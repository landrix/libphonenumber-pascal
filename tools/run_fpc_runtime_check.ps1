param(
  # Which FreePascal build is compared against the Delphi reference:
  #   Wsl    - FreePascal inside WSL (the mandatory gate; default compiler
  #            ~/fpc-3.2.4/bin/fpc of the WSL user, override with -FpcPath)
  #   Native - the Windows FreePascal on PATH (or -FpcPath)
  #   Mac    - the shared Mac toolchain behind the ssh alias -MacHost, built
  #            with ~/remote-toolchains/macos-fpc/bin/fpc.sh (manual extra run)
  [ValidateSet("Wsl", "Native", "Mac")]
  [string]$Toolchain = "Wsl",
  [string]$FpcPath = "",
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  [string]$MacHost = "macos-tests",
  # PARENT directory of the scratch space. The script creates and removes only
  # its own uniquely named subdirectory below it and never deletes the
  # directory it was given.
  [string]$WorkDir = "",
  # Directory of a REUSABLE Delphi reference, owned by the caller. When it
  # holds a reference whose fingerprint (driver input, driver source, every
  # unit of src/, dcc64 identity, build options) matches this run, the Delphi build is skipped and
  # that reference is compared against; otherwise the reference is built as
  # usual and stored there. tools/run_update_workflow.ps1 uses it to build the
  # reference once for the runs on several FreePascal toolchains. The script
  # never deletes this directory.
  [string]$ReferenceDir = "",
  [int]$MaxDiffLines = 20,
  [switch]$RequireFpc,
  [switch]$RequireDelphi,
  [switch]$KeepWorkDir,
  [switch]$Quiet
)

<#
  FreePascal RUNTIME gate for the library units.

  tools/check_fpc_compile.ps1 proves that the FreePascal clean units COMPILE;
  this script proves that they BEHAVE like the Delphi build. It builds the
  driver tools/fpcruntime/PhoneNumbersFpcRuntime.dpr twice from the same
  source - once with dcc64, once with FreePascal - runs both and compares the
  two observation files byte for byte. The Delphi output is the reference: it
  is the build the test suite and the mass differential vouch for. Every
  differing line is a FreePascal behaviour difference of the port (regex
  dialect of TRegExpr, AnsiString/UnicodeString conversions, Char = AnsiChar,
  RTL character data) and must be fixed in src/, never excluded here.

  The driver uses exactly the units of the FPC compile gate - the facade and
  the matcher included - and derives most inputs from the generated metadata
  itself (see its header). The rest is fed from ONE plain text file this
  script generates into the scratch directory on every run, so neither RTL
  needs a JSON reader: the AYTF corpus plus the mobileDialing and
  keepingAlphaChars sections of tests/data/aytf_reference_cases.json, and the
  inputs of the reference corpus tests/data/reference_cases_java_csharp.json.

  Like the compile check the gate is a no-op with a warning when the selected
  FreePascal toolchain is not reachable; -RequireFpc turns that into a failure.
  A missing Delphi installation is handled the same way (-RequireDelphi),
  because without the reference there is nothing to compare against.

  Mac mode copies the sources into a fresh run directory
  ~/remote-toolchains/macos-fpc/runs/libphonenumber-<utc>-<id>/ on -MacHost,
  builds there with the shared fpc.sh wrapper (which discovers Xcode and the
  SDK on every call; nothing here names an Xcode path), runs the driver and
  copies the observation file back. Remote runs are kept for review, as the
  toolchain README asks.
#>

$ErrorActionPreference = "Stop"

# Toolchain resolution, Invoke-Native, the Mac transport and the build output
# rules are shared with tools/run_fpc_tests.ps1.
. (Join-Path $PSScriptRoot "fpc_toolchains.ps1")

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot "src"
$driverDir = Join-Path $PSScriptRoot "fpcruntime"
$driverName = "PhoneNumbersFpcRuntime"
$driverFile = Join-Path $driverDir ($driverName + ".dpr")
$aytfJson = Join-Path $repoRoot "tests\data\aytf_reference_cases.json"
$referenceJson = Join-Path $repoRoot "tests\data\reference_cases_java_csharp.json"

# The FreePascal options of both the local and the remote build. -Mdelphi and
# -Sh match tools/check_fpc_compile.ps1; range and overflow checking are on in
# BOTH builds (dcc64 gets -$R+ -$Q+), so an index or arithmetic slip that one
# compiler would let pass silently becomes a visible exception line.
$fpcOptions = @("-B", "-Mdelphi", "-Sh", "-Cr", "-Co", "-gl")

function Write-Info {
  param([string]$Message)
  if (-not $Quiet) {
    Write-Host $Message
  }
}

# The scratch directory is created and deleted recursively, so it must never be
# a path the caller cares about. -WorkDir therefore names a PARENT directory;
# the script appends its own uniquely named subdirectory and only ever touches
# that one. Same rule as tools/check_fpc_compile.ps1.
if ([string]::IsNullOrWhiteSpace($WorkDir)) {
  $WorkDir = [System.IO.Path]::GetTempPath()
}
# Absolute from here on: the script changes its location (Push-Location) and
# hands paths to other processes, so a relative -WorkDir would resolve
# against a different directory later.
$WorkDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($WorkDir)
$scratchDir = Join-Path $WorkDir ("libphonenumber-fpcruntime-{0}" -f $PID)

if (-not (Test-Path -LiteralPath $driverFile)) {
  throw "Runtime gate driver not found: $driverFile"
}

# ---------------------------------------------------------------------------
# Inputs
# ---------------------------------------------------------------------------

function ConvertTo-EscapedField {
  # Same escaping as EscapeField in the driver: printable ASCII stays, the
  # backslash, the separator and everything else becomes \uXXXX.
  param([string]$Value)
  $builder = New-Object System.Text.StringBuilder
  foreach ($ch in $Value.ToCharArray()) {
    $code = [int]$ch
    if ($code -ge 0x20 -and $code -le 0x7E -and $ch -ne '\' -and $ch -ne '|') {
      [void]$builder.Append($ch)
    } else {
      [void]$builder.AppendFormat("\u{0:X4}", $code)
    }
  }
  return $builder.ToString()
}

function ConvertTo-Flag {
  param($Value)
  if ([bool]$Value) { return "T" }
  return "F"
}

function Write-DriverInput {
  # One record per line, '|' separated, every free text field escaped like the
  # driver output. Record kinds: seq / remember / clear / smoke (the AYTF
  # corpus), mobile / alpha (the two formatter sections of the AYTF JSON that
  # start from a parsed number) and ref (the reference corpus inputs). Only
  # INPUTS are taken over; no expected value of either JSON reaches the driver.
  param([string]$Path)
  $json = Get-Content -LiteralPath $aytfJson -Raw -Encoding UTF8 | ConvertFrom-Json
  $reference = Get-Content -LiteralPath $referenceJson -Raw -Encoding UTF8 | ConvertFrom-Json
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("# Generated by tools/run_fpc_runtime_check.ps1 from tests/data/aytf_reference_cases.json and tests/data/reference_cases_java_csharp.json")
  foreach ($case in @($json.aytfSequences)) {
    $lines.Add(("seq|{0}|{1}" -f $case.region, (ConvertTo-EscapedField $case.input)))
  }
  foreach ($case in @($json.aytfRemember)) {
    $lines.Add(("remember|{0}|{1}|{2}" -f $case.region, (ConvertTo-EscapedField $case.input),
      ((@($case.rememberIndices) | ForEach-Object { [string]$_ }) -join ",")))
  }
  foreach ($case in @($json.aytfClear)) {
    $lines.Add(("clear|{0}|{1}|{2}" -f $case.region, (ConvertTo-EscapedField $case.firstInput),
      (ConvertTo-EscapedField $case.secondInput)))
  }
  foreach ($case in @($json.aytfSmoke)) {
    $lines.Add(("smoke|{0}|{1}" -f $case.region, (ConvertTo-EscapedField $case.input)))
  }
  foreach ($case in @($json.mobileDialing)) {
    $lines.Add(("mobile|{0}|{1}|{2}|{3}|{4}" -f $case.region, $case.regionCallingFrom,
      (ConvertTo-Flag $case.withFormatting), (ConvertTo-Flag $case.keepRawInput),
      (ConvertTo-EscapedField $case.input)))
  }
  foreach ($case in @($json.keepingAlphaChars)) {
    $lines.Add(("alpha|{0}|{1}|{2}" -f $case.region, $case.regionCallingFrom,
      (ConvertTo-EscapedField $case.rawInput)))
  }
  foreach ($case in @($reference)) {
    $lines.Add(("ref|{0}|{1}|{2}" -f $case.country, (ConvertTo-EscapedField $case.input),
      (ConvertTo-EscapedField $case.name)))
  }
  # LF and ASCII, so the file reads the same on every RTL and platform.
  Write-LfAsciiFile -Path $Path -Lines $lines
  return ($lines.Count - 1)
}

function Write-UnixScript {
  # The build-and-run step of the Wsl and the Mac mode. Written at run time
  # with LF line ends and run as "sh <script> <args>", so no $-containing one
  # liner has to survive PowerShell, wsl.exe or ssh quoting.
  param([string]$Path)
  $options = $fpcOptions -join " "
  $script = @(
    '#!/bin/sh',
    '# Generated by tools/run_fpc_runtime_check.ps1.',
    '# Arguments: <fpc> <source dir> <driver dir> <output dir> <input file>',
    'fpc="$1"; src="$2"; drv="$3"; out="$4"; input="$5"',
    'mkdir -p "$out/units" || exit 2',
    '{ "$fpc" -iV; "$fpc" -iTP; "$fpc" -iTO; } > "$out/fpc-info.txt" 2>&1',
    ('"$fpc" ' + $options + ' -FU"$out/units" -FE"$out" -Fu"$src" "$drv/' + $driverName + '.dpr" > "$out/build.log" 2>&1'),
    'status=$?',
    'if [ $status -ne 0 ]; then cat "$out/build.log"; echo "FPC build failed (exit $status)"; exit 3; fi',
    ('"$out/' + $driverName + '" "$input" "$out/observations.txt" "$out/rtl-characters.txt"'),
    'status=$?',
    'if [ $status -ne 0 ]; then echo "driver failed (exit $status)"; exit 4; fi',
    'exit 0'
  )
  Write-LfAsciiFile -Path $Path -Lines $script
}

# ---------------------------------------------------------------------------
# Reusable Delphi reference (-ReferenceDir)
# ---------------------------------------------------------------------------

function Get-ReferenceFingerprint {
  # SHA-256 over everything the Delphi observation files depend on: the
  # generated driver input, the driver source, every unit of src/, the
  # compiler (path, file version, size, time stamp) and the build options. A
  # stored reference is reused only when this matches exactly.
  param([string]$DriverInput, [string]$Compiler, [string[]]$Options)
  $parts = New-Object System.Collections.Generic.List[string]
  $compilerFile = Get-Item -LiteralPath $Compiler
  $parts.Add(("compiler|{0}|{1}|{2}|{3}" -f $Compiler, $compilerFile.VersionInfo.FileVersion, $compilerFile.Length,
    $compilerFile.LastWriteTimeUtc.ToString("o")))
  $parts.Add("options|" + ($Options -join " "))
  $parts.Add("input|" + (Get-FileHash -LiteralPath $DriverInput -Algorithm SHA256).Hash)
  $parts.Add("driver|" + (Get-FileHash -LiteralPath $driverFile -Algorithm SHA256).Hash)
  foreach ($unit in @(Get-ChildItem -LiteralPath $sourceDir -Filter "*.pas" -File | Sort-Object Name)) {
    $parts.Add(("src|{0}|{1}" -f $unit.Name, (Get-FileHash -LiteralPath $unit.FullName -Algorithm SHA256).Hash))
  }
  $bytes = [System.Text.Encoding]::UTF8.GetBytes(($parts -join "`n"))
  $sha = [System.Security.Cryptography.SHA256]::Create()
  try {
    return ([System.BitConverter]::ToString($sha.ComputeHash($bytes)) -replace '-', '')
  } finally {
    $sha.Dispose()
  }
}

function Restore-DelphiReference {
  # Copies a stored reference whose fingerprint matches into the Delphi output
  # files of this run; answers whether it did.
  param([string]$Directory, [string]$Fingerprint, [string]$Observations, [string]$RtlCharacters)
  $names = @("fingerprint.txt", "delphi-version.txt", "observations.txt", "rtl-characters.txt")
  foreach ($name in $names) {
    if (-not (Test-Path -LiteralPath (Join-Path $Directory $name))) {
      return $false
    }
  }
  $stored = (Get-Content -LiteralPath (Join-Path $Directory "fingerprint.txt") | Select-Object -First 1)
  if ($stored -ne $Fingerprint) {
    return $false
  }
  Copy-Item -LiteralPath (Join-Path $Directory "observations.txt") -Destination $Observations -Force
  Copy-Item -LiteralPath (Join-Path $Directory "rtl-characters.txt") -Destination $RtlCharacters -Force
  return $true
}

function Save-DelphiReference {
  # Stores the reference of this run; the fingerprint is written LAST, so an
  # interrupted save never looks like a complete reference.
  param([string]$Directory, [string]$Fingerprint, [string]$Version, [string]$Observations, [string]$RtlCharacters)
  Remove-Item -LiteralPath (Join-Path $Directory "fingerprint.txt") -Force -ErrorAction SilentlyContinue
  Copy-Item -LiteralPath $Observations -Destination (Join-Path $Directory "observations.txt") -Force
  Copy-Item -LiteralPath $RtlCharacters -Destination (Join-Path $Directory "rtl-characters.txt") -Force
  Write-LfAsciiFile -Path (Join-Path $Directory "delphi-version.txt") -Lines @($Version)
  Write-LfAsciiFile -Path (Join-Path $Directory "fingerprint.txt") -Lines @($Fingerprint)
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

# Both compilers are looked up before either may skip the check, so a
# -RequireFpc or -RequireDelphi failure is raised even when the OTHER compiler
# is missing too; the required failures come first, then the soft skips.
$fpc = Resolve-FpcToolchain -Toolchain $Toolchain -FpcPath $FpcPath -MacHost $MacHost
$toolchainLabel = $Toolchain
if (-not [string]::IsNullOrWhiteSpace($FpcPath)) {
  $toolchainLabel = "$Toolchain, $FpcPath"
}
$fpcMissingMessage = "FreePascal toolchain '$toolchainLabel' not reachable; skipping the FPC runtime check."
$dcc64 = Join-Path $StudioRoot "bin\dcc64.exe"
$delphiMissingMessage = "Delphi command line compiler not found at '$dcc64'; skipping the FPC runtime check (no reference build)."
$fpcMissing = [string]::IsNullOrWhiteSpace($fpc)
$delphiMissing = -not (Test-Path -LiteralPath $dcc64)

if ($fpcMissing -and $RequireFpc) {
  throw $fpcMissingMessage
}
if ($delphiMissing -and $RequireDelphi) {
  throw $delphiMissingMessage
}
if ($fpcMissing) {
  Write-Warning $fpcMissingMessage
  return
}
if ($delphiMissing) {
  Write-Warning $delphiMissingMessage
  return
}
# The options of the Delphi reference build; part of the -ReferenceDir
# fingerprint. The output directories are added at the call and do not change
# what the build produces.
$dccOptions = @("-B", "-Q", '-$R+', '-$Q+', "-U$sourceDir")

if ([string]::IsNullOrWhiteSpace($FpcPath)) {
  Write-Info "FPC runtime check ($Toolchain)"
} else {
  Write-Info "FPC runtime check ($Toolchain, $FpcPath)"
}

if (Test-Path -LiteralPath $scratchDir) {
  Remove-Item -LiteralPath $scratchDir -Recurse -Force
}
[void](New-Item -ItemType Directory -Path $scratchDir -Force)
$delphiDir = Join-Path $scratchDir "delphi"
$fpcDir = Join-Path $scratchDir "fpc"
[void](New-Item -ItemType Directory -Path (Join-Path $delphiDir "dcu") -Force)
[void](New-Item -ItemType Directory -Path $fpcDir -Force)

$driverInput = Join-Path $scratchDir "driver_input.txt"
$delphiOutput = Join-Path $delphiDir "observations.txt"
$fpcOutput = Join-Path $fpcDir "observations.txt"
# The RTL character category sweep; see "RTL character data" in the driver
# header. Compared and reported, never a failure.
$delphiRtl = Join-Path $delphiDir "rtl-characters.txt"
$fpcRtl = Join-Path $fpcDir "rtl-characters.txt"

$succeeded = $false
$watch = [System.Diagnostics.Stopwatch]::new()
try {
  $records = Write-DriverInput -Path $driverInput
  Write-Info ("  input file : {0} records from {1} and {2}" -f $records, $aytfJson, $referenceJson)

  # ---- Delphi reference ---------------------------------------------------
  $watch.Restart()
  $referenceFingerprint = ""
  $reused = $false
  if (-not [string]::IsNullOrWhiteSpace($ReferenceDir)) {
    $ReferenceDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($ReferenceDir)
    [void](New-Item -ItemType Directory -Path $ReferenceDir -Force)
    $referenceFingerprint = Get-ReferenceFingerprint -DriverInput $driverInput -Compiler $dcc64 -Options $dccOptions
    $reused = Restore-DelphiReference -Directory $ReferenceDir -Fingerprint $referenceFingerprint `
      -Observations $delphiOutput -RtlCharacters $delphiRtl
  }
  if ($reused) {
    $delphiVersion = (Get-Content -LiteralPath (Join-Path $ReferenceDir "delphi-version.txt") | Select-Object -First 1)
    Write-Info ("  Delphi     : {0}" -f $delphiVersion)
    Write-Info ("               reference reused from {0}" -f $ReferenceDir)
  } else {
    $build = Invoke-Native $dcc64 ($dccOptions + @(("-NU" + (Join-Path $delphiDir "dcu")), "-E$delphiDir", $driverFile))
    $delphiVersion = ($build.Output | Select-Object -First 1)
    if ($build.ExitCode -ne 0) {
      $build.Output | ForEach-Object { Write-Host "    $_" }
      throw "dcc64 failed for $driverFile (exit code $($build.ExitCode))."
    }
    $run = Invoke-Native (Join-Path $delphiDir ($driverName + ".exe")) @($driverInput, $delphiOutput, $delphiRtl)
    if ($run.ExitCode -ne 0) {
      $run.Output | ForEach-Object { Write-Host "    $_" }
      throw "The Delphi build of the driver failed (exit code $($run.ExitCode))."
    }
    $delphiSeconds = $watch.Elapsed.TotalSeconds
    Write-Info ("  Delphi     : {0}" -f $delphiVersion)
    Write-Info ("               build + run {0:N1} s" -f $delphiSeconds)
    if ($referenceFingerprint -ne "") {
      Save-DelphiReference -Directory $ReferenceDir -Fingerprint $referenceFingerprint -Version $delphiVersion `
        -Observations $delphiOutput -RtlCharacters $delphiRtl
    }
  }

  # ---- FreePascal ---------------------------------------------------------
  $watch.Restart()
  switch ($Toolchain) {
    "Native" {
      $fpcVersion = Get-NativeFpcDescription $fpc
      $unitsDir = Join-Path $fpcDir "units"
      [void](New-Item -ItemType Directory -Path $unitsDir -Force)
      $build = Invoke-Native $fpc ($fpcOptions + @("-FU$unitsDir", "-FE$fpcDir", "-Fu$sourceDir", $driverFile))
      $problems = Get-FpcProblems $build.Output
      if ($build.ExitCode -ne 0 -or $problems.Count -gt 0) {
        $build.Output | ForEach-Object { Write-Host "    $_" }
        throw "The FreePascal build of the driver failed (exit code $($build.ExitCode), $($problems.Count) error/warning line(s))."
      }
      $run = Invoke-Native (Join-Path $fpcDir ($driverName + ".exe")) @($driverInput, $fpcOutput, $fpcRtl)
      if ($run.ExitCode -ne 0) {
        $run.Output | ForEach-Object { Write-Host "    $_" }
        throw "The FreePascal build of the driver failed at run time (exit code $($run.ExitCode))."
      }
    }
    "Wsl" {
      $unixScript = Join-Path $scratchDir "build_and_run.sh"
      Write-UnixScript -Path $unixScript
      $result = Invoke-Native "wsl.exe" @("-e", "sh", (ConvertTo-WslPath $unixScript), $fpc,
        (ConvertTo-WslPath $sourceDir), (ConvertTo-WslPath $driverDir),
        (ConvertTo-WslPath $fpcDir), (ConvertTo-WslPath $driverInput))
      if ($result.ExitCode -ne 0) {
        $result.Output | ForEach-Object { Write-Host "    $_" }
        throw "The WSL FreePascal build or run failed (exit code $($result.ExitCode))."
      }
      $buildLog = @(Get-Content -LiteralPath (Join-Path $fpcDir "build.log"))
      $problems = Get-FpcProblems $buildLog
      if ($problems.Count -gt 0) {
        $buildLog | ForEach-Object { Write-Host "    $_" }
        throw "The FreePascal build of the driver reported $($problems.Count) error/warning line(s)."
      }
      $info = @(Get-Content -LiteralPath (Join-Path $fpcDir "fpc-info.txt"))
      $fpcVersion = "{0} ({1}-{2})" -f $info[0], $info[1], $info[2]
    }
    "Mac" {
      $unixScript = Join-Path $scratchDir "build_and_run.sh"
      Write-UnixScript -Path $unixScript

      # One archive with exactly what the remote build needs: the hand written
      # and generated units of src/, the driver, the generated input file and
      # the build script.
      $stage = Join-Path $scratchDir "mac-stage"
      [void](New-Item -ItemType Directory -Path (Join-Path $stage "src") -Force)
      [void](New-Item -ItemType Directory -Path (Join-Path $stage "driver") -Force)
      Copy-Item -Path (Join-Path $sourceDir "*.pas") -Destination (Join-Path $stage "src")
      Copy-Item -LiteralPath $driverFile -Destination (Join-Path $stage "driver")
      Copy-Item -LiteralPath $driverInput -Destination $stage
      Copy-Item -LiteralPath $unixScript -Destination $stage

      $remoteRun = New-MacRunDirectory -MacHost $MacHost -Prefix "libphonenumber"
      Send-MacStage -MacHost $MacHost -RemoteRun $remoteRun -StageDir $stage -ScratchDir $scratchDir
      $remoteCommand = ("cd $remoteRun && " +
        "sh build_and_run.sh $(ConvertTo-RemoteShellWord $fpc) `"`$PWD/src`" `"`$PWD/driver`" `"`$PWD/out`" `"`$PWD/driver_input.txt`"")
      $result = Invoke-Native "ssh" @($MacHost, $remoteCommand)
      if ($result.ExitCode -ne 0) {
        $result.Output | ForEach-Object { Write-Host "    $_" }
        throw "The Mac FreePascal build or run failed (exit code $($result.ExitCode)); run kept at ~/$remoteRun."
      }
      foreach ($name in @("observations.txt", "rtl-characters.txt", "build.log", "fpc-info.txt")) {
        [void](Receive-MacFile -MacHost $MacHost -RemoteRun $remoteRun -RelativePath "out/$name" `
          -Destination (Join-Path $fpcDir $name))
      }
      $problems = Get-FpcProblems @(Get-Content -LiteralPath (Join-Path $fpcDir "build.log"))
      if ($problems.Count -gt 0) {
        Get-Content -LiteralPath (Join-Path $fpcDir "build.log") | ForEach-Object { Write-Host "    $_" }
        throw "The FreePascal build of the driver reported $($problems.Count) error/warning line(s)."
      }
      $info = @(Get-Content -LiteralPath (Join-Path $fpcDir "fpc-info.txt"))
      $fpcVersion = "{0} ({1}-{2}), run ~/{3}" -f $info[0], $info[1], $info[2], $remoteRun
    }
  }
  $fpcSeconds = $watch.Elapsed.TotalSeconds
  Write-Info ("  FreePascal : {0} via {1}" -f $fpcVersion, $fpc)
  Write-Info ("               build + run {0:N1} s" -f $fpcSeconds)

  # ---- Compare -------------------------------------------------------------
  if (-not (Test-Path -LiteralPath $fpcOutput)) {
    throw "The FreePascal build produced no observation file: $fpcOutput"
  }
  # Byte for byte: same length and same SHA-256.
  $delphiSize = (Get-Item -LiteralPath $delphiOutput).Length
  $identical = ($delphiSize -eq (Get-Item -LiteralPath $fpcOutput).Length) -and
    ((Get-FileHash -LiteralPath $delphiOutput -Algorithm SHA256).Hash -eq
      (Get-FileHash -LiteralPath $fpcOutput -Algorithm SHA256).Hash)

  $delphiLines = [System.IO.File]::ReadAllLines($delphiOutput)
  $summaryLine = $delphiLines | Where-Object { $_.StartsWith("summary|") } | Select-Object -Last 1
  Write-Info ("  compared   : {0} lines, {1} bytes" -f $delphiLines.Count, $delphiSize)
  Write-Info ("  summary    : {0}" -f $summaryLine)

  # Evaluated on the REFERENCE summary and reported together with a byte
  # difference, so neither hides the other. Identical is not enough either: both builds could agree on an exception, on a
  # pattern that does not compile, or on having observed nothing at all.
  $summary = @{}
  foreach ($field in @($summaryLine -split '\|' | Select-Object -Skip 1)) {
    $pair = $field -split '=', 2
    if ($pair.Count -eq 2) {
      $summary[$pair[0]] = [int64]$pair[1]
    }
  }
  # rewriteMismatches / expansionProbeFailures: the counted quantifier rewrite
  # is the SAME code in both builds, so only these in-run assertions can catch
  # a rewriter defect; the byte comparison alone would let it through.
  $mustBeZero = @("exceptions", "patternFailures", "metadataPatternsOverBudget",
    "rewriteMismatches", "expansionProbeFailures")
  # The facade and matcher counters (since the facade became FreePascal
  # clean): every one of those sections must have observed something too.
  $mustBePositive = @("productionExamples", "testingExamples", "shortExamples",
    "aytfSequences", "patternsCompiled", "regexProbes",
    "facadeProductionExamples", "facadeTestingExamples", "facadeTerritories",
    "parseInputs", "parseSuccesses", "referenceCases", "mobileDialingCases",
    "keepingAlphaCases", "matcherTexts", "matcherCalls", "matchesFound")
  $violations = @()
  foreach ($name in $mustBeZero) {
    if (-not $summary.ContainsKey($name)) {
      $violations += "$name missing"
    } elseif ($summary[$name] -ne 0) {
      $violations += "$name=$($summary[$name])"
    }
  }
  foreach ($name in $mustBePositive) {
    if (-not $summary.ContainsKey($name)) {
      $violations += "$name missing"
    } elseif ($summary[$name] -le 0) {
      $violations += "$name=$($summary[$name])"
    }
  }
  $violationMessage = ""
  if ($violations.Count -gt 0) {
    $violationMessage = (("FPC runtime check failed: the summary violates the gate ({0}). Exceptions, pattern failures, rewrite mismatches and " +
      "over-budget metadata patterns are never acceptable, even when both builds agree, and a section that " +
      "observed nothing would make the comparison vacuous.") -f ($violations -join ", "))
    Write-Host ("  summary violations: {0}" -f ($violations -join ", "))
  }

  if (-not $identical) {
    $fpcLines = [System.IO.File]::ReadAllLines($fpcOutput)
    $count = [Math]::Max($delphiLines.Count, $fpcLines.Count)
    $differences = 0
    for ($i = 0; $i -lt $count; $i++) {
      $left = if ($i -lt $delphiLines.Count) { $delphiLines[$i] } else { "<missing>" }
      $right = if ($i -lt $fpcLines.Count) { $fpcLines[$i] } else { "<missing>" }
      if ($left -ceq $right) {
        continue
      }
      $differences++
      if ($differences -le $MaxDiffLines) {
        Write-Host ("  line {0}:" -f ($i + 1))
        if ($i -gt 0 -and $i - 1 -lt $delphiLines.Count) {
          Write-Host ("    context: {0}" -f $delphiLines[$i - 1])
        }
        Write-Host ("    delphi : {0}" -f $left)
        Write-Host ("    fpc    : {0}" -f $right)
      }
    }
    Write-Host ("  {0} differing line(s) (Delphi {1} lines, FreePascal {2} lines)." -f
      $differences, $delphiLines.Count, $fpcLines.Count)
    Write-Host ("  Both observation files are kept in {0}" -f $scratchDir)
    $message = "FPC runtime check failed: the FreePascal build behaves differently from the Delphi build."
    if ($violationMessage -ne "") {
      $message += " " + $violationMessage
    }
    throw $message
  }

  if ($violationMessage -ne "") {
    Write-Host ("  Both observation files are kept in {0}" -f $scratchDir)
    throw $violationMessage
  }

  # ---- RTL character data (reported, not a failure) -------------------------
  # The open Unicode categories L and N come from the RTL of each compiler, and
  # the two ship different Unicode versions. A difference here is the Unicode
  # version delta of the two RTLs, not a defect of the port; it is printed on
  # every run so it stays visible, and documented in KNOWN_ISSUES.md.
  $rtlLeft = [System.IO.File]::ReadAllLines($delphiRtl)
  $rtlRight = [System.IO.File]::ReadAllLines($fpcRtl)
  $onlyDelphi = @($rtlLeft | Where-Object { $rtlRight -cnotcontains $_ })
  $onlyFpc = @($rtlRight | Where-Object { $rtlLeft -cnotcontains $_ })
  if ($onlyDelphi.Count -eq 0 -and $onlyFpc.Count -eq 0) {
    Write-Info ("  RTL Unicode: identical ({0} category ranges)" -f $rtlLeft.Count)
  } else {
    Write-Warning ("RTL Unicode data differs between Delphi and FreePascal (letter/number categories of UNWANTED_END_CHARS): " +
      "{0} range line(s) only in the Delphi sweep, {1} only in the FreePascal sweep. Not a port defect; see KNOWN_ISSUES.md." -f
      $onlyDelphi.Count, $onlyFpc.Count)
    foreach ($line in $onlyDelphi) { Write-Info ("    delphi only: {0}" -f $line) }
    foreach ($line in $onlyFpc) { Write-Info ("    fpc only   : {0}" -f $line) }
  }

  $succeeded = $true
  Write-Info "FPC runtime check passed: the Delphi and the FreePascal build are byte identical."
} finally {
  if ($KeepWorkDir) {
    Write-Info ("  work directory kept: {0}" -f $scratchDir)
  } elseif ($succeeded -and (Test-Path -LiteralPath $scratchDir)) {
    # Windows can still hold the handle of a process that just exited; retry a
    # few times instead of failing a green run over a leftover scratch file.
    for ($attempt = 1; $attempt -le 5 -and (Test-Path -LiteralPath $scratchDir); $attempt++) {
      Remove-Item -LiteralPath $scratchDir -Recurse -Force -ErrorAction SilentlyContinue
      if (Test-Path -LiteralPath $scratchDir) {
        [System.Threading.Thread]::Sleep(200)
      }
    }
  } elseif (-not $succeeded -and (Test-Path -LiteralPath $scratchDir)) {
    Write-Info ("  work directory kept for inspection: {0}" -f $scratchDir)
  }
}
