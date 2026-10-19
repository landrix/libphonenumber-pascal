param(
  [string]$SourceDir = ""
)

<#
  Prints the provenance of the generated metadata data sets: the generator
  label, source file and vendor commit the generator embeds in the generated
  units.
#>

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($SourceDir)) {
  $SourceDir = Join-Path $repoRoot "src"
}

$dataSets = @(
  @{ Label = "Phone metadata";     Unit = "LibPhoneNumber.Metadata.Data.pas";          Prefix = "Metadata" },
  @{ Label = "Testing metadata";   Unit = "LibPhoneNumber.TestingMetadata.Data.pas";   Prefix = "Metadata" },
  @{ Label = "Short number data";  Unit = "LibPhoneNumber.ShortMetadata.Data.pas";     Prefix = "ShortMetadata" },
  @{ Label = "Alternate formats";  Unit = "LibPhoneNumber.AlternateFormats.Data.pas";  Prefix = "AlternateFormats" }
)

function Get-PascalConstant {
  param([string]$Text, [string]$Name, [string]$File)

  $m = [regex]::Match($Text, ("\b{0}\s*=\s*'([^']*)'" -f [regex]::Escape($Name)))
  if (-not $m.Success) {
    throw "Could not read the constant $Name from $File."
  }
  return $m.Groups[1].Value
}

Write-Host "Generated metadata provenance"
Write-Host "-----------------------------"

foreach ($dataSet in $dataSets) {
  $path = Join-Path $SourceDir $dataSet.Unit
  if (-not (Test-Path -LiteralPath $path)) {
    throw "Generated unit not found: $path. Run tools/generate_metadata.ps1 first."
  }
  $text = [System.IO.File]::ReadAllText($path)
  $prefix = $dataSet.Prefix

  $version = Get-PascalConstant -Text $text -Name ($prefix + "GeneratorVersion") -File $path
  $source = Get-PascalConstant -Text $text -Name ($prefix + "SourceFile") -File $path
  $commit = Get-PascalConstant -Text $text -Name ($prefix + "SourceCommit") -File $path

  Write-Host ""
  Write-Host ("{0}" -f $dataSet.Label)
  Write-Host ("  unit      : {0}" -f $dataSet.Unit)
  Write-Host ("  generator : {0}" -f $version)
  Write-Host ("  source    : vendor/libphonenumber/{0}" -f $source)
  Write-Host ("  commit    : {0}" -f $commit)
}
