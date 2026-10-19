param(
  [string]$FpcPath = "",
  [string]$SourceDir = "",
  [string[]]$Units = @(),
  [string]$WorkDir = "",
  [switch]$RequireFpc,
  [switch]$KeepWorkDir,
  [switch]$Quiet
)

<#
  FreePascal compile check for the library units.

  FreePascal compatibility is a hard requirement of the full parity plan, but a
  working FPC is not guaranteed on every machine. The script is therefore a
  no-op with a warning when no compiler is found; pass -RequireFpc to turn a
  missing compiler into a failure (CI).

  The check compiles for whatever target the installed FPC produces. The point
  is source level compatibility ({$MODE DELPHI}, RTL usage, table shapes), not
  the generated machine code, so the target architecture is irrelevant.

  -WorkDir names the PARENT directory for the compiler output. The script
  creates and removes its own uniquely named subdirectory below it and never
  deletes the directory it was given.
#>

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($SourceDir)) {
  $SourceDir = Join-Path $repoRoot "src"
}
if ($Units.Count -eq 0) {
  # The metadata lookup unit pulls in the three generated units plus the
  # hand written data model, so one entry point covers the whole data layer.
  # The core adds the regex abstraction and the interpreter on top; the
  # interpreter pulls the regex unit in, but it is listed explicitly so a
  # failure names the unit that actually broke.
  #
  # LibPhoneNumber.Types carries the public result record and the
  # CountryCodeSource enum. It has no dependencies of its own and is
  # not reachable from the core, so it needs its own entry.
  #
  # LibPhoneNumber.AsYouTypeFormatter is a stateful class
  # and the only unit that holds a UnicodeString buffer, so it
  # is the most FreePascal sensitive one; it gets its own entry as well.
  #
  # LibPhoneNumber.ShortMetadata pulls in the two generated
  # short number units; LibPhoneNumber.ShortNumberInfo is the port on top
  # of them and reaches into MetadataCore and Regex, so a failure there names
  # the ShortNumberInfo unit rather than one of its dependencies.
  #
  # LibPhoneNumber.TestingMetadata pulls in the three
  # generated TESTING units, which is what puts them under the same compile
  # gate as the production ones. Only the DUnitX test project links it; no unit
  # under src/ references it.
  #
  # LibPhoneNumber.AlternateFormats pulls in the generated
  # alternate format unit. Its only consumer is the matcher; the lookup layer
  # itself has no dependency beyond the data model and gets its own entry so a
  # failure names it.
  #
  # LibPhoneNumber.PhoneNumberUtil is the public facade: the parse driver, isNumberMatch,
  # the record based formatters and the parse based accessory API. It became
  # FreePascal clean in the step that replaced its Delphi only RTL surface
  # (dotted unit names without an FPC switch, string helpers) and moved every
  # length and character test of the parse driver onto the UTF-16 form of its
  # `string` arguments; its unit header documents the FreePascal string
  # contract.
  #
  # LibPhoneNumber.PhoneNumberMatcher is the last unit: its
  # parseAndVerify calls parseAndKeepRawInput and its containsOnlyValidXChars
  # calls isNumberMatch off the facade, so it could only join the list
  # together with the facade. With these two entries every hand written unit
  # of src/ is gated.
  $Units = @(
    "LibPhoneNumber.Types.pas",
    "LibPhoneNumber.Metadata.pas",
    "LibPhoneNumber.Regex.pas",
    "LibPhoneNumber.MetadataCore.pas",
    "LibPhoneNumber.MetadataFormat.pas",
    "LibPhoneNumber.AsYouTypeFormatter.pas",
    "LibPhoneNumber.ShortMetadata.pas",
    "LibPhoneNumber.ShortNumberInfo.pas",
    "LibPhoneNumber.TestingMetadata.pas",
    "LibPhoneNumber.AlternateFormats.pas",
    "LibPhoneNumber.PhoneNumberUtil.pas",
    "LibPhoneNumber.PhoneNumberMatcher.pas"
  )
}
# The scratch directory is created and deleted recursively, so it must never be
# a path the caller cares about. -WorkDir therefore names a PARENT directory;
# the script appends its own uniquely named subdirectory and only ever touches
# that one. The process id in the name also keeps concurrent runs apart.
if ([string]::IsNullOrWhiteSpace($WorkDir)) {
  $WorkDir = [System.IO.Path]::GetTempPath()
}
$scratchDir = Join-Path $WorkDir ("libphonenumber-fpccheck-{0}" -f $PID)

function Write-Info {
  param([string]$Message)
  if (-not $Quiet) {
    Write-Host $Message
  }
}

function Resolve-Fpc {
  param([string]$Explicit)

  if (-not [string]::IsNullOrWhiteSpace($Explicit)) {
    if (-not (Test-Path -LiteralPath $Explicit)) {
      throw "FreePascal compiler not found at -FpcPath '$Explicit'."
    }
    return (Resolve-Path -LiteralPath $Explicit).Path
  }

  $command = Get-Command -Name "fpc" -CommandType Application -ErrorAction SilentlyContinue |
    Select-Object -First 1
  if ($null -ne $command) {
    return $command.Source
  }
  return ""
}

$fpc = Resolve-Fpc -Explicit $FpcPath
if ([string]::IsNullOrWhiteSpace($fpc)) {
  $message = "FreePascal compiler (fpc) not found on PATH; skipping the FPC compile check."
  if ($RequireFpc) {
    throw $message
  }
  Write-Warning $message
  return
}

$version = (& $fpc -iV 2>&1 | Select-Object -First 1)
$targetCpu = (& $fpc -iTP 2>&1 | Select-Object -First 1)
$targetOs = (& $fpc -iTO 2>&1 | Select-Object -First 1)

# 'fpc -iV' prints the version but exits non-zero because no source file was
# given, so validate the output instead of the exit code.
if ($version -notmatch '^\d+\.\d+') {
  $message = "FreePascal compiler at '$fpc' is not usable (version query returned '$version'); skipping the FPC compile check."
  if ($RequireFpc) {
    throw $message
  }
  Write-Warning $message
  return
}

Write-Info "FPC compile check"
Write-Info ("  compiler: {0}" -f $fpc)
Write-Info ("  version : {0} ({1}-{2})" -f $version, $targetCpu, $targetOs)

if (Test-Path -LiteralPath $scratchDir) {
  Remove-Item -LiteralPath $scratchDir -Recurse -Force
}
[void](New-Item -ItemType Directory -Path $scratchDir -Force)

$failed = $false
try {
  foreach ($unit in $Units) {
    $unitPath = Join-Path $SourceDir $unit
    if (-not (Test-Path -LiteralPath $unitPath)) {
      throw "Unit to check not found: $unitPath"
    }

    $arguments = @(
      "-Mdelphi",
      "-Sh",
      "-Se1",
      ("-FU" + $scratchDir),
      ("-Fu" + $SourceDir),
      $unitPath
    )

    $output = & $fpc @arguments 2>&1
    $exitCode = $LASTEXITCODE

    $problems = @($output | Where-Object { $_ -match "(Error|Fatal|Warning):" })
    if ($exitCode -ne 0 -or $problems.Count -gt 0) {
      Write-Host "  FAILED  $unit"
      foreach ($line in $output) {
        Write-Host "    $line"
      }
      $failed = $true
    } else {
      $summary = @($output | Where-Object { $_ -match "lines compiled" }) | Select-Object -First 1
      Write-Info ("  ok      {0} ({1})" -f $unit, $summary)
    }
  }
} finally {
  if ($KeepWorkDir) {
    Write-Info ("  output kept in {0}" -f $scratchDir)
  } elseif (Test-Path -LiteralPath $scratchDir) {
    Remove-Item -LiteralPath $scratchDir -Recurse -Force -ErrorAction SilentlyContinue
  }
}

if ($failed) {
  throw "FPC compile check failed. The library units must compile with Delphi and FreePascal."
}

Write-Info "FPC compile check passed."
