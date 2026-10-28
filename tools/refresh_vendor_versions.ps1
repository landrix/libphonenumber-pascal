param(
  # Upstream release to check out, "X.Y.Z" or "vX.Y.Z". Empty (the default):
  # the highest vX.Y.Z tag of google/libphonenumber after the fetch.
  [string]$Version = "",
  # No fetch, no checkout: only rewrite vendor/versions.md from the commits the
  # clones are at now plus Get-OraclePin.
  [switch]$SkipPull,
  [string]$VendorDir = "vendor",
  [string]$VersionsFile = "vendor/versions.md",
  [string]$OraclePackageId = "",
  [string]$OraclePackageVersion = ""
)

<#
  Points both upstream clones at an upstream RELEASE and records it in
  vendor/versions.md.

  1. Fetches the tags of vendor/libphonenumber and vendor/libphonenumber-csharp.
  2. The release is -Version, else the highest vX.Y.Z tag of the Java clone
     (compared as versions, never as strings).
  3. Both clones must have the tag vX.Y.Z; a missing C# tag means the C#
     release (and with it the NuGet package the oracle pin needs) is not
     published yet. Both tags are resolved before either clone is touched.
  4. Checks out the tag in both clones as a detached HEAD. The Java release
     commit is NOT on master (upstream squashes the maven release commits), so
     a branch fast-forward would pin the wrong commit.
  5. Writes vendor/versions.md: both commits plus the oracle pin from
     Get-OraclePin in tools/oracle_helpers.ps1.

  Runs under Windows PowerShell 5.1 and PowerShell 7: native commands go
  through Invoke-Native, so git's progress on stderr is not an error; the exit
  code decides.
#>

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$vendorRoot = Join-Path $repoRoot $VendorDir
$javaRepo = Join-Path $vendorRoot "libphonenumber"
$csharpRepo = Join-Path $vendorRoot "libphonenumber-csharp"
$versionsPath = Join-Path $repoRoot $VersionsFile

function Invoke-Native {
  # Same approach as Invoke-Native in fpc_toolchains.ps1 (kept local: that file
  # carries the FreePascal toolchain helpers and nothing else this script
  # needs). Combined output as lines plus the exit code; stderr is not an
  # error, the caller decides what the exit code means.
  param([string]$FilePath, [string[]]$Arguments)
  $previous = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  try {
    $output = & $FilePath @Arguments 2>&1 | ForEach-Object { "$_" }
    return [pscustomobject]@{ Output = @($output); ExitCode = $LASTEXITCODE }
  } finally {
    $ErrorActionPreference = $previous
  }
}

function Invoke-Git {
  # git -C <Path> <Arguments>; a non zero exit code is an error.
  param([string]$Path, [string[]]$Arguments, [string]$What)
  $result = Invoke-Native "git" (@("-C", $Path) + $Arguments)
  if ($result.ExitCode -ne 0) {
    throw ("{0} failed (git {1}, exit code {2}): {3}" -f $What, ($Arguments -join " "), $result.ExitCode,
      ($result.Output -join " "))
  }
  return $result.Output
}

function ConvertTo-ReleaseVersion {
  # "9.0.42" or "v9.0.42" -> [version]; anything else -> $null.
  param([string]$Text)
  $match = [regex]::Match($Text.Trim(), '^v?(\d+)\.(\d+)\.(\d+)$')
  if (-not $match.Success) {
    return $null
  }
  return New-Object -TypeName System.Version -ArgumentList ([int]$match.Groups[1].Value), ([int]$match.Groups[2].Value),
    ([int]$match.Groups[3].Value)
}

function Assert-GitRepo {
  param([Parameter(Mandatory = $true)][string]$Path)

  if (-not (Test-Path $Path)) {
    throw "Missing directory: $Path"
  }

  $result = Invoke-Native "git" @("-C", $Path, "rev-parse", "--is-inside-work-tree")
  if ($result.ExitCode -ne 0 -or $result.Output.Count -eq 0 -or $result.Output[0].Trim() -ne "true") {
    throw "Not a git repository: $Path"
  }
}

function Sync-Tags {
  param([string]$Path, [string]$Name)
  Write-Host ""
  Write-Host "==> $Name (fetching tags)"
  Assert-GitRepo -Path $Path
  $output = Invoke-Git -Path $Path -Arguments @("fetch", "--tags", "origin") -What "Fetching the tags of $Name"
  $output | ForEach-Object { Write-Host $_ }
}

function Get-HighestReleaseTag {
  param([string]$Path, [string]$Name)
  $latest = $null
  foreach ($tag in (Invoke-Git -Path $Path -Arguments @("tag", "--list", "v*") -What "Listing the tags of $Name")) {
    $tag = $tag.Trim()
    $parsed = ConvertTo-ReleaseVersion $tag
    if ($null -ne $parsed -and $tag.StartsWith("v") -and ($null -eq $latest -or $parsed -gt $latest)) {
      $latest = $parsed
    }
  }
  if ($null -eq $latest) {
    throw "No vX.Y.Z tag found in $Name ($Path)."
  }
  return $latest
}

function Resolve-TagCommit {
  # The commit of tag $Tag, or "" when the clone has no such tag.
  param([string]$Path, [string]$Tag)
  $result = Invoke-Native "git" @("-C", $Path, "rev-parse", "--verify", "--quiet", "refs/tags/$Tag^{commit}")
  if ($result.ExitCode -ne 0 -or $result.Output.Count -eq 0) {
    return ""
  }
  return $result.Output[0].Trim()
}

function Assert-CleanTree {
  param([string]$Path, [string]$Name)
  $status = Invoke-Git -Path $Path -Arguments @("status", "--porcelain", "--untracked-files=no") -What "Reading the status of $Name"
  if (@($status | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }).Count -gt 0) {
    throw "$Name ($Path) has local modifications; refusing to check out another release over them."
  }
}

function Get-HeadCommit {
  param([string]$Path, [string]$Name)
  $commit = (Invoke-Git -Path $Path -Arguments @("rev-parse", "HEAD") -What "Resolving HEAD of $Name" |
    Select-Object -First 1).Trim()
  if ($commit -notmatch '^[0-9a-f]{40}$') {
    throw "Invalid commit hash resolved for ${Name}: $commit"
  }
  return $commit
}

function Get-CloneState {
  # HEAD of a clone: the commit, and the branch when HEAD is on one ("" when
  # detached), so Restore-CloneState can put it back exactly.
  param([string]$Path, [string]$Name)
  $branch = Invoke-Native "git" @("-C", $Path, "symbolic-ref", "--quiet", "--short", "HEAD")
  return [pscustomobject]@{
    Path   = $Path
    Name   = $Name
    Commit = (Get-HeadCommit -Path $Path -Name $Name)
    Branch = $(if ($branch.ExitCode -eq 0 -and $branch.Output.Count -gt 0) { $branch.Output[0].Trim() } else { "" })
  }
}

function Restore-CloneState {
  # Puts a clone back to a state of Get-CloneState; answers a line for the
  # error message, never throws (it runs while another error is reported).
  param($State)
  if ([string]::IsNullOrWhiteSpace($State.Branch)) {
    $arguments = @("-C", $State.Path, "checkout", "--quiet", "--detach", $State.Commit)
    $target = $State.Commit
  } else {
    $arguments = @("-C", $State.Path, "checkout", "--quiet", $State.Branch)
    $target = "branch $($State.Branch)"
  }
  $result = Invoke-Native "git" $arguments
  if ($result.ExitCode -ne 0) {
    return ("{0} could NOT be restored to {1}: {2}" -f $State.Name, $target, ($result.Output -join " "))
  }
  return ("{0} restored to {1}" -f $State.Name, $target)
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

$release = $null
if (-not $SkipPull) {
  if (-not [string]::IsNullOrWhiteSpace($Version)) {
    $release = ConvertTo-ReleaseVersion $Version
    if ($null -eq $release) {
      throw "-Version '$Version' is not of the form X.Y.Z (or vX.Y.Z)."
    }
  }

  Sync-Tags -Path $javaRepo -Name "libphonenumber"
  Sync-Tags -Path $csharpRepo -Name "libphonenumber-csharp"

  if ($null -eq $release) {
    $release = Get-HighestReleaseTag -Path $javaRepo -Name "libphonenumber"
    $releaseSource = "highest vX.Y.Z tag of google/libphonenumber"
  } else {
    $releaseSource = "-Version"
  }
  $tag = "v$release"
  Write-Host ""
  Write-Host "==> release $tag ($releaseSource)"

  # Resolve both tags before touching either clone, so a missing C# release
  # leaves both clones where they were.
  $javaTagCommit = Resolve-TagCommit -Path $javaRepo -Tag $tag
  if ([string]::IsNullOrWhiteSpace($javaTagCommit)) {
    throw "google/libphonenumber has no tag $tag ($javaRepo); no such upstream release."
  }
  $csharpTagCommit = Resolve-TagCommit -Path $csharpRepo -Tag $tag
  if ([string]::IsNullOrWhiteSpace($csharpTagCommit)) {
    throw (("twcclegg/libphonenumber-csharp has no tag {0} ({1}): the C# release {2} is not published yet, " +
      "and with it NuGet libphonenumber-csharp {2} (needed for the reference oracle pin). " +
      "Wait for it before refreshing (tools/check_upstream_release.ps1 reports the NuGet status).") -f $tag, $csharpRepo, $release)
  }

  Assert-CleanTree -Path $javaRepo -Name "libphonenumber"
  Assert-CleanTree -Path $csharpRepo -Name "libphonenumber-csharp"
  # Record where both clones are before touching either; when a checkout
  # fails (an untracked file in the way, for example), the clones already
  # moved go back there, so the two never end on different releases.
  $clones = @(
    (Get-CloneState -Path $javaRepo -Name "libphonenumber"),
    (Get-CloneState -Path $csharpRepo -Name "libphonenumber-csharp"))
  $moved = @()
  foreach ($clone in $clones) {
    try {
      $output = Invoke-Git -Path $clone.Path -Arguments @("checkout", "--quiet", "--detach", "refs/tags/$tag^{commit}") `
        -What "Checking out $tag in $($clone.Name)"
      $output | ForEach-Object { Write-Host $_ }
      $moved += $clone
    } catch {
      $failure = $_.Exception.Message
      $restored = @()
      for ($i = $moved.Count - 1; $i -ge 0; $i--) {
        $restored += Restore-CloneState -State $moved[$i]
      }
      $note = if ($restored.Count -gt 0) { " Rolled back: " + ($restored -join "; ") + "." } else { "" }
      throw ("{0}{1} No clone is left on {2}; fix the cause and run the script again." -f $failure, $note, $tag)
    }
  }
} else {
  if (-not [string]::IsNullOrWhiteSpace($Version)) {
    throw "-Version and -SkipPull exclude each other: -SkipPull records the commits the clones are at now."
  }
  Assert-GitRepo -Path $javaRepo
  Assert-GitRepo -Path $csharpRepo
  Write-Host ""
  Write-Host "Skipping fetch and checkout (-SkipPull)."
}

$javaCommit = Get-HeadCommit -Path $javaRepo -Name "libphonenumber"
$csharpCommit = Get-HeadCommit -Path $csharpRepo -Name "libphonenumber-csharp"
Write-Host ""
Write-Host "==> libphonenumber"
Write-Host "Commit: $javaCommit"
Write-Host ""
Write-Host "==> libphonenumber-csharp"
Write-Host "Commit: $csharpCommit"

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
if ($null -ne $release -and (ConvertTo-ReleaseVersion $OraclePackageVersion) -ne $release) {
  Write-Warning (("The oracle pin is {0}, the clones are at release {1}. Set Get-OraclePin in tools/oracle_helpers.ps1 " +
    "to {1}, then run this script again with -SkipPull.") -f $OraclePackageVersion, $release)
}

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
