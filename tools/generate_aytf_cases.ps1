param(
  [string]$OutputFile = "",
  # Empty means "the canonical pin"; see tools/oracle_helpers.ps1, Get-OraclePin.
  [string]$PackageId = "",
  [string]$PackageVersion = "",
  [string]$TargetFramework = "",
  [string]$OracleRoot = ""
)

<#
  Generates tests/data/aytf_reference_cases.json from the C# NuGet oracle.

  Every expectation of the AsYouTypeFormatter test surface - AsYouTypeFormatter
  sequences, remembered positions, clear/reuse, the mass smoke table,
  formatNumberForMobileDialing and formatOutOfCountryKeepingAlphaChars - is
  COMPUTED here and never copied out of AsYouTypeFormatterTest.java or
  PhoneNumberUtilTest.java. Those suites run against
  PhoneNumberMetadataForTesting.xml, which differs from the shipped metadata
  (see AGENTS.md, "Test Expectations"); only the test IDEAS are taken from
  upstream.

  The oracle assembly is the cache tools/generate_reference_cases.ps1 restores
  (tools/.nuget-oracle/); run that script first if the cache is missing.

  Requires PowerShell 7 (pwsh) because the oracle targets net8.0.
#>

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "oracle_helpers.ps1")

$PackageId = Resolve-OraclePinValue -Value $PackageId -Name "PackageId"
$PackageVersion = Resolve-OraclePinValue -Value $PackageVersion -Name "PackageVersion"
$TargetFramework = Resolve-OraclePinValue -Value $TargetFramework -Name "TargetFramework"

if ($PSVersionTable.PSEdition -eq "Desktop") {
  throw "This script requires PowerShell 7+ (pwsh); the NuGet oracle targets '$TargetFramework'."
}

$repoRoot = Split-Path -Parent $PSScriptRoot

$OracleRoot = Get-OracleCacheRoot -Root $OracleRoot
if ([string]::IsNullOrWhiteSpace($OutputFile)) {
  $OutputFile = Join-Path $repoRoot "tests\data\aytf_reference_cases.json"
}

# -NoRestore: this is a follow-up generator on the cache the reference generator
# restores, so a missing cache is an instruction to run that one first, not a
# reason to spend a dotnet publish here.
$assemblyPath = Get-OracleAssemblyPath -Root $OracleRoot -Id $PackageId -Version $PackageVersion `
  -Framework $TargetFramework -NoRestore -Quiet
$loadedOracle = Import-OracleAssembly -AssemblyPath $assemblyPath -ExpectedPackageVersion $PackageVersion -Quiet
$loadedVersion = $loadedOracle.Version

Write-Host "AYTF reference generator"
Write-Host ("  oracle : {0} ({1})" -f $assemblyPath, $loadedVersion)
Write-Host ("  output : {0}" -f $OutputFile)

$util = [PhoneNumbers.PhoneNumberUtil]::GetInstance()

function New-Sequence {
  param([string]$Name, [string]$Region, [string]$Typed, [string]$Comment = "")

  $formatter = $util.GetAsYouTypeFormatter($Region)
  $outputs = New-Object System.Collections.Generic.List[string]
  foreach ($ch in $Typed.ToCharArray()) {
    [void]$outputs.Add($formatter.InputDigit($ch))
  }
  return [ordered]@{
    name    = $Name
    region  = $Region
    input   = $Typed
    comment = $Comment
    outputs = @($outputs)
  }
}

function New-RememberSequence {
  param([string]$Name, [string]$Region, [string]$Typed, [int[]]$RememberIndices, [string]$Comment = "")

  $formatter = $util.GetAsYouTypeFormatter($Region)
  $outputs = New-Object System.Collections.Generic.List[string]
  $positions = New-Object System.Collections.Generic.List[int]
  $chars = $Typed.ToCharArray()
  for ($i = 0; $i -lt $chars.Length; $i++) {
    if ($RememberIndices -contains $i) {
      [void]$outputs.Add($formatter.InputDigitAndRememberPosition($chars[$i]))
    } else {
      [void]$outputs.Add($formatter.InputDigit($chars[$i]))
    }
    [void]$positions.Add($formatter.GetRememberedPosition())
  }
  return [ordered]@{
    name            = $Name
    region          = $Region
    input           = $Typed
    comment         = $Comment
    rememberIndices = @($RememberIndices)
    outputs         = @($outputs)
    positions       = @($positions)
  }
}

# ---------------------------------------------------------------------------
# AsYouTypeFormatter sequences. Test ideas from
# vendor/libphonenumber/java/libphonenumber/test/.../AsYouTypeFormatterTest.java;
# every expectation recomputed here against the SHIPPED metadata.
# ---------------------------------------------------------------------------
$sequences = @(
  (New-Sequence -Name "US international with plus" -Region "US" -Typed "+16502532222" `
     -Comment "testAYTFUS idea: the plus branch, attemptToExtractIdd plus attemptToExtractCountryCallingCode."),
  (New-Sequence -Name "US national with national prefix" -Region "US" -Typed "16502532222" `
     -Comment "isNanpaNumberWithNationalPrefix: the leading 1 becomes the national prefix."),
  (New-Sequence -Name "US national without national prefix" -Region "US" -Typed "6502532222" `
     -Comment "Plain national entry, no prefix extraction."),
  (New-Sequence -Name "US IDD 011 to GB" -Region "US" -Typed "01144212345678" `
     -Comment "testAYTFLongIDD idea: IDD 011 plus country calling code 44, currentMetadata switches to GB."),
  (New-Sequence -Name "US star short code" -Region "US" -Typed "*121#" `
     -Comment "testAYTFUSMobileShortCode idea: a non digit turns formatting off for good (inputHasFormatting)."),
  (New-Sequence -Name "US vanity with spaces" -Region "US" -Typed "800 MY APPLE" `
     -Comment "testAYTFUSVanityNumber idea: alpha input is echoed unformatted."),
  (New-Sequence -Name "DE national Berlin" -Region "DE" -Typed "030123456" `
     -Comment "testAYTFDE idea, recomputed on the shipped metadata."),
  (New-Sequence -Name "DE international with plus" -Region "DE" -Typed "+4930123456" -Comment ""),
  (New-Sequence -Name "DE mobile national" -Region "DE" -Typed "015112345678" -Comment ""),
  (New-Sequence -Name "GB mobile national" -Region "GB" -Typed "07912345678" `
     -Comment "testAYTFGBFixedLine idea for the mobile range."),
  (New-Sequence -Name "GB fixed line national" -Region "GB" -Typed "02012345678" -Comment ""),
  (New-Sequence -Name "GB international with plus" -Region "GB" -Typed "+447912345678" -Comment ""),
  (New-Sequence -Name "ZZ unknown region with plus" -Region "ZZ" -Typed "+48881231" `
     -Comment "testInvalidRegion idea: EMPTY_METADATA fallback, formatting only works through the plus branch."),
  (New-Sequence -Name "ZZ unknown region national" -Region "ZZ" -Typed "650253" `
     -Comment "testInvalidRegion idea, second half: no metadata, so nothing is formatted."),
  (New-Sequence -Name "ZZ plus sign in the middle" -Region "ZZ" -Typed "+48881231+2" `
     -Comment "testInvalidPlusSign idea: a plus is only a plus at position one."),
  (New-Sequence -Name "JP multiple leading digit patterns" -Region "JP" -Typed "+815023456789" `
     -Comment "testAYTFMultipleLeadingDigitPatterns idea."),
  (New-Sequence -Name "International toll free from US" -Region "US" -Typed "+800123456789" `
     -Comment "testAYTF_International_Toll_Free idea: the non geographical entity 800."),
  (New-Sequence -Name "BR national" -Region "BR" -Typed "01131234567" `
     -Comment "National prefix plus carrier code shape; ableToExtractLongerNdd territory."),
  (New-Sequence -Name "AU long IDD" -Region "AU" -Typed "0011541234567" `
     -Comment "testAYTFLongIDD_AU idea: AU has a multi branch internationalPrefix."),
  (New-Sequence -Name "KR long NDD" -Region "KR" -Typed "0212345678" `
     -Comment "testAYTFLongNDD_KR idea.")
)

$rememberSequences = @(
  (New-RememberSequence -Name "US remember first and fourth digit" -Region "US" -Typed "16502532222" -RememberIndices @(0, 3) `
     -Comment "testAYTFAndRememberPositionUS idea: the remembered position moves as separators are inserted."),
  (New-RememberSequence -Name "US remember after plus" -Region "US" -Typed "+16502532222" -RememberIndices @(4) -Comment ""),
  (New-RememberSequence -Name "US remember then formatting char" -Region "US" -Typed "650253*22" -RememberIndices @(1) `
     -Comment "Once ableToFormat is false getRememberedPosition returns the ORIGINAL position instead."),
  (New-RememberSequence -Name "DE remember area code digit" -Region "DE" -Typed "03012345678" -RememberIndices @(2) -Comment "")
)

# Clear/reuse: two sequences on ONE formatter instance with clear() in between.
$clearCases = @()
foreach ($pair in @(
    @{ name = "US national twice on one formatter"; region = "US"; first = "6502532222"; second = "6502532222" },
    @{ name = "US plus then national"; region = "US"; first = "+16502532222"; second = "6502532222" },
    @{ name = "US IDD then national"; region = "US"; first = "01144212345678"; second = "6502532222" }
  )) {
  $formatter = $util.GetAsYouTypeFormatter($pair.region)
  $first = New-Object System.Collections.Generic.List[string]
  foreach ($ch in ([string]$pair.first).ToCharArray()) { [void]$first.Add($formatter.InputDigit($ch)) }
  $formatter.Clear()
  $second = New-Object System.Collections.Generic.List[string]
  foreach ($ch in ([string]$pair.second).ToCharArray()) { [void]$second.Add($formatter.InputDigit($ch)) }
  $clearCases += [ordered]@{
    name          = $pair.name
    region        = $pair.region
    firstInput    = $pair.first
    firstOutputs  = @($first)
    secondInput   = $pair.second
    secondOutputs = @($second)
  }
}

# ---------------------------------------------------------------------------
# Mass smoke: type the E164 spelling of each region's example number one
# character at a time and record only the FINAL output.
# ---------------------------------------------------------------------------
$smokeRegions = @("US", "CA", "GB", "DE", "FR", "IT", "ES", "NL", "CH", "AT",
                  "BE", "SE", "PL", "PT", "IE", "AU", "NZ", "JP", "BR", "AR",
                  "MX", "IN", "ZA", "KR")
$smoke = @()
foreach ($region in $smokeRegions) {
  $example = $util.GetExampleNumber($region)
  if ($null -eq $example) { throw "No example number for region $region." }
  $e164 = $util.Format($example, [PhoneNumbers.PhoneNumberFormat]::E164)
  $formatter = $util.GetAsYouTypeFormatter($region)
  $last = ""
  foreach ($ch in $e164.ToCharArray()) { $last = $formatter.InputDigit($ch) }
  $smoke += [ordered]@{
    region   = $region
    input    = $e164
    expected = $last
  }
}

# ---------------------------------------------------------------------------
# formatNumberForMobileDialing. Ideas from PhoneNumberUtilTest
# testFormatNumberForMobileDialing; the regional special cases the SHIPPED
# upstream still has are BR (carrier code), NANPA, the non geographical
# entities and MX/CL/UZ.
# ---------------------------------------------------------------------------
$mobileSpecs = @(
  @{ name = "US from US with formatting";      number = "+1 650 253 0000";    region = "US"; from = "US";  fmt = $true;  keepRaw = $false },
  @{ name = "US from US without formatting";   number = "+1 650 253 0000";    region = "US"; from = "US";  fmt = $false; keepRaw = $false },
  @{ name = "US from GB with formatting";      number = "+1 650 253 0000";    region = "US"; from = "GB";  fmt = $true;  keepRaw = $false },
  @{ name = "US from GB without formatting";   number = "+1 650 253 0000";    region = "US"; from = "GB";  fmt = $false; keepRaw = $false },
  @{ name = "US from DE";                      number = "+1 650 253 0000";    region = "US"; from = "DE";  fmt = $true;  keepRaw = $false },
  @{ name = "BR from BR without carrier code"; number = "+55 11 3121-2869";   region = "BR"; from = "BR";  fmt = $true;  keepRaw = $false },
  @{ name = "BR from BR with carrier code";    number = "012 3121286979";     region = "BR"; from = "BR";  fmt = $true;  keepRaw = $true },
  @{ name = "BR from US";                      number = "+55 11 3121-2869";   region = "BR"; from = "US";  fmt = $true;  keepRaw = $false },
  @{ name = "MX from MX";                      number = "+52 1 33 1234 5678"; region = "MX"; from = "MX";  fmt = $true;  keepRaw = $false },
  @{ name = "MX from US";                      number = "+52 1 33 1234 5678"; region = "MX"; from = "US";  fmt = $true;  keepRaw = $false },
  @{ name = "CL from CL";                      number = "+56 2 2123 4567";    region = "CL"; from = "CL";  fmt = $true;  keepRaw = $false },
  @{ name = "UZ from UZ";                      number = "+998 71 123 4567";   region = "UZ"; from = "UZ";  fmt = $true;  keepRaw = $false },
  @{ name = "DE from DE";                      number = "+49 30 1234567";     region = "DE"; from = "DE";  fmt = $true;  keepRaw = $false },
  @{ name = "DE from US";                      number = "+49 30 1234567";     region = "DE"; from = "US";  fmt = $true;  keepRaw = $false },
  @{ name = "GB from GB";                      number = "+44 20 7031 3000";   region = "GB"; from = "GB";  fmt = $true;  keepRaw = $false },
  @{ name = "Non geo 800 from US";             number = "+800 1234 5678";     region = "US"; from = "US";  fmt = $true;  keepRaw = $false },
  @{ name = "Non geo 800 from 001";            number = "+800 1234 5678";     region = "US"; from = "001"; fmt = $true;  keepRaw = $false }
)
$mobile = @()
foreach ($spec in $mobileSpecs) {
  if ($spec.keepRaw) {
    $number = $util.ParseAndKeepRawInput([string]$spec.number, [string]$spec.region)
  } else {
    $number = $util.Parse([string]$spec.number, [string]$spec.region)
  }
  $mobile += [ordered]@{
    name              = $spec.name
    input             = $spec.number
    region            = $spec.region
    regionCallingFrom = $spec.from
    withFormatting    = [bool]$spec.fmt
    keepRawInput      = [bool]$spec.keepRaw
    expected          = $util.FormatNumberForMobileDialing($number, [string]$spec.from, [bool]$spec.fmt)
  }
}

# ---------------------------------------------------------------------------
# formatOutOfCountryKeepingAlphaChars. Idea from PhoneNumberUtilTest
# testFormatOutOfCountryKeepingAlphaChars.
# ---------------------------------------------------------------------------
$alphaSpecs = @(
  @{ name = "1-800-FLOWERS from US";     raw = "1-800-FLOWERS";  region = "US"; from = "US" },
  @{ name = "1-800-FLOWERS from GB";     raw = "1-800-FLOWERS";  region = "US"; from = "GB" },
  @{ name = "1-800-FLOWERS from DE";     raw = "1-800-FLOWERS";  region = "US"; from = "DE" },
  @{ name = "1-800-FLOWERS from CA";     raw = "1-800-FLOWERS";  region = "US"; from = "CA" },
  @{ name = "1-800-FLOWERS from ZZ";     raw = "1-800-FLOWERS";  region = "US"; from = "ZZ" },
  @{ name = "1-800-SIX-FLAG from AU";    raw = "1-800-SIX-FLAG"; region = "US"; from = "AU" },
  @{ name = "GB national from GB";       raw = "020 7031 3000";  region = "GB"; from = "GB" },
  @{ name = "GB national from US";       raw = "020 7031 3000";  region = "GB"; from = "US" },
  @{ name = "DE slash grouping from DE"; raw = "030/1234567";    region = "DE"; from = "DE" },
  @{ name = "DE slash grouping from GB"; raw = "030/1234567";    region = "DE"; from = "GB" },
  @{ name = "US alpha with extension from GB"; raw = "1-800-FLOWERS ext. 1234"; region = "US"; from = "GB" },
  # The ambiguous "X" branch of the restricted extension scanner, and with it
  # the isViablePhoneNumber guard in front of it (the prefix "800-FLOWERS" is
  # viable, so the extension must still be stripped from the raw input).
  @{ name = "US alpha with X extension from GB"; raw = "1-800-FLOWERS X 12"; region = "US"; from = "GB" }
)
$alpha = @()
foreach ($spec in $alphaSpecs) {
  $number = $util.ParseAndKeepRawInput([string]$spec.raw, [string]$spec.region)
  $alpha += [ordered]@{
    name              = $spec.name
    rawInput          = $spec.raw
    region            = $spec.region
    regionCallingFrom = $spec.from
    expected          = $util.FormatOutOfCountryKeepingAlphaChars($number, [string]$spec.from)
  }
}

$document = [ordered]@{
  generator         = "tools/generate_aytf_cases.ps1"
  oraclePackage     = ("{0} {1}" -f $PackageId, $PackageVersion)
  oracleAssembly    = $loadedVersion
  note              = "Generated expectations. Test IDEAS come from the upstream Java suites; every value here is computed against the SHIPPED metadata by the C# NuGet oracle, never copied from PhoneNumberMetadataForTesting.xml based tests."
  aytfSequences     = @($sequences)
  aytfRemember      = @($rememberSequences)
  aytfClear         = @($clearCases)
  aytfSmoke         = @($smoke)
  mobileDialing     = @($mobile)
  keepingAlphaChars = @($alpha)
}

$json = $document | ConvertTo-Json -Depth 12
$outDir = Split-Path -Parent $OutputFile
if (-not (Test-Path -LiteralPath $outDir)) { [void](New-Item -ItemType Directory -Path $outDir -Force) }
Set-Content -LiteralPath $OutputFile -Value $json -Encoding UTF8

Write-Host ("  wrote  : {0} sequences, {1} remember, {2} clear, {3} smoke, {4} mobile, {5} alpha" -f `
  $sequences.Count, $rememberSequences.Count, $clearCases.Count, $smoke.Count, $mobile.Count, $alpha.Count)
