unit LibPhoneNumber.ShortNumberInfo.Tests;

{
  Tests for the generated short number metadata and for the ShortNumberInfo
  port.

  Where the expected values come from
  -----------------------------------
  The test IDEAS are taken from upstream
  java/libphonenumber/test/com/google/i18n/phonenumbers/ShortNumberInfoTest.java,
  the expected VALUES are NOT - and the reason is not the obvious one. There is
  no ShortNumberMetadataForTesting.xml upstream, so that suite reads the very
  same shipped ShortNumberMetadata.xml this port generates from. What differs
  is the PHONE metadata behind it: ShortNumberInfoTest extends
  TestMetadataTestCase, so getRegionCodesForCountryCode - which decides which
  regions of a calling code a number is checked against - answers from the TEST
  data set there and from the production one here. Its values are therefore
  usable only inside a testing-metadata fixture, which is what
  tests/LibPhoneNumber.UpstreamSuite.ShortNumber.Tests.pas is.

  Every expected value below was therefore recomputed with the NuGet oracle
  (libphonenumber-csharp 9.0.38, the metadata release matching the pinned Java
  baseline, see AGENTS.md "Reference Oracle") through
  [PhoneNumbers.ShortNumberInfo]::GetInstance(), and the oracle answer is
  recorded next to each group of cases.

  Input convention
  ----------------
  LibPhoneNumber.ShortNumberInfo takes the pair
  (country calling code, national significant number) where upstream takes a
  PhoneNumber, so every case below records the (cc, nsn) the oracle read off
  its parsed PhoneNumber via GetNationalSignificantNumber.
}

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
  LibPhoneNumber.TestFramework,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.ShortMetadata.Data,
  LibPhoneNumber.ShortMetadata.Descs,
  LibPhoneNumber.ShortMetadata,
  LibPhoneNumber.ShortNumberInfo;

type
  TShortNumberInfoTests = class(TTestCase)
  private
    function CostName(ACost: TShortNumberCost): string;
    procedure CheckCost(ACountryCode: Integer; const ANationalNumber,
      ARegion: string; AExpected: TShortNumberCost);
  published
    { --- generated short number metadata ------------------------------- }
    procedure ShortMetadataProvenance_IsEmbedded;

    procedure ShortMetadataInventory_MatchesPinnedUpstreamBaseline;

    procedure ShortRegionCodes_AreOrdinallySortedAndUnique;

    procedure EveryShortTerritory_IsResolvableByRegionCode;

    procedure UnknownRegions_HaveNoShortMetadata;

    procedure ShortCodeLengths_AreAlwaysInheritedFromTheGeneralDesc;

    procedure TypedDescLengths_AreCoveredByTheGeneralDesc;

    procedure ShortMetadataTableStructure_IsInternallyConsistent;

    procedure AbsentDescriptions_UseTheUpstreamMinusOneEncoding;

    procedure ShortNumberPatterns_CompileWithTheDelphiEngine;

    { --- ShortNumberInfo ----------------------------------------------- }
    procedure IsEmergencyNumber_MatchesExactlyInSeveralRegions;

    procedure ConnectsToEmergencyNumber_AllowsAppendedDigits;

    procedure ConnectsToEmergencyNumber_IsExactInBrazilChileAndNicaragua;

    procedure EmergencyNumbers_RejectALeadingPlusAndUnknownRegions;

    procedure EmergencyNumbers_TolerateFormattingCharacters;

    procedure RegionArguments_AreCanonicalised;

    procedure IsPossibleShortNumber_IsMoreLenientThanIsValid;

    procedure IsPossibleShortNumber_IsTheUnionOverAllRegionsOfTheCallingCode;

    procedure ShortNumbers_AreOnlyPossibleInTheirOwnCallingCode;

    procedure GetExpectedCostForRegion_CoversAllFourCostCategories;

    procedure GetExpectedCostForRegion_TreatsEmergencyNumbersAsTollFree;

    procedure GetExpectedCost_MergesTheRegionsOfASharedCallingCode;

    procedure GetExpectedCost_IsUnknownForAnUnknownCallingCode;

    procedure SharedCallingCode_IsValidInAnyOfItsRegions;

    procedure IsCarrierSpecific_FollowsTheCarrierSpecificDescription;

    procedure IsSmsServiceForRegion_FollowsTheSmsServicesDescription;

    procedure ExampleShortNumbers_AreReadOffTheMetadata;

    { --- mass gate ------------------------------------------------------ }
    procedure EveryShortCodeExampleNumber_IsAValidShortNumberInItsRegion;
  end;

implementation

uses
  SysUtils,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.Regex;

const
  { Pinned baseline of the generated tables, see the generator summary of
    tools/generate_metadata.ps1:
      241 territories x 8 description kinds = 1928 descriptions,
      961 of them with an example number.
    961 is 1062 exampleNumber elements in the XML minus the 101 that belong to
    expandedEmergency, which upstream BuildMetadataFromXml does not read. }
  ExpectedShortTerritoryCount = 241;
  ExpectedShortDescCount = 1928;
  ExpectedShortExampleCount = 961;
  ExpectedShortPossibleLengthCount = 149;

function TShortNumberInfoTests.CostName(ACost: TShortNumberCost): string;
begin
  Result := ShortNumberCostToString(ACost);
end;

procedure TShortNumberInfoTests.CheckCost(ACountryCode: Integer;
  const ANationalNumber, ARegion: string; AExpected: TShortNumberCost);
begin
  Assert.AreEqual(CostName(AExpected),
    CostName(GetExpectedCostForRegion(ACountryCode, ANationalNumber, ARegion)),
    Format('getExpectedCostForRegion(+%d %s, %s)',
      [ACountryCode, ANationalNumber, ARegion]));
end;

{ ---------------------------------------------------------------------------
  Generated short number metadata
  --------------------------------------------------------------------------- }

procedure TShortNumberInfoTests.ShortMetadataProvenance_IsEmbedded;
begin
  Assert.AreEqual('short-metadata-v1', ShortMetadataVersion);
  Assert.AreEqual('resources/ShortNumberMetadata.xml', ShortMetadataSourceFileName);
  Assert.AreEqual(40, Length(ShortMetadataUpstreamCommit),
    'The upstream commit must be embedded as a full SHA-1.');
  { Both tables are generated from the same pinned vendor checkout. }
  Assert.AreEqual(MetadataUpstreamCommit, ShortMetadataUpstreamCommit,
    'Short number and phone metadata must come from the same vendor commit.');
end;

procedure TShortNumberInfoTests.ShortMetadataInventory_MatchesPinnedUpstreamBaseline;
var
  I, Examples: Integer;
begin
  Assert.AreEqual(ExpectedShortTerritoryCount, GetShortTerritoryCount);
  Assert.AreEqual(ExpectedShortTerritoryCount, ShortMetadataTerritoryCount);
  Assert.AreEqual(ExpectedShortDescCount, ShortMetadataDescCount);
  Assert.AreEqual(ExpectedShortPossibleLengthCount, ShortMetadataPossibleLengthCount);
  Assert.AreEqual(ShortMetadataTerritoryCount * ShortNumberDescKindCount,
    ShortMetadataDescCount,
    'Every territory must carry exactly one description per short number kind.');

  Examples := 0;
  for I := 0 to ShortMetadataDescCount - 1 do
    if ShortMetadataDescs[I].ExampleNumber <> '' then
      Inc(Examples);
  Assert.AreEqual(ExpectedShortExampleCount, Examples,
    'Number of short number example numbers changed.');
end;

procedure TShortNumberInfoTests.ShortRegionCodes_AreOrdinallySortedAndUnique;
var
  I: Integer;
begin
  for I := 1 to ShortMetadataTerritoryCount - 1 do
    Assert.IsTrue(CompareStr(ShortMetadataRegionCodes[I - 1],
      ShortMetadataRegionCodes[I]) < 0,
      Format('Region codes must be ordinally sorted and unique: %s / %s',
        [ShortMetadataRegionCodes[I - 1], ShortMetadataRegionCodes[I]]));
end;

procedure TShortNumberInfoTests.EveryShortTerritory_IsResolvableByRegionCode;
var
  I: Integer;
  Territory, Found: PShortMetadataRec;
begin
  for I := 0 to ShortMetadataTerritoryCount - 1 do
  begin
    Territory := GetShortTerritory(I);
    Assert.IsTrue(Territory <> nil);
    Assert.IsTrue(TryGetShortMetadataForRegion(Territory^.Id, Found),
      'Territory not reachable by region code: ' + Territory^.Id);
    Assert.AreEqual(Territory^.Id, Found^.Id);
    Assert.AreEqual(Territory^.DescOffset, Found^.DescOffset);

    { Short number metadata has no calling code of its own; the region must be
      known to the PHONE metadata, which is where ShortNumberInfo takes the
      region list of a calling code from. }
    Assert.IsTrue(GetCountryCodeForRegion(Territory^.Id) > 0,
      'Short number region unknown to the phone metadata: ' + Territory^.Id);
  end;
end;

procedure TShortNumberInfoTests.UnknownRegions_HaveNoShortMetadata;
var
  Metadata: PShortMetadataRec;
begin
  { '001' is the non geographical entity id of the PHONE metadata; short
    number metadata has no non geographical entities at all. Region codes are
    matched exactly, so lower case does not resolve either. }
  Assert.IsFalse(TryGetShortMetadataForRegion('', Metadata));
  Assert.IsFalse(TryGetShortMetadataForRegion('ZZ', Metadata));
  Assert.IsFalse(TryGetShortMetadataForRegion('001', Metadata));
  Assert.IsFalse(TryGetShortMetadataForRegion('us', Metadata));
  Assert.IsFalse(HasShortMetadataForRegion('XX'));
  Assert.IsTrue(HasShortMetadataForRegion('US'));
end;

procedure TShortNumberInfoTests.ShortCodeLengths_AreAlwaysInheritedFromTheGeneralDesc;
var
  I: Integer;
  Territory: PShortMetadataRec;
  General, ShortCode: PPhoneNumberDescRec;
begin
  { setPossibleLengthsGeneralDesc derives the general description of short
    number metadata from the shortCode element ALONE, so setPossibleLengths
    always finds the shortCode lengths identical to their parent and drops
    them. An empty length list on shortCode is therefore an invariant of this
    data set, not a coincidence, and it is what makes
    matchesPossibleNumberAndNationalNumber skip its length pre-check for the
    shortCode description. }
  for I := 0 to ShortMetadataTerritoryCount - 1 do
  begin
    Territory := GetShortTerritory(I);
    General := GetShortDesc(Territory, sdkGeneralDesc);
    ShortCode := GetShortDesc(Territory, sdkShortCode);
    Assert.IsTrue(General^.LengthCount > 0,
      'General description without possible lengths: ' + Territory^.Id);
    Assert.IsTrue(ShortCode^.HasData,
      'Every short number territory must declare a shortCode: ' + Territory^.Id);
    Assert.AreEqual(0, ShortCode^.LengthCount,
      'shortCode lengths must be inherited from the general desc: ' + Territory^.Id);
  end;
end;

procedure TShortNumberInfoTests.TypedDescLengths_AreCoveredByTheGeneralDesc;
var
  I, L: Integer;
  Kind: TShortNumberDescKind;
  Territory: PShortMetadataRec;
  General, Desc: PPhoneNumberDescRec;
  Lengths: TMetadataIntegerArray;
begin
  for I := 0 to ShortMetadataTerritoryCount - 1 do
  begin
    Territory := GetShortTerritory(I);
    General := GetShortDesc(Territory, sdkGeneralDesc);
    for Kind := Low(TShortNumberDescKind) to High(TShortNumberDescKind) do
    begin
      if Kind = sdkGeneralDesc then
        Continue;
      Desc := GetShortDesc(Territory, Kind);
      Lengths := GetShortPossibleLengths(Desc);
      for L := 0 to Length(Lengths) - 1 do
      begin
        if Lengths[L] = NoPossibleLength then
        begin
          { The upstream encoding of "this description does not exist here":
            a single length of -1, which can never match a real number. }
          Assert.IsFalse(Desc^.HasData,
            'Only an absent description may carry the -1 length: ' + Territory^.Id);
          Assert.AreEqual(1, Integer(Length(Lengths)));
          Continue;
        end;
        Assert.IsTrue(ShortDescHasPossibleLength(General, Lengths[L]),
          Format('%s: length %d is not covered by the general description.',
            [Territory^.Id, Lengths[L]]));
      end;
      { Short number metadata never carries local-only lengths; upstream
        setPossibleLengthsGeneralDesc throws when it finds any. }
      Assert.AreEqual(0, Desc^.LocalOnlyCount);
    end;
  end;
end;

procedure TShortNumberInfoTests.ShortMetadataTableStructure_IsInternallyConsistent;
var
  I, Seen: Integer;
  Desc: PPhoneNumberDescRec;
  Territory: PShortMetadataRec;
  Used: array of Boolean;
begin
  { Structural gate over the generated tables, the short number counterpart of
    PossibleLengthSlices_StayInsideThePool in the phone metadata suite. Three
    things are checked, because all three are silently corruptible by a
    generator change: the desc slices must stay inside the pool, the territory
    desc offsets must sit on an exact stride of ShortNumberDescKindCount, and
    the region order must be a PERMUTATION of the territory indices. }

  for I := 0 to ShortMetadataDescCount - 1 do
  begin
    Desc := @ShortMetadataDescs[I];
    Assert.IsTrue(Desc^.LengthOffset >= 0,
      Format('Negative length offset on desc #%d.', [I]));
    Assert.IsTrue(Desc^.LengthCount >= 0,
      Format('Negative length count on desc #%d.', [I]));
    Assert.IsTrue(Desc^.LengthOffset + Desc^.LengthCount <= ShortMetadataPossibleLengthCount,
      Format('Length slice of desc #%d exceeds the pool.', [I]));
    { Short number metadata never carries local-only lengths, so the slice must
      be the empty one at offset 0. }
    Assert.AreEqual(0, Desc^.LocalOnlyOffset,
      Format('Desc #%d must not point into the local-only pool.', [I]));
    Assert.AreEqual(0, Desc^.LocalOnlyCount,
      Format('Desc #%d must not carry local-only lengths.', [I]));
  end;

  for I := 0 to ShortMetadataTerritoryCount - 1 do
  begin
    Territory := GetShortTerritory(I);
    Assert.AreEqual(I * ShortNumberDescKindCount, Territory^.DescOffset,
      Format('Desc offset of territory #%d (%s) is not on the kind stride.',
        [I, Territory^.Id]));
    Assert.IsTrue(
      Territory^.DescOffset + ShortNumberDescKindCount <= ShortMetadataDescCount,
      Format('Desc block of territory %s exceeds the desc table.',
        [Territory^.Id]));
    Assert.AreEqual(2, Integer(Length(Territory^.Id)),
      'Short number territory ids are CLDR region codes: ' + Territory^.Id);
  end;

  { The region order must hit every territory index exactly once. Without this
    a duplicated or dropped entry would make one territory unreachable by
    region code while every individual lookup still succeeded. }
  Used := nil;
  SetLength(Used, ShortMetadataTerritoryCount);
  Seen := 0;
  for I := 0 to ShortMetadataTerritoryCount - 1 do
  begin
    Assert.IsTrue((ShortMetadataRegionOrder[I] >= 0)
      and (ShortMetadataRegionOrder[I] < ShortMetadataTerritoryCount),
      Format('Region order entry #%d is out of range.', [I]));
    Assert.IsFalse(Used[ShortMetadataRegionOrder[I]],
      Format('Territory index %d appears twice in the region order.',
        [ShortMetadataRegionOrder[I]]));
    Used[ShortMetadataRegionOrder[I]] := True;
    Inc(Seen);
    { The sorted region code at slot I must be the id of the territory it
      points at. }
    Assert.AreEqual(ShortMetadataRegionCodes[I],
      ShortMetadataTerritories[ShortMetadataRegionOrder[I]].Id,
      Format('Region code / territory mismatch at slot %d.', [I]));
  end;
  Assert.AreEqual(ShortMetadataTerritoryCount, Seen);
end;

procedure TShortNumberInfoTests.AbsentDescriptions_UseTheUpstreamMinusOneEncoding;
var
  I, L, Absent, Present: Integer;
  Desc: PPhoneNumberDescRec;
  HasMinusOne: Boolean;
begin
  { BOTH directions of the upstream encoding for "this description does not
    exist in this territory": processPhoneNumberDescElement returns a desc with
    no data and a single possible length of -1, which can never match a real
    number. Checking only one direction would let a generator bug through - a
    -1 on a description that DOES have data would silently make every number of
    that kind impossible. }
  Absent := 0;
  Present := 0;
  for I := 0 to ShortMetadataDescCount - 1 do
  begin
    Desc := @ShortMetadataDescs[I];

    HasMinusOne := False;
    for L := 0 to Desc^.LengthCount - 1 do
      if ShortMetadataPossibleLengths[Desc^.LengthOffset + L] = NoPossibleLength then
        HasMinusOne := True;

    if Desc^.HasData then
    begin
      Inc(Present);
      Assert.IsFalse(HasMinusOne,
        Format('Desc #%d has data and must not carry the -1 length.', [I]));
      for L := 0 to Desc^.LengthCount - 1 do
        Assert.IsTrue(ShortMetadataPossibleLengths[Desc^.LengthOffset + L] > 0,
          Format('Desc #%d carries a non positive possible length.', [I]));
      Assert.IsTrue(Desc^.NationalNumberPattern <> '',
        Format('Desc #%d has data but no national number pattern.', [I]));
    end
    else
    begin
      Inc(Absent);
      { An absent element has no pattern and no example number, and exactly the
        one impossible length. }
      Assert.AreEqual('', Desc^.NationalNumberPattern,
        Format('Absent desc #%d must not carry a pattern.', [I]));
      Assert.AreEqual('', Desc^.ExampleNumber,
        Format('Absent desc #%d must not carry an example number.', [I]));
      Assert.AreEqual(1, Desc^.LengthCount,
        Format('Absent desc #%d must carry exactly one possible length.', [I]));
      Assert.IsTrue(HasMinusOne,
        Format('Absent desc #%d must carry the -1 length.', [I]));
    end;
  end;

  { 241 generalDesc + 241 shortCode + 240 tollFree + 240 emergency +
    91 smsServices + 85 carrierSpecific + 36 premiumRate + 28 standardRate
    = 1202 present descriptions, which is exactly the number of patterns the
    regex dialect gate compiles; the remaining 726 are absent. }
  Assert.AreEqual(1202, Present,
    'Number of present short number descriptions changed.');
  Assert.AreEqual(ShortMetadataDescCount - 1202, Absent);
end;

procedure TShortNumberInfoTests.ShortNumberPatterns_CompileWithTheDelphiEngine;
var
  I, Compiled: Integer;
  Error: string;
begin
  { The generator gate compiles every pattern against .NET regex; this is the
    second half of the same gate, against the engine the port actually runs
    on. }
  Compiled := 0;
  for I := 0 to ShortMetadataDescCount - 1 do
  begin
    if ShortMetadataDescs[I].NationalNumberPattern = '' then
      Continue;
    Assert.IsTrue(TryCompilePattern(ShortMetadataDescs[I].NationalNumberPattern,
      Error),
      Format('Short number pattern %d does not compile: %s', [I, Error]));
    Inc(Compiled);
  end;
  Assert.AreEqual(1202, Compiled,
    'Number of short number patterns changed.');
end;

{ ---------------------------------------------------------------------------
  ShortNumberInfo
  --------------------------------------------------------------------------- }

procedure TShortNumberInfoTests.IsEmergencyNumber_MatchesExactlyInSeveralRegions;
begin
  { Oracle: isEmergencyNumber('911','US')=True, ('112','US')=True,
    ('999','US')=False, ('999','GB')=True, ('112','DE')=True,
    ('110','DE')=True, ('1101','DE')=False, ('112','FR')=True,
    ('911','AU')=False. }
  Assert.IsTrue(IsEmergencyNumber('911', 'US'));
  Assert.IsTrue(IsEmergencyNumber('112', 'US'));
  Assert.IsFalse(IsEmergencyNumber('999', 'US'));
  Assert.IsTrue(IsEmergencyNumber('999', 'GB'));
  Assert.IsTrue(IsEmergencyNumber('112', 'DE'));
  Assert.IsTrue(IsEmergencyNumber('110', 'DE'));
  Assert.IsFalse(IsEmergencyNumber('1101', 'DE'));
  Assert.IsTrue(IsEmergencyNumber('112', 'FR'));
  Assert.IsFalse(IsEmergencyNumber('911', 'AU'));
end;

procedure TShortNumberInfoTests.ConnectsToEmergencyNumber_AllowsAppendedDigits;
begin
  { isEmergencyNumber implies connectsToEmergencyNumber, and outside the three
    exact-match regions extra digits behind an emergency number still connect.
    Oracle: connects('9116666666','US')=True while
    isEmergencyNumber('9116666666','US')=False; the same for
    ('1126666666','US'), ('1101','DE'), ('999123','GB'), ('112123','FR') and
    ('000123','AU'). }
  Assert.IsTrue(ConnectsToEmergencyNumber('911', 'US'));
  Assert.IsTrue(ConnectsToEmergencyNumber('9116666666', 'US'));
  Assert.IsFalse(IsEmergencyNumber('9116666666', 'US'));
  Assert.IsTrue(ConnectsToEmergencyNumber('1126666666', 'US'));
  Assert.IsFalse(IsEmergencyNumber('1126666666', 'US'));
  Assert.IsTrue(ConnectsToEmergencyNumber('1101', 'DE'));
  Assert.IsTrue(ConnectsToEmergencyNumber('999123', 'GB'));
  Assert.IsTrue(ConnectsToEmergencyNumber('112123', 'FR'));
  Assert.IsTrue(ConnectsToEmergencyNumber('000123', 'AU'));
  { A number that is no emergency number at all does not connect either. }
  Assert.IsFalse(ConnectsToEmergencyNumber('999', 'US'));
  Assert.IsFalse(ConnectsToEmergencyNumber('911', 'AU'));
end;

procedure TShortNumberInfoTests.ConnectsToEmergencyNumber_IsExactInBrazilChileAndNicaragua;
begin
  { REGIONS_WHERE_EMERGENCY_NUMBERS_MUST_BE_EXACT = BR, CL, NI: appending
    digits breaks the call there, so connectsToEmergencyNumber must not allow
    a prefix match.
    Oracle: ('190','BR') emergency=True connects=True,
            ('1900','BR') emergency=False connects=False,
            ('911','BR') emergency=True connects=True,
            ('9111','BR') emergency=False connects=False,
            ('133','CL') True/True, ('1330','CL') False/False,
            ('118','NI') True/True, ('1180','NI') False/False. }
  Assert.IsTrue(IsEmergencyNumber('190', 'BR'));
  Assert.IsTrue(ConnectsToEmergencyNumber('190', 'BR'));
  Assert.IsFalse(IsEmergencyNumber('1900', 'BR'));
  Assert.IsFalse(ConnectsToEmergencyNumber('1900', 'BR'));

  Assert.IsTrue(IsEmergencyNumber('911', 'BR'));
  Assert.IsFalse(ConnectsToEmergencyNumber('9111', 'BR'));

  Assert.IsTrue(ConnectsToEmergencyNumber('133', 'CL'));
  Assert.IsFalse(ConnectsToEmergencyNumber('1330', 'CL'));
  Assert.IsTrue(IsEmergencyNumber('131', 'CL'));
  Assert.IsFalse(IsEmergencyNumber('112', 'CL'));

  Assert.IsTrue(ConnectsToEmergencyNumber('118', 'NI'));
  Assert.IsFalse(ConnectsToEmergencyNumber('1180', 'NI'));
  Assert.IsFalse(ConnectsToEmergencyNumber('911', 'NI'));
end;

procedure TShortNumberInfoTests.EmergencyNumbers_RejectALeadingPlusAndUnknownRegions;
begin
  { Upstream returns false as soon as the extracted number starts with a plus
    sign: dialling the country code in front of an emergency number is not
    believed to work.
    Oracle: ('+911','US')=False/False, ('911','ZZ')=False/False,
            ('911','XX')=False/False, ('911','')=False/False,
            ('112','001')=False/False, ('','US') and ('abc','US')=False.

    The lower case spelling ('911','us') is covered by
    RegionArguments_AreCanonicalised. }
  Assert.IsFalse(IsEmergencyNumber('+911', 'US'));
  Assert.IsFalse(ConnectsToEmergencyNumber('+911', 'US'));
  Assert.IsFalse(IsEmergencyNumber('911', 'ZZ'));
  Assert.IsFalse(IsEmergencyNumber('911', 'XX'));
  Assert.IsFalse(IsEmergencyNumber('911', ''));
  Assert.IsFalse(IsEmergencyNumber('112', '001'));
  Assert.IsFalse(IsEmergencyNumber('', 'US'));
  Assert.IsFalse(ConnectsToEmergencyNumber('', 'US'));
  Assert.IsFalse(IsEmergencyNumber('abc', 'US'));
end;

procedure TShortNumberInfoTests.RegionArguments_AreCanonicalised;
begin
  { Every public entry point of this unit applies
    UpperCase(Trim(...)) to its region argument, the same rule the facade and
    the AsYouTypeFormatter constructor follow. Upstream compares region codes
    exactly and would answer False for 'us' or ' US ' - the canonical codes are
    a strict superset of what it accepts, so this changes no answer for a
    caller that passes CLDR codes and gives a defined one to a caller that does
    not. Recorded as a deliberate deviation in the unit header.

    The values are the ORACLE values for the canonical spelling 'US' / 'FR',
    which is the whole point: a non canonical spelling must answer exactly like
    the canonical one. }
  Assert.IsTrue(IsEmergencyNumber('911', 'us'));
  Assert.IsTrue(ConnectsToEmergencyNumber('911', 'us'));
  Assert.IsTrue(IsEmergencyNumber('911', ' US '));
  Assert.IsTrue(ConnectsToEmergencyNumber('112 34', ' fr '));

  Assert.IsTrue(IsValidShortNumberForRegion(1, '911', 'us'));
  Assert.AreEqual(IsValidShortNumberForRegion(1, '911', 'US'),
    IsValidShortNumberForRegion(1, '911', ' us '));
  Assert.IsTrue(IsPossibleShortNumberForRegion(1, '911', 'us'));
  Assert.AreEqual(Integer(Ord(GetExpectedCostForRegion(1, '911', 'US'))),
    Integer(Ord(GetExpectedCostForRegion(1, '911', ' us '))));
  Assert.AreEqual(GetExampleShortNumber('US'), GetExampleShortNumber(' us '));

  { An unknown region stays unknown however it is spelled. }
  Assert.IsFalse(IsEmergencyNumber('911', ' xx '));
end;

procedure TShortNumberInfoTests.EmergencyNumbers_TolerateFormattingCharacters;
begin
  { extractPossibleNumber plus normalizeDigitsOnly run before the match, so
    punctuation between the digits is irrelevant.
    Oracle: ('9-1-1','US') emergency=True connects=True;
            ('112 34','FR') emergency=False connects=True - the space is
            dropped, which turns the input into the prefix match '11234'. }
  Assert.IsTrue(IsEmergencyNumber('9-1-1', 'US'));
  Assert.IsTrue(ConnectsToEmergencyNumber('9-1-1', 'US'));
  Assert.IsFalse(IsEmergencyNumber('112 34', 'FR'));
  Assert.IsTrue(ConnectsToEmergencyNumber('112 34', 'FR'));
end;

procedure TShortNumberInfoTests.IsPossibleShortNumber_IsMoreLenientThanIsValid;
begin
  { isPossibleShortNumber only tests the LENGTH against the general
    description, isValidShortNumber tests the shortCode pattern as well.
    Oracle: +1 '123' possible(US)=True valid(US)=False,
            +1 '999' possible(US)=True valid(US)=False,
            +49 '12345' possible(DE)=True valid(DE)=False,
            +55 '1911' possible(BR)=True valid(BR)=False,
            +49 '115' possible(DE)=True valid(DE)=True. }
  Assert.IsTrue(IsPossibleShortNumberForRegion(1, '123', 'US'));
  Assert.IsFalse(IsValidShortNumberForRegion(1, '123', 'US'));
  Assert.IsTrue(IsPossibleShortNumberForRegion(1, '999', 'US'));
  Assert.IsFalse(IsValidShortNumberForRegion(1, '999', 'US'));
  Assert.IsTrue(IsPossibleShortNumberForRegion(49, '12345', 'DE'));
  Assert.IsFalse(IsValidShortNumberForRegion(49, '12345', 'DE'));
  Assert.IsTrue(IsPossibleShortNumberForRegion(55, '1911', 'BR'));
  Assert.IsFalse(IsValidShortNumberForRegion(55, '1911', 'BR'));

  Assert.IsTrue(IsPossibleShortNumberForRegion(49, '115', 'DE'));
  Assert.IsTrue(IsValidShortNumberForRegion(49, '115', 'DE'));
  Assert.IsTrue(IsPossibleShortNumber(49, '115'));
  Assert.IsTrue(IsValidShortNumber(49, '115'));
end;

procedure TShortNumberInfoTests.IsPossibleShortNumber_IsTheUnionOverAllRegionsOfTheCallingCode;
begin
  { isPossibleShortNumber walks EVERY region of the calling code and answers
    True as soon as one of them accepts the length - it is neither the first
    region's answer nor the last one's. Calling code 7 is the discriminator on
    the productive metadata: its region list is RU, KZ (RU first, it carries
    mainCountryForCode).

    Oracle:
      +7 '1234'   RU possible=False, KZ possible=True  -> union True
      +7 '12345'  RU possible=False, KZ possible=True  -> union True
      +7 '12'     RU possible=True,  KZ possible=False -> union True
      +7 '123456' RU possible=False, KZ possible=False -> union False
      +7 '112'    possible AND valid in both.
    '1234', '12345' and '12' are valid short numbers in neither region, so each
    case isolates the length union of isPossibleShortNumber from the pattern
    match of isValidShortNumber. }

  { Possible only in the SECOND region: an implementation that looked at the
    first region alone would answer False here. }
  Assert.IsFalse(IsPossibleShortNumberForRegion(7, '1234', 'RU'));
  Assert.IsTrue(IsPossibleShortNumberForRegion(7, '1234', 'KZ'));
  Assert.IsTrue(IsPossibleShortNumber(7, '1234'));
  Assert.IsFalse(IsValidShortNumber(7, '1234'));

  Assert.IsFalse(IsPossibleShortNumberForRegion(7, '12345', 'RU'));
  Assert.IsTrue(IsPossibleShortNumberForRegion(7, '12345', 'KZ'));
  Assert.IsTrue(IsPossibleShortNumber(7, '12345'));
  Assert.IsFalse(IsValidShortNumber(7, '12345'));

  { Possible only in the FIRST region: an implementation where the last region
    wins would answer False here. }
  Assert.IsTrue(IsPossibleShortNumberForRegion(7, '12', 'RU'));
  Assert.IsFalse(IsPossibleShortNumberForRegion(7, '12', 'KZ'));
  Assert.IsTrue(IsPossibleShortNumber(7, '12'));
  Assert.IsFalse(IsValidShortNumber(7, '12'));

  { Possible in neither, so the union stays False - "any region of the calling
    code has short number metadata" is not what is being measured. }
  Assert.IsFalse(IsPossibleShortNumberForRegion(7, '123456', 'RU'));
  Assert.IsFalse(IsPossibleShortNumberForRegion(7, '123456', 'KZ'));
  Assert.IsFalse(IsPossibleShortNumber(7, '123456'));

  { Possible and valid in both. }
  Assert.IsTrue(IsPossibleShortNumberForRegion(7, '112', 'RU'));
  Assert.IsTrue(IsPossibleShortNumberForRegion(7, '112', 'KZ'));
  Assert.IsTrue(IsPossibleShortNumber(7, '112'));
  Assert.IsTrue(IsValidShortNumber(7, '112'));
end;

procedure TShortNumberInfoTests.ShortNumbers_AreOnlyPossibleInTheirOwnCallingCode;
begin
  { regionDialingFromMatchesNumber: the calling code of the number must belong
    to the region it is dialled from.
    Oracle: +49 '115' for AT -> possible=False valid=False;
            +33 '1000' for US -> possible=False valid=False;
            +33 '3200' for GP -> possible=False valid=False (GP has calling
            code 590, the number is a French one). }
  Assert.IsFalse(IsPossibleShortNumberForRegion(49, '115', 'AT'));
  Assert.IsFalse(IsValidShortNumberForRegion(49, '115', 'AT'));
  Assert.IsFalse(IsPossibleShortNumberForRegion(33, '1000', 'US'));
  Assert.IsFalse(IsValidShortNumberForRegion(33, '1000', 'US'));
  Assert.IsFalse(IsPossibleShortNumberForRegion(33, '3200', 'GP'));
  Assert.IsFalse(IsValidShortNumberForRegion(33, '3200', 'GP'));
  Assert.IsFalse(IsCarrierSpecificForRegion(33, '611', 'US'));
  Assert.IsFalse(IsSmsServiceForRegion(33, '30000', 'US'));
  CheckCost(33, '1000', 'US', sncUnknownCost);
end;

procedure TShortNumberInfoTests.GetExpectedCostForRegion_CoversAllFourCostCategories;
begin
  { Oracle, all four categories on the productive metadata:
      +33 '1000'  FR -> PREMIUM_RATE
      +33 '611'   FR -> STANDARD_RATE
      +49 '110'   DE -> TOLL_FREE
      +49 '115'   DE -> UNKNOWN_COST
    and two more premium/standard rate anchors from the NANPA:
      +1  '24280' US -> PREMIUM_RATE
      +1  '23333' US -> STANDARD_RATE }
  CheckCost(33, '1000', 'FR', sncPremiumRate);
  CheckCost(33, '611', 'FR', sncStandardRate);
  CheckCost(49, '110', 'DE', sncTollFree);
  CheckCost(49, '115', 'DE', sncUnknownCost);
  CheckCost(1, '24280', 'US', sncPremiumRate);
  CheckCost(1, '23333', 'US', sncStandardRate);
  CheckCost(55, '102', 'BR', sncStandardRate);
end;

procedure TShortNumberInfoTests.GetExpectedCostForRegion_TreatsEmergencyNumbersAsTollFree;
begin
  { The last branch of getExpectedCostForRegion: a number that matches none of
    the three cost descriptions but IS an emergency number is toll free.
    Oracle: +1 '911' US -> TOLL_FREE, +1 '112' US -> TOLL_FREE,
            +55 '190' BR -> TOLL_FREE. }
  CheckCost(1, '911', 'US', sncTollFree);
  CheckCost(1, '112', 'US', sncTollFree);
  CheckCost(55, '190', 'BR', sncTollFree);
end;

procedure TShortNumberInfoTests.GetExpectedCost_MergesTheRegionsOfASharedCallingCode;
begin
  { Calling code 1 is shared by the NANPA regions, so getExpectedCost merges
    the per region results in the order PREMIUM_RATE, UNKNOWN_COST,
    STANDARD_RATE, TOLL_FREE.
    Oracle:
      '24280': US=PREMIUM_RATE, CA=UNKNOWN_COST -> PREMIUM_RATE (early exit)
      '23333': US=STANDARD_RATE, CA=UNKNOWN_COST -> UNKNOWN_COST
      '211'  : US=UNKNOWN_COST, CA=TOLL_FREE     -> UNKNOWN_COST
      '911'  : US=TOLL_FREE, CA=TOLL_FREE        -> UNKNOWN_COST
               (some other NANPA region answers UNKNOWN_COST)
      '988'  : TOLL_FREE everywhere              -> TOLL_FREE
    and for a calling code with a single region the merge is a pass through:
      +49 '110' -> TOLL_FREE, +33 '1000' -> PREMIUM_RATE. }
  Assert.AreEqual(CostName(sncPremiumRate), CostName(GetExpectedCost(1, '24280')));
  Assert.AreEqual(CostName(sncUnknownCost), CostName(GetExpectedCost(1, '23333')));
  Assert.AreEqual(CostName(sncUnknownCost), CostName(GetExpectedCost(1, '211')));
  Assert.AreEqual(CostName(sncUnknownCost), CostName(GetExpectedCost(1, '911')));
  Assert.AreEqual(CostName(sncTollFree), CostName(GetExpectedCost(1, '988')));
  Assert.AreEqual(CostName(sncTollFree), CostName(GetExpectedCost(49, '110')));
  Assert.AreEqual(CostName(sncPremiumRate), CostName(GetExpectedCost(33, '1000')));
  Assert.AreEqual(CostName(sncStandardRate), CostName(GetExpectedCost(33, '611')));
end;

procedure TShortNumberInfoTests.GetExpectedCost_IsUnknownForAnUnknownCallingCode;
begin
  { getRegionCodesForCountryCode returns an empty list, which is the first
    guard of getExpectedCost. The same list drives isPossibleShortNumber and
    isValidShortNumber. }
  Assert.AreEqual(CostName(sncUnknownCost), CostName(GetExpectedCost(999, '911')));
  Assert.IsFalse(IsPossibleShortNumber(999, '911'));
  Assert.IsFalse(IsValidShortNumber(999, '911'));
  Assert.IsFalse(IsCarrierSpecific(999, '911'));
end;

procedure TShortNumberInfoTests.SharedCallingCode_IsValidInAnyOfItsRegions;
begin
  { isValidShortNumber answers True when the number is valid in ANY region of
    the calling code, while isValidShortNumberForRegion is region exact.
    Oracle: +1 '10000' -> US=False, CA=True, isValidShortNumber=True;
            +1 '211'   -> US=True, CA=True. }
  Assert.IsFalse(IsValidShortNumberForRegion(1, '10000', 'US'));
  Assert.IsTrue(IsValidShortNumberForRegion(1, '10000', 'CA'));
  Assert.IsTrue(IsValidShortNumber(1, '10000'));
  Assert.IsTrue(IsPossibleShortNumber(1, '10000'));

  Assert.IsTrue(IsValidShortNumberForRegion(1, '211', 'US'));
  Assert.IsTrue(IsValidShortNumberForRegion(1, '211', 'CA'));
  Assert.IsTrue(IsValidShortNumber(1, '211'));

  { Not valid anywhere in the calling code. }
  Assert.IsFalse(IsValidShortNumber(1, '123'));
  Assert.IsTrue(IsPossibleShortNumber(1, '123'));
end;

procedure TShortNumberInfoTests.IsCarrierSpecific_FollowsTheCarrierSpecificDescription;
begin
  { Oracle: +33 '611' FR carrierSpecific=True, +55 '151' BR carrierSpecific=True,
            +1 '211' carrierSpecific=True (US and CA),
            +33 '1000' FR carrierSpecific=False, +1 '10000' carrierSpecific=False. }
  Assert.IsTrue(IsCarrierSpecificForRegion(33, '611', 'FR'));
  Assert.IsTrue(IsCarrierSpecific(33, '611'));
  Assert.IsTrue(IsCarrierSpecificForRegion(55, '151', 'BR'));
  Assert.IsTrue(IsCarrierSpecific(55, '151'));
  Assert.IsTrue(IsCarrierSpecificForRegion(1, '211', 'US'));
  Assert.IsTrue(IsCarrierSpecificForRegion(1, '211', 'CA'));
  Assert.IsTrue(IsCarrierSpecific(1, '211'));

  Assert.IsFalse(IsCarrierSpecificForRegion(33, '1000', 'FR'));
  Assert.IsFalse(IsCarrierSpecific(33, '1000'));
  Assert.IsFalse(IsCarrierSpecific(1, '10000'));
end;

procedure TShortNumberInfoTests.IsSmsServiceForRegion_FollowsTheSmsServicesDescription;
begin
  { Oracle: +33 '30000' FR sms=True, +1 '24280' US sms=True,
            +1 '10000' CA sms=True but US sms=False,
            +33 '611' FR sms=False, +49 '115' DE sms=False. }
  Assert.IsTrue(IsSmsServiceForRegion(33, '30000', 'FR'));
  Assert.IsTrue(IsSmsServiceForRegion(1, '24280', 'US'));
  Assert.IsTrue(IsSmsServiceForRegion(1, '10000', 'CA'));
  Assert.IsFalse(IsSmsServiceForRegion(1, '10000', 'US'));
  Assert.IsFalse(IsSmsServiceForRegion(33, '611', 'FR'));
  Assert.IsFalse(IsSmsServiceForRegion(49, '115', 'DE'));
end;

procedure TShortNumberInfoTests.ExampleShortNumbers_AreReadOffTheMetadata;
begin
  { getExampleShortNumber / getExampleShortNumberForCost read the exampleNumber
    of the shortCode respectively of the cost description. Values are the
    exampleNumber elements of the pinned ShortNumberMetadata.xml;
    UNKNOWN_COST has no description of its own and always yields ''. }
  Assert.AreEqual('1000', GetExampleShortNumberForCost('FR', sncPremiumRate));
  Assert.AreEqual('611', GetExampleShortNumberForCost('FR', sncStandardRate));
  Assert.AreEqual('24280', GetExampleShortNumberForCost('US', sncPremiumRate));
  Assert.AreEqual('23333', GetExampleShortNumberForCost('US', sncStandardRate));
  Assert.AreEqual('', GetExampleShortNumberForCost('US', sncUnknownCost));
  Assert.AreEqual('', GetExampleShortNumberForCost('DE', sncPremiumRate),
    'DE declares no premiumRate short numbers.');
  Assert.AreEqual('', GetExampleShortNumber('XX'));
  Assert.AreEqual('', GetExampleShortNumberForCost('XX', sncTollFree));
  Assert.IsTrue(GetExampleShortNumber('DE') <> '');
end;

procedure TShortNumberInfoTests.EveryShortCodeExampleNumber_IsAValidShortNumberInItsRegion;
var
  I, CountryCode, Checked: Integer;
  Territory: PShortMetadataRec;
  ShortCode: PPhoneNumberDescRec;
  Example: string;
begin
  { Mass gate, the short number counterpart of the 1144 example number gate of
    the phone metadata: the shortCode example number of every territory must be
    a valid short number in that very territory.

    Oracle result on libphonenumber-csharp 9.0.41: 241 of 241 example numbers
    answer IsValidShortNumberForRegion = True, and for each one the parsed
    national significant number equals the example number itself. There is no
    exception to document. }
  Checked := 0;
  for I := 0 to ShortMetadataTerritoryCount - 1 do
  begin
    Territory := GetShortTerritory(I);
    ShortCode := GetShortDesc(Territory, sdkShortCode);
    Example := ShortCode^.ExampleNumber;
    Assert.IsTrue(Example <> '',
      'Territory without a shortCode example number: ' + Territory^.Id);

    CountryCode := GetCountryCodeForRegion(Territory^.Id);
    Assert.IsTrue(IsPossibleShortNumberForRegion(CountryCode, Example,
      Territory^.Id),
      Format('%s: example %s is not a possible short number.',
        [Territory^.Id, Example]));
    Assert.IsTrue(IsValidShortNumberForRegion(CountryCode, Example,
      Territory^.Id),
      Format('%s: example %s is not a valid short number.',
        [Territory^.Id, Example]));
    Inc(Checked);
  end;
  Assert.AreEqual(ExpectedShortTerritoryCount, Checked);
end;

initialization
  RegisterTest(TShortNumberInfoTests);

end.
