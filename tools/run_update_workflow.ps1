param(
  [switch]$SkipReference,
  [switch]$SkipMetadataGen,
  # The FreePascal compile check is a step of its OWN, independent of the
  # metadata generation, so -SkipMetadataGen cannot skip the FPC gate.
  # -SkipFpcCheck is the only way to skip it.
  [switch]$SkipFpcCheck,
  # The FreePascal RUNTIME check (tools/run_fpc_runtime_check.ps1) builds the
  # runtime gate driver with Delphi and with FreePascal and compares the two
  # observation files byte for byte. A step of its own right after the compile
  # check; -SkipFpcRuntime is the only way to skip it.
  [switch]$SkipFpcRuntime,
  # Forwarded to tools/check_fpc_compile.ps1 AND tools/run_fpc_runtime_check.ps1:
  # turn a missing FreePascal compiler from a warning into a failure.
  [switch]$RequireFpc,
  [switch]$SkipTests,
  [switch]$FailOnDiff,
  # The mass differential runner parses and
  # formats all 1144 upstream example numbers through both the Pascal port and
  # the C# oracle. That takes minutes and needs the oracle package, so it is
  # opt in rather than part of every run.
  [switch]$RunMassDifferential,
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  [string]$Config = "Debug",
  [string]$Platform = "Win64"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$diffPath = Join-Path $repoRoot "tools\snapshots\generated_vs_upstream_diff.json"
$massDifferentialFindings = Join-Path $repoRoot "tests\data\mass_differential_findings.json"

# The nine tracked units tools/generate_metadata.ps1 produces, relative to the
# repository root. They are the artefacts that MUST be in sync with the four
# input XMLs; the post-generation guard below diffs exactly these against the
# repository state.
$generatedUnits = @(
  "src/LibPhoneNumber.Metadata.Data.pas",
  "src/LibPhoneNumber.Metadata.Descs.pas",
  "src/LibPhoneNumber.Metadata.Formats.pas",
  "src/LibPhoneNumber.ShortMetadata.Data.pas",
  "src/LibPhoneNumber.ShortMetadata.Descs.pas",
  "src/LibPhoneNumber.TestingMetadata.Data.pas",
  "src/LibPhoneNumber.TestingMetadata.Descs.pas",
  "src/LibPhoneNumber.TestingMetadata.Formats.pas",
  "src/LibPhoneNumber.AlternateFormats.Data.pas"
)

function Invoke-Step {
  param(
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $true)][scriptblock]$Action
  )

  Write-Host ""
  Write-Host "==> $Name"
  & $Action
}

function Get-PwshPath {
  # generate_reference_cases.ps1 loads a net8.0 assembly and therefore needs
  # PowerShell 7. Running it as a child process also keeps Add-Type out of the
  # caller's session, which avoids "Assembly with same name is already loaded".
  if ($PSVersionTable.PSEdition -eq "Core") {
    $currentHost = (Get-Process -Id $PID).Path
    if (-not [string]::IsNullOrWhiteSpace($currentHost)) {
      return $currentHost
    }
  }

  $pwshCommand = Get-Command -Name "pwsh" -CommandType Application -ErrorAction SilentlyContinue |
    Select-Object -First 1
  if ($null -ne $pwshCommand) {
    return $pwshCommand.Source
  }

  throw "PowerShell 7 (pwsh) was not found but is required to refresh the reference cases. Install PowerShell 7 or run the workflow with -SkipReference."
}

Write-Host "Running update workflow..."
Write-Host "Repo: $repoRoot"

if (-not $SkipReference) {
  Invoke-Step "Refresh Java/C# reference cases" {
    $pwshPath = Get-PwshPath
    $generatorScript = Join-Path $PSScriptRoot "generate_reference_cases.ps1"
    Write-Host "Host: $pwshPath"

    & $pwshPath -NoProfile -ExecutionPolicy Bypass -File $generatorScript
    if ($LASTEXITCODE -ne 0) {
      throw "Reference case refresh failed (exit code $LASTEXITCODE)."
    }
  }
} else {
  Write-Host "Skipping reference case refresh (-SkipReference)."
}

if (-not $SkipMetadataGen) {
  Invoke-Step "Generate metadata units" {
    # The generator embeds the pinned vendor commit and rewrites the generated
    # units only when their content actually changes, so a clean vendor state
    # leaves the working tree untouched.
    # Unlike the reference generator this step needs no .NET assembly loading,
    # so it runs in-process and works under Windows PowerShell 5.1 as well.
    #
    # -SkipFpcCheck is passed unconditionally: the FreePascal check is a step of
    # this workflow now (see below) and must not depend on whether the metadata
    # was regenerated.
    & (Join-Path $PSScriptRoot "generate_metadata.ps1") -SkipFpcCheck
  }

  if ($FailOnDiff) {
    Invoke-Step "Verify the generated units match the repository state" {
      # The generator writes a unit only when its content changed, so after a
      # regeneration the nine tracked units must be byte identical to what is
      # committed. Without this check a commit that forgot to regenerate would
      # pass the whole workflow locally: every later step reads the units from
      # the WORKING TREE, which the generator has just brought up to date.
      $gitCommand = Get-Command -Name "git" -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1
      if ($null -eq $gitCommand) {
        throw "git was not found on PATH but -FailOnDiff requires it to verify the generated metadata units."
      }

      $status = & $gitCommand.Source -C $repoRoot status --porcelain -- $generatedUnits
      if ($LASTEXITCODE -ne 0) {
        throw "git status failed while verifying the generated metadata units (exit code $LASTEXITCODE)."
      }

      $dirty = @($status | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
      if ($dirty.Count -gt 0) {
        Write-Host "Generated units differing from the repository state:"
        foreach ($line in $dirty) {
          Write-Host "  $line"
        }
        throw ("Regenerating the metadata changed $($dirty.Count) tracked generated unit(s) and -FailOnDiff is enabled. " +
          "The committed units are not the output of the current generator plus the pinned vendor XMLs. " +
          "Commit the regenerated units (never edit them by hand) and re-run.")
      }

      Write-Host "All $($generatedUnits.Count) generated units match the repository state."
    }
  }
} else {
  Write-Host "Skipping metadata generation (-SkipMetadataGen)."
}

if (-not $SkipFpcCheck) {
  Invoke-Step "FreePascal compile check" {
    & (Join-Path $PSScriptRoot "check_fpc_compile.ps1") -RequireFpc:$RequireFpc
  }
} else {
  Write-Host "Skipping the FreePascal compile check (-SkipFpcCheck)."
}

if (-not $SkipFpcRuntime) {
  Invoke-Step "FreePascal runtime check" {
    # The default toolchain is FreePascal inside WSL. Like the compile check it
    # is a soft skip with a warning when that toolchain (or the Delphi
    # reference compiler) is missing; -RequireFpc makes a missing FreePascal a
    # failure here as well.
    & (Join-Path $PSScriptRoot "run_fpc_runtime_check.ps1") -RequireFpc:$RequireFpc -StudioRoot $StudioRoot
  }
} else {
  Write-Host "Skipping the FreePascal runtime check (-SkipFpcRuntime)."
}

# The compare gate: it diffs the GENERATED metadata - the actual runtime
# data - against the upstream XML, per territory and over the whole
# possible-length set.
Invoke-Step "Export generated metadata snapshot" {
  & (Join-Path $PSScriptRoot "export_generated_metadata_snapshot.ps1")
}

Invoke-Step "Extract upstream length rules" {
  & (Join-Path $PSScriptRoot "extract_upstream_length_rules.ps1")
}

Invoke-Step "Compare generated metadata with upstream" {
  & (Join-Path $PSScriptRoot "compare_generated_metadata_with_upstream.ps1")
}

if (-not (Test-Path $diffPath)) {
  throw "Expected diff snapshot was not generated: $diffPath"
}

$diffJson = Get-Content -Path $diffPath -Raw -Encoding UTF8 | ConvertFrom-Json
$summary = $diffJson.summary

Write-Host ""
Write-Host "Diff summary:"
Write-Host "  lengthMismatches     : $($summary.lengthMismatches)"
Write-Host "  missingInGenerated   : $($summary.missingInGenerated)"
Write-Host "  missingInUpstream    : $($summary.missingInUpstream)"
Write-Host "  callingCodeMismatches: $($summary.callingCodeMismatches)"

$diffTotal = [int]$summary.lengthMismatches + [int]$summary.missingInGenerated +
  [int]$summary.missingInUpstream + [int]$summary.callingCodeMismatches
if ($diffTotal -gt 0 -and $FailOnDiff) {
  throw "Diff summary is not clean and -FailOnDiff is enabled."
}

if (-not $SkipTests) {
  Invoke-Step "Run Delphi test suite" {
    & (Join-Path $PSScriptRoot "run_delphi_tests.ps1") -StudioRoot $StudioRoot -Config $Config -Platform $Platform
  }
} else {
  Write-Host "Skipping Delphi tests (-SkipTests)."
}

if ($RunMassDifferential) {
  Invoke-Step "Mass differential against the C# oracle" {
    $pwshPath = Get-PwshPath
    $massScript = Join-Path $PSScriptRoot "run_mass_differential.ps1"
    $arguments = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $massScript,
      "-StudioRoot", $StudioRoot)
    if ($FailOnDiff) {
      $arguments += "-FailOnFindings"
    }
    & $pwshPath @arguments
    if ($LASTEXITCODE -ne 0) {
      throw "Mass differential reported findings or failed (exit code $LASTEXITCODE)."
    }
  }
} else {
  Write-Host ""
  Write-Host "Skipping the mass differential (pass -RunMassDifferential to run it)."
}

Write-Host ""
Write-Host "Workflow completed successfully."
Write-Host "Diff snapshot: $diffPath"
if ($RunMassDifferential) {
  Write-Host "Mass differential findings: $massDifferentialFindings"
}
