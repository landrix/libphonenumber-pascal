param(
  [string]$ReferenceFile = "",
  # Empty means "the canonical pin"; see tools/oracle_helpers.ps1, Get-OraclePin.
  [string]$PackageId = "",
  [string]$PackageVersion = "",
  [string]$TargetFramework = "",
  [string]$OracleRoot = "",
  [switch]$RefreshOracle,
  [switch]$IncludeAllRegions,
  # Every case that cannot be computed is an ERROR: writing the corpus anyway
  # would conserve the previous - possibly stale - expectation for that case.
  # -AllowPartial downgrades that to the old warn-and-continue behaviour for the
  # rare deliberate exception (a case whose region the pinned oracle does not
  # know yet, say); it then writes what it could compute and says so.
  [switch]$AllowPartial,
  [switch]$ForceWrite
)

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "oracle_helpers.ps1")
. (Join-Path $PSScriptRoot "json_helpers.ps1")

$PackageId = Resolve-OraclePinValue -Value $PackageId -Name "PackageId"
$PackageVersion = Resolve-OraclePinValue -Value $PackageVersion -Name "PackageVersion"
$TargetFramework = Resolve-OraclePinValue -Value $TargetFramework -Name "TargetFramework"

if ($PSVersionTable.PSEdition -eq "Desktop") {
  throw "This script requires PowerShell 7+ (pwsh). The NuGet reference oracle targets '$TargetFramework' and cannot be loaded by Windows PowerShell 5.1. Re-run with: pwsh -NoProfile -ExecutionPolicy Bypass -File tools\generate_reference_cases.ps1"
}

$repoRoot = Split-Path -Parent $PSScriptRoot

$OracleRoot = Get-OracleCacheRoot -Root $OracleRoot

if ([string]::IsNullOrWhiteSpace($ReferenceFile)) {
  $ReferenceFile = Join-Path $repoRoot "tests\data\reference_cases_java_csharp.json"
} else {
  $ReferenceFile = (Resolve-Path $ReferenceFile).Path
}

Write-Host "Generating reference cases from the C# NuGet oracle..."
Write-Host "Package: $PackageId $PackageVersion"
Write-Host "TFM:     $TargetFramework"
Write-Host "Cache:   $OracleRoot"
Write-Host "File:    $ReferenceFile"

$phoneNumbersDll = Get-OracleAssemblyPath -Root $OracleRoot -Id $PackageId -Version $PackageVersion -Framework $TargetFramework -Refresh:$RefreshOracle

Write-Host "Assembly: $phoneNumbersDll"

[void](Import-OracleAssembly -AssemblyPath $phoneNumbersDll -ExpectedPackageVersion $PackageVersion)

$json = Get-Content -Path $ReferenceFile -Raw -Encoding UTF8 | ConvertFrom-Json
if ($null -eq $json) {
  throw "Reference case file is empty or invalid JSON: $ReferenceFile"
}

$util = [PhoneNumbers.PhoneNumberUtil]::GetInstance()

# --- case error collection ---------------------------------------------------
#
# Every case that cannot be recomputed is collected here instead of being warned
# about. A warning plus a write is the dangerous combination: the corpus is
# rewritten with the OLD expectation for that case still in it, so a genuine
# oracle disagreement looks like a clean run forever after. The corpus is
# therefore written only when this list is empty (or -AllowPartial was passed).
$caseErrors = New-Object System.Collections.Generic.List[string]

function Add-CaseError {
  param([Parameter(Mandatory = $true)][string]$Message)
  [void]$caseErrors.Add($Message)
  Write-Warning $Message
}

if ($IncludeAllRegions) {
  $cases = New-Object System.Collections.Generic.List[object]
  foreach ($item in @($json)) {
    [void]$cases.Add($item)
  }

  $existingRegions = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
  foreach ($item in $cases) {
    $regionCode = [string]$item.country
    if (-not [string]::IsNullOrWhiteSpace($regionCode)) {
      [void]$existingRegions.Add($regionCode.Trim().ToUpperInvariant())
    }
  }

  $addedRegions = 0
  $allRegions = @($util.GetSupportedRegions() | Sort-Object)

  foreach ($region in $allRegions) {
    if ($existingRegions.Contains($region)) {
      continue
    }

    $example = $null
    foreach ($phoneType in @(
      [PhoneNumbers.PhoneNumberType]::MOBILE,
      [PhoneNumbers.PhoneNumberType]::FIXED_LINE_OR_MOBILE,
      [PhoneNumbers.PhoneNumberType]::FIXED_LINE,
      [PhoneNumbers.PhoneNumberType]::TOLL_FREE
    )) {
      try {
        $example = $util.GetExampleNumberForType($region, $phoneType)
        if ($null -ne $example) {
          break
        }
      }
      catch {
      }
    }

    if ($null -eq $example) {
      try {
        $example = $util.GetExampleNumber($region)
      }
      catch {
      }
    }

    if ($null -eq $example) {
      Add-CaseError "No example number available for region '$region'; the auto-case could not be built."
      continue
    }

    $exampleE164 = $util.Format($example, [PhoneNumbers.PhoneNumberFormat]::E164)
    $cases.Add([PSCustomObject]@{
      name = "$region auto example"
      input = [string]$exampleE164
      country = [string]$region
      javaE164 = ''
      csharpE164 = ''
      csharpInternational = ''
      csharpNational = ''
      csharpRfc3966 = ''
      javaInternational = ''
      javaNational = ''
      javaRfc3966 = ''
    })
    [void]$existingRegions.Add($region)
    $addedRegions++
  }

  $json = $cases.ToArray()
  Write-Host "Auto-added region cases: $addedRegions (total regions in reference: $($existingRegions.Count))"
}

foreach ($item in $json) {
  if ([string]::IsNullOrWhiteSpace($item.input) -or [string]::IsNullOrWhiteSpace($item.country)) {
    Add-CaseError "Case '$($item.name)' has no input and/or no country; it cannot be recomputed."
    continue
  }

  try {
    if (-not ($item.PSObject.Properties.Name -contains 'csharpInternational')) {
      $item | Add-Member -NotePropertyName csharpInternational -NotePropertyValue ''
    }
    if (-not ($item.PSObject.Properties.Name -contains 'csharpNational')) {
      $item | Add-Member -NotePropertyName csharpNational -NotePropertyValue ''
    }
    if (-not ($item.PSObject.Properties.Name -contains 'csharpRfc3966')) {
      $item | Add-Member -NotePropertyName csharpRfc3966 -NotePropertyValue ''
    }
    if (-not ($item.PSObject.Properties.Name -contains 'javaInternational')) {
      $item | Add-Member -NotePropertyName javaInternational -NotePropertyValue ''
    }
    if (-not ($item.PSObject.Properties.Name -contains 'javaNational')) {
      $item | Add-Member -NotePropertyName javaNational -NotePropertyValue ''
    }
    if (-not ($item.PSObject.Properties.Name -contains 'javaRfc3966')) {
      $item | Add-Member -NotePropertyName javaRfc3966 -NotePropertyValue ''
    }

    $parsed = $util.Parse([string]$item.input, [string]$item.country)
    $e164 = $util.Format($parsed, [PhoneNumbers.PhoneNumberFormat]::E164)
    $international = $util.Format($parsed, [PhoneNumbers.PhoneNumberFormat]::INTERNATIONAL)
    $national = $util.Format($parsed, [PhoneNumbers.PhoneNumberFormat]::NATIONAL)
    $rfc3966 = $util.Format($parsed, [PhoneNumbers.PhoneNumberFormat]::RFC3966)

    $item.csharpE164 = [string]$e164
    $item.csharpInternational = [string]$international
    $item.csharpNational = [string]$national
    $item.csharpRfc3966 = [string]$rfc3966

    # Auto-generated region cases never carry hand-curated Java values: their java*
    # fields were only ever backfilled from the oracle, so they are always refreshed.
    # Curated cases keep the preserve-if-non-empty rule.
    $isAutoGeneratedCase = ([string]$item.name).EndsWith(' auto example', [System.StringComparison]::OrdinalIgnoreCase)

    if ($isAutoGeneratedCase -or [string]::IsNullOrWhiteSpace([string]$item.javaE164)) {
      $item.javaE164 = [string]$e164
    }
    if ($isAutoGeneratedCase -or [string]::IsNullOrWhiteSpace([string]$item.javaInternational)) {
      $item.javaInternational = [string]$international
    }
    if ($isAutoGeneratedCase -or [string]::IsNullOrWhiteSpace([string]$item.javaNational)) {
      $item.javaNational = [string]$national
    }
    if ($isAutoGeneratedCase -or [string]::IsNullOrWhiteSpace([string]$item.javaRfc3966)) {
      $item.javaRfc3966 = [string]$rfc3966
    }
  }
  catch {
    Add-CaseError "Case '$($item.name)' failed: $($_.Exception.Message)"
  }
}

if ($caseErrors.Count -gt 0) {
  Write-Host ""
  Write-Host "Case errors ($($caseErrors.Count)):"
  foreach ($caseError in $caseErrors) {
    Write-Host "  - $caseError"
  }

  if (-not $AllowPartial) {
    throw ("$($caseErrors.Count) reference case(s) could not be recomputed; refusing to write $ReferenceFile. " +
      "Writing anyway would keep the previous - possibly stale - expectations for those cases while every other " +
      "case is refreshed. Fix the cases (or the oracle pin) and re-run; pass -AllowPartial only for a deliberate, " +
      "documented exception.")
  }

  Write-Warning "-AllowPartial is set: writing the corpus although $($caseErrors.Count) case(s) could not be recomputed."
}

$json = @($json | Sort-Object country, name)

$written = Write-JsonFile -InputObject $json -Path $ReferenceFile -Depth 8 -ForceWrite:$ForceWrite
if ($written) {
  Write-Host "Updated reference cases in: $ReferenceFile"
} else {
  Write-Host "Reference cases unchanged: $ReferenceFile"
}
