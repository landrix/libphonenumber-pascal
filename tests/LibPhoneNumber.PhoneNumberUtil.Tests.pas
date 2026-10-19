unit LibPhoneNumber.PhoneNumberUtil.Tests;

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{ The test sources are pure ASCII and spell every non ASCII character as a
  numeric constant (#$XXXX). Without a source code page FreePascal converts
  such a constant to an AnsiString `string` at COMPILE time through its
  default code page and turns every character outside it into '?'. UTF-8
  as the source code page makes that conversion lossless and matches the
  UTF-8 string contract of the library on FreePascal. }
{$CODEPAGE UTF8}
{ Implicit UnicodeString <-> AnsiString conversions are the documented
  string contract here: the runner sets the UTF-8 conversion code page, so
  they are lossless, and the warning would bury every other one. }
{$WARN 4105 OFF}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  Generics.Collections,
{$ELSE}
  System.Generics.Collections,
{$ENDIF}
  LibPhoneNumber.TestFramework,
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.MetadataFormat;

type
  TPhoneNumberUtilTests = class(TTestCase)
  private
    function FindGoldenCasesFile: string;
    function FindReferenceCasesFile: string;
    function ParseExpectedError(const AValue: string): TPhoneNumberParseError;
    { Parse helpers for the extended formatter tests: they assert the parse itself
      succeeded so the format assertions stay one liners. }
    function ParsedNumber(const AInput, ACountry: string): TPhoneNumber;
    function KeptNumber(const AInput, ACountry: string): TPhoneNumber;
    { Builds a string from code points so the non ASCII test data does
      not have to be written into this file. }
    function CodePoints(const ACodes: array of Integer): string;
  published
    procedure Parse_ReturnsFalse_WhenInputHasNoDigits;

    procedure Parse_StripsNonDigits_AndStoresNationalNumber;

    procedure Parse_SeparatesExtension_FromNationalNumber;

    procedure Parse_ExtensionMarkersFollowTheUpstreamExtnPattern;

    procedure Parse_HandlesInternationalPrefix00;

    procedure Parse_HandlesInternationalPrefix011_ForUS;

    procedure Parse_HandlesInternationalPrefix011_ForCA;

    procedure Parse_ParsesNationalInput_ForCA;

    procedure IsValidNumber_ReturnsTrue_WhenDigitsExist;

    procedure IsValidNumber_ReturnsFalse_WhenLengthIsInvalidForRegion;

    procedure IsPossibleNumber_ReturnsTrue_WhenLengthMatchesRegion;

    procedure IsPossibleNumber_ReturnsFalse_WhenLengthDoesNotMatchRegion;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForUSPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForCAPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForGBPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForDEPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForFRPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForITPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForESPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForNLPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForCHPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForATPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForAUPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForJPPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForINPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForPLPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForSEPattern;

    procedure IsValidNumber_IsStricterThanIsPossibleNumber_ForPTPattern;

    procedure Parse_PreservesLeadingZeroDigits_ForIT;

    procedure Format_E164_ReturnsPlusCountryCodeAndNationalNumber;

    procedure Format_International_US_ReturnsGrouped;

    procedure Format_International_CA_ReturnsGrouped;

    procedure Format_National_US_ReturnsParenthesized;

    procedure Format_National_CA_ReturnsParenthesized;

    procedure Format_International_GB_ReturnsGrouped;

    procedure Format_National_GB_ReturnsWithTrunkZero;

    procedure Format_International_DE_ReturnsGrouped;

    procedure Format_International_DE_FixedLine_ReturnsGrouped;

    procedure Format_InternationalLegacy_DE_ReturnsLegacyDisplay;

    procedure Format_InternationalLegacy_DE_FixedLine_ReturnsLegacyDisplay;

    procedure Format_National_DE_ReturnsWithTrunkZero;

    procedure Format_International_FR_ReturnsGrouped;

    procedure Format_National_FR_ReturnsWithTrunkZero;

    procedure Format_International_IT_ReturnsGrouped;

    procedure Format_National_IT_ReturnsGrouped;

    procedure Format_International_ES_ReturnsGrouped;

    procedure Format_National_ES_ReturnsGrouped;

    procedure Format_International_NL_ReturnsGrouped;

    procedure Format_National_NL_ReturnsWithTrunkZero;

    procedure Format_International_CH_ReturnsGrouped;

    procedure Format_National_CH_ReturnsWithTrunkZero;

    procedure Format_International_AT_ReturnsGrouped;

    procedure Format_International_PT_ReturnsGrouped;

    procedure Format_International_BE_ReturnsGrouped;

    procedure Format_International_IE_ReturnsGrouped;

    procedure Format_National_AT_ReturnsWithTrunkZero;

    procedure Format_National_PT_ReturnsGrouped;

    procedure Format_National_BE_ReturnsWithTrunkZero;

    procedure Format_National_IE_ReturnsWithTrunkZero;

    procedure Format_Rfc3966_US_ReturnsTelUri;

    procedure Format_Rfc3966_GB_ReturnsTelUri;

    procedure Format_Rfc3966_DE_ReturnsTelUri;

    procedure Format_Rfc3966_FR_ReturnsTelUri;

    procedure Format_Rfc3966_IT_ReturnsTelUri;

    procedure Format_Rfc3966_ES_ReturnsTelUri;

    procedure Format_Rfc3966_NL_ReturnsTelUri;

    procedure Format_Rfc3966_CH_ReturnsTelUri;

    procedure Format_Rfc3966_AT_ReturnsTelUri;

    procedure Format_Rfc3966_JP_ReturnsTelUri;

    procedure Format_Rfc3966_AU_ReturnsTelUri;

    procedure Format_Rfc3966_IN_ReturnsTelUri;

    procedure Format_Rfc3966_PL_ReturnsTelUri;

    procedure Format_Rfc3966_SE_ReturnsTelUri;

    procedure Format_Rfc3966_CA_ReturnsTelUri;

    procedure Format_Rfc3966_PT_ReturnsTelUri;

    procedure Format_Rfc3966_BE_ReturnsTelUri;

    procedure Format_Rfc3966_IE_ReturnsTelUri;

    procedure Format_Rfc3966_WithExtension_AppendsExtParameter;

    { Metadata driven formatting }
    procedure Format_International_WithExtension_AppendsTheExtensionPrefix;

    procedure Format_UsesTheMetadata_ForRegionsOutsideTheLegacyFormatterSet;

    procedure GoldenCases_FromJson;

    procedure ReferenceCases_JavaCSharp_AreConsistent;

    procedure ReferenceCases_JavaCSharp_DifferentialAgainstPort;

    procedure GeneratedMetadata_ProvenanceIsPresent;

    procedure GeneratedMetadata_CallingCodeTablesAreConsistent;

    procedure AlternateFormats_TableIsConsistent;

    procedure Parse_KeepsCallerRegion_ForSharedCallingCode;

    procedure Parse_ReturnsTooShortAfterIdd_WhenOnlyCallingCodePresent;

    procedure Parse_RejectsATrailingHashWithoutExtensionDigits;

    procedure Format_International_DE_Munich_ReturnsTwoDigitArea;

    procedure Format_National_DE_Munich_ReturnsTwoDigitArea;

    procedure IsValidNumber_RejectsNanpN11Codes;

    procedure Parse_DoesNotTreat00AsIdd_ForNanp;

    procedure Parse_ReturnsTooLongNsn_WhenDigitsExceedCapacity;

    { Metadata driven national prefix handling }
    procedure Parse_KeepsSignificantLeadingZero_WhenTerritoryHasNoNationalPrefix;

    procedure Parse_StripsNationalPrefix_WhenTerritoryDeclaresOne;

    procedure Parse_UsesMetadataIddPrefixes;

    { ParseAndKeepRawInput / CountryCodeSource }
    procedure ParseAndKeepRawInput_ReportsPlusSignSource;

    procedure ParseAndKeepRawInput_ReportsIddSource;

    procedure ParseAndKeepRawInput_ReportsSourceWithoutPlusSign;

    procedure ParseAndKeepRawInput_ReportsDefaultCountrySource;

    procedure Parse_LeavesCountryCodeSourceUnspecified;

    procedure Parse_LeavesRawInputEmpty;

    procedure Parse_UsesMainRegionMetadataAfterExplicitCallingCode;

    procedure Parse_RollsBackANationalPrefixStripThatIsTooShort;

    { Extended formatter API }
    procedure FormatOutOfCountryCallingNumber_MatchesTheOracle;

    procedure FormatOutOfCountryCallingNumber_NormalizesTheRegionArgument;

    procedure FormatNationalNumberWithCarrierCode_MatchesTheOracle;

    procedure FormatNationalNumberWithPreferredCarrierCode_PrefersTheParsedCode;

    procedure FormatByPattern_MatchesTheOracle;

    procedure FormatInOriginalFormat_MatchesTheOracle;

    procedure ReferenceCases_OutOfCountryComposesTheOracleStrings;

    procedure ReferenceCases_CarrierCodeFreeNationalFormatMatchesTheOracle;

    procedure ReferenceCases_InOriginalFormatMatchesTheOracle;

    { Entry path of parseHelper and isNumberMatch }
    procedure Parse_AppliesExtractPossibleNumber;

    procedure Parse_AppliesTheViabilityGate;

    procedure Parse_HandlesRfc3966PhoneContext;

    procedure Parse_AcceptsUnicodeDecimalDigits;

    procedure Parse_FillsTheExtensionFromEveryExtnBranch;

    procedure IsNumberMatch_CompareTwoNumbers;

    procedure IsNumberMatch_CompareTwoStrings;

    procedure IsNumberMatch_CompareNumberAndString;

    { Parse driver details }
    procedure Parse_RetriesCountryCodeExtractionWithoutPlus;

    procedure Parse_SupplementaryCharactersFollowJavaNotTheOracle;

    procedure Parse_ExtensionLabelsUseTheJavaCaseFoldingClosure;

    procedure IsNumberMatch_CanonicalisesItsOperands;

    { Accessory API. Every expected value below was read off the NuGet oracle
      libphonenumber-csharp 9.0.41 against the PRODUCTION metadata (the probe
      parses "+<cc><nsn>" in region ZZ, which is what these tests do as
      well); the one Java only method is checked by its contract. }
    procedure Accessory_ExampleNumbersMatchTheOracle;

    procedure Accessory_InvalidExampleNumberKeepsItsContract;

    procedure Accessory_SupportedTypesMatchTheOracle;

    procedure Accessory_GeographyAndCodeLengthsMatchTheOracle;

    procedure Accessory_TruncateTooLongNumberMatchesTheOracle;

    procedure Accessory_AlphaNumberMobileTokenAndNsnMatchTheOracle;

    procedure Accessory_RegionArgumentsAreCanonicalised;

    procedure Accessory_NationalSignificantNumberMatchesTheOracle;
  end;

implementation

uses
{$IFDEF FPC}
  SysUtils,
  Classes,
  StrUtils,
{$ELSE}
  System.SysUtils,
  System.Classes,
  System.StrUtils,
{$ENDIF}
  LibPhoneNumber.TestJson,
  LibPhoneNumber.PhoneNumberUtil,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.ShortMetadata,
  LibPhoneNumber.AlternateFormats,
  { Provenance only. This unit does NOT switch the metadata source; see
    GeneratedMetadata_ProvenanceIsPresent. }
  LibPhoneNumber.TestingMetadata;

function TPhoneNumberUtilTests.FindGoldenCasesFile: string;
const
  FileName = 'core_golden_cases.json';
begin
  { tests/data is searched upwards from the executable and from the
    current directory (LibPhoneNumber.TestJson.FindTestDataFile). }
  Result := FindTestDataFile(FileName);
  if Result <> '' then
    Exit;

  Assert.Fail('Golden case file not found: tests/data/' + FileName);
  Result := '';
end;

function TPhoneNumberUtilTests.FindReferenceCasesFile: string;
const
  FileName = 'reference_cases_java_csharp.json';
begin
  { tests/data is searched upwards from the executable and from the
    current directory (LibPhoneNumber.TestJson.FindTestDataFile). }
  Result := FindTestDataFile(FileName);
  if Result <> '' then
    Exit;

  Assert.Fail('Reference case file not found: tests/data/' + FileName);
  Result := '';
end;

{ ---------------------------------------------------------------------------
  Metadata driven formatting
  --------------------------------------------------------------------------- }

procedure TPhoneNumberUtilTests.Format_International_WithExtension_AppendsTheExtensionPrefix;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { Upstream behaviour: maybeAppendFormattedExtension runs for EVERY format,
    not only for RFC3966. Germany declares no
    preferredExtnPrefix, so the upstream default " ext. " applies. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 30 123456 ext. 42', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('42', Parsed.Extension);

  Assert.AreEqual('+49 30 123456 ext. 42', TPhoneNumberUtil.Format(Parsed, pnfInternational));
  Assert.AreEqual('030 123456 ext. 42', TPhoneNumberUtil.Format(Parsed, pnfNational));
  Assert.AreEqual('tel:+49-30-123456;ext=42', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
  { E164 never carries an extension, upstream returns early for it. }
  Assert.AreEqual('+4930123456', TPhoneNumberUtil.Format(Parsed, pnfE164));
end;

procedure TPhoneNumberUtilTests.Format_UsesTheMetadata_ForRegionsOutsideTheLegacyFormatterSet;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { Argentina is the hardest case in the corpus:
    its NATIONAL layout drops the mobile 9 and injects a literal 15, while the
    international layout keeps the 9. Oracle values of the reference corpus
    entry "AR auto example". }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+5491123456789', 'AR', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));

  Assert.AreEqual('+54 9 11 2345-6789', TPhoneNumberUtil.Format(Parsed, pnfInternational));
  Assert.AreEqual('011 15-2345-6789', TPhoneNumberUtil.Format(Parsed, pnfNational));
  Assert.AreEqual('tel:+54-9-11-2345-6789', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));

  { Taiwan. Oracle values of
    the reference corpus entry "TW auto example". }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+886912345678', 'TW', Parsed, ParseError));
  Assert.AreEqual('+886 912 345 678', TPhoneNumberUtil.Format(Parsed, pnfInternational));
  Assert.AreEqual('0912 345 678', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.GoldenCases_FromJson;
var
  FilePath: string;
  RawJson: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  I: Integer;
  CaseObj: TJSONObject;
  CaseName: string;
  Input: string;
  Country: string;
  ShouldParse: Boolean;
  ShouldBeValid: Boolean;
  ExpectedRegion: string;
  ExpectedNationalNumber: UInt64;
  ExpectedNationalNumberDigits: string;
  ExpectedError: TPhoneNumberParseError;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  ParseResult: Boolean;
begin
  FilePath := FindGoldenCasesFile;
  RawJson := ReadUtf8File(FilePath);
  JsonValue := TJSONObject.ParseJSONValue(RawJson);
  try
    Assert.IsNotNull(JsonValue, 'Could not parse JSON in ' + FilePath);
    Assert.IsTrue(JsonValue is TJSONArray, 'Root JSON value must be an array.');
    Cases := JsonValue as TJSONArray;

    Assert.IsTrue(Cases.Count >= 20, 'Expected at least 20 golden test cases.');

    for I := 0 to Cases.Count - 1 do
    begin
      Assert.IsTrue(Cases.Items[I] is TJSONObject, 'Each case must be a JSON object.');
      CaseObj := Cases.Items[I] as TJSONObject;

      CaseName := CaseObj.GetString('name');
      Input := CaseObj.GetString('input');
      Country := CaseObj.GetString('country');
      ShouldParse := CaseObj.GetBoolean('shouldParse');
      ShouldBeValid := CaseObj.GetBoolean('shouldBeValid');
      ExpectedRegion := CaseObj.GetString('expectedRegion');
      // expectedNationalNumber is the national SIGNIFICANT number exactly as
      // Java/C# report it, so it is compared as a digit string first. The
      // numeric comparison alone would silently accept a lost leading zero.
      ExpectedNationalNumberDigits := CaseObj.GetString('expectedNationalNumber');
      ExpectedNationalNumber := StrToUInt64Def(ExpectedNationalNumberDigits, 0);
      ExpectedError := ParseExpectedError(CaseObj.GetString('expectedError'));

      ParseResult := TPhoneNumberUtil.Parse(Input, Country, Parsed, ParseError);

      Assert.AreEqual(ShouldParse, ParseResult, CaseName + ' parse result mismatch');
      Assert.AreEqual(Ord(ExpectedError), Ord(ParseError), CaseName + ' parse error mismatch');
      Assert.AreEqual(ShouldBeValid, TPhoneNumberUtil.IsValidNumber(Input, Country), CaseName + ' valid result mismatch');

      if ParseResult then
      begin
        Assert.AreEqual(ExpectedRegion, Parsed.RegionCode, CaseName + ' region mismatch');
        Assert.AreEqual(ExpectedNationalNumberDigits, Parsed.NationalNumberDigits, CaseName + ' national number digits mismatch');
        Assert.AreEqual<UInt64>(ExpectedNationalNumber, Parsed.NationalNumber, CaseName + ' national number mismatch');
      end;
    end;
  finally
    JsonValue.Free;
  end;
end;

procedure TPhoneNumberUtilTests.ReferenceCases_JavaCSharp_AreConsistent;
var
  FilePath: string;
  RawJson: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  I: Integer;
  CaseObj: TJSONObject;
  CaseName: string;
  JavaE164: string;
  CSharpE164: string;
  JavaInternational: string;
  CSharpInternational: string;
  JavaNational: string;
  CSharpNational: string;
  JavaRfc3966: string;
  CSharpRfc3966: string;
begin
  FilePath := FindReferenceCasesFile;
  RawJson := ReadUtf8File(FilePath);
  JsonValue := TJSONObject.ParseJSONValue(RawJson);
  try
    Assert.IsNotNull(JsonValue, 'Could not parse JSON in ' + FilePath);
    Assert.IsTrue(JsonValue is TJSONArray, 'Root JSON value must be an array.');
    Cases := JsonValue as TJSONArray;
    Assert.IsTrue(Cases.Count >= 10, 'Expected at least 10 reference cases.');

    for I := 0 to Cases.Count - 1 do
    begin
      Assert.IsTrue(Cases.Items[I] is TJSONObject, 'Each case must be a JSON object.');
      CaseObj := Cases.Items[I] as TJSONObject;

      CaseName := CaseObj.GetString('name');
      JavaE164 := CaseObj.GetString('javaE164');
      CSharpE164 := CaseObj.GetString('csharpE164');
      if not CaseObj.TryGetString('javaInternational', JavaInternational) then
        JavaInternational := '';
      if not CaseObj.TryGetString('csharpInternational', CSharpInternational) then
        CSharpInternational := '';
      if not CaseObj.TryGetString('javaNational', JavaNational) then
        JavaNational := '';
      if not CaseObj.TryGetString('csharpNational', CSharpNational) then
        CSharpNational := '';
      if not CaseObj.TryGetString('javaRfc3966', JavaRfc3966) then
        JavaRfc3966 := '';
      if not CaseObj.TryGetString('csharpRfc3966', CSharpRfc3966) then
        CSharpRfc3966 := '';

      Assert.IsTrue(JavaE164.StartsWith('+'), CaseName + ' invalid javaE164 value');
      Assert.IsTrue(CSharpE164.StartsWith('+'), CaseName + ' invalid csharpE164 value');
      Assert.AreEqual(JavaE164, CSharpE164, CaseName + ' Java/C# mismatch');

      if (JavaInternational <> '') or (CSharpInternational <> '') then
      begin
        Assert.IsTrue(JavaInternational <> '', CaseName + ' invalid javaInternational value');
        Assert.IsTrue(CSharpInternational <> '', CaseName + ' invalid csharpInternational value');
        Assert.AreEqual(JavaInternational, CSharpInternational, CaseName + ' Java/C# international mismatch');
      end;

      if (JavaNational <> '') or (CSharpNational <> '') then
      begin
        Assert.IsTrue(JavaNational <> '', CaseName + ' invalid javaNational value');
        Assert.IsTrue(CSharpNational <> '', CaseName + ' invalid csharpNational value');
        Assert.AreEqual(JavaNational, CSharpNational, CaseName + ' Java/C# national mismatch');
      end;

      if (JavaRfc3966 <> '') or (CSharpRfc3966 <> '') then
      begin
        Assert.IsTrue(JavaRfc3966.StartsWith('tel:'), CaseName + ' invalid javaRfc3966 value');
        Assert.IsTrue(CSharpRfc3966.StartsWith('tel:'), CaseName + ' invalid csharpRfc3966 value');
        Assert.AreEqual(JavaRfc3966, CSharpRfc3966, CaseName + ' Java/C# RFC3966 mismatch');
      end;
    end;
  finally
    JsonValue.Free;
  end;
end;

procedure TPhoneNumberUtilTests.ReferenceCases_JavaCSharp_DifferentialAgainstPort;
var
  FilePath: string;
  RawJson: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  I: Integer;
  CaseObj: TJSONObject;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  ParseResult: Boolean;
  PortE164: string;
  PortInternational: string;
  PortNational: string;
  PortRfc3966: string;
  CaseName: string;
  JavaInternational: string;
  JavaNational: string;
  JavaRfc3966: string;
  Divergences: TStringList;
begin
  FilePath := FindReferenceCasesFile;
  RawJson := ReadUtf8File(FilePath);
  JsonValue := TJSONObject.ParseJSONValue(RawJson);
  Divergences := TStringList.Create;
  try
    Assert.IsNotNull(JsonValue, 'Could not parse JSON in ' + FilePath);
    Assert.IsTrue(JsonValue is TJSONArray, 'Root JSON value must be an array.');
    Cases := JsonValue as TJSONArray;

    for I := 0 to Cases.Count - 1 do
    begin
      CaseObj := Cases.Items[I] as TJSONObject;
      CaseName := CaseObj.GetString('name');

      ParseResult := TPhoneNumberUtil.Parse(
        CaseObj.GetString('input'),
        CaseObj.GetString('country'),
        Parsed,
        ParseError
      );

      Assert.IsTrue(ParseResult, CaseName + ' parse failed for the port');
      Assert.AreEqual(Ord(pnpeNone), Ord(ParseError), CaseName + ' unexpected parse error');

      PortE164 := TPhoneNumberUtil.Format(Parsed, pnfE164);
      PortInternational := TPhoneNumberUtil.Format(Parsed, pnfInternational);
      PortNational := TPhoneNumberUtil.Format(Parsed, pnfNational);
      PortRfc3966 := TPhoneNumberUtil.Format(Parsed, pnfRfc3966);

      // E164 parity is asserted for EVERY reference case, auto generated
      // ones included. E164 output is pure parse fidelity (calling code plus
      // the complete national significant number), not formatting, so the
      // "auto cases are no formatter parity gate" rule does not apply to it.
      // This is the broad regression guard for the trunk zero class of defect.
      Assert.AreEqual(CaseObj.GetString('javaE164'), PortE164, CaseName + ' port E164 mismatch');

      // The same holds for the three FORMATTED representations: the metadata
      // driven engine covers every territory, so every case of the corpus is a
      // formatter parity gate. Divergences are collected
      // instead of asserted one by one so a single run reports the complete
      // picture.
      if CaseObj.TryGetString('javaInternational', JavaInternational)
        and (JavaInternational <> '') and (JavaInternational <> PortInternational) then
        Divergences.Add(CaseName + ' INTERNATIONAL: expected [' + JavaInternational
          + '] but got [' + PortInternational + ']');
      if CaseObj.TryGetString('javaNational', JavaNational)
        and (JavaNational <> '') and (JavaNational <> PortNational) then
        Divergences.Add(CaseName + ' NATIONAL: expected [' + JavaNational
          + '] but got [' + PortNational + ']');
      if CaseObj.TryGetString('javaRfc3966', JavaRfc3966)
        and (JavaRfc3966 <> '') and (JavaRfc3966 <> PortRfc3966) then
        Divergences.Add(CaseName + ' RFC3966: expected [' + JavaRfc3966
          + '] but got [' + PortRfc3966 + ']');
    end;

    if Divergences.Count > 0 then
      Assert.Fail(Format('%d of %d reference cases diverge from the Java/C# oracle:'#13#10'%s',
        [Divergences.Count, Cases.Count, Divergences.Text]));
  finally
    Divergences.Free;
    JsonValue.Free;
  end;
end;

{ Provenance of the GENERATED data sets; the generated units are the runtime
  path, so this is where the provenance has to be. }
procedure TPhoneNumberUtilTests.GeneratedMetadata_ProvenanceIsPresent;
begin
  { The PRODUCTION tables must be active here. MetadataVersion and friends
    report the ACTIVE data set, so a fixture that forgot its teardown
    would otherwise make this test read the testing tables. }
  Assert.IsTrue(IsProductionMetadataActive,
    'The production metadata must be active for this test.');

  Assert.IsTrue(MetadataVersion.StartsWith('metadata-v'),
    'Unexpected phone metadata generator version: ' + MetadataVersion);
  Assert.AreEqual(40, Length(MetadataUpstreamCommit),
    'Phone metadata commit is not a full git hash.');
  Assert.AreEqual('resources/PhoneNumberMetadata.xml', MetadataSourceName);
  Assert.IsTrue(GetTerritoryCount > 200,
    'Unexpected territory count: ' + IntToStr(GetTerritoryCount));

  Assert.IsTrue(ShortMetadataVersion.StartsWith('short-metadata-v'),
    'Unexpected short metadata generator version: ' + ShortMetadataVersion);
  Assert.AreEqual(40, Length(ShortMetadataUpstreamCommit),
    'Short metadata commit is not a full git hash.');
  Assert.AreEqual('resources/ShortNumberMetadata.xml', ShortMetadataSourceFileName);

  Assert.IsTrue(
    AlternateFormatsVersion.StartsWith('alternate-formats-v'),
    'Unexpected alternate formats generator version: ' + AlternateFormatsVersion);
  Assert.AreEqual(40, Length(AlternateFormatsUpstreamCommit),
    'Alternate formats commit is not a full git hash.');
  Assert.AreEqual('resources/PhoneNumberAlternateFormats.xml',
    AlternateFormatsSourceFileName);

  { The upstream TEST tables. They are never ACTIVE here - the fixture does not
    switch - so they are read through LibPhoneNumber.TestingMetadata,
    which reports the provenance of the generated testing units directly. }
  Assert.IsTrue(
    TestingMetadataVersion.StartsWith('testing-metadata-v'),
    'Unexpected testing metadata generator version: ' + TestingMetadataVersion);
  Assert.AreEqual(40, Length(TestingMetadataUpstreamCommit),
    'Testing metadata commit is not a full git hash.');
  Assert.AreEqual('resources/PhoneNumberMetadataForTesting.xml',
    TestingMetadataSourceName);

  { All FOUR data sets are generated from the SAME pinned vendor checkout. }
  Assert.AreEqual(MetadataUpstreamCommit, ShortMetadataUpstreamCommit);
  Assert.AreEqual(MetadataUpstreamCommit, AlternateFormatsUpstreamCommit);
  Assert.AreEqual(MetadataUpstreamCommit, TestingMetadataUpstreamCommit);
end;

function TPhoneNumberUtilTests.ParseExpectedError(
  const AValue: string): TPhoneNumberParseError;
begin
  if SameText(AValue, 'pnpeNone') then
    Exit(pnpeNone);
  if SameText(AValue, 'pnpeNotANumber') then
    Exit(pnpeNotANumber);
  if SameText(AValue, 'pnpeInvalidCountryCode') then
    Exit(pnpeInvalidCountryCode);
  if SameText(AValue, 'pnpeTooShortAfterIdd') then
    Exit(pnpeTooShortAfterIdd);
  if SameText(AValue, 'pnpeTooShortNsn') then
    Exit(pnpeTooShortNsn);
  if SameText(AValue, 'pnpeTooLongNsn') then
    Exit(pnpeTooLongNsn);

  Assert.Fail('Unknown parse error value: ' + AValue);
  Result := pnpeNotANumber;
end;

procedure TPhoneNumberUtilTests.Format_E164_ReturnsPlusCountryCodeAndNationalNumber;
var
  Parsed: TPhoneNumber;
begin
  Parsed := Default(TPhoneNumber);
  Parsed.CountryCode := 49;
  Parsed.NationalNumber := 1511234567;

  Assert.AreEqual('+491511234567', TPhoneNumberUtil.Format(Parsed, pnfE164));
end;

procedure TPhoneNumberUtilTests.Format_International_US_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 202 555 0123', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+1 202-555-0123', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_International_CA_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 506 234 5678', 'CA', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+1 506-234-5678', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_US_ReturnsParenthesized;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 202 555 0123', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('(202) 555-0123', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_National_CA_ReturnsParenthesized;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 506 234 5678', 'CA', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('(506) 234-5678', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_International_GB_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+44 20 7946 0321', 'GB', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+44 20 7946 0321', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_GB_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+44 20 7946 0321', 'GB', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('020 7946 0321', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_International_DE_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 151 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+49 1511234567', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_International_DE_FixedLine_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 351 8338916', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+49 351 8338916', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_InternationalLegacy_DE_ReturnsLegacyDisplay;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 151 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  // Mobile numbers have no separate area-code group, so nothing is bracketed.
  Assert.AreEqual('+49 1511234567', TPhoneNumberUtil.Format(Parsed, pnfInternationalLegacy));
end;

procedure TPhoneNumberUtilTests.Format_InternationalLegacy_DE_FixedLine_ReturnsLegacyDisplay;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 351 8338916', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+49 (351) 8338916', TPhoneNumberUtil.Format(Parsed, pnfInternationalLegacy));
end;

procedure TPhoneNumberUtilTests.Format_National_DE_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 151 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('1511234567', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_International_FR_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+33 1 42 68 53 00', 'FR', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+33 1 42 68 53 00', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_FR_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+33 1 42 68 53 00', 'FR', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('01 42 68 53 00', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_International_IT_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+39 347 123 4567', 'IT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+39 347 123 4567', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_IT_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+39 347 123 4567', 'IT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('347 123 4567', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_International_ES_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+34 612 34 56 78', 'ES', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+34 612 34 56 78', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_ES_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+34 612 34 56 78', 'ES', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('612 34 56 78', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_International_NL_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+31 6 12345678', 'NL', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+31 6 12345678', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_NL_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+31 6 12345678', 'NL', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('06 12345678', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_International_CH_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+41 44 668 18 00', 'CH', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+41 44 668 18 00', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_CH_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+41 44 668 18 00', 'CH', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('044 668 18 00', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

  { The Vienna number 1 2345678 is matched by the AT numberFormat
    for the one digit area code - pattern "one digit, then 3 to 12 digits",
    leadingDigits 1(?:11|[2-9]), format "$1 $2" - so upstream groups it as
    "1 2345678" and nationally as "01 2345678"; no AT numberFormat of the
    pinned baseline produces a 1+3+2+2 grouping.
    Source: vendor/libphonenumber/resources/PhoneNumberMetadata.xml,
    territory AT. }
procedure TPhoneNumberUtilTests.Format_International_AT_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+43 1 234 56 78', 'AT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+43 1 2345678', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_International_PT_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+351 912 345 678', 'PT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+351 912 345 678', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_International_BE_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+32 450 00 12 34', 'BE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+32 450 00 12 34', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_International_IE_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+353 85 012 3456', 'IE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+353 85 012 3456', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_AT_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+43 1 234 56 78', 'AT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  { See the note on Format_International_AT_ReturnsGrouped. }
  Assert.AreEqual('01 2345678', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_National_PT_ReturnsGrouped;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+351 912 345 678', 'PT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('912 345 678', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_National_BE_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+32 450 00 12 34', 'BE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('0450 00 12 34', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_National_IE_ReturnsWithTrunkZero;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+353 85 012 3456', 'IE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('085 012 3456', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_US_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 202 555 0123', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+1-202-555-0123', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_GB_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+44 20 7946 0321', 'GB', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+44-20-7946-0321', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_DE_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 151 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+49-1511234567', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_FR_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+33 1 42 68 53 00', 'FR', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+33-1-42-68-53-00', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_IT_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+39 347 123 4567', 'IT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+39-347-123-4567', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_ES_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+34 612 34 56 78', 'ES', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+34-612-34-56-78', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_NL_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+31 6 12345678', 'NL', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+31-6-12345678', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_CH_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+41 44 668 18 00', 'CH', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+41-44-668-18-00', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_AT_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+43 1 234 56 78', 'AT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  { See the note on Format_International_AT_ReturnsGrouped. }
  Assert.AreEqual('tel:+43-1-2345678', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_JP_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+81 3-1234-5678', 'JP', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+81-3-1234-5678', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_AU_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+61 2 9374 4000', 'AU', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+61-2-9374-4000', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_IN_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+91 98765 43210', 'IN', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+91-98765-43210', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_PL_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+48 501 234 567', 'PL', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+48-501-234-567', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_SE_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+46 70 123 45 67', 'SE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+46-70-123-45-67', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_CA_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 506 234 5678', 'CA', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+1-506-234-5678', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_PT_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+351 912 345 678', 'PT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+351-912-345-678', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_BE_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+32 450 00 12 34', 'BE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+32-450-00-12-34', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_IE_ReturnsTelUri;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+353 85 012 3456', 'IE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+353-85-012-3456', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.Format_Rfc3966_WithExtension_AppendsExtParameter;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 202 555 0123 ext. 99', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('tel:+1-202-555-0123;ext=99', TPhoneNumberUtil.Format(Parsed, pnfRfc3966));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_ReturnsTrue_WhenDigitsExist;
begin
  // Upstream requires eleven digits for the German 15x mobile ranges
  // (mobile pattern: 15(?:[0-25-9]\d\d|3(?:10|33))\d{6}), so the ten
  // digit +49 151 1234567 is not a valid number for Java.
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('+49 151 12345678', 'DE'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber('abc', 'DE'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_ReturnsFalse_WhenLengthIsInvalidForRegion;
begin
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber('+1 202 555', 'US'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber('+44 20 7', 'GB'));
end;

procedure TPhoneNumberUtilTests.IsPossibleNumber_ReturnsFalse_WhenLengthDoesNotMatchRegion;
begin
  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('+1 202 555', 'US'));
  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('+44 20 7', 'GB'));
end;

procedure TPhoneNumberUtilTests.IsPossibleNumber_ReturnsTrue_WhenLengthMatchesRegion;
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+1 202 555 0123', 'US'));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('01144 20 7946 0321', 'US'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForGBPattern;
const
  Candidate = '+44 50 7946 0321';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'GB'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'GB'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForDEPattern;
const
  // The candidate is the
  // ten digit 15x mobile number, which Java reports as IS_POSSIBLE but
  // invalid, because the 15x ranges require eleven digits.
  Candidate = '+49 1511234567';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'DE'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'DE'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForFRPattern;
const
  Candidate = '+33 001 426 8530';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'FR'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'FR'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForITPattern;
const
  Candidate = '+39 2123 4567';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'IT'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'IT'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForESPattern;
const
  Candidate = '+34 112345678';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'ES'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'ES'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForNLPattern;
const
  Candidate = '+31 0012345678';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'NL'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'NL'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForCHPattern;
const
  Candidate = '+41 0012345678';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'CH'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'CH'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForATPattern;
const
  Candidate = '+43 0012345678';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'AT'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'AT'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForAUPattern;
const
  Candidate = '+61 5 9374 4000';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'AU'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'AU'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForJPPattern;
const
  Candidate = '+81 00 1234 5678';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'JP'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'JP'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForINPattern;
const
  Candidate = '+91 00 98765 43210';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'IN'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'IN'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForPLPattern;
const
  Candidate = '+48 00 123 4567';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'PL'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'PL'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForSEPattern;
const
  Candidate = '+46 00 123 45 67';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'SE'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'SE'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForPTPattern;
const
  Candidate = '+351 412 345 678';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'PT'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'PT'));
end;

procedure TPhoneNumberUtilTests.Parse_PreservesLeadingZeroDigits_ForIT;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+39 02 12345678', 'IT', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('0212345678', Parsed.NationalNumberDigits);
  Assert.AreEqual('+390212345678', TPhoneNumberUtil.Format(Parsed, pnfE164));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForUSPattern;
const
  Candidate = '+1 123 555 0123';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'US'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'US'));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_IsStricterThanIsPossibleNumber_ForCAPattern;
const
  Candidate = '+1 123 555 0123';
begin
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber(Candidate, 'CA'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber(Candidate, 'CA'));
end;

procedure TPhoneNumberUtilTests.Parse_SeparatesExtension_FromNationalNumber;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 202 555 0123 ext. 99', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual<UInt64>(2025550123, Parsed.NationalNumber);
  Assert.AreEqual('99', Parsed.Extension);
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('+1 202 555 0123 ext. 99', 'US'));
end;

procedure TPhoneNumberUtilTests
  .Parse_ExtensionMarkersFollowTheUpstreamExtnPattern;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { Of the three markers 'extension:', German 'Durchwahl' and 'dw:' only the
    first exists in upstream EXTN_PATTERNS_FOR_PARSING. Every expectation below comes from the NuGet oracle
    (libphonenumber-csharp 9.0.38, productive metadata), never from
    PhoneNumberUtilTest.java. }

  { KEPT: 'extension:' is the explicit label branch. Oracle:
    Parse('+49 151 1234567 extension: 42', 'DE') -> nsn 1511234567, ext '42'. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 151 1234567 extension: 42', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual<UInt64>(1511234567, Parsed.NationalNumber);
  Assert.AreEqual('42', Parsed.Extension);

  { GONE: 'Durchwahl' is not an upstream extension label. It has three or more
    ASCII letters, so normalize() sends the whole string through
    ALPHA_PHONE_MAPPINGS and the national number becomes too long. Oracle:
    Parse('+49 151 1234567 Durchwahl 77', 'DE') throws TOO_LONG. }
  Assert.IsFalse(TPhoneNumberUtil.Parse('+49 151 1234567 Durchwahl 77', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeTooLongNsn), Ord(ParseError));

  { GONE: 'dw:' is not a label either, and the colon is not in
    VALID_PUNCTUATION, so the string is not even viable. Oracle:
    Parse('+49 151 1234567 dw: 9', 'DE') throws NOT_A_NUMBER. }
  Assert.IsFalse(TPhoneNumberUtil.Parse('+49 151 1234567 dw: 9', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));

  { The replacement for the validity assertion the old test carried, on the
    same eleven digit German mobile number but with an upstream label. Oracle:
    Parse('+49 151 12345678 ext 9', 'DE') -> nsn 15112345678, ext '9', valid. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 151 12345678 ext 9', 'DE', Parsed, ParseError));
  Assert.AreEqual<UInt64>(15112345678, Parsed.NationalNumber);
  Assert.AreEqual('9', Parsed.Extension);
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('+49 151 12345678 ext 9', 'DE'));
end;

procedure TPhoneNumberUtilTests.Parse_HandlesInternationalPrefix00;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('0044 20 7946 0321', 'GB', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(44, Parsed.CountryCode);
  Assert.AreEqual<UInt64>(2079460321, Parsed.NationalNumber);
  Assert.AreEqual('+442079460321', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('0044 20 7946 0321', 'GB'));
end;

procedure TPhoneNumberUtilTests.Parse_HandlesInternationalPrefix011_ForUS;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('01144 20 7946 0321', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(44, Parsed.CountryCode);
  Assert.AreEqual<UInt64>(2079460321, Parsed.NationalNumber);
  Assert.AreEqual('GB', Parsed.RegionCode);
  Assert.AreEqual('+442079460321', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('01144 20 7946 0321', 'US'));
end;

procedure TPhoneNumberUtilTests.Parse_HandlesInternationalPrefix011_ForCA;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('01144 20 7946 0321', 'CA', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(44, Parsed.CountryCode);
  Assert.AreEqual<UInt64>(2079460321, Parsed.NationalNumber);
  Assert.AreEqual('GB', Parsed.RegionCode);
  Assert.AreEqual('+442079460321', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('01144 20 7946 0321', 'CA'));
end;

procedure TPhoneNumberUtilTests.Parse_ParsesNationalInput_ForCA;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('204 555 0123', 'CA', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual<UInt64>(2045550123, Parsed.NationalNumber);
  Assert.AreEqual('CA', Parsed.RegionCode);
  Assert.AreEqual('+12045550123', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('204 555 0123', 'CA'));
end;

procedure TPhoneNumberUtilTests.Parse_ReturnsFalse_WhenInputHasNoDigits;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsFalse(TPhoneNumberUtil.Parse('abc', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));
end;

procedure TPhoneNumberUtilTests.Parse_StripsNonDigits_AndStoresNationalNumber;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 151 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(49, Parsed.CountryCode);
  Assert.AreEqual<UInt64>(1511234567, Parsed.NationalNumber);
  Assert.AreEqual('DE', Parsed.RegionCode);
end;

{ Driven by the GENERATED calling code index, so it covers every calling code
  the library actually ships. }
procedure TPhoneNumberUtilTests.GeneratedMetadata_CallingCodeTablesAreConsistent;
var
  CallingCodes: TMetadataIntegerArray;
  I, CountryCode, Code, Extracted: Integer;
  Region: string;
  NationalDigits: string;
begin
  CallingCodes := GetSupportedCallingCodes;
  Assert.IsTrue(Length(CallingCodes) > 200,
    'Unexpected calling code count: ' + IntToStr(Length(CallingCodes)));

  for I := 0 to High(CallingCodes) do
  begin
    CountryCode := CallingCodes[I];

    // Every calling code must resolve to a region ('ZZ' is the upstream
    // sentinel for "unknown", '001' the non geographical entities).
    Region := GetRegionCodeForCountryCode(CountryCode);
    Assert.AreNotEqual('ZZ', Region,
      Format('Calling code %d has no region mapping.', [CountryCode]));

    // Geographic regions must map back to the same calling code.
    if Region <> '001' then
    begin
      Code := GetCountryCodeForRegion(Region);
      Assert.AreNotEqual(0, Code,
        Format('Region %s (code %d) has no reverse mapping.', [Region, CountryCode]));
      Assert.AreEqual(CountryCode, Code,
        Format('Region %s maps back to %d, expected %d.', [Region, Code, CountryCode]));
    end;

    // The calling code must be discoverable by prefix extraction (upstream
    // extractCountryCode).
    Extracted := ExtractCountryCode(IntToStr(CountryCode) + '0000000',
      NationalDigits);
    Assert.AreEqual(CountryCode, Extracted,
      Format('Extraction of code %d returned %d.', [CountryCode, Extracted]));
  end;
end;

{ Table consistency of the alternate format data set: the groups
  are ascending and duplicate free, every slice is inside the format table, the
  slices tile it without gaps or overlap, and every leadingDigits offset is
  inside this data set's OWN pool. }
procedure TPhoneNumberUtilTests.AlternateFormats_TableIsConsistent;
var
  I, K, Expected: Integer;
  Group, Previous: PAlternateFormatGroupRec;
  NumberFormat: PNumberFormatRec;
begin
  Assert.IsTrue(GetAlternateFormatsGroupCount > 0,
    'No alternate format groups present.');

  Expected := 0;
  Previous := nil;
  for I := 0 to GetAlternateFormatsGroupCount - 1 do
  begin
    Group := GetAlternateFormatsGroup(I);
    Assert.IsNotNull(Group, Format('Alternate format group %d is nil.', [I]));

    if Previous <> nil then
      Assert.IsTrue(Group^.CountryCode > Previous^.CountryCode,
        Format('Alternate format groups are not ascending at index %d.', [I]));

    Assert.AreEqual(Expected, Group^.FormatOffset,
      Format('Alternate format group %d (cc=%d) does not follow the previous slice.',
        [I, Group^.CountryCode]));
    Assert.IsTrue(Group^.FormatCount > 0,
      Format('Alternate format group cc=%d is empty.', [Group^.CountryCode]));
    Inc(Expected, Group^.FormatCount);

    { The lookup answers by calling code and must find this very group. }
    Assert.IsTrue(HasAlternateFormats(Group^.CountryCode));
    Assert.AreEqual(Group^.FormatCount,
      GetAlternateFormatCount(Group^.CountryCode));

    for K := 0 to Group^.FormatCount - 1 do
    begin
      NumberFormat := GetAlternateFormat(Group^.CountryCode, K);
      Assert.IsNotNull(NumberFormat,
        Format('Alternate format cc=%d[%d] is nil.', [Group^.CountryCode, K]));
      Assert.IsTrue(NumberFormat^.Pattern <> '',
        Format('Alternate format cc=%d[%d] has no pattern.',
          [Group^.CountryCode, K]));
      Assert.IsTrue(NumberFormat^.Format <> '',
        Format('Alternate format cc=%d[%d] has no format.',
          [Group^.CountryCode, K]));
      { Upstream reads leadingDigits index 0 only. }
      Assert.IsTrue(NumberFormat^.LeadingDigitsCount <= 1,
        Format('Alternate format cc=%d[%d] has %d leadingDigits patterns.',
          [Group^.CountryCode, K, NumberFormat^.LeadingDigitsCount]));
      if NumberFormat^.LeadingDigitsCount = 1 then
      begin
        Assert.IsTrue(
          NumberFormat^.LeadingDigitsOffset < GetAlternateFormatsLeadingDigitsCount,
          Format('Alternate format cc=%d[%d] points outside the leadingDigits pool.',
            [Group^.CountryCode, K]));
        Assert.IsTrue(GetAlternateLeadingDigitsPattern(NumberFormat, 0) <> '',
          Format('Alternate format cc=%d[%d] has an empty leadingDigits pattern.',
            [Group^.CountryCode, K]));
      end;
    end;

    { Out of range index answers nil, like the phone metadata accessors. }
    Assert.IsNull(GetAlternateFormat(Group^.CountryCode, Group^.FormatCount));
    Previous := Group;
  end;

  Assert.AreEqual(GetAlternateFormatsTotalFormatCount, Expected,
    'The alternate format groups do not tile the format table.');

  { A calling code without alternate formats is the upstream null. }
  Assert.IsFalse(HasAlternateFormats(1), 'Calling code 1 has no alternate formats.');
  Assert.AreEqual(0, GetAlternateFormatCount(1));
  Assert.IsNull(GetAlternateFormat(1, 0));
end;

procedure TPhoneNumberUtilTests.Parse_KeepsCallerRegion_ForSharedCallingCode;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // +1 is shared across NANP; the caller-supplied region must survive.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 506 234 5678', 'CA', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual('CA', Parsed.RegionCode);

  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 202 555 0123', 'US', Parsed, ParseError));
  Assert.AreEqual('US', Parsed.RegionCode);

  // A region that does not own the dialled calling code is replaced by the
  // primary region for that code.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+44 20 7946 0321', 'CA', Parsed, ParseError));
  Assert.AreEqual('GB', Parsed.RegionCode);
end;

procedure TPhoneNumberUtilTests.Parse_ReturnsTooShortAfterIdd_WhenOnlyCallingCodePresent;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsFalse(TPhoneNumberUtil.Parse('0049', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeTooShortAfterIdd), Ord(ParseError));
end;

procedure TPhoneNumberUtilTests
  .Parse_RejectsATrailingHashWithoutExtensionDigits;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { A trailing '#' with no extension digits makes the input unparseable: '#' is not in
    VALID_PUNCTUATION, so it can only be part of an EXTENSION, and every
    extension branch that starts with '#' needs at least one digit after it.
    The string is therefore not a viable phone number at all.

    Oracle (libphonenumber-csharp 9.0.38): Parse('+49 351 8338916#', 'DE')
    throws NOT_A_NUMBER, while Parse('+49 351 8338916', 'DE') and
    Parse('+49 351 8338916#12', 'DE') both succeed - the latter with
    nsn 3518338916 and extension '12'. }
  Assert.IsFalse(TPhoneNumberUtil.Parse('+49 351 8338916#', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));

  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 351 8338916', 'DE', Parsed, ParseError));
  Assert.AreEqual('', Parsed.Extension);
  Assert.AreEqual<UInt64>(3518338916, Parsed.NationalNumber);

  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 351 8338916#12', 'DE', Parsed, ParseError));
  Assert.AreEqual('12', Parsed.Extension);
  Assert.AreEqual<UInt64>(3518338916, Parsed.NationalNumber);
end;

procedure TPhoneNumberUtilTests.Format_International_DE_Munich_ReturnsTwoDigitArea;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 89 12345678', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('+49 89 12345678', TPhoneNumberUtil.Format(Parsed, pnfInternational));
end;

procedure TPhoneNumberUtilTests.Format_National_DE_Munich_ReturnsTwoDigitArea;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 89 12345678', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('089 12345678', TPhoneNumberUtil.Format(Parsed, pnfNational));
end;

procedure TPhoneNumberUtilTests.IsValidNumber_RejectsNanpN11Codes;
begin
  // Area code 211 (N11) is not a valid geographic NANP area code; the upstream
  // US fixedLine pattern does not list it.
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+1 211 555 0123', 'US'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber('+1 211 555 0123', 'US'));

  // An N11 CENTRAL OFFICE code (+1 202 411 0123) is valid: the upstream
  // metadata places no restriction on the second block, and Java/C# report
  // the number as a valid FIXED_LINE_OR_MOBILE.
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+1 202 411 0123', 'US'));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('+1 202 411 0123', 'US'));
end;

procedure TPhoneNumberUtilTests.Parse_DoesNotTreat00AsIdd_ForNanp;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // NANP dials internationally with 011, not 00, so a leading 00 must not be
  // stripped as an IDD escape and reinterpreted as +49.
  Assert.IsTrue(TPhoneNumberUtil.Parse('0049 151 1234567', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual('US', Parsed.RegionCode);
end;

procedure TPhoneNumberUtilTests.Parse_ReturnsTooLongNsn_WhenDigitsExceedCapacity;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // The bound is upstream MAX_LENGTH_FOR_NSN = 17. Java and C# report TOO_LONG from 18 digits on.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 12345678901234567', 'DE', Parsed, ParseError),
    '17 national digits are still accepted.');
  Assert.AreEqual('12345678901234567', Parsed.NationalNumberDigits);

  Assert.IsFalse(TPhoneNumberUtil.Parse('+49 123456789012345678', 'DE', Parsed, ParseError),
    '18 national digits are TOO_LONG upstream.');
  Assert.AreEqual(Ord(pnpeTooLongNsn), Ord(ParseError));

  Assert.IsFalse(TPhoneNumberUtil.Parse('+49 1234567890123456789', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeTooLongNsn), Ord(ParseError));
end;

procedure TPhoneNumberUtilTests.Parse_KeepsSignificantLeadingZero_WhenTerritoryHasNoNationalPrefix;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // Trunk zero regression test. Benin (229), Congo (242) and Cote
  // d'Ivoire (225) carry no nationalPrefix / nationalPrefixForParsing in
  // PhoneNumberMetadata.xml, so the leading zero belongs to the national
  // significant number. Expected values are the Java/C# oracle output.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+2290195123456', 'BJ', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual(229, Parsed.CountryCode);
  Assert.AreEqual('0195123456', Parsed.NationalNumberDigits);
  Assert.AreEqual('+2290195123456', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('+2290195123456', 'BJ'));

  Assert.IsTrue(TPhoneNumberUtil.Parse('+242061234567', 'CG', Parsed, ParseError));
  Assert.AreEqual('061234567', Parsed.NationalNumberDigits);
  Assert.AreEqual('+242061234567', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('+242061234567', 'CG'));

  Assert.IsTrue(TPhoneNumberUtil.Parse('+2250123456789', 'CI', Parsed, ParseError));
  Assert.AreEqual('0123456789', Parsed.NationalNumberDigits);
  Assert.AreEqual('+2250123456789', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsValidNumber('+2250123456789', 'CI'));

  // Dialled nationally the leading zero must survive as well.
  Assert.IsTrue(TPhoneNumberUtil.Parse('0195123456', 'BJ', Parsed, ParseError));
  Assert.AreEqual('0195123456', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests.Parse_StripsNationalPrefix_WhenTerritoryDeclaresOne;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // The counterpart of the test above: Germany declares nationalPrefix 0, so
  // the trunk zero is still removed.
  Assert.IsTrue(TPhoneNumberUtil.Parse('030 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual('301234567', Parsed.NationalNumberDigits);
  Assert.AreEqual('+49301234567', TPhoneNumberUtil.Format(Parsed, pnfE164));

  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 (0)30 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual('301234567', Parsed.NationalNumberDigits);

  // Great Britain likewise (nationalPrefixForParsing '0|180020').
  Assert.IsTrue(TPhoneNumberUtil.Parse('020 7946 0321', 'GB', Parsed, ParseError));
  Assert.AreEqual('2079460321', Parsed.NationalNumberDigits);

  // The NANP trunk prefix is 1, not 0.
  Assert.IsTrue(TPhoneNumberUtil.Parse('1 202 555 0123', 'US', Parsed, ParseError));
  Assert.AreEqual('2025550123', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests.Parse_UsesMetadataIddPrefixes;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // The international prefix now comes from the territory metadata instead of
  // a hard coded "011 for the NANP, 00 for everyone else" table.

  // US: internationalPrefix '011'.
  Assert.IsTrue(TPhoneNumberUtil.Parse('011 44 20 7946 0321', 'US', Parsed, ParseError));
  Assert.AreEqual(44, Parsed.CountryCode);
  Assert.AreEqual('2079460321', Parsed.NationalNumberDigits);
  Assert.AreEqual('GB', Parsed.RegionCode);

  // DE: internationalPrefix '00'.
  Assert.IsTrue(TPhoneNumberUtil.Parse('00 44 20 7946 0321', 'DE', Parsed, ParseError));
  Assert.AreEqual(44, Parsed.CountryCode);
  Assert.AreEqual('2079460321', Parsed.NationalNumberDigits);

  // AU: internationalPrefix '001[14-689]|14(?:...)0011', preferred '0011'.
  Assert.IsTrue(TPhoneNumberUtil.Parse('0011 44 20 7946 0321', 'AU', Parsed, ParseError));
  Assert.AreEqual(44, Parsed.CountryCode);
  Assert.AreEqual('2079460321', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests.ParseAndKeepRawInput_ReportsPlusSignSource;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('+49 30 1234567', 'DE',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsFromNumberWithPlusSign), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual('+49 30 1234567', Parsed.RawInput);
  Assert.AreEqual(49, Parsed.CountryCode);
  Assert.AreEqual('301234567', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests.ParseAndKeepRawInput_ReportsIddSource;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('0049 30 1234567', 'DE',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsFromNumberWithIdd), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual(49, Parsed.CountryCode);
  Assert.AreEqual('301234567', Parsed.NationalNumberDigits);

  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('01144 20 7946 0321', 'US',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsFromNumberWithIdd), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual(44, Parsed.CountryCode);
end;

procedure TPhoneNumberUtilTests.ParseAndKeepRawInput_ReportsSourceWithoutPlusSign;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // Upstream maybeExtractCountryCode reinterprets a national number that
  // starts with the calling code of its own region when dropping the code
  // makes the rest match the general description.
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('49301234567', 'DE',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsFromNumberWithoutPlusSign), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual(49, Parsed.CountryCode);
  Assert.AreEqual('301234567', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests.ParseAndKeepRawInput_ReportsDefaultCountrySource;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('030 1234567', 'DE',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsFromDefaultCountry), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual(49, Parsed.CountryCode);
  Assert.AreEqual('301234567', Parsed.NationalNumberDigits);

  // The NANP does not dial out with 00, so this stays a (nonsensical but)
  // national number of the default region.
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('0049 151 1234567', 'US',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsFromDefaultCountry), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual('00491511234567', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests.Parse_LeavesCountryCodeSourceUnspecified;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // Upstream only records the source when parsing with keepRawInput; the same
  // gate applies to RawInput (see Parse_LeavesRawInputEmpty) and to the
  // preferred domestic carrier code.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 30 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsUnspecified), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual('', Parsed.PreferredDomesticCarrierCode);
end;

procedure TPhoneNumberUtilTests.Parse_UsesMainRegionMetadataAfterExplicitCallingCode;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // Upstream parseHelper replaces the region metadata by the metadata of the
  // MAIN region of the extracted calling code, not by the metadata of the
  // caller-supplied region. Barbados makes the difference visible: BB declares
  // nationalPrefixForParsing '1|([2-8]\d{6})$' with transform rule '246$1', so
  // a seven digit local number is expanded to the full national number - but
  // only when no calling code was extracted. With an explicit +1 the strip
  // runs against US metadata (nationalPrefixForParsing '1'), which leaves the
  // number alone. Both expectations are the Java/C# oracle output.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 2345678', 'BB', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('2345678', Parsed.NationalNumberDigits,
    'An explicit +1 must be stripped with US metadata, not with BB metadata.');
  Assert.AreEqual('+12345678', TPhoneNumberUtil.Format(Parsed, pnfE164));

  // Counter check: dialled locally, no calling code is extracted, so BB
  // metadata stays in charge and the transform rule fires.
  Assert.IsTrue(TPhoneNumberUtil.Parse('2345678', 'BB', Parsed, ParseError));
  Assert.AreEqual('2462345678', Parsed.NationalNumberDigits,
    'A local BB number must be expanded by the BB transform rule.');
  Assert.AreEqual('+12462345678', TPhoneNumberUtil.Format(Parsed, pnfE164));

  // Same shape on calling code 44: GG expands a six digit local number through
  // '0|([25-9]\d{5})$' / '1481$1', while an explicit +44 uses GB metadata.
  Assert.IsTrue(TPhoneNumberUtil.Parse('570000', 'GG', Parsed, ParseError));
  Assert.AreEqual('1481570000', Parsed.NationalNumberDigits);

  Assert.IsTrue(TPhoneNumberUtil.Parse('+441481570000', 'GG', Parsed, ParseError));
  Assert.AreEqual('1481570000', Parsed.NationalNumberDigits);
  Assert.AreEqual('+441481570000', TPhoneNumberUtil.Format(Parsed, pnfE164));
end;

procedure TPhoneNumberUtilTests.Parse_RollsBackANationalPrefixStripThatIsTooShort;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // Length guard of upstream parseHelper: the tentative strip of the NANP
  // trunk prefix '1' would leave nine digits, which is TOO_SHORT for the US
  // numbering plan, so the strip is discarded and the number stays as dialled.
  // Java/C# report the national number 1234567890 here.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 1234567890', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNone), Ord(ParseError));
  Assert.AreEqual('1234567890', Parsed.NationalNumberDigits);
  Assert.AreEqual('+11234567890', TPhoneNumberUtil.Format(Parsed, pnfE164));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+1 1234567890', 'US'));
  Assert.IsFalse(TPhoneNumberUtil.IsValidNumber('+1 1234567890', 'US'));
end;

procedure TPhoneNumberUtilTests.Parse_LeavesRawInputEmpty;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  // Upstream parseHelper fills rawInput only when keepRawInput is requested.
  Assert.IsTrue(TPhoneNumberUtil.Parse('+49 30 1234567', 'DE', Parsed, ParseError));
  Assert.AreEqual('', Parsed.RawInput,
    'Plain Parse must not record the raw input.');

  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('+49 30 1234567', 'DE',
    Parsed, ParseError));
  Assert.AreEqual('+49 30 1234567', Parsed.RawInput);
end;

{ ---------------------------------------------------------------------------
  Extended formatter API

  Every expectation below comes from the C# NuGet oracle
  (libphonenumber-csharp 9.0.38, the metadata release of the pinned Java
  baseline) run against the PRODUCTIVE metadata, or from the oracle values
  already recorded in tests/data/reference_cases_java_csharp.json. Nothing is
  copied from PhoneNumberUtilTest.java: that suite runs on
  PhoneNumberMetadataForTesting.xml, whose AR, AU, MX and UZ entries differ
  from the shipped ones. The test IDEAS are the upstream ones.
  --------------------------------------------------------------------------- }

function TPhoneNumberUtilTests.ParsedNumber(const AInput,
  ACountry: string): TPhoneNumber;
var
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.Parse(AInput, ACountry, Result, ParseError),
    'Parse failed for [' + AInput + '] / ' + ACountry);
end;

function TPhoneNumberUtilTests.KeptNumber(const AInput,
  ACountry: string): TPhoneNumber;
var
  ParseError: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput(AInput, ACountry,
    Result, ParseError),
    'ParseAndKeepRawInput failed for [' + AInput + '] / ' + ACountry);
end;

procedure TPhoneNumberUtilTests.FormatOutOfCountryCallingNumber_MatchesTheOracle;
begin
  { NANPA special case: no IDD at all, just the calling code in front of the
    NATIONAL format. }
  Assert.AreEqual('1 (650) 253-0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+16502530000', 'ZZ'), 'BS'));

  { Same calling code as the calling region: NATIONAL format. }
  Assert.AreEqual('02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+390236618300', 'ZZ'), 'IT'));

  { Single international prefix of the calling region. }
  Assert.AreEqual('00 1 900-253-0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+19002530000', 'ZZ'), 'DE'));
  Assert.AreEqual('011 44 7912 345678',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+447912345678', 'ZZ'), 'US'));
  Assert.AreEqual('011 800 1234 5678',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+80012345678', 'ZZ'), 'US'));

  { Preferred international prefix wins over a multi prefix internationalPrefix
    (AU), and a waiting tone survives verbatim (RU). }
  Assert.AreEqual('0011 39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+390236618300', 'ZZ'), 'AU'));
  Assert.AreEqual('8~10 39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+390236618300', 'ZZ'), 'RU'));

  { Multiple international prefixes without a preferred one: the INTERNATIONAL
    format is returned because upstream cannot pick a prefix. }
  Assert.AreEqual('+39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+390236618300', 'ZZ'), 'SG'));

  { An unsupported calling region falls back to INTERNATIONAL instead of
    throwing; '001' is the non geographical entity id and is deliberately not a
    supported region. }
  Assert.AreEqual('+1 650-253-0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+16502530000', 'ZZ'), 'AQ'));
  Assert.AreEqual('+1 650-253-0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+16502530000', 'ZZ'), '001'));
  Assert.AreEqual('+1 650-253-0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
      ParsedNumber('+16502530000', 'ZZ'), ''));
end;

procedure TPhoneNumberUtilTests.FormatOutOfCountryCallingNumber_NormalizesTheRegionArgument;
var
  Number: TPhoneNumber;
begin
  { The facade normalises the region the same way Parse normalises its default
    region; upstream expects a canonical CLDR code from the caller. }
  Number := ParsedNumber('+390236618300', 'ZZ');
  Assert.AreEqual('0011 39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, ' au '));
  Assert.AreEqual('0011 39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, 'Au'));
end;

procedure TPhoneNumberUtilTests.FormatNationalNumberWithCarrierCode_MatchesTheOracle;
var
  Number: TPhoneNumber;
begin
  { Brazil is the territory whose PRODUCTIVE metadata carries a
    carrierCodeFormattingRule; the Java test uses AR, which only has one in the
    test metadata. }
  Number := ParsedNumber('+551130111234', 'ZZ');
  Assert.AreEqual('(11) 3011-1234',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Number, ''));
  Assert.AreEqual('0 21 (11) 3011-1234',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Number, '21'));

  Number := ParsedNumber('+5511961234567', 'ZZ');
  Assert.AreEqual('(11) 96123-4567',
    TPhoneNumberUtil.Format(Number, pnfNational));
  Assert.AreEqual('0 15 (11) 96123-4567',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Number, '15'));

  { A territory without such a rule ignores the carrier code. }
  Number := ParsedNumber('+16502530000', 'ZZ');
  Assert.AreEqual('(650) 253-0000',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Number, '15'));

  { An invalid calling code yields the bare national significant number - the
    upstream contract, deliberately NOT the empty string Format() returns. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 0;
  Number.NationalNumberDigits := '12345';
  Assert.AreEqual('12345',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Number, '89'));
end;

procedure TPhoneNumberUtilTests.FormatNationalNumberWithPreferredCarrierCode_PrefersTheParsedCode;
var
  Kept: TPhoneNumber;
  Plain: TPhoneNumber;
begin
  { The Brazilian carrier selection code 12 is stripped by
    maybeStripNationalPrefixAndCarrierCode and recorded as
    PreferredDomesticCarrierCode - but only by ParseAndKeepRawInput. }
  Kept := KeptNumber('012 3121286979', 'BR');
  Assert.AreEqual('12', Kept.PreferredDomesticCarrierCode);
  Assert.AreEqual('3121286979', Kept.NationalNumberDigits);

  Assert.AreEqual('0 12 (31) 2128-6979',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(Kept, ''));
  Assert.AreEqual('0 12 (31) 2128-6979',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(Kept, '99'),
    'The stored code wins over the fallback.');
  Assert.AreEqual('0 99 (31) 2128-6979',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Kept, '99'),
    'FormatNationalNumberWithCarrierCode always uses the code passed in.');
  Assert.AreEqual('(31) 2128-6979',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Kept, ''));
  Assert.AreEqual('(31) 2128-6979',
    TPhoneNumberUtil.Format(Kept, pnfNational),
    'The plain NATIONAL format never uses the stored carrier code.');

  { Plain Parse leaves the field empty, exactly like upstream parse(); the
    fallback then applies, and an empty fallback means "no carrier code". }
  Plain := ParsedNumber('012 3121286979', 'BR');
  Assert.AreEqual('', Plain.PreferredDomesticCarrierCode);
  Assert.AreEqual('0 99 (31) 2128-6979',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(Plain, '99'));
  Assert.AreEqual('(31) 2128-6979',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(Plain, ''));
end;

procedure TPhoneNumberUtilTests.FormatByPattern_MatchesTheOracle;
var
  Formats: TUserNumberFormatArray;
  UsNumber: TPhoneNumber;
begin
  UsNumber := ParsedNumber('+16502530000', 'ZZ');
  SetLength(Formats, 1);

  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '($1) $2-$3',
    [], '', '');
  Assert.AreEqual('(650) 253-0000',
    TPhoneNumberUtil.FormatByPattern(UsNumber, pnfNational, Formats));
  Assert.AreEqual('+1 (650) 253-0000',
    TPhoneNumberUtil.FormatByPattern(UsNumber, pnfInternational, Formats));
  Assert.AreEqual('tel:+1-650-712-9823',
    TPhoneNumberUtil.FormatByPattern(ParsedNumber('+16507129823', 'ZZ'),
      pnfRfc3966, Formats));

  { $NP / $FG are resolved from the metadata of the MAIN region of the calling
    code, so a Bahamian number follows the US national prefix. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1 $2-$3',
    [], '$NP ($FG)', '');
  Assert.AreEqual('1 (242) 365-1234',
    TPhoneNumberUtil.FormatByPattern(ParsedNumber('+12423651234', 'ZZ'),
      pnfNational, Formats));

  { Italy has no national prefix, so the rule is dropped rather than expanded. }
  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{5})(\d{3})', '$1-$2 $3',
    [], '$NP ($FG)', '');
  Assert.AreEqual('02-36618 300',
    TPhoneNumberUtil.FormatByPattern(ParsedNumber('+390236618300', 'ZZ'),
      pnfNational, Formats));

  { The extension comes from the metadata of the territory, not from the user
    format. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '($1) $2-$3',
    [], '', '');
  Assert.AreEqual('(650) 253-0000 ext. 4567',
    TPhoneNumberUtil.FormatByPattern(
      ParsedNumber('+16502530000 ext. 4567', 'ZZ'), pnfNational, Formats));

  { pnfInternationalLegacy has no upstream counterpart: it is the INTERNATIONAL
    string with the group after the calling code parenthesised, and
    FormatByPattern applies that step to the user formatted string as well. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1 $2-$3',
    [], '', '');
  Assert.AreEqual('+1 650 253-0000',
    TPhoneNumberUtil.FormatByPattern(UsNumber, pnfInternational, Formats));
  Assert.AreEqual('+1 (650) 253-0000',
    TPhoneNumberUtil.FormatByPattern(UsNumber, pnfInternationalLegacy,
      Formats));
end;

procedure TPhoneNumberUtilTests.FormatInOriginalFormat_MatchesTheOracle;
var
  Number: TPhoneNumber;
begin
  { The four CountryCodeSource branches. }
  Assert.AreEqual('+44 20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('+442087654321', 'GB'), 'GB'), 'FROM_NUMBER_WITH_PLUS_SIGN');
  Assert.AreEqual('011 44 20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('011442087654321', 'US'), 'US'), 'FROM_NUMBER_WITH_IDD');
  Assert.AreEqual('44 20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('442087654321', 'GB'), 'GB'), 'FROM_NUMBER_WITHOUT_PLUS_SIGN');
  Assert.AreEqual('020 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('02087654321', 'GB'), 'GB'), 'FROM_DEFAULT_COUNTRY');

  { A number parsed without keepRawInput has no country code source at all, so
    upstream degrades to the NATIONAL format. }
  Assert.AreEqual('020 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParsedNumber('+442087654321', 'GB'), 'GB'));

  { The national prefix is preserved exactly as dialled: 2087654321 was entered
    WITHOUT the trunk zero, so the format rule is applied with its
    nationalPrefixFormattingRule cleared. }
  Assert.AreEqual('20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('2087654321', 'GB'), 'GB'));
  Assert.AreEqual('1 800-345-6789',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('18003456789', 'US'), 'US'));
  Assert.AreEqual('253-0000',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('2530000', 'US'), 'US'));

  { Invalid numbers that still have a formatting pattern are formatted; the
    presence of a leading zero in a region without one makes the method fall
    back to the raw input instead. }
  Assert.AreEqual('(734) 567-8901',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('7345678901', 'US'), 'US'));
  Assert.AreEqual('0734567 8901',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('0734567 8901', 'US'), 'US'));

  { Valid numbers without a formatting pattern fall back to the raw input. }
  Assert.AreEqual('02-4567-8900',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('02-4567-8900', 'KR'), 'KR'));

  { Non geographical calling codes. }
  Assert.AreEqual('011 800 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('01180012345678', 'US'), 'US'));
  Assert.AreEqual('+800 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('+80012345678', 'KR'), 'KR'));

  { Territories without a national prefix (MX, IT) always keep the national
    format; MX numbers dialled with the historic 01/044/045 prefixes are not
    rewritten. }
  Assert.AreEqual('33 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('3312345678', 'MX'), 'MX'));
  Assert.AreEqual('013312345678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('013312345678', 'MX'), 'MX'));
  Assert.AreEqual('044(33)1234-5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('044(33)1234-5678', 'MX'), 'MX'));
  Assert.AreEqual('045(33)1234-5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('045(33)1234-5678', 'MX'), 'MX'));
  Assert.AreEqual('02 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('0212345678', 'IT'), 'IT'));

  { The Japanese case rawInputContainsNationalPrefix exists for: 00777012 does
    carry the national prefix, 0777012 does not. }
  Assert.AreEqual('0077-7012',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('00777012', 'JP'), 'JP'));
  Assert.AreEqual('0777012',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('0777012', 'JP'), 'JP'));

  { A Brazilian number dialled with a carrier selection code keeps the raw
    input, because the formatted output would drop the carrier digits. }
  Assert.AreEqual('012 3121286979',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('012 3121286979', 'BR'), 'BR'));

  { AU declares 0011 as its preferred international prefix. A number dialled
    with the alternative 0012 is not a recognised IDD, so it stays raw. }
  Assert.AreEqual('0011 1 650-253-0000',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('0011 16502530000', 'AU'), 'AU'));
  Assert.AreEqual('0012 16502530000',
    TPhoneNumberUtil.FormatInOriginalFormat(
      KeptNumber('0012 16502530000', 'AU'), 'AU'));

  { An invalid national number without raw input is simply formatted as the
    national number. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 1;
  Number.NationalNumberDigits := '650253000';
  Assert.AreEqual('650253000',
    TPhoneNumberUtil.FormatInOriginalFormat(Number, 'US'));

  { An invalid CALLING CODE yields the bare national significant number as
    well. This is the one place where the method must not go through the public
    Format(), which answers with the empty string here; it formats through the
    engine instead, exactly like upstream format() does. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 0;
  Number.NationalNumberDigits := '12345';
  Assert.AreEqual('12345',
    TPhoneNumberUtil.FormatInOriginalFormat(Number, 'US'));
  Assert.AreEqual('12345',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, 'US'));
  Assert.AreEqual('', TPhoneNumberUtil.Format(Number, pnfNational),
    'The older Format() keeps its own contract for a number without a calling code.');
end;

{ ---------------------------------------------------------------------------
  Reference corpus differentials

  The corpus records the oracle E164/INTERNATIONAL/NATIONAL/RFC3966 strings of
  247 numbers but no out of country or original format values, so the three
  gates below check that the new entry points COMPOSE those recorded oracle
  strings exactly the way upstream does. The composition rules were verified
  against the oracle itself: running formatOutOfCountryCallingNumber,
  formatNationalNumberWithCarrierCode and formatInOriginalFormat over all 247
  cases in libphonenumber-csharp 9.0.38 reproduces them with zero mismatches.
  --------------------------------------------------------------------------- }

procedure TPhoneNumberUtilTests.ReferenceCases_CarrierCodeFreeNationalFormatMatchesTheOracle;
var
  FilePath: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  I: Integer;
  CaseObj: TJSONObject;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  Actual: string;
  Divergences: TStringList;
begin
  FilePath := FindReferenceCasesFile;
  JsonValue := TJSONObject.ParseJSONValue(
    ReadUtf8File(FilePath));
  Divergences := TStringList.Create;
  try
    Cases := JsonValue as TJSONArray;
    for I := 0 to Cases.Count - 1 do
    begin
      CaseObj := Cases.Items[I] as TJSONObject;
      Assert.IsTrue(TPhoneNumberUtil.Parse(CaseObj.GetString('input'),
        CaseObj.GetString('country'), Parsed, ParseError));

      { An empty carrier code is Java's "national format without any carrier
        code", so the result must be the recorded NATIONAL string. }
      Actual := TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Parsed,
        '');
      if Actual <> CaseObj.GetString('javaNational') then
        Divergences.Add(CaseObj.GetString('name') + ': expected ['
          + CaseObj.GetString('javaNational') + '] but got ['
          + Actual + ']');
    end;

    if Divergences.Count > 0 then
      Assert.Fail(Format('%d of %d reference cases diverge:'#13#10'%s',
        [Divergences.Count, Cases.Count, Divergences.Text]));
  finally
    Divergences.Free;
    JsonValue.Free;
  end;
end;

procedure TPhoneNumberUtilTests.ReferenceCases_OutOfCountryComposesTheOracleStrings;
const
  { Calling regions chosen so that all four branches of
    formatOutOfCountryCallingNumber are exercised over the whole corpus:
    a single international prefix (DE, US), a preferred prefix (AU), a
    preferred prefix with a waiting tone (RU) and a region whose
    internationalPrefix is a real regex with no preferred prefix (SG). The
    prefixes are spelled out instead of read back from the metadata so that a
    metadata read bug cannot make the test agree with itself. }
  RegionCount = 5;
  CallingFromRegions: array[0..RegionCount - 1] of string =
    ('DE', 'US', 'AU', 'RU', 'SG');
  CallingFromPrefixes: array[0..RegionCount - 1] of string =
    ('00', '011', '0011', '8~10', '');
var
  FilePath: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  I, R: Integer;
  CaseObj: TJSONObject;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  CaseName, JavaNational, JavaInternational: string;
  Head, Expected, Actual: string;
  Divergences: TStringList;
  Checked: Integer;
begin
  FilePath := FindReferenceCasesFile;
  JsonValue := TJSONObject.ParseJSONValue(
    ReadUtf8File(FilePath));
  Divergences := TStringList.Create;
  try
    Cases := JsonValue as TJSONArray;
    Checked := 0;
    for I := 0 to Cases.Count - 1 do
    begin
      CaseObj := Cases.Items[I] as TJSONObject;
      CaseName := CaseObj.GetString('name');
      JavaNational := CaseObj.GetString('javaNational');
      JavaInternational := CaseObj.GetString('javaInternational');
      Assert.IsTrue(TPhoneNumberUtil.Parse(CaseObj.GetString('input'),
        CaseObj.GetString('country'), Parsed, ParseError));

      { Every INTERNATIONAL string starts with "+<cc> " because
        prefixNumberWithCountryCallingCode always writes that head. }
      Head := '+' + IntToStr(Parsed.CountryCode) + ' ';
      Assert.IsTrue(JavaInternational.StartsWith(Head),
        CaseName + ': unexpected INTERNATIONAL head in the corpus.');

      for R := 0 to RegionCount - 1 do
      begin
        if (Parsed.CountryCode = 1)
          and IsNanpaCountry(CallingFromRegions[R]) then
          { NANPA to NANPA: calling code plus NATIONAL, no IDD. }
          Expected := '1 ' + JavaNational
        else if (Parsed.CountryCode <> 1)
          and (Parsed.CountryCode
               = GetCountryCodeForRegion(CallingFromRegions[R])) then
          { Same calling code: the calling code need not be dialled. }
          Expected := JavaNational
        else if CallingFromPrefixes[R] = '' then
          { No usable international prefix: INTERNATIONAL is returned. }
          Expected := JavaInternational
        else
          Expected := CallingFromPrefixes[R] + ' '
            + IntToStr(Parsed.CountryCode) + ' '
            + Copy(JavaInternational, Length(Head) + 1,
                Length(JavaInternational) - Length(Head));

        Actual := TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Parsed,
          CallingFromRegions[R]);
        Inc(Checked);
        if Actual <> Expected then
          Divergences.Add(CaseName + ' from ' + CallingFromRegions[R]
            + ': expected [' + Expected + '] but got [' + Actual + ']');
      end;
    end;

    if Divergences.Count > 0 then
      Assert.Fail(Format('%d of %d out of country combinations diverge:'#13#10'%s',
        [Divergences.Count, Checked, Divergences.Text]));
    Assert.AreEqual(Cases.Count * RegionCount, Checked);
  finally
    Divergences.Free;
    JsonValue.Free;
  end;
end;

procedure TPhoneNumberUtilTests.ReferenceCases_InOriginalFormatMatchesTheOracle;
const
  { The territories of the corpus that have no numberFormat at all. For them
    chooseFormattingPatternForNumber finds nothing, and formatInOriginalFormat
    returns the raw input instead of a formatted string. This is an exact
    inventory, not a budget: a case that silently joins or leaves the list is a
    regression either way. }
  NoFormatCaseCount = 8;
  NoFormatCases: array[0..NoFormatCaseCount - 1] of string = (
    'AC auto example',
    'DE mobile canonical',
    'FK auto example',
    'GI auto example',
    'KI auto example',
    'SH auto example',
    'TA auto example',
    'TK auto example'
  );
var
  FilePath: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  I, J: Integer;
  CaseObj: TJSONObject;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  CaseName, JavaE164, Expected, Actual: string;
  HasFormat, Documented: Boolean;
  Divergences: TStringList;
  RawFallbacks: TStringList;
begin
  FilePath := FindReferenceCasesFile;
  JsonValue := TJSONObject.ParseJSONValue(
    ReadUtf8File(FilePath));
  Divergences := TStringList.Create;
  RawFallbacks := TStringList.Create;
  try
    Cases := JsonValue as TJSONArray;
    for I := 0 to Cases.Count - 1 do
    begin
      CaseObj := Cases.Items[I] as TJSONObject;
      CaseName := CaseObj.GetString('name');
      JavaE164 := CaseObj.GetString('javaE164');

      { The E164 string is used as the input on purpose: it makes every case a
        FROM_NUMBER_WITH_PLUS_SIGN case, so the expectation is the recorded
        INTERNATIONAL string - unless there is no formatting pattern, in which
        case upstream returns the raw input unchanged. }
      Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput(JavaE164,
        CaseObj.GetString('country'), Parsed, ParseError));
      Assert.AreEqual(Ord(pnccsFromNumberWithPlusSign),
        Ord(Parsed.CountryCodeSource), CaseName);

      HasFormat := ChooseFormattingPatternForCallingCode(Parsed.CountryCode,
        Parsed.NationalNumberDigits) <> nil;
      if HasFormat then
        Expected := CaseObj.GetString('javaInternational')
      else
      begin
        Expected := JavaE164;
        RawFallbacks.Add(CaseName);
      end;

      Actual := TPhoneNumberUtil.FormatInOriginalFormat(Parsed,
        CaseObj.GetString('country'));
      if Actual <> Expected then
        Divergences.Add(CaseName + ': expected [' + Expected + '] but got ['
          + Actual + ']');
    end;

    if Divergences.Count > 0 then
      Assert.Fail(Format('%d of %d reference cases diverge:'#13#10'%s',
        [Divergences.Count, Cases.Count, Divergences.Text]));

    Assert.AreEqual(NoFormatCaseCount, RawFallbacks.Count,
      'Unexpected number of cases without a formatting pattern: '
      + RawFallbacks.CommaText);
    for J := 0 to RawFallbacks.Count - 1 do
    begin
      Documented := False;
      for I := 0 to NoFormatCaseCount - 1 do
        if RawFallbacks[J] = NoFormatCases[I] then
          Documented := True;
      Assert.IsTrue(Documented,
        'Undocumented case without a formatting pattern: ' + RawFallbacks[J]);
    end;
  finally
    RawFallbacks.Free;
    Divergences.Free;
    JsonValue.Free;
  end;
end;

{ ------------------------------------------------------------------
  Entry path of parseHelper and isNumberMatch.

  Every expected value below was computed with the NuGet reference oracle
  (libphonenumber-csharp 9.0.38 against the productive metadata), never copied
  out of PhoneNumberUtilTest.java - see "Test Expectations" in AGENTS.md. The
  test IDEAS do come from upstream.
  ------------------------------------------------------------------ }

function TPhoneNumberUtilTests.CodePoints(
  const ACodes: array of Integer): string;
var
  I: Integer;
  Wide: UnicodeString;
begin
  { Non ASCII test data is built from code points instead of being written
    into the source, so this file stays pure ASCII - the same rule the port
    itself follows. Built as UTF-16 and converted once: on FreePascal
    `string` is UTF-8, where one code unit per character does not hold. }
  SetLength(Wide, Length(ACodes));
  for I := 0 to High(ACodes) do
    Wide[I + 1] := WideChar(ACodes[I]);
  Result := string(Wide);
end;

procedure TPhoneNumberUtilTests.Parse_AppliesExtractPossibleNumber;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { A star is not a VALID_START_CHAR, so it and everything before it goes.
    Oracle: Parse('*1234', 'US') -> nsn 1234. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('*1234', 'US', Parsed, ParseError));
  Assert.AreEqual('1234', Parsed.NationalNumberDigits);

  { Leading text: the three letters of "Tel" are stripped, not mapped as a
    vanity number. Oracle:
    Parse('Tel: 650 253 0000', 'US') -> nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('Tel: 650 253 0000', 'US', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { Trailing characters that are neither letters nor numbers. Oracle:
    Parse('650 253 0000...', 'US') and Parse('650 253 0000)', 'US') both
    -> nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('650 253 0000...', 'US', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);
  Assert.IsTrue(TPhoneNumberUtil.Parse('650 253 0000)', 'US', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { The start of a SECOND number is cut off. Oracle:
    Parse('(530) 583-6985 x302/x2303', 'US') -> nsn 5305836985, ext '302'. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('(530) 583-6985 x302/x2303', 'US', Parsed, ParseError));
  Assert.AreEqual('5305836985', Parsed.NationalNumberDigits);
  Assert.AreEqual('302', Parsed.Extension);

  { No VALID_START_CHAR at all: extractPossibleNumber yields the empty string
    and isViablePhoneNumber rejects it. Oracle: Parse('abc-def', 'US') throws
    NOT_A_NUMBER. }
  Assert.IsFalse(TPhoneNumberUtil.Parse('abc-def', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));
end;

procedure TPhoneNumberUtilTests.Parse_AppliesTheViabilityGate;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { The short number alternative of VALID_PHONE_NUMBER: exactly two digits and
    no punctuation. Oracle: Parse('12', 'US') -> nsn 12, Parse('1-2', 'US')
    throws NOT_A_NUMBER. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('12', 'US', Parsed, ParseError));
  Assert.AreEqual('12', Parsed.NationalNumberDigits);
  Assert.IsFalse(TPhoneNumberUtil.Parse('1-2', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));

  { The optional extension binds to the SECOND alternative only, so a two
    digit number cannot carry one. Oracle: Parse('12;ext=34', 'US') throws
    NOT_A_NUMBER while Parse('123;ext=45', 'US') -> nsn 123, ext '45'. }
  Assert.IsFalse(TPhoneNumberUtil.Parse('12;ext=34', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));
  Assert.IsTrue(TPhoneNumberUtil.Parse('123;ext=45', 'US', Parsed, ParseError));
  Assert.AreEqual('123', Parsed.NationalNumberDigits);
  Assert.AreEqual('45', Parsed.Extension);

  { An rfc extension longer than twenty digits matches no alternative, and the
    semicolon is not in VALID_PUNCTUATION, so the whole string is unviable.
    Oracle: Parse('+1 650 253 0000;ext=123456789012345678901', 'ZZ') throws
    NOT_A_NUMBER. }
  Assert.IsFalse(TPhoneNumberUtil.Parse(
    '+1 650 253 0000;ext=123456789012345678901', 'ZZ', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));

  { A plus sign in the middle is in none of the character classes. This is the
    string buildNationalNumberForParsing produces for a tel: URI whose
    phone-context repeats the calling code. Oracle:
    Parse('tel:+1-650-253-0000;phone-context=+1', 'ZZ') throws NOT_A_NUMBER. }
  Assert.IsFalse(TPhoneNumberUtil.Parse(
    'tel:+1-650-253-0000;phone-context=+1', 'ZZ', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));
end;

procedure TPhoneNumberUtilTests.Parse_HandlesRfc3966PhoneContext;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { A phone-context that carries a number prefix is prepended to the body.
    Oracle: Parse('tel:253-0000;phone-context=+1-650', 'ZZ') -> cc 1,
    nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    'tel:253-0000;phone-context=+1-650', 'ZZ', Parsed, ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { A DOMAIN phone-context is ignored. Oracle:
    Parse('tel:253-0000;phone-context=www.google.com', 'US') -> nsn 2530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    'tel:253-0000;phone-context=www.google.com', 'US', Parsed, ParseError));
  Assert.AreEqual('2530000', Parsed.NationalNumberDigits);

  { The tel: prefix may be missing. Oracle:
    Parse('253-0000;phone-context=+1-650', 'ZZ') -> nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '253-0000;phone-context=+1-650', 'ZZ', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { isdn-subaddress and everything behind it is deleted. Oracle:
    Parse('tel:253-0000;isub=12345;phone-context=+1-650', 'ZZ') and
    Parse('+1 650 253 0000;isub=12345', 'ZZ') both -> nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    'tel:253-0000;isub=12345;phone-context=+1-650', 'ZZ', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '+1 650 253 0000;isub=12345', 'ZZ', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { An invalid or empty phone-context is the one NOT_A_NUMBER
    buildNationalNumberForParsing raises itself. Oracle:
    Parse('tel:253-0000;phone-context=1-650', 'US') and
    Parse('tel:253-0000;phone-context=', 'US') both throw NOT_A_NUMBER. }
  Assert.IsFalse(TPhoneNumberUtil.Parse(
    'tel:253-0000;phone-context=1-650', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));
  Assert.IsFalse(TPhoneNumberUtil.Parse(
    'tel:253-0000;phone-context=', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));
end;

procedure TPhoneNumberUtilTests.Parse_AcceptsUnicodeDecimalDigits;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  FullWidth: string;
begin
  { Full width 6502530000, dialled inside the US. Oracle -> cc 1,
    nsn 6502530000. }
  FullWidth := CodePoints([$FF16, $FF15, $FF10, $FF12, $FF15, $FF13, $FF10,
    $FF10, $FF10, $FF10]);
  Assert.IsTrue(TPhoneNumberUtil.Parse(FullWidth, 'US', Parsed, ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { Full width plus sign and full width digits, no default region. Oracle:
    the same number -> cc 1, nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    CodePoints([$FF0B, $FF11]) + FullWidth, 'ZZ', Parsed, ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { Arabic-Indic. Oracle -> cc 1, nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    CodePoints([$0666, $0665, $0660, $0662, $0665, $0663, $0660, $0660, $0660,
      $0660]), 'US', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { Devanagari. Oracle -> cc 1, nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    CodePoints([$096C, $096B, $0966, $0968, $096B, $0969, $0966, $0966, $0966,
      $0966]), 'US', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { A no break space is VALID_PUNCTUATION, so it separates like a space.
    Oracle: nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '+1' + CodePoints([$00A0]) + '650' + CodePoints([$00A0]) + '253 0000',
    'ZZ', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests.Parse_FillsTheExtensionFromEveryExtnBranch;
const
  Base = '+1 650 253 0000';
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;

  procedure CheckExtension(const AInput, AExpectedExtension: string;
    const AWhat: string);
  var
    Number: TPhoneNumber;
    Error: TPhoneNumberParseError;
  begin
    Assert.IsTrue(TPhoneNumberUtil.Parse(AInput, 'ZZ', Number, Error),
      'Parse failed: ' + AWhat);
    Assert.AreEqual('6502530000', Number.NationalNumberDigits, AWhat);
    Assert.AreEqual(AExpectedExtension, Number.Extension, AWhat);
  end;

begin
  { Every expectation is the extension the oracle reports for the same input.
    The six alternatives of EXTN_PATTERNS_FOR_PARSING are covered in upstream
    order. }

  { 1. rfcExtn }
  CheckExtension(Base + ';ext=1234', '1234', 'rfcExtn');
  CheckExtension(Base + ' ext. 12345678901234567890',
    '12345678901234567890', 'twenty digits after an explicit label');

  { 2. explicitExtn, all label families }
  CheckExtension(Base + ' ext. 1234', '1234', 'ext.');
  CheckExtension(Base + ' extension: 1234', '1234', 'extension:');
  CheckExtension(Base + ' xtn 1234', '1234', 'xtn');
  CheckExtension(Base + ' anexo 1234', '1234', 'anexo');
  CheckExtension(Base + ' EXT. 1234', '1234', 'upper case label');
  CheckExtension(Base + ' ' + CodePoints([$0434, $043E, $0431]) + ' 1234',
    '1234', 'Cyrillic label');
  CheckExtension(Base + ' ' + CodePoints([$FF45, $FF58, $FF54, $FF4E])
    + ' 1234', '1234', 'full width label');
  CheckExtension(Base + ' extensio' + CodePoints([$0301]) + 'n 1234', '1234',
    'combining acute accent');
  CheckExtension(Base + ' extensi' + CodePoints([$00F3]) + 'n 1234', '1234',
    'precomposed o with acute accent');
  CheckExtension(Base + CodePoints([9]) + 'ext 12', '12', 'tab separator');

  { 3. ambiguousExtn, capped at nine digits }
  CheckExtension(Base + ' x123456789', '123456789', 'x with nine digits');
  CheckExtension(Base + '#1234', '1234', 'hash');
  CheckExtension(Base + CodePoints([$FF03]) + '1234', '1234',
    'full width hash');
  CheckExtension(Base + CodePoints([$FF58]) + '1234', '1234',
    'full width x');
  CheckExtension(Base + '~1234', '1234', 'tilde');
  CheckExtension(Base + CodePoints([$FF5E]) + '1234', '1234',
    'full width tilde');
  CheckExtension(Base + ' int 1234', '1234', 'int');
  CheckExtension(Base + ' ' + CodePoints([$FF49, $FF4E, $FF54]) + ' 1234',
    '1234', 'full width int');

  { 4. americanStyleExtnWithSuffix }
  CheckExtension(Base + ' - 503#', '503', 'american style with hash');

  { 5. autoDiallingExtn }
  CheckExtension(Base + ',,1234', '1234', 'two commas');
  CheckExtension(Base + ';1234', '1234', 'semicolon');

  { 6. onlyCommasExtn }
  CheckExtension(Base + ',1234', '1234', 'one comma');

  { The captured group is the RAW substring, so full width extension digits
    stay full width. Oracle: the extension is U+FF11 U+FF12 U+FF13 U+FF14. }
  CheckExtension(Base + ' ext. ' + CodePoints([$FF11, $FF12, $FF13, $FF14]),
    CodePoints([$FF11, $FF12, $FF13, $FF14]), 'full width extension digits');

  { Over the caps nothing matches, and the digits end up in the national
    number instead - which then becomes too long. Oracle:
    Parse(Base + ' x1234567890', 'ZZ') and
    Parse(Base + ' ext. 123456789012345678901', 'ZZ') both throw TOO_LONG. }
  Assert.IsFalse(TPhoneNumberUtil.Parse(Base + ' x1234567890', 'ZZ',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeTooLongNsn), Ord(ParseError));
  Assert.IsFalse(TPhoneNumberUtil.Parse(
    Base + ' ext. 123456789012345678901', 'ZZ', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeTooLongNsn), Ord(ParseError));
end;

procedure TPhoneNumberUtilTests.IsNumberMatch_CompareTwoNumbers;
var
  First, Second: TPhoneNumber;

  procedure Check(const AFirstInput, AFirstRegion, ASecondInput,
    ASecondRegion: string; AExpected: TPhoneNumberMatchType);
  begin
    Assert.AreEqual(Ord(AExpected),
      Ord(TPhoneNumberUtil.IsNumberMatch(
        ParsedNumber(AFirstInput, AFirstRegion),
        ParsedNumber(ASecondInput, ASecondRegion))),
      Format('[%s] vs [%s]', [AFirstInput, ASecondInput]));
  end;

begin
  { Oracle: IsNumberMatch(Parse(a, ra), Parse(b, rb)). }
  Check('+64 3 331 6005', 'NZ', '+64 3 331 6005', 'NZ', pnmtExactMatch);
  Check('+64 3 331 6005', 'NZ', '+64 3 331 6006', 'NZ', pnmtNoMatch);
  Check('+64 3 331 6005', 'NZ', '+1 650 253 0000', 'US', pnmtNoMatch);

  { Both carry an extension and the two differ: the early exit. }
  Check('+64 3 331 6005 extn 1234', 'NZ', '+64 3 331 6005 extn 1235', 'NZ',
    pnmtNoMatch);

  { One has an extension, the other does not: SHORT_NSN_MATCH, not NO_MATCH. }
  Check('+64 3 331 6005 extn 1234', 'NZ', '+64 3 331 6005', 'NZ',
    pnmtShortNsnMatch);

  { One national number is a shorter variant of the other. }
  Check('+1 345 657 1234', 'ZZ', '+1 657 1234', 'ZZ', pnmtShortNsnMatch);

  { The "Italian leading zero" case the upstream doc comment calls out: the
    two national significant numbers differ only in a significant leading
    zero, so isNationalNumberSuffixOfTheOther - which compares the NUMERIC
    national number - reports a match. }
  Check('+39 02 3661 8300', 'IT', '+39 2 3661 8300', 'IT', pnmtShortNsnMatch);
  Assert.AreEqual('0236618300',
    ParsedNumber('+39 02 3661 8300', 'IT').NationalNumberDigits,
    'The leading zero must actually be there, or the case above is vacuous.');
  Assert.AreEqual('236618300',
    ParsedNumber('+39 2 3661 8300', 'IT').NationalNumberDigits);

  { A number with NO calling code - the shape parseHelper produces for
    isNumberMatch when neither side carries one - compares as NSN_MATCH when
    everything else is equal, and as SHORT_NSN_MATCH when one national number
    is a suffix of the other. The record is built by hand because the public
    Parse never returns a calling code of zero; the same two branches are
    exercised end to end by IsNumberMatch_CompareTwoStrings, where the oracle
    reports NSN_MATCH for ('+64 3 331 6005', '3 331 6005'). }
  First := ParsedNumber('+64 3 331 6005', 'NZ');
  Second := Default(TPhoneNumber);
  Second.CountryCode := 0;
  Second.NationalNumberDigits := '33316005';
  Second.NationalNumber := 33316005;
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(First, Second)));

  Second.NationalNumberDigits := '6005';
  Second.NationalNumber := 6005;
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(First, Second)));
end;

procedure TPhoneNumberUtilTests.IsNumberMatch_CompareTwoStrings;

  procedure Check(const AFirst, ASecond: string;
    AExpected: TPhoneNumberMatchType);
  begin
    Assert.AreEqual(Ord(AExpected),
      Ord(TPhoneNumberUtil.IsNumberMatch(AFirst, ASecond)),
      Format('[%s] vs [%s]', [AFirst, ASecond]));
  end;

begin
  { Every expectation is the MatchType the oracle reports for the same pair. }
  Check('+64 3 331 6005', '+64 3 331 6005', pnmtExactMatch);
  Check('+64 3 331 6005', '+64 03 331 6005', pnmtExactMatch);
  Check('+64 3 331 6005', '+64 03 331-6005', pnmtExactMatch);
  Check('+443316005', '+44 331 6005', pnmtExactMatch);
  Check('+80012345678', '+80012345678', pnmtExactMatch);

  { The extension survives the different spellings of the same marker. }
  Check('+64 3 331 6005 extn 1234', '+6433316005#1234', pnmtExactMatch);
  Check('+64 3 331 6005 ext. 1234', '+6433316005;ext=1234', pnmtExactMatch);

  { One side has no calling code of its own. }
  Check('+64 3 331 6005', '3 331 6005', pnmtNsnMatch);
  Check('+64 3 331 6005', '03 331 6005', pnmtNsnMatch);
  Check('+81 345 657 1234', '345 657 1234', pnmtNsnMatch);
  Check('1234', '1234', pnmtNsnMatch);
  Check('331 6005', '331 6005', pnmtNsnMatch);

  { One national number is a shorter variant of the other. }
  Check('+64 3 331 6005', '+64 03 331 6005 extn 1234', pnmtShortNsnMatch);
  Check('3 331 6005', '331 6005', pnmtShortNsnMatch);
  Check('+64 3 331 6005', '331 6005', pnmtShortNsnMatch);
  Check('+1 345 657 1234', '657 1234', pnmtShortNsnMatch);

  { No match. }
  Check('+1 345 657 1234', '345 657', pnmtNoMatch);
  Check('+64 3 331 6005', '+16433316005', pnmtNoMatch);
  Check('+64 3 331 6005', '+6133316005', pnmtNoMatch);
  Check('+64 3 331 6005', '+64 3 331 6006', pnmtNoMatch);
  Check('+64 3 331 6005 extn 1234', '+64 3 331 6005 extn 1235', pnmtNoMatch);

  { Not a number at all. }
  Check('', '+64 3 331 6005', pnmtNotANumber);
  Check('abc', '+64 3 331 6005', pnmtNotANumber);
  Check('+64 3 331 6005', 'abc', pnmtNotANumber);
end;

procedure TPhoneNumberUtilTests.IsNumberMatch_CompareNumberAndString;
var
  Number: TPhoneNumber;

  procedure Check(const ASecond: string; AExpected: TPhoneNumberMatchType);
  begin
    Assert.AreEqual(Ord(AExpected),
      Ord(TPhoneNumberUtil.IsNumberMatch(Number, ASecond)),
      'vs [' + ASecond + ']');
  end;

begin
  { Oracle: IsNumberMatch(Parse('+64 3 331 6005', 'NZ'), <string>). }
  Number := ParsedNumber('+64 3 331 6005', 'NZ');
  Check('+64 3 331 6005', pnmtExactMatch);
  Check('+6433316005', pnmtExactMatch);

  { The string carries no calling code, so it is reparsed with the region of
    the first number and an EXACT_MATCH is downgraded to NSN_MATCH. }
  Check('03 331 6005', pnmtNsnMatch);
  Check('3 331 6005', pnmtNsnMatch);

  Check('331 6005', pnmtShortNsnMatch);
  Check('0331 6005', pnmtShortNsnMatch);
  Check('+1 650 253 0000', pnmtNoMatch);
  Check('abc', pnmtNotANumber);
end;

procedure TPhoneNumberUtilTests.Parse_RetriesCountryCodeExtractionWithoutPlus;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { Port of the catch/retry around the maybeExtractCountryCode call in
    parseHelper. The first attempt strips the leading plus and fails, because
    a country calling code never starts with a zero; Java then removes the
    plus run and runs the whole method again, which gives the international
    prefix of the DEFAULT region its chance.

    All expectations from the NuGet oracle (libphonenumber-csharp 9.0.38). }

  { The case from the review: a leading plus in front of the NANPA IDD 011,
    dialled in the US. Oracle: cc 64, nsn 33316005, E164 +6433316005, and
    ParseAndKeepRawInput reports FROM_NUMBER_WITH_IDD - the source of the
    SECOND attempt, not of the first. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+01164 3 331 6005', 'US', Parsed, ParseError));
  Assert.AreEqual(64, Parsed.CountryCode);
  Assert.AreEqual('33316005', Parsed.NationalNumberDigits);
  Assert.AreEqual('+6433316005', TPhoneNumberUtil.Format(Parsed, pnfE164));

  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('+01164 3 331 6005',
    'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnccsFromNumberWithIdd), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual('+01164 3 331 6005', Parsed.RawInput);

  { The same shape for three more regions and their own international
    prefixes. Oracle: cc 65 / nsn 02530000, cc 1 / nsn 6502530000,
    cc 49 / nsn 30123456, cc 44 / nsn 2079460321, cc 64 / nsn 3316005. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+0116502530000', 'US', Parsed, ParseError));
  Assert.AreEqual(65, Parsed.CountryCode);
  Assert.AreEqual('02530000', Parsed.NationalNumberDigits);

  Assert.IsTrue(TPhoneNumberUtil.Parse('+01116502530000', 'US', Parsed, ParseError));
  Assert.AreEqual(1, Parsed.CountryCode);
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  Assert.IsTrue(TPhoneNumberUtil.Parse('+004930123456', 'DE', Parsed, ParseError));
  Assert.AreEqual(49, Parsed.CountryCode);
  Assert.AreEqual('30123456', Parsed.NationalNumberDigits);

  Assert.IsTrue(TPhoneNumberUtil.Parse('+00442079460321', 'GB', Parsed, ParseError));
  Assert.AreEqual(44, Parsed.CountryCode);
  Assert.AreEqual('2079460321', Parsed.NationalNumberDigits);

  Assert.IsTrue(TPhoneNumberUtil.Parse('+0011643316005', 'AU', Parsed, ParseError));
  Assert.AreEqual(64, Parsed.CountryCode);
  Assert.AreEqual('3316005', Parsed.NationalNumberDigits);

  { The retry must NOT rescue a number that has no interpretation either way -
    Java then reports "Could not interpret numbers after plus-sign". Oracle:
    all three throw INVALID_COUNTRY_CODE. }
  Assert.IsFalse(TPhoneNumberUtil.Parse('+01164 3 331 6005', 'NZ', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeInvalidCountryCode), Ord(ParseError));
  Assert.IsFalse(TPhoneNumberUtil.Parse('+01164 3 331 6005', 'ZZ', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeInvalidCountryCode), Ord(ParseError));
  Assert.IsFalse(TPhoneNumberUtil.Parse('+06502530000', 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeInvalidCountryCode), Ord(ParseError));

  { And a number that never needed the retry is untouched. Oracle: cc 64,
    nsn 33316005, FROM_NUMBER_WITH_PLUS_SIGN. }
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput('+64 3 331 6005', 'US',
    Parsed, ParseError));
  Assert.AreEqual(64, Parsed.CountryCode);
  Assert.AreEqual('33316005', Parsed.NationalNumberDigits);
  Assert.AreEqual(Ord(pnccsFromNumberWithPlusSign),
    Ord(Parsed.CountryCodeSource));
end;

procedure TPhoneNumberUtilTests
  .Parse_SupplementaryCharactersFollowJavaNotTheOracle;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  BoldDigits, Gothic: string;
begin
  { DOCUMENTED DIVERGENCE FROM THE C# ORACLE, see the "Code point scanning"
    block in LibPhoneNumber.MetadataCore.

    java.util.regex matches CODE POINTS, so a supplementary character is one
    unit of input for every character class of the parse path.
    System.Text.RegularExpressions matches UTF-16 CODE UNITS, so .NET sees the
    two halves of a surrogate pair as two characters that are neither a letter
    nor a number. Java is the functional source of truth of this port
    (AGENTS.md), so these two cases pin the JAVA answer and record what the
    oracle says instead. }

  { Three MATHEMATICAL BOLD DIGITs, U+1D7CF..U+1D7D1. Java: viable, because
    DIGITS matches all three; then normalize() drops all six code units,
    because Character.digit(char, 10) cannot see a supplementary code point,
    and nothing is left -> TOO_SHORT_NSN. Oracle: NOT_A_NUMBER, because the
    six surrogate halves are not digits for .NET either in the viability check
    or anywhere else. }
  BoldDigits := CodePoints([$D835, $DFCF, $D835, $DFD0, $D835, $DFD1]);
  Assert.IsTrue(IsViablePhoneNumber(BoldDigits),
    'DIGITS matches a supplementary decimal digit.');
  Assert.AreEqual('', NormalizeDigitsOnly(BoldDigits),
    'Character.digit(char) parity: normalizeDigitsOnly stays BMP only.');
  Assert.IsFalse(TPhoneNumberUtil.Parse(BoldDigits, 'US', Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeTooShortNsn), Ord(ParseError));

  { A trailing GOTHIC LETTER AHSA, U+10330. Java: the character IS a Unicode
    letter, so UNWANTED_END_CHARS does NOT strip it, and VALID_PHONE_NUMBER then rejects
    it because VALID_ALPHA is the ASCII letters only -> NOT_A_NUMBER. Oracle:
    both halves are stripped as unwanted end characters and the number
    parses. }
  Gothic := CodePoints([$D800, $DF30]);
  Assert.AreEqual('+1 650 253 0000' + Gothic,
    ExtractPossibleNumber('+1 650 253 0000' + Gothic),
    'A supplementary LETTER is not an unwanted end character.');
  Assert.IsFalse(IsViablePhoneNumber('+1 650 253 0000' + Gothic));
  Assert.IsFalse(TPhoneNumberUtil.Parse('+1 650 253 0000' + Gothic, 'ZZ',
    Parsed, ParseError));
  Assert.AreEqual(Ord(pnpeNotANumber), Ord(ParseError));

  { Where Java and the oracle AGREE, the port agrees with both: a trailing
    supplementary DIGIT survives extractPossibleNumber and viability and is
    then dropped by normalize(). Oracle: nsn 6502530000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '+1 650 253 0000' + CodePoints([$D835, $DFCF]), 'ZZ', Parsed, ParseError));
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);

  { Oracle: '+1 650 253 000' plus one supplementary digit -> nsn 650253000. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '+1 650 253 000' + CodePoints([$D835, $DFCF]), 'ZZ', Parsed, ParseError));
  Assert.AreEqual('650253000', Parsed.NationalNumberDigits);
end;

procedure TPhoneNumberUtilTests
  .Parse_ExtensionLabelsUseTheJavaCaseFoldingClosure;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  { DOCUMENTED DIVERGENCE FROM THE C# ORACLE, see FoldExtnLabelChar.

    EXTN_PATTERN is compiled with CASE_INSENSITIVE and UNICODE_CASE, and Java
    compares a literal through toLowerCase(toUpperCase(ch)). Over the letters
    the label sets actually use, that equivalence closure reaches three code
    points outside the four alphabet ranges: U+017F LATIN SMALL LETTER LONG S
    folds onto 's', and U+0131 LATIN SMALL LETTER DOTLESS I and U+0130 LATIN
    CAPITAL LETTER I WITH DOT ABOVE fold onto 'i'.

    .NET matches case insensitively with ToLowerInvariant, which leaves all
    three unchanged, so the oracle throws NOT_A_NUMBER for every input below.
    Java accepts them, and so does this port. }
  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '+1 650 253 0000 exten' + CodePoints([$017F]) + 'ion 12', 'ZZ',
    Parsed, ParseError), 'long s in "extension"');
  Assert.AreEqual('6502530000', Parsed.NationalNumberDigits);
  Assert.AreEqual('12', Parsed.Extension);

  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '+1 650 253 0000 ' + CodePoints([$0131]) + 'nt 12', 'ZZ',
    Parsed, ParseError), 'dotless i in "int"');
  Assert.AreEqual('12', Parsed.Extension);

  Assert.IsTrue(TPhoneNumberUtil.Parse(
    '+1 650 253 0000 ' + CodePoints([$0130]) + 'NT 12', 'ZZ',
    Parsed, ParseError), 'dotted capital I in "INT"');
  Assert.AreEqual('12', Parsed.Extension);

  { The ordinary spelling is unaffected and IS oracle verified:
    nsn 6502530000, ext 12. }
  Assert.IsTrue(TPhoneNumberUtil.Parse('+1 650 253 0000 extension 12', 'ZZ',
    Parsed, ParseError));
  Assert.AreEqual('12', Parsed.Extension);
end;

procedure TPhoneNumberUtilTests.IsNumberMatch_CanonicalisesItsOperands;
var
  DigitsOnly, ValueOnly, Other: TPhoneNumber;
begin
  { TPhoneNumber carries the national significant number twice - as a digit
    string and as a number - and the parser fills both. IsNumberMatch is a
    public entry point that also accepts hand built records, so both
    comparisons canonicalise first; without that, a record that carries only
    one of the two representations compared as "no match" against an
    equivalent one. }
  DigitsOnly := Default(TPhoneNumber);
  DigitsOnly.CountryCode := 64;
  DigitsOnly.NationalNumberDigits := '33316005';

  ValueOnly := Default(TPhoneNumber);
  ValueOnly.CountryCode := 64;
  ValueOnly.NationalNumber := 33316005;

  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(DigitsOnly, ValueOnly)),
    'Digits only against value only must be an exact match.');
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(ValueOnly, DigitsOnly)),
    'The comparison is symmetric.');
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(ValueOnly,
      ParsedNumber('+64 3 331 6005', 'NZ'))),
    'And against a parsed number, which fills both fields.');

  { The suffix comparison uses the same canonicalisation. }
  Other := Default(TPhoneNumber);
  Other.CountryCode := 64;
  Other.NationalNumber := 6005;
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(DigitsOnly, Other)));

  { A significant leading zero lives in the digit string only, so a record
    that carries just the number is the "no Italian leading zero" variant -
    upstream's SHORT_NSN_MATCH rather than an exact match. }
  DigitsOnly.CountryCode := 39;
  DigitsOnly.NationalNumberDigits := '0236618300';
  ValueOnly.CountryCode := 39;
  ValueOnly.NationalNumber := 236618300;
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(DigitsOnly, ValueOnly)));
end;

{ ---------------------------------------------------------------------------
  Accessory API (production metadata, values from the NuGet oracle 9.0.41)
  --------------------------------------------------------------------------- }

procedure TPhoneNumberUtilTests.Accessory_ExampleNumbersMatchTheOracle;
var
  Number: TPhoneNumber;

  procedure Check(const AContext: string; ACountryCode: Integer;
    const ANsn: string);
  begin
    Assert.AreEqual(ACountryCode, Number.CountryCode, AContext + ': calling code');
    Assert.AreEqual(ANsn, Number.NationalNumberDigits, AContext + ': NSN');
    Assert.AreEqual('', Number.Extension, AContext + ': extension');
  end;

begin
  { Oracle: GetExampleNumber("DE") -> +49 30123456. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumber('DE', Number));
  Check('example(DE)', 49, '30123456');
  { Oracle: GetExampleNumber("US") -> +1 2015550123. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumber('US', Number));
  Check('example(US)', 1, '2015550123');
  { Oracle: GetExampleNumberForType("DE", MOBILE) -> +49 15123456789. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType('DE', mntMobile,
    Number));
  Check('exampleForType(DE, MOBILE)', 49, '15123456789');
  { Oracle: GetExampleNumberForType("DE", VOICEMAIL) -> +49 177991234567. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType('DE',
    mntVoicemail, Number));
  Check('exampleForType(DE, VOICEMAIL)', 49, '177991234567');
  { Oracle: FIXED_LINE_OR_MOBILE answers the fixed line example,
    +49 30123456. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType('DE',
    mntFixedLineOrMobile, Number));
  Check('exampleForType(DE, FIXED_LINE_OR_MOBILE)', 49, '30123456');
  { Oracle: GetExampleNumberForNonGeoEntity(800 / 979 / 882) ->
    +800 12345678, +979 123456789, +882 3421234; 49 is geographical -> null. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(800,
    Number));
  Check('exampleNonGeo(800)', 800, '12345678');
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(979,
    Number));
  Check('exampleNonGeo(979)', 979, '123456789');
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(882,
    Number));
  Check('exampleNonGeo(882)', 882, '3421234');
  Assert.IsFalse(TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(49,
    Number));
  { Oracle: GetExampleNumber("001") -> null. }
  Assert.IsFalse(TPhoneNumberUtil.TryGetExampleNumber('001', Number));

  { getExampleNumberForType(type) has no specified region upstream (it walks
    a HashSet), so only its contract is checked: a valid number of the
    requested type. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(mntVoip, Number));
  Assert.AreEqual(Ord(mntVoip), Ord(LibPhoneNumber.MetadataCore
    .GetNumberType(Number.CountryCode, Number.NationalNumberDigits)));
end;

procedure TPhoneNumberUtilTests.Accessory_InvalidExampleNumberKeepsItsContract;
const
  Regions: array[0..3] of string = ('DE', 'US', 'GB', 'IT');
var
  I: Integer;
  Number, Example: TPhoneNumber;
begin
  { getInvalidExampleNumber exists in Java only - the C# oracle has no
    counterpart - so this checks the upstream CONTRACT: "the number that is
    returned will always be able to be parsed and will have the correct
    country code", it is not valid, and by construction it is a prefix of the
    fixed line example number. }
  for I := Low(Regions) to High(Regions) do
  begin
    Assert.IsTrue(TPhoneNumberUtil.TryGetInvalidExampleNumber(Regions[I],
      Number), Regions[I]);
    Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumber(Regions[I], Example),
      Regions[I]);
    Assert.AreEqual(Example.CountryCode, Number.CountryCode, Regions[I]);
    Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(
      Number.CountryCode, Number.NationalNumberDigits), Regions[I]);
    Assert.IsTrue(Number.NationalNumber <> 0, Regions[I]);
  end;
  Assert.IsFalse(TPhoneNumberUtil.TryGetInvalidExampleNumber('001', Number));
  Assert.IsFalse(TPhoneNumberUtil.TryGetInvalidExampleNumber('ZZ', Number));
end;

procedure TPhoneNumberUtilTests.Accessory_SupportedTypesMatchTheOracle;
begin
  { Oracle: GetSupportedTypesForRegion("DE") -> FIXED_LINE, MOBILE, TOLL_FREE,
    PREMIUM_RATE, SHARED_COST, PERSONAL_NUMBER, PAGER, UAN, VOICEMAIL. }
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForRegion('DE')
    = [mntFixedLine, mntMobile, mntTollFree, mntPremiumRate, mntSharedCost,
       mntPersonalNumber, mntPager, mntUan, mntVoicemail], 'DE');
  { Oracle: "US" -> FIXED_LINE, MOBILE, TOLL_FREE, PREMIUM_RATE,
    PERSONAL_NUMBER. }
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForRegion('US')
    = [mntFixedLine, mntMobile, mntTollFree, mntPremiumRate,
       mntPersonalNumber], 'US');
  { Oracle: "ZZ" -> empty. }
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForRegion('ZZ') = [], 'ZZ');
  { Oracle: GetSupportedTypesForNonGeoEntity(800) -> TOLL_FREE,
    (979) -> PREMIUM_RATE. }
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(800)
    = [mntTollFree], '800');
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(979)
    = [mntPremiumRate], '979');
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(49) = [],
    '49 is geographical');
end;

procedure TPhoneNumberUtilTests.Accessory_GeographyAndCodeLengthsMatchTheOracle;
type
  TCase = record
    Input: string;
    Geographical: Boolean;
    AreaCode: Integer;
    Ndc: Integer;
  end;
const
  { Oracle 9.0.41, IsNumberGeographical / GetLengthOfGeographicalAreaCode /
    GetLengthOfNationalDestinationCode of Parse(Input, "ZZ"). The comment is
    the oracle's type and INTERNATIONAL format. }
  Cases: array[0..15] of TCase = (
    (Input: '+4930123456'; Geographical: True; AreaCode: 2; Ndc: 2),       // FIXED_LINE +49 30 123456
    (Input: '+4915123456789'; Geographical: False; AreaCode: 0; Ndc: 4),   // MOBILE +49 1512 3456789
    (Input: '+16502530000'; Geographical: True; AreaCode: 3; Ndc: 3),      // FIXED_LINE_OR_MOBILE +1 650-253-0000
    (Input: '+18002530000'; Geographical: False; AreaCode: 0; Ndc: 3),     // TOLL_FREE +1 800-253-0000
    (Input: '+390236618300'; Geographical: True; AreaCode: 2; Ndc: 2),     // FIXED_LINE +39 02 3661 8300
    (Input: '+393123456789'; Geographical: False; AreaCode: 0; Ndc: 3),    // MOBILE +39 312 345 6789
    (Input: '+442070313000'; Geographical: True; AreaCode: 2; Ndc: 2),     // FIXED_LINE +44 20 7031 3000
    (Input: '+447912345678'; Geographical: False; AreaCode: 0; Ndc: 4),    // MOBILE +44 7912 345678
    (Input: '+5491123456789'; Geographical: True; AreaCode: 3; Ndc: 3),    // MOBILE +54 9 11 2345-6789
    (Input: '+541123456789'; Geographical: True; AreaCode: 2; Ndc: 2),     // FIXED_LINE +54 11 2345-6789
    (Input: '+8618912341234'; Geographical: True; AreaCode: 0; Ndc: 3),    // MOBILE +86 189 1234 1234
    (Input: '+861012345678'; Geographical: True; AreaCode: 2; Ndc: 2),     // FIXED_LINE +86 10 1234 5678
    (Input: '+523312345678'; Geographical: True; AreaCode: 2; Ndc: 2),     // FIXED_LINE_OR_MOBILE +52 33 1234 5678
    (Input: '+6565218000'; Geographical: True; AreaCode: 0; Ndc: 4),       // FIXED_LINE +65 6521 8000
    (Input: '+80012345678'; Geographical: False; AreaCode: 0; Ndc: 4),     // TOLL_FREE +800 1234 5678
    (Input: '+61236618300'; Geographical: True; AreaCode: 1; Ndc: 1)       // FIXED_LINE +61 2 3661 8300
  );
var
  I: Integer;
  Number: TPhoneNumber;
begin
  for I := Low(Cases) to High(Cases) do
  begin
    Number := ParsedNumber(Cases[I].Input, 'ZZ');
    Assert.AreEqual(Cases[I].Geographical,
      TPhoneNumberUtil.IsNumberGeographical(Number),
      Cases[I].Input + ': isNumberGeographical');
    Assert.AreEqual(Cases[I].AreaCode,
      TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(Number),
      Cases[I].Input + ': getLengthOfGeographicalAreaCode');
    Assert.AreEqual(Cases[I].Ndc,
      TPhoneNumberUtil.GetLengthOfNationalDestinationCode(Number),
      Cases[I].Input + ': getLengthOfNationalDestinationCode');
  end;

  { An extension does not change the NDC: Java formats a copy without it. }
  Number := ParsedNumber('+4930123456 ext. 12', 'ZZ');
  Assert.AreEqual('12', Number.Extension);
  Assert.AreEqual(Integer(2),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(Number));

  { The type overload of isNumberGeographical: FIXED_LINE_OR_MOBILE is
    geographical everywhere, MOBILE only in GEO_MOBILE_COUNTRIES. }
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsNumberGeographical(
    mntFixedLineOrMobile, 49));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsNumberGeographical(
    mntMobile, 55));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsNumberGeographical(
    mntMobile, 49));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsNumberGeographical(
    mntTollFree, 52));
end;

procedure TPhoneNumberUtilTests.Accessory_TruncateTooLongNumberMatchesTheOracle;
type
  TCase = record
    Input: string;
    Expected: Boolean;
    ResultNsn: string;
  end;
const
  { Oracle 9.0.41: TruncateTooLongNumber on Parse(Input, "ZZ"), followed by
    GetNationalSignificantNumber of the (possibly modified) number. }
  Cases: array[0..5] of TCase = (
    (Input: '+165025300001'; Expected: True; ResultNsn: '6502530000'),
    (Input: '+4480123456780123'; Expected: False; ResultNsn: '80123456780123'),
    (Input: '+49301234567890'; Expected: True; ResultNsn: '301234567890'),
    (Input: '+3902366183001234'; Expected: True; ResultNsn: '02366183001'),
    (Input: '+12401234567'; Expected: False; ResultNsn: '2401234567'),
    (Input: '+11234'; Expected: False; ResultNsn: '1234')
  );
var
  I: Integer;
  Number: TPhoneNumber;
begin
  for I := Low(Cases) to High(Cases) do
  begin
    Number := ParsedNumber(Cases[I].Input, 'ZZ');
    Assert.AreEqual(Cases[I].Expected,
      TPhoneNumberUtil.TruncateTooLongNumber(Number), Cases[I].Input);
    Assert.AreEqual(Cases[I].ResultNsn, Number.NationalNumberDigits,
      Cases[I].Input + ': NSN afterwards');
    Assert.IsTrue(Number.NationalNumber = StrToUInt64(Cases[I].ResultNsn),
      Cases[I].Input + ': numeric field follows the digits');
  end;
end;

procedure TPhoneNumberUtilTests.Accessory_AlphaNumberMobileTokenAndNsnMatchTheOracle;
begin
  { Oracle 9.0.41 IsAlphaNumber. }
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('1800 six-flags'));
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('1800 six-flags ext. 1234'));
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('+800 six-flags'));
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('0800 FLOWERS'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber('1800 123-1234'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber('1 six-flags'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber('+49 30 123456'));

  { Oracle: GetCountryMobileToken(54) = "9", (49) = "". }
  Assert.AreEqual('9', TPhoneNumberUtil.GetCountryMobileToken(54));
  Assert.AreEqual('', TPhoneNumberUtil.GetCountryMobileToken(49));

  { Oracle: GetNationalSignificantNumber(Parse("02 3661 8300", "IT")) =
    "0236618300" - the Italian leading zero survives. }
  Assert.AreEqual('0236618300', TPhoneNumberUtil.GetNationalSignificantNumber(
    ParsedNumber('02 3661 8300', 'IT')));
end;

procedure TPhoneNumberUtilTests.Accessory_RegionArgumentsAreCanonicalised;
var
  Upper, Lower: TPhoneNumber;
begin
  { Port rule, not an oracle value: every public region argument goes through
    UpperCase(Trim(...)). }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumber('DE', Upper));
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumber(' de ', Lower));
  Assert.AreEqual(Upper.NationalNumberDigits, Lower.NationalNumberDigits);
  Assert.IsTrue(TPhoneNumberUtil.TryGetInvalidExampleNumber('de', Lower));
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForRegion('de')
    = TPhoneNumberUtil.GetSupportedTypesForRegion('DE'));
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForRegion('de') <> []);
end;

procedure TPhoneNumberUtilTests.Accessory_NationalSignificantNumberMatchesTheOracle;
var
  Number: TPhoneNumber;
begin
  { Oracle 9.0.41: GetNationalSignificantNumber(new PhoneNumber()) = "0" -
    Java appends the numeric national number unconditionally. }
  Number := Default(TPhoneNumber);
  Assert.AreEqual('0', TPhoneNumberUtil.GetNationalSignificantNumber(Number));
  Number.CountryCode := 1;
  Assert.AreEqual('0', TPhoneNumberUtil.GetNationalSignificantNumber(Number));

  { Oracle 9.0.41, the cap of ten leading zeros (Java
    getNationalSignificantNumber, "defensively cap"):
      Parse("+100000000000650", "ZZ")   -> 11 leading zeros -> "0000000000650"
      Parse("+10000000000650", "ZZ")    -> 10 leading zeros -> "0000000000650"
      Parse("+39000000000000236", "ZZ") -> 12 leading zeros -> "0000000000236" }
  Assert.AreEqual('0000000000650', TPhoneNumberUtil.GetNationalSignificantNumber(
    ParsedNumber('+100000000000650', 'ZZ')));
  Assert.AreEqual('0000000000650', TPhoneNumberUtil.GetNationalSignificantNumber(
    ParsedNumber('+10000000000650', 'ZZ')));
  Assert.AreEqual('0000000000236', TPhoneNumberUtil.GetNationalSignificantNumber(
    ParsedNumber('+39000000000000236', 'ZZ')));

  { Oracle 9.0.41, a hand built number: CountryCode 1, NationalNumber 650,
    NumberOfLeadingZeros 11 -> "0000000000650". The record spells that as
    eleven zeros in the digits. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 1;
  Number.NationalNumberDigits := '00000000000650';
  Number.NationalNumber := 650;
  Assert.AreEqual('0000000000650',
    TPhoneNumberUtil.GetNationalSignificantNumber(Number));

  { Port rule, not an oracle value: the cap is applied by this public method
    only. The record's own digits stay what the parser produced, i.e. they
    keep all eleven zeros (documented divergence at the facade). }
  Assert.AreEqual('00000000000650',
    ParsedNumber('+100000000000650', 'ZZ').NationalNumberDigits);
end;

initialization
  RegisterTest(TPhoneNumberUtilTests);

end.
