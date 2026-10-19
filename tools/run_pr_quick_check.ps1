param(
  [switch]$RefreshReference,
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  [string]$Config = "Debug",
  [string]$Platform = "Win64",
  # Turn a missing FreePascal compiler / a missing Delphi installation from a
  # warning into a failure. Both gates are soft skips by default because the
  # public CI runner has neither.
  [switch]$RequireFpc,
  [switch]$RequireDelphi,
  [switch]$SkipDelphiCompile,
  # Forwarded to the workflow. The FreePascal runtime check is part of the
  # quick check by default: it takes about twenty seconds (WSL; the build
  # dominates), which is cheap next to what it covers.
  [switch]$SkipFpcRuntime
)

<#
  CI friendly quick gate: the full update workflow without the Delphi test RUN
  and, by default, without the reference case refresh.

  The compare step behind it reads the GENERATED metadata, so this gate also
  catches a generator or vendor drift in the possible lengths of any territory. The
  mass differential stays out of it deliberately - it needs the oracle package
  and takes minutes; run
  tools/run_update_workflow.ps1 -FailOnDiff -RunMassDifferential for that.

  It additionally BUILDS the DUnitX test project without running it. The
  workflow runs with -SkipTests, which skips the Delphi compiler entirely, and
  the test project is the only artefact that links every unit of the port
  together with the tests, so building it - without paying for the test run -
  proves that everything still compiles with Delphi.

  The workflow behind it also runs the FreePascal RUNTIME check
  (tools/run_fpc_runtime_check.ps1, WSL toolchain by default): measured at
  about twenty seconds end to end, so it stays in; -SkipFpcRuntime opts out.

  The compile step is skipped with a warning when no Delphi installation is
  found at -StudioRoot (the GitHub runner has none); -RequireDelphi turns that
  into a failure.
#>

$ErrorActionPreference = "Stop"

$workflowScript = Join-Path $PSScriptRoot "run_update_workflow.ps1"
$delphiScript = Join-Path $PSScriptRoot "run_delphi_tests.ps1"

$workflowArguments = @{
  FailOnDiff     = $true
  SkipTests      = $true
  RequireFpc     = $RequireFpc
  SkipFpcRuntime = $SkipFpcRuntime
  # The runtime check builds its Delphi reference with dcc64 from this
  # installation, so the quick check's -StudioRoot must reach it.
  StudioRoot     = $StudioRoot
}
if (-not $RefreshReference) {
  $workflowArguments["SkipReference"] = $true
}

& $workflowScript @workflowArguments

if ($SkipDelphiCompile) {
  Write-Host ""
  Write-Host "Skipping the Delphi compile-only build (-SkipDelphiCompile)."
  return
}

$rsvars = Join-Path $StudioRoot "bin\rsvars.bat"
if (-not (Test-Path -LiteralPath $rsvars)) {
  $message = "No Delphi installation found at '$StudioRoot'; skipping the compile-only build of the test project."
  if ($RequireDelphi) {
    throw $message
  }
  Write-Host ""
  Write-Warning $message
  return
}

Write-Host ""
Write-Host "==> Compile the DUnitX test project (no test run)"
& $delphiScript -StudioRoot $StudioRoot -Config $Config -Platform $Platform -BuildOnly
