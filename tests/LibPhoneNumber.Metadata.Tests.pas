unit LibPhoneNumber.Metadata.Tests;

{
  Tests for the generated metadata tables.

  These cover the data itself and the lookup layer, not validation or
  formatting semantics; those are covered by the other test units.

  The regex dialect gate runs twice: once in the generator against .NET regex
  as a PCRE proxy, and once here against the actual Delphi engine
  (System.RegularExpressions). Both must accept every upstream pattern.
}

interface

uses
  DUnitX.TestFramework,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata.Data,
  LibPhoneNumber.Metadata.Descs,
  LibPhoneNumber.Metadata.Formats,
  LibPhoneNumber.Metadata;

type
  [TestFixture]
  TMetadataTests = class
  private
    function TryCompilePattern(const APattern: string; out AError: string): Boolean;
    function MatchesFully(const APattern, AInput: string): Boolean;
    function DescKindName(AKind: TPhoneNumberDescKind): string;
    procedure CheckExampleNumbersForRegion(const ARegionCode: string;
      var AChecked: Integer);
    procedure CheckIntlListMirrorsNationalList(const ARegionCode: string);
  public
    { Inventory }
    [Test]
    procedure TerritoryCount_MatchesPinnedUpstreamBaseline;

    [Test]
    procedure RegionsAndNonGeoEntities_AddUpToTerritoryCount;

    [Test]
    procedure MetadataProvenance_IsEmbedded;

    { Spot checks }
    [Test]
    procedure Germany_HasExpectedTerritoryAttributes;

    [Test]
    procedure UnitedStates_HasExpectedTerritoryAttributes;

    [Test]
    procedure NonGeoEntity800_IsAvailable;

    [Test]
    procedure AllNonGeoEntities_AreReachableByCallingCode;

    [Test]
    procedure UnknownRegionAndCallingCode_AreNotResolved;

    { Index integrity }
    [Test]
    procedure RegionCodes_AreOrdinallySortedAndUnique;

    [Test]
    procedure EveryGeographicalTerritory_IsResolvableByRegionCode;

    [Test]
    procedure GetSupportedRegions_ExcludesNonGeoEntities;

    [Test]
    procedure GetRegionCodesForCountryCode_PutsMainCountryFirst;

    [Test]
    procedure GetRegionCodesForCountryCode_ReturnsNonGeoIdForGlobalNetworkCode;

    [Test]
    procedure SupportedCallingCodes_CoverEveryTerritory;

    { Regex dialect gate against the Delphi engine }
    [Test]
    procedure AllNationalNumberPatterns_CompileWithDelphiRegexEngine;

    [Test]
    procedure AllNumberFormatPatterns_CompileWithDelphiRegexEngine;

    [Test]
    procedure AllLeadingDigitsPatterns_CompileWithDelphiRegexEngine;

    [Test]
    procedure AllTerritoryLevelPatterns_CompileWithDelphiRegexEngine;

    { Example numbers }
    [Test]
    procedure ExampleNumbers_MatchOwnPattern_AcrossAllContinents;

    [Test]
    procedure ExampleNumbers_MatchOwnPattern_ForAllNonGeoEntities;

    [Test]
    procedure ExampleNumbers_MatchOwnPattern_ForEveryTerritory;

    { Possible lengths }
    [Test]
    procedure GeneralDescPossibleLengths_AreNeverEmpty;

    [Test]
    procedure TypedDescs_WithoutOwnLengths_FallBackToGeneralDesc;

    [Test]
    procedure AbsentNumberTypes_UseTheNeverMatchingLength;

    [Test]
    procedure PossibleLengthSlices_StayInsideThePool;

    { Format tables }
    [Test]
    procedure FormatSlices_StayInsideTheTables;

    [Test]
    procedure IntlFormatList_IsEitherEmptyOrCarriesAnExplicitFormat;

    [Test]
    procedure NotAvailableIntlFormats_AreExcludedFromTheIntlList;

    [Test]
    procedure IntlFormatList_MirrorsNationalListMinusNotAvailable_ForEveryTerritory;

    [Test]
    procedure IntlFormatList_HasExpectedShape_ForBrazil;

    [Test]
    procedure IntlFormatList_HasExpectedShape_ForMexico;

    [Test]
    procedure IntlFormatList_KeepsExplicitFormats_ForArgentina;

    [Test]
    procedure NationalPrefixFormattingRule_IsExpandedFromNpAndFgPlaceholders;

    [Test]
    procedure NationalPrefixTransformRule_IsTakenFromUpstream;

    [Test]
    procedure DomesticCarrierCodeFormattingRule_IsExpanded_ForBrazil;
  end;

implementation

uses
  System.SysUtils,
  System.RegularExpressions;

const
  { Territory count of the pinned upstream baseline
    (vendor/libphonenumber commit recorded in MetadataSourceCommit):
    245 geographical regions plus 9 non geographical entities. }
  ExpectedTerritoryCount = 254;
  ExpectedRegionCount = 245;
  ExpectedNonGeoCount = 9;

  { A spread of regions across every continent, used for the targeted example
    number check. }
  ContinentSampleRegions: array[0..25] of string = (
    'DE', 'FR', 'GB', 'IT', 'ES', 'PL', 'SE', 'RU',
    'US', 'CA', 'MX', 'BR', 'AR', 'CL',
    'ZA', 'NG', 'EG', 'KE', 'MA',
    'JP', 'CN', 'IN', 'KR', 'TR',
    'AU', 'NZ'
  );

function TMetadataTests.TryCompilePattern(const APattern: string;
  out AError: string): Boolean;
var
  Expression: TRegEx;
begin
  AError := '';
  try
    Expression := TRegEx.Create(APattern);
    { Force the engine to materialise the compiled program. }
    Expression.IsMatch('');
    Result := True;
  except
    on E: Exception do
    begin
      AError := E.ClassName + ': ' + E.Message;
      Result := False;
    end;
  end;
end;

function TMetadataTests.MatchesFully(const APattern, AInput: string): Boolean;
begin
  { Upstream uses Matcher.matches(), i.e. the pattern must consume the whole
    input. \A .. \z anchors that without the trailing newline tolerance of $. }
  Result := TRegEx.IsMatch(AInput, '\A(?:' + APattern + ')\z');
end;

function TMetadataTests.DescKindName(AKind: TPhoneNumberDescKind): string;
begin
  case AKind of
    pdkGeneralDesc: Result := 'generalDesc';
    pdkFixedLine: Result := 'fixedLine';
    pdkMobile: Result := 'mobile';
    pdkTollFree: Result := 'tollFree';
    pdkPremiumRate: Result := 'premiumRate';
    pdkSharedCost: Result := 'sharedCost';
    pdkPersonalNumber: Result := 'personalNumber';
    pdkVoip: Result := 'voip';
    pdkPager: Result := 'pager';
    pdkUan: Result := 'uan';
    pdkVoicemail: Result := 'voicemail';
    pdkNoInternationalDialling: Result := 'noInternationalDialling';
  else
    Result := 'unknown';
  end;
end;

procedure TMetadataTests.CheckExampleNumbersForRegion(
  const ARegionCode: string; var AChecked: Integer);
var
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Kind: TPhoneNumberDescKind;
begin
  Assert.IsTrue(TryGetMetadataForRegion(ARegionCode, Metadata),
    'Sample region not found in the generated metadata: ' + ARegionCode);

  for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
  begin
    Desc := GetDesc(Metadata, Kind);
    if (Desc^.ExampleNumber = '') or (Desc^.NationalNumberPattern = '') then
      Continue;
    Inc(AChecked);
    Assert.IsTrue(MatchesFully(Desc^.NationalNumberPattern, Desc^.ExampleNumber),
      Format('Example number %s does not match the %s pattern of %s',
        [Desc^.ExampleNumber, DescKindName(Kind), Metadata^.Id]));
  end;
end;

procedure TMetadataTests.CheckIntlListMirrorsNationalList(
  const ARegionCode: string);
var
  Metadata: PPhoneMetadataRec;
  National, Intl: PNumberFormatRec;
  I, IntlIndex: Integer;
begin
  Assert.IsTrue(TryGetMetadataForRegion(ARegionCode, Metadata),
    'Region not found: ' + ARegionCode);
  Assert.IsTrue(GetIntlNumberFormatCount(Metadata) > 0,
    ARegionCode + ' is expected to carry an explicit international format list.');

  IntlIndex := 0;
  for I := 0 to GetNumberFormatCount(Metadata) - 1 do
  begin
    National := GetNumberFormat(Metadata, I);
    { "NA" drops the block from the international list entirely. }
    if National^.IntlFormatKind = ifkNotAvailable then
      Continue;

    Intl := GetIntlNumberFormat(Metadata, IntlIndex);
    Assert.IsTrue(Intl <> nil,
      Format('%s: missing international format for national block #%d.',
        [ARegionCode, I]));
    Assert.AreEqual(National^.Pattern, Intl^.Pattern,
      Format('%s: international format #%d must reuse the national pattern.',
        [ARegionCode, IntlIndex]));
    Assert.AreEqual(National^.LeadingDigitsOffset, Intl^.LeadingDigitsOffset,
      Format('%s: international format #%d must reuse the leadingDigits slice.',
        [ARegionCode, IntlIndex]));
    Assert.AreEqual(National^.LeadingDigitsCount, Intl^.LeadingDigitsCount,
      Format('%s: international format #%d must reuse the leadingDigits slice.',
        [ARegionCode, IntlIndex]));

    if National^.IntlFormatKind = ifkExplicit then
    begin
      Assert.AreEqual(National^.IntlFormat, Intl^.Format,
        Format('%s: international format #%d must use the explicit intlFormat.',
          [ARegionCode, IntlIndex]));
      { Upstream builds an explicit intl format from scratch: only pattern,
        leadingDigits and format are set, no prefix or carrier rules. }
      Assert.AreEqual('', Intl^.NationalPrefixFormattingRule,
        Format('%s: explicit international format #%d must not carry a national prefix rule.',
          [ARegionCode, IntlIndex]));
      Assert.AreEqual('', Intl^.DomesticCarrierCodeFormattingRule,
        Format('%s: explicit international format #%d must not carry a carrier rule.',
          [ARegionCode, IntlIndex]));
      Assert.IsFalse(Intl^.NationalPrefixOptionalWhenFormatting,
        Format('%s: explicit international format #%d must not inherit the optional prefix flag.',
          [ARegionCode, IntlIndex]));
    end
    else
    begin
      { No <intlFormat> child: upstream merges the national format verbatim. }
      Assert.AreEqual(National^.Format, Intl^.Format,
        Format('%s: international format #%d must copy the national format.',
          [ARegionCode, IntlIndex]));
      Assert.AreEqual(National^.NationalPrefixFormattingRule,
        Intl^.NationalPrefixFormattingRule,
        Format('%s: international format #%d must copy the national prefix rule.',
          [ARegionCode, IntlIndex]));
      Assert.AreEqual(National^.DomesticCarrierCodeFormattingRule,
        Intl^.DomesticCarrierCodeFormattingRule,
        Format('%s: international format #%d must copy the carrier rule.',
          [ARegionCode, IntlIndex]));
    end;
    Inc(IntlIndex);
  end;

  Assert.AreEqual(IntlIndex, GetIntlNumberFormatCount(Metadata),
    ARegionCode + ': international list length must be the national count minus the "NA" blocks.');
end;

procedure TMetadataTests.TerritoryCount_MatchesPinnedUpstreamBaseline;
begin
  Assert.AreEqual(ExpectedTerritoryCount, GetTerritoryCount,
    'Territory count of the generated metadata changed.');
  Assert.AreEqual(ExpectedTerritoryCount, PhoneMetadataTerritoryCount);
end;

procedure TMetadataTests.RegionsAndNonGeoEntities_AddUpToTerritoryCount;
var
  I, Regions, NonGeo: Integer;
begin
  Regions := 0;
  NonGeo := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    if GetTerritory(I)^.Id = NonGeoRegionCode then
      Inc(NonGeo)
    else
      Inc(Regions);
  end;

  Assert.AreEqual(ExpectedRegionCount, Regions, 'Geographical region count changed.');
  Assert.AreEqual(ExpectedNonGeoCount, NonGeo, 'Non geographical entity count changed.');
  Assert.AreEqual(PhoneMetadataRegionCount, Regions);
  Assert.AreEqual(PhoneMetadataNonGeoCount, NonGeo);
end;

procedure TMetadataTests.MetadataProvenance_IsEmbedded;
begin
  Assert.AreEqual('metadata-v1', MetadataVersion);
  Assert.AreEqual(40, Length(MetadataUpstreamCommit),
    'The upstream commit must be embedded as a full SHA-1.');
  Assert.AreEqual('resources/PhoneNumberMetadata.xml', MetadataSourceFile);
end;

procedure TMetadataTests.Germany_HasExpectedTerritoryAttributes;
var
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
begin
  Assert.IsTrue(TryGetMetadataForRegion('DE', Metadata), 'DE metadata missing.');
  Assert.AreEqual('DE', Metadata^.Id);
  Assert.AreEqual(49, Metadata^.CountryCode);
  Assert.AreEqual('0', Metadata^.NationalPrefix);
  Assert.AreEqual('0', Metadata^.NationalPrefixForParsing);
  Assert.AreEqual('00', Metadata^.InternationalPrefix);
  Assert.IsTrue(Metadata^.MobileNumberPortableRegion, 'DE is mobile number portable upstream.');
  Assert.IsFalse(Metadata^.SameMobileAndFixedLinePattern,
    'DE has distinct fixed line and mobile patterns.');
  Assert.IsTrue(GetNumberFormatCount(Metadata) > 0, 'DE has number formats.');

  Desc := GetDesc(Metadata, pdkMobile);
  Assert.IsTrue(Desc^.HasData, 'DE has mobile metadata.');
  Assert.IsTrue(Desc^.NationalNumberPattern <> '', 'DE mobile pattern missing.');
end;

procedure TMetadataTests.UnitedStates_HasExpectedTerritoryAttributes;
var
  Metadata: PPhoneMetadataRec;
begin
  Assert.IsTrue(TryGetMetadataForRegion('US', Metadata), 'US metadata missing.');
  Assert.AreEqual('US', Metadata^.Id);
  Assert.AreEqual(1, Metadata^.CountryCode);
  Assert.IsTrue(Metadata^.MainCountryForCode,
    'US is the main country for calling code 1.');
  Assert.AreEqual('1', Metadata^.NationalPrefix);
  Assert.IsTrue(Metadata^.SameMobileAndFixedLinePattern,
    'US uses the same pattern for fixed line and mobile.');
end;

procedure TMetadataTests.NonGeoEntity800_IsAvailable;
var
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
begin
  Assert.IsTrue(TryGetMetadataForNonGeoEntity(800, Metadata),
    'Non geographical entity 800 missing.');
  Assert.AreEqual(NonGeoRegionCode, Metadata^.Id);
  Assert.AreEqual(800, Metadata^.CountryCode);
  Assert.IsTrue(IsSupportedGlobalNetworkCallingCode(800));
  Assert.IsFalse(IsSupportedRegion(NonGeoRegionCode),
    'The non geo placeholder id must not be a supported region.');

  Desc := GetDesc(Metadata, pdkTollFree);
  Assert.IsTrue(Desc^.HasData, '800 must carry toll free metadata.');
end;

procedure TMetadataTests.AllNonGeoEntities_AreReachableByCallingCode;
var
  Codes: TMetadataIntegerArray;
  Metadata: PPhoneMetadataRec;
  I: Integer;
begin
  Codes := GetSupportedGlobalNetworkCallingCodes;
  Assert.AreEqual(ExpectedNonGeoCount, Integer(Length(Codes)));
  for I := 0 to High(Codes) do
  begin
    Assert.IsTrue(TryGetMetadataForNonGeoEntity(Codes[I], Metadata),
      Format('Non geo entity %d not resolvable.', [Codes[I]]));
    Assert.AreEqual(NonGeoRegionCode, Metadata^.Id);
    Assert.AreEqual(Codes[I], Metadata^.CountryCode);
    if I > 0 then
      Assert.IsTrue(Codes[I] > Codes[I - 1], 'Non geo calling codes must be ascending.');
  end;
end;

procedure TMetadataTests.UnknownRegionAndCallingCode_AreNotResolved;
var
  Metadata: PPhoneMetadataRec;
begin
  Assert.IsFalse(TryGetMetadataForRegion('ZZ', Metadata));
  Assert.IsTrue(Metadata = nil, 'A failed lookup must return nil.');
  Assert.IsFalse(TryGetMetadataForRegion('', Metadata));
  Assert.IsFalse(TryGetMetadataForRegion('de', Metadata),
    'Region lookup is case sensitive, like upstream.');
  Assert.IsFalse(TryGetMetadataForNonGeoEntity(49, Metadata));
  Assert.IsFalse(IsSupportedCallingCode(9999));
  Assert.AreEqual(0, GetCountryCodeForRegion('ZZ'));
  Assert.AreEqual(49, GetCountryCodeForRegion('DE'));
end;

procedure TMetadataTests.RegionCodes_AreOrdinallySortedAndUnique;
var
  I: Integer;
begin
  for I := 1 to PhoneMetadataRegionCount - 1 do
    Assert.IsTrue(
      CompareStr(PhoneMetadataRegionCodes[I - 1], PhoneMetadataRegionCodes[I]) < 0,
      Format('Region code index is not strictly ascending at %d (%s / %s).',
        [I, PhoneMetadataRegionCodes[I - 1], PhoneMetadataRegionCodes[I]]));
end;

procedure TMetadataTests.EveryGeographicalTerritory_IsResolvableByRegionCode;
var
  I: Integer;
  Territory, Resolved: PPhoneMetadataRec;
begin
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    if Territory^.Id = NonGeoRegionCode then
      Continue;
    Assert.IsTrue(TryGetMetadataForRegion(Territory^.Id, Resolved),
      'Region not resolvable: ' + Territory^.Id);
    Assert.AreEqual(Territory^.Id, Resolved^.Id);
    Assert.AreEqual(Territory^.CountryCode, Resolved^.CountryCode);
  end;
end;

procedure TMetadataTests.GetSupportedRegions_ExcludesNonGeoEntities;
var
  Regions: TMetadataStringArray;
  I: Integer;
begin
  Regions := GetSupportedRegions;
  Assert.AreEqual(ExpectedRegionCount, Integer(Length(Regions)));
  for I := 0 to High(Regions) do
    Assert.AreNotEqual(NonGeoRegionCode, Regions[I]);
  Assert.IsTrue(IsSupportedRegion('DE'));
  Assert.IsTrue(IsSupportedRegion('US'));
end;

procedure TMetadataTests.GetRegionCodesForCountryCode_PutsMainCountryFirst;
var
  Regions: TMetadataStringArray;
begin
  Regions := GetRegionCodesForCountryCode(1);
  Assert.IsTrue(Length(Regions) > 1, 'Calling code 1 is shared by many regions.');
  Assert.AreEqual('US', Regions[0], 'The main country for code 1 must come first.');

  Regions := GetRegionCodesForCountryCode(49);
  Assert.AreEqual(1, Integer(Length(Regions)));
  Assert.AreEqual('DE', Regions[0]);

  Regions := GetRegionCodesForCountryCode(44);
  Assert.IsTrue(Length(Regions) > 1, 'Calling code 44 is shared.');
  Assert.AreEqual('GB', Regions[0]);

  Regions := GetRegionCodesForCountryCode(9999);
  Assert.AreEqual(0, Integer(Length(Regions)));
end;

procedure TMetadataTests.GetRegionCodesForCountryCode_ReturnsNonGeoIdForGlobalNetworkCode;
var
  Regions: TMetadataStringArray;
begin
  Regions := GetRegionCodesForCountryCode(800);
  Assert.AreEqual(1, Integer(Length(Regions)));
  Assert.AreEqual(NonGeoRegionCode, Regions[0]);
end;

procedure TMetadataTests.SupportedCallingCodes_CoverEveryTerritory;
var
  Codes: TMetadataIntegerArray;
  I: Integer;
begin
  Codes := GetSupportedCallingCodes;
  Assert.AreEqual(PhoneMetadataCountryCodeCount, Integer(Length(Codes)));
  for I := 1 to High(Codes) do
    Assert.IsTrue(Codes[I] > Codes[I - 1], 'Calling code index must be ascending.');
  for I := 0 to GetTerritoryCount - 1 do
    Assert.IsTrue(IsSupportedCallingCode(GetTerritory(I)^.CountryCode),
      Format('Calling code %d of %s is missing from the index.',
        [GetTerritory(I)^.CountryCode, GetTerritory(I)^.Id]));
end;

procedure TMetadataTests.AllNationalNumberPatterns_CompileWithDelphiRegexEngine;
var
  I, Compiled: Integer;
  Error: string;
begin
  Compiled := 0;
  for I := 0 to PhoneMetadataDescCount - 1 do
  begin
    if PhoneMetadataDescs[I].NationalNumberPattern = '' then
      Continue;
    Assert.IsTrue(
      TryCompilePattern(PhoneMetadataDescs[I].NationalNumberPattern, Error),
      Format('nationalNumberPattern #%d does not compile: %s (%s)',
        [I, PhoneMetadataDescs[I].NationalNumberPattern, Error]));
    Inc(Compiled);
  end;
  Assert.AreEqual(1431, Compiled,
    'Number of national number patterns in the pinned baseline changed.');
end;

procedure TMetadataTests.AllNumberFormatPatterns_CompileWithDelphiRegexEngine;
var
  I: Integer;
  Error: string;
begin
  for I := 0 to PhoneMetadataNumberFormatCount - 1 do
    Assert.IsTrue(TryCompilePattern(PhoneMetadataNumberFormats[I].Pattern, Error),
      Format('numberFormat pattern #%d does not compile: %s (%s)',
        [I, PhoneMetadataNumberFormats[I].Pattern, Error]));

  for I := 0 to PhoneMetadataIntlNumberFormatCount - 1 do
    Assert.IsTrue(TryCompilePattern(PhoneMetadataIntlNumberFormats[I].Pattern, Error),
      Format('intl numberFormat pattern #%d does not compile: %s (%s)',
        [I, PhoneMetadataIntlNumberFormats[I].Pattern, Error]));
end;

procedure TMetadataTests.AllLeadingDigitsPatterns_CompileWithDelphiRegexEngine;
var
  I: Integer;
  Error: string;
begin
  for I := 0 to PhoneMetadataLeadingDigitsCount - 1 do
    Assert.IsTrue(TryCompilePattern(PhoneMetadataLeadingDigits[I], Error),
      Format('leadingDigits pattern #%d does not compile: %s (%s)',
        [I, PhoneMetadataLeadingDigits[I], Error]));
end;

procedure TMetadataTests.AllTerritoryLevelPatterns_CompileWithDelphiRegexEngine;
var
  I: Integer;
  Territory: PPhoneMetadataRec;
  Error: string;
begin
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    if Territory^.LeadingDigits <> '' then
      Assert.IsTrue(TryCompilePattern(Territory^.LeadingDigits, Error),
        Format('%s leadingDigits does not compile: %s (%s)',
          [Territory^.Id, Territory^.LeadingDigits, Error]));
    if Territory^.InternationalPrefix <> '' then
      Assert.IsTrue(TryCompilePattern(Territory^.InternationalPrefix, Error),
        Format('%s internationalPrefix does not compile: %s (%s)',
          [Territory^.Id, Territory^.InternationalPrefix, Error]));
    if Territory^.NationalPrefixForParsing <> '' then
      Assert.IsTrue(TryCompilePattern(Territory^.NationalPrefixForParsing, Error),
        Format('%s nationalPrefixForParsing does not compile: %s (%s)',
          [Territory^.Id, Territory^.NationalPrefixForParsing, Error]));
  end;
end;

procedure TMetadataTests.ExampleNumbers_MatchOwnPattern_AcrossAllContinents;
var
  I, Checked: Integer;
begin
  Checked := 0;
  for I := Low(ContinentSampleRegions) to High(ContinentSampleRegions) do
    CheckExampleNumbersForRegion(ContinentSampleRegions[I], Checked);

  Assert.IsTrue(Integer(Length(ContinentSampleRegions)) >= 20,
    'The continent sample must cover at least 20 regions.');
  Assert.IsTrue(Checked >= Integer(Length(ContinentSampleRegions)),
    Format('Expected at least one example number per sample region, checked %d.',
      [Checked]));
end;

procedure TMetadataTests.ExampleNumbers_MatchOwnPattern_ForAllNonGeoEntities;
var
  Codes: TMetadataIntegerArray;
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Kind: TPhoneNumberDescKind;
  I, Checked: Integer;
begin
  Checked := 0;
  Codes := GetSupportedGlobalNetworkCallingCodes;
  for I := 0 to High(Codes) do
  begin
    Assert.IsTrue(TryGetMetadataForNonGeoEntity(Codes[I], Metadata));
    for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
    begin
      Desc := GetDesc(Metadata, Kind);
      if (Desc^.ExampleNumber = '') or (Desc^.NationalNumberPattern = '') then
        Continue;
      Inc(Checked);
      Assert.IsTrue(MatchesFully(Desc^.NationalNumberPattern, Desc^.ExampleNumber),
        Format('Example number %s does not match the %s pattern of non geo %d',
          [Desc^.ExampleNumber, DescKindName(Kind), Codes[I]]));
    end;
  end;
  Assert.IsTrue(Checked >= Integer(Length(Codes)),
    'Every non geographical entity should carry at least one example number.');
end;

procedure TMetadataTests.ExampleNumbers_MatchOwnPattern_ForEveryTerritory;
var
  I, Checked: Integer;
  Desc: PPhoneNumberDescRec;
begin
  Checked := 0;
  for I := 0 to PhoneMetadataDescCount - 1 do
  begin
    Desc := @PhoneMetadataDescs[I];
    if (Desc^.ExampleNumber = '') or (Desc^.NationalNumberPattern = '') then
      Continue;
    Inc(Checked);
    Assert.IsTrue(MatchesFully(Desc^.NationalNumberPattern, Desc^.ExampleNumber),
      Format('Example number %s (desc #%d) does not match its own pattern.',
        [Desc^.ExampleNumber, I]));
  end;
  Assert.AreEqual(1144, Checked,
    'Number of example numbers in the pinned baseline changed.');
end;

procedure TMetadataTests.GeneralDescPossibleLengths_AreNeverEmpty;
var
  I: Integer;
  Territory: PPhoneMetadataRec;
  Lengths: TMetadataIntegerArray;
begin
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    Lengths := GetPossibleLengths(GetDesc(Territory, pdkGeneralDesc));
    Assert.IsTrue(Integer(Length(Lengths)) > 0,
      Format('Territory %s (cc %d) has an empty general description length set.',
        [Territory^.Id, Territory^.CountryCode]));
    Assert.IsTrue(Lengths[0] > 0,
      Format('Territory %s has a non positive general description length.',
        [Territory^.Id]));
  end;
end;

procedure TMetadataTests.TypedDescs_WithoutOwnLengths_FallBackToGeneralDesc;
var
  Metadata: PPhoneMetadataRec;
  Desc, GeneralDesc: PPhoneNumberDescRec;
  Effective, General, LocalOnly, GeneralLocalOnly: TMetadataIntegerArray;
  Kind: TPhoneNumberDescKind;
  I, N, Fallbacks, DivergingLocalOnly: Integer;
begin
  Fallbacks := 0;
  DivergingLocalOnly := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Metadata := GetTerritory(I);
    GeneralDesc := GetDesc(Metadata, pdkGeneralDesc);
    General := GetPossibleLengths(GeneralDesc);
    GeneralLocalOnly := GetPossibleLengthsLocalOnly(GeneralDesc);

    for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
    begin
      Desc := GetDesc(Metadata, Kind);
      if (Kind = pdkGeneralDesc) or (Desc^.LengthCount <> 0) then
        Continue;
      Inc(Fallbacks);

      Effective := GetEffectivePossibleLengths(Metadata, Kind);
      Assert.AreEqual(Integer(Length(General)), Integer(Length(Effective)),
        Format('%s/%s must inherit the general description lengths.',
          [Metadata^.Id, DescKindName(Kind)]));
      for N := 0 to High(General) do
        Assert.AreEqual(General[N], Effective[N],
          Format('%s/%s inherited length #%d differs from the general description (%d vs %d).',
            [Metadata^.Id, DescKindName(Kind), N, General[N], Effective[N]]));

      { The length fallback must not drag the local-only lengths along: those
        are stored per description and are never inherited upstream. }
      LocalOnly := GetPossibleLengthsLocalOnly(Desc);
      Assert.AreEqual(Desc^.LocalOnlyCount, Integer(Length(LocalOnly)),
        Format('%s/%s local-only lengths must come from the description itself.',
          [Metadata^.Id, DescKindName(Kind)]));
      for N := 0 to High(LocalOnly) do
        Assert.AreEqual(
          Integer(PhoneMetadataPossibleLengths[Desc^.LocalOnlyOffset + N]),
          LocalOnly[N],
          Format('%s/%s local-only length #%d is not read from its own slice.',
            [Metadata^.Id, DescKindName(Kind), N]));

      if Integer(Length(LocalOnly)) <> Integer(Length(GeneralLocalOnly)) then
        Inc(DivergingLocalOnly);
    end;
  end;
  Assert.IsTrue(Fallbacks > 0,
    'The upstream size optimisation (empty length list) must be present.');
  Assert.IsTrue(DivergingLocalOnly > 0,
    Format('Expected descriptions that inherit lengths but keep their own local-only set, found %d.',
      [DivergingLocalOnly]));
end;

procedure TMetadataTests.AbsentNumberTypes_UseTheNeverMatchingLength;
var
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Lengths: TMetadataIntegerArray;
  Kind: TPhoneNumberDescKind;
  I, Absent: Integer;
begin
  Absent := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Metadata := GetTerritory(I);
    for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
    begin
      Desc := GetDesc(Metadata, Kind);
      if Desc^.HasData then
        Continue;
      Inc(Absent);
      Lengths := GetPossibleLengths(Desc);
      Assert.AreEqual(1, Integer(Length(Lengths)),
        Format('%s/%s is absent and must carry exactly one possible length.',
          [Metadata^.Id, DescKindName(Kind)]));
      Assert.AreEqual(NoPossibleLength, Lengths[0],
        Format('%s/%s is absent and must use the never matching length.',
          [Metadata^.Id, DescKindName(Kind)]));
      Assert.AreEqual('', Desc^.NationalNumberPattern);
    end;
  end;
  Assert.IsTrue(Absent > 0, 'Some number types are absent in upstream metadata.');
end;

procedure TMetadataTests.PossibleLengthSlices_StayInsideThePool;
var
  I: Integer;
  Desc: PPhoneNumberDescRec;
begin
  for I := 0 to PhoneMetadataDescCount - 1 do
  begin
    Desc := @PhoneMetadataDescs[I];
    Assert.IsTrue(Desc^.LengthOffset + Desc^.LengthCount <= PhoneMetadataPossibleLengthCount,
      Format('Length slice of desc #%d exceeds the pool.', [I]));
    Assert.IsTrue(Desc^.LocalOnlyOffset + Desc^.LocalOnlyCount <= PhoneMetadataPossibleLengthCount,
      Format('Local-only slice of desc #%d exceeds the pool.', [I]));
  end;
end;

procedure TMetadataTests.FormatSlices_StayInsideTheTables;
var
  I, J: Integer;
  Territory: PPhoneMetadataRec;
  NumberFormat: PNumberFormatRec;
begin
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    Assert.IsTrue(Territory^.DescOffset + PhoneNumberDescKindCount <= PhoneMetadataDescCount,
      'Description slice exceeds the desc table for ' + Territory^.Id);
    Assert.IsTrue(
      Territory^.FormatOffset + Territory^.FormatCount <= PhoneMetadataNumberFormatCount,
      'Format slice exceeds the format table for ' + Territory^.Id);
    Assert.IsTrue(
      Territory^.IntlFormatOffset + Territory^.IntlFormatCount <= PhoneMetadataIntlNumberFormatCount,
      'Intl format slice exceeds the intl format table for ' + Territory^.Id);

    for J := 0 to GetNumberFormatCount(Territory) - 1 do
    begin
      NumberFormat := GetNumberFormat(Territory, J);
      Assert.IsTrue(NumberFormat <> nil);
      Assert.IsTrue(NumberFormat^.Format <> '',
        Format('%s numberFormat #%d has an empty format string.', [Territory^.Id, J]));
      Assert.IsTrue(
        NumberFormat^.LeadingDigitsOffset + NumberFormat^.LeadingDigitsCount <= PhoneMetadataLeadingDigitsCount,
        'leadingDigits slice exceeds the pool for ' + Territory^.Id);
      Assert.AreEqual(NumberFormat^.LeadingDigitsCount,
        Integer(Length(GetLeadingDigitsPatterns(NumberFormat))));
    end;
  end;
end;

procedure TMetadataTests.IntlFormatList_IsEitherEmptyOrCarriesAnExplicitFormat;
var
  I, J, WithIntl: Integer;
  Territory: PPhoneMetadataRec;
  HasExplicit: Boolean;
begin
  WithIntl := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    if Territory^.IntlFormatCount = 0 then
      Continue;
    Inc(WithIntl);

    { Upstream keeps the intl list only when at least one numberFormat block
      declares an explicit <intlFormat>. }
    HasExplicit := False;
    for J := 0 to GetNumberFormatCount(Territory) - 1 do
      if GetNumberFormat(Territory, J)^.IntlFormatKind <> ifkInheritedFromNational then
        HasExplicit := True;
    Assert.IsTrue(HasExplicit,
      'Territory ' + Territory^.Id + ' carries an intl format list without an explicit intlFormat.');
  end;
  Assert.IsTrue(WithIntl > 0, 'Some territories declare explicit international formats.');
end;

procedure TMetadataTests.NotAvailableIntlFormats_AreExcludedFromTheIntlList;
var
  I, J, NotAvailable: Integer;
  Territory: PPhoneMetadataRec;
begin
  NotAvailable := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    for J := 0 to GetNumberFormatCount(Territory) - 1 do
      if GetNumberFormat(Territory, J)^.IntlFormatKind = ifkNotAvailable then
      begin
        Inc(NotAvailable);
        Assert.AreEqual('', GetNumberFormat(Territory, J)^.IntlFormat,
          'An "NA" intlFormat must not carry a format string.');
      end;

    { "NA" entries are dropped, so the intl list is shorter than the national
      one whenever such an entry exists. }
    if Territory^.IntlFormatCount > 0 then
      Assert.IsTrue(Territory^.IntlFormatCount <= Territory^.FormatCount,
        'Intl format list must not be longer than the national one for ' + Territory^.Id);
  end;
  Assert.IsTrue(NotAvailable > 0,
    'The upstream baseline contains intlFormat="NA" entries.');
end;

procedure TMetadataTests.IntlFormatList_MirrorsNationalListMinusNotAvailable_ForEveryTerritory;
var
  I, Checked: Integer;
  Territory: PPhoneMetadataRec;
begin
  Checked := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    if Territory^.IntlFormatCount = 0 then
      Continue;
    Inc(Checked);
    CheckIntlListMirrorsNationalList(Territory^.Id);
  end;
  Assert.IsTrue(Checked > 0,
    'Some territories must carry an explicit international format list.');
end;

procedure TMetadataTests.IntlFormatList_HasExpectedShape_ForBrazil;
var
  Metadata: PPhoneMetadataRec;
begin
  { BR: 7 national blocks, three of them intlFormat="NA" (indices 0, 2 and 4),
    none with an explicit intlFormat, so the international list is the
    remaining four blocks in order. }
  Assert.IsTrue(TryGetMetadataForRegion('BR', Metadata));
  Assert.AreEqual(7, GetNumberFormatCount(Metadata));
  Assert.AreEqual(4, GetIntlNumberFormatCount(Metadata));

  Assert.IsTrue(GetNumberFormat(Metadata, 0)^.IntlFormatKind = ifkNotAvailable);
  Assert.IsTrue(GetNumberFormat(Metadata, 2)^.IntlFormatKind = ifkNotAvailable);
  Assert.IsTrue(GetNumberFormat(Metadata, 4)^.IntlFormatKind = ifkNotAvailable);

  Assert.AreEqual('(\d{4})(\d{4})', GetIntlNumberFormat(Metadata, 0)^.Pattern);
  Assert.AreEqual('$1-$2', GetIntlNumberFormat(Metadata, 0)^.Format);
  Assert.AreEqual('(\d{3})(\d{2,3})(\d{4})', GetIntlNumberFormat(Metadata, 1)^.Pattern);
  Assert.AreEqual('(\d{2})(\d{4})(\d{4})', GetIntlNumberFormat(Metadata, 2)^.Pattern);
  Assert.AreEqual('(\d{2})(\d{5})(\d{4})', GetIntlNumberFormat(Metadata, 3)^.Pattern);

  CheckIntlListMirrorsNationalList('BR');
end;

procedure TMetadataTests.IntlFormatList_HasExpectedShape_ForMexico;
var
  Metadata: PPhoneMetadataRec;
begin
  { MX: 3 national blocks, the first one is intlFormat="NA". }
  Assert.IsTrue(TryGetMetadataForRegion('MX', Metadata));
  Assert.AreEqual(3, GetNumberFormatCount(Metadata));
  Assert.AreEqual(2, GetIntlNumberFormatCount(Metadata));
  Assert.IsTrue(GetNumberFormat(Metadata, 0)^.IntlFormatKind = ifkNotAvailable);
  Assert.AreEqual('(\d{5})', GetNumberFormat(Metadata, 0)^.Pattern);
  Assert.AreEqual('(\d{2})(\d{4})(\d{4})', GetIntlNumberFormat(Metadata, 0)^.Pattern);
  Assert.AreEqual('(\d{3})(\d{3})(\d{4})', GetIntlNumberFormat(Metadata, 1)^.Pattern);

  CheckIntlListMirrorsNationalList('MX');
end;

procedure TMetadataTests.IntlFormatList_KeepsExplicitFormats_ForArgentina;
var
  Metadata: PPhoneMetadataRec;
begin
  { AR mixes all three cases: 4 blocks with intlFormat="NA" (indices 0-3),
    3 blocks with an explicit intlFormat (indices 8, 9 and 11) and 5 inherited
    ones, so the international list has 12 - 4 = 8 entries. }
  Assert.IsTrue(TryGetMetadataForRegion('AR', Metadata));
  Assert.AreEqual(12, GetNumberFormatCount(Metadata));
  Assert.AreEqual(8, GetIntlNumberFormatCount(Metadata));

  Assert.IsTrue(GetNumberFormat(Metadata, 0)^.IntlFormatKind = ifkNotAvailable);
  Assert.IsTrue(GetNumberFormat(Metadata, 4)^.IntlFormatKind = ifkInheritedFromNational);
  Assert.IsTrue(GetNumberFormat(Metadata, 8)^.IntlFormatKind = ifkExplicit);
  Assert.AreEqual('$2 15-$3-$4', GetNumberFormat(Metadata, 8)^.Format);
  Assert.AreEqual('$1 $2 $3-$4', GetNumberFormat(Metadata, 8)^.IntlFormat);

  { Intl entry 0 comes from national block 4 (inherited, keeps its prefix rule). }
  Assert.AreEqual('$1 $2-$3', GetIntlNumberFormat(Metadata, 0)^.Format);
  Assert.AreEqual('0$1', GetIntlNumberFormat(Metadata, 0)^.NationalPrefixFormattingRule);

  { Intl entry 4 comes from national block 8 (explicit, built from scratch). }
  Assert.AreEqual('$1 $2 $3-$4', GetIntlNumberFormat(Metadata, 4)^.Format);
  Assert.AreEqual('', GetIntlNumberFormat(Metadata, 4)^.NationalPrefixFormattingRule);

  CheckIntlListMirrorsNationalList('AR');
end;

procedure TMetadataTests.NationalPrefixFormattingRule_IsExpandedFromNpAndFgPlaceholders;
var
  Metadata: PPhoneMetadataRec;
begin
  { DE declares nationalPrefixFormattingRule="$NP$FG" with nationalPrefix="0",
    so $NP expands to the national prefix and $FG to the first group. }
  Assert.IsTrue(TryGetMetadataForRegion('DE', Metadata));
  Assert.AreEqual('0', Metadata^.NationalPrefix);
  Assert.AreEqual(19, GetNumberFormatCount(Metadata));
  Assert.AreEqual('0$1', GetNumberFormat(Metadata, 0)^.NationalPrefixFormattingRule);
  Assert.AreEqual('(\d{2})(\d{3,13})', GetNumberFormat(Metadata, 0)^.Pattern);
  Assert.AreEqual('$1 $2', GetNumberFormat(Metadata, 0)^.Format);

  { Block 1 carries no rule of its own and DE declares no territory level
    default, so it must stay empty instead of inheriting from a sibling. }
  Assert.AreEqual('', GetNumberFormat(Metadata, 1)^.NationalPrefixFormattingRule);
  Assert.AreEqual('(\d{6})', GetNumberFormat(Metadata, 1)^.Pattern);

  { IT has no national prefix at all, so no block carries a prefix rule. }
  Assert.IsTrue(TryGetMetadataForRegion('IT', Metadata));
  Assert.AreEqual('', Metadata^.NationalPrefix);
  Assert.AreEqual('', GetNumberFormat(Metadata, 0)^.NationalPrefixFormattingRule);
end;

procedure TMetadataTests.NationalPrefixTransformRule_IsTakenFromUpstream;
var
  Metadata: PPhoneMetadataRec;
begin
  { Upstream runs the attribute through validateRE without stripping
    whitespace, so the value reaches the tables unchanged. }
  Assert.IsTrue(TryGetMetadataForRegion('AR', Metadata));
  Assert.AreEqual('9$1', Metadata^.NationalPrefixTransformRule);
  Assert.AreNotEqual('', Metadata^.NationalPrefixForParsing);

  Assert.IsTrue(TryGetMetadataForRegion('BR', Metadata));
  Assert.AreEqual('$2', Metadata^.NationalPrefixTransformRule);

  Assert.IsTrue(TryGetMetadataForRegion('SM', Metadata));
  Assert.AreEqual('0549$1', Metadata^.NationalPrefixTransformRule);

  { Without nationalPrefixForParsing there is no transform rule either. }
  Assert.IsTrue(TryGetMetadataForRegion('DE', Metadata));
  Assert.AreEqual('', Metadata^.NationalPrefixTransformRule);
end;

procedure TMetadataTests.DomesticCarrierCodeFormattingRule_IsExpanded_ForBrazil;
var
  Metadata: PPhoneMetadataRec;
begin
  { BR blocks 5 and 6 declare carrierCodeFormattingRule="$NP $CC ($FG)".
    Upstream replaces the first $FG with $1 and then the first $NP with the
    national prefix, leaving $CC for the runtime. }
  Assert.IsTrue(TryGetMetadataForRegion('BR', Metadata));
  Assert.AreEqual('0', Metadata^.NationalPrefix);
  Assert.AreEqual('0 $CC ($1)',
    GetNumberFormat(Metadata, 5)^.DomesticCarrierCodeFormattingRule);
  Assert.AreEqual('0 $CC ($1)',
    GetNumberFormat(Metadata, 6)^.DomesticCarrierCodeFormattingRule);
  { Blocks without the attribute stay empty (BR has no territory level rule). }
  Assert.AreEqual('', GetNumberFormat(Metadata, 0)^.DomesticCarrierCodeFormattingRule);
end;

initialization
  TDUnitX.RegisterTestFixture(TMetadataTests);

end.
