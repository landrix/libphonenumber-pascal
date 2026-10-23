param(
  # The release the repository is pinned to. Empty (the default) reads it from
  # Get-OraclePin in tools/oracle_helpers.ps1, the canonical pin: by the rule
  # in AGENTS.md its PackageVersion IS the metadata release of the pinned Java
  # baseline. Pass a version only to test the script ("9.0.40" pretends the
  # pin is older than upstream).
  [string]$PinnedVersion = "",
  # The repository the issue is opened in. Empty: $env:GITHUB_REPOSITORY (set
  # on GitHub runners), else the repository of the current checkout (gh).
  [string]$Repository = "",
  [string]$UpstreamRepository = "google/libphonenumber",
  [string]$NuGetPackageId = "libphonenumber-csharp",
  [string]$Label = "upstream-release",
  # Testing only: read the open issues from this JSON file (an array of
  # {number, title, body, url}) instead of querying GitHub. Combine with
  # -DryRun to exercise the duplicate and cleanup handling without a token.
  [string]$IssuesJson = "",
  # Prints what the script would do and changes nothing: no label, no issue,
  # no comment. Reading the open issues still happens, so the duplicate
  # handling is part of a dry run as well.
  [switch]$DryRun
)

<#
  Weekly check for a new upstream libphonenumber release; the logic behind
  .github/workflows/upstream-release-check.yml, runnable locally with pwsh on
  Windows and Linux (needs git, and gh authenticated for the issue part).

  1. Pinned release: -PinnedVersion, else Get-OraclePin (tools/oracle_helpers.ps1).
  2. Latest upstream: the highest vX.Y.Z tag of -UpstreamRepository
     (git ls-remote, compared as versions, never as strings).
  3. NuGet: whether -NuGetPackageId already has that version (the oracle pin
     needs it). Reported in the issue text; a lookup failure is reported as
     "unknown", never a failure of the check.
  4. Issues: the OPEN issues of -Repository titled "Upstream libphonenumber
     vX.Y.Z released", found with a title search (not a capped listing).
     Issues this script opened carry the hidden marker
     <!-- upstream-release-check --> in their body (and the label -Label):
       - an open issue for the latest version, whoever opened it (title
         match), means no new issue; otherwise one is opened (label created
         on first use);
       - then every open issue for an OLDER version that carries the marker
         gets a comment pointing to the latest one and is closed as not
         planned - the vendor refresh always goes to the newest release. This
         also runs when the latest issue already existed, so a cleanup that
         failed on an earlier run is retried. Issues without the marker
         (opened by a person) are only reported, never commented on or closed.
     When the pin is up to date nothing is written; an open issue for a
     version the pin has already reached is only reported, for a person to
     close.
#>

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "oracle_helpers.ps1")

$titlePattern = '^Upstream libphonenumber v(\d+\.\d+\.\d+) released$'
# Ownership marker: only issues whose body carries it are ever commented on or
# closed by this script.
$ownershipMarker = "<!-- upstream-release-check -->"

function ConvertTo-ReleaseVersion {
  # "9.0.41" or "v9.0.41" -> [version]; anything else -> $null.
  param([string]$Text)
  $match = [regex]::Match($Text.Trim(), '^v?(\d+)\.(\d+)\.(\d+)$')
  if (-not $match.Success) {
    return $null
  }
  return [version]::new([int]$match.Groups[1].Value, [int]$match.Groups[2].Value, [int]$match.Groups[3].Value)
}

function Invoke-Gh {
  # gh with its output as lines; a non zero exit code is an error.
  param([string[]]$Arguments)
  $output = & gh @Arguments 2>&1 | ForEach-Object { "$_" }
  if ($LASTEXITCODE -ne 0) {
    throw ("gh {0} failed (exit code {1}): {2}" -f ($Arguments -join " "), $LASTEXITCODE, ($output -join " "))
  }
  return @($output)
}

# ---- Pinned release --------------------------------------------------------
if ([string]::IsNullOrWhiteSpace($PinnedVersion)) {
  $PinnedVersion = (Get-OraclePin).PackageVersion
  $pinSource = "Get-OraclePin in tools/oracle_helpers.ps1"
} else {
  $pinSource = "-PinnedVersion override"
}
$pinned = ConvertTo-ReleaseVersion $PinnedVersion
if ($null -eq $pinned) {
  throw "The pinned version '$PinnedVersion' is not of the form X.Y.Z."
}
Write-Host ("pinned   : {0} ({1})" -f $pinned, $pinSource)

# ---- Latest upstream release ------------------------------------------------
$upstreamUrl = "https://github.com/$UpstreamRepository"
$refs = & git ls-remote --tags --refs "$upstreamUrl.git" 2>&1 | ForEach-Object { "$_" }
if ($LASTEXITCODE -ne 0) {
  throw ("git ls-remote failed for {0}: {1}" -f $upstreamUrl, ($refs -join " "))
}
$latest = $null
foreach ($line in $refs) {
  $tag = ($line -split "`t", 2)[-1] -replace '^refs/tags/', ''
  $version = ConvertTo-ReleaseVersion $tag
  if ($null -ne $version -and $tag.StartsWith("v") -and ($null -eq $latest -or $version -gt $latest)) {
    $latest = $version
  }
}
if ($null -eq $latest) {
  throw "No vX.Y.Z tag found in $upstreamUrl."
}
$latestTag = "v$latest"
Write-Host ("upstream : {0} (highest vX.Y.Z tag of {1})" -f $latestTag, $UpstreamRepository)

# ---- NuGet status (informational) --------------------------------------------
$nugetIndex = "https://api.nuget.org/v3-flatcontainer/{0}/index.json" -f $NuGetPackageId.ToLowerInvariant()
try {
  $index = Invoke-RestMethod -Uri $nugetIndex -TimeoutSec 60
  $available = @($index.versions | Where-Object { (ConvertTo-ReleaseVersion "$_") -eq $latest }).Count -gt 0
  $nugetStatus = if ($available) { "available" } else { "not published yet" }
} catch {
  $nugetStatus = "unknown (lookup failed: $($_.Exception.Message))"
}
Write-Host ("nuget    : {0} {1}: {2}" -f $NuGetPackageId, $latest, $nugetStatus)

# ---- Open issues of this repository ------------------------------------------
if ([string]::IsNullOrWhiteSpace($Repository)) {
  $Repository = $env:GITHUB_REPOSITORY
}
if ([string]::IsNullOrWhiteSpace($Repository)) {
  $Repository = @(Invoke-Gh @("repo", "view", "--json", "nameWithOwner", "--jq", ".nameWithOwner"))[0].Trim()
}
Write-Host ("repo     : {0}" -f $Repository)

if ([string]::IsNullOrWhiteSpace($IssuesJson)) {
  # A title search instead of a listing of every open issue, so the result does
  # not depend on how many other issues are open; the exact title is checked
  # below, the search only narrows.
  $openIssues = (Invoke-Gh @("issue", "list", "--repo", $Repository, "--state", "open", "--limit", "1000",
      "--search", 'in:title "Upstream libphonenumber" "released"',
      "--json", "number,title,body,url")) -join "`n" | ConvertFrom-Json
} else {
  Write-Host ("issues   : read from {0} (-IssuesJson, testing)" -f $IssuesJson)
  $openIssues = Get-Content -LiteralPath $IssuesJson -Raw -Encoding UTF8 | ConvertFrom-Json
}
$releaseIssues = @()
foreach ($issue in @($openIssues)) {
  $match = [regex]::Match([string]$issue.title, $titlePattern)
  if ($match.Success) {
    $releaseIssues += [pscustomobject]@{
      Number  = [int]$issue.number
      Version = (ConvertTo-ReleaseVersion $match.Groups[1].Value)
      Url     = [string]$issue.url
      Owned   = ([string]$issue.body).Contains($ownershipMarker)
    }
  }
}

if ($latest -le $pinned) {
  Write-Host ("result   : up to date (upstream {0} <= pinned {1}); nothing to do." -f $latest, $pinned)
  foreach ($issue in @($releaseIssues | Where-Object { $_.Version -le $pinned })) {
    Write-Host ("note     : issue #{0} (v{1}) is still open although the pin has reached that release; close it once the refresh is merged." -f
      $issue.Number, $issue.Version)
  }
  return
}

$title = "Upstream libphonenumber $latestTag released"
$existing = @($releaseIssues | Where-Object { $_.Version -eq $latest })
$older = @($releaseIssues | Where-Object { $_.Version -lt $latest })

$body = @'
{{MARKER}}
libphonenumber **{{TAG}}** is out; this repository is pinned to **{{PINNED}}** (`Get-OraclePin` in `tools/oracle_helpers.ps1`).

- Release notes: {{UPSTREAM}}/releases/tag/{{TAG}} (also `release_notes.txt`: {{UPSTREAM}}/blob/{{TAG}}/release_notes.txt)
- Changes since the pin: {{UPSTREAM}}/compare/v{{PINNED}}...{{TAG}}
- NuGet `{{PACKAGE}}` {{VERSION}} (needed for the reference oracle pin): **{{NUGET}}** at the time of this check (https://www.nuget.org/packages/{{PACKAGE}}/{{VERSION}}). If it is not published yet, wait for it before moving the pin.

Refresh, as described in `AGENTS.md`, section "Vendor Update Workflow":

1. `tools/refresh_vendor_versions.ps1` (fast-forwards the upstream clones, rewrites `vendor/versions.md`).
2. Set `Get-OraclePin` in `tools/oracle_helpers.ps1` to {{VERSION}}, then `tools/refresh_vendor_versions.ps1 -SkipPull`.
3. `tools/run_update_workflow.ps1 -RunMassDifferential` (without `-FailOnDiff`), read the compare summary and the mass differential findings.
4. Review the diffs, update the manifest in `AGENTS.md` and `CHANGELOG.md`, commit.
5. Verify with `tools/run_update_workflow.ps1 -FailOnDiff -RunMassDifferential`. Release it as `v{{VERSION}}.0` (`AGENTS.md`, section "Releases").

Opened by `.github/workflows/upstream-release-check.yml` (`tools/check_upstream_release.ps1`). Close this issue with the refresh commit.
'@
$body = $body.Replace("{{TAG}}", $latestTag).Replace("{{VERSION}}", "$latest").Replace("{{PINNED}}", "$pinned").
  Replace("{{UPSTREAM}}", $upstreamUrl).Replace("{{PACKAGE}}", $NuGetPackageId).Replace("{{NUGET}}", $nugetStatus).Replace("{{MARKER}}", $ownershipMarker)

if ($existing.Count -gt 0) {
  # Matched by title, whoever opened it: never a second issue for a version.
  $targetUrl = $existing[0].Url
  Write-Host ("result   : {0} is newer than the pin {1}, but issue #{2} is already open; no new issue." -f
    $latestTag, $pinned, $existing[0].Number)
} elseif ($DryRun) {
  $targetUrl = "<the new issue>"
  Write-Host ("result   : {0} is newer than the pin {1}; would open an issue in {2} (dry run, nothing written)." -f $latestTag, $pinned, $Repository)
  Write-Host ("title    : {0}" -f $title)
  Write-Host ("label    : {0}" -f $Label)
  Write-Host "body     :"
  $body -split "`n" | ForEach-Object { Write-Host ("  " + $_.TrimEnd("`r")) }
} else {
  # The label is a convenience for filtering; the body marker marks ownership.
  $labelArguments = @()
  try {
    [void](Invoke-Gh @("label", "create", $Label, "--repo", $Repository, "--color", "0e8a16",
        "--description", "A newer upstream libphonenumber release is available", "--force"))
    $labelArguments = @("--label", $Label)
  } catch {
    Write-Warning "Could not create the label '$Label'; opening the issue without it. $($_.Exception.Message)"
  }

  $bodyFile = [System.IO.Path]::GetTempFileName()
  try {
    [System.IO.File]::WriteAllText($bodyFile, $body, (New-Object System.Text.UTF8Encoding($false)))
    $created = @(Invoke-Gh (@("issue", "create", "--repo", $Repository, "--title", $title, "--body-file", $bodyFile) + $labelArguments))
  } finally {
    Remove-Item -LiteralPath $bodyFile -Force -ErrorAction SilentlyContinue
  }
  $targetUrl = ($created | Where-Object { $_ -match '/issues/\d+' } | Select-Object -Last 1)
  Write-Host ("result   : opened {0}" -f $targetUrl)
}

# Older issues: also when the latest issue already existed, so a cleanup that
# failed on an earlier run is retried. Only issues with the marker are touched.
foreach ($issue in $older) {
  if (-not $issue.Owned) {
    Write-Host ("older    : issue #{0} (v{1}) has no {2} marker (not opened by this check); left alone." -f
      $issue.Number, $issue.Version, $ownershipMarker)
    continue
  }
  if ($DryRun) {
    Write-Host ("older    : would comment on and close issue #{0} (v{1}) as superseded by {2}." -f $issue.Number, $issue.Version, $targetUrl)
    continue
  }
  [void](Invoke-Gh @("issue", "comment", "$($issue.Number)", "--repo", $Repository, "--body",
      "Superseded by $targetUrl ($latestTag): the vendor refresh goes straight to the newest release."))
  [void](Invoke-Gh @("issue", "close", "$($issue.Number)", "--repo", $Repository, "--reason", "not planned"))
  Write-Host ("older    : commented on and closed issue #{0} (v{1})." -f $issue.Number, $issue.Version)
}
