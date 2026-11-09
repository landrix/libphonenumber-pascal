param(
  # The README whose "## Quick start" section holds the program, and the
  # program it must show verbatim. Parameters only so the check can be pointed
  # at copies; the defaults are the files of this repository.
  [string]$ReadmePath = "",
  [string]$SamplePath = "",
  [switch]$Quiet
)

<#
  Checks that the first ```pascal fenced block after the "## Quick start"
  heading of README.md is exactly samples/QuickStart.dpr.

  A pure text comparison, no compiler: tools/run_samples.ps1 builds and runs
  the sample and compares its output, this script makes sure the README still
  shows that same program. Only the line ends are normalised (CRLF and a lone
  CR become LF, so a Windows checkout with autocrlf and a Linux checkout give
  the same result), and a line end at the very end of the file does not
  matter (the fenced block cannot carry one). Everything else must match
  exactly, trailing blanks included.

  Fails when the heading, the block or its closing fence is missing, or names
  the first differing line (numbered as in samples/QuickStart.dpr) with both
  versions of it.

  Runs under PowerShell 7 and Windows PowerShell 5.1. tools/run_samples.ps1
  calls it at its start (-SkipReadmeCheck opts out; the update workflow
  passes that to every run after the first).
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($ReadmePath)) {
  $ReadmePath = Join-Path $repoRoot "README.md"
}
if ([string]::IsNullOrWhiteSpace($SamplePath)) {
  $SamplePath = Join-Path (Join-Path $repoRoot "samples") "QuickStart.dpr"
}

function Read-NormalisedLines {
  # The file as UTF-8 text (a BOM is dropped), split into lines after the line
  # end normalisation, without the empty element a final line end leaves.
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    throw "File not found: $Path"
  }
  $text = [System.IO.File]::ReadAllText($Path, (New-Object System.Text.UTF8Encoding($false)))
  $text = $text.Replace("`r`n", "`n").Replace("`r", "`n")
  if ($text.EndsWith("`n")) {
    $text = $text.Substring(0, $text.Length - 1)
  }
  return , ([string[]]($text -split "`n"))
}

$readmeLines = Read-NormalisedLines $ReadmePath
$sampleLines = Read-NormalisedLines $SamplePath

# The heading: exactly "## Quick start" (trailing blanks tolerated).
$heading = -1
for ($i = 0; $i -lt $readmeLines.Count; $i++) {
  if ($readmeLines[$i].TrimEnd() -ceq "## Quick start") {
    $heading = $i
    break
  }
}
if ($heading -lt 0) {
  throw "README quick start check: no '## Quick start' heading in $ReadmePath."
}

# The first ```pascal fence after it, before the next heading of level 1 or 2.
$open = -1
for ($i = $heading + 1; $i -lt $readmeLines.Count; $i++) {
  if ($readmeLines[$i] -cmatch '^#{1,2} ') {
    break
  }
  if ($readmeLines[$i].TrimEnd() -ceq '```pascal') {
    $open = $i
    break
  }
}
if ($open -lt 0) {
  throw "README quick start check: no '``````pascal' block in the '## Quick start' section of $ReadmePath."
}
$close = -1
for ($i = $open + 1; $i -lt $readmeLines.Count; $i++) {
  if ($readmeLines[$i].TrimEnd() -ceq '```') {
    $close = $i
    break
  }
}
if ($close -lt 0) {
  throw ("README quick start check: the '``````pascal' block opened on line {0} of {1} is never closed." -f
    ($open + 1), $ReadmePath)
}

$blockLines = @()
if ($close -gt $open + 1) {
  $blockLines = @($readmeLines[($open + 1)..($close - 1)])
}

$count = [Math]::Max($blockLines.Count, $sampleLines.Count)
for ($i = 0; $i -lt $count; $i++) {
  $s = if ($i -lt $sampleLines.Count) { $sampleLines[$i] } else { $null }
  $r = if ($i -lt $blockLines.Count) { $blockLines[$i] } else { $null }
  # A missing line is checked first: passed to [string]::Equals, PowerShell
  # turns $null into an empty string, which would equal a blank line.
  # Ordinal: PowerShell's -eq is case insensitive and -ceq is linguistic.
  if (($null -eq $s) -or ($null -eq $r) -or
      (-not [string]::Equals($s, $r, [System.StringComparison]::Ordinal))) {
    $sampleText = if ($null -eq $s) { "<end of file>" } else { "'$s'" }
    $readmeText = if ($null -eq $r) { "<end of block>" } else { "'$r'" }
    # The details as separate lines: the error view of PowerShell 7 folds a
    # multi line exception message into one paragraph.
    Write-Host ("README quick start: line {0} of {1} differs from line {2} of {3}" -f
      ($i + 1), $SamplePath, ($open + 2 + $i), $ReadmePath)
    Write-Host ("  sample: {0}" -f $sampleText)
    Write-Host ("  README: {0}" -f $readmeText)
    throw ("README quick start check: the '``````pascal' block of README.md differs from samples/QuickStart.dpr " +
      "at line {0} of the sample (README line {1}); README.md shows the program verbatim, change both together.") -f
      ($i + 1), ($open + 2 + $i)
  }
}

if (-not $Quiet) {
  Write-Host ("README quick start: the block on README lines {0}-{1} equals samples/QuickStart.dpr ({2} lines)." -f
    ($open + 2), $close, $sampleLines.Count)
}
