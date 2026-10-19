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
  # quick check by default: it takes well under a minute per toolchain (WSL;
  # the build dominates), which is cheap next to what it covers.
  [switch]$SkipFpcRuntime,
  # Forwarded to the workflow. The FreePascal test suite (build and run of the
  # whole test program with FreePascal in WSL) is part of the quick check by
  # default for the same reason: it adds well under a minute per toolchain.
  [switch]$SkipFpcTests,
  # Forwarded to the workflow. The samples (tools/run_samples.ps1: every
  # program of samples/ built and run with Delphi and the FreePascal
  # toolchains, output compared with samples/expected) take a few seconds per
  # compiler.
  [switch]$SkipSamples,
  # Forwarded to the workflow when given: the toolchains of the runtime check,
  # the test suite and the samples ("<Toolchain>" or
  # "<Toolchain>=<compiler path>"). The default - WSL FreePascal 3.2.4 and
  # 3.2.2 - is defined there, not here.
  [string[]]$FpcToolchains
)

<#
  CI friendly quick gate: the full update workflow without the Delphi test RUN
  and, by default, without the reference case refresh. The FreePascal test
  suite DOES run (it is cheap; -SkipFpcTests opts out).

  The compare step behind it reads the GENERATED metadata, so this gate also
  catches a generator or vendor drift in the possible lengths of any territory. The
  mass differential stays out of it deliberately - it needs the oracle package
  and takes minutes; run
  tools/run_update_workflow.ps1 -FailOnDiff -RunMassDifferential for that.

  It additionally BUILDS the Delphi test program (tests/LibPhoneNumberTests)
  without running it. The workflow runs with -SkipTests, which skips the
  Delphi test run, and the test program is the only artefact that links every
  unit of the port together with the tests, so building it proves that
  everything still compiles with Delphi.

  The workflow behind it also runs the FreePascal RUNTIME check
  (tools/run_fpc_runtime_check.ps1) and the FreePascal TEST SUITE
  (tools/run_fpc_tests.ps1), both on the WSL FreePascal 3.2.4 AND 3.2.2 by
  default (-FpcToolchains); each run takes well under a minute end to end, so
  both stay in (-SkipFpcRuntime, -SkipFpcTests opt out). The SAMPLES are
  built, run and compared with their expected output on Delphi and on the
  same FreePascal toolchains (-SkipSamples opts out).

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
  SkipFpcTests   = $SkipFpcTests
  SkipSamples    = $SkipSamples
  # The runtime check builds its Delphi reference with dcc64 from this
  # installation, so the quick check's -StudioRoot must reach it.
  StudioRoot     = $StudioRoot
}
if (-not $RefreshReference) {
  $workflowArguments["SkipReference"] = $true
}
if ($PSBoundParameters.ContainsKey("FpcToolchains")) {
  $workflowArguments["FpcToolchains"] = $FpcToolchains
}

& $workflowScript @workflowArguments

if ($SkipDelphiCompile) {
  Write-Host ""
  Write-Host "Skipping the Delphi compile-only build (-SkipDelphiCompile)."
  return
}

$rsvars = Join-Path $StudioRoot "bin\rsvars.bat"
if (-not (Test-Path -LiteralPath $rsvars)) {
  $message = "No Delphi installation found at '$StudioRoot'; skipping the compile-only build of the test program."
  if ($RequireDelphi) {
    throw $message
  }
  Write-Host ""
  Write-Warning $message
  return
}

Write-Host ""
Write-Host "==> Compile the Delphi test program (no test run)"
& $delphiScript -StudioRoot $StudioRoot -Config $Config -Platform $Platform -BuildOnly
