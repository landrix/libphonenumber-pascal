unit LibPhoneNumber.UpstreamSuite.Tests;

{
  Port of the upstream Java test suite, run against the upstream TEST metadata.

  ============================================================================
  READ THIS FIRST: the expected values here come STRAIGHT OUT OF THE JAVA TEST
  SUITE, and that is correct ONLY in this file.
  ============================================================================

  AGENTS.md "Test Expectations" forbids copying an expected value out of
  PhoneNumberUtilTest.java into a test of this repository, because that suite
  runs against PhoneNumberMetadataForTesting.xml while the rest of our tests
  run against the shipped PhoneNumberMetadata.xml - the two data sets disagree
  for AR, AU, MX, UZ and others, so a value copied across data sets is simply
  wrong.

  This fixture removes the reason for that rule: Setup switches the metadata
  lookup layer onto the GENERATED TESTING TABLES
  (LibPhoneNumber.TestingMetadata, built from the very same
  PhoneNumberMetadataForTesting.xml), TearDown switches it back. Inside these
  fixtures we therefore read the same data the Java suite reads, and its
  expected values are the correct expected values - no oracle recomputation,
  and none is meaningful here, because the NuGet oracle ships the PRODUCTION
  metadata.

  The rule stands unchanged everywhere else. Any test outside a testing-metadata
  fixture still has to recompute its values with the oracle or read them off the
  productive XML.

  Source of the ported cases:
    vendor/libphonenumber/java/libphonenumber/test/com/google/i18n/phonenumbers/
      PhoneNumberUtilTest.java

  Shape of the port
  -----------------
  1. Java holds a mutable Phonenumber.PhoneNumber; this port holds the
     immutable record TPhoneNumber and builds one per case with MakeNumber.
     italianLeadingZero/numberOfLeadingZeros have no counterpart: the national
     significant number is carried as DIGITS, so "011" and "11" are simply two
     different strings. That is the same information, encoded once instead of
     three times.
  2. Java compares whole protos with assertEquals; this port compares the
     three fields that carry the number - calling code, national significant
     number, extension - plus, for the parseAndKeepRawInput cases, raw input,
     country code source and preferred carrier code. The remaining proto fields
     are exactly the ones the record does not model.
  3. Java throws NumberParseException; this port returns False plus a
     TPhoneNumberParseError, so a "fail(...)" case becomes CheckParseFails.
  4. The validation and typing entry points of this port take
     (calling code, national significant number) where upstream takes a
     PhoneNumber, so every case passes the pair the Java number stands for.

  Coverage
  --------
  PhoneNumberUtilTest declares 121 test methods. 115 of them are covered here
  by 113 fixture methods - the three getMetadataFor*_shouldBeNull tests are one
  method, because they are one lookup each - plus two fixture methods of this
  port's own that pin the metadata switch. The remaining 6 are listed below.

  The fourteen methods of the accessory API step (getSupportedTypesFor*,
  isNumberGeographical, getLengthOfGeographicalAreaCode,
  getLengthOfNationalDestinationCode, getCountryMobileToken,
  getNationalSignificantNumber and its _ManyLeadingZeros variant, the four
  getExampleNumber* tests, getInvalidExampleNumber, truncateTooLongNumber and
  isAlphaNumber) are ported at the end of this file. The record form shows in two places only: a Java number with
  italianLeadingZero = true is written with its leading zero in the digits
  (IT_NUMBER is 0236618300 here), and one assertion of
  Test_GetNationalSignificantNumber_ManyLeadingZeros carries an UPSTREAM ONLY
  marker.

  Tests of PhoneNumberUtilTest that are NOT ported, and why
  --------------------------------------------------------
  None of these is blocked on missing library surface. They test a
  private step of the parse driver on its own, a metadata loader the port does
  not have, or a proto field pair the record does not model:

    testMaybeStripInternationalPrefix     - an API SHAPE difference, not a
                                            metadata one:
                                            maybeStripInternationalPrefixAnd
                                            Normalize is a private step of the
                                            parse driver here and is not
                                            callable on its own. Covered
                                            indirectly by
                                            ParseWithInternationalPrefixes and
                                            by the CountryCodeSource
                                            assertions of ParseAndKeepRaw.
    testMaybeExtractCountryCode           - same shape difference:
                                            TryMaybeExtractCountryCode is a
                                            private method of the facade;
                                            covered by ParseAndKeepRaw.
    testGetMetadataForRegionForMissing    - needs a metadata SOURCE that can
      Metadata / ...ForNonGeographical...    FAIL. UseMetadataTables installs a
                                            data set, it does not install a
                                            loader, and the generated tables
                                            are linked - there is no state in
                                            which a lookup can throw.
    testIsNumberMatchAcceptsProtoDefaults - both assert how the proto pair
      AsMatch                                italianLeadingZero /
    testIsNumberMatchMatchesDiffLeading      numberOfLeadingZeros interacts.
      ZerosIfItalianLeadingZeroFalse         TPhoneNumber carries the national
                                             significant number as DIGITS, so
                                             the pair does not exist and
                                             neither does the case; see the
                                             comment in
                                             Test_IsNumberMatchShortMatchIf
                                             DiffNumLeadingZeros.

  testMaybeStripNationalPrefix IS ported (Test_MaybeStripNationalPrefix): the
  Java case builds a synthetic PhoneMetadata.Builder, and the port
  can do the same thing - UseSyntheticMetadata installs a complete, self
  consistent ONE TERRITORY data set through UseMetadataTables for the duration
  of the test and a finally block puts the testing tables back.

  Single assertions left out inside a ported test are marked with an
  "UPSTREAM ONLY" comment at the place they belong. Exactly two such markers
  are left, in Test_IsNumberMatchShortMatchIfDiffNumLeadingZeros and in
  Test_GetNationalSignificantNumber_ManyLeadingZeros (both about the
  numberOfLeadingZeros field).
}

interface

uses
  DUnitX.TestFramework,
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.MetadataFormat,
  LibPhoneNumber.TestingMetadata,
  LibPhoneNumber.PhoneNumberUtil;

type
  [TestFixture]
  TUpstreamPhoneNumberUtilTests = class
  private
    { A complete, self consistent ONE TERRITORY data set, used by
      Test_MaybeStripNationalPrefix to reproduce the synthetic
      PhoneMetadata.Builder of the Java test. Fields rather than locals so the
      pointers the lookup layer holds cannot outlive their storage. }
    FSynTerritories: array[0..0] of TPhoneMetadataRec;
    FSynDescs: array[0..PhoneNumberDescKindCount - 1] of TPhoneNumberDescRec;
    FSynLengths: array[0..0] of SmallInt;
    FSynFormats: array[0..0] of TNumberFormatRec;
    FSynLeadingDigits: array[0..0] of string;
    FSynRegionOrder: array[0..0] of SmallInt;
    FSynRegionCodes: array[0..0] of string;
    FSynNonGeoOrder: array[0..0] of SmallInt;
    FSynNonGeoCallingCodes: array[0..0] of Integer;
    FSynCountryCodeGroups: array[0..0] of TCountryCodeGroupRec;
    FSynCountryCodeRegions: array[0..0] of SmallInt;
    procedure UseSyntheticMetadata(const ANationalPrefixForParsing,
      ANationalPrefixTransformRule, AGeneralDescPattern: string);

    function MakeNumber(ACountryCode: Integer;
      const ANationalNumber: string): TPhoneNumber; overload;
    function MakeNumber(ACountryCode: Integer;
      const ANationalNumber, AExtension: string): TPhoneNumber; overload;
    function ParseOk(const ANumber, ARegion: string): TPhoneNumber;
    function ParseRawOk(const ANumber, ARegion: string): TPhoneNumber;
    procedure CheckNumber(const AExpected, AActual: TPhoneNumber;
      const AContext: string);
    procedure CheckParse(const AExpected: TPhoneNumber;
      const ANumber, ARegion: string);
    procedure CheckParseFails(const ANumber, ARegion: string;
      AExpected: TPhoneNumberParseError);
    procedure CheckPossible(ACountryCode: Integer; const ANsn: string;
      AType: TMetadataNumberType; AExpected: TMetadataValidationResult);
    function TypeOf(ACountryCode: Integer;
      const ANsn: string): TMetadataNumberType;
    function MetadataOf(const ARegion: string): PPhoneMetadataRec;
    function NonGeoMetadataOf(ACountryCode: Integer): PPhoneMetadataRec;
    function ContainsRegion(const AList: TMetadataStringArray;
      const ARegion: string): Boolean;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    { --- the fixture itself -------------------------------------------- }
    [Test]
    procedure TestingMetadata_IsActiveInsideThisFixture;

    [Test]
    procedure TestingMetadata_CarriesItsOwnProvenance;

    { --- metadata, regions and calling codes ---------------------------- }
    [Test]
    procedure Test_GetSupportedRegions;

    [Test]
    procedure Test_GetSupportedGlobalNetworkCallingCodes;

    [Test]
    procedure Test_GetSupportedCallingCodes;

    [Test]
    procedure Test_GetInstanceLoadBadMetadata;

    [Test]
    procedure Test_GetInstanceLoadUSMetadata;

    [Test]
    procedure Test_GetInstanceLoadDEMetadata;

    [Test]
    procedure Test_GetInstanceLoadARMetadata;

    [Test]
    procedure Test_GetInstanceLoadInternationalTollFreeMetadata;

    [Test]
    procedure Test_GetRegionCodeForCountryCode;

    [Test]
    procedure Test_GetRegionCodeForNumber;

    [Test]
    procedure Test_GetRegionCodesForCountryCode;

    [Test]
    procedure Test_GetCountryCodeForRegion;

    [Test]
    procedure Test_GetNationalDiallingPrefixForRegion;

    [Test]
    procedure Test_IsNANPACountry;

    [Test]
    procedure Test_IsMobileNumberPortableRegion;

    [Test]
    procedure Test_GetMetadataForRegionForNonGeoEntityAndUnknownRegion;

    { --- normalisation -------------------------------------------------- }
    [Test]
    procedure Test_ConvertAlphaCharactersInNumber;

    [Test]
    procedure Test_NormaliseRemovePunctuation;

    [Test]
    procedure Test_NormaliseReplaceAlphaCharacters;

    [Test]
    procedure Test_NormaliseOtherDigits;

    [Test]
    procedure Test_NormaliseStripAlphaCharacters;

    [Test]
    procedure Test_NormaliseStripNonDiallableCharacters;

    { --- format ---------------------------------------------------------- }
    [Test]
    procedure Test_FormatUSNumber;

    [Test]
    procedure Test_FormatAUShortCodeNumber;

    [Test]
    procedure Test_FormatBSNumber;

    [Test]
    procedure Test_FormatGBNumber;

    [Test]
    procedure Test_FormatDENumber;

    [Test]
    procedure Test_FormatITNumber;

    [Test]
    procedure Test_FormatAUNumber;

    [Test]
    procedure Test_FormatARNumber;

    [Test]
    procedure Test_FormatMXNumber;

    [Test]
    procedure Test_FormatOutOfCountryCallingNumber;

    [Test]
    procedure Test_FormatOutOfCountryWithInvalidRegion;

    [Test]
    procedure Test_FormatOutOfCountryWithPreferredIntlPrefix;

    [Test]
    procedure Test_FormatOutOfCountryKeepingAlphaChars;

    [Test]
    procedure Test_FormatWithCarrierCode;

    [Test]
    procedure Test_FormatWithPreferredCarrierCode;

    [Test]
    procedure Test_FormatNumberForMobileDialing;

    [Test]
    procedure Test_FormatByPattern;

    [Test]
    procedure Test_FormatE164Number;

    [Test]
    procedure Test_FormatNumberWithExtension;

    [Test]
    procedure Test_FormatInOriginalFormat;

    [Test]
    procedure Test_CountryWithNoNumberDesc;

    [Test]
    procedure Test_UnknownCountryCallingCode;

    { --- typing, validity, possibility ---------------------------------- }
    [Test]
    procedure Test_IsPremiumRate;

    [Test]
    procedure Test_IsTollFree;

    [Test]
    procedure Test_IsMobile;

    [Test]
    procedure Test_IsFixedLine;

    [Test]
    procedure Test_IsFixedLineAndMobile;

    [Test]
    procedure Test_IsSharedCost;

    [Test]
    procedure Test_IsVoip;

    [Test]
    procedure Test_IsPersonalNumber;

    [Test]
    procedure Test_IsUnknown;

    [Test]
    procedure Test_IsValidNumber;

    [Test]
    procedure Test_IsValidForRegion;

    [Test]
    procedure Test_IsNotValidNumber;

    [Test]
    procedure Test_IsPossibleNumber;

    [Test]
    procedure Test_IsPossibleNumberForType_DifferentTypeLengths;

    [Test]
    procedure Test_IsPossibleNumberForType_LocalOnly;

    [Test]
    procedure Test_IsPossibleNumberForType_DataMissingForSizeReasons;

    [Test]
    procedure Test_IsPossibleNumberForType_NumberTypeNotSupportedForRegion;

    [Test]
    procedure Test_IsPossibleNumberWithReason;

    [Test]
    procedure Test_IsPossibleNumberForTypeWithReason_DifferentTypeLengths;

    [Test]
    procedure Test_IsPossibleNumberForTypeWithReason_LocalOnly;

    [Test]
    procedure Test_IsPossibleNumberForTypeWithReason_DataMissingForSizeReasons;

    [Test]
    procedure Test_IsPossibleNumberForTypeWithReason_NumberTypeNotSupportedForRegion;

    [Test]
    procedure Test_IsPossibleNumberForTypeWithReason_FixedLineOrMobile;

    [Test]
    procedure Test_IsNotPossibleNumber;

    [Test]
    procedure Test_CanBeInternationallyDialled;

    { --- parse ----------------------------------------------------------- }
    [Test]
    procedure Test_IsViablePhoneNumber;

    [Test]
    procedure Test_IsViablePhoneNumberNonAscii;

    [Test]
    procedure Test_ExtractPossibleNumber;

    [Test]
    procedure Test_MaybeStripNationalPrefix;

    [Test]
    procedure Test_ParseNationalNumber;

    [Test]
    procedure Test_ParseNumberWithAlphaCharacters;

    [Test]
    procedure Test_ParseMaliciousInput;

    [Test]
    procedure Test_ParseWithInternationalPrefixes;

    [Test]
    procedure Test_ParseNonAscii;

    [Test]
    procedure Test_ParseWithLeadingZero;

    [Test]
    procedure Test_ParseNationalNumberArgentina;

    [Test]
    procedure Test_ParseWithXInNumber;

    [Test]
    procedure Test_ParseNumbersMexico;

    [Test]
    procedure Test_FailedParseOnInvalidNumbers;

    [Test]
    procedure Test_ParseNumbersWithPlusWithNoRegion;

    [Test]
    procedure Test_ParseNumberTooShortIfNationalPrefixStripped;

    [Test]
    procedure Test_ParseExtensions;

    [Test]
    procedure Test_ParseHandlesLongExtensionsWithExplicitLabels;

    [Test]
    procedure Test_ParseHandlesLongExtensionsWithAutoDiallingLabels;

    [Test]
    procedure Test_ParseHandlesShortExtensionsWithAmbiguousChar;

    [Test]
    procedure Test_ParseHandlesShortExtensionsWhenNotSureOfLabel;

    [Test]
    procedure Test_ParseAndKeepRaw;

    [Test]
    procedure Test_ParseItalianLeadingZeros;

    [Test]
    procedure Test_ParseWithPhoneContext;

    { --- isNumberMatch ---------------------------------------------------- }
    [Test]
    procedure Test_IsNumberMatchMatches;

    [Test]
    procedure Test_IsNumberMatchShortMatchIfDiffNumLeadingZeros;

    [Test]
    procedure Test_IsNumberMatchIgnoresSomeFields;

    [Test]
    procedure Test_IsNumberMatchNonMatches;

    [Test]
    procedure Test_IsNumberMatchNsnMatches;

    [Test]
    procedure Test_IsNumberMatchShortNsnMatches;

    { --- accessory API ---------------------------------------------------- }
    [Test]
    procedure Test_GetSupportedTypesForRegion;

    [Test]
    procedure Test_GetSupportedTypesForNonGeoEntity;

    [Test]
    procedure Test_IsNumberGeographical;

    [Test]
    procedure Test_GetLengthOfGeographicalAreaCode;

    [Test]
    procedure Test_GetLengthOfNationalDestinationCode;

    [Test]
    procedure Test_GetCountryMobileToken;

    [Test]
    procedure Test_GetNationalSignificantNumber;

    [Test]
    procedure Test_GetNationalSignificantNumber_ManyLeadingZeros;

    [Test]
    procedure Test_GetExampleNumber;

    [Test]
    procedure Test_GetInvalidExampleNumber;

    [Test]
    procedure Test_GetExampleNumberForNonGeoEntity;

    [Test]
    procedure Test_GetExampleNumberWithoutRegion;

    [Test]
    procedure Test_TruncateTooLongNumber;

    [Test]
    procedure Test_IsAlphaNumber;
  end;

implementation

uses
  System.SysUtils;

const
  { RegionCode.java of the upstream test suite. }
  RC_UN001 = '001';
  RC_AD = 'AD';
  RC_AE = 'AE';
  RC_AO = 'AO';
  RC_AR = 'AR';
  RC_AU = 'AU';
  RC_BR = 'BR';
  RC_BS = 'BS';
  RC_BY = 'BY';
  RC_CA = 'CA';
  RC_CN = 'CN';
  RC_CO = 'CO';
  RC_DE = 'DE';
  RC_GB = 'GB';
  RC_IT = 'IT';
  RC_JP = 'JP';
  RC_KR = 'KR';
  RC_MX = 'MX';
  RC_NZ = 'NZ';
  RC_PL = 'PL';
  RC_RE = 'RE';
  RC_RU = 'RU';
  RC_SE = 'SE';
  RC_SG = 'SG';
  RC_US = 'US';
  RC_UZ = 'UZ';
  RC_YT = 'YT';
  RC_ZZ = 'ZZ';

{ ---------------------------------------------------------------------------
  Fixture helpers
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Setup;
begin
  { Upstream TestMetadataTestCase.setUp installs a PhoneNumberUtil over the
    test metadata as the singleton; this is the same step for a stateless
    port. }
  UseTestingMetadata;
end;

procedure TUpstreamPhoneNumberUtilTests.TearDown;
begin
  { Upstream TestMetadataTestCase.tearDown clears the singleton again. Anything
    that runs after this fixture must see the production tables. }
  RestoreProductionMetadata;
end;

function TUpstreamPhoneNumberUtilTests.MakeNumber(ACountryCode: Integer;
  const ANationalNumber: string): TPhoneNumber;
begin
  Result := MakeNumber(ACountryCode, ANationalNumber, '');
end;

function TUpstreamPhoneNumberUtilTests.MakeNumber(ACountryCode: Integer;
  const ANationalNumber, AExtension: string): TPhoneNumber;
var
  Digits: string;
  I: Integer;
begin
  Result := Default(TPhoneNumber);
  Result.CountryCode := ACountryCode;
  Result.NationalNumberDigits := ANationalNumber;
  Result.Extension := AExtension;

  { The numeric field of the record mirrors the Java nationalNumber, i.e. the
    digits without their leading zeros. }
  Digits := ANationalNumber;
  I := 1;
  while (I < Length(Digits)) and (Digits[I] = '0') do
    Inc(I);
  Digits := Copy(Digits, I, MaxInt);
  if Digits = '' then
    Result.NationalNumber := 0
  else
    Result.NationalNumber := StrToUInt64(Digits);
end;

function TUpstreamPhoneNumberUtilTests.ParseOk(const ANumber,
  ARegion: string): TPhoneNumber;
var
  Error: TPhoneNumberParseError;
begin
  if not TPhoneNumberUtil.Parse(ANumber, ARegion, Result, Error) then
    Assert.Fail(Format('Parse("%s", "%s") failed with error %d',
      [ANumber, ARegion, Ord(Error)]));
end;

function TUpstreamPhoneNumberUtilTests.ParseRawOk(const ANumber,
  ARegion: string): TPhoneNumber;
var
  Error: TPhoneNumberParseError;
begin
  if not TPhoneNumberUtil.ParseAndKeepRawInput(ANumber, ARegion, Result,
    Error) then
    Assert.Fail(Format('ParseAndKeepRawInput("%s", "%s") failed with error %d',
      [ANumber, ARegion, Ord(Error)]));
end;

procedure TUpstreamPhoneNumberUtilTests.CheckNumber(const AExpected,
  AActual: TPhoneNumber; const AContext: string);
begin
  Assert.AreEqual(AExpected.CountryCode, AActual.CountryCode,
    AContext + ': calling code');
  Assert.AreEqual(AExpected.NationalNumberDigits, AActual.NationalNumberDigits,
    AContext + ': national significant number');
  Assert.AreEqual(AExpected.Extension, AActual.Extension,
    AContext + ': extension');
end;

procedure TUpstreamPhoneNumberUtilTests.CheckParse(const AExpected: TPhoneNumber;
  const ANumber, ARegion: string);
begin
  CheckNumber(AExpected, ParseOk(ANumber, ARegion),
    Format('parse("%s", "%s")', [ANumber, ARegion]));
end;

procedure TUpstreamPhoneNumberUtilTests.CheckParseFails(const ANumber,
  ARegion: string; AExpected: TPhoneNumberParseError);
var
  Parsed: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  if TPhoneNumberUtil.Parse(ANumber, ARegion, Parsed, Error) then
    Assert.Fail(Format('parse("%s", "%s") should have failed', [ANumber, ARegion]));
  Assert.AreEqual(Ord(AExpected), Ord(Error),
    Format('parse("%s", "%s"): wrong error type', [ANumber, ARegion]));
end;

procedure TUpstreamPhoneNumberUtilTests.CheckPossible(ACountryCode: Integer;
  const ANsn: string; AType: TMetadataNumberType;
  AExpected: TMetadataValidationResult);
var
  Actual: TMetadataValidationResult;
begin
  Actual := IsPossibleNumberForTypeWithReason(ACountryCode, ANsn, AType);
  Assert.AreEqual(ValidationResultToString(AExpected),
    ValidationResultToString(Actual),
    Format('isPossibleNumberForTypeWithReason(+%d %s, %s)',
      [ACountryCode, ANsn, NumberTypeToString(AType)]));
end;

function TUpstreamPhoneNumberUtilTests.TypeOf(ACountryCode: Integer;
  const ANsn: string): TMetadataNumberType;
begin
  Result := LibPhoneNumber.MetadataCore.GetNumberType(ACountryCode, ANsn);
end;

function TUpstreamPhoneNumberUtilTests.MetadataOf(
  const ARegion: string): PPhoneMetadataRec;
begin
  if not TryGetMetadataForRegion(ARegion, Result) then
    Assert.Fail('No metadata for region ' + ARegion);
end;

function TUpstreamPhoneNumberUtilTests.NonGeoMetadataOf(
  ACountryCode: Integer): PPhoneMetadataRec;
begin
  if not TryGetMetadataForNonGeoEntity(ACountryCode, Result) then
    Assert.Fail(Format('No metadata for non geo entity %d', [ACountryCode]));
end;

function TUpstreamPhoneNumberUtilTests.ContainsRegion(
  const AList: TMetadataStringArray; const ARegion: string): Boolean;
var
  I: Integer;
begin
  for I := 0 to Length(AList) - 1 do
    if AList[I] = ARegion then
      Exit(True);
  Result := False;
end;

{ ---------------------------------------------------------------------------
  The fixture itself
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.TestingMetadata_IsActiveInsideThisFixture;
begin
  Assert.IsTrue(IsTestingMetadataActive,
    'Setup must have switched the lookup layer onto the testing tables');
  Assert.IsFalse(IsProductionMetadataActive,
    'The production tables must not be active inside this fixture');
  { 36 territories, 33 regions and 3 non geographical entities - the numbers
    tools/generate_metadata.ps1 reports for
    resources/PhoneNumberMetadataForTesting.xml. }
  Assert.AreEqual(Integer(36), GetTerritoryCount, 'territory count of the test data set');
  Assert.AreEqual(Integer(33), Integer(Length(LibPhoneNumber.Metadata.GetSupportedRegions)),
    'region count of the test data set');
  Assert.AreEqual(Integer(3),
    Integer(Length(GetSupportedGlobalNetworkCallingCodes)),
    'non geographical entity count of the test data set');
end;

procedure TUpstreamPhoneNumberUtilTests.TestingMetadata_CarriesItsOwnProvenance;
begin
  Assert.AreEqual('testing-metadata-v1', MetadataVersion,
    'the active generator version must be the testing one');
  Assert.AreEqual('resources/PhoneNumberMetadataForTesting.xml',
    MetadataSourceName, 'the active source file must be the testing XML');
  Assert.AreEqual(TestingMetadataUpstreamCommit, MetadataUpstreamCommit,
    'both data sets are generated from the same pinned vendor commit');
end;

{ ---------------------------------------------------------------------------
  Metadata, regions and calling codes
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Test_GetSupportedRegions;
begin
  Assert.IsTrue(Length(LibPhoneNumber.Metadata.GetSupportedRegions) > 0);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetSupportedGlobalNetworkCallingCodes;
var
  Codes: TMetadataIntegerArray;
  I: Integer;
begin
  Codes := GetSupportedGlobalNetworkCallingCodes;
  Assert.IsTrue(Length(Codes) > 0);
  for I := 0 to Length(Codes) - 1 do
  begin
    Assert.IsTrue(Codes[I] > 0);
    Assert.AreEqual(RC_UN001,
      LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(Codes[I]));
  end;
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetSupportedCallingCodes;
var
  Codes: TMetadataIntegerArray;
  I: Integer;
  Found979: Boolean;
begin
  Codes := GetSupportedCallingCodes;
  Assert.IsTrue(Length(Codes) > 0);
  Found979 := False;
  for I := 0 to Length(Codes) - 1 do
  begin
    Assert.IsTrue(Codes[I] > 0);
    Assert.AreNotEqual(RC_ZZ,
      LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(Codes[I]));
    if Codes[I] = 979 then
      Found979 := True;
  end;
  { There should be more than just the global network calling codes in this
    set. }
  Assert.IsTrue(Length(Codes) > Length(GetSupportedGlobalNetworkCallingCodes));
  Assert.IsTrue(Found979, 'the global network calling codes must be included');
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetInstanceLoadBadMetadata;
var
  Metadata: PPhoneMetadataRec;
begin
  Assert.IsFalse(TryGetMetadataForRegion('No Such Region', Metadata));
  Assert.IsFalse(TryGetMetadataForNonGeoEntity(-1, Metadata));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetInstanceLoadUSMetadata;
var
  Metadata: PPhoneMetadataRec;
  Lengths: TMetadataIntegerArray;
begin
  Metadata := MetadataOf(RC_US);
  Assert.AreEqual('US', Metadata^.Id);
  Assert.AreEqual(Integer(1), Metadata^.CountryCode);
  Assert.AreEqual('011', Metadata^.InternationalPrefix);
  Assert.AreNotEqual('', Metadata^.NationalPrefix, 'hasNationalPrefix');
  Assert.AreEqual(Integer(2), GetNumberFormatCount(Metadata));
  Assert.AreEqual('(\d{3})(\d{3})(\d{4})', GetNumberFormat(Metadata, 1)^.Pattern);
  Assert.AreEqual('$1 $2 $3', GetNumberFormat(Metadata, 1)^.Format);
  Assert.AreEqual('[13-689]\d{9}|2[0-35-9]\d{8}',
    GetDesc(Metadata, pdkGeneralDesc)^.NationalNumberPattern);
  Assert.AreEqual('[13-689]\d{9}|2[0-35-9]\d{8}',
    GetDesc(Metadata, pdkFixedLine)^.NationalNumberPattern);

  Lengths := GetPossibleLengths(GetDesc(Metadata, pdkGeneralDesc));
  Assert.AreEqual(Integer(1), Integer(Length(Lengths)));
  Assert.AreEqual(Integer(10), Lengths[0]);
  { Possible lengths are the same as the general description, so aren't stored
    separately in the toll free element as well. }
  Assert.AreEqual(Integer(0),
    Integer(Length(GetPossibleLengths(GetDesc(Metadata, pdkTollFree)))));
  Assert.AreEqual('900\d{7}',
    GetDesc(Metadata, pdkPremiumRate)^.NationalNumberPattern);
  { No shared-cost data is available, so its national number data should not be
    set. }
  Assert.AreEqual('',
    GetDesc(Metadata, pdkSharedCost)^.NationalNumberPattern);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetInstanceLoadDEMetadata;
var
  Metadata: PPhoneMetadataRec;
  Format: PNumberFormatRec;
begin
  Metadata := MetadataOf(RC_DE);
  Assert.AreEqual('DE', Metadata^.Id);
  Assert.AreEqual(Integer(49), Metadata^.CountryCode);
  Assert.AreEqual('00', Metadata^.InternationalPrefix);
  Assert.AreEqual('0', Metadata^.NationalPrefix);
  Assert.AreEqual(Integer(6), GetNumberFormatCount(Metadata));

  Format := GetNumberFormat(Metadata, 5);
  Assert.AreEqual(Integer(1), Integer(Length(GetLeadingDigitsPatterns(Format))));
  Assert.AreEqual('900', GetLeadingDigitsPattern(Format, 0));
  Assert.AreEqual('(\d{3})(\d{3,4})(\d{4})', Format^.Pattern);
  Assert.AreEqual('$1 $2 $3', Format^.Format);

  Assert.AreEqual(Integer(2),
    Integer(Length(GetPossibleLengthsLocalOnly(GetDesc(Metadata, pdkGeneralDesc)))));
  Assert.AreEqual(Integer(8),
    Integer(Length(GetPossibleLengths(GetDesc(Metadata, pdkGeneralDesc)))));
  { Nothing is present for fixed-line, since it is the same as the general
    desc. }
  Assert.AreEqual(Integer(0),
    Integer(Length(GetPossibleLengths(GetDesc(Metadata, pdkFixedLine)))));
  Assert.AreEqual(Integer(2),
    Integer(Length(GetPossibleLengths(GetDesc(Metadata, pdkMobile)))));
  Assert.AreEqual('(?:[24-6]\d{2}|3[03-9]\d|[789](?:0[2-9]|[1-9]\d))\d{1,8}',
    GetDesc(Metadata, pdkFixedLine)^.NationalNumberPattern);
  Assert.AreEqual('30123456', GetDesc(Metadata, pdkFixedLine)^.ExampleNumber);
  Assert.AreEqual(Integer(10),
    GetPossibleLengths(GetDesc(Metadata, pdkTollFree))[0]);
  Assert.AreEqual('900([135]\d{6}|9\d{7})',
    GetDesc(Metadata, pdkPremiumRate)^.NationalNumberPattern);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetInstanceLoadARMetadata;
var
  Metadata: PPhoneMetadataRec;
begin
  Metadata := MetadataOf(RC_AR);
  Assert.AreEqual('AR', Metadata^.Id);
  Assert.AreEqual(Integer(54), Metadata^.CountryCode);
  Assert.AreEqual('00', Metadata^.InternationalPrefix);
  Assert.AreEqual('0', Metadata^.NationalPrefix);
  Assert.AreEqual('0(?:(11|343|3715)15)?', Metadata^.NationalPrefixForParsing);
  Assert.AreEqual('9$1', Metadata^.NationalPrefixTransformRule);
  Assert.AreEqual('$2 15 $3-$4', GetNumberFormat(Metadata, 2)^.Format);
  Assert.AreEqual('(\d)(\d{4})(\d{2})(\d{4})',
    GetNumberFormat(Metadata, 3)^.Pattern);
  Assert.AreEqual('(\d)(\d{4})(\d{2})(\d{4})',
    GetIntlNumberFormat(Metadata, 3)^.Pattern);
  Assert.AreEqual('$1 $2 $3 $4', GetIntlNumberFormat(Metadata, 3)^.Format);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetInstanceLoadInternationalTollFreeMetadata;
var
  Metadata: PPhoneMetadataRec;
begin
  Metadata := NonGeoMetadataOf(800);
  Assert.AreEqual('001', Metadata^.Id);
  Assert.AreEqual(Integer(800), Metadata^.CountryCode);
  Assert.AreEqual('$1 $2', GetNumberFormat(Metadata, 0)^.Format);
  Assert.AreEqual('(\d{4})(\d{4})', GetNumberFormat(Metadata, 0)^.Pattern);
  Assert.AreEqual(Integer(0),
    Integer(Length(GetPossibleLengthsLocalOnly(GetDesc(Metadata, pdkGeneralDesc)))));
  Assert.AreEqual(Integer(1),
    Integer(Length(GetPossibleLengths(GetDesc(Metadata, pdkGeneralDesc)))));
  Assert.AreEqual('12345678', GetDesc(Metadata, pdkTollFree)^.ExampleNumber);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetRegionCodeForCountryCode;
begin
  Assert.AreEqual(RC_US,
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(1));
  Assert.AreEqual(RC_GB,
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(44));
  Assert.AreEqual(RC_DE,
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(49));
  Assert.AreEqual(RC_UN001,
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(800));
  Assert.AreEqual(RC_UN001,
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(979));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetRegionCodeForNumber;
begin
  Assert.AreEqual(RC_BS,
    LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(1, '2423651234'));
  Assert.AreEqual(RC_US,
    LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(1, '6502530000'));
  Assert.AreEqual(RC_GB,
    LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(44, '7912345678'));
  Assert.AreEqual(RC_UN001,
    LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(800, '12345678'));
  Assert.AreEqual(RC_UN001,
    LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(979, '123456789'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetRegionCodesForCountryCode;
var
  Nanpa: TMetadataStringArray;
begin
  Nanpa := LibPhoneNumber.Metadata.GetRegionCodesForCountryCode(1);
  Assert.IsTrue(ContainsRegion(Nanpa, RC_US));
  Assert.IsTrue(ContainsRegion(Nanpa, RC_BS));
  Assert.IsTrue(ContainsRegion(
    LibPhoneNumber.Metadata.GetRegionCodesForCountryCode(44), RC_GB));
  Assert.IsTrue(ContainsRegion(
    LibPhoneNumber.Metadata.GetRegionCodesForCountryCode(49), RC_DE));
  Assert.IsTrue(ContainsRegion(
    LibPhoneNumber.Metadata.GetRegionCodesForCountryCode(800), RC_UN001));
  Assert.AreEqual(Integer(0), Integer(Length(
    LibPhoneNumber.Metadata.GetRegionCodesForCountryCode(-1))));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetCountryCodeForRegion;
begin
  Assert.AreEqual(Integer(1),
    LibPhoneNumber.Metadata.GetCountryCodeForRegion(RC_US));
  Assert.AreEqual(Integer(64),
    LibPhoneNumber.Metadata.GetCountryCodeForRegion(RC_NZ));
  { Java passes null for "no region"; the port's equivalent is the empty
    string. }
  Assert.AreEqual(Integer(0), LibPhoneNumber.Metadata.GetCountryCodeForRegion(''));
  Assert.AreEqual(Integer(0),
    LibPhoneNumber.Metadata.GetCountryCodeForRegion(RC_ZZ));
  Assert.AreEqual(Integer(0),
    LibPhoneNumber.Metadata.GetCountryCodeForRegion(RC_UN001));
  { CS is already deprecated so the library doesn't support it. }
  Assert.AreEqual(Integer(0), LibPhoneNumber.Metadata.GetCountryCodeForRegion('CS'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetNationalDiallingPrefixForRegion;
begin
  Assert.AreEqual('1', GetNddPrefixForRegion(RC_US, False));
  { Test non-main country to see it gets the national dialling prefix for the
    main country with that country calling code. }
  Assert.AreEqual('1', GetNddPrefixForRegion(RC_BS, False));
  Assert.AreEqual('0', GetNddPrefixForRegion(RC_NZ, False));
  { Test case with non digit in the national prefix. }
  Assert.AreEqual('0~0', GetNddPrefixForRegion(RC_AO, False));
  Assert.AreEqual('00', GetNddPrefixForRegion(RC_AO, True));
  { Java answers null for the invalid cases; this port answers the empty
    string, which is what every upstream caller tests for. }
  Assert.AreEqual('', GetNddPrefixForRegion('', False));
  Assert.AreEqual('', GetNddPrefixForRegion(RC_ZZ, False));
  Assert.AreEqual('', GetNddPrefixForRegion(RC_UN001, False));
  Assert.AreEqual('', GetNddPrefixForRegion('CS', False));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNANPACountry;
begin
  Assert.IsTrue(IsNanpaCountry(RC_US));
  Assert.IsTrue(IsNanpaCountry(RC_BS));
  Assert.IsFalse(IsNanpaCountry(RC_DE));
  Assert.IsFalse(IsNanpaCountry(RC_ZZ));
  Assert.IsFalse(IsNanpaCountry(RC_UN001));
  Assert.IsFalse(IsNanpaCountry(''));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsMobileNumberPortableRegion;
begin
  Assert.IsTrue(MetadataOf(RC_US)^.MobileNumberPortableRegion);
  Assert.IsTrue(MetadataOf(RC_GB)^.MobileNumberPortableRegion);
  Assert.IsFalse(MetadataOf(RC_AE)^.MobileNumberPortableRegion);
  Assert.IsFalse(MetadataOf(RC_BS)^.MobileNumberPortableRegion);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetMetadataForRegionForNonGeoEntityAndUnknownRegion;
var
  Metadata: PPhoneMetadataRec;
begin
  { getMetadataForRegion("001") is null upstream: the non geographical entities
    are addressed by calling code, never by region code. }
  Assert.IsFalse(TryGetMetadataForRegion(RC_UN001, Metadata));
  Assert.IsFalse(TryGetMetadataForRegion(RC_ZZ, Metadata));
  { getMetadataForNonGeographicalRegion(1) is null upstream: 1 is geographical. }
  Assert.IsFalse(TryGetMetadataForNonGeoEntity(1, Metadata));
end;

{ ---------------------------------------------------------------------------
  Normalisation
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Test_ConvertAlphaCharactersInNumber;
begin
  Assert.AreEqual('1800-222-333',
    LibPhoneNumber.MetadataCore.ConvertAlphaCharactersInNumber(
      '1800-ABC-DEF'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_NormaliseRemovePunctuation;
begin
  { Java PhoneNumberUtil.normalize(StringBuilder) is
    NormalizeAlphaPhoneOrDigits here. }
  Assert.AreEqual('03456234',
    NormalizeAlphaPhoneOrDigits('034-56&+#2' + #$00AD + '34'),
    'Conversion did not correctly remove punctuation');
end;

procedure TUpstreamPhoneNumberUtilTests.Test_NormaliseReplaceAlphaCharacters;
begin
  Assert.AreEqual('034426486479',
    NormalizeAlphaPhoneOrDigits('034-I-am-HUNGRY'),
    'Conversion did not correctly replace alpha characters');
end;

procedure TUpstreamPhoneNumberUtilTests.Test_NormaliseOtherDigits;
begin
  Assert.AreEqual('255', NormalizeAlphaPhoneOrDigits(#$FF12 + '5' + #$0665),
    'Conversion did not correctly replace non-latin digits');
  { Eastern-Arabic digits. }
  Assert.AreEqual('520',
    NormalizeAlphaPhoneOrDigits(#$06F5 + '2' + #$06F0),
    'Conversion did not correctly replace non-latin digits');
end;

procedure TUpstreamPhoneNumberUtilTests.Test_NormaliseStripAlphaCharacters;
begin
  Assert.AreEqual('03456234', NormalizeDigitsOnly('034-56&+a#234'),
    'Conversion did not correctly remove alpha character');
end;

procedure TUpstreamPhoneNumberUtilTests.Test_NormaliseStripNonDiallableCharacters;
begin
  Assert.AreEqual('03*456+1#234',
    NormalizeDiallableCharsOnly('03*4-56&+1a#234'),
    'Conversion did not correctly remove non-diallable characters');
end;

{ ---------------------------------------------------------------------------
  Format
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Test_FormatUSNumber;
var
  UsNumber, UsTollFree, UsPremium, UsSpoof,
    UsSpoofWithRawInput: TPhoneNumber;
begin
  UsNumber := MakeNumber(1, '6502530000');
  UsTollFree := MakeNumber(1, '8002530000');
  UsPremium := MakeNumber(1, '9002530000');
  UsSpoof := MakeNumber(1, '0');

  Assert.AreEqual('650 253 0000',
    TPhoneNumberUtil.Format(UsNumber, pnfNational));
  Assert.AreEqual('+1 650 253 0000',
    TPhoneNumberUtil.Format(UsNumber, pnfInternational));

  Assert.AreEqual('800 253 0000',
    TPhoneNumberUtil.Format(UsTollFree, pnfNational));
  Assert.AreEqual('+1 800 253 0000',
    TPhoneNumberUtil.Format(UsTollFree, pnfInternational));

  Assert.AreEqual('900 253 0000',
    TPhoneNumberUtil.Format(UsPremium, pnfNational));
  Assert.AreEqual('+1 900 253 0000',
    TPhoneNumberUtil.Format(UsPremium, pnfInternational));
  Assert.AreEqual('tel:+1-900-253-0000',
    TPhoneNumberUtil.Format(UsPremium, pnfRfc3966));

  { Numbers with all zeros in the national number part are formatted by using
    the raw_input if that is available, no matter which format is specified. }
  UsSpoofWithRawInput := MakeNumber(1, '0');
  UsSpoofWithRawInput.RawInput := '000-000-0000';
  Assert.AreEqual('000-000-0000',
    TPhoneNumberUtil.Format(UsSpoofWithRawInput, pnfNational));
  Assert.AreEqual('0', TPhoneNumberUtil.Format(UsSpoof, pnfNational));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatAUShortCodeNumber;
var
  PgShortCodeNumber: TPhoneNumber;
begin
  Assert.AreEqual('+61000',
    TPhoneNumberUtil.Format(ParseOk('000', RC_AU), pnfE164));

  PgShortCodeNumber := MakeNumber(675, '0');
  PgShortCodeNumber.RawInput := '+675000';
  Assert.AreEqual('+675000',
    TPhoneNumberUtil.Format(PgShortCodeNumber, pnfE164));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatBSNumber;
var
  BsNumber: TPhoneNumber;
begin
  BsNumber := MakeNumber(1, '2423651234');
  Assert.AreEqual('242 365 1234',
    TPhoneNumberUtil.Format(BsNumber, pnfNational));
  Assert.AreEqual('+1 242 365 1234',
    TPhoneNumberUtil.Format(BsNumber, pnfInternational));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatGBNumber;
var
  GbNumber, GbMobile: TPhoneNumber;
begin
  GbNumber := MakeNumber(44, '2070313000');
  GbMobile := MakeNumber(44, '7912345678');

  Assert.AreEqual('(020) 7031 3000',
    TPhoneNumberUtil.Format(GbNumber, pnfNational));
  Assert.AreEqual('+44 20 7031 3000',
    TPhoneNumberUtil.Format(GbNumber, pnfInternational));

  Assert.AreEqual('(07912) 345 678',
    TPhoneNumberUtil.Format(GbMobile, pnfNational));
  Assert.AreEqual('+44 7912 345 678',
    TPhoneNumberUtil.Format(GbMobile, pnfInternational));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatDENumber;
var
  DeNumber: TPhoneNumber;
begin
  DeNumber := MakeNumber(49, '301234');
  Assert.AreEqual('030/1234', TPhoneNumberUtil.Format(DeNumber, pnfNational));
  Assert.AreEqual('+49 30/1234',
    TPhoneNumberUtil.Format(DeNumber, pnfInternational));
  Assert.AreEqual('tel:+49-30-1234',
    TPhoneNumberUtil.Format(DeNumber, pnfRfc3966));

  DeNumber := MakeNumber(49, '291123');
  Assert.AreEqual('0291 123', TPhoneNumberUtil.Format(DeNumber, pnfNational));
  Assert.AreEqual('+49 291 123',
    TPhoneNumberUtil.Format(DeNumber, pnfInternational));

  DeNumber := MakeNumber(49, '29112345678');
  Assert.AreEqual('0291 12345678',
    TPhoneNumberUtil.Format(DeNumber, pnfNational));
  Assert.AreEqual('+49 291 12345678',
    TPhoneNumberUtil.Format(DeNumber, pnfInternational));

  DeNumber := MakeNumber(49, '912312345');
  Assert.AreEqual('09123 12345',
    TPhoneNumberUtil.Format(DeNumber, pnfNational));
  Assert.AreEqual('+49 9123 12345',
    TPhoneNumberUtil.Format(DeNumber, pnfInternational));

  DeNumber := MakeNumber(49, '80212345');
  Assert.AreEqual('08021 2345',
    TPhoneNumberUtil.Format(DeNumber, pnfNational));
  Assert.AreEqual('+49 8021 2345',
    TPhoneNumberUtil.Format(DeNumber, pnfInternational));

  { Note this number is correctly formatted without national prefix. }
  DeNumber := MakeNumber(49, '1234');
  Assert.AreEqual('1234', TPhoneNumberUtil.Format(DeNumber, pnfNational));
  Assert.AreEqual('+49 1234',
    TPhoneNumberUtil.Format(DeNumber, pnfInternational));

  DeNumber := MakeNumber(49, '41341234');
  Assert.AreEqual('04134 1234', TPhoneNumberUtil.Format(DeNumber, pnfNational));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatITNumber;
var
  ItNumber, ItMobile: TPhoneNumber;
begin
  { IT_NUMBER carries the italian leading zero, i.e. the NSN "0236618300". }
  ItNumber := MakeNumber(39, '0236618300');
  ItMobile := MakeNumber(39, '345678901');

  Assert.AreEqual('02 3661 8300',
    TPhoneNumberUtil.Format(ItNumber, pnfNational));
  Assert.AreEqual('+39 02 3661 8300',
    TPhoneNumberUtil.Format(ItNumber, pnfInternational));
  Assert.AreEqual('+390236618300',
    TPhoneNumberUtil.Format(ItNumber, pnfE164));

  Assert.AreEqual('345 678 901',
    TPhoneNumberUtil.Format(ItMobile, pnfNational));
  Assert.AreEqual('+39 345 678 901',
    TPhoneNumberUtil.Format(ItMobile, pnfInternational));
  Assert.AreEqual('+39345678901',
    TPhoneNumberUtil.Format(ItMobile, pnfE164));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatAUNumber;
var
  AuNumber: TPhoneNumber;
begin
  AuNumber := MakeNumber(61, '236618300');
  Assert.AreEqual('02 3661 8300',
    TPhoneNumberUtil.Format(AuNumber, pnfNational));
  Assert.AreEqual('+61 2 3661 8300',
    TPhoneNumberUtil.Format(AuNumber, pnfInternational));
  Assert.AreEqual('+61236618300',
    TPhoneNumberUtil.Format(AuNumber, pnfE164));

  AuNumber := MakeNumber(61, '1800123456');
  Assert.AreEqual('1800 123 456',
    TPhoneNumberUtil.Format(AuNumber, pnfNational));
  Assert.AreEqual('+61 1800 123 456',
    TPhoneNumberUtil.Format(AuNumber, pnfInternational));
  Assert.AreEqual('+611800123456',
    TPhoneNumberUtil.Format(AuNumber, pnfE164));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatARNumber;
var
  ArNumber, ArMobile: TPhoneNumber;
begin
  ArNumber := MakeNumber(54, '1187654321');
  ArMobile := MakeNumber(54, '91187654321');

  Assert.AreEqual('011 8765-4321',
    TPhoneNumberUtil.Format(ArNumber, pnfNational));
  Assert.AreEqual('+54 11 8765-4321',
    TPhoneNumberUtil.Format(ArNumber, pnfInternational));
  Assert.AreEqual('+541187654321',
    TPhoneNumberUtil.Format(ArNumber, pnfE164));

  Assert.AreEqual('011 15 8765-4321',
    TPhoneNumberUtil.Format(ArMobile, pnfNational));
  Assert.AreEqual('+54 9 11 8765 4321',
    TPhoneNumberUtil.Format(ArMobile, pnfInternational));
  Assert.AreEqual('+5491187654321',
    TPhoneNumberUtil.Format(ArMobile, pnfE164));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatMXNumber;
var
  MxMobile1, MxMobile2, MxNumber1, MxNumber2: TPhoneNumber;
begin
  MxMobile1 := MakeNumber(52, '12345678900');
  MxMobile2 := MakeNumber(52, '15512345678');
  MxNumber1 := MakeNumber(52, '3312345678');
  MxNumber2 := MakeNumber(52, '8211234567');

  Assert.AreEqual('045 234 567 8900',
    TPhoneNumberUtil.Format(MxMobile1, pnfNational));
  Assert.AreEqual('+52 1 234 567 8900',
    TPhoneNumberUtil.Format(MxMobile1, pnfInternational));
  Assert.AreEqual('+5212345678900',
    TPhoneNumberUtil.Format(MxMobile1, pnfE164));

  Assert.AreEqual('045 55 1234 5678',
    TPhoneNumberUtil.Format(MxMobile2, pnfNational));
  Assert.AreEqual('+52 1 55 1234 5678',
    TPhoneNumberUtil.Format(MxMobile2, pnfInternational));
  Assert.AreEqual('+5215512345678',
    TPhoneNumberUtil.Format(MxMobile2, pnfE164));

  Assert.AreEqual('01 33 1234 5678',
    TPhoneNumberUtil.Format(MxNumber1, pnfNational));
  Assert.AreEqual('+52 33 1234 5678',
    TPhoneNumberUtil.Format(MxNumber1, pnfInternational));
  Assert.AreEqual('+523312345678',
    TPhoneNumberUtil.Format(MxNumber1, pnfE164));

  Assert.AreEqual('01 821 123 4567',
    TPhoneNumberUtil.Format(MxNumber2, pnfNational));
  Assert.AreEqual('+52 821 123 4567',
    TPhoneNumberUtil.Format(MxNumber2, pnfInternational));
  Assert.AreEqual('+528211234567',
    TPhoneNumberUtil.Format(MxNumber2, pnfE164));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatOutOfCountryCallingNumber;
var
  UsPremium, UsNumber, GbMobile, DeShort, ItNumber, SgNumber, ArMobile,
    IntlTollFree, ArWithExtn: TPhoneNumber;
begin
  UsPremium := MakeNumber(1, '9002530000');
  UsNumber := MakeNumber(1, '6502530000');
  GbMobile := MakeNumber(44, '7912345678');
  DeShort := MakeNumber(49, '1234');
  ItNumber := MakeNumber(39, '0236618300');
  SgNumber := MakeNumber(65, '65218000');
  ArMobile := MakeNumber(54, '91187654321');
  IntlTollFree := MakeNumber(800, '12345678');
  ArWithExtn := MakeNumber(54, '91187654321', '1234');

  Assert.AreEqual('00 1 900 253 0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(UsPremium, RC_DE));
  Assert.AreEqual('1 650 253 0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(UsNumber, RC_BS));
  Assert.AreEqual('00 1 650 253 0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(UsNumber, RC_PL));
  Assert.AreEqual('011 44 7912 345 678',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(GbMobile, RC_US));
  Assert.AreEqual('00 49 1234',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(DeShort, RC_GB));
  Assert.AreEqual('1234',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(DeShort, RC_DE));
  Assert.AreEqual('011 39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ItNumber, RC_US));
  Assert.AreEqual('02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ItNumber, RC_IT));
  Assert.AreEqual('+39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ItNumber, RC_SG));
  Assert.AreEqual('6521 8000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(SgNumber, RC_SG));
  Assert.AreEqual('011 54 9 11 8765 4321',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ArMobile, RC_US));
  Assert.AreEqual('011 800 1234 5678',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(IntlTollFree, RC_US));

  Assert.AreEqual('011 54 9 11 8765 4321 ext. 1234',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ArWithExtn, RC_US));
  Assert.AreEqual('0011 54 9 11 8765 4321 ext. 1234',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ArWithExtn, RC_AU));
  Assert.AreEqual('011 15 8765-4321 ext. 1234',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ArWithExtn, RC_AR));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatOutOfCountryWithInvalidRegion;
var
  UsNumber: TPhoneNumber;
begin
  UsNumber := MakeNumber(1, '6502530000');
  { AQ/Antarctica isn't a valid region code for phone number formatting, so
    this falls back to intl formatting. }
  Assert.AreEqual('+1 650 253 0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(UsNumber, 'AQ'));
  { For region code 001, the out-of-country format always turns into the
    international format. }
  Assert.AreEqual('+1 650 253 0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(UsNumber, RC_UN001));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatOutOfCountryWithPreferredIntlPrefix;
var
  ItNumber: TPhoneNumber;
begin
  ItNumber := MakeNumber(39, '0236618300');
  Assert.AreEqual('0011 39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ItNumber, RC_AU));
  { Preferred international prefixes with ~ are supported (designates
    waiting). }
  Assert.AreEqual('8~10 39 02 3661 8300',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ItNumber, RC_UZ));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatOutOfCountryKeepingAlphaChars;
var
  Number: TPhoneNumber;
begin
  Number := MakeNumber(1, '8007493524');
  Number.RawInput := '1800 six-flag';
  Assert.AreEqual('0011 1 800 SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_AU));

  Number.RawInput := '1-800-SIX-flag';
  Assert.AreEqual('0011 1 800-SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_AU));

  Number.RawInput := 'Call us from UK: 00 1 800 SIX-flag';
  Assert.AreEqual('0011 1 800 SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_AU));

  Number.RawInput := '800 SIX-flag';
  Assert.AreEqual('0011 1 800 SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_AU));

  { Formatting from within the NANPA region. }
  Assert.AreEqual('1 800 SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_US));
  Assert.AreEqual('1 800 SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_BS));

  { A number with extension. }
  Assert.AreEqual('0011 1 800 SIX-FLAG extn. 1234',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(
      ParseRawOk('800 SIX-flag ext. 1234', RC_US), RC_AU));

  { If the raw input doesn't exist, it is formatted using
    formatOutOfCountryCallingNumber. }
  Number.RawInput := '';
  Assert.AreEqual('00 1 800 749 3524',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_DE));

  { An AU alpha number formatted from Australia; the national prefix is
    fixed. }
  Number := MakeNumber(61, '827493524');
  Number.RawInput := '+61 82749-FLAG';
  Assert.AreEqual('082749-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_AU));

  Number.RawInput := '082749-FLAG';
  Assert.AreEqual('082749-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_AU));

  Number := MakeNumber(61, '18007493524');
  Number.RawInput := '1-800-SIX-flag';
  { This number should not have the national prefix prefixed, in accordance
    with the override for this specific formatting rule. }
  Assert.AreEqual('1-800-SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_AU));

  { The metadata must not be permanently changed by the call above. }
  Number := MakeNumber(61, '1800749352');
  Assert.AreEqual('1800 749 352',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, RC_AU));

  { A region with multiple international prefixes. }
  Number := MakeNumber(61, '18007493524');
  Number.RawInput := '1-800-SIX-flag';
  Assert.AreEqual('+61 1-800-SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_SG));
  { Calling from a non-supported region. }
  Assert.AreEqual('+61 1-800-SIX-FLAG',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, 'AQ'));

  { An invalid country calling code: uses the raw input only. }
  Number := MakeNumber(0, '18007493524');
  Number.RawInput := '1-800-SIX-flag';
  Assert.AreEqual('1-800-SIX-flag',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_DE));

  { An invalid alpha number: no country-code stripping can be done. }
  Number := MakeNumber(1, '80749');
  Number.RawInput := '180-SIX';
  Assert.AreEqual('00 1 180-SIX',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, RC_DE));
  Assert.AreEqual('+1 180-SIX',
    TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, 'AQ'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatWithCarrierCode;
var
  ArMobile, UsNumber, UnknownCc: TPhoneNumber;
begin
  { Only supported for AR in the test metadata, and only for mobile numbers
    starting with certain values. }
  ArMobile := MakeNumber(54, '92234654321');
  Assert.AreEqual('02234 65-4321',
    TPhoneNumberUtil.Format(ArMobile, pnfNational));
  Assert.AreEqual('02234 14 65-4321',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(ArMobile, '14'));
  Assert.AreEqual('02234 65-4321',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(ArMobile, ''));
  { Here the international rule is used, so no carrier code should be
    present. }
  Assert.AreEqual('+5492234654321',
    TPhoneNumberUtil.Format(ArMobile, pnfE164));

  UsNumber := MakeNumber(1, '6502530000');
  Assert.AreEqual('650 253 0000',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(UsNumber, '15'));

  { Invalid country code should just get the NSN. }
  UnknownCc := MakeNumber(2, '12345');
  Assert.AreEqual('12345',
    TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(UnknownCc, '89'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatWithPreferredCarrierCode;
var
  ArNumber, UsNumber: TPhoneNumber;
begin
  ArNumber := MakeNumber(54, '91234125678');
  { No preferred carrier code stored in the number itself. }
  Assert.AreEqual('01234 15 12-5678',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
      ArNumber, '15'));
  Assert.AreEqual('01234 12-5678',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
      ArNumber, ''));

  ArNumber.PreferredDomesticCarrierCode := '19';
  Assert.AreEqual('01234 12-5678',
    TPhoneNumberUtil.Format(ArNumber, pnfNational));
  Assert.AreEqual('01234 19 12-5678',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
      ArNumber, '15'));
  Assert.AreEqual('01234 19 12-5678',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
      ArNumber, ''));

  { When the preferred carrier code is present (even when it is just a space),
    use it instead of the default carrier code passed in. }
  ArNumber.PreferredDomesticCarrierCode := ' ';
  Assert.AreEqual('01234   12-5678',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
      ArNumber, '15'));

  { When it is present but empty, treat it as unset. }
  ArNumber.PreferredDomesticCarrierCode := '';
  Assert.AreEqual('01234 15 12-5678',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
      ArNumber, '15'));

  { Not supported for the US, so there should be no change. }
  UsNumber := MakeNumber(1, '4241231234');
  UsNumber.PreferredDomesticCarrierCode := '99';
  Assert.AreEqual('424 123 1234',
    TPhoneNumberUtil.Format(UsNumber, pnfNational));
  Assert.AreEqual('424 123 1234',
    TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
      UsNumber, '15'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatNumberForMobileDialing;
var
  CoFixedLine, DeNumber, DeWithExtn, UsTollFree, UsNumber, UsWithExtn,
    UsLongNumber, JpStar, IntlTollFree, AeUan, MxNumber1, UzFixedLine,
    UzMobile, DeShort, UsShort, AuNumber: TPhoneNumber;
begin
  CoFixedLine := MakeNumber(57, '6012345678');
  DeNumber := MakeNumber(49, '30123456');
  DeWithExtn := MakeNumber(49, '30123456', '1234');
  UsTollFree := MakeNumber(1, '8002530000');
  UsNumber := MakeNumber(1, '6502530000');
  UsWithExtn := MakeNumber(1, '6502530000', '1234');
  UsLongNumber := MakeNumber(1, '65025300001');
  JpStar := MakeNumber(81, '2345');
  IntlTollFree := MakeNumber(800, '12345678');
  AeUan := MakeNumber(971, '600123456');
  MxNumber1 := MakeNumber(52, '3312345678');
  UzFixedLine := MakeNumber(998, '612201234');
  UzMobile := MakeNumber(998, '950123456');

  Assert.AreEqual('6012345678',
    TPhoneNumberUtil.FormatNumberForMobileDialing(CoFixedLine, RC_CO, False));
  Assert.AreEqual('030123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(DeNumber, RC_DE, False));
  Assert.AreEqual('+4930123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(DeNumber, 'CH', False));
  Assert.AreEqual('030123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(DeWithExtn, RC_DE, False));
  Assert.AreEqual('+4930123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(DeWithExtn, 'CH', False));

  { US toll free numbers are marked as noInternationalDialling in the test
    metadata. }
  Assert.AreEqual('800 253 0000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsTollFree, RC_US, True));
  Assert.AreEqual('',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsTollFree, RC_CN, True));
  Assert.AreEqual('+1 650 253 0000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsNumber, RC_US, True));
  Assert.AreEqual('+1 650 253 0000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsWithExtn, RC_US, True));

  Assert.AreEqual('8002530000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsTollFree, RC_US, False));
  Assert.AreEqual('',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsTollFree, RC_CN, False));
  Assert.AreEqual('+16502530000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsNumber, RC_US, False));
  Assert.AreEqual('+16502530000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsWithExtn, RC_US, False));

  { An invalid US number, which is one digit too long. }
  Assert.AreEqual('+165025300001',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsLongNumber, RC_US, False));
  Assert.AreEqual('+1 65025300001',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsLongNumber, RC_US, True));

  { Star numbers. In real life they appear in Israel, but the test metadata has
    them in JP. }
  Assert.AreEqual('*2345',
    TPhoneNumberUtil.FormatNumberForMobileDialing(JpStar, RC_JP, False));
  Assert.AreEqual('*2345',
    TPhoneNumberUtil.FormatNumberForMobileDialing(JpStar, RC_JP, True));

  Assert.AreEqual('+80012345678',
    TPhoneNumberUtil.FormatNumberForMobileDialing(IntlTollFree, RC_JP, False));
  Assert.AreEqual('+800 1234 5678',
    TPhoneNumberUtil.FormatNumberForMobileDialing(IntlTollFree, RC_JP, True));

  { UAE numbers beginning with 600 (classified as UAN) need to be dialled
    without +971 locally. }
  Assert.AreEqual('+971600123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(AeUan, RC_JP, False));
  Assert.AreEqual('600123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(AeUan, RC_AE, False));

  Assert.AreEqual('+523312345678',
    TPhoneNumberUtil.FormatNumberForMobileDialing(MxNumber1, RC_MX, False));
  Assert.AreEqual('+523312345678',
    TPhoneNumberUtil.FormatNumberForMobileDialing(MxNumber1, RC_US, False));

  { Uzbek phone numbers are returned in international format even when dialled
    from the same region. }
  Assert.AreEqual('+998612201234',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UzFixedLine, RC_UZ, False));
  Assert.AreEqual('+998950123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UzMobile, RC_UZ, False));
  Assert.AreEqual('+998950123456',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UzMobile, RC_US, False));

  { Non-geographical numbers are always dialled in international format. }
  Assert.AreEqual('+80012345678',
    TPhoneNumberUtil.FormatNumberForMobileDialing(IntlTollFree, RC_US, False));
  Assert.AreEqual('+80012345678',
    TPhoneNumberUtil.FormatNumberForMobileDialing(IntlTollFree, RC_UN001,
      False));

  { A short number is formatted correctly for mobile dialing within the region,
    and is not diallable from outside the region. }
  DeShort := MakeNumber(49, '123');
  Assert.AreEqual('123',
    TPhoneNumberUtil.FormatNumberForMobileDialing(DeShort, RC_DE, False));
  Assert.AreEqual('',
    TPhoneNumberUtil.FormatNumberForMobileDialing(DeShort, RC_IT, False));

  { The special logic for NANPA countries. }
  Assert.AreEqual('+16502530000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsNumber, RC_US, False));
  Assert.AreEqual('+16502530000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsNumber, RC_CA, False));
  Assert.AreEqual('+16502530000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsNumber, RC_BR, False));
  UsShort := MakeNumber(1, '911');
  Assert.AreEqual('911',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsShort, RC_US, False));
  Assert.AreEqual('',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsShort, RC_CA, False));
  Assert.AreEqual('',
    TPhoneNumberUtil.FormatNumberForMobileDialing(UsShort, RC_BR, False));

  { The Australian emergency number 000. }
  AuNumber := MakeNumber(61, '000');
  Assert.AreEqual('000',
    TPhoneNumberUtil.FormatNumberForMobileDialing(AuNumber, RC_AU, False));
  Assert.AreEqual('',
    TPhoneNumberUtil.FormatNumberForMobileDialing(AuNumber, RC_NZ, False));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatByPattern;
var
  Formats: TUserNumberFormatArray;
  UsNumber, UsNumber2, BsNumber, ItNumber, GbNumber: TPhoneNumber;
begin
  UsNumber := MakeNumber(1, '6502530000');
  UsNumber2 := MakeNumber(1, '6507129823');
  BsNumber := MakeNumber(1, '2423651234');
  ItNumber := MakeNumber(39, '0236618300');
  GbNumber := MakeNumber(44, '2070313000');

  SetLength(Formats, 1);
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '($1) $2-$3',
    [], '', '');

  Assert.AreEqual('(650) 253-0000',
    TPhoneNumberUtil.FormatByPattern(UsNumber, pnfNational, Formats));
  Assert.AreEqual('+1 (650) 253-0000',
    TPhoneNumberUtil.FormatByPattern(UsNumber, pnfInternational, Formats));
  Assert.AreEqual('tel:+1-650-712-9823',
    TPhoneNumberUtil.FormatByPattern(UsNumber2, pnfRfc3966, Formats));

  { $NP is set to '1' for the US. Here we check that for other NANPA countries
    the US rules are followed. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1 $2-$3',
    [], '$NP ($FG)', '');
  Assert.AreEqual('1 (242) 365-1234',
    TPhoneNumberUtil.FormatByPattern(BsNumber, pnfNational, Formats));
  Assert.AreEqual('+1 242 365-1234',
    TPhoneNumberUtil.FormatByPattern(BsNumber, pnfInternational, Formats));

  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{5})(\d{3})', '$1-$2 $3',
    [], '$NP ($FG)', '');
  Assert.AreEqual('02-36618 300',
    TPhoneNumberUtil.FormatByPattern(ItNumber, pnfNational, Formats));
  Assert.AreEqual('+39 02-36618 300',
    TPhoneNumberUtil.FormatByPattern(ItNumber, pnfInternational, Formats));

  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{4})(\d{4})', '$1 $2 $3',
    [], '$NP$FG', '');
  Assert.AreEqual('020 7031 3000',
    TPhoneNumberUtil.FormatByPattern(GbNumber, pnfNational, Formats));

  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{4})(\d{4})', '$1 $2 $3',
    [], '($NP$FG)', '');
  Assert.AreEqual('(020) 7031 3000',
    TPhoneNumberUtil.FormatByPattern(GbNumber, pnfNational, Formats));

  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{4})(\d{4})', '$1 $2 $3',
    [], '', '');
  Assert.AreEqual('20 7031 3000',
    TPhoneNumberUtil.FormatByPattern(GbNumber, pnfNational, Formats));
  Assert.AreEqual('+44 20 7031 3000',
    TPhoneNumberUtil.FormatByPattern(GbNumber, pnfInternational, Formats));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatE164Number;
begin
  Assert.AreEqual('+16502530000',
    TPhoneNumberUtil.Format(MakeNumber(1, '6502530000'), pnfE164));
  Assert.AreEqual('+4930123456',
    TPhoneNumberUtil.Format(MakeNumber(49, '30123456'), pnfE164));
  Assert.AreEqual('+80012345678',
    TPhoneNumberUtil.Format(MakeNumber(800, '12345678'), pnfE164));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatNumberWithExtension;
var
  NzNumber, UsNumber: TPhoneNumber;
begin
  NzNumber := MakeNumber(64, '33316005', '1234');
  { Uses the default extension prefix. }
  Assert.AreEqual('03-331 6005 ext. 1234',
    TPhoneNumberUtil.Format(NzNumber, pnfNational));
  { Uses RFC 3966 syntax. }
  Assert.AreEqual('tel:+64-3-331-6005;ext=1234',
    TPhoneNumberUtil.Format(NzNumber, pnfRfc3966));
  { Extension prefix overridden in the territory information for the US. }
  UsNumber := MakeNumber(1, '6502530000', '4567');
  Assert.AreEqual('650 253 0000 extn. 4567',
    TPhoneNumberUtil.Format(UsNumber, pnfNational));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FormatInOriginalFormat;
var
  Number5: TPhoneNumber;
begin
  Assert.AreEqual('+44 20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('+442087654321', RC_GB), RC_GB));
  Assert.AreEqual('(020) 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('02087654321', RC_GB), RC_GB));
  Assert.AreEqual('011 44 20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('011442087654321', RC_US), RC_US));
  Assert.AreEqual('44 20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('442087654321', RC_GB), RC_GB));

  Number5 := ParseOk('+442087654321', RC_GB);
  Assert.AreEqual('(020) 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(Number5, RC_GB));

  { Invalid numbers that we have a formatting pattern for should be formatted
    properly. Area codes starting with 7 are intentionally excluded in the test
    metadata. }
  Assert.AreEqual('734 567 8901',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('7345678901', RC_US), RC_US));

  { US is not a leading zero country, and the presence of the leading zero
    leads us to format the number using raw_input. }
  Assert.AreEqual('0734567 8901',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('0734567 8901', RC_US), RC_US));

  { Valid, but no formatting pattern for it: fall back to the raw input. }
  Assert.AreEqual('02-4567-8900',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('02-4567-8900', RC_KR), RC_KR));

  Assert.AreEqual('011 800 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('01180012345678', RC_US), RC_US));
  Assert.AreEqual('+800 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('+80012345678', RC_KR), RC_KR));

  { US local numbers are formatted correctly, as we have formatting patterns
    for them. }
  Assert.AreEqual('253 0000',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('2530000', RC_US), RC_US));
  Assert.AreEqual('1 800 345 6789',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('18003456789', RC_US), RC_US));
  Assert.AreEqual('20 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('2087654321', RC_GB), RC_GB));
  { Make sure no metadata is modified as a result of the previous call. }
  Assert.AreEqual('(020) 8765 4321',
    TPhoneNumberUtil.FormatInOriginalFormat(Number5, RC_GB));

  Assert.AreEqual('01 33 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('013312345678', RC_MX), RC_MX));
  Assert.AreEqual('33 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('3312345678', RC_MX), RC_MX));
  Assert.AreEqual('02 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('0212345678', RC_IT), RC_IT));
  Assert.AreEqual('0077-7012',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('00777012', RC_JP), RC_JP));
  Assert.AreEqual('0777012',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('0777012', RC_JP), RC_JP));
  Assert.AreEqual('012 3121286979',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('012 3121286979', RC_BR), RC_BR));

  { The default national prefix used in this case is 045. When a number with
    national prefix 044 is entered, we return the raw input. }
  Assert.AreEqual('044(33)1234-5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('044(33)1234-5678', RC_MX), RC_MX));
  Assert.AreEqual('045 33 1234 5678',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('045(33)1234-5678', RC_MX), RC_MX));

  { The default international prefix used in this case is 0011. When a number
    with international prefix 0012 is entered, we return the raw input. }
  Assert.AreEqual('0012 16502530000',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('0012 16502530000', RC_AU), RC_AU));
  Assert.AreEqual('0011 1 650 253 0000',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('0011 16502530000', RC_AU), RC_AU));

  { The star sign is neither removed from nor added to the original input. }
  Assert.AreEqual('*1234',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('*1234', RC_JP), RC_JP));
  Assert.AreEqual('1234',
    TPhoneNumberUtil.FormatInOriginalFormat(
      ParseRawOk('1234', RC_JP), RC_JP));

  { An invalid national number without raw input is just formatted as the
    national number. }
  Assert.AreEqual('650253000',
    TPhoneNumberUtil.FormatInOriginalFormat(
      MakeNumber(1, '650253000'), RC_US));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_CountryWithNoNumberDesc;
var
  AdNumber, UsNumber: TPhoneNumber;
begin
  { Andorra is a country where we don't have PhoneNumberDesc info in the
    metadata. }
  AdNumber := MakeNumber(376, '12345');
  Assert.AreEqual('+376 12345',
    TPhoneNumberUtil.Format(AdNumber, pnfInternational));
  Assert.AreEqual('+37612345', TPhoneNumberUtil.Format(AdNumber, pnfE164));
  Assert.AreEqual('12345', TPhoneNumberUtil.Format(AdNumber, pnfNational));
  Assert.AreEqual(NumberTypeToString(mntUnknown),
    NumberTypeToString(TypeOf(376, '12345')));
  Assert.IsFalse(
    LibPhoneNumber.MetadataCore.IsValidNumber(376, '12345'));

  { Dialing a US number from within Andorra. }
  UsNumber := MakeNumber(1, '6502530000');
  Assert.AreEqual('00 1 650 253 0000',
    TPhoneNumberUtil.FormatOutOfCountryCallingNumber(UsNumber, RC_AD));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_UnknownCountryCallingCode;
begin
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(2, '12345'));
  Assert.AreEqual('+212345',
    TPhoneNumberUtil.Format(MakeNumber(2, '12345'), pnfE164));
end;

{ ---------------------------------------------------------------------------
  Typing, validity, possibility
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Test_IsPremiumRate;
begin
  Assert.AreEqual(NumberTypeToString(mntPremiumRate),
    NumberTypeToString(TypeOf(1, '9002530000')));
  Assert.AreEqual(NumberTypeToString(mntPremiumRate),
    NumberTypeToString(TypeOf(39, '892123')));
  Assert.AreEqual(NumberTypeToString(mntPremiumRate),
    NumberTypeToString(TypeOf(44, '9187654321')));
  Assert.AreEqual(NumberTypeToString(mntPremiumRate),
    NumberTypeToString(TypeOf(49, '9001654321')));
  Assert.AreEqual(NumberTypeToString(mntPremiumRate),
    NumberTypeToString(TypeOf(49, '90091234567')));
  Assert.AreEqual(NumberTypeToString(mntPremiumRate),
    NumberTypeToString(TypeOf(979, '123456789')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsTollFree;
begin
  Assert.AreEqual(NumberTypeToString(mntTollFree),
    NumberTypeToString(TypeOf(1, '8881234567')));
  Assert.AreEqual(NumberTypeToString(mntTollFree),
    NumberTypeToString(TypeOf(39, '803123')));
  Assert.AreEqual(NumberTypeToString(mntTollFree),
    NumberTypeToString(TypeOf(44, '8012345678')));
  Assert.AreEqual(NumberTypeToString(mntTollFree),
    NumberTypeToString(TypeOf(49, '8001234567')));
  Assert.AreEqual(NumberTypeToString(mntTollFree),
    NumberTypeToString(TypeOf(800, '12345678')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsMobile;
begin
  Assert.AreEqual(NumberTypeToString(mntMobile),
    NumberTypeToString(TypeOf(1, '2423570000')));
  Assert.AreEqual(NumberTypeToString(mntMobile),
    NumberTypeToString(TypeOf(44, '7912345678')));
  Assert.AreEqual(NumberTypeToString(mntMobile),
    NumberTypeToString(TypeOf(39, '345678901')));
  Assert.AreEqual(NumberTypeToString(mntMobile),
    NumberTypeToString(TypeOf(54, '91187654321')));
  Assert.AreEqual(NumberTypeToString(mntMobile),
    NumberTypeToString(TypeOf(49, '15123456789')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsFixedLine;
begin
  Assert.AreEqual(NumberTypeToString(mntFixedLine),
    NumberTypeToString(TypeOf(1, '2423651234')));
  Assert.AreEqual(NumberTypeToString(mntFixedLine),
    NumberTypeToString(TypeOf(39, '0236618300')));
  Assert.AreEqual(NumberTypeToString(mntFixedLine),
    NumberTypeToString(TypeOf(44, '2070313000')));
  Assert.AreEqual(NumberTypeToString(mntFixedLine),
    NumberTypeToString(TypeOf(49, '30123456')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsFixedLineAndMobile;
begin
  Assert.AreEqual(NumberTypeToString(mntFixedLineOrMobile),
    NumberTypeToString(TypeOf(1, '6502530000')));
  Assert.AreEqual(NumberTypeToString(mntFixedLineOrMobile),
    NumberTypeToString(TypeOf(54, '1987654321')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsSharedCost;
begin
  Assert.AreEqual(NumberTypeToString(mntSharedCost),
    NumberTypeToString(TypeOf(44, '8431231234')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsVoip;
begin
  Assert.AreEqual(NumberTypeToString(mntVoip),
    NumberTypeToString(TypeOf(44, '5631231234')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPersonalNumber;
begin
  Assert.AreEqual(NumberTypeToString(mntPersonalNumber),
    NumberTypeToString(TypeOf(44, '7031231234')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsUnknown;
begin
  { Invalid numbers should be of type UNKNOWN. }
  Assert.AreEqual(NumberTypeToString(mntUnknown),
    NumberTypeToString(TypeOf(1, '2530000')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsValidNumber;
begin
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(1, '6502530000'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(39, '0236618300'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(44, '7912345678'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(800, '12345678'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(979, '123456789'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(64, '21387835'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsValidForRegion;
begin
  { This number is valid for the Bahamas, but is not a valid US number. }
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(1, '2423651234'));
  Assert.IsTrue(IsValidNumberForRegion(1, '2423651234', RC_BS));
  Assert.IsFalse(IsValidNumberForRegion(1, '2423651234', RC_US));
  { This number is no longer valid. }
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(1, '2421232345'));

  { La Mayotte and Reunion use 'leadingDigits' to differentiate them. }
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(262, '262123456'));
  Assert.IsTrue(IsValidNumberForRegion(262, '262123456', RC_RE));
  Assert.IsFalse(IsValidNumberForRegion(262, '262123456', RC_YT));
  { Now a number for La Mayotte. }
  Assert.IsTrue(IsValidNumberForRegion(262, '269601234', RC_YT));
  Assert.IsFalse(IsValidNumberForRegion(262, '269601234', RC_RE));
  { This number is no longer valid for La Reunion. }
  Assert.IsFalse(IsValidNumberForRegion(262, '269123456', RC_YT));
  Assert.IsFalse(IsValidNumberForRegion(262, '269123456', RC_RE));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(262, '269123456'));
  { However, it should be recognised as from La Mayotte. }
  Assert.AreEqual(RC_YT,
    LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(262, '269123456'));
  { This number is valid in both places. }
  Assert.IsTrue(IsValidNumberForRegion(262, '800123456', RC_YT));
  Assert.IsTrue(IsValidNumberForRegion(262, '800123456', RC_RE));

  Assert.IsTrue(IsValidNumberForRegion(800, '12345678', RC_UN001));
  Assert.IsFalse(IsValidNumberForRegion(800, '12345678', RC_US));
  Assert.IsFalse(IsValidNumberForRegion(800, '12345678', RC_ZZ));

  { Invalid country calling codes. }
  Assert.IsFalse(IsValidNumberForRegion(3923, '2366', RC_ZZ));
  Assert.IsFalse(IsValidNumberForRegion(3923, '2366', RC_UN001));
  Assert.IsFalse(IsValidNumberForRegion(0, '2366', RC_UN001));
  Assert.IsFalse(IsValidNumberForRegion(0, '2366', RC_ZZ));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNotValidNumber;
begin
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(1, '2530000'));
  Assert.IsFalse(
    LibPhoneNumber.MetadataCore.IsValidNumber(39, '023661830000'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(44, '791234567'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(49, '1234'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(64, '3316005'));
  { Invalid country calling codes. }
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(3923, '2366'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(0, '2366'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(800, '123456789'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumber;
begin
  Assert.IsTrue(
    LibPhoneNumber.MetadataCore.IsPossibleNumber(1, '6502530000'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsPossibleNumber(1, '2530000'));
  Assert.IsTrue(
    LibPhoneNumber.MetadataCore.IsPossibleNumber(44, '2070313000'));
  Assert.IsTrue(
    LibPhoneNumber.MetadataCore.IsPossibleNumber(800, '12345678'));

  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+1 650 253 0000', RC_US));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+1 650 GOO OGLE', RC_US));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('(650) 253-0000', RC_US));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('253-0000', RC_US));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+1 650 253 0000', RC_GB));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+44 20 7031 3000', RC_GB));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('(020) 7031 300', RC_GB));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('7031 3000', RC_GB));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('3331 6005', RC_NZ));
  Assert.IsTrue(TPhoneNumberUtil.IsPossibleNumber('+800 1234 5678', RC_UN001));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForType_DifferentTypeLengths;
begin
  { Argentinian numbers have different possible lengths for different types. }
  Assert.IsFalse(IsPossibleNumberForType(54, '12345', mntFixedLine));
  Assert.IsFalse(IsPossibleNumberForType(54, '12345', mntUnknown));

  Assert.IsTrue(IsPossibleNumberForType(54, '123456', mntUnknown));
  Assert.IsTrue(IsPossibleNumberForType(54, '123456', mntFixedLine));
  Assert.IsFalse(IsPossibleNumberForType(54, '123456', mntMobile));
  Assert.IsFalse(IsPossibleNumberForType(54, '123456', mntTollFree));

  Assert.IsTrue(IsPossibleNumberForType(54, '123456789', mntUnknown));
  Assert.IsTrue(IsPossibleNumberForType(54, '123456789', mntFixedLine));
  Assert.IsFalse(IsPossibleNumberForType(54, '123456789', mntMobile));
  Assert.IsFalse(IsPossibleNumberForType(54, '123456789', mntTollFree));

  Assert.IsTrue(IsPossibleNumberForType(54, '1234567890', mntUnknown));
  Assert.IsTrue(IsPossibleNumberForType(54, '1234567890', mntFixedLine));
  Assert.IsTrue(IsPossibleNumberForType(54, '1234567890', mntMobile));
  Assert.IsTrue(IsPossibleNumberForType(54, '1234567890', mntTollFree));

  Assert.IsTrue(IsPossibleNumberForType(54, '12345678901', mntUnknown));
  Assert.IsFalse(IsPossibleNumberForType(54, '12345678901', mntFixedLine));
  Assert.IsTrue(IsPossibleNumberForType(54, '12345678901', mntMobile));
  Assert.IsFalse(IsPossibleNumberForType(54, '12345678901', mntTollFree));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForType_LocalOnly;
begin
  Assert.IsTrue(IsPossibleNumberForType(49, '12', mntUnknown));
  Assert.IsTrue(IsPossibleNumberForType(49, '12', mntFixedLine));
  Assert.IsFalse(IsPossibleNumberForType(49, '12', mntMobile));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForType_DataMissingForSizeReasons;
begin
  Assert.IsTrue(IsPossibleNumberForType(55, '12345678', mntUnknown));
  Assert.IsTrue(IsPossibleNumberForType(55, '12345678', mntFixedLine));
  Assert.IsTrue(IsPossibleNumberForType(55, '1234567890', mntUnknown));
  Assert.IsTrue(IsPossibleNumberForType(55, '1234567890', mntFixedLine));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForType_NumberTypeNotSupportedForRegion;
begin
  { There are *no* mobile numbers for this region at all. }
  Assert.IsFalse(IsPossibleNumberForType(55, '12345678', mntMobile));
  Assert.IsTrue(IsPossibleNumberForType(55, '12345678', mntFixedLine));
  Assert.IsTrue(IsPossibleNumberForType(55, '12345678', mntFixedLineOrMobile));

  { There are *no* fixed-line OR mobile numbers for this calling code. }
  Assert.IsFalse(IsPossibleNumberForType(979, '123456789', mntMobile));
  Assert.IsFalse(IsPossibleNumberForType(979, '123456789', mntFixedLine));
  Assert.IsFalse(IsPossibleNumberForType(979, '123456789',
    mntFixedLineOrMobile));
  Assert.IsTrue(IsPossibleNumberForType(979, '123456789', mntPremiumRate));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberWithReason;
begin
  Assert.AreEqual(ValidationResultToString(mvrIsPossible),
    ValidationResultToString(
      LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(1,
        '6502530000')));
  Assert.AreEqual(ValidationResultToString(mvrIsPossibleLocalOnly),
    ValidationResultToString(
      LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(1,
        '2530000')));
  Assert.AreEqual(ValidationResultToString(mvrTooLong),
    ValidationResultToString(
      LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(1,
        '65025300001')));
  Assert.AreEqual(ValidationResultToString(mvrInvalidCountryCode),
    ValidationResultToString(
      LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(0,
        '2530000')));
  Assert.AreEqual(ValidationResultToString(mvrTooShort),
    ValidationResultToString(
      LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(1,
        '253000')));
  Assert.AreEqual(ValidationResultToString(mvrIsPossible),
    ValidationResultToString(
      LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(65,
        '1234567890')));
  Assert.AreEqual(ValidationResultToString(mvrTooLong),
    ValidationResultToString(
      LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(800,
        '123456789')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForTypeWithReason_DifferentTypeLengths;
begin
  CheckPossible(54, '12345', mntUnknown, mvrTooShort);
  CheckPossible(54, '12345', mntFixedLine, mvrTooShort);

  CheckPossible(54, '123456', mntUnknown, mvrIsPossible);
  CheckPossible(54, '123456', mntFixedLine, mvrIsPossible);
  CheckPossible(54, '123456', mntMobile, mvrTooShort);
  CheckPossible(54, '123456', mntTollFree, mvrTooShort);

  CheckPossible(54, '123456789', mntUnknown, mvrIsPossible);
  CheckPossible(54, '123456789', mntFixedLine, mvrIsPossible);
  CheckPossible(54, '123456789', mntMobile, mvrTooShort);
  CheckPossible(54, '123456789', mntTollFree, mvrTooShort);

  CheckPossible(54, '1234567890', mntUnknown, mvrIsPossible);
  CheckPossible(54, '1234567890', mntFixedLine, mvrIsPossible);
  CheckPossible(54, '1234567890', mntMobile, mvrIsPossible);
  CheckPossible(54, '1234567890', mntTollFree, mvrIsPossible);

  CheckPossible(54, '12345678901', mntUnknown, mvrIsPossible);
  CheckPossible(54, '12345678901', mntFixedLine, mvrTooLong);
  CheckPossible(54, '12345678901', mntMobile, mvrIsPossible);
  CheckPossible(54, '12345678901', mntTollFree, mvrTooLong);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForTypeWithReason_LocalOnly;
begin
  CheckPossible(49, '12', mntUnknown, mvrIsPossibleLocalOnly);
  CheckPossible(49, '12', mntFixedLine, mvrIsPossibleLocalOnly);
  CheckPossible(49, '12', mntMobile, mvrTooShort);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForTypeWithReason_DataMissingForSizeReasons;
begin
  CheckPossible(55, '12345678', mntUnknown, mvrIsPossibleLocalOnly);
  CheckPossible(55, '12345678', mntFixedLine, mvrIsPossibleLocalOnly);
  CheckPossible(55, '1234567890', mntUnknown, mvrIsPossible);
  CheckPossible(55, '1234567890', mntFixedLine, mvrIsPossible);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForTypeWithReason_NumberTypeNotSupportedForRegion;
begin
  CheckPossible(55, '12345678', mntMobile, mvrInvalidLength);
  CheckPossible(55, '12345678', mntFixedLineOrMobile, mvrIsPossibleLocalOnly);

  CheckPossible(55, '1234567', mntMobile, mvrInvalidLength);
  CheckPossible(55, '1234567', mntFixedLineOrMobile, mvrTooShort);
  CheckPossible(55, '1234567', mntFixedLine, mvrTooShort);

  CheckPossible(882, '1234567', mntMobile, mvrTooShort);
  CheckPossible(882, '1234567', mntFixedLineOrMobile, mvrTooShort);
  CheckPossible(882, '1234567', mntFixedLine, mvrInvalidLength);

  CheckPossible(979, '123456789', mntMobile, mvrInvalidLength);
  CheckPossible(979, '123456789', mntFixedLine, mvrInvalidLength);
  CheckPossible(979, '123456789', mntFixedLineOrMobile, mvrInvalidLength);
  CheckPossible(979, '123456789', mntPremiumRate, mvrIsPossible);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsPossibleNumberForTypeWithReason_FixedLineOrMobile;
begin
  CheckPossible(290, '1234', mntFixedLine, mvrTooShort);
  CheckPossible(290, '1234', mntMobile, mvrIsPossible);
  CheckPossible(290, '1234', mntFixedLineOrMobile, mvrIsPossible);

  CheckPossible(290, '12345', mntFixedLine, mvrTooShort);
  CheckPossible(290, '12345', mntMobile, mvrTooLong);
  CheckPossible(290, '12345', mntFixedLineOrMobile, mvrInvalidLength);

  CheckPossible(290, '123456', mntFixedLine, mvrIsPossible);
  CheckPossible(290, '123456', mntMobile, mvrTooLong);
  CheckPossible(290, '123456', mntFixedLineOrMobile, mvrIsPossible);

  CheckPossible(290, '1234567', mntFixedLine, mvrTooLong);
  CheckPossible(290, '1234567', mntMobile, mvrTooLong);
  CheckPossible(290, '1234567', mntFixedLineOrMobile, mvrTooLong);

  { 8-digit numbers are possible for toll-free and premium-rate only. }
  CheckPossible(290, '12345678', mntTollFree, mvrIsPossible);
  CheckPossible(290, '12345678', mntFixedLineOrMobile, mvrTooLong);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNotPossibleNumber;
begin
  Assert.IsFalse(
    LibPhoneNumber.MetadataCore.IsPossibleNumber(1, '65025300001'));
  Assert.IsFalse(
    LibPhoneNumber.MetadataCore.IsPossibleNumber(800, '123456789'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsPossibleNumber(1, '253000'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsPossibleNumber(44, '300'));

  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('+1 650 253 00000', RC_US));
  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('(650) 253-00000', RC_US));
  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('I want a Pizza', RC_US));
  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('253-000', RC_US));
  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('1 3000', RC_GB));
  Assert.IsFalse(TPhoneNumberUtil.IsPossibleNumber('+44 300', RC_GB));
  Assert.IsFalse(
    TPhoneNumberUtil.IsPossibleNumber('+800 1234 5678 9', RC_UN001));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_CanBeInternationallyDialled;
begin
  { The test metadata says US toll-free numbers cannot be dialled
    internationally. }
  Assert.IsFalse(LibPhoneNumber.MetadataFormat.CanBeInternationallyDialled(
    1, '8002530000'));
  Assert.IsTrue(LibPhoneNumber.MetadataFormat.CanBeInternationallyDialled(
    1, '6502530000'));
  { Invalid number. }
  Assert.IsTrue(LibPhoneNumber.MetadataFormat.CanBeInternationallyDialled(
    1, '2530000'));
  { No data for NZ - should return true. }
  Assert.IsTrue(LibPhoneNumber.MetadataFormat.CanBeInternationallyDialled(
    64, '33316005'));
  Assert.IsTrue(LibPhoneNumber.MetadataFormat.CanBeInternationallyDialled(
    800, '12345678'));
end;

{ ---------------------------------------------------------------------------
  Parse
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Test_IsViablePhoneNumber;
begin
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsViablePhoneNumber('1'));
  { Only one or two digits before strange non-possible punctuation. }
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsViablePhoneNumber('1+1+1'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsViablePhoneNumber('80+0'));
  { Two digits is viable. }
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsViablePhoneNumber('00'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsViablePhoneNumber('111'));
  { Alpha numbers. }
  Assert.IsTrue(
    LibPhoneNumber.MetadataCore.IsViablePhoneNumber('0800-4-pizza'));
  Assert.IsTrue(
    LibPhoneNumber.MetadataCore.IsViablePhoneNumber('0800-4-PIZZA'));
  { At least three digits are needed before any alpha characters. }
  Assert.IsFalse(
    LibPhoneNumber.MetadataCore.IsViablePhoneNumber('08-PIZZA'));
  Assert.IsFalse(
    LibPhoneNumber.MetadataCore.IsViablePhoneNumber('8-PIZZA'));
  Assert.IsFalse(
    LibPhoneNumber.MetadataCore.IsViablePhoneNumber('12. March'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsViablePhoneNumberNonAscii;
begin
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsViablePhoneNumber(
    '1' + #$3000 + '34'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsViablePhoneNumber(
    '1' + #$3000 + '3+4'));
  { Unicode variants of possible starting character and other allowed
    punctuation/digits. }
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsViablePhoneNumber(
    #$FF08 + '1' + #$FF09 + #$3000 + '3456789'));
  { A leading + is okay. }
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsViablePhoneNumber(
    '+1' + #$FF09 + #$3000 + '3456789'));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ExtractPossibleNumber;
begin
  Assert.AreEqual('0800-345-600',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber('Tel:0800-345-600'));
  Assert.AreEqual('0800 FOR PIZZA',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber('Tel:0800 FOR PIZZA'));
  { Should not remove the plus sign. }
  Assert.AreEqual('+800-345-600',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber('Tel:+800-345-600'));
  { Wide digits are possible start values. }
  Assert.AreEqual(#$FF10 + #$FF12 + #$FF13,
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber(
      #$FF10 + #$FF12 + #$FF13));
  { Dashes are not possible start values and should be removed. }
  Assert.AreEqual(#$FF11 + #$FF12 + #$FF13,
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber(
      'Num-' + #$FF11 + #$FF12 + #$FF13));
  { If no possible number is present, return the empty string. }
  Assert.AreEqual('',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber('Num-....'));
  { Leading brackets are stripped - these are not used when parsing. }
  Assert.AreEqual('650) 253-0000',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber('(650) 253-0000'));

  { Trailing non-alpha-numeric characters should be removed. }
  Assert.AreEqual('650) 253-0000',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber(
      '(650) 253-0000..- ..'));
  Assert.AreEqual('650) 253-0000',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber('(650) 253-0000.'));
  { This case has a trailing RTL char. }
  Assert.AreEqual('650) 253-0000',
    LibPhoneNumber.MetadataCore.ExtractPossibleNumber(
      '(650) 253-0000' + #$200F));
end;

{ Installs a ONE TERRITORY data set built from the three values the Java test
  sets on its PhoneMetadata.Builder. Everything else is filled in consistently:
  one description per kind, the absent ones with the upstream "-1" possible
  length, a region index of one entry, no formats. The stripper only reads
  nationalPrefixForParsing, nationalPrefixTransformRule and the generalDesc,
  but a half filled data set is exactly what UseMetadataTables exists to
  prevent, so the record is complete. }
procedure TUpstreamPhoneNumberUtilTests.UseSyntheticMetadata(
  const ANationalPrefixForParsing, ANationalPrefixTransformRule,
  AGeneralDescPattern: string);
var
  Tables: TPhoneMetadataTables;
  Kind: TPhoneNumberDescKind;
begin
  FSynLengths[0] := NoPossibleLength;
  FSynLeadingDigits[0] := '';
  FSynFormats[0] := Default(TNumberFormatRec);

  for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
  begin
    FSynDescs[Ord(Kind)] := Default(TPhoneNumberDescRec);
    FSynDescs[Ord(Kind)].LengthOffset := 0;
    FSynDescs[Ord(Kind)].LengthCount := 1;
  end;
  FSynDescs[Ord(pdkGeneralDesc)].HasData := True;
  FSynDescs[Ord(pdkGeneralDesc)].NationalNumberPattern := AGeneralDescPattern;

  FSynTerritories[0] := Default(TPhoneMetadataRec);
  FSynTerritories[0].Id := 'ZZ';
  FSynTerritories[0].CountryCode := 1;
  FSynTerritories[0].NationalPrefixForParsing := ANationalPrefixForParsing;
  FSynTerritories[0].NationalPrefixTransformRule := ANationalPrefixTransformRule;
  FSynTerritories[0].MainCountryForCode := True;

  FSynRegionOrder[0] := 0;
  FSynRegionCodes[0] := 'ZZ';
  FSynNonGeoOrder[0] := 0;
  FSynNonGeoCallingCodes[0] := 0;
  FSynCountryCodeGroups[0].CountryCode := 1;
  FSynCountryCodeGroups[0].RegionOffset := 0;
  FSynCountryCodeGroups[0].RegionCount := 1;
  FSynCountryCodeRegions[0] := 0;

  Tables := Default(TPhoneMetadataTables);
  Tables.GeneratorVersion := 'synthetic-test-metadata';
  Tables.SourceFile := 'PhoneNumberUtilTest.testMaybeStripNationalPrefix';
  Tables.SourceCommit := '';
  Tables.Territories := @FSynTerritories;
  Tables.TerritoryCount := 1;
  Tables.Descs := @FSynDescs;
  Tables.DescCount := PhoneNumberDescKindCount;
  Tables.NumberFormats := @FSynFormats;
  Tables.NumberFormatCount := 0;
  Tables.IntlNumberFormats := @FSynFormats;
  Tables.IntlNumberFormatCount := 0;
  Tables.LeadingDigits := @FSynLeadingDigits;
  Tables.LeadingDigitsCount := 0;
  Tables.PossibleLengths := @FSynLengths;
  Tables.PossibleLengthCount := 1;
  Tables.RegionOrder := @FSynRegionOrder;
  Tables.RegionCodes := @FSynRegionCodes;
  Tables.RegionCount := 1;
  Tables.NonGeoOrder := @FSynNonGeoOrder;
  Tables.NonGeoCallingCodes := @FSynNonGeoCallingCodes;
  Tables.NonGeoCount := 0;
  Tables.CountryCodeGroups := @FSynCountryCodeGroups;
  Tables.CountryCodeRegions := @FSynCountryCodeRegions;
  Tables.CountryCodeCount := 1;

  UseMetadataTables(Tables);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_MaybeStripNationalPrefix;
var
  NumberToStrip, CarrierCode: string;
begin
  { The Java test builds a PhoneMetadata.Builder by hand; here the whole
    ACTIVE data set is replaced by a synthetic one for the duration of the
    test, which is the same thing through the metadata switch. The finally block
    puts the testing tables back; TearDown then restores production. }
  try
    UseSyntheticMetadata('34', '', '\d{4,8}');
    NumberToStrip := '34356778';
    Assert.IsTrue(MaybeStripNationalPrefixAndCarrierCode(NumberToStrip,
      @FSynTerritories[0], CarrierCode));
    Assert.AreEqual('356778', NumberToStrip,
      'Should have had national prefix stripped.');
    { Retry stripping - now the number should not start with the national
      prefix, so no more stripping should occur. }
    Assert.IsFalse(MaybeStripNationalPrefixAndCarrierCode(NumberToStrip,
      @FSynTerritories[0], CarrierCode));
    Assert.AreEqual('356778', NumberToStrip,
      'Should have had no change - no national prefix present.');

    { Some countries have no national prefix. }
    UseSyntheticMetadata('', '', '\d{4,8}');
    Assert.IsFalse(MaybeStripNationalPrefixAndCarrierCode(NumberToStrip,
      @FSynTerritories[0], CarrierCode));
    Assert.AreEqual('356778', NumberToStrip,
      'Should not strip anything with empty national prefix.');

    { If the resultant number doesn't match the national rule, it shouldn't be
      stripped. }
    UseSyntheticMetadata('3', '', '\d{4,8}');
    NumberToStrip := '3123';
    Assert.IsFalse(MaybeStripNationalPrefixAndCarrierCode(NumberToStrip,
      @FSynTerritories[0], CarrierCode));
    Assert.AreEqual('3123', NumberToStrip,
      'Should have had no change - after stripping, it wouldn''t have matched the national rule.');

    { Extracting the carrier selection code. }
    UseSyntheticMetadata('0(81)?', '', '\d{4,8}');
    NumberToStrip := '08122123456';
    Assert.IsTrue(MaybeStripNationalPrefixAndCarrierCode(NumberToStrip,
      @FSynTerritories[0], CarrierCode));
    Assert.AreEqual('81', CarrierCode);
    Assert.AreEqual('22123456', NumberToStrip,
      'Should have had national prefix and carrier code stripped.');

    { If there was a transform rule, check it was applied. Note that a
      capturing group is present here. }
    UseSyntheticMetadata('0(\d{2})', '5$15', '\d{4,8}');
    NumberToStrip := '031123';
    Assert.IsTrue(MaybeStripNationalPrefixAndCarrierCode(NumberToStrip,
      @FSynTerritories[0], CarrierCode));
    Assert.AreEqual('5315123', NumberToStrip,
      'Should transform the 031 to a 5315.');
  finally
    UseTestingMetadata;
  end;
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseNationalNumber;
var
  NzNumber: TPhoneNumber;
begin
  NzNumber := MakeNumber(64, '33316005');

  { National prefix attached. }
  CheckParse(NzNumber, '033316005', RC_NZ);
  Assert.AreEqual(Ord(pnccsUnspecified),
    Ord(ParseOk('033316005', RC_NZ).CountryCodeSource),
    'plain parse must not fill in the country code source');

  CheckParse(NzNumber, '33316005', RC_NZ);
  CheckParse(NzNumber, '03-331 6005', RC_NZ);
  CheckParse(NzNumber, '03 331 6005', RC_NZ);
  { RFC3966 with a phone context. }
  CheckParse(NzNumber, 'tel:03-331-6005;phone-context=+64', RC_NZ);
  CheckParse(NzNumber, 'tel:331-6005;phone-context=+64-3', RC_NZ);
  CheckParse(NzNumber, 'tel:331-6005;phone-context=+64-3', RC_US);
  CheckParse(NzNumber, 'My number is tel:03-331-6005;phone-context=+64', RC_NZ);
  { Optional user-defined parameters after the context. }
  CheckParse(NzNumber, 'tel:03-331-6005;phone-context=+64;a=%A1', RC_NZ);
  { An ISDN subaddress. }
  CheckParse(NzNumber, 'tel:03-331-6005;isub=12345;phone-context=+64', RC_NZ);
  CheckParse(NzNumber, 'tel:+64-3-331-6005;isub=12345', RC_NZ);
  { "tel:" missing. }
  CheckParse(NzNumber, '03-331-6005;phone-context=+64', RC_NZ);
  { International prefixes. }
  CheckParse(NzNumber, '0064 3 331 6005', RC_NZ);
  CheckParse(NzNumber, '01164 3 331 6005', RC_US);
  CheckParse(NzNumber, '+64 3 331 6005', RC_US);
  { The leading plus is ignored here, since it is not followed by a valid
    country code but by the IDD for the US. }
  CheckParse(NzNumber, '+01164 3 331 6005', RC_US);
  CheckParse(NzNumber, '+0064 3 331 6005', RC_NZ);
  CheckParse(NzNumber, '+ 00 64 3 331 6005', RC_NZ);

  CheckParse(MakeNumber(1, '2530000'),
    'tel:253-0000;phone-context=www.google.com', RC_US);
  CheckParse(MakeNumber(1, '2530000'),
    'tel:253-0000;isub=12345;phone-context=www.google.com', RC_US);
  CheckParse(MakeNumber(1, '2530000'),
    'tel:2530000;isub=12345;phone-context=1234.com', RC_US);

  CheckParse(MakeNumber(64, '64123456'), '64(0)64123456', RC_NZ);
  { A "/" is fine in a phone number. }
  CheckParse(MakeNumber(49, '30123456'), '301/23456', RC_DE);

  { The '1' is not used as a country calling code when the phone number was
    already possible. }
  CheckParse(MakeNumber(1, '1234567890'), '123-456-7890', RC_US);

  { Star numbers. }
  CheckParse(MakeNumber(81, '2345'), '+81 *2345', RC_JP);

  CheckParse(MakeNumber(64, '12'), '12', RC_NZ);

  { A short code with a leading zero for a country which has 0 as national
    prefix. }
  CheckParse(MakeNumber(44, '0123456'), '0123456', RC_GB);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseNumberWithAlphaCharacters;
var
  PremiumNumber: TPhoneNumber;
begin
  CheckParse(MakeNumber(64, '800332005'), '0800 DDA 005', RC_NZ);
  PremiumNumber := MakeNumber(64, '9003326005');
  CheckParse(PremiumNumber, '0900 DDA 6005', RC_NZ);
  { Not enough alpha characters for them to be considered intentional, so they
    are stripped. }
  CheckParse(PremiumNumber, '0900 332 6005a', RC_NZ);
  CheckParse(PremiumNumber, '0900 332 600a5', RC_NZ);
  CheckParse(PremiumNumber, '0900 332 600A5', RC_NZ);
  CheckParse(PremiumNumber, '0900 a332 600A5', RC_NZ);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseMaliciousInput;
var
  Malicious: string;
  I: Integer;
begin
  Malicious := StringOfChar('+', 6000) + '12222-33-244 extensioB 343+';
  CheckParseFails(Malicious, RC_US, pnpeTooLongNsn);

  Malicious := '';
  for I := 1 to 350 do
    Malicious := Malicious + '200';
  Malicious := Malicious + ' extensiOB 345';
  CheckParseFails(Malicious, RC_US, pnpeTooLongNsn);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseWithInternationalPrefixes;
var
  UsNumber: TPhoneNumber;
begin
  UsNumber := MakeNumber(1, '6502530000');
  CheckParse(UsNumber, '+1 (650) 253-0000', RC_NZ);
  CheckParse(MakeNumber(800, '12345678'), '011 800 1234 5678', RC_US);
  CheckParse(UsNumber, '1-650-253-0000', RC_US);
  { Calling the US number from Singapore with different service providers. }
  CheckParse(UsNumber, '0011-650-253-0000', RC_SG);
  CheckParse(UsNumber, '0081-650-253-0000', RC_SG);
  CheckParse(UsNumber, '0191-650-253-0000', RC_SG);
  { Calling the US number from Poland. }
  CheckParse(UsNumber, '0~01-650-253-0000', RC_PL);
  { Using "++" at the start. }
  CheckParse(UsNumber, '++1 (650) 253-0000', RC_PL);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseNonAscii;
var
  UsNumber: TPhoneNumber;
begin
  UsNumber := MakeNumber(1, '6502530000');
  { A full-width plus sign. }
  CheckParse(UsNumber, #$FF0B + '1 (650) 253-0000', RC_SG);
  { A soft hyphen U+00AD. }
  CheckParse(UsNumber, '1 (650) 253' + #$00AD + '-0000', RC_US);
  { The whole number, including punctuation, in full-width form. }
  CheckParse(UsNumber,
    #$FF0B + #$FF11 + #$3000 + #$FF08 + #$FF16 + #$FF15 + #$FF10 + #$FF09 +
    #$3000 + #$FF12 + #$FF15 + #$FF13 + #$FF0D + #$FF10 + #$FF10 + #$FF10 +
    #$FF10, RC_SG);
  { Using the U+30FC dash instead. }
  CheckParse(UsNumber,
    #$FF0B + #$FF11 + #$3000 + #$FF08 + #$FF16 + #$FF15 + #$FF10 + #$FF09 +
    #$3000 + #$FF12 + #$FF15 + #$FF13 + #$30FC + #$FF10 + #$FF10 + #$FF10 +
    #$FF10, RC_SG);
  { A very strange decimal digit range (Mongolian digits). }
  CheckParse(UsNumber,
    #$1811 + ' ' + #$1816 + #$1815 + #$1810 + ' ' + #$1812 + #$1815 + #$1813 +
    ' ' + #$1810 + #$1810 + #$1810 + #$1810, RC_US);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseWithLeadingZero;
var
  ItNumber: TPhoneNumber;
begin
  ItNumber := MakeNumber(39, '0236618300');
  CheckParse(ItNumber, '+39 02-36618 300', RC_NZ);
  CheckParse(ItNumber, '02-36618 300', RC_IT);
  CheckParse(MakeNumber(39, '345678901'), '345 678 901', RC_IT);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseNationalNumberArgentina;
begin
  { Mobile numbers of Argentina. }
  CheckParse(MakeNumber(54, '93435551212'), '+54 9 343 555 1212', RC_AR);
  CheckParse(MakeNumber(54, '93435551212'), '0343 15 555 1212', RC_AR);

  CheckParse(MakeNumber(54, '93715654320'), '+54 9 3715 65 4320', RC_AR);
  CheckParse(MakeNumber(54, '93715654320'), '03715 15 65 4320', RC_AR);
  CheckParse(MakeNumber(54, '91187654321'), '911 876 54321', RC_AR);

  { Fixed-line numbers of Argentina. }
  CheckParse(MakeNumber(54, '1187654321'), '+54 11 8765 4321', RC_AR);
  CheckParse(MakeNumber(54, '1187654321'), '011 8765 4321', RC_AR);

  CheckParse(MakeNumber(54, '3715654321'), '+54 3715 65 4321', RC_AR);
  CheckParse(MakeNumber(54, '3715654321'), '03715 65 4321', RC_AR);

  CheckParse(MakeNumber(54, '2312340000'), '+54 23 1234 0000', RC_AR);
  CheckParse(MakeNumber(54, '2312340000'), '023 1234 0000', RC_AR);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseWithXInNumber;
var
  ArNumber: TPhoneNumber;
begin
  ArNumber := MakeNumber(54, '1187654321');
  CheckParse(ArNumber, '01187654321', RC_AR);
  CheckParse(ArNumber, '(0) 1187654321', RC_AR);
  CheckParse(ArNumber, '0 1187654321', RC_AR);
  CheckParse(ArNumber, '(0xx) 1187654321', RC_AR);
  CheckParse(MakeNumber(54, '81429712'), '011xx5481429712', RC_US);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseNumbersMexico;
var
  MxNumber: TPhoneNumber;
begin
  { Fixed-line numbers of Mexico. }
  MxNumber := MakeNumber(52, '4499780001');
  CheckParse(MxNumber, '+52 (449)978-0001', RC_MX);
  CheckParse(MxNumber, '01 (449)978-0001', RC_MX);
  CheckParse(MxNumber, '(449)978-0001', RC_MX);

  { Mobile numbers of Mexico. }
  MxNumber := MakeNumber(52, '13312345678');
  CheckParse(MxNumber, '+52 1 33 1234-5678', RC_MX);
  CheckParse(MxNumber, '044 (33) 1234-5678', RC_MX);
  CheckParse(MxNumber, '045 33 1234-5678', RC_MX);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_FailedParseOnInvalidNumbers;
begin
  CheckParseFails('This is not a phone number', RC_NZ, pnpeNotANumber);
  CheckParseFails('1 Still not a number', RC_NZ, pnpeNotANumber);
  CheckParseFails('1 MICROSOFT', RC_NZ, pnpeNotANumber);
  CheckParseFails('12 MICROSOFT', RC_NZ, pnpeNotANumber);
  CheckParseFails('01495 72553301873 810104', RC_GB, pnpeTooLongNsn);
  CheckParseFails('+---', RC_DE, pnpeNotANumber);
  CheckParseFails('+***', RC_DE, pnpeNotANumber);
  CheckParseFails('+*******91', RC_DE, pnpeNotANumber);
  CheckParseFails('+49 0', RC_DE, pnpeTooShortNsn);
  CheckParseFails('+210 3456 56789', RC_NZ, pnpeInvalidCountryCode);
  { 00 is a correct IDD, but 210 is not a valid country code. }
  CheckParseFails('+ 00 210 3 331 6005', RC_NZ, pnpeInvalidCountryCode);
  CheckParseFails('123 456 7890', RC_ZZ, pnpeInvalidCountryCode);
  CheckParseFails('123 456 7890', 'CS', pnpeInvalidCountryCode);
  { Java passes null here; the empty string is this port's equivalent. }
  CheckParseFails('123 456 7890', '', pnpeInvalidCountryCode);
  CheckParseFails('0044------', RC_GB, pnpeTooShortAfterIdd);
  CheckParseFails('0044', RC_GB, pnpeTooShortAfterIdd);
  CheckParseFails('011', RC_US, pnpeTooShortAfterIdd);
  CheckParseFails('0119', RC_US, pnpeTooShortAfterIdd);
  CheckParseFails('', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:555-1234;phone-context=www.google.com', RC_ZZ,
    pnpeInvalidCountryCode);
  { Invalid because no "+" sign is present as part of the phone-context. }
  CheckParseFails('tel:555-1234;phone-context=1-331', RC_ZZ, pnpeNotANumber);
  { Only the phone-context symbol is present, but no data. }
  CheckParseFails(';phone-context=', RC_ZZ, pnpeNotANumber);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseNumbersWithPlusWithNoRegion;
var
  NzNumber, Parsed: TPhoneNumber;
begin
  NzNumber := MakeNumber(64, '33316005');
  { RegionCode.ZZ is allowed only if the number starts with a '+'. }
  CheckParse(NzNumber, '+64 3 331 6005', RC_ZZ);
  CheckParse(NzNumber, #$FF0B + '64 3 331 6005', RC_ZZ);
  CheckParse(NzNumber, 'Tel: +64 3 331 6005', RC_ZZ);
  { Java also allows null for the region; the empty string is the equivalent. }
  CheckParse(NzNumber, '+64 3 331 6005', '');
  CheckParse(MakeNumber(800, '12345678'), '+800 1234 5678', '');
  CheckParse(MakeNumber(979, '123456789'), '+979 123 456 789', '');

  CheckParse(NzNumber, 'tel:03-331-6005;phone-context=+64', RC_ZZ);
  CheckParse(NzNumber, '  tel:03-331-6005;phone-context=+64', RC_ZZ);
  CheckParse(NzNumber, 'tel:03-331-6005;isub=12345;phone-context=+64', RC_ZZ);

  Parsed := ParseRawOk('+64 3 331 6005', RC_ZZ);
  CheckNumber(NzNumber, Parsed, 'parseAndKeepRawInput("+64 3 331 6005", ZZ)');
  Assert.AreEqual('+64 3 331 6005', Parsed.RawInput);
  Assert.AreEqual(Ord(pnccsFromNumberWithPlusSign), Ord(Parsed.CountryCodeSource));

  Parsed := ParseRawOk('+64 3 331 6005', '');
  CheckNumber(NzNumber, Parsed, 'parseAndKeepRawInput("+64 3 331 6005", null)');
  Assert.AreEqual('+64 3 331 6005', Parsed.RawInput);
  Assert.AreEqual(Ord(pnccsFromNumberWithPlusSign), Ord(Parsed.CountryCodeSource));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseNumberTooShortIfNationalPrefixStripped;
begin
  { A number whose first digits happen to coincide with the national prefix
    does not get them stripped if doing so would result in a number too short
    to be possible. }
  CheckParse(MakeNumber(375, '8123'), '8123', RC_BY);
  CheckParse(MakeNumber(375, '81234'), '81234', RC_BY);
  { The prefix doesn't get stripped, since the input is a viable 6-digit
    number, whereas the result of stripping is only 5 digits. }
  CheckParse(MakeNumber(375, '812345'), '812345', RC_BY);
  { The prefix gets stripped, since only 6-digit numbers are possible. }
  CheckParse(MakeNumber(375, '123456'), '8123456', RC_BY);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseExtensions;
var
  NzNumber, AlphaNumeric, UkNumber, UsWithExtension, RuWithExtension: TPhoneNumber;
begin
  NzNumber := MakeNumber(64, '33316005', '3456');
  CheckParse(NzNumber, '03 331 6005 ext 3456', RC_NZ);
  CheckParse(NzNumber, '03-3316005x3456', RC_NZ);
  CheckParse(NzNumber, '03-3316005 int.3456', RC_NZ);
  CheckParse(NzNumber, '03 3316005 #3456', RC_NZ);

  { The following do not extract extensions. }
  AlphaNumeric := MakeNumber(1, '80074935247');
  CheckParse(AlphaNumeric, '1800 six-flags', RC_US);
  CheckParse(AlphaNumeric, '1800 SIX FLAGS', RC_US);
  CheckParse(AlphaNumeric, '0~0 1800 7493 5247', RC_PL);
  CheckParse(AlphaNumeric, '(1800) 7493.5247', RC_US);
  { The last instance of an extension token is matched. }
  CheckParse(MakeNumber(1, '80074935247', '1234'),
    '0~0 1800 7493 5247 ~1234', RC_PL);

  UkNumber := MakeNumber(44, '2034567890', '456');
  CheckParse(UkNumber, '+44 2034567890x456', RC_NZ);
  CheckParse(UkNumber, '+44 2034567890x456', RC_GB);
  CheckParse(UkNumber, '+44 2034567890 x456', RC_GB);
  CheckParse(UkNumber, '+44 2034567890 X456', RC_GB);
  CheckParse(UkNumber, '+44 2034567890 X 456', RC_GB);
  CheckParse(UkNumber, '+44 2034567890 X  456', RC_GB);
  CheckParse(UkNumber, '+44 2034567890 x 456  ', RC_GB);
  CheckParse(UkNumber, '+44 2034567890  X 456', RC_GB);
  CheckParse(UkNumber, '+44-2034567890;ext=456', RC_GB);
  CheckParse(UkNumber, 'tel:2034567890;ext=456;phone-context=+44', RC_ZZ);
  { Full-width extension, "extn" only. }
  CheckParse(UkNumber,
    '+442034567890' + #$FF45 + #$FF58 + #$FF54 + #$FF4E + '456', RC_GB);
  { "xtn" only. }
  CheckParse(UkNumber,
    '+442034567890' + #$FF58 + #$FF54 + #$FF4E + '456', RC_GB);
  { "xt" only. }
  CheckParse(UkNumber, '+442034567890' + #$FF58 + #$FF54 + '456', RC_GB);

  UsWithExtension := MakeNumber(1, '8009013355', '7246433');
  CheckParse(UsWithExtension, '(800) 901-3355 x 7246433', RC_US);
  CheckParse(UsWithExtension, '(800) 901-3355 , ext 7246433', RC_US);
  CheckParse(UsWithExtension, '(800) 901-3355 ; 7246433', RC_US);
  CheckParse(UsWithExtension, '(800) 901-3355;7246433', RC_US);
  CheckParse(UsWithExtension, '(800) 901-3355 ,extension 7246433', RC_US);
  CheckParse(UsWithExtension,
    '(800) 901-3355 ,extensi' + #$00F3 + 'n 7246433', RC_US);
  { The small letter o with acute accent created by combining characters. }
  CheckParse(UsWithExtension,
    '(800) 901-3355 ,extensio' + #$0301 + 'n 7246433', RC_US);
  CheckParse(UsWithExtension, '(800) 901-3355 , 7246433', RC_US);
  CheckParse(UsWithExtension, '(800) 901-3355 ext: 7246433', RC_US);

  { The Russian extension label. }
  RuWithExtension := MakeNumber(7, '4232022511', '100');
  CheckParse(RuWithExtension,
    '8 (423) 202-25-11, ' + #$0434 + #$043E + #$0431 + '. 100', RC_RU);
  CheckParse(RuWithExtension,
    '8 (423) 202-25-11 ' + #$0434 + #$043E + #$0431 + '. 100', RC_RU);
  CheckParse(RuWithExtension,
    '8 (423) 202-25-11, ' + #$0434 + #$043E + #$0431 + ' 100', RC_RU);
  CheckParse(RuWithExtension,
    '8 (423) 202-25-11 ' + #$0434 + #$043E + #$0431 + ' 100', RC_RU);
  CheckParse(RuWithExtension,
    '8 (423) 202-25-11' + #$0434 + #$043E + #$0431 + '100', RC_RU);
  { In upper case. }
  CheckParse(RuWithExtension,
    '8 (423) 202-25-11, ' + #$0414 + #$041E + #$0411 + '. 100', RC_RU);

  { If a number has two extensions specified, the second is ignored. }
  CheckParse(MakeNumber(1, '2121231234', '508'), '(212)123-1234 x508/x1234',
    RC_US);
  CheckParse(MakeNumber(1, '2121231234', '508'), '(212)123-1234 x508/ x1234',
    RC_US);
  CheckParse(MakeNumber(1, '2121231234', '508'), '(212)123-1234 x508\x1234',
    RC_US);

  { Numbers in the form (645) 123-1234-910#, where the last 3 digits before the
    # are an extension. }
  CheckParse(MakeNumber(1, '6451231234', '910'), '+1 (645) 123 1234-910#',
    RC_US);
  CheckParse(MakeNumber(1, '6451231234', '910'), '+1 (645) 123 1234 ext. 910#',
    RC_US);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseHandlesLongExtensionsWithExplicitLabels;
begin
  { In RFC format: extLimitAfterExplicitLabel. }
  CheckParse(MakeNumber(64, '33316005', '0'), 'tel:+6433316005;ext=0', RC_NZ);
  CheckParse(MakeNumber(64, '33316005', '01234567890123456789'),
    'tel:+6433316005;ext=01234567890123456789', RC_NZ);
  CheckParseFails('tel:+6433316005;ext=012345678901234567890', RC_NZ,
    pnpeNotANumber);

  { Explicit extension label: extLimitAfterExplicitLabel. }
  CheckParse(MakeNumber(64, '33316005', '1'), '03 3316005ext:1', RC_NZ);
  CheckParse(MakeNumber(64, '33316005', '12345678901234567890'),
    '03 3316005 xtn:12345678901234567890', RC_NZ);
  CheckParse(MakeNumber(64, '33316005', '12345678901234567890'),
    '03 3316005 extension' + #9 + '12345678901234567890', RC_NZ);
  CheckParse(MakeNumber(64, '33316005', '12345678901234567890'),
    '03 3316005 xtensio:12345678901234567890', RC_NZ);
  CheckParse(MakeNumber(64, '33316005', '12345678901234567890'),
    '03 3316005 xtensi' + #$00F3 + 'n, 12345678901234567890#', RC_NZ);
  CheckParse(MakeNumber(64, '33316005', '12345678901234567890'),
    '03 3316005extension.12345678901234567890', RC_NZ);
  CheckParse(MakeNumber(64, '33316005', '12345678901234567890'),
    '03 3316005 ' + #$0434 + #$043E + #$0431 + ':12345678901234567890', RC_NZ);
  CheckParseFails('03 3316005 extension 123456789012345678901', RC_NZ,
    pnpeTooLongNsn);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseHandlesLongExtensionsWithAutoDiallingLabels;
begin
  CheckParse(MakeNumber(1, '2679000000', '123456789012345'),
    '+12679000000,,123456789012345#', RC_US);
  CheckParse(MakeNumber(1, '2679000000', '123456789012345'),
    '+12679000000;123456789012345#', RC_US);
  CheckParse(MakeNumber(44, '2034000000', '123456789'),
    '+442034000000,,123456789#', RC_GB);
  CheckParseFails('+12679000000,,1234567890123456#', RC_US, pnpeNotANumber);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseHandlesShortExtensionsWithAmbiguousChar;
var
  NzNumber: TPhoneNumber;
begin
  NzNumber := MakeNumber(64, '33316005', '123456789');
  CheckParse(NzNumber, '03 3316005 x 123456789', RC_NZ);
  CheckParse(NzNumber, '03 3316005 x. 123456789', RC_NZ);
  CheckParse(NzNumber, '03 3316005 #123456789#', RC_NZ);
  CheckParse(NzNumber, '03 3316005 ~ 123456789', RC_NZ);
  CheckParseFails('03 3316005 ~ 1234567890', RC_NZ, pnpeTooLongNsn);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseHandlesShortExtensionsWhenNotSureOfLabel;
begin
  CheckParse(MakeNumber(1, '1234567890', '666666'),
    '+1123-456-7890 666666#', RC_US);
  CheckParse(MakeNumber(1, '1234567890', '6'), '+11234567890-6#', RC_US);
  CheckParseFails('+1123-456-7890 7777777#', RC_US, pnpeNotANumber);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseAndKeepRaw;
var
  Parsed: TPhoneNumber;
begin
  Parsed := ParseRawOk('800 six-flags', RC_US);
  CheckNumber(MakeNumber(1, '80074935247'), Parsed, '800 six-flags');
  Assert.AreEqual('800 six-flags', Parsed.RawInput);
  Assert.AreEqual(Ord(pnccsFromDefaultCountry), Ord(Parsed.CountryCodeSource));

  Parsed := ParseRawOk('1800 six-flag', RC_US);
  CheckNumber(MakeNumber(1, '8007493524'), Parsed, '1800 six-flag');
  Assert.AreEqual('1800 six-flag', Parsed.RawInput);
  Assert.AreEqual(Ord(pnccsFromNumberWithoutPlusSign),
    Ord(Parsed.CountryCodeSource));

  Parsed := ParseRawOk('+1800 six-flag', RC_NZ);
  CheckNumber(MakeNumber(1, '8007493524'), Parsed, '+1800 six-flag');
  Assert.AreEqual('+1800 six-flag', Parsed.RawInput);
  Assert.AreEqual(Ord(pnccsFromNumberWithPlusSign),
    Ord(Parsed.CountryCodeSource));

  Parsed := ParseRawOk('001800 six-flag', RC_NZ);
  CheckNumber(MakeNumber(1, '8007493524'), Parsed, '001800 six-flag');
  Assert.AreEqual('001800 six-flag', Parsed.RawInput);
  Assert.AreEqual(Ord(pnccsFromNumberWithIdd), Ord(Parsed.CountryCodeSource));

  { Invalid region code supplied. }
  CheckParseFails('123 456 7890', 'CS', pnpeInvalidCountryCode);

  Parsed := ParseRawOk('08122123456', RC_KR);
  CheckNumber(MakeNumber(82, '22123456'), Parsed, '08122123456');
  Assert.AreEqual('08122123456', Parsed.RawInput);
  Assert.AreEqual(Ord(pnccsFromDefaultCountry), Ord(Parsed.CountryCodeSource));
  Assert.AreEqual('81', Parsed.PreferredDomesticCarrierCode);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseItalianLeadingZeros;
begin
  { The leading zeros of the Java italianLeadingZero/numberOfLeadingZeros pair
    are simply part of the national significant number here. }
  CheckParse(MakeNumber(61, '011'), '011', RC_AU);
  CheckParse(MakeNumber(61, '001'), '001', RC_AU);
  CheckParse(MakeNumber(61, '000'), '000', RC_AU);
  CheckParse(MakeNumber(61, '0000'), '0000', RC_AU);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_ParseWithPhoneContext;
var
  NzNumber: TPhoneNumber;
begin
  NzNumber := MakeNumber(64, '33316005');
  { Valid global-phone-digits. }
  CheckParse(NzNumber, 'tel:033316005;phone-context=+64', RC_ZZ);
  CheckParse(NzNumber,
    'tel:033316005;phone-context=+64;{this isn''t part of phone-context anymore!}',
    RC_ZZ);
  CheckParse(MakeNumber(64, '3033316005'),
    'tel:033316005;phone-context=+64-3', RC_ZZ);
  CheckParse(MakeNumber(55, '5033316005'),
    'tel:033316005;phone-context=+(555)', RC_ZZ);
  CheckParse(MakeNumber(1, '23033316005'),
    'tel:033316005;phone-context=+-1-2.3()', RC_ZZ);

  { Valid domainname. }
  CheckParse(NzNumber, 'tel:033316005;phone-context=abc.nz', RC_NZ);
  CheckParse(NzNumber, 'tel:033316005;phone-context=www.PHONE-numb3r.com', RC_NZ);
  CheckParse(NzNumber, 'tel:033316005;phone-context=a', RC_NZ);
  CheckParse(NzNumber, 'tel:033316005;phone-context=3phone.J.', RC_NZ);
  CheckParse(NzNumber, 'tel:033316005;phone-context=a--z', RC_NZ);

  { Invalid descriptor. }
  CheckParseFails('tel:033316005;phone-context=', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=+', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=64', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=++64', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=+abc', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=.', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=3phone', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=a-.nz', RC_ZZ, pnpeNotANumber);
  CheckParseFails('tel:033316005;phone-context=a{b}c', RC_ZZ, pnpeNotANumber);
end;

{ ---------------------------------------------------------------------------
  isNumberMatch
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Test_IsNumberMatchMatches;
var
  NzNumber, NzWithExtn: TPhoneNumber;
begin
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331 6005', '+64 03 331 6005')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+800 1234 5678', '+80012345678')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 03 331-6005', '+64 03331 6005')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+643 331-6005', '+64033316005')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+643 331-6005', '+6433316005')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005', '+6433316005')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005',
      'tel:+64-3-331-6005;isub=123')));
  { Alpha numbers. }
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+1800 siX-Flags', '+1 800 7493 5247')));
  { Numbers with extensions. }
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005 extn 1234',
      '+6433316005#1234')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005 ext. 1234',
      '+6433316005;1234')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+7 423 202-25-11 ext 100',
      '+7 4232022511 ' + #$0434 + #$043E + #$0431 + '. 100')));

  NzNumber := MakeNumber(64, '33316005');
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(NzNumber, '+6403 331 6005')));

  NzWithExtn := MakeNumber(64, '33316005', '3456');
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(NzWithExtn, '+643 331 6005 ext 3456')));
  { Empty extensions are ignored. }
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(NzNumber, '+6403 331 6005')));
  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(NzNumber, NzNumber)));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNumberMatchShortMatchIfDiffNumLeadingZeros;
var
  One, Two: TPhoneNumber;
begin
  { Java encodes the leading zeros as italianLeadingZero plus
    numberOfLeadingZeros; here they are digits of the national significant
    number, so "033316005" against "0033316005" is the same case. }
  One := MakeNumber(64, '033316005');
  Two := MakeNumber(64, '0033316005');
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(One, Two)));

  { UPSTREAM ONLY: the second half of the Java test sets italianLeadingZero to
    false while keeping numberOfLeadingZeros, i.e. it asserts how the two proto
    fields interact. The record has no such pair - a leading zero is either in
    the digits or it is not - so the case cannot exist here. The same holds for
    testIsNumberMatchAcceptsProtoDefaultsAsMatch and
    testIsNumberMatchMatchesDiffLeadingZerosIfItalianLeadingZeroFalse, which
    are not ported for exactly this reason. }
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNumberMatchIgnoresSomeFields;
var
  One, Two: TPhoneNumber;
begin
  { raw_input, country_code_source and preferred_domestic_carrier_code are
    ignored. }
  One := MakeNumber(55, '3121286979');
  One.CountryCodeSource := pnccsFromNumberWithPlusSign;
  One.PreferredDomesticCarrierCode := '12';
  One.RawInput := '012 3121286979';

  Two := MakeNumber(55, '3121286979');
  Two.CountryCodeSource := pnccsFromDefaultCountry;
  Two.PreferredDomesticCarrierCode := '14';
  Two.RawInput := '143121286979';

  Assert.AreEqual(Ord(pnmtExactMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(One, Two)));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNumberMatchNonMatches;
begin
  Assert.AreEqual(Ord(pnmtNoMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('03 331 6005', '03 331 6006')));
  Assert.AreEqual(Ord(pnmtNoMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+800 1234 5678', '+1 800 1234 5678')));
  { Different country calling code, partial number match. }
  Assert.AreEqual(Ord(pnmtNoMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005', '+16433316005')));
  { Different country calling code, same number. }
  Assert.AreEqual(Ord(pnmtNoMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005', '+6133316005')));
  { Extension different, all else the same. }
  Assert.AreEqual(Ord(pnmtNoMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005 extn 1234',
      '0116433316005#1235')));
  Assert.AreEqual(Ord(pnmtNoMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005 extn 1234',
      'tel:+64-3-331-6005;ext=1235')));
  { NSN matches, but extension is different. }
  Assert.AreEqual(Ord(pnmtNoMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005 ext.1235',
      '3 331 6005#1234')));

  { Invalid numbers that can't be parsed. }
  Assert.AreEqual(Ord(pnmtNotANumber),
    Ord(TPhoneNumberUtil.IsNumberMatch('4', '3 331 6043')));
  Assert.AreEqual(Ord(pnmtNotANumber),
    Ord(TPhoneNumberUtil.IsNumberMatch('+43', '+64 3 331 6005')));
  Assert.AreEqual(Ord(pnmtNotANumber),
    Ord(TPhoneNumberUtil.IsNumberMatch('+43', '64 3 331 6005')));
  Assert.AreEqual(Ord(pnmtNotANumber),
    Ord(TPhoneNumberUtil.IsNumberMatch('Dog', '64 3 331 6005')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNumberMatchNsnMatches;
var
  NzNumber, UsNumber, RandomNumber: TPhoneNumber;
begin
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005', '03 331 6005')));
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005',
      'tel:03-331-6005;isub=1234;phone-context=abc.nz')));

  NzNumber := MakeNumber(64, '33316005');
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(NzNumber, '03 331 6005')));
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(NzNumber, '(64-3) 331 6005')));

  UsNumber := MakeNumber(1, '6502530000');
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(UsNumber, '1-650-253-0000')));
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(UsNumber, '6502530000')));
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+1 650-253 0000', '1 650 253 0000')));
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('1 650-253 0000', '1 650 253 0000')));
  Assert.AreEqual(Ord(pnmtNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('1 650-253 0000', '+1 650 253 0000')));

  { Here the 1 cannot be assumed to be a national prefix. }
  RandomNumber := MakeNumber(41, '6502530000');
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(RandomNumber, '1-650-253-0000')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNumberMatchShortNsnMatches;
var
  ItalianOne, ItalianTwo: TPhoneNumber;
begin
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005', '331 6005')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005',
      'tel:331-6005;phone-context=abc.nz')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005',
      'tel:331-6005;isub=1234;phone-context=abc.nz')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005',
      'tel:331-6005;isub=1234;phone-context=abc.nz;a=%A1')));
  { The "0" was not known to be a national prefix. }
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('3 331-6005', '03 331 6005')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('3 331-6005', '331 6005')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('3 331-6005',
      'tel:331-6005;phone-context=abc.nz')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('3 331-6005', '+64 331 6005')));
  { Short NSN match with the country specified. }
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('03 331-6005', '331 6005')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('1 234 345 6789', '345 6789')));
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+1 (234) 345 6789', '345 6789')));
  { NSN matches, country calling code omitted for one number, extension missing
    for one. }
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch('+64 3 331-6005', '3 331 6005#1234')));

  { One has an Italian leading zero, one does not. }
  ItalianOne := MakeNumber(39, '01234');
  ItalianTwo := MakeNumber(39, '1234');
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(ItalianOne, ItalianTwo)));

  { One has an extension, the other has an extension of "". }
  ItalianOne := MakeNumber(39, '1234', '1234');
  ItalianTwo := MakeNumber(39, '1234', '');
  Assert.AreEqual(Ord(pnmtShortNsnMatch),
    Ord(TPhoneNumberUtil.IsNumberMatch(ItalianOne, ItalianTwo)));
end;

{ ---------------------------------------------------------------------------
  Accessory API
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberUtilTests.Test_GetSupportedTypesForRegion;
var
  Types: TMetadataNumberTypes;
begin
  Types := TPhoneNumberUtil.GetSupportedTypesForRegion(RC_BR);
  Assert.IsTrue(mntFixedLine in Types);
  { Our test data has no mobile numbers for Brazil. }
  Assert.IsFalse(mntMobile in Types);
  { UNKNOWN should never be returned. }
  Assert.IsFalse(mntUnknown in Types);

  { "In the US, many numbers are classified as FIXED_LINE_OR_MOBILE; but we
    don't want to expose this as a supported type, instead we say FIXED_LINE
    and MOBILE are both present." }
  Types := TPhoneNumberUtil.GetSupportedTypesForRegion(RC_US);
  Assert.IsTrue(mntFixedLine in Types);
  Assert.IsTrue(mntMobile in Types);
  Assert.IsFalse(mntFixedLineOrMobile in Types);

  { Test the invalid region code. }
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForRegion(RC_ZZ) = []);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetSupportedTypesForNonGeoEntity;
var
  TypesFor979: TMetadataNumberTypes;
begin
  { No data exists for 999 at all, no types should be returned. }
  Assert.IsTrue(TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(999) = []);

  TypesFor979 := TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(979);
  Assert.IsTrue(mntPremiumRate in TypesFor979);
  Assert.IsFalse(mntMobile in TypesFor979);
  Assert.IsFalse(mntUnknown in TypesFor979);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsNumberGeographical;
begin
  { Bahamas, mobile phone number. }
  Assert.IsFalse(TPhoneNumberUtil.IsNumberGeographical(
    MakeNumber(1, '2423570000')));
  { Australian fixed line number. }
  Assert.IsTrue(TPhoneNumberUtil.IsNumberGeographical(
    MakeNumber(61, '236618300')));
  { International toll free number. }
  Assert.IsFalse(TPhoneNumberUtil.IsNumberGeographical(
    MakeNumber(800, '12345678')));
  { "We test that mobile phone numbers in relevant regions are indeed
    considered geographical." Argentina, Mexico, Mexico. }
  Assert.IsTrue(TPhoneNumberUtil.IsNumberGeographical(
    MakeNumber(54, '91187654321')));
  Assert.IsTrue(TPhoneNumberUtil.IsNumberGeographical(
    MakeNumber(52, '12345678900')));
  Assert.IsTrue(TPhoneNumberUtil.IsNumberGeographical(
    MakeNumber(52, '15512345678')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetLengthOfGeographicalAreaCode;
begin
  { Google MTV, which has area code "650". }
  Assert.AreEqual(Integer(3), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(1, '6502530000')));
  { A North America toll-free number, which has no area code. }
  Assert.AreEqual(Integer(0), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(1, '8002530000')));
  { Google London, which has area code "20". }
  Assert.AreEqual(Integer(2), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(44, '2070313000')));
  { A mobile number in the UK does not have an area code. }
  Assert.AreEqual(Integer(0), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(44, '7912345678')));
  { Google Buenos Aires, which has area code "11". }
  Assert.AreEqual(Integer(2), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(54, '1187654321')));
  { A mobile number in Argentina also has an area code. }
  Assert.AreEqual(Integer(3), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(54, '91187654321')));
  { Google Sydney, which has area code "2". }
  Assert.AreEqual(Integer(1), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(61, '236618300')));
  { Italian numbers - there is no national prefix, but it still has an area
    code. IT_NUMBER is 236618300 with italianLeadingZero = true upstream; the
    record carries that as the digits 0236618300. }
  Assert.AreEqual(Integer(2), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(39, '0236618300')));
  { Mexico numbers - there is no national prefix, but it still has an area
    code. }
  Assert.AreEqual(Integer(2), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(52, '3312345678')));
  { Google Singapore. Singapore has no area code and no national prefix. }
  Assert.AreEqual(Integer(0), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(65, '65218000')));
  { An invalid US number (1 digit shorter), which has no area code. }
  Assert.AreEqual(Integer(0), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(1, '650253000')));
  { An international toll free number, which has no area code. }
  Assert.AreEqual(Integer(0), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(800, '12345678')));
  { A mobile number from China is geographical, but does not have an area
    code. }
  Assert.AreEqual(Integer(0), TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
    MakeNumber(86, '18912341234')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetLengthOfNationalDestinationCode;
begin
  { Google MTV, which has national destination code (NDC) "650". }
  Assert.AreEqual(Integer(3),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(1, '6502530000')));
  { A North America toll-free number, which has NDC "800". }
  Assert.AreEqual(Integer(3),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(1, '8002530000')));
  { Google London, which has NDC "20". }
  Assert.AreEqual(Integer(2),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(44, '2070313000')));
  { A UK mobile phone, which has NDC "7912". }
  Assert.AreEqual(Integer(4),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(44, '7912345678')));
  { Google Buenos Aires, which has NDC "11". }
  Assert.AreEqual(Integer(2),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(54, '1187654321')));
  { An Argentinian mobile which has NDC "911". }
  Assert.AreEqual(Integer(3),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(54, '91187654321')));
  { Google Sydney, which has NDC "2". }
  Assert.AreEqual(Integer(1),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(61, '236618300')));
  { Google Singapore, which has NDC "6521". }
  Assert.AreEqual(Integer(4),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(65, '65218000')));
  { An invalid US number (1 digit shorter), which has no NDC. }
  Assert.AreEqual(Integer(0),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(1, '650253000')));
  { A number containing an invalid country calling code, which shouldn't have
    any NDC. }
  Assert.AreEqual(Integer(0),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(123, '6502530000')));
  { An international toll free number, which has NDC "1234". }
  Assert.AreEqual(Integer(4),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(800, '12345678')));
  { "A mobile number from China is geographical, but does not have an area
    code: however it still can be considered to have a national destination
    code." }
  Assert.AreEqual(Integer(3),
    TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
      MakeNumber(86, '18912341234')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetCountryMobileToken;
begin
  Assert.AreEqual('9', TPhoneNumberUtil.GetCountryMobileToken(
    LibPhoneNumber.Metadata.GetCountryCodeForRegion(RC_AR)));
  { Country calling code for Sweden, which has no mobile token. }
  Assert.AreEqual('', TPhoneNumberUtil.GetCountryMobileToken(
    LibPhoneNumber.Metadata.GetCountryCodeForRegion(RC_SE)));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetNationalSignificantNumber;
begin
  Assert.AreEqual('6502530000', TPhoneNumberUtil.GetNationalSignificantNumber(
    MakeNumber(1, '6502530000')));
  { An Italian mobile number. }
  Assert.AreEqual('345678901', TPhoneNumberUtil.GetNationalSignificantNumber(
    MakeNumber(39, '345678901')));
  { An Italian fixed line number. }
  Assert.AreEqual('0236618300', TPhoneNumberUtil.GetNationalSignificantNumber(
    MakeNumber(39, '0236618300')));
  Assert.AreEqual('12345678', TPhoneNumberUtil.GetNationalSignificantNumber(
    MakeNumber(800, '12345678')));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetNationalSignificantNumber_ManyLeadingZeros;
var
  Number: TPhoneNumber;
begin
  { Java: nationalNumber 650, italianLeadingZero = true, numberOfLeadingZeros
    = 2. The record carries the same number as the digits 00650. }
  Number := MakeNumber(1, '00650');
  Assert.AreEqual('00650', TPhoneNumberUtil.GetNationalSignificantNumber(
    Number));

  { UPSTREAM ONLY: the second half of the Java test sets numberOfLeadingZeros
    to -3 and expects "650" - "we shouldn't crash, we shouldn't output any
    leading zeros at all". That is a guard against a malformed (negative)
    numberOfLeadingZeros FIELD, and TPhoneNumber has no such field: the leading
    zeros are part of NationalNumberDigits, so there is no bad count to pass.
    (The OTHER guard of that method, the cap at ten leading zeros, IS ported
    and is pinned against the oracle in
    Accessory_NationalSignificantNumberMatchesTheOracle.)
    What is portable is the fallback of a record that carries only the numeric
    field, which cannot hold a leading zero and therefore prints none: }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 1;
  Number.NationalNumber := 650;
  Assert.AreEqual('650', TPhoneNumberUtil.GetNationalSignificantNumber(
    Number));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetExampleNumber;
var
  Number: TPhoneNumber;
begin
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumber(RC_DE, Number));
  CheckNumber(MakeNumber(49, '30123456'), Number, 'getExampleNumber(DE)');

  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(RC_DE,
    mntFixedLine, Number));
  CheckNumber(MakeNumber(49, '30123456'), Number,
    'getExampleNumberForType(DE, FIXED_LINE)');
  { Should return the same response if asked for FIXED_LINE_OR_MOBILE too. }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(RC_DE,
    mntFixedLineOrMobile, Number));
  CheckNumber(MakeNumber(49, '30123456'), Number,
    'getExampleNumberForType(DE, FIXED_LINE_OR_MOBILE)');
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(RC_US,
    mntFixedLine, Number));
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(RC_US,
    mntMobile, Number));

  { We have data for the US, but no data for VOICEMAIL, so return null. }
  Assert.IsFalse(TPhoneNumberUtil.TryGetExampleNumberForType(RC_US,
    mntVoicemail, Number));
  { CS is an invalid region, so we have no data for it. }
  Assert.IsFalse(TPhoneNumberUtil.TryGetExampleNumberForType('CS',
    mntMobile, Number));
  { "RegionCode 001 is reserved for supporting non-geographical country
    calling code. We don't support getting an example number for it with this
    method." }
  Assert.IsFalse(TPhoneNumberUtil.TryGetExampleNumber(RC_UN001, Number));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetInvalidExampleNumber;
var
  UsInvalidNumber: TPhoneNumber;
begin
  { "RegionCode 001 is reserved for supporting non-geographical country
    calling codes. We don't support getting an invalid example number for it
    with getInvalidExampleNumber." }
  Assert.IsFalse(TPhoneNumberUtil.TryGetInvalidExampleNumber(RC_UN001,
    UsInvalidNumber));
  Assert.IsFalse(TPhoneNumberUtil.TryGetInvalidExampleNumber('CS',
    UsInvalidNumber));
  Assert.IsTrue(TPhoneNumberUtil.TryGetInvalidExampleNumber(RC_US,
    UsInvalidNumber));
  Assert.AreEqual(Integer(1), UsInvalidNumber.CountryCode);
  Assert.IsFalse(UsInvalidNumber.NationalNumber = 0);
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetExampleNumberForNonGeoEntity;
var
  Number: TPhoneNumber;
begin
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(800,
    Number));
  CheckNumber(MakeNumber(800, '12345678'), Number,
    'getExampleNumberForNonGeoEntity(800)');
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(979,
    Number));
  CheckNumber(MakeNumber(979, '123456789'), Number,
    'getExampleNumberForNonGeoEntity(979)');
end;

procedure TUpstreamPhoneNumberUtilTests.Test_GetExampleNumberWithoutRegion;
var
  Number: TPhoneNumber;
begin
  { "In our test metadata we don't cover all types: in our real metadata, we
    do." }
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(mntFixedLine,
    Number));
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(mntMobile,
    Number));
  Assert.IsTrue(TPhoneNumberUtil.TryGetExampleNumberForType(mntPremiumRate,
    Number));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_TruncateTooLongNumber;
var
  TooLongNumber, ValidNumber, ValidNumberCopy, NumberWithInvalidPrefix,
    InvalidNumberCopy, TooShortNumber, TooShortNumberCopy: TPhoneNumber;

  { Java compares whole protos; this compares every field the record
    models. }
  procedure CheckSame(const AExpected, AActual: TPhoneNumber;
    const AContext: string);
  begin
    CheckNumber(AExpected, AActual, AContext);
    Assert.IsTrue(AExpected.NationalNumber = AActual.NationalNumber,
      AContext + ': numeric national number');
    Assert.AreEqual(AExpected.RawInput, AActual.RawInput,
      AContext + ': raw input');
    Assert.AreEqual(Ord(AExpected.CountryCodeSource),
      Ord(AActual.CountryCodeSource), AContext + ': country code source');
    Assert.AreEqual(AExpected.PreferredDomesticCarrierCode,
      AActual.PreferredDomesticCarrierCode,
      AContext + ': preferred domestic carrier code');
    Assert.AreEqual(AExpected.RegionCode, AActual.RegionCode,
      AContext + ': region code');
  end;

var
  Kept, KeptCopy: TPhoneNumber;

begin
  { GB number 080 1234 5678, but entered with 4 extra digits at the end. }
  TooLongNumber := MakeNumber(44, '80123456780123');
  ValidNumber := MakeNumber(44, '8012345678');
  Assert.IsTrue(TPhoneNumberUtil.TruncateTooLongNumber(TooLongNumber));
  CheckSame(ValidNumber, TooLongNumber, 'GB');

  { IT number 022 3456 7890, but entered with 3 extra digits at the end.
    italianLeadingZero = true is the leading 0 of the digits. }
  TooLongNumber := MakeNumber(39, '02234567890123');
  ValidNumber := MakeNumber(39, '02234567890');
  Assert.IsTrue(TPhoneNumberUtil.TruncateTooLongNumber(TooLongNumber));
  CheckSame(ValidNumber, TooLongNumber, 'IT');

  { US number 650-253-0000, but entered with one additional digit at the end. }
  TooLongNumber := MakeNumber(1, '65025300001');
  Assert.IsTrue(TPhoneNumberUtil.TruncateTooLongNumber(TooLongNumber));
  CheckSame(MakeNumber(1, '6502530000'), TooLongNumber, 'US');

  TooLongNumber := MakeNumber(800, '123456789');
  Assert.IsTrue(TPhoneNumberUtil.TruncateTooLongNumber(TooLongNumber));
  CheckSame(MakeNumber(800, '12345678'), TooLongNumber, '800');

  { Tests what happens when a valid number is passed in. }
  ValidNumberCopy := ValidNumber;
  Assert.IsTrue(TPhoneNumberUtil.TruncateTooLongNumber(ValidNumber));
  { Tests the number is not modified. }
  CheckSame(ValidNumberCopy, ValidNumber, 'valid number');

  { Tests what happens when a number with invalid prefix is passed in. The
    test metadata says US numbers cannot have prefix 240. }
  NumberWithInvalidPrefix := MakeNumber(1, '2401234567');
  InvalidNumberCopy := NumberWithInvalidPrefix;
  Assert.IsFalse(TPhoneNumberUtil.TruncateTooLongNumber(
    NumberWithInvalidPrefix));
  { Tests the number is not modified. }
  CheckSame(InvalidNumberCopy, NumberWithInvalidPrefix, 'invalid prefix');

  { Tests what happens when a too short number is passed in. }
  TooShortNumber := MakeNumber(1, '1234');
  TooShortNumberCopy := TooShortNumber;
  Assert.IsFalse(TPhoneNumberUtil.TruncateTooLongNumber(TooShortNumber));
  { Tests the number is not modified. }
  CheckSame(TooShortNumberCopy, TooShortNumber, 'too short');

  { Port addition (not in the Java test): the same two contracts on records
    whose context fields are filled - raw input, country code source,
    preferred carrier code and region. A successful truncation changes the
    two national number fields and nothing else; a failed one changes
    nothing. }
  Kept := ParseRawOk('+44 80123456780123', RC_GB);
  KeptCopy := Kept;
  Assert.IsTrue(TPhoneNumberUtil.TruncateTooLongNumber(Kept));
  KeptCopy.NationalNumberDigits := '8012345678';
  KeptCopy.NationalNumber := 8012345678;
  CheckSame(KeptCopy, Kept, 'GB kept raw input');
  Assert.AreEqual('+44 80123456780123', Kept.RawInput);
  Assert.AreEqual(Ord(pnccsFromNumberWithPlusSign), Ord(Kept.CountryCodeSource));

  Kept := ParseRawOk('240 123 4567', RC_US);
  KeptCopy := Kept;
  Assert.IsFalse(TPhoneNumberUtil.TruncateTooLongNumber(Kept));
  CheckSame(KeptCopy, Kept, 'US invalid prefix, kept raw input');
  Assert.AreEqual(Ord(pnccsFromDefaultCountry), Ord(Kept.CountryCodeSource));
end;

procedure TUpstreamPhoneNumberUtilTests.Test_IsAlphaNumber;
begin
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('1800 six-flags'));
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('1800 six-flags ext. 1234'));
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('+800 six-flags'));
  Assert.IsTrue(TPhoneNumberUtil.IsAlphaNumber('180 six-flags'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber('1800 123-1234'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber('1 six-flags'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber('18 six-flags'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber(
    '1800 123-1234 extension: 1234'));
  Assert.IsFalse(TPhoneNumberUtil.IsAlphaNumber('+800 1234-1234'));
end;

initialization
  TDUnitX.RegisterTestFixture(TUpstreamPhoneNumberUtilTests);

end.
