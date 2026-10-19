param(
  [string]$MetadataFile = "",
  [string]$OutputPath = "",
  [switch]$ForceWrite
)

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "json_helpers.ps1")

$repoRoot = Split-Path -Parent $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($MetadataFile)) {
  $MetadataFile = Join-Path $repoRoot "vendor\libphonenumber\resources\PhoneNumberMetadata.xml"
}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
  $OutputPath = Join-Path $repoRoot "tools\snapshots\upstream_length_rules.json"
}

if (-not (Test-Path $MetadataFile)) {
  throw "Metadata file not found: $MetadataFile"
}

[xml]$xml = Get-Content -Path $MetadataFile -Raw -Encoding UTF8
$territories = $xml.phoneNumberMetadata.territories.territory
if ($null -eq $territories -or $territories.Count -eq 0) {
  throw "No territories found in: $MetadataFile"
}

# Port of BuildMetadataFromXml.parsePossibleLengthStringToSet.
#
# STRICT on purpose. Returning an empty list for anything unrecognised, or
# accepting an unbracketed `7-9` (which upstream does not), would be a silent
# pass risk: a malformed or non-upstream possibleLengths attribute would simply
# vanish from the snapshot, and the compare gate would be green against an
# incomplete model of the XML. Every deviation throws, exactly like the
# Java builder does.
#
# The accepted grammar, upstream verbatim:
#   spec  := token ("," token)*      no empty token anywhere
#   token := \d+ | "[" \d+ "-" \d+ "]"
#   a range must be ascending AND span at least three values (upstream refuses
#   [6-7] because the shorter "6,7" is preferred)
#   no duplicate length within one spec
function Expand-LengthToken {
  param([string]$Token, [string]$Spec, [string]$Context)

  if ($Token.Length -eq 0) {
    throw "Leading, trailing or adjacent commas in possible length string '$Spec' ($Context); these should only separate numbers or ranges."
  }

  if ($Token[0] -eq '[') {
    if ($Token[$Token.Length - 1] -ne ']') {
      throw "Missing end of range character in possible length string '$Spec' ($Context)."
    }
    $inner = $Token.Substring(1, $Token.Length - 2)
    $minMax = $inner -split '-'
    if ($minMax.Count -ne 2) {
      throw "Ranges must have exactly one '-' character: missing for '$Spec' ($Context)."
    }
    if ($minMax[0] -notmatch '^\d+$' -or $minMax[1] -notmatch '^\d+$') {
      throw "Non numeric range bound in possible length string '$Spec' ($Context)."
    }
    $start = [int]$minMax[0]
    $end = [int]$minMax[1]
    if (($end - $start) -lt 2) {
      throw "The first number in a range should be two or more digits lower than the second. Culprit possible length string: '$Spec' ($Context)."
    }
    return @($start..$end)
  }

  if ($Token -notmatch '^\d+$') {
    throw "Malformed possible length token '$Token' in '$Spec' ($Context); expected a number or a bracketed range."
  }
  return @([int]$Token)
}

function Expand-LengthSpec {
  param([string]$Spec, [string]$Context)

  if ($null -eq $Spec -or $Spec.Length -eq 0) {
    throw "Empty possibleLength string found ($Context)."
  }

  $seen = [System.Collections.Generic.HashSet[int]]::new()
  foreach ($token in ($Spec -split ',')) {
    foreach ($value in (Expand-LengthToken -Token $token -Spec $Spec -Context $Context)) {
      if (-not $seen.Add([int]$value)) {
        throw "Duplicate length element found ($value) in possible length string '$Spec' ($Context)."
      }
    }
  }

  return @($seen | Sort-Object)
}

$regionEntries = @()

foreach ($territory in $territories) {
  $regionId = [string]$territory.id
  $countryCode = [int]$territory.countryCode
  $isMainForCode = ([string]$territory.mainCountryForCode -eq 'true')

  $lengths = @()
  foreach ($node in $territory.ChildNodes) {
    if ($node.Name -eq 'noInternationalDialling') {
      continue
    }

    foreach ($child in $node.ChildNodes) {
      if ($child.Name -eq 'possibleLengths') {
        # Upstream populatePossibleLengthSets reads the attribute
        # unconditionally and lets parsePossibleLengthStringToSet throw on an
        # empty value; so does this.
        $national = [string]$child.national
        $lengths += Expand-LengthSpec -Spec $national -Context "$regionId/$($node.Name)/possibleLengths"
      }
    }
  }

  $unique = @($lengths | Sort-Object -Unique)
  if ($unique.Count -eq 0) {
    continue
  }

  $regionEntries += [PSCustomObject]@{
    region = $regionId
    countryCode = $countryCode
    mainCountryForCode = $isMainForCode
    minLength = [int](($unique | Measure-Object -Minimum).Minimum)
    maxLength = [int](($unique | Measure-Object -Maximum).Maximum)
    lengths = $unique
  }
}

$regionEntries = @($regionEntries | Sort-Object countryCode, region)

$byCountryCode = @()
$groups = $regionEntries | Group-Object countryCode
foreach ($g in $groups) {
  $allLengths = @()
  foreach ($entry in $g.Group) {
    $allLengths += $entry.lengths
  }
  $allUnique = @($allLengths | Sort-Object -Unique)

  $mainRegion = ($g.Group | Where-Object { $_.mainCountryForCode } | Select-Object -First 1)
  if ($null -eq $mainRegion) {
    $mainRegion = $g.Group[0]
  }

  $byCountryCode += [PSCustomObject]@{
    countryCode = [int]$g.Name
    primaryRegion = $mainRegion.region
    minLength = [int](($allUnique | Measure-Object -Minimum).Minimum)
    maxLength = [int](($allUnique | Measure-Object -Maximum).Maximum)
    lengths = $allUnique
  }
}

$byCountryCode = @($byCountryCode | Sort-Object countryCode)

# The pinned vendor commit, read from the checkout instead of hardcoded, so a
# snapshot can never carry a stale label.
$metadataCommit = ''
$vendorRepo = Join-Path $repoRoot 'vendor\libphonenumber'
if (Test-Path -LiteralPath $vendorRepo) {
  $head = & git -C $vendorRepo rev-parse HEAD 2>$null
  if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace($head)) {
    $metadataCommit = $head.Trim()
  }
}

$snapshot = [PSCustomObject]@{
  generatedAt = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssK')
  source = [PSCustomObject]@{
    metadataFile = $MetadataFile
    metadataCommit = $metadataCommit
  }
  regionCount = $regionEntries.Count
  countryCodeCount = $byCountryCode.Count
  byRegion = $regionEntries
  byCountryCode = $byCountryCode
}

$outDir = Split-Path -Parent $OutputPath
if (-not [string]::IsNullOrWhiteSpace($outDir) -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$written = Write-JsonFile -InputObject $snapshot -Path $OutputPath -Depth 8 -IgnorePathsForChangeDetection @('generatedAt') -ForceWrite:$ForceWrite

Write-Host "Upstream length snapshot exported:"
Write-Host "  $OutputPath"
Write-Host "Regions:      $($regionEntries.Count)"
Write-Host "CountryCodes: $($byCountryCode.Count)"
if (-not $written) {
  Write-Host "No content changes detected (timestamp-only change ignored)."
}
