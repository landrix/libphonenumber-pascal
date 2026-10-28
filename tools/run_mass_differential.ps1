param(
  [string]$StudioRoot = "C:\Program Files (x86)\Embarcadero\Studio\37.0",
  # Empty means "the canonical pin"; see tools/oracle_helpers.ps1, Get-OraclePin.
  [string]$PackageId = "",
  [string]$PackageVersion = "",
  [string]$TargetFramework = "",
  [string]$OracleRoot = "",
  [string]$FindingsPath = "",
  # PARENT directory of the build/run scratch space. The script creates and
  # removes only its own uniquely named subdirectory below it and never deletes
  # the directory it was given.
  [string]$WorkDir = "",
  # Pinned corpus size of the metadata baseline: the number of descriptions of
  # PhoneNumberMetadata.xml that carry an example number. Pinned for the same
  # reason the oracle package version is - so a silently shrinking data set is
  # a failure and not a quietly smaller, still "clean" run. Bump it together
  # with the baseline numbers in the AGENTS.md manifest when a vendor
  # refresh legitimately changes it.
  [int]$ExpectedCaseCount = 1143,
  [switch]$SkipBuild,
  [switch]$KeepWorkDir,
  [switch]$RefreshOracle,
  [switch]$FailOnFindings,
  [switch]$ForceWrite
)

<#
  Mass differential runner.

  For every description of every territory of the generated metadata that has
  an example number - 1143 cases over all 254 territories - it compares the
  Pascal port against the C# NuGet oracle on nine answers:

    Parse (success and, on failure, the error), E164, INTERNATIONAL, NATIONAL
    and RFC3966, IsPossibleNumber, IsValidNumber, GetNumberType,
    GetRegionCodeForNumber.

  How it works
  ------------
  1. tools/differential/PhoneNumbersDifferential.dpr is compiled with dcc64 and
     run; it links the shipped src/ units and writes its answers as JSON.
  2. The same inputs are put to PhoneNumbers.PhoneNumberUtil from the oracle
     package, restored exactly like tools/generate_reference_cases.ps1 does it.
  3. Every field that differs becomes a finding in
     tests/data/mass_differential_findings.json, which is VERSIONED: the file
     is the inventory of known divergences, and it is meant to stay empty.

  Corpus guards
  -------------
  "Zero findings" only means something when something was actually compared, so
  three assertions run before the result is accepted: the probe's own case
  count must match the number of cases it emitted, the corpus must have exactly
  -ExpectedCaseCount entries (a pinned baseline number, like the oracle package
  version), and the number of compared fields must equal what the per case
  outcomes imply - with a finding free run compared field for field over the
  whole corpus. Each of them throws; none of them is covered by
  -FailOnFindings, which only counts divergences.

  Not covered here: PhoneNumberMatcher / FindNumbers. The C# matcher is not a
  current translation of the Java one (five documented deviations, see the
  header of tests/LibPhoneNumber.PhoneNumberMatcher.Tests.pas), so the
  oracle is not an arbiter for it.

  Runtime is minutes, which is why run_update_workflow.ps1 only runs this with
  -RunMassDifferential.
#>

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "oracle_helpers.ps1")
. (Join-Path $PSScriptRoot "json_helpers.ps1")

$PackageId = Resolve-OraclePinValue -Value $PackageId -Name "PackageId"
$PackageVersion = Resolve-OraclePinValue -Value $PackageVersion -Name "PackageVersion"
$TargetFramework = Resolve-OraclePinValue -Value $TargetFramework -Name "TargetFramework"

if ($PSVersionTable.PSEdition -eq "Desktop") {
  throw "This script requires PowerShell 7+ (pwsh): the NuGet oracle targets '$TargetFramework' and cannot be loaded by Windows PowerShell 5.1."
}

$repoRoot = Split-Path -Parent $PSScriptRoot

$OracleRoot = Get-OracleCacheRoot -Root $OracleRoot
if ([string]::IsNullOrWhiteSpace($FindingsPath)) {
  $FindingsPath = Join-Path $repoRoot "tests\data\mass_differential_findings.json"
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
$scratchDir = Join-Path $WorkDir ("libphonenumber-massdiff-{0}" -f $PID)

$projectDir = Join-Path $PSScriptRoot "differential"
$projectFile = Join-Path $projectDir "PhoneNumbersDifferential.dpr"
if (-not (Test-Path -LiteralPath $projectFile)) {
  throw "Differential probe not found: $projectFile"
}

if (Test-Path -LiteralPath $scratchDir) {
  Remove-Item -LiteralPath $scratchDir -Recurse -Force
}
[void](New-Item -ItemType Directory -Path $scratchDir -Force)
$dcuDir = Join-Path $scratchDir "dcu"
[void](New-Item -ItemType Directory -Path $dcuDir -Force)

$probeExe = Join-Path $scratchDir "PhoneNumbersDifferential.exe"
$portJson = Join-Path $scratchDir "differential_port.json"

# --- 1. port side ----------------------------------------------------------

if (-not $SkipBuild) {
  $dcc64 = Join-Path $StudioRoot "bin\dcc64.exe"
  if (-not (Test-Path -LiteralPath $dcc64)) {
    throw "Delphi command line compiler not found: $dcc64"
  }

  Write-Host "==> Building the port differential probe"
  Push-Location $projectDir
  try {
    & $dcc64 -B -Q "-U..\..\src" ("-NU" + $dcuDir) ("-E" + $scratchDir) "PhoneNumbersDifferential.dpr"
    if ($LASTEXITCODE -ne 0) {
      throw "dcc64 failed for $projectFile (exit code $LASTEXITCODE)."
    }
  } finally {
    Pop-Location
  }
}
elseif (-not (Test-Path -LiteralPath $probeExe)) {
  # -SkipBuild reuses an executable an earlier -KeepWorkDir run left behind.
  # That run's scratch directory carried ITS process id, so also accept the
  # executable directly in the -WorkDir the caller named.
  $reusedProbe = Join-Path $WorkDir "PhoneNumbersDifferential.exe"
  if (Test-Path -LiteralPath $reusedProbe) {
    $probeExe = $reusedProbe
  }
}

if (-not (Test-Path -LiteralPath $probeExe)) {
  throw "Differential probe executable not found: $probeExe"
}

Write-Host "==> Running the port differential probe"
& $probeExe $portJson
if ($LASTEXITCODE -ne 0) {
  throw "The port differential probe failed (exit code $LASTEXITCODE)."
}

$port = Get-Content -LiteralPath $portJson -Raw -Encoding UTF8 | ConvertFrom-Json
if ($null -eq $port -or $null -eq $port.cases) {
  throw "The port differential probe produced no cases: $portJson"
}

# --- corpus guards -----------------------------------------------------------
#
# Without these, an empty or truncated probe output would PASS: -FailOnFindings
# only looks at the number of divergences, and zero cases produce zero
# divergences. The three guards below turn "nothing was compared" into a
# failure, which is what a gate has to do.

$portCases = @($port.cases)
if ($portCases.Count -ne [int]$port.caseCount) {
  throw ("The port differential probe is inconsistent with itself: it reports {0} cases but emitted {1}." -f
    $port.caseCount, $portCases.Count)
}

if ($portCases.Count -ne $ExpectedCaseCount) {
  throw ("Differential corpus size changed: expected $ExpectedCaseCount example numbers, got $($portCases.Count). " +
    "That is a metadata baseline change, not a run to accept blindly: confirm it against the generator summary " +
    "('descriptions: N with example numbers') and then update the -ExpectedCaseCount default in this script " +
    "together with the baseline numbers in the AGENTS.md manifest.")
}

# --- 2. oracle side ----------------------------------------------------------

Write-Host "==> Loading the C# oracle"
$phoneNumbersDll = Get-OracleAssemblyPath -Root $OracleRoot -Id $PackageId -Version $PackageVersion `
  -Framework $TargetFramework -Refresh:$RefreshOracle -Quiet
$loadedOracle = Import-OracleAssembly -AssemblyPath $phoneNumbersDll -ExpectedPackageVersion $PackageVersion -Quiet
$oracleVersion = $loadedOracle.Version
Write-Host "Oracle version: $oracleVersion"

$util = [PhoneNumbers.PhoneNumberUtil]::GetInstance()

$formatE164 = [PhoneNumbers.PhoneNumberFormat]::E164
$formatInternational = [PhoneNumbers.PhoneNumberFormat]::INTERNATIONAL
$formatNational = [PhoneNumbers.PhoneNumberFormat]::NATIONAL
$formatRfc3966 = [PhoneNumbers.PhoneNumberFormat]::RFC3966

# --- 3. differential ---------------------------------------------------------

Write-Host "==> Comparing $($portCases.Count) cases"

$findings = @()
$comparedFields = 0
$parseFailures = 0
# Split for the field-count guard below: a case where both sides parsed
# contributes 9 compared fields, a case both refused contributes 2 (parseOk and
# parseError), a case where the two disagree about parseability contributes 1.
$bothParsedCases = 0
$bothRefusedCases = 0
$parseOkMismatches = 0

# Fields compared when both sides parsed. The port probe writes these only in
# that case, exactly like this list.
$resultFields = @(
  'e164', 'international', 'national', 'rfc3966',
  'isPossible', 'isValid', 'numberType', 'regionCode'
)
$resultFieldCount = $resultFields.Count

foreach ($case in $portCases) {
  $region = [string]$case.parseRegion
  if ([string]::IsNullOrEmpty($region)) {
    $region = $null
  }

  $oracleNumber = $null
  $oracleParseOk = $true
  $oracleError = 'NONE'
  try {
    $oracleNumber = $util.Parse([string]$case.parseInput, $region)
  }
  catch [PhoneNumbers.NumberParseException] {
    $oracleParseOk = $false
    $oracleError = [string]$_.Exception.ErrorType
  }
  catch {
    $oracleParseOk = $false
    $oracleError = 'EXCEPTION:' + $_.Exception.GetType().Name
  }

  $comparedFields++
  if ($oracleParseOk -ne [bool]$case.parseOk) {
    $findings += [PSCustomObject]@{
      region = [string]$case.region
      countryCode = [int]$case.countryCode
      descKind = [string]$case.descKind
      input = [string]$case.parseInput
      parseRegion = [string]$case.parseRegion
      field = 'parseOk'
      port = ([bool]$case.parseOk).ToString()
      oracle = $oracleParseOk.ToString()
      javaVerdict = ''
    }
    $parseFailures++
    $parseOkMismatches++
    continue
  }

  if (-not $oracleParseOk) {
    # Both refused. Compare the reason as well; the port enum names are the
    # upstream ErrorType names.
    if ($oracleError -ne [string]$case.parseError) {
      $findings += [PSCustomObject]@{
        region = [string]$case.region
        countryCode = [int]$case.countryCode
        descKind = [string]$case.descKind
        input = [string]$case.parseInput
        parseRegion = [string]$case.parseRegion
        field = 'parseError'
        port = [string]$case.parseError
        oracle = $oracleError
        javaVerdict = ''
      }
    }
    $parseFailures++
    $bothRefusedCases++
    continue
  }

  $bothParsedCases++
  $oracleValues = @{
    e164 = [string]$util.Format($oracleNumber, $formatE164)
    international = [string]$util.Format($oracleNumber, $formatInternational)
    national = [string]$util.Format($oracleNumber, $formatNational)
    rfc3966 = [string]$util.Format($oracleNumber, $formatRfc3966)
    isPossible = [bool]$util.IsPossibleNumber($oracleNumber)
    isValid = [bool]$util.IsValidNumber($oracleNumber)
    numberType = [string]$util.GetNumberType($oracleNumber)
    regionCode = [string]$util.GetRegionCodeForNumber($oracleNumber)
  }

  foreach ($field in $resultFields) {
    $portValue = $case.$field
    $oracleValue = $oracleValues[$field]

    $portText = if ($portValue -is [bool]) { $portValue.ToString() } else { [string]$portValue }
    $oracleText = if ($oracleValue -is [bool]) { $oracleValue.ToString() } else { [string]$oracleValue }

    $comparedFields++
    if ($portText -cne $oracleText) {
      $findings += [PSCustomObject]@{
        region = [string]$case.region
        countryCode = [int]$case.countryCode
        descKind = [string]$case.descKind
        input = [string]$case.parseInput
        parseRegion = [string]$case.parseRegion
        field = $field
        port = $portText
        oracle = $oracleText
        javaVerdict = ''
      }
    }
  }
}

# --- field count guard -------------------------------------------------------
#
# Every case must have contributed exactly the fields its outcome implies. This
# catches a probe that emitted case objects without the result fields, a typo
# in $resultFields and a loop that silently skipped cases - all of which would
# otherwise show up as a smaller, still "clean" run.
$expectedFields = ($bothParsedCases * (1 + $resultFieldCount)) +
  ($bothRefusedCases * 2) + $parseOkMismatches
if ($comparedFields -ne $expectedFields) {
  throw ("Differential field count mismatch: compared $comparedFields fields but the outcomes imply $expectedFields " +
    "($bothParsedCases both-parsed x $(1 + $resultFieldCount), $bothRefusedCases both-refused x 2, $parseOkMismatches parseOk mismatches).")
}
if (($bothParsedCases + $bothRefusedCases + $parseOkMismatches) -ne $portCases.Count) {
  throw ("Differential case accounting mismatch: $($portCases.Count) cases in, " +
    "$($bothParsedCases + $bothRefusedCases + $parseOkMismatches) accounted for.")
}
# A clean baseline compares 9 fields for every single case. Anything less means
# the corpus did not parse end to end, which is a finding in itself.
if (@($findings).Count -eq 0 -and $comparedFields -ne ($portCases.Count * (1 + $resultFieldCount))) {
  throw ("A finding free run must compare $($portCases.Count * (1 + $resultFieldCount)) fields but compared $comparedFields.")
}

$summary = [PSCustomObject]@{
  generatedAt = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssK')
  oracle = ("{0} {1} ({2})" -f $PackageId, $PackageVersion, $oracleVersion)
  metadataVersion = [string]$port.metadataVersion
  metadataSourceFile = [string]$port.metadataSourceFile
  metadataSourceCommit = [string]$port.metadataSourceCommit
  caseCount = $portCases.Count
  expectedCaseCount = $ExpectedCaseCount
  comparedFields = $comparedFields
  fieldsPerCase = (1 + $resultFieldCount)
  parseFailures = $parseFailures
  findingCount = @($findings).Count
}

$result = [PSCustomObject]@{
  summary = $summary
  # Only REAL divergences are listed. Each one carries a javaVerdict field for
  # the arbitration that has to follow: Java upstream decides, not the oracle.
  findings = @($findings | Sort-Object countryCode, region, descKind, field)
}

$findingsDir = Split-Path -Parent $FindingsPath
if (-not [string]::IsNullOrWhiteSpace($findingsDir) -and -not (Test-Path $findingsDir)) {
  [void](New-Item -ItemType Directory -Path $findingsDir -Force)
}

$written = Write-JsonFile -InputObject $result -Path $FindingsPath -Depth 8 -IgnorePathsForChangeDetection @('summary.generatedAt', 'summary.oracle') -ForceWrite:$ForceWrite

Write-Host ""
Write-Host "Mass differential summary:"
Write-Host "  cases           : $($summary.caseCount) (expected $ExpectedCaseCount)"
Write-Host "  compared fields : $($summary.comparedFields)"
Write-Host "  parse failures  : $($summary.parseFailures)"
Write-Host "  findings        : $($summary.findingCount)"
Write-Host "  findings file   : $FindingsPath"
if (-not $written) {
  Write-Host "No content changes detected (timestamp-only change ignored)."
}

if ($KeepWorkDir) {
  Write-Host "  work directory  : $scratchDir (kept)"
} else {
  # Windows can still hold the handle of the probe process that just exited,
  # which made the removal fail silently and leave the executable behind. Retry
  # a few times; never fail the run over a leftover scratch file.
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

if ($FailOnFindings -and $summary.findingCount -gt 0) {
  throw "The mass differential found $($summary.findingCount) divergences and -FailOnFindings is enabled."
}
