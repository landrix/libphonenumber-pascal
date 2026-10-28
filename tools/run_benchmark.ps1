param(
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  [int]$Repetitions = 50,
  [string]$JsonPath = "",
  # PARENT directory of the build/run scratch space. The script creates and
  # removes only its own uniquely named subdirectory below it and never deletes
  # the directory it was given.
  [string]$WorkDir = "",
  [switch]$SkipBuild,
  [switch]$KeepWorkDir
)

<#
  Performance benchmark of the library.

  Builds tools/benchmark/PhoneNumbersBenchmark.dpr with dcc64 and runs it over
  the 1143 example numbers of the generated production metadata: parse,
  isValid, format(INTERNATIONAL) and the three of them back to back.

  This is DOCUMENTATION, not a gate. Nothing here fails on a slow machine, the
  update workflow does not call it, and the recorded numbers live in
  docs/ARCHITECTURE.md. Re-run it after a change that could plausibly cost
  throughput (a new regex in a hot path, an extra metadata lookup per call) and
  compare against those.

  -JsonPath additionally writes the raw figures as JSON; the file is a local
  artifact and is not versioned.
#>

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$projectDir = Join-Path $PSScriptRoot "benchmark"
$projectFile = Join-Path $projectDir "PhoneNumbersBenchmark.dpr"

if (-not (Test-Path -LiteralPath $projectFile)) {
  throw "Benchmark project not found: $projectFile"
}

# The scratch directory is created and deleted recursively, so it must never be
# a path the caller cares about. -WorkDir therefore names a PARENT directory;
# the script appends its own uniquely named subdirectory and only ever touches
# that one. The process id in the name also keeps concurrent runs apart. Same
# rule as tools/check_fpc_compile.ps1.
if ([string]::IsNullOrWhiteSpace($WorkDir)) {
  $WorkDir = [System.IO.Path]::GetTempPath()
}
# Absolute from here on: the script changes its location (Push-Location) and
# hands paths to other processes, so a relative -WorkDir would resolve
# against a different directory later.
$WorkDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($WorkDir)
$scratchDir = Join-Path $WorkDir ("libphonenumber-benchmark-{0}" -f $PID)

if (Test-Path -LiteralPath $scratchDir) {
  Remove-Item -LiteralPath $scratchDir -Recurse -Force
}
[void](New-Item -ItemType Directory -Path $scratchDir -Force)
$dcuDir = Join-Path $scratchDir "dcu"
[void](New-Item -ItemType Directory -Path $dcuDir -Force)

$benchExe = Join-Path $scratchDir "PhoneNumbersBenchmark.exe"

if (-not $SkipBuild) {
  $dcc64 = Join-Path $StudioRoot "bin\dcc64.exe"
  if (-not (Test-Path -LiteralPath $dcc64)) {
    throw "Delphi command line compiler not found: $dcc64"
  }

  Write-Host "==> Building the benchmark"
  Push-Location $projectDir
  try {
    # -B rebuild, -Q quiet, -$O+ is the default for a release build of the
    # command line compiler; the units are compiled exactly as the library
    # ships them.
    & $dcc64 -B -Q "-U..\..\src" ("-NU" + $dcuDir) ("-E" + $scratchDir) "PhoneNumbersBenchmark.dpr"
    if ($LASTEXITCODE -ne 0) {
      throw "dcc64 failed for $projectFile (exit code $LASTEXITCODE)."
    }
  } finally {
    Pop-Location
  }
}
elseif (-not (Test-Path -LiteralPath $benchExe)) {
  # -SkipBuild reuses an executable an earlier -KeepWorkDir run left behind.
  # That run's scratch directory carried ITS process id, so also accept the
  # executable directly in the -WorkDir the caller named.
  $reusedExe = Join-Path $WorkDir "PhoneNumbersBenchmark.exe"
  if (Test-Path -LiteralPath $reusedExe) {
    $benchExe = $reusedExe
  }
}

if (-not (Test-Path -LiteralPath $benchExe)) {
  throw "Benchmark executable not found: $benchExe"
}

Write-Host "==> Running the benchmark ($Repetitions repetitions)"
if ([string]::IsNullOrWhiteSpace($JsonPath)) {
  & $benchExe $Repetitions
} else {
  & $benchExe $Repetitions $JsonPath
}
$benchExitCode = $LASTEXITCODE

if ($KeepWorkDir) {
  Write-Host "Work directory kept: $scratchDir"
} else {
  # Windows can still hold the handle of the process that just exited, which
  # made the removal fail silently and leave the executable behind. Retry a few
  # times before giving up; never fail the run over a leftover scratch file.
  for ($attempt = 1; $attempt -le 5 -and (Test-Path -LiteralPath $scratchDir); $attempt++) {
    Remove-Item -LiteralPath $scratchDir -Recurse -Force -ErrorAction SilentlyContinue
    if (Test-Path -LiteralPath $scratchDir) {
      [System.Threading.Thread]::Sleep(200)
    }
  }
  if (Test-Path -LiteralPath $scratchDir) {
    Write-Warning "Could not remove the scratch directory (still locked): $scratchDir"
  }
}

if ($benchExitCode -ne 0) {
  throw "The benchmark failed (exit code $benchExitCode)."
}
