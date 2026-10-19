param(
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  [string]$Config = "Debug",
  [string]$Platform = "Win64",
  # Build the test program but do not run it. The test program is the only
  # artefact that compiles EVERY unit of the port together with the tests with
  # Delphi, so a compile-only build is the cheapest Delphi gate.
  # tools/run_pr_quick_check.ps1 uses it for exactly that.
  [switch]$BuildOnly,
  # Copy the JUnit XML report of the run to this file.
  [string]$JUnit = "",
  # Passed to the runner as --filter (<Fixture>[.<Test>], comma separated).
  [string]$Filter = ""
)

<#
  Builds tests/LibPhoneNumberTests.dproj with msbuild and runs it. The same
  program source is built with FreePascal by tools/run_fpc_tests.ps1.

  The runner (tests/framework/LibPhoneNumber.TestRunner.pas) prints a line
  per fixture, every failure and a summary, and exits with 0 only when every
  test passed; a non zero exit code makes this script throw, which is what
  tools/run_update_workflow.ps1 relies on.
#>

$ErrorActionPreference = "Stop"

# Resolved against the caller's location before the script moves into tests/.
if (-not [string]::IsNullOrWhiteSpace($JUnit)) {
  $JUnit = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($JUnit)
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$testsDir = Join-Path $repoRoot "tests"
$rsvars = Join-Path $StudioRoot "bin\rsvars.bat"
$msbuild = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
$projectName = "LibPhoneNumberTests"
$project = Join-Path $testsDir ($projectName + ".dproj")
$exe = Join-Path $testsDir ("bin\{0}_{1}\{2}.exe" -f $Platform, $Config, $projectName)

if (-not (Test-Path $rsvars)) {
  throw "rsvars.bat not found: $rsvars"
}

if (-not (Test-Path $msbuild)) {
  throw "MSBuild not found: $msbuild"
}

if (-not (Test-Path $project)) {
  throw "Project not found: $project"
}

Push-Location $testsDir
try {
  $studioShort = $StudioRoot.Replace("Program Files (x86)", "Progra~2")
  $rsvarsShort = Join-Path $studioShort "bin\rsvars.bat"

  cmd /c "call $rsvarsShort && $msbuild $projectName.dproj /t:Build /p:Config=$Config /p:Platform=$Platform /v:m"
  if ($LASTEXITCODE -ne 0) {
    throw "Build failed."
  }

  if (-not (Test-Path $exe)) {
    throw "Test executable not found: $exe"
  }

  if ($BuildOnly) {
    Write-Host "Build only (-BuildOnly): every unit of the port compiled, tests not run."
    Write-Host "Executable: $exe"
    return
  }

  $arguments = @()
  if (-not [string]::IsNullOrWhiteSpace($JUnit)) {
    $arguments += @("--junit", $JUnit)
  }
  if (-not [string]::IsNullOrWhiteSpace($Filter)) {
    $arguments += @("--filter", $Filter)
  }
  # The runner exits with 0 only when every selected test passed (1: a test
  # failed or raised, 2: usage error or nothing ran), so the exit code can be
  # trusted here.
  & $exe @arguments
  $testExitCode = $LASTEXITCODE
  if ($testExitCode -ne 0) {
    throw "Delphi test run reported failures (exit code $testExitCode): $exe"
  }
}
finally {
  Pop-Location
}
