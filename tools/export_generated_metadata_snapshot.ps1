param(
  [string]$DataUnit = "",
  [string]$DescsUnit = "",
  [string]$OutputPath = "",
  [switch]$ForceWrite
)

<#
  Exports the possible-length model of the GENERATED phone metadata units as a
  snapshot JSON.

  The generated units ARE the runtime path, so this is what the compare gate
  reads.

  What is read
  ------------
  src/LibPhoneNumber.Metadata.Data.pas
    - the provenance constants,
    - the PhoneMetadataPossibleLengths pool,
    - every territory record: Id, CountryCode and DescOffset.
  src/LibPhoneNumber.Metadata.Descs.pas
    - the LengthOffset / LengthCount pair of every description, in table order.

  A territory's GENERAL description sits at its DescOffset (pdkGeneralDesc is
  the first desc kind by definition), and upstream
  BuildMetadataFromXml.setPossibleLengthsGeneralDesc derives its possible
  lengths as the union of the possibleLengths of all typed child elements
  except noInternationalDialling. That is exactly the set
  tools/extract_upstream_length_rules.ps1 computes straight from the XML, so
  the two snapshots are directly comparable - see
  tools/compare_generated_metadata_with_upstream.ps1.

  Parsing generated Pascal with regular expressions is safe here because the
  emitter is one function in tools/generate_metadata.ps1: the layout is fixed,
  ASCII only and deterministic, and any change to it changes this script's
  input in an obvious, immediately failing way (the script throws when a table
  cannot be found rather than silently exporting a short snapshot).
#>

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "json_helpers.ps1")

$repoRoot = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($DataUnit)) {
  $DataUnit = Join-Path $repoRoot "src\LibPhoneNumber.Metadata.Data.pas"
}
if ([string]::IsNullOrWhiteSpace($DescsUnit)) {
  $DescsUnit = Join-Path $repoRoot "src\LibPhoneNumber.Metadata.Descs.pas"
}
if ([string]::IsNullOrWhiteSpace($OutputPath)) {
  $OutputPath = Join-Path $repoRoot "tools\snapshots\generated_metadata_snapshot.json"
}

foreach ($file in @($DataUnit, $DescsUnit)) {
  if (-not (Test-Path -LiteralPath $file)) {
    throw "Generated metadata unit not found: $file. Run tools/generate_metadata.ps1 first."
  }
}

$dataText = [System.IO.File]::ReadAllText($DataUnit)
$descsText = [System.IO.File]::ReadAllText($DescsUnit)

function Get-PascalConstant {
  param([string]$Text, [string]$Name, [string]$File)

  $m = [regex]::Match($Text, ("\b{0}\s*=\s*'([^']*)'" -f [regex]::Escape($Name)))
  if (-not $m.Success) {
    throw "Could not read the constant $Name from $File."
  }
  return $m.Groups[1].Value
}

$generatorVersion = Get-PascalConstant -Text $dataText -Name "MetadataGeneratorVersion" -File $DataUnit
$sourceFile = Get-PascalConstant -Text $dataText -Name "MetadataSourceFile" -File $DataUnit
$sourceCommit = Get-PascalConstant -Text $dataText -Name "MetadataSourceCommit" -File $DataUnit

# --- possible length pool ----------------------------------------------------

$poolMatch = [regex]::Match(
  $dataText,
  "PhoneMetadataPossibleLengths:\s*array\[0\.\.(\d+)\]\s*of\s*SmallInt\s*=\s*\((?<body>[^)]*)\)\s*;",
  [System.Text.RegularExpressions.RegexOptions]::Singleline)
if (-not $poolMatch.Success) {
  throw "Could not read PhoneMetadataPossibleLengths from $DataUnit."
}

$lengthPool = New-Object 'System.Collections.Generic.List[int]'
foreach ($token in ($poolMatch.Groups["body"].Value -split "[,\s]+")) {
  if ($token -match '^-?\d+$') {
    $lengthPool.Add([int]$token)
  }
}
$expectedPoolCount = [int]$poolMatch.Groups[1].Value + 1
if ($lengthPool.Count -ne $expectedPoolCount) {
  throw "PhoneMetadataPossibleLengths declares $expectedPoolCount entries but $($lengthPool.Count) were parsed."
}

# --- descriptions ------------------------------------------------------------

$descMatches = [regex]::Matches($descsText, "LengthOffset:\s*(\d+);\s*LengthCount:\s*(\d+);")
if ($descMatches.Count -eq 0) {
  throw "Could not read any description length slices from $DescsUnit."
}

$declaredDescCount = [regex]::Match($descsText, "PhoneMetadataDescCount\s*=\s*(\d+);")
if (-not $declaredDescCount.Success) {
  throw "Could not read PhoneMetadataDescCount from $DescsUnit."
}
if ($descMatches.Count -ne [int]$declaredDescCount.Groups[1].Value) {
  throw "PhoneMetadataDescCount is $($declaredDescCount.Groups[1].Value) but $($descMatches.Count) description records were parsed from $DescsUnit."
}

$descLengthOffset = New-Object 'int[]' $descMatches.Count
$descLengthCount = New-Object 'int[]' $descMatches.Count
for ($i = 0; $i -lt $descMatches.Count; $i++) {
  $descLengthOffset[$i] = [int]$descMatches[$i].Groups[1].Value
  $descLengthCount[$i] = [int]$descMatches[$i].Groups[2].Value
}

# --- territories -------------------------------------------------------------

$territoryMatches = [regex]::Matches(
  $dataText,
  "\(Id:\s*'([^']*)';\s*CountryCode:\s*(\d+);.*?DescOffset:\s*(\d+);",
  [System.Text.RegularExpressions.RegexOptions]::Singleline)
if ($territoryMatches.Count -eq 0) {
  throw "Could not read any territory records from $DataUnit."
}

$declaredTerritoryCount = [regex]::Match($dataText, "PhoneMetadataTerritoryCount\s*=\s*(\d+);")
if (-not $declaredTerritoryCount.Success) {
  throw "Could not read PhoneMetadataTerritoryCount from $DataUnit."
}
if ($territoryMatches.Count -ne [int]$declaredTerritoryCount.Groups[1].Value) {
  throw "PhoneMetadataTerritoryCount is $($declaredTerritoryCount.Groups[1].Value) but $($territoryMatches.Count) territory records were parsed from $DataUnit."
}

$byTerritory = @()
foreach ($m in $territoryMatches) {
  $id = $m.Groups[1].Value
  $countryCode = [int]$m.Groups[2].Value
  $descOffset = [int]$m.Groups[3].Value

  if ($descOffset -lt 0 -or $descOffset -ge $descLengthOffset.Length) {
    throw "Territory $id (cc=$countryCode) has DescOffset $descOffset outside the description table."
  }

  # pdkGeneralDesc is the first desc kind, so the general description of a
  # territory sits at its DescOffset.
  $offset = $descLengthOffset[$descOffset]
  $count = $descLengthCount[$descOffset]
  if ($count -lt 0 -or ($offset + $count) -gt $lengthPool.Count) {
    throw "Territory $id (cc=$countryCode) has a general description length slice ($offset,$count) outside the length pool."
  }

  $lengths = @()
  for ($k = 0; $k -lt $count; $k++) {
    $lengths += $lengthPool[$offset + $k]
  }
  $lengths = @($lengths | Sort-Object -Unique)

  $byTerritory += [PSCustomObject]@{
    region = $id
    countryCode = $countryCode
    lengths = $lengths
    minLength = if ($lengths.Count -gt 0) { [int](($lengths | Measure-Object -Minimum).Minimum) } else { 0 }
    maxLength = if ($lengths.Count -gt 0) { [int](($lengths | Measure-Object -Maximum).Maximum) } else { 0 }
  }
}

$byTerritory = @($byTerritory | Sort-Object countryCode, region)

# Aggregate per calling code, the same shape the upstream snapshot uses.
$byCountryCode = @()
foreach ($group in ($byTerritory | Group-Object countryCode)) {
  $all = @()
  foreach ($entry in $group.Group) {
    $all += $entry.lengths
  }
  $all = @($all | Sort-Object -Unique)
  $byCountryCode += [PSCustomObject]@{
    countryCode = [int]$group.Name
    territoryCount = $group.Group.Count
    minLength = [int](($all | Measure-Object -Minimum).Minimum)
    maxLength = [int](($all | Measure-Object -Maximum).Maximum)
    lengths = $all
  }
}
$byCountryCode = @($byCountryCode | Sort-Object countryCode)

$snapshot = [PSCustomObject]@{
  generatedAt = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssK')
  source = [PSCustomObject]@{
    dataUnit = (Split-Path -Leaf $DataUnit)
    descsUnit = (Split-Path -Leaf $DescsUnit)
    generatorVersion = $generatorVersion
    metadataSourceFile = $sourceFile
    metadataSourceCommit = $sourceCommit
  }
  territoryCount = $byTerritory.Count
  descCount = $descMatches.Count
  possibleLengthPoolCount = $lengthPool.Count
  countryCodeCount = $byCountryCode.Count
  byTerritory = $byTerritory
  byCountryCode = $byCountryCode
}

$outDir = Split-Path -Parent $OutputPath
if (-not [string]::IsNullOrWhiteSpace($outDir) -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$written = Write-JsonFile -InputObject $snapshot -Path $OutputPath -Depth 8 -IgnorePathsForChangeDetection @('generatedAt') -ForceWrite:$ForceWrite

Write-Host "Generated metadata snapshot exported:"
Write-Host "  $OutputPath"
Write-Host "Generator     : $generatorVersion"
Write-Host "Source commit : $sourceCommit"
Write-Host "Territories   : $($byTerritory.Count)"
Write-Host "CountryCodes  : $($byCountryCode.Count)"
if (-not $written) {
  Write-Host "No content changes detected (timestamp-only change ignored)."
}
