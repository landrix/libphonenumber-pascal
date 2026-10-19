param(
  [string]$GeneratedSnapshot = "",
  [string]$UpstreamSnapshot = "",
  [string]$OutputPath = "",
  [switch]$ForceWrite
)

<#
  Compares the GENERATED phone metadata - the actual runtime data - against
  the upstream XML.

  1. It compares per TERRITORY, not only per calling code.
  2. It compares the whole possible-length SET, not only its minimum and
     maximum.
  3. It compares presence in both directions, so a territory that appears on
     only one side is a finding rather than an invisible difference.

  Why the two sides are comparable: the generated general description of a
  territory carries the possible lengths that upstream
  BuildMetadataFromXml.setPossibleLengthsGeneralDesc derives as the union of
  all typed child elements except noInternationalDialling, and
  tools/extract_upstream_length_rules.ps1 computes that very union straight
  from PhoneNumberMetadata.xml. A mismatch therefore means the generator, the
  emitted tables or the pinned XML drifted apart.

  The generator run itself is the other half of the gate: it rewrites a unit
  only when the content changes, so a clean vendor state has to leave every
  generated unit reported as "current".
#>

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "json_helpers.ps1")

$repoRoot = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($GeneratedSnapshot)) {
  $GeneratedSnapshot = Join-Path $repoRoot "tools\snapshots\generated_metadata_snapshot.json"
}
if ([string]::IsNullOrWhiteSpace($UpstreamSnapshot)) {
  $UpstreamSnapshot = Join-Path $repoRoot "tools\snapshots\upstream_length_rules.json"
}
if ([string]::IsNullOrWhiteSpace($OutputPath)) {
  $OutputPath = Join-Path $repoRoot "tools\snapshots\generated_vs_upstream_diff.json"
}

if (-not (Test-Path $GeneratedSnapshot)) {
  throw "Generated metadata snapshot not found: $GeneratedSnapshot"
}
if (-not (Test-Path $UpstreamSnapshot)) {
  throw "Upstream snapshot not found: $UpstreamSnapshot"
}

$generated = Get-Content -Path $GeneratedSnapshot -Raw -Encoding UTF8 | ConvertFrom-Json
$upstream = Get-Content -Path $UpstreamSnapshot -Raw -Encoding UTF8 | ConvertFrom-Json

if ($null -eq $generated -or $null -eq $generated.byTerritory) {
  throw "Invalid generated metadata snapshot format: $GeneratedSnapshot"
}
if ($null -eq $upstream -or $null -eq $upstream.byRegion) {
  throw "Invalid upstream snapshot format: $UpstreamSnapshot"
}

# A territory is identified by region id AND calling code: the nine non
# geographical entities all carry the id "001" and differ only in their code.
function Get-TerritoryKey {
  param([string]$Region, [int]$CountryCode)
  return ("{0}|{1}" -f $Region, $CountryCode)
}

function Format-Lengths {
  param($Values)
  if ($null -eq $Values) { return "" }
  return (@($Values | ForEach-Object { [int]$_ }) -join ",")
}

$generatedMap = @{}
foreach ($entry in $generated.byTerritory) {
  $generatedMap[(Get-TerritoryKey -Region ([string]$entry.region) -CountryCode ([int]$entry.countryCode))] = $entry
}

$upstreamMap = @{}
foreach ($entry in $upstream.byRegion) {
  $upstreamMap[(Get-TerritoryKey -Region ([string]$entry.region) -CountryCode ([int]$entry.countryCode))] = $entry
}

$diffs = @()
$missingInUpstream = @()
$missingInGenerated = @()

foreach ($key in $generatedMap.Keys) {
  $gen = $generatedMap[$key]
  if (-not $upstreamMap.ContainsKey($key)) {
    $missingInUpstream += [PSCustomObject]@{
      region = [string]$gen.region
      countryCode = [int]$gen.countryCode
      generatedLengths = (Format-Lengths $gen.lengths)
    }
    continue
  }

  $up = $upstreamMap[$key]
  $genLengths = Format-Lengths $gen.lengths
  $upLengths = Format-Lengths $up.lengths

  if ($genLengths -ne $upLengths) {
    $diffs += [PSCustomObject]@{
      region = [string]$gen.region
      countryCode = [int]$gen.countryCode
      status = "length-mismatch"
      generated = $genLengths
      upstream = $upLengths
    }
  }
}

foreach ($key in $upstreamMap.Keys) {
  if (-not $generatedMap.ContainsKey($key)) {
    $up = $upstreamMap[$key]
    $missingInGenerated += [PSCustomObject]@{
      region = [string]$up.region
      countryCode = [int]$up.countryCode
      upstreamLengths = (Format-Lengths $up.lengths)
    }
  }
}

# Calling code level cross check, so a regrouping that keeps every territory
# set intact but moves a territory between calling codes still shows up.
$callingCodeDiffs = @()
$generatedCodeMap = @{}
foreach ($entry in $generated.byCountryCode) {
  $generatedCodeMap[[int]$entry.countryCode] = $entry
}
foreach ($entry in $upstream.byCountryCode) {
  $cc = [int]$entry.countryCode
  if (-not $generatedCodeMap.ContainsKey($cc)) {
    $callingCodeDiffs += [PSCustomObject]@{
      countryCode = $cc
      status = "missing-in-generated"
      generated = ""
      upstream = (Format-Lengths $entry.lengths)
    }
    continue
  }
  $gen = $generatedCodeMap[$cc]
  $genLengths = Format-Lengths $gen.lengths
  $upLengths = Format-Lengths $entry.lengths
  if ($genLengths -ne $upLengths) {
    $callingCodeDiffs += [PSCustomObject]@{
      countryCode = $cc
      status = "length-mismatch"
      generated = $genLengths
      upstream = $upLengths
    }
  }
}
foreach ($cc in $generatedCodeMap.Keys) {
  $found = $false
  foreach ($entry in $upstream.byCountryCode) {
    if ([int]$entry.countryCode -eq [int]$cc) { $found = $true; break }
  }
  if (-not $found) {
    $callingCodeDiffs += [PSCustomObject]@{
      countryCode = [int]$cc
      status = "missing-in-upstream"
      generated = (Format-Lengths $generatedCodeMap[$cc].lengths)
      upstream = ""
    }
  }
}

$summary = [PSCustomObject]@{
  generatedAt = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssK')
  generatorVersion = [string]$generated.source.generatorVersion
  metadataSourceFile = [string]$generated.source.metadataSourceFile
  metadataSourceCommit = [string]$generated.source.metadataSourceCommit
  generatedTerritoryCount = @($generated.byTerritory).Count
  upstreamTerritoryCount = @($upstream.byRegion).Count
  generatedCountryCodeCount = @($generated.byCountryCode).Count
  upstreamCountryCodeCount = @($upstream.byCountryCode).Count
  lengthMismatches = @($diffs).Count
  missingInGenerated = @($missingInGenerated).Count
  missingInUpstream = @($missingInUpstream).Count
  callingCodeMismatches = @($callingCodeDiffs).Count
}

$result = [PSCustomObject]@{
  summary = $summary
  diffs = @($diffs | Sort-Object countryCode, region)
  missingInGenerated = @($missingInGenerated | Sort-Object countryCode, region)
  missingInUpstream = @($missingInUpstream | Sort-Object countryCode, region)
  callingCodeDiffs = @($callingCodeDiffs | Sort-Object countryCode)
}

$outDir = Split-Path -Parent $OutputPath
if (-not [string]::IsNullOrWhiteSpace($outDir) -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$written = Write-JsonFile -InputObject $result -Path $OutputPath -Depth 8 -IgnorePathsForChangeDetection @('summary.generatedAt') -ForceWrite:$ForceWrite

Write-Host "Generated-metadata-vs-upstream diff exported:"
Write-Host "  $OutputPath"
Write-Host "Territories          : $($summary.generatedTerritoryCount) generated / $($summary.upstreamTerritoryCount) upstream"
Write-Host "Length mismatches    : $($summary.lengthMismatches)"
Write-Host "Missing in generated : $($summary.missingInGenerated)"
Write-Host "Missing in upstream  : $($summary.missingInUpstream)"
Write-Host "Calling code diffs   : $($summary.callingCodeMismatches)"
if (-not $written) {
  Write-Host "No content changes detected (timestamp-only change ignored)."
}
