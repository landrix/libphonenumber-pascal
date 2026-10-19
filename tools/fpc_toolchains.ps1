<#
  Shared FreePascal toolchain helpers, dot-sourced by
  tools/run_fpc_runtime_check.ps1 and tools/run_fpc_tests.ps1.

  Three toolchains:
    Wsl     FreePascal inside WSL (default compiler ~/fpc-3.2.4/bin/fpc of the
            WSL user, resolved inside WSL; override with an explicit path).
    Native  the FreePascal on PATH of THIS machine (or an explicit path) -
            Windows, and also Linux or macOS when the script runs under pwsh
            there (the GitHub Ubuntu job uses exactly that).
    Mac     the shared Mac toolchain behind an ssh alias, built with
            ~/remote-toolchains/macos-fpc/bin/fpc.sh, which discovers Xcode
            and the SDK on every call (nothing here names an Xcode path).

  Every resolver answers an empty string when its toolchain is not reachable;
  the caller turns that into a warning or, with -RequireFpc, a failure.
#>

# Below the home directory of the WSL user; resolved inside WSL.
$script:DefaultWslFpcRelative = "fpc-3.2.4/bin/fpc"
$script:DefaultMacFpc = "~/remote-toolchains/macos-fpc/bin/fpc.sh"

function Invoke-Native {
  # Runs a native command and returns its combined output as an array of lines
  # plus the exit code. A non zero exit code is not an exception here; every
  # caller decides itself what it means.
  param([string]$FilePath, [string[]]$Arguments)
  $previous = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  try {
    $output = & $FilePath @Arguments 2>&1 | ForEach-Object { "$_" }
    return [pscustomobject]@{ Output = @($output); ExitCode = $LASTEXITCODE }
  } finally {
    $ErrorActionPreference = $previous
  }
}

function Skip-OrFail {
  param([string]$Message, [bool]$Fail)
  if ($Fail) {
    throw $Message
  }
  Write-Warning $Message
}

function ConvertTo-WslPath {
  param([string]$WindowsPath)
  $result = Invoke-Native "wsl.exe" @("-e", "wslpath", "-u", $WindowsPath)
  if ($result.ExitCode -ne 0 -or $result.Output.Count -eq 0) {
    throw "wslpath could not translate '$WindowsPath'."
  }
  return $result.Output[0].Trim()
}

function Resolve-WslFpc {
  param([string]$FpcPath = "")
  $wsl = Get-Command -Name "wsl.exe" -CommandType Application -ErrorAction SilentlyContinue |
    Select-Object -First 1
  if ($null -eq $wsl) {
    return ""
  }
  if ([string]::IsNullOrWhiteSpace($FpcPath)) {
    # The default lives below the WSL user's home directory, so it is
    # resolved inside WSL instead of being spelled out here.
    $probe = Invoke-Native "wsl.exe" @("-e", "sh", "-c",
      ('p="$HOME/{0}"; test -x "$p" && echo "$p"' -f $script:DefaultWslFpcRelative))
    if ($probe.ExitCode -ne 0 -or $probe.Output.Count -eq 0) {
      return ""
    }
    return $probe.Output[0].Trim()
  }
  $probe = Invoke-Native "wsl.exe" @("-e", "test", "-x", $FpcPath)
  if ($probe.ExitCode -ne 0) {
    return ""
  }
  return $FpcPath
}

function Resolve-NativeFpc {
  param([string]$FpcPath = "")
  if (-not [string]::IsNullOrWhiteSpace($FpcPath)) {
    if (-not (Test-Path -LiteralPath $FpcPath)) {
      return ""
    }
    return (Resolve-Path -LiteralPath $FpcPath).Path
  }
  $command = Get-Command -Name "fpc" -CommandType Application -ErrorAction SilentlyContinue |
    Select-Object -First 1
  if ($null -eq $command) {
    return ""
  }
  return $command.Source
}

function ConvertTo-RemoteShellWord {
  # One word for the remote POSIX shell. Single quoted with the usual '\''
  # escaping, so nothing in the value is interpreted - except a leading "~/",
  # which must still expand to the remote home directory: it becomes "$HOME"
  # followed by the single quoted rest.
  param([string]$Value)
  $prefix = ""
  if ($Value.StartsWith("~/")) {
    $prefix = '"$HOME"/'
    $Value = $Value.Substring(2)
  }
  return $prefix + "'" + $Value.Replace("'", "'\''") + "'"
}

function Resolve-MacFpc {
  param([string]$FpcPath = "", [string]$MacHost)
  $ssh = Get-Command -Name "ssh" -CommandType Application -ErrorAction SilentlyContinue |
    Select-Object -First 1
  if ($null -eq $ssh) {
    return ""
  }
  $candidate = $FpcPath
  if ([string]::IsNullOrWhiteSpace($candidate)) {
    $candidate = $script:DefaultMacFpc
  }
  $probe = Invoke-Native "ssh" @("-o", "BatchMode=yes", "-o", "ConnectTimeout=10",
    $MacHost, ("test -x " + (ConvertTo-RemoteShellWord $candidate)))
  if ($probe.ExitCode -ne 0) {
    return ""
  }
  return $candidate
}

function Resolve-FpcToolchain {
  # The compiler of the selected toolchain, or "" when it is not reachable.
  param([string]$Toolchain, [string]$FpcPath = "", [string]$MacHost = "macos-tests")
  switch ($Toolchain) {
    "Wsl" { return Resolve-WslFpc -FpcPath $FpcPath }
    "Native" { return Resolve-NativeFpc -FpcPath $FpcPath }
    "Mac" { return Resolve-MacFpc -FpcPath $FpcPath -MacHost $MacHost }
  }
  throw "Unknown FreePascal toolchain '$Toolchain'."
}

function ConvertFrom-FpcToolchainList {
  # The toolchain list of tools/run_update_workflow.ps1 (-FpcToolchains): every
  # entry is "<Toolchain>" or "<Toolchain>=<compiler path>", the path being
  # handed on as -FpcPath. An entry may itself carry several comma separated
  # entries, because "powershell -File" passes "Wsl,Wsl=/usr/bin/fpc" as ONE
  # string. Answers one object per entry (Toolchain, FpcPath, Label) in the
  # given order; an unknown toolchain name is an error, never a skip.
  param([string[]]$Entries)
  $result = @()
  foreach ($entry in @($Entries)) {
    foreach ($part in @("$entry" -split ',')) {
      $text = $part.Trim()
      if ($text -eq "") {
        continue
      }
      $pair = $text -split '=', 2
      $name = $pair[0].Trim()
      $path = ""
      if ($pair.Count -eq 2) {
        $path = $pair[1].Trim()
      }
      $known = @("Wsl", "Native", "Mac") | Where-Object { $_ -eq $name } | Select-Object -First 1
      if ($null -eq $known) {
        throw "Unknown FreePascal toolchain '$name' in '$text' (expected Wsl, Native or Mac, optionally followed by =<compiler path>)."
      }
      $label = $known
      if ($path -ne "") {
        $label = "$known, $path"
      }
      $result += [pscustomobject]@{ Toolchain = $known; FpcPath = $path; Label = $label }
    }
  }
  return $result
}

function Get-NativeFpcDescription {
  # "<version> (<cpu>-<os>)" of a compiler this machine runs directly.
  param([string]$Fpc)
  return "{0} ({1}-{2})" -f (Invoke-Native $Fpc @("-iV")).Output[0],
    (Invoke-Native $Fpc @("-iTP")).Output[0], (Invoke-Native $Fpc @("-iTO")).Output[0]
}

function Get-FpcProblems {
  param([string[]]$BuildOutput)
  # An error or a WARNING of the compiler fails the build. Hints and notes are
  # tolerated. Case sensitive on purpose: the compiler writes "Warning:", while
  # the Apple linker's lower case "ld: warning: ignoring duplicate libraries:
  # '-lc'" is a known, harmless message of the macOS toolchain and not about
  # this source.
  return @($BuildOutput | Where-Object { $_ -cmatch "(Error|Fatal|Warning):" })
}

function Write-LfAsciiFile {
  # Writes lines with LF line ends and ASCII encoding: the repository checks
  # out with CRLF on Windows, which a POSIX shell would choke on, and nothing
  # in such a file needs more than ASCII.
  param([string]$Path, [string[]]$Lines)
  [System.IO.File]::WriteAllText($Path, (($Lines -join "`n") + "`n"),
    (New-Object System.Text.ASCIIEncoding))
}

function New-MacRunDirectory {
  # A fresh, unique run directory below ~/remote-toolchains/macos-fpc/runs on
  # the Mac, named <Prefix>-<utc>-<id>; relative to the remote home directory.
  # Remote runs are kept for review, as the toolchain README asks.
  param([string]$MacHost, [string]$Prefix)
  $stamp = [DateTime]::UtcNow.ToString("yyyyMMddTHHmmssZ")
  $runId = [Guid]::NewGuid().ToString("N").Substring(0, 8)
  $remoteRun = "remote-toolchains/macos-fpc/runs/$Prefix-$stamp-$runId"
  $step = Invoke-Native "ssh" @($MacHost, "mkdir -p $remoteRun")
  if ($step.ExitCode -ne 0) {
    throw "Creating the Mac run directory failed: $($step.Output -join ' ')"
  }
  return $remoteRun
}

function Send-MacStage {
  # Packs the local directory $StageDir (Windows ships bsdtar as tar.exe),
  # uploads it and unpacks it into the remote run directory.
  param([string]$MacHost, [string]$RemoteRun, [string]$StageDir, [string]$ScratchDir)
  $archive = Join-Path $ScratchDir "mac-stage.tar.gz"
  $tar = Invoke-Native "tar.exe" @("-czf", $archive, "-C", $StageDir, ".")
  if ($tar.ExitCode -ne 0) {
    $tar.Output | ForEach-Object { Write-Host "    $_" }
    throw "Packing the Mac sources failed (exit code $($tar.ExitCode))."
  }
  $step = Invoke-Native "scp" @("-q", ($archive -replace '\\', '/'), ("{0}:{1}/stage.tar.gz" -f $MacHost, $RemoteRun))
  if ($step.ExitCode -ne 0) {
    throw "Uploading the Mac sources failed: $($step.Output -join ' ')"
  }
  $step = Invoke-Native "ssh" @($MacHost, "cd $RemoteRun && tar -xzf stage.tar.gz")
  if ($step.ExitCode -ne 0) {
    throw "Unpacking the Mac sources failed: $($step.Output -join ' ')"
  }
}

function Receive-MacFile {
  # Copies <remote run>/<RelativePath> to the local file $Destination.
  param([string]$MacHost, [string]$RemoteRun, [string]$RelativePath, [string]$Destination,
    [switch]$Optional)
  $step = Invoke-Native "scp" @("-q", ("{0}:{1}/{2}" -f $MacHost, $RemoteRun, $RelativePath),
    ($Destination -replace '\\', '/'))
  if ($step.ExitCode -ne 0 -and -not $Optional) {
    throw "Downloading $RelativePath from the Mac failed: $($step.Output -join ' ')"
  }
  return ($step.ExitCode -eq 0)
}
