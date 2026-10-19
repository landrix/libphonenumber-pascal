param(
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  [string]$Config = "Debug",
  [string]$Platform = "Win64",
  # Build the DUnitX project but do not run it. The test project is the only
  # thing that compiles EVERY unit of the port together with the tests with
  # Delphi, so a compile-only build is the cheapest Delphi gate.
  # tools/run_pr_quick_check.ps1 uses it for exactly that.
  [switch]$BuildOnly
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$testsDir = Join-Path $repoRoot "tests"
$rsvars = Join-Path $StudioRoot "bin\rsvars.bat"
$msbuild = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
$project = Join-Path $testsDir "DUnitXCmdTest.dproj"
$exe = Join-Path $testsDir ("bin\{0}_{1}\DUnitXCmdTest.exe" -f $Platform, $Config)

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

  cmd /c "call $rsvarsShort && $msbuild DUnitXCmdTest.dproj /t:Build /p:Config=$Config /p:Platform=$Platform /v:m"
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

  # DUnitXCmdTest sets ExitCode = EXIT_ERRORS (1) when tests fail or error, and only
  # pauses when --exitbehavior:Pause is passed, so the exit code can be trusted here.
  & $exe
  $testExitCode = $LASTEXITCODE
  if ($testExitCode -ne 0) {
    throw "Delphi test run reported failures (exit code $testExitCode): $exe"
  }
}
finally {
  Pop-Location
}
