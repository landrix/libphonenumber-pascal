param(
  [switch]$SkipPull,
  [string]$VendorDir = "vendor",
  [string]$VersionsFile = "vendor/versions.md",
  [string]$OraclePackageId = "",
  [string]$OraclePackageVersion = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$vendorRoot = Join-Path $repoRoot $VendorDir
$javaRepo = Join-Path $vendorRoot "libphonenumber"
$csharpRepo = Join-Path $vendorRoot "libphonenumber-csharp"
$versionsPath = Join-Path $repoRoot $VersionsFile

function Assert-GitRepo {
  param([Parameter(Mandatory = $true)][string]$Path)

  if (-not (Test-Path $Path)) {
    throw "Missing directory: $Path"
  }

  $isGitRepo = git -C $Path rev-parse --is-inside-work-tree 2>$null
  if ($LASTEXITCODE -ne 0 -or $isGitRepo.Trim() -ne "true") {
    throw "Not a git repository: $Path"
  }
}

function Update-Repo {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $true)][switch]$SkipPull
  )

  Write-Host ""
  Write-Host "==> $Name"

  Assert-GitRepo -Path $Path

  if (-not $SkipPull) {
    $pullOutput = git -C $Path pull --ff-only 2>&1
    if ($pullOutput) {
      $pullOutput | ForEach-Object { Write-Host $_ }
    }
    if ($LASTEXITCODE -ne 0) {
      throw "git pull failed for $Name ($Path)"
    }
  } else {
    Write-Host "Skipping git pull (-SkipPull)."
  }

  $commit = git -C $Path rev-parse HEAD 2>$null
  if ($LASTEXITCODE -ne 0) {
    throw "Could not resolve HEAD for $Name ($Path)"
  }

  $commit = ($commit | Select-Object -First 1).Trim()
  if ($commit -notmatch '^[0-9a-f]{40}$') {
    throw "Invalid commit hash resolved for ${Name}: $commit"
  }
  Write-Host "Commit: $commit"
  return $commit
}

function Get-ReferenceOracleDefault {
  <#
    The oracle pin recorded in vendor/versions.md must be the one the generators
    actually load. That pin lives in exactly one
    place - Get-OraclePin in tools/oracle_helpers.ps1 - and this function reads
    it from there instead of parsing another script's parameter defaults.
  #>
  param([Parameter(Mandatory = $true)][string]$ParameterName)

  $helperScript = Join-Path $PSScriptRoot "oracle_helpers.ps1"
  if (-not (Test-Path -LiteralPath $helperScript)) {
    throw "Cannot determine the reference oracle pin: missing $helperScript. Pass -OraclePackageId/-OraclePackageVersion explicitly."
  }

  try {
    . $helperScript
    $pin = Get-OraclePin
  }
  catch {
    throw "Cannot read the oracle pin from ${helperScript}: $($_.Exception.Message). Pass -OraclePackageId/-OraclePackageVersion explicitly."
  }

  $value = [string]$pin.$ParameterName
  if ([string]::IsNullOrWhiteSpace($value)) {
    throw "The oracle pin in $helperScript has no value for '$ParameterName'. Pass -OraclePackageId/-OraclePackageVersion explicitly."
  }

  return $value
}

Write-Host "Refreshing vendor commit references..."
Write-Host "Repo: $repoRoot"

if ([string]::IsNullOrWhiteSpace($OraclePackageId)) {
  $OraclePackageId = Get-ReferenceOracleDefault -ParameterName "PackageId"
}
if ([string]::IsNullOrWhiteSpace($OraclePackageVersion)) {
  $OraclePackageVersion = Get-ReferenceOracleDefault -ParameterName "PackageVersion"
}

if ([string]::IsNullOrWhiteSpace($OraclePackageId) -or [string]::IsNullOrWhiteSpace($OraclePackageVersion)) {
  throw "Reference oracle pin could not be resolved; refusing to write $versionsPath without it."
}

$javaCommit = Update-Repo -Path $javaRepo -Name "libphonenumber" -SkipPull:$SkipPull
$csharpCommit = Update-Repo -Path $csharpRepo -Name "libphonenumber-csharp" -SkipPull:$SkipPull

$versionsLines = @(
  "libphonenumber-csharp",
  "",
  "    https://github.com/twcclegg/libphonenumber-csharp/commit/$csharpCommit",
  "",
  "libphonenumber",
  "",
  "    https://github.com/google/libphonenumber/commit/$javaCommit",
  ""
)

Write-Host ""
Write-Host "==> reference oracle package"
Write-Host "Package: $OraclePackageId $OraclePackageVersion"

$versionsLines += @(
  "reference oracle (NuGet package used by tools/generate_reference_cases.ps1)",
  "",
  "    https://www.nuget.org/packages/$OraclePackageId/$OraclePackageVersion",
  ""
)

$versionsContent = $versionsLines -join [Environment]::NewLine

# UTF-8 WITHOUT a BOM, explicitly: Set-Content -Encoding UTF8 writes a BOM under
# Windows PowerShell 5.1 and none under PowerShell 7, so the same script
# produced a one byte diff depending on the host it was started from.
# The trailing newline is the one Set-Content used to append; keeping it makes
# this change byte neutral for the committed file.
[System.IO.File]::WriteAllText($versionsPath,
  $versionsContent + [Environment]::NewLine,
  (New-Object System.Text.UTF8Encoding($false)))

Write-Host ""
Write-Host "Updated: $versionsPath"
Write-Host "Done."
