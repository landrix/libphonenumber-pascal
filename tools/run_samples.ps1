param(
  # Which compiler builds the samples:
  #   Delphi - dcc64 of the installation at -StudioRoot
  #   Fpc    - FreePascal of -Toolchain (tools/fpc_toolchains.ps1):
  #            Wsl    FreePascal inside WSL (default compiler
  #                   ~/fpc-3.2.4/bin/fpc of the WSL user, override with
  #                   -FpcPath)
  #            Native the FreePascal on PATH of this machine (or -FpcPath):
  #                   Windows, or Linux/macOS when this script runs under pwsh
  #                   there (CI)
  #            Mac    the shared Mac toolchain behind the ssh alias -MacHost
  [ValidateSet("Delphi", "Fpc")]
  [string]$Compiler = "Delphi",
  [ValidateSet("Wsl", "Native", "Mac")]
  [string]$Toolchain = "Wsl",
  [string]$FpcPath = "",
  [string]$MacHost = "macos-tests",
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  # Restrict the run to these samples (program names without .dpr). Default:
  # every samples/*.dpr.
  [string[]]$Sample = @(),
  # Rewrite samples/expected/<name>.txt with the output of this run instead of
  # comparing against it. Review the diff before committing it.
  [switch]$UpdateExpected,
  # PARENT directory of the scratch space. The script creates and removes only
  # its own uniquely named subdirectory below it and never deletes the
  # directory it was given.
  [string]$WorkDir = "",
  [int]$MaxDiffLines = 20,
  [switch]$RequireFpc,
  [switch]$RequireDelphi,
  [switch]$KeepWorkDir,
  [switch]$Quiet
)

<#
  Builds every sample program of samples/ with one compiler, runs it and
  compares its standard output with the expected output in
  samples/expected/<name>.txt (the "golden" file).

  The golden files are the exact output of the programs: ASCII only, LF line
  ends. The comparison turns CRLF into LF on both sides first, because a
  Delphi program on Windows writes CRLF and a Windows checkout may convert the
  golden files (.gitattributes pins them to LF, the normalisation makes the
  check independent of that). Everything else must match byte for byte, the
  final line end included. Output that is not pure ASCII fails the run: the
  Delphi console best fit maps non ASCII text through the ANSI code page, so
  such output would differ between the compilers by construction.

  A sample fails when it does not build, when the build reports a warning or
  an error (hints and notes are tolerated), when it exits with a non zero exit
  code, or when its output differs from the golden file. The same golden files
  hold for every compiler; that is the point of the check.

  Like the FreePascal gates the script is a no-op with a warning when the
  selected compiler is not reachable; -RequireFpc / -RequireDelphi turn that
  into a failure.

  Build options. Delphi: dcc64 -Q -$R+ -$Q+ -U<src>. FreePascal: -Mdelphi -Sh
  -Cr -Co -Fu<src> (the command line of samples/README.md plus range and
  overflow checking). Units go to a fresh scratch directory per run, so
  nothing is left in the repository.

  Mac mode copies src/, samples/ and a build script into a fresh run directory
  ~/remote-toolchains/macos-fpc/runs/libphonenumber-samples-<utc>-<id>/ on
  -MacHost, builds and runs there and copies the results back. Remote runs are
  kept for review, as the toolchain README asks.
#>

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "fpc_toolchains.ps1")

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot "src"
$samplesDir = Join-Path $repoRoot "samples"
$expectedDir = Join-Path $samplesDir "expected"

$fpcOptions = @("-Mdelphi", "-Sh", "-Cr", "-Co")
$dccOptions = @("-Q", '-$R+', '-$Q+', "-U$sourceDir")

function Write-Info {
  param([string]$Message)
  if (-not $Quiet) {
    Write-Host $Message
  }
}

# --- The samples -------------------------------------------------------------

$allSamples = @(Get-ChildItem -LiteralPath $samplesDir -Filter "*.dpr" -File |
  Sort-Object Name | ForEach-Object { [System.IO.Path]::GetFileNameWithoutExtension($_.Name) })
if ($allSamples.Count -eq 0) {
  throw "No sample programs found in $samplesDir."
}
if ($Sample.Count -gt 0) {
  $names = @()
  foreach ($entry in $Sample) {
    foreach ($part in @("$entry" -split ',')) {
      $name = $part.Trim()
      if ($name -eq "") {
        continue
      }
      $known = $allSamples | Where-Object { $_ -eq $name } | Select-Object -First 1
      if ($null -eq $known) {
        throw "Unknown sample '$name' (known: $($allSamples -join ', '))."
      }
      $names += $known
    }
  }
  if ($names.Count -eq 0) {
    throw "-Sample selects no sample."
  }
} else {
  $names = $allSamples
  # A golden file without a program is a leftover of a renamed or removed
  # sample.
  if (Test-Path -LiteralPath $expectedDir) {
    $orphans = @(Get-ChildItem -LiteralPath $expectedDir -Filter "*.txt" -File | Where-Object {
      $allSamples -notcontains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) })
    if ($orphans.Count -gt 0) {
      throw "Golden file(s) without a sample program: $(($orphans | ForEach-Object { $_.Name }) -join ', ')."
    }
  }
}
if (-not $UpdateExpected) {
  foreach ($name in $names) {
    $golden = Join-Path $expectedDir ($name + ".txt")
    if (-not (Test-Path -LiteralPath $golden)) {
      throw "Golden file missing: $golden (create it with -UpdateExpected)."
    }
  }
}

# --- The compiler ------------------------------------------------------------

if ($Compiler -eq "Delphi") {
  $compilerLabel = "Delphi"
  $dcc64 = Join-Path $StudioRoot "bin\dcc64.exe"
  if (-not (Test-Path -LiteralPath $dcc64)) {
    Skip-OrFail "Delphi command line compiler not found at '$dcc64'; skipping the samples on Delphi." $RequireDelphi
    return
  }
} else {
  $compilerLabel = "FreePascal $Toolchain"
  if (-not [string]::IsNullOrWhiteSpace($FpcPath)) {
    $compilerLabel = "FreePascal $Toolchain, $FpcPath"
  }
  $fpc = Resolve-FpcToolchain -Toolchain $Toolchain -FpcPath $FpcPath -MacHost $MacHost
  if ([string]::IsNullOrWhiteSpace($fpc)) {
    Skip-OrFail "FreePascal toolchain '$($compilerLabel.Substring(11))' not reachable; skipping the samples on FreePascal." $RequireFpc
    return
  }
}

if ([string]::IsNullOrWhiteSpace($WorkDir)) {
  $WorkDir = [System.IO.Path]::GetTempPath()
}
$WorkDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($WorkDir)
$scratchDir = Join-Path $WorkDir ("libphonenumber-samples-{0}" -f $PID)

function Invoke-Capture {
  # Runs a program and returns its standard output as raw bytes, its standard
  # error as text and its exit code. Raw bytes, because the comparison is byte
  # exact and a text decoder would hide a non ASCII byte or a line end.
  param([string]$FilePath)
  $info = New-Object System.Diagnostics.ProcessStartInfo
  $info.FileName = $FilePath
  $info.UseShellExecute = $false
  $info.RedirectStandardOutput = $true
  $info.RedirectStandardError = $true
  $info.WorkingDirectory = Split-Path -Parent $FilePath
  $process = [System.Diagnostics.Process]::Start($info)
  $errorTask = $process.StandardError.ReadToEndAsync()
  $buffer = New-Object System.IO.MemoryStream
  $process.StandardOutput.BaseStream.CopyTo($buffer)
  $process.WaitForExit()
  return [pscustomobject]@{
    Output   = $buffer.ToArray()
    Error    = $errorTask.Result
    ExitCode = $process.ExitCode
  }
}

function Write-UnixScript {
  # The build and run step of the Wsl and the Mac mode, run as
  # "sh <script> <args>" so no $-containing one liner has to survive
  # PowerShell, wsl.exe or ssh quoting. Per sample it leaves
  # <name>.build.log, <name>.build.exit and, when the build produced a
  # program, <name>.out, <name>.err and <name>.run.exit in the output
  # directory.
  param([string]$Path)
  $options = $fpcOptions -join " "
  $lines = @(
    '#!/bin/sh',
    '# Generated by tools/run_samples.ps1.',
    '# Arguments: <fpc> <source dir> <samples dir> <output dir> <sample names...>',
    'fpc="$1"; src="$2"; samples="$3"; out="$4"; shift 4',
    '# Units and programs go to a temporary directory of the build machine:',
    '# under WSL the output directory is a Windows path, and writing the units',
    '# through it is several times slower.',
    'work=$(mktemp -d) || exit 2',
    'mkdir -p "$work/units" "$work/bin" "$out" || exit 2',
    '{ "$fpc" -iV; "$fpc" -iTP; "$fpc" -iTO; } > "$out/fpc-info.txt" 2>&1',
    'for name in "$@"; do',
    ('  "$fpc" ' + $options + ' -FU"$work/units" -FE"$work/bin" -Fu"$src" "$samples/$name.dpr" > "$out/$name.build.log" 2>&1'),
    '  echo $? > "$out/$name.build.exit"',
    '  if [ -x "$work/bin/$name" ]; then',
    '    "$work/bin/$name" > "$out/$name.out" 2> "$out/$name.err"',
    '    echo $? > "$out/$name.run.exit"',
    '  fi',
    'done',
    'rm -rf "$work"',
    'exit 0'
  )
  Write-LfAsciiFile -Path $Path -Lines $lines
}

function Get-BuildProblems {
  param([string[]]$BuildOutput)
  if ($Compiler -eq "Delphi") {
    # dcc64 localises its message words ("Warning", "Warnung", ...), not the
    # message codes: W1234 / E1234 / F1234 are warnings, errors and fatals,
    # H1234 hints are tolerated.
    return @($BuildOutput | Where-Object { $_ -cmatch '\b[WEF]\d{4}\b' })
  }
  return Get-FpcProblems $BuildOutput
}

function Read-ResultFile {
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path)) {
    return $null
  }
  return [System.IO.File]::ReadAllText($Path).Trim()
}

if (Test-Path -LiteralPath $scratchDir) {
  Remove-Item -LiteralPath $scratchDir -Recurse -Force
}
[void](New-Item -ItemType Directory -Path $scratchDir -Force)
$outDir = Join-Path $scratchDir "out"
$binDir = Join-Path $outDir "bin"
$unitDir = Join-Path $outDir "units"
[void](New-Item -ItemType Directory -Path $binDir -Force)
[void](New-Item -ItemType Directory -Path $unitDir -Force)

$succeeded = $false
$watch = [System.Diagnostics.Stopwatch]::StartNew()
try {
  # One result per sample: the build output, whether the build succeeded, and
  # the run (output bytes, standard error, exit code) when there was one.
  $results = [ordered]@{}
  switch ("$Compiler/$Toolchain") {
    { $Compiler -eq "Delphi" } {
      $compilerDescription = "dcc64 at $dcc64"
      foreach ($name in $names) {
        $build = Invoke-Native $dcc64 ($dccOptions + @("-NU$unitDir", "-E$binDir",
          (Join-Path $samplesDir ($name + ".dpr"))))
        $result = [pscustomobject]@{ Build = $build.Output; Built = ($build.ExitCode -eq 0); Run = $null }
        $exe = Join-Path $binDir ($name + ".exe")
        if ($result.Built -and (Test-Path -LiteralPath $exe)) {
          $result.Run = Invoke-Capture $exe
        }
        $results[$name] = $result
      }
      break
    }
    "Fpc/Native" {
      $compilerDescription = "{0} via {1}" -f (Get-NativeFpcDescription $fpc), $fpc
      foreach ($name in $names) {
        $build = Invoke-Native $fpc ($fpcOptions + @("-FU$unitDir", "-FE$binDir", "-Fu$sourceDir",
          (Join-Path $samplesDir ($name + ".dpr"))))
        $result = [pscustomobject]@{ Build = $build.Output; Built = ($build.ExitCode -eq 0); Run = $null }
        $exe = Join-Path $binDir $name
        if (Test-Path -LiteralPath ($exe + ".exe")) {
          $exe = $exe + ".exe"
        }
        if ($result.Built -and (Test-Path -LiteralPath $exe)) {
          $result.Run = Invoke-Capture $exe
        }
        $results[$name] = $result
      }
      break
    }
    default {
      # Wsl and Mac: one shell script builds and runs every sample; the
      # results come back as files.
      $unixScript = Join-Path $scratchDir "build_and_run.sh"
      Write-UnixScript -Path $unixScript
      if ($Toolchain -eq "Wsl") {
        $step = Invoke-Native "wsl.exe" (@("-e", "sh", (ConvertTo-WslPath $unixScript), $fpc,
          (ConvertTo-WslPath $sourceDir), (ConvertTo-WslPath $samplesDir),
          (ConvertTo-WslPath $outDir)) + $names)
        if ($step.ExitCode -ne 0) {
          $step.Output | ForEach-Object { Write-Host "    $_" }
          throw "The WSL build script failed (exit code $($step.ExitCode))."
        }
        $runLocation = ""
      } else {
        $stage = Join-Path $scratchDir "mac-stage"
        foreach ($dir in @("src", "samples")) {
          [void](New-Item -ItemType Directory -Path (Join-Path $stage $dir) -Force)
        }
        Copy-Item -Path (Join-Path $sourceDir "*.pas") -Destination (Join-Path $stage "src")
        Copy-Item -Path (Join-Path $samplesDir "*.dpr") -Destination (Join-Path $stage "samples")
        Copy-Item -LiteralPath $unixScript -Destination $stage
        $remoteRun = New-MacRunDirectory -MacHost $MacHost -Prefix "libphonenumber-samples"
        Send-MacStage -MacHost $MacHost -RemoteRun $remoteRun -StageDir $stage -ScratchDir $scratchDir
        $remoteCommand = ("cd $remoteRun && sh build_and_run.sh $(ConvertTo-RemoteShellWord $fpc) " +
          "`"`$PWD/src`" `"`$PWD/samples`" `"`$PWD/out`" " + ($names -join " ") +
          " && tar -czf out.tar.gz -C out .")
        $step = Invoke-Native "ssh" @($MacHost, $remoteCommand)
        if ($step.ExitCode -ne 0) {
          $step.Output | ForEach-Object { Write-Host "    $_" }
          throw "The Mac build script failed (exit code $($step.ExitCode)); run kept at ~/$remoteRun."
        }
        $archive = Join-Path $scratchDir "out.tar.gz"
        [void](Receive-MacFile -MacHost $MacHost -RemoteRun $remoteRun -RelativePath "out.tar.gz" -Destination $archive)
        $unpack = Invoke-Native "tar.exe" @("-xzf", $archive, "-C", $outDir)
        if ($unpack.ExitCode -ne 0) {
          throw "Unpacking the Mac results failed: $($unpack.Output -join ' ')"
        }
        $runLocation = ", run ~/$remoteRun"
      }
      $info = @(Get-Content -LiteralPath (Join-Path $outDir "fpc-info.txt"))
      $compilerDescription = "{0} ({1}-{2}) via {3}{4}" -f $info[0], $info[1], $info[2], $fpc, $runLocation
      foreach ($name in $names) {
        $buildLog = Join-Path $outDir ($name + ".build.log")
        $build = @()
        if (Test-Path -LiteralPath $buildLog) {
          $build = @(Get-Content -LiteralPath $buildLog)
        }
        $result = [pscustomobject]@{ Build = $build; Built = ((Read-ResultFile (Join-Path $outDir ($name + ".build.exit"))) -eq "0"); Run = $null }
        $runExit = Read-ResultFile (Join-Path $outDir ($name + ".run.exit"))
        if ($result.Built -and $null -ne $runExit) {
          $result.Run = [pscustomobject]@{
            Output   = [System.IO.File]::ReadAllBytes((Join-Path $outDir ($name + ".out")))
            Error    = [System.IO.File]::ReadAllText((Join-Path $outDir ($name + ".err")))
            ExitCode = [int]$runExit
          }
        }
        $results[$name] = $result
      }
    }
  }

  Write-Info "Samples on $compilerLabel"
  Write-Info "  compiler: $compilerDescription"

  $failures = @()
  $updated = 0
  foreach ($name in $names) {
    $result = $results[$name]
    $problems = Get-BuildProblems $result.Build
    if (-not $result.Built -or $problems.Count -gt 0) {
      $result.Build | ForEach-Object { Write-Host "    $_" }
      $failures += "$name (build)"
      continue
    }
    if ($null -eq $result.Run) {
      $failures += "$name (no program)"
      continue
    }
    if ($result.Run.ExitCode -ne 0 -or -not [string]::IsNullOrEmpty($result.Run.Error)) {
      Write-Host "  ${name}: exit code $($result.Run.ExitCode)"
      if (-not [string]::IsNullOrEmpty($result.Run.Error)) {
        Write-Host "    stderr: $($result.Run.Error.Trim())"
      }
      $failures += "$name (run)"
      continue
    }
    $bytes = $result.Run.Output
    # Printable ASCII plus TAB, LF and CR only: a control character would
    # survive the comparison unnoticed in a diff and in a golden file.
    $nonAscii = @($bytes | Where-Object { $_ -gt 126 -or ($_ -lt 32 -and $_ -ne 9 -and $_ -ne 10 -and $_ -ne 13) }).Count
    if ($nonAscii -gt 0) {
      Write-Host "  ${name}: $nonAscii byte(s) of the output are not printable ASCII"
      $failures += "$name (non ASCII output)"
      continue
    }
    $actual = [System.Text.Encoding]::ASCII.GetString($bytes).Replace("`r`n", "`n")
    [System.IO.File]::WriteAllText((Join-Path $outDir ($name + ".actual.txt")), $actual,
      (New-Object System.Text.ASCIIEncoding))
    $golden = Join-Path $expectedDir ($name + ".txt")

    if ($UpdateExpected) {
      $previous = $null
      if (Test-Path -LiteralPath $golden) {
        $previous = [System.IO.File]::ReadAllText($golden).Replace("`r`n", "`n")
      }
      # Ordinal: PowerShell's -ne is case insensitive and -ceq is linguistic.
      if (-not [string]::Equals($previous, $actual, [System.StringComparison]::Ordinal)) {
        if (-not (Test-Path -LiteralPath $expectedDir)) {
          [void](New-Item -ItemType Directory -Path $expectedDir -Force)
        }
        [System.IO.File]::WriteAllText($golden, $actual, (New-Object System.Text.ASCIIEncoding))
        Write-Info "  ${name}: golden file updated"
        $updated++
      } else {
        Write-Info "  ${name}: golden file unchanged"
      }
      continue
    }

    $expected = [System.IO.File]::ReadAllText($golden).Replace("`r`n", "`n")
    if ([string]::Equals($expected, $actual, [System.StringComparison]::Ordinal)) {
      Write-Info "  ${name}: OK"
      continue
    }
    Write-Host "  ${name}: output differs from samples/expected/$name.txt"
    $expectedLines = $expected -split "`n"
    $actualLines = $actual -split "`n"
    $shown = 0
    $count = [Math]::Max($expectedLines.Count, $actualLines.Count)
    for ($i = 0; $i -lt $count -and $shown -lt $MaxDiffLines; $i++) {
      $e = if ($i -lt $expectedLines.Count) { $expectedLines[$i] } else { "<missing>" }
      $a = if ($i -lt $actualLines.Count) { $actualLines[$i] } else { "<missing>" }
      if (-not [string]::Equals($e, $a, [System.StringComparison]::Ordinal)) {
        Write-Host ("    line {0}" -f ($i + 1))
        Write-Host ("      expected: {0}" -f $e)
        Write-Host ("      actual  : {0}" -f $a)
        $shown++
      }
    }
    $failures += "$name (output)"
  }

  if ($failures.Count -gt 0) {
    throw ("Samples on {0}: {1} of {2} failed: {3}. Work directory kept: {4}" -f
      $compilerLabel, $failures.Count, $names.Count, ($failures -join ", "), $scratchDir)
  }
  $succeeded = $true
  if ($UpdateExpected) {
    Write-Host ("Samples on {0}: {1} built and run, {2} golden file(s) updated ({3:N1} s)." -f
      $compilerLabel, $names.Count, $updated, $watch.Elapsed.TotalSeconds)
  } else {
    Write-Host ("Samples on {0}: {1} built and run, all match samples/expected ({2:N1} s)." -f
      $compilerLabel, $names.Count, $watch.Elapsed.TotalSeconds)
  }
} finally {
  if ($KeepWorkDir) {
    Write-Info ("  work directory kept: {0}" -f $scratchDir)
  } elseif ($succeeded -and (Test-Path -LiteralPath $scratchDir)) {
    for ($attempt = 1; $attempt -le 5 -and (Test-Path -LiteralPath $scratchDir); $attempt++) {
      Remove-Item -LiteralPath $scratchDir -Recurse -Force -ErrorAction SilentlyContinue
      if (Test-Path -LiteralPath $scratchDir) {
        [System.Threading.Thread]::Sleep(200)
      }
    }
  }
}
