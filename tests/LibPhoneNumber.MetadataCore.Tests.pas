unit LibPhoneNumber.MetadataCore.Tests;

{
  Gate for the metadata driven core.

  The public API of LibPhoneNumber.PhoneNumberUtil runs ON this unit. These
  tests therefore do three things:

  1. Prove the core against upstream guarantees: every example number of the
     pinned baseline must be valid, must have a known type, and must resolve to
     a region of its own calling code.
  2. Gate the public parser against the oracle: every reference case must parse
     to the recorded C# E164 output, and every example number must survive an
     E164 parse/format round trip in its own region and stay valid. Both are
     oracle anchored, not self referential.
  3. Cover the parsing helpers (extractCountryCode,
     parsePrefixAsIdd, maybeStripNationalPrefixAndCarrierCode) directly,
     including the invariant that the group participation heuristic of
     LibPhoneNumber.Regex relies on.
}

interface

uses
  System.Classes,
  DUnitX.TestFramework,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore;

type
  [TestFixture]
  TMetadataCoreTests = class
  private
    function FindReferenceCasesFile: string;
    function BuildE164(ACountryCode: Integer; const ANsn: string): string;
    function DescKindName(AKind: TPhoneNumberDescKind): string;
    function FirstOrEmpty(AList: TStringList): string;
    procedure AssertMatchesDocumentedList(AActual: TStringList;
      const AExpected: array of string; const AWhat: string);
    procedure AssertIsEmpty(AActual: TStringList;
      const AEmptySentinel: array of string; const AWhat: string);
    function RegionIsCandidateForCountryCode(const ARegionCode: string;
      ACountryCode: Integer): Boolean;
    function CapturingGroupBody(const APattern: string; AIndex: Integer): string;
    procedure Report(const AMessage: string);
    procedure ReportList(const ACaption: string; const AItems: array of string);
  public
    { Regex abstraction }
    [Test]
    procedure MatchFull_RequiresTheWholeInput;

    [Test]
    procedure MatchFull_AnchorsTopLevelAlternations;

    [Test]
    procedure MatchPrefix_AcceptsAProperPrefixOnly;

    [Test]
    procedure EmptyPattern_NeverMatches;

    [Test]
    procedure EmptyInput_MatchesAPatternThatAllowsIt;

    [Test]
    procedure PatternCache_ReusesCompiledPatterns;

    { Regex abstraction - replace operations }
    [Test]
    procedure ReplaceAll_SubstitutesEveryMatch;

    [Test]
    procedure ReplaceAll_ExpandsGroupReferencesLikeJava;

    [Test]
    procedure ReplaceFirst_SubstitutesTheFirstMatchOnly;

    [Test]
    procedure ReplaceFirst_AppliesTheNationalPrefixRuleToAFormatTemplate;

    [Test]
    procedure ReplaceAll_IsLenientAboutMalformedTemplates;

    [Test]
    procedure ReplaceAll_TreatsAnEmptyPatternAsANoOp;

    { Format engine }
    [Test]
    procedure FormatEngine_PicksThePatternByLeadingDigitsAndFullMatch;

    [Test]
    procedure FormatEngine_FallsBackToTheRawNsn_WhenNoPatternMatches;

    [Test]
    procedure FormatEngine_UsesTheIntlFormatsForInternationalAndRfc3966;

    [Test]
    procedure FormatEngine_AppendsTheExtensionPerFormat;

    [Test]
    procedure FormatEngine_FormatsNonGeographicalEntities;

    [Test]
    procedure FormatEngine_SupportsTheCarrierCodePath;

    { Extended formatter API }
    [Test]
    procedure FormatEngine_SingleInternationalPrefix_MatchesTheUpstreamPattern;

    [Test]
    procedure FormatEngine_FormatsOutOfCountryCallingNumbers;

    [Test]
    procedure FormatEngine_FormatsOutOfCountryWithPreferredIntlPrefix;

    [Test]
    procedure FormatEngine_FormatsNationalNumbersWithACarrierCode;

    [Test]
    procedure FormatEngine_ChoosesUserDefinedFormatsByLeadingDigits;

    [Test]
    procedure FormatEngine_FormatsByPattern;

    [Test]
    procedure FormatEngine_DoesNotThrowOnAnUncompilableUserPattern;

    [Test]
    procedure FormatEngine_ScansSeparatorsAsCodePoints;

    { Example numbers - upstream guarantees }
    [Test]
    procedure ExampleNumbers_AreValid_ForEveryTerritory;

    [Test]
    procedure ExampleNumbers_HaveAKnownType_ForEveryTerritory;

    [Test]
    procedure ExampleNumbers_ArePossible_ForEveryTerritory;

    [Test]
    procedure ExampleNumbers_ResolveToACandidateRegion;

    [Test]
    procedure ExampleNumbers_ResolveExactly_ForMajorRegions;

    [Test]
    procedure ExampleNumbers_ResolveToNonGeoId_ForGlobalNetworkCodes;

    { Reference corpus }
    [Test]
    procedure ReferenceCases_AreValidOnTheMetadataPath;

    [Test]
    procedure ReferenceCases_E164MatchesTheOracle;

    [Test]
    procedure ExampleNumbers_RoundTripThroughTheParser;

    { Format engine gate over the whole example number
      inventory. }
    [Test]
    procedure ExampleNumbers_FormatThroughTheEngine;

    { testNumberLength semantics }
    [Test]
    procedure TooShortNumber_IsReportedAsTooShort;

    [Test]
    procedure TooLongNumber_IsReportedAsTooLong;

    [Test]
    procedure LocalOnlyLength_IsReportedAsLocalOnly;

    [Test]
    procedure UnsupportedCallingCode_IsReportedAsInvalidCountryCode;

    [Test]
    procedure TypeWithoutMetadata_IsReportedAsInvalidLength;

    [Test]
    procedure FixedLineOrMobile_MergesBothLengthLists;

    [Test]
    procedure FixedLineOrMobile_FallsBackToMobile_WhenNoFixedLineData;

    [Test]
    procedure LocalOnlyLengths_ExistAndBehaveConsistently;

    { getNumberType / isValidNumberForRegion spot checks }
    [Test]
    procedure GermanNumbers_AreTypedLikeUpstream;

    [Test]
    procedure UnitedStatesNumbers_AreFixedLineOrMobile;

    [Test]
    procedure IsValidNumberForRegion_RejectsMismatchedRegion;

    [Test]
    procedure IsValidNumberForRegion_AcceptsSiblingRegionsOfSharedCallingCode;

    { Parsing helpers }
    [Test]
    procedure ExtractCountryCode_TakesTheKnownCallingCodePrefix;

    [Test]
    procedure ParsePrefixAsIdd_UsesTheMetadataInternationalPrefix;

    [Test]
    procedure MaybeStripNationalPrefix_LeavesTerritoriesWithoutNationalPrefixAlone;

    [Test]
    procedure MaybeStripNationalPrefix_StripsWhatTheMetadataDeclares;

    [Test]
    procedure MaybeStripNationalPrefix_KeepsTheNumberViable;

    [Test]
    procedure MaybeStripNationalPrefix_AppliesTheTransformRule;

    [Test]
    procedure NationalPrefixForParsing_HasNoGroupThatCanMatchEmpty;

    { Entry path of parseHelper }
    [Test]
    procedure UnicodeDecimalDigits_CoverTheBmpNdRuns;

    [Test]
    procedure NormalizeDigits_MapsNonAsciiDigitsToAscii;

    [Test]
    procedure ExtractPossibleNumber_PortsTheUpstreamSteps;

    [Test]
    procedure ExtractPossibleNumber_TreatsALoneSurrogateAsUnwanted;

    [Test]
    procedure IsViablePhoneNumber_PortsValidPhoneNumber;

    [Test]
    procedure MaybeStripExtension_PortsTheExtnPattern;

    [Test]
    procedure PhoneContext_FollowsTheRfc3966Syntax;

    [Test]
    procedure BuildNationalNumberForParsing_HandlesTelUris;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  LibPhoneNumber.Types,
  LibPhoneNumber.PhoneNumberUtil,
  LibPhoneNumber.MetadataFormat,
  LibPhoneNumber.Regex;

const
  { Example number inventory of the pinned baseline; see
    LibPhoneNumber.Metadata.Tests. }
  ExpectedExampleNumberCount = 1144;

  { Divergence inventories of the two parser gates below, as exact lists rather
    than budgets: a plain count would let a documented divergence disappear
    while a fresh regression silently takes its place.

    Both are empty on the pinned baseline and are expected to stay that way.
    The tests are anchored on the ORACLE (recorded E164 output of the
    reference corpus) respectively on an upstream guarantee verified against
    the oracle (E164 round trip of every example number). }
  ReferenceCasesWithE164Divergence: array[0..0] of string = (
    ''
  );
  ExampleNumbersWithParserDivergence: array[0..0] of string = (
    ''
  );

  { Divergence inventory of the format gate
    (ExampleNumbers_FormatThroughTheEngine), same "exact list, not a budget"
    rule as above. Empty on the pinned baseline. }
  ExampleNumbersWithFormatDivergence: array[0..0] of string = (
    ''
  );

  { How many divergences are printed in full before the list is truncated. }
  MaxReportedItems = 40;

  { Documented exception, upstream behaviour, not a port defect.

    PhoneNumberUtil.isPossibleNumberWithReason carries this exact case in its
    Javadoc (https://issuetracker.google.com/issues/335892662): the possible
    length check always uses the MAIN region of a shared calling code, so the
    seven digit Canadian UAN range 310xxxx is measured against the US metadata,
    where seven digits are a local only length. isValidNumber still accepts the
    number (it resolves the region properly), only isPossibleNumberWithReason
    reports IS_POSSIBLE_LOCAL_ONLY instead of IS_POSSIBLE. }
  KnownNotFullyPossibleExampleNumbers: array[0..0] of string = (
    'CA/uan +13101234 -> IS_POSSIBLE_LOCAL_ONLY'
  );

  { Documented exception of the reference corpus.

    DE mobile canonical (+49 151 1234567) stays: in the pinned baseline the
    German mobile pattern requires eleven digits for the 15x ranges, so the ten
    digit number is not a valid mobile number upstream either. The reference
    file only records formatter output for it, and libphonenumber emits an
    unformatted national number there precisely because no format matches. }
  KnownInvalidReferenceCases: array[0..0] of string = (
    'DE mobile canonical'
  );

function TMetadataCoreTests.BuildE164(ACountryCode: Integer;
  const ANsn: string): string;
begin
  Result := '+' + IntToStr(ACountryCode) + ANsn;
end;

function TMetadataCoreTests.FirstOrEmpty(AList: TStringList): string;
begin
  if AList.Count = 0 then
    Result := '-'
  else
    Result := AList[0];
end;

{ Asserts that AActual holds exactly the documented entries, in order. Using an
  explicit list instead of a plain count keeps both directions honest: a new
  divergence fails, and so does a silently disappearing one. }
procedure TMetadataCoreTests.AssertMatchesDocumentedList(
  AActual: TStringList; const AExpected: array of string; const AWhat: string);
var
  I: Integer;
  Expected, Actual: string;
begin
  Assert.AreEqual(Integer(Length(AExpected)), AActual.Count,
    Format('Unexpected number of %s (documented: %d, found: %d, first found: %s).',
      [AWhat, Length(AExpected), AActual.Count, FirstOrEmpty(AActual)]));
  for I := 0 to AActual.Count - 1 do
  begin
    Expected := AExpected[I];
    Actual := AActual[I];
    Assert.AreEqual(Expected, Actual,
      Format('Undocumented entry in %s.', [AWhat]));
  end;
end;

{ Companion of AssertMatchesDocumentedList for a list that must stay empty.
  Pascal has no zero length constant array, so the documented inventory carries
  a single empty string as its sentinel; that shape is asserted too, so the
  constant cannot quietly grow real entries without a test change. }
procedure TMetadataCoreTests.AssertIsEmpty(AActual: TStringList;
  const AEmptySentinel: array of string; const AWhat: string);
var
  Sentinel: string;
begin
  Sentinel := AEmptySentinel[0];
  Assert.AreEqual(1, Integer(Length(AEmptySentinel)),
    Format('The documented inventory of %s must be the empty sentinel.', [AWhat]));
  Assert.AreEqual('', Sentinel,
    Format('The documented inventory of %s must be the empty sentinel.', [AWhat]));
  Assert.AreEqual(0, AActual.Count,
    Format('Expected no %s, found %d (first: %s).',
      [AWhat, AActual.Count, FirstOrEmpty(AActual)]));
end;

function TMetadataCoreTests.DescKindName(
  AKind: TPhoneNumberDescKind): string;
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

function TMetadataCoreTests.RegionIsCandidateForCountryCode(
  const ARegionCode: string; ACountryCode: Integer): Boolean;
var
  Candidates: TMetadataStringArray;
  I: Integer;
begin
  Candidates := GetRegionCodesForCountryCode(ACountryCode);
  for I := 0 to Length(Candidates) - 1 do
    if Candidates[I] = ARegionCode then
      Exit(True);
  Result := False;
end;

procedure TMetadataCoreTests.Report(const AMessage: string);
begin
  System.Writeln(AMessage);
end;

procedure TMetadataCoreTests.ReportList(const ACaption: string;
  const AItems: array of string);
var
  I, Limit: Integer;
begin
  Report(Format('  %s: %d', [ACaption, Length(AItems)]));
  Limit := Length(AItems);
  if Limit > MaxReportedItems then
    Limit := MaxReportedItems;
  for I := 0 to Limit - 1 do
    Report('    ' + AItems[I]);
  if Length(AItems) > Limit then
    Report(Format('    ... %d more', [Length(AItems) - Limit]));
end;

function TMetadataCoreTests.FindReferenceCasesFile: string;
const
  FileName = 'reference_cases_java_csharp.json';
var
  BaseDir: string;
  Candidate: string;
  I: Integer;
begin
  BaseDir := ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  for I := 0 to 6 do
  begin
    Candidate := TPath.Combine(TPath.Combine(BaseDir, 'data'), FileName);
    if FileExists(Candidate) then
      Exit(Candidate);

    Candidate := TPath.Combine(TPath.Combine(TPath.Combine(BaseDir, 'tests'), 'data'), FileName);
    if FileExists(Candidate) then
      Exit(Candidate);

    BaseDir := ExcludeTrailingPathDelimiter(TPath.GetDirectoryName(BaseDir));
    if BaseDir = '' then
      Break;
  end;

  Assert.Fail('Reference case file not found: tests/data/' + FileName);
  Result := '';
end;

{ ---------------------------------------------------------------------------
  Regex abstraction
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.MatchFull_RequiresTheWholeInput;
begin
  Assert.IsTrue(TryMatchFull('\d{4}', '1234'), 'Full match should accept 1234.');
  Assert.IsFalse(TryMatchFull('\d{4}', '12345'), 'Full match must not accept a longer input.');
  Assert.IsFalse(TryMatchFull('\d{4}', '123'), 'Full match must not accept a shorter input.');
  Assert.IsFalse(TryMatchFull('\d{4}', 'x1234'), 'Full match must be anchored at the start.');
end;

procedure TMetadataCoreTests.MatchFull_AnchorsTopLevelAlternations;
begin
  { Without the non capturing wrapper the anchors would bind to the first and
    the last branch only, which is the single most common shape of an upstream
    nationalNumberPattern. }
  Assert.IsTrue(TryMatchFull('1\d{6}|[2-9]\d{5}', '1234567'), 'First branch must match fully.');
  Assert.IsTrue(TryMatchFull('1\d{6}|[2-9]\d{5}', '234567'), 'Second branch must match fully.');
  Assert.IsFalse(TryMatchFull('1\d{6}|[2-9]\d{5}', '12345678'), 'Trailing digits must be rejected.');
  Assert.IsFalse(TryMatchFull('1\d{6}|[2-9]\d{5}', 'x234567'), 'Leading garbage must be rejected.');
end;

procedure TMetadataCoreTests.MatchPrefix_AcceptsAProperPrefixOnly;
begin
  Assert.IsTrue(TryMatchPrefix('[13]', '30123456'), 'lookingAt must accept a prefix match.');
  Assert.IsFalse(TryMatchPrefix('[13]', '40123456'), 'lookingAt must be anchored at the start.');
  Assert.IsTrue(TryMatchPrefix('\d{2}', '1234'), 'lookingAt must ignore trailing input.');
end;

procedure TMetadataCoreTests.EmptyPattern_NeverMatches;
begin
  { Mirrors RegexBasedMatcher.matchNationalNumber, which refuses to match a
    non empty input against an empty pattern. }
  Assert.IsFalse(TryMatchFull('', ''), 'Empty pattern must never match.');
  Assert.IsFalse(TryMatchFull('', '123'), 'Empty pattern must never match.');
  Assert.IsFalse(TryMatchPrefix('', '123'), 'Empty pattern must never match.');
end;

procedure TMetadataCoreTests.EmptyInput_MatchesAPatternThatAllowsIt;
begin
  { Java Matcher.matches() accepts an empty input when the pattern can match
    the empty string. The Delphi engine must therefore not be created with
    roNotEmpty. No upstream metadata pattern currently matches the empty
    string, but the abstraction has to behave like Java regardless. }
  Assert.IsTrue(TryMatchFull('a*', ''), 'a* must match the empty input.');
  Assert.IsTrue(TryMatchFull('a*', 'aaa'), 'a* must still match a non empty input.');
  Assert.IsTrue(TryMatchFull('(?:x)?', ''), 'An optional group must match the empty input.');
  Assert.IsTrue(TryMatchPrefix('a*', ''), 'lookingAt must behave the same way.');
  Assert.IsFalse(TryMatchFull('a+', ''), 'a+ must not match the empty input.');
end;

procedure TMetadataCoreTests.PatternCache_ReusesCompiledPatterns;
var
  Before, Between, After: Integer;
begin
  Before := CachedPatternCount;
  Assert.IsTrue(TryMatchFull('cache-probe-\d{3}', 'cache-probe-123'));
  Between := CachedPatternCount;
  Assert.IsTrue(TryMatchFull('cache-probe-\d{3}', 'cache-probe-456'));
  After := CachedPatternCount;

  Assert.AreEqual(Before + 1, Between, 'A new pattern must be compiled exactly once.');
  Assert.AreEqual(Between, After, 'A repeated pattern must come from the cache.');
end;

{ ---------------------------------------------------------------------------
  Regex abstraction - replace operations
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.ReplaceAll_SubstitutesEveryMatch;
begin
  Assert.AreEqual('aXbX', ReplaceAll('\d', 'a1b2', 'X'),
    'Every match must be replaced, like Java Matcher.replaceAll.');
  Assert.AreEqual('2143', ReplaceAll('(\d)(\d)', '1234', '$2$1'),
    'The replacement runs once per match, not once per input.');
  Assert.AreEqual('abc', ReplaceAll('\d', 'abc', 'X'),
    'An input without a match must come back unchanged.');
  Assert.AreEqual('12', ReplaceAll('', '12', 'X'),
    'An empty pattern replaces nothing, like the other operations of this unit.');
end;

procedure TMetadataCoreTests.ReplaceAll_ExpandsGroupReferencesLikeJava;
begin
  { Group digits are consumed greedily but only while the accumulated group
    number stays valid, so with a single group "$10" is group 1 plus a literal
    zero - the rule java.util.regex.Matcher.appendReplacement applies. }
  Assert.AreEqual('70', ReplaceAll('(\d)', '7', '$10'),
    'A group number must not swallow a digit the pattern has no group for.');
  { A backslash escapes the next character, so a literal dollar survives. }
  Assert.AreEqual('$1', ReplaceAll('(\d)', '7', '\$1'),
    'A backslash must escape the following character.');
  { A group that did not participate contributes the empty string. }
  Assert.AreEqual('[7]', ReplaceAll('(\d)(x)?', '7', '[$1$2]'),
    'A non participating group must expand to nothing.');
end;

procedure TMetadataCoreTests.ReplaceFirst_SubstitutesTheFirstMatchOnly;
begin
  Assert.AreEqual('aXb2', ReplaceFirst('\d', 'a1b2', 'X'),
    'Only the first match must be replaced.');
  Assert.AreEqual('abc', ReplaceFirst('\d', 'abc', 'X'),
    'An input without a match must come back unchanged.');
end;

procedure TMetadataCoreTests.ReplaceFirst_AppliesTheNationalPrefixRuleToAFormatTemplate;
begin
  { This is what formatNsnUsingPattern does with the nationalPrefixFormattingRule:
    FIRST_GROUP_PATTERN matches the first group reference of the format
    template, and the $1 INSIDE the rule is a backreference to exactly that
    reference. Hence "0$1" applied to "$1 $2 $3" yields "0$1 $2 $3". }
  Assert.AreEqual('0$1 $2 $3',
    ReplaceFirst(FirstGroupPattern, '$1 $2 $3', '0$1'),
    'The national prefix rule must wrap the first group reference.');
  { Argentina does not use group 1 in its national format; the same mechanism
    therefore has to bind to $2 there, which is why upstream matches a dollar
    followed by a digit instead of the literal "$1". }
  Assert.AreEqual('0$2 15-$3-$4',
    ReplaceFirst(FirstGroupPattern, '$2 15-$3-$4', '0$1'),
    'The rule must bind to the first group reference actually used.');
  Assert.AreEqual('($1) $2-$3',
    ReplaceFirst(FirstGroupPattern, '$1 $2-$3', '($1)'),
    'A parenthesising rule must keep the rest of the template intact.');
end;

procedure TMetadataCoreTests.ReplaceAll_IsLenientAboutMalformedTemplates;
begin
  { java.util.regex REJECTS all three of these at run time; this port degrades
    instead, so a caller written format template can never blow up in the
    middle of formatting. The unit header of LibPhoneNumber.Regex spells
    the contract out; this test is what pins it. }

  { Java: IndexOutOfBoundsException, "No group 5". }
  Assert.AreEqual('[]', ReplaceAll('(\d)', '7', '[$5]'),
    'A group reference the pattern has no group for must expand to nothing.');

  { Java: IllegalArgumentException, "Illegal group reference". }
  Assert.AreEqual('a$b', ReplaceAll('(\d)', '7', 'a$b'),
    'A dollar that is not followed by a digit must stay a literal dollar.');
  Assert.AreEqual('a$', ReplaceAll('(\d)', '7', 'a$'),
    'A trailing dollar must stay a literal dollar.');

  { Java: IllegalArgumentException, "character to be escaped is missing". }
  Assert.AreEqual('a', ReplaceAll('(\d)', '7', 'a'),
    'A trailing backslash must stay a literal backslash.');

  { The same leniency applies to ReplaceFirst, which shares the body. }
  Assert.AreEqual('[]', ReplaceFirst('(\d)', '7', '[$5]'));
end;

procedure TMetadataCoreTests.ReplaceAll_TreatsAnEmptyPatternAsANoOp;
begin
  { Deliberate deviation from java.util.regex: an empty pattern matches zero
    width at every position there, so Java's replaceAll("") on 'abc' would
    yield 'XaXbXcX'. Nothing in this port can produce an empty pattern - the
    metadata never stores one and the format engine never builds one - so the
    shortcut is kept and pinned here instead of made Java exact. }
  Assert.AreEqual('abc', ReplaceAll('', 'abc', 'X'));
  Assert.AreEqual('abc', ReplaceFirst('', 'abc', 'X'));
  Assert.AreEqual('', ReplaceAll('', '', 'X'));
end;

{ ---------------------------------------------------------------------------
  Format engine
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.FormatEngine_PicksThePatternByLeadingDigitsAndFullMatch;
var
  Metadata: PPhoneMetadataRec;
  Chosen: PNumberFormatRec;
begin
  Assert.IsTrue(TryGetMetadataForRegion('DE', Metadata));

  { Berlin, area code 30. Oracle values of the reference corpus entry
    "DE Berlin canonical". }
  Assert.AreEqual('+49 30 123456',
    FormatNumber(49, '30123456', '', mpnfInternational));
  Assert.AreEqual('030 123456', FormatNumber(49, '30123456', '', mpnfNational));
  Assert.AreEqual('tel:+49-30-123456',
    FormatNumber(49, '30123456', '', mpnfRfc3966));

  { The chosen block must really be the one whose LAST leadingDigits pattern
    matches as a prefix and whose pattern matches the whole number. }
  Chosen := ChooseFormattingPatternForNumber(Metadata, False, '30123456');
  Assert.IsTrue(Chosen <> nil, 'A German geographic number must find a format.');
  Assert.IsTrue(TryMatchFull(Chosen^.Pattern, '30123456'),
    'The chosen pattern must match the national number completely.');
  Assert.AreEqual('0$1', Chosen^.NationalPrefixFormattingRule,
    'German formats carry the resolved national prefix rule.');
end;

procedure TMetadataCoreTests.FormatEngine_FallsBackToTheRawNsn_WhenNoPatternMatches;
var
  Metadata: PPhoneMetadataRec;
begin
  { Upstream formatNsn returns the unformatted national significant number when
    chooseFormattingPatternForNumber finds nothing, and formatNsnUsingPattern -
    with it the RFC3966 dash rewriting - is never reached. The ten digit German
    15x number is exactly that case: it is not a valid mobile number of the
    pinned baseline (the 15x ranges need eleven digits), so no German
    numberFormat matches it. Oracle values of the reference corpus entry
    "DE mobile canonical"; the golden case "DE mobile ten digit (upstream
    invalid)" is the same number. }
  Assert.IsTrue(TryGetMetadataForRegion('DE', Metadata));
  Assert.IsTrue(ChooseFormattingPatternForNumber(Metadata, False, '1511234567') = nil,
    'No German format may match the ten digit 15x number.');

  Assert.AreEqual('+49 1511234567',
    FormatNumber(49, '1511234567', '', mpnfInternational));
  Assert.AreEqual('1511234567', FormatNumber(49, '1511234567', '', mpnfNational));
  Assert.AreEqual('tel:+49-1511234567',
    FormatNumber(49, '1511234567', '', mpnfRfc3966));
end;

procedure TMetadataCoreTests.FormatEngine_UsesTheIntlFormatsForInternationalAndRfc3966;
begin
  { Argentina is the region that separates the three code paths cleanly.

    NATIONAL uses the numberFormat list, whose mobile block formats
    9AA-xxxx-xxxx as "$2 15-$3-$4": group 1, the mobile 9, is DROPPED and the
    literal 15 is injected, then the national prefix rule 0$1 binds to $2.
    INTERNATIONAL and RFC3966 use the intlNumberFormat list, which keeps the 9.

    Oracle values of the reference corpus entry "AR auto example". }
  Assert.AreEqual('+54 9 11 2345-6789',
    FormatNumber(54, '91123456789', '', mpnfInternational));
  Assert.AreEqual('011 15-2345-6789',
    FormatNumber(54, '91123456789', '', mpnfNational));
  Assert.AreEqual('tel:+54-9-11-2345-6789',
    FormatNumber(54, '91123456789', '', mpnfRfc3966));
end;

procedure TMetadataCoreTests.FormatEngine_AppendsTheExtensionPerFormat;
begin
  { RFC3966 always uses the RFC extension parameter, everything else the
    preferredExtnPrefix of the territory or the upstream default " ext. ".
    Germany declares none, the United Kingdom declares " x". }
  Assert.AreEqual('+49 30 123456 ext. 42',
    FormatNumber(49, '30123456', '42', mpnfInternational));
  Assert.AreEqual('030 123456 ext. 42',
    FormatNumber(49, '30123456', '42', mpnfNational));
  Assert.AreEqual('tel:+49-30-123456;ext=42',
    FormatNumber(49, '30123456', '42', mpnfRfc3966));

  Assert.AreEqual('+44 20 7946 0321 x42',
    FormatNumber(44, '2079460321', '42', mpnfInternational));
  Assert.AreEqual('tel:+44-20-7946-0321;ext=42',
    FormatNumber(44, '2079460321', '42', mpnfRfc3966));
end;

procedure TMetadataCoreTests.FormatEngine_FormatsNonGeographicalEntities;
begin
  { Country code 800 has no region code, so the engine must resolve its
    metadata through getMetadataForRegionOrCallingCode. Its single format is
    "$1 $2" over eight digits and carries no national prefix rule, so NATIONAL
    and the national part of INTERNATIONAL are identical. }
  Assert.AreEqual('+800 1234 5678',
    FormatNumber(800, '12345678', '', mpnfInternational));
  Assert.AreEqual('1234 5678', FormatNumber(800, '12345678', '', mpnfNational));
  Assert.AreEqual('tel:+800-1234-5678',
    FormatNumber(800, '12345678', '', mpnfRfc3966));
end;

procedure TMetadataCoreTests.FormatEngine_SupportsTheCarrierCodePath;
var
  Chosen: PNumberFormatRec;
begin
  { The carrier code branch of formatNsnUsingPattern is ported but not offered
    through this entry point - formatNationalNumberWithCarrierCode is the
    public one - so it is exercised through the engine directly.

    Brazilian mobile: format "$1 $2-$3", nationalPrefixFormattingRule "($1)",
    carrierCodeFormattingRule "0 $CC ($1)". Without a carrier code the national
    prefix branch runs and yields the oracle value of the reference corpus
    entry "BR auto example". }
  Chosen := ChooseFormattingPatternForCallingCode(55, '11961234567');
  Assert.IsTrue(Chosen <> nil, 'The Brazilian mobile format must be found.');
  Assert.AreEqual('($1)', Chosen^.NationalPrefixFormattingRule);
  Assert.AreEqual('0 $CC ($1)', Chosen^.DomesticCarrierCodeFormattingRule);

  Assert.AreEqual('(11) 96123-4567',
    FormatNsnUsingPattern('11961234567', Chosen, mpnfNational, ''),
    'An empty carrier code must select the national prefix branch.');
  Assert.AreEqual('0 15 (11) 96123-4567',
    FormatNsnUsingPattern('11961234567', Chosen, mpnfNational, '15'),
    'A carrier code must replace the placeholder and win over the prefix rule.');
  { Upstream restricts the carrier branch to NATIONAL; every other format keeps
    the plain template. }
  Assert.AreEqual('11 96123-4567',
    FormatNsnUsingPattern('11961234567', Chosen, mpnfInternational, '15'),
    'The carrier code must be ignored outside the NATIONAL format.');
end;

procedure TMetadataCoreTests.FormatEngine_ScansSeparatorsAsCodePoints;
const
  { Written as character codes so the source file stays pure ASCII: the point
    of this test is precisely that the encoding of the SOURCE must not decide
    which separators the engine recognises. }
  NoBreakSpace = #$00A0;
  Hyphen = #$2010;
  SwungDash = #$2053;
  TildeOperator = #$223C;
  IdeographicSpace = #$3000;
  FullwidthHyphen = #$FF0D;
  FullwidthTilde = #$FF5E;
var
  Formats: TUserNumberFormatArray;
begin
  { VALID_PUNCTUATION is a Unicode class, and both predicates take a WideChar
    so it stays complete on FreePascal as well, where the native Char is a
    single byte. See "Character scanning" in the unit header of
    LibPhoneNumber.MetadataFormat. }
  Assert.IsTrue(IsValidPunctuation(' '), 'ASCII space');
  Assert.IsTrue(IsValidPunctuation('-'), 'ASCII hyphen');
  Assert.IsTrue(IsValidPunctuation(NoBreakSpace), 'U+00A0');
  Assert.IsTrue(IsValidPunctuation(Hyphen), 'U+2010');
  Assert.IsTrue(IsValidPunctuation(IdeographicSpace), 'U+3000');
  Assert.IsTrue(IsValidPunctuation(FullwidthHyphen), 'U+FF0D');
  Assert.IsTrue(IsValidPunctuation(FullwidthTilde), 'U+FF5E');
  Assert.IsFalse(IsValidPunctuation('5'), 'A digit is not punctuation.');
  Assert.IsFalse(IsValidPunctuation('a'),
    'Only the letter x counts as punctuation upstream.');

  { All three non ASCII waiting tone variants of SINGLE_INTERNATIONAL_PREFIX
    must be accepted, not only the ASCII tilde. }
  Assert.IsTrue(IsSingleInternationalPrefix('8' + SwungDash + '10'), 'U+2053');
  Assert.IsTrue(IsSingleInternationalPrefix('8' + TildeOperator + '10'),
    'U+223C');
  Assert.IsTrue(IsSingleInternationalPrefix('8' + FullwidthTilde + '10'),
    'U+FF5E');
  Assert.IsFalse(IsSingleInternationalPrefix('8' + IdeographicSpace + '10'),
    'An ideographic space is punctuation but not a waiting tone.');

  { The reason this matters at run time: FormatByPattern takes format templates
    straight from the caller, and the RFC3966 branch has to rewrite every
    separator run in them - not just the ASCII ones. Oracle values
    (libphonenumber-csharp 9.0.38, productive metadata). }
  SetLength(Formats, 1);
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})',
    '$1' + IdeographicSpace + '$2-$3', [], '', '');
  Assert.AreEqual('650' + IdeographicSpace + '253-0000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats),
    'NATIONAL keeps the template separators verbatim.');
  Assert.AreEqual('tel:+1-650-253-0000',
    FormatByPattern(1, '6502530000', '', mpnfRfc3966, Formats),
    'RFC3966 must rewrite a non ASCII separator run as a dash.');

  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})',
    NoBreakSpace + FullwidthTilde + '$1 $2' + FullwidthHyphen + '$3',
    [], '', '');
  Assert.AreEqual('tel:+1-650-253-0000',
    FormatByPattern(1, '6502530000', '', mpnfRfc3966, Formats),
    'A LEADING non ASCII separator run must be stripped, not turned into a dash.');
end;

{ ---------------------------------------------------------------------------
  Extended formatter API

  Every expectation below was produced by the C# NuGet oracle
  (libphonenumber-csharp 9.0.38, the metadata release of the pinned Java
  baseline) against the PRODUCTIVE metadata, never copied from
  PhoneNumberUtilTest.java: that suite runs on
  PhoneNumberMetadataForTesting.xml, whose AR, AU, MX and UZ entries differ
  from the shipped ones. The test IDEAS are the upstream ones.
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.FormatEngine_SingleInternationalPrefix_MatchesTheUpstreamPattern;
begin
  { SINGLE_INTERNATIONAL_PREFIX = "[\d]+(?:[~...][\d]+)?" with matches().
    The inputs are the real internationalPrefix values of the baseline. }
  Assert.IsTrue(IsSingleInternationalPrefix('011'), 'US');
  Assert.IsTrue(IsSingleInternationalPrefix('00'), 'DE');
  Assert.IsTrue(IsSingleInternationalPrefix('810'), 'RU');
  Assert.IsTrue(IsSingleInternationalPrefix('8~10'),
    'A waiting tone between two digit runs is a single prefix.');

  { Multiple prefixes: anything that is not digits plus at most one waiting
    tone. }
  Assert.IsFalse(IsSingleInternationalPrefix('0[0-3]\d'), 'SG');
  Assert.IsFalse(IsSingleInternationalPrefix(
    '001[14-689]|14(?:1[14]|34|4[17]|[56]6|7[47]|88)0011'), 'AU');
  Assert.IsFalse(IsSingleInternationalPrefix('0[09]'), 'MX');

  { Degenerate inputs. }
  Assert.IsFalse(IsSingleInternationalPrefix(''),
    'The leading digit run is mandatory.');
  Assert.IsFalse(IsSingleInternationalPrefix('~10'),
    'The leading digit run is mandatory.');
  Assert.IsFalse(IsSingleInternationalPrefix('8~'),
    'The trailing digit run of the optional group is mandatory.');
  Assert.IsFalse(IsSingleInternationalPrefix('8~10~2'),
    'The optional group may occur at most once.');
end;

procedure TMetadataCoreTests.FormatEngine_FormatsOutOfCountryCallingNumbers;
begin
  { NANPA special case: dialling a +1 number from another NANPA region prefixes
    the NATIONAL format with the calling code and uses no IDD at all. }
  Assert.AreEqual('1 (650) 253-0000',
    FormatOutOfCountryCallingNumber(1, '6502530000', '', 'BS'));

  { Same calling code, non NANPA: pure NATIONAL format. }
  Assert.AreEqual('02 3661 8300',
    FormatOutOfCountryCallingNumber(39, '0236618300', '', 'IT'));
  Assert.AreEqual('6521 8000',
    FormatOutOfCountryCallingNumber(65, '65218000', '', 'SG'));
  Assert.AreEqual('011 15-8765-4321',
    FormatOutOfCountryCallingNumber(54, '91187654321', '', 'AR'));

  { A number the library considers invalid keeps working; note it is formatted
    without a national prefix, which is upstream's documented behaviour for
    short numbers. }
  Assert.AreEqual('1234', FormatOutOfCountryCallingNumber(49, '1234', '', 'DE'));
  Assert.AreEqual('00 49 1234',
    FormatOutOfCountryCallingNumber(49, '1234', '', 'GB'));

  { Single international prefix of the calling region. }
  Assert.AreEqual('00 1 900-253-0000',
    FormatOutOfCountryCallingNumber(1, '9002530000', '', 'DE'));
  Assert.AreEqual('00 1 650-253-0000',
    FormatOutOfCountryCallingNumber(1, '6502530000', '', 'PL'));
  Assert.AreEqual('011 44 7912 345678',
    FormatOutOfCountryCallingNumber(44, '7912345678', '', 'US'));
  Assert.AreEqual('011 39 02 3661 8300',
    FormatOutOfCountryCallingNumber(39, '0236618300', '', 'US'));
  Assert.AreEqual('011 54 9 11 8765-4321',
    FormatOutOfCountryCallingNumber(54, '91187654321', '', 'US'));

  { Non geographical calling code dialled from a region with a single IDD. }
  Assert.AreEqual('011 800 1234 5678',
    FormatOutOfCountryCallingNumber(800, '12345678', '', 'US'));

  { Multiple international prefixes and no preferred one: upstream cannot pick
    and returns the INTERNATIONAL format. SG declares "0[0-3]\d". }
  Assert.AreEqual('+39 02 3661 8300',
    FormatOutOfCountryCallingNumber(39, '0236618300', '', 'SG'));

  { Unsupported calling region: INTERNATIONAL format, no exception. '001' is
    the non geographical entity id and is deliberately NOT a supported region. }
  Assert.AreEqual('+1 650-253-0000',
    FormatOutOfCountryCallingNumber(1, '6502530000', '', 'AQ'));
  Assert.AreEqual('+1 650-253-0000',
    FormatOutOfCountryCallingNumber(1, '6502530000', '', '001'));
  Assert.AreEqual('+1 650-253-0000',
    FormatOutOfCountryCallingNumber(1, '6502530000', '', 'XX'));

  { An extension is appended before the IDD is prefixed. }
  Assert.AreEqual('011 54 9 11 8765-4321 ext. 1234',
    FormatOutOfCountryCallingNumber(54, '91187654321', '1234', 'US'));
  Assert.AreEqual('011 15-8765-4321 ext. 1234',
    FormatOutOfCountryCallingNumber(54, '91187654321', '1234', 'AR'));
end;

procedure TMetadataCoreTests.FormatEngine_FormatsOutOfCountryWithPreferredIntlPrefix;
begin
  { AU has BOTH a multi prefix internationalPrefix and a
    preferredInternationalPrefix of 0011, so the preferred one wins over the
    "cannot decide, use INTERNATIONAL" branch. }
  Assert.AreEqual('0011 39 02 3661 8300',
    FormatOutOfCountryCallingNumber(39, '0236618300', '', 'AU'));
  Assert.AreEqual('0011 54 9 11 8765-4321 ext. 1234',
    FormatOutOfCountryCallingNumber(54, '91187654321', '1234', 'AU'));

  { A preferred prefix containing a waiting tone survives verbatim. The Java
    test uses UZ for this, which carries preferredInternationalPrefix="8~10" in
    the TEST metadata only - the productive UZ entry has a plain "00". RU is
    the productive territory with that prefix. }
  Assert.AreEqual('8~10 39 02 3661 8300',
    FormatOutOfCountryCallingNumber(39, '0236618300', '', 'RU'));
  Assert.AreEqual('00 39 02 3661 8300',
    FormatOutOfCountryCallingNumber(39, '0236618300', '', 'UZ'));
end;

procedure TMetadataCoreTests.FormatEngine_FormatsNationalNumbersWithACarrierCode;
begin
  { Brazil is the territory whose productive metadata carries
    carrierCodeFormattingRule "0 $CC ($1)". The Java test uses AR, which has
    that rule in the TEST metadata only. }
  Assert.AreEqual('(11) 3011-1234',
    FormatNationalNumberWithCarrierCode(55, '1130111234', '', ''),
    'An empty carrier code must yield the plain national format.');
  Assert.AreEqual('0 21 (11) 3011-1234',
    FormatNationalNumberWithCarrierCode(55, '1130111234', '', '21'));
  Assert.AreEqual('0 15 (11) 96123-4567',
    FormatNationalNumberWithCarrierCode(55, '11961234567', '', '15'));

  { A territory without a carrierCodeFormattingRule ignores the carrier code. }
  Assert.AreEqual('(650) 253-0000',
    FormatNationalNumberWithCarrierCode(1, '6502530000', '', '15'));

  { An invalid country calling code yields the bare national number. }
  Assert.AreEqual('12345',
    FormatNationalNumberWithCarrierCode(0, '12345', '', '89'));
end;

procedure TMetadataCoreTests.FormatEngine_ChoosesUserDefinedFormatsByLeadingDigits;
var
  Formats: TUserNumberFormatArray;
begin
  SetLength(Formats, 2);
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1/$2/$3',
    ['9'], '', '');
  Formats[1] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1-$2-$3',
    ['6'], '', '');

  { The first format whose LAST leadingDigits pattern matches as a prefix AND
    whose pattern matches the whole number wins. }
  Assert.AreEqual(1, ChooseFormattingPatternForUserFormats(Formats,
    '6502530000'));
  Assert.AreEqual(0, ChooseFormattingPatternForUserFormats(Formats,
    '9002530000'));
  Assert.AreEqual(-1, ChooseFormattingPatternForUserFormats(Formats,
    '2530000'), 'A number the pattern cannot match fully finds nothing.');
  Assert.AreEqual(-1, ChooseFormattingPatternForUserFormats(Formats,
    '1002530000'), 'No leadingDigits pattern matches.');

  { A format without leadingDigits is an unconditional candidate. }
  SetLength(Formats, 1);
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1/$2/$3',
    [], '', '');
  Assert.AreEqual(0, ChooseFormattingPatternForUserFormats(Formats,
    '1002530000'));
end;

procedure TMetadataCoreTests.FormatEngine_FormatsByPattern;
var
  Formats: TUserNumberFormatArray;
begin
  SetLength(Formats, 1);

  { The Java testFormatByPattern cases, recomputed against the productive
    metadata. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '($1) $2-$3',
    [], '', '');
  Assert.AreEqual('(650) 253-0000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));
  Assert.AreEqual('+1 (650) 253-0000',
    FormatByPattern(1, '6502530000', '', mpnfInternational, Formats));
  Assert.AreEqual('tel:+1-650-712-9823',
    FormatByPattern(1, '6507129823', '', mpnfRfc3966, Formats),
    'RFC3966 replaces every separator run of the user template with a dash.');

  { $NP is resolved from the metadata of the MAIN region of the calling code,
    so a Bahamian number follows the US national prefix "1". }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1 $2-$3',
    [], '$NP ($FG)', '');
  Assert.AreEqual('1 (242) 365-1234',
    FormatByPattern(1, '2423651234', '', mpnfNational, Formats));
  Assert.AreEqual('+1 242 365-1234',
    FormatByPattern(1, '2423651234', '', mpnfInternational, Formats),
    'The national prefix rule applies to NATIONAL only.');

  { Italy has no national prefix, so the rule is dropped instead of expanded. }
  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{5})(\d{3})', '$1-$2 $3',
    [], '$NP ($FG)', '');
  Assert.AreEqual('02-36618 300',
    FormatByPattern(39, '0236618300', '', mpnfNational, Formats));
  Assert.AreEqual('+39 02-36618 300',
    FormatByPattern(39, '0236618300', '', mpnfInternational, Formats));

  { The two national prefix rule shapes of the Java test, on GB. }
  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{4})(\d{4})', '$1 $2 $3',
    [], '$NP$FG', '');
  Assert.AreEqual('020 7031 3000',
    FormatByPattern(44, '2070313000', '', mpnfNational, Formats));
  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{4})(\d{4})', '$1 $2 $3',
    [], '($NP$FG)', '');
  Assert.AreEqual('(020) 7031 3000',
    FormatByPattern(44, '2070313000', '', mpnfNational, Formats));
  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{4})(\d{4})', '$1 $2 $3',
    [], '', '');
  Assert.AreEqual('20 7031 3000',
    FormatByPattern(44, '2070313000', '', mpnfNational, Formats));

  { The extension is appended by the METADATA of the territory, not by the user
    format. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '($1) $2-$3',
    [], '', '');
  Assert.AreEqual('(650) 253-0000 ext. 4567',
    FormatByPattern(1, '6502530000', '4567', mpnfNational, Formats));

  { No user format matches: the number is formatted as a whole. }
  Formats[0] := MakeUserNumberFormat('(\d{2})(\d{2})', '$1-$2', [], '', '');
  Assert.AreEqual('6502530000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));

  { leadingDigits of a user format are honoured. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1/$2/$3',
    ['9'], '', '');
  Assert.AreEqual('6502530000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1/$2/$3',
    ['6'], '', '');
  Assert.AreEqual('650/253/0000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));

  { An invalid country calling code yields the bare national number. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '($1) $2-$3',
    [], '', '');
  Assert.AreEqual('12345',
    FormatByPattern(0, '12345', '', mpnfNational, Formats));
end;

procedure TMetadataCoreTests
  .FormatEngine_DoesNotThrowOnAnUncompilableUserPattern;
var
  Formats: TUserNumberFormatArray;
begin
  { FormatByPattern is the ONE entry point of the port that takes regular
    expressions straight from the caller, and the whole public surface is
    documented as non throwing: no engine compile error may escape through
    TryMatchFull/TryMatchPrefix.

    A format whose Pattern or leadingDigits do not compile is simply not a
    candidate, so the answer is the documented no-match answer: the number
    formatted as a whole. }
  SetLength(Formats, 1);

  { Unbalanced group in the pattern. }
  Formats[0] := MakeUserNumberFormat('(\d{3}(\d{3})(\d{4})', '$1-$2-$3',
    [], '', '');
  Assert.AreEqual('6502530000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));
  Assert.AreEqual(-1,
    ChooseFormattingPatternForUserFormats(Formats, '6502530000'));

  { A quantifier with nothing to repeat. }
  Formats[0] := MakeUserNumberFormat('*(\d{3})', '$1', [], '', '');
  Assert.AreEqual('6502530000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));

  { Broken leadingDigits, valid pattern: the format is skipped as a whole. }
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1/$2/$3',
    ['6['], '', '');
  Assert.AreEqual('6502530000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));

  { A second, VALID format behind the broken one still wins - skipping is not
    aborting. }
  SetLength(Formats, 2);
  Formats[0] := MakeUserNumberFormat('(\d{3}(\d{3})(\d{4})', '$1-$2-$3',
    [], '', '');
  Formats[1] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1/$2/$3',
    [], '', '');
  Assert.AreEqual(1,
    ChooseFormattingPatternForUserFormats(Formats, '6502530000'));
  Assert.AreEqual('650/253/0000',
    FormatByPattern(1, '6502530000', '', mpnfNational, Formats));
end;

{ ---------------------------------------------------------------------------
  Example numbers
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.ExampleNumbers_AreValid_ForEveryTerritory;
var
  I, Checked: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Failures: TStringList;
begin
  Failures := TStringList.Create;
  try
    Checked := 0;
    for I := 0 to GetTerritoryCount - 1 do
    begin
      Territory := GetTerritory(I);
      for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
      begin
        Desc := GetDesc(Territory, Kind);
        if Desc^.ExampleNumber = '' then
          Continue;
        Inc(Checked);
        if not LibPhoneNumber.MetadataCore.IsValidNumber(
          Territory^.CountryCode, Desc^.ExampleNumber) then
          Failures.Add(Format('%s/%s %s', [Territory^.Id, DescKindName(Kind),
            BuildE164(Territory^.CountryCode, Desc^.ExampleNumber)]));
      end;
    end;

    Assert.AreEqual(ExpectedExampleNumberCount, Checked,
      'Unexpected number of example numbers in the pinned baseline.');

    if Failures.Count > 0 then
      ReportList('example numbers rejected by the metadata path',
        Failures.ToStringArray);

    Assert.AreEqual(0, Failures.Count,
      Format('%d example numbers are not valid on the metadata path (first: %s).',
        [Failures.Count, FirstOrEmpty(Failures)]));
  finally
    Failures.Free;
  end;
end;

procedure TMetadataCoreTests.ExampleNumbers_HaveAKnownType_ForEveryTerritory;
var
  I, Checked, Mismatched: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  ActualType, ExpectedType: TMetadataNumberType;
  Unknowns, OtherType: TStringList;
begin
  Unknowns := TStringList.Create;
  OtherType := TStringList.Create;
  try
    Checked := 0;
    for I := 0 to GetTerritoryCount - 1 do
    begin
      Territory := GetTerritory(I);
      for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
      begin
        Desc := GetDesc(Territory, Kind);
        if Desc^.ExampleNumber = '' then
          Continue;
        if not TryDescKindToNumberType(Kind, ExpectedType) then
          Continue;
        Inc(Checked);

        ActualType := GetNumberType(Territory^.CountryCode, Desc^.ExampleNumber);
        if ActualType = mntUnknown then
          Unknowns.Add(Format('%s/%s %s', [Territory^.Id, DescKindName(Kind),
            BuildE164(Territory^.CountryCode, Desc^.ExampleNumber)]))
        else if (ActualType <> ExpectedType)
          and not ((ActualType = mntFixedLineOrMobile)
            and ((ExpectedType = mntFixedLine) or (ExpectedType = mntMobile))) then
          OtherType.Add(Format('%s/%s %s -> %s',
            [Territory^.Id, DescKindName(Kind),
             BuildE164(Territory^.CountryCode, Desc^.ExampleNumber),
             NumberTypeToString(ActualType)]));
      end;
    end;

    Assert.AreEqual(ExpectedExampleNumberCount, Checked,
      'Every example number belongs to a real PhoneNumberType.');

    { Informational: a number can legitimately be typed differently from the
      description it was taken from when its region resolves to the main region
      of a shared calling code (NANPA is full of this). }
    Mismatched := OtherType.Count;
    if Mismatched > 0 then
      ReportList('example numbers typed differently than their own description',
        OtherType.ToStringArray);

    if Unknowns.Count > 0 then
      ReportList('example numbers typed UNKNOWN', Unknowns.ToStringArray);

    Assert.AreEqual(0, Unknowns.Count,
      Format('%d example numbers are typed UNKNOWN (first: %s).',
        [Unknowns.Count, FirstOrEmpty(Unknowns)]));
  finally
    OtherType.Free;
    Unknowns.Free;
  end;
end;

procedure TMetadataCoreTests.ExampleNumbers_ArePossible_ForEveryTerritory;
var
  I: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Reason: TMetadataValidationResult;
  Failures: TStringList;
begin
  Failures := TStringList.Create;
  try
    for I := 0 to GetTerritoryCount - 1 do
    begin
      Territory := GetTerritory(I);
      for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
      begin
        Desc := GetDesc(Territory, Kind);
        if Desc^.ExampleNumber = '' then
          Continue;
        Reason := IsPossibleNumberWithReason(Territory^.CountryCode,
          Desc^.ExampleNumber);
        if Reason <> mvrIsPossible then
          Failures.Add(Format('%s/%s %s -> %s', [Territory^.Id, DescKindName(Kind),
            BuildE164(Territory^.CountryCode, Desc^.ExampleNumber),
            ValidationResultToString(Reason)]));
      end;
    end;

    ReportList('example numbers that are not IS_POSSIBLE',
      Failures.ToStringArray);

    AssertMatchesDocumentedList(Failures, KnownNotFullyPossibleExampleNumbers,
      'example numbers that are not IS_POSSIBLE');
  finally
    Failures.Free;
  end;
end;

procedure TMetadataCoreTests.ExampleNumbers_ResolveToACandidateRegion;
var
  I: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Region: string;
  Failures: TStringList;
begin
  Failures := TStringList.Create;
  try
    for I := 0 to GetTerritoryCount - 1 do
    begin
      Territory := GetTerritory(I);
      for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
      begin
        Desc := GetDesc(Territory, Kind);
        if Desc^.ExampleNumber = '' then
          Continue;
        Region := GetRegionCodeForNumber(Territory^.CountryCode, Desc^.ExampleNumber);
        if not RegionIsCandidateForCountryCode(Region, Territory^.CountryCode) then
          Failures.Add(Format('%s/%s %s -> "%s"', [Territory^.Id, DescKindName(Kind),
            BuildE164(Territory^.CountryCode, Desc^.ExampleNumber), Region]));
      end;
    end;

    if Failures.Count > 0 then
      ReportList('example numbers resolving outside their calling code',
        Failures.ToStringArray);

    Assert.AreEqual(0, Failures.Count,
      Format('%d example numbers do not resolve to a candidate region (first: %s).',
        [Failures.Count, FirstOrEmpty(Failures)]));
  finally
    Failures.Free;
  end;
end;

procedure TMetadataCoreTests.ExampleNumbers_ResolveExactly_ForMajorRegions;
const
  ExactRegions: array[0..2] of string = ('US', 'GB', 'DE');
var
  R: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Checked: Integer;
begin
  Checked := 0;
  for R := Low(ExactRegions) to High(ExactRegions) do
  begin
    Assert.IsTrue(TryGetMetadataForRegion(ExactRegions[R], Territory),
      'Region not found: ' + ExactRegions[R]);
    for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
    begin
      Desc := GetDesc(Territory, Kind);
      if Desc^.ExampleNumber = '' then
        Continue;
      Inc(Checked);
      Assert.AreEqual(ExactRegions[R],
        GetRegionCodeForNumber(Territory^.CountryCode, Desc^.ExampleNumber),
        Format('%s/%s %s resolved to the wrong region',
          [ExactRegions[R], DescKindName(Kind),
           BuildE164(Territory^.CountryCode, Desc^.ExampleNumber)]));
    end;
  end;
  Assert.IsTrue(Checked >= 10, 'Expected a meaningful number of checks.');
end;

procedure TMetadataCoreTests.ExampleNumbers_ResolveToNonGeoId_ForGlobalNetworkCodes;
var
  Codes: TMetadataIntegerArray;
  I: Integer;
  Kind: TPhoneNumberDescKind;
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Checked: Integer;
begin
  Codes := GetSupportedGlobalNetworkCallingCodes;
  Assert.IsTrue(Length(Codes) > 0, 'Expected non geographical entities.');

  Checked := 0;
  for I := 0 to Length(Codes) - 1 do
  begin
    Assert.IsTrue(TryGetMetadataForNonGeoEntity(Codes[I], Metadata),
      Format('Non geo entity %d not found', [Codes[I]]));
    for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
    begin
      Desc := GetDesc(Metadata, Kind);
      if Desc^.ExampleNumber = '' then
        Continue;
      Inc(Checked);
      Assert.AreEqual(NonGeoRegionCode,
        GetRegionCodeForNumber(Codes[I], Desc^.ExampleNumber),
        Format('+%d%s must resolve to %s', [Codes[I], Desc^.ExampleNumber,
          NonGeoRegionCode]));
      Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(Codes[I],
        Desc^.ExampleNumber),
        Format('+%d%s must be valid', [Codes[I], Desc^.ExampleNumber]));
    end;
  end;
  Assert.IsTrue(Checked > 0, 'Expected example numbers for the non geo entities.');
end;

{ ---------------------------------------------------------------------------
  Reference corpus
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.ReferenceCases_AreValidOnTheMetadataPath;
var
  RawJson: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  I: Integer;
  CaseName, Input, Country: string;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  Failures, ParseFailures: TStringList;
begin
  Failures := TStringList.Create;
  ParseFailures := TStringList.Create;
  try
    RawJson := TFile.ReadAllText(FindReferenceCasesFile, TEncoding.UTF8);
    JsonValue := TJSONObject.ParseJSONValue(RawJson);
    try
      Assert.IsTrue(JsonValue is TJSONArray, 'Root JSON value must be an array.');
      Cases := JsonValue as TJSONArray;
      Assert.IsTrue(Cases.Count >= 100, 'Expected the full reference corpus.');

      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        CaseName := CaseObj.GetValue<string>('name');
        Input := CaseObj.GetValue<string>('input');
        Country := CaseObj.GetValue<string>('country');

        { A parse failure and a metadata rejection are tracked separately: a
          parser regression on a case that is already an accepted metadata
          exception would otherwise be invisible. }
        if not TPhoneNumberUtil.Parse(Input, Country, Parsed, ParseError) then
        begin
          ParseFailures.Add(Format('%s (%s): parse error %d',
            [CaseName, Input, Ord(ParseError)]));
          Continue;
        end;

        if not LibPhoneNumber.MetadataCore.IsValidNumber(Parsed.CountryCode,
          Parsed.NationalNumberDigits) then
        begin
          Failures.Add(CaseName);
          Report(Format('    %s: +%d%s not valid on the metadata path',
            [CaseName, Parsed.CountryCode, Parsed.NationalNumberDigits]));
        end;
      end;
    finally
      JsonValue.Free;
    end;

    ReportList('reference cases that fail to parse', ParseFailures.ToStringArray);
    ReportList('reference cases rejected by the metadata path',
      Failures.ToStringArray);

    Assert.AreEqual(0, ParseFailures.Count,
      Format('%d reference cases do not parse at all (first: %s).',
        [ParseFailures.Count, FirstOrEmpty(ParseFailures)]));
    AssertMatchesDocumentedList(Failures, KnownInvalidReferenceCases,
      'reference cases rejected by the metadata path');
  finally
    ParseFailures.Free;
    Failures.Free;
  end;
end;

procedure TMetadataCoreTests.ReferenceCases_E164MatchesTheOracle;
var
  RawJson: string;
  JsonValue: TJSONValue;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  I, Compared: Integer;
  CaseName, Input, Country, ExpectedE164, ActualE164: string;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  Divergences: TStringList;
begin
  { Oracle anchored parser gate. Every reference case must parse to exactly the
    E164 output of the C# oracle (which the corpus records alongside the
    identical Java value, cross checked by
    TPhoneNumberUtilTests.ReferenceCases_JavaCSharp_AreConsistent).

    E164 is pure parse fidelity - calling code plus the complete national
    significant number - so a regression of the national prefix handling shows
    up here by name. }
  Divergences := TStringList.Create;
  try
    Compared := 0;
    RawJson := TFile.ReadAllText(FindReferenceCasesFile, TEncoding.UTF8);
    JsonValue := TJSONObject.ParseJSONValue(RawJson);
    try
      Assert.IsTrue(JsonValue is TJSONArray, 'Root JSON value must be an array.');
      Cases := JsonValue as TJSONArray;
      Assert.IsTrue(Cases.Count >= 100, 'Expected the full reference corpus.');

      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        CaseName := CaseObj.GetValue<string>('name');
        Input := CaseObj.GetValue<string>('input');
        Country := CaseObj.GetValue<string>('country');
        ExpectedE164 := CaseObj.GetValue<string>('csharpE164');

        Inc(Compared);
        if not TPhoneNumberUtil.Parse(Input, Country, Parsed, ParseError) then
        begin
          Divergences.Add(Format('%s (%s): parse error %d',
            [CaseName, Input, Ord(ParseError)]));
          Continue;
        end;

        ActualE164 := TPhoneNumberUtil.Format(Parsed, pnfE164);
        if ActualE164 <> ExpectedE164 then
          Divergences.Add(Format('%s (%s): %s, oracle %s',
            [CaseName, Input, ActualE164, ExpectedE164]));
      end;
    finally
      JsonValue.Free;
    end;

    Report(Format('Reference case E164 gate: %d cases compared', [Compared]));
    ReportList('reference cases diverging from the oracle',
      Divergences.ToStringArray);

    AssertIsEmpty(Divergences, ReferenceCasesWithE164Divergence,
      'reference cases diverging from the oracle E164 output');
  finally
    Divergences.Free;
  end;
end;

procedure TMetadataCoreTests.ExampleNumbers_RoundTripThroughTheParser;
var
  I, Compared: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  E164: string;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  Divergences: TStringList;
begin
  { Upstream guarantee, verified against the C# oracle before this test was
    written: parsing the E164 form of an example number in its own region and
    formatting it back as E164 reproduces the input for every example number of
    the baseline. The parser must therefore neither drop nor add a digit - for
    example the significant leading zero of BJ, BW, BZ, CG, CI, FJ, GA, SM and
    TO numbers, whose calling codes have no national prefix.

    On top of the round trip the metadata core must accept the number, so the
    public parser and the validation core are pinned together. }
  Divergences := TStringList.Create;
  try
    Compared := 0;
    for I := 0 to GetTerritoryCount - 1 do
    begin
      Territory := GetTerritory(I);
      for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
      begin
        Desc := GetDesc(Territory, Kind);
        if Desc^.ExampleNumber = '' then
          Continue;

        E164 := BuildE164(Territory^.CountryCode, Desc^.ExampleNumber);
        Inc(Compared);

        if not TPhoneNumberUtil.Parse(E164, Territory^.Id, Parsed, ParseError) then
        begin
          Divergences.Add(Format('%s/%s %s: parse error %d',
            [Territory^.Id, DescKindName(Kind), E164, Ord(ParseError)]));
          Continue;
        end;

        if TPhoneNumberUtil.Format(Parsed, pnfE164) <> E164 then
        begin
          Divergences.Add(Format('%s/%s %s: round trip gave %s',
            [Territory^.Id, DescKindName(Kind), E164,
             TPhoneNumberUtil.Format(Parsed, pnfE164)]));
          Continue;
        end;

        if not LibPhoneNumber.MetadataCore.IsValidNumber(Parsed.CountryCode,
          Parsed.NationalNumberDigits) then
          Divergences.Add(Format('%s/%s %s: not valid after parsing',
            [Territory^.Id, DescKindName(Kind), E164]));
      end;
    end;

    Report(Format('Example number round trip: %d numbers compared', [Compared]));
    ReportList('example numbers diverging on the parser round trip',
      Divergences.ToStringArray);

    AssertIsEmpty(Divergences, ExampleNumbersWithParserDivergence,
      'example numbers diverging on the parser round trip');
  finally
    Divergences.Free;
  end;
end;

procedure TMetadataCoreTests.ExampleNumbers_FormatThroughTheEngine;
var
  I, Compared: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  E164, Nsn, Prefix: string;
  International, National, Rfc3966: string;
  Parsed, ReParsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  Divergences: TStringList;

  procedure Diverge(const AWhat: string);
  begin
    Divergences.Add(Format('%s/%s %s: %s',
      [Territory^.Id, DescKindName(Kind), E164, AWhat]));
  end;

begin
  { Gate for the metadata driven format engine, run over the whole example
    number inventory of the pinned baseline - every territory and every number
    type.

    Three properties are checked per number and format:

    1. Formatting neither raises nor returns an empty string. The engine falls
       back to the bare national significant number when no numberFormat
       matches (upstream formatNsn does exactly that), so "empty" can only mean
       a defect.
    2. RFC3966 output is a tel: URI carrying the calling code, i.e. the
       prefixNumberWithCountryCallingCode branch really ran.
    3. INTERNATIONAL output is LOSSLESS: parsing it back yields the same
       calling code and the same national significant number.

    Property 3 is the invariant that actually pins the grouping logic. A naive
    "the national form must still contain the NSN digits" check would be wrong
    here: several territories deliberately drop or inject digits in their
    NATIONAL layout - Argentina formats a mobile number 9AAxxxxxxx as
    "AA 15-xxxx-xxxx", dropping the 9 and inserting 15 - so only the
    international form is required to round trip. }
  Divergences := TStringList.Create;
  try
    Compared := 0;
    for I := 0 to GetTerritoryCount - 1 do
    begin
      Territory := GetTerritory(I);
      for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
      begin
        Desc := GetDesc(Territory, Kind);
        if Desc^.ExampleNumber = '' then
          Continue;

        E164 := BuildE164(Territory^.CountryCode, Desc^.ExampleNumber);
        Inc(Compared);

        if not TPhoneNumberUtil.Parse(E164, Territory^.Id, Parsed, ParseError) then
        begin
          Diverge(Format('parse error %d', [Ord(ParseError)]));
          Continue;
        end;
        Nsn := Parsed.NationalNumberDigits;

        try
          International := TPhoneNumberUtil.Format(Parsed, pnfInternational);
          National := TPhoneNumberUtil.Format(Parsed, pnfNational);
          Rfc3966 := TPhoneNumberUtil.Format(Parsed, pnfRfc3966);
        except
          on E: Exception do
          begin
            Diverge('formatting raised ' + E.ClassName + ': ' + E.Message);
            Continue;
          end;
        end;

        if International = '' then
          Diverge('INTERNATIONAL is empty');
        if National = '' then
          Diverge('NATIONAL is empty');
        if Rfc3966 = '' then
          Diverge('RFC3966 is empty');
        if (International = '') or (National = '') or (Rfc3966 = '') then
          Continue;

        Prefix := 'tel:+' + IntToStr(Parsed.CountryCode) + '-';
        if Copy(Rfc3966, 1, Length(Prefix)) <> Prefix then
        begin
          Diverge('RFC3966 [' + Rfc3966 + '] does not start with ' + Prefix);
          Continue;
        end;

        if not TPhoneNumberUtil.Parse(International, Territory^.Id, ReParsed,
          ParseError) then
        begin
          Diverge('INTERNATIONAL [' + International + '] does not parse back, error '
            + IntToStr(Ord(ParseError)));
          Continue;
        end;

        if ReParsed.CountryCode <> Parsed.CountryCode then
          Diverge('INTERNATIONAL [' + International + '] parses back to calling code '
            + IntToStr(ReParsed.CountryCode))
        else if ReParsed.NationalNumberDigits <> Nsn then
          Diverge('INTERNATIONAL [' + International + '] parses back to national number '
            + ReParsed.NationalNumberDigits + ' instead of ' + Nsn);
      end;
    end;

    Assert.AreEqual(ExpectedExampleNumberCount, Compared,
      'Unexpected number of example numbers.');

    Report(Format('Example number formatting: %d numbers x 3 formats compared',
      [Compared]));
    ReportList('example numbers diverging in the format engine',
      Divergences.ToStringArray);

    AssertIsEmpty(Divergences, ExampleNumbersWithFormatDivergence,
      'example numbers diverging in the format engine');
  finally
    Divergences.Free;
  end;
end;

{ ---------------------------------------------------------------------------
  testNumberLength semantics
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.TooShortNumber_IsReportedAsTooShort;
begin
  { DE generalDesc: national lengths 5..15, localOnly 2..4. }
  Assert.AreEqual(Ord(mvrTooShort), Ord(IsPossibleNumberWithReason(49, '1')),
    'A single digit German number must be TOO_SHORT.');
  Assert.AreEqual(Ord(mvrTooShort), Ord(IsPossibleNumberWithReason(1, '20255')),
    'A five digit NANPA number must be TOO_SHORT.');
end;

procedure TMetadataCoreTests.TooLongNumber_IsReportedAsTooLong;
begin
  Assert.AreEqual(Ord(mvrTooLong), Ord(IsPossibleNumberWithReason(49, '3012345678901234')),
    'A 16 digit German number must be TOO_LONG.');
  Assert.AreEqual(Ord(mvrTooLong), Ord(IsPossibleNumberWithReason(1, '20255501234')),
    'An 11 digit NANPA number must be TOO_LONG.');
end;

procedure TMetadataCoreTests.LocalOnlyLength_IsReportedAsLocalOnly;
begin
  { DE declares local only lengths 2..4 on fixedLine, but the derived general
    description already carries 4 as a national length (the German pager range
    allows four digits), and upstream removes national lengths from the general
    local only set. So 2 and 3 are local only, 4 is a regular possible length. }
  Assert.AreEqual(Ord(mvrIsPossibleLocalOnly), Ord(IsPossibleNumberWithReason(49, '123')),
    'A three digit German number must be IS_POSSIBLE_LOCAL_ONLY.');
  Assert.AreEqual(Ord(mvrIsPossible), Ord(IsPossibleNumberWithReason(49, '1234')),
    'Four digits are a national length in Germany (pager range).');
  { US keeps the seven digit subscriber number as local only. }
  Assert.AreEqual(Ord(mvrIsPossibleLocalOnly), Ord(IsPossibleNumberWithReason(1, '5550123')),
    'A seven digit NANPA number must be IS_POSSIBLE_LOCAL_ONLY.');
  { And local only is not valid. }
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(1, '5550123'),
    'A local only number must not be valid.');
end;

procedure TMetadataCoreTests.UnsupportedCallingCode_IsReportedAsInvalidCountryCode;
begin
  Assert.AreEqual(Ord(mvrInvalidCountryCode), Ord(IsPossibleNumberWithReason(999, '1234567')),
    'Calling code 999 is not assigned.');
  Assert.AreEqual(Ord(mvrInvalidCountryCode), Ord(IsPossibleNumberWithReason(0, '1234567')),
    'Calling code 0 is not assigned.');
  Assert.AreEqual(UnknownRegionCode, GetRegionCodeForCountryCode(999),
    'An unassigned calling code must map to the unknown region sentinel.');
  Assert.AreEqual('', GetRegionCodeForNumber(999, '1234567'),
    'An unassigned calling code has no region.');
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(999, '1234567'),
    'An unassigned calling code can never be valid.');
end;

procedure TMetadataCoreTests.TypeWithoutMetadata_IsReportedAsInvalidLength;
begin
  { The US metadata has no pager, voip, uan or voicemail section at all, so the
    corresponding descriptions carry the never matching length -1. }
  Assert.AreEqual(Ord(mvrInvalidLength),
    Ord(IsPossibleNumberForTypeWithReason(1, '2015550123', mntPager)),
    'US has no pager numbers.');
  Assert.AreEqual(Ord(mvrInvalidLength),
    Ord(IsPossibleNumberForTypeWithReason(1, '2015550123', mntVoicemail)),
    'US has no voicemail numbers.');
  Assert.AreEqual(Ord(mvrIsPossible),
    Ord(IsPossibleNumberForTypeWithReason(1, '2015550123', mntFixedLine)),
    'US fixed line numbers have ten digits.');
end;

procedure TMetadataCoreTests.FixedLineOrMobile_MergesBothLengthLists;
var
  Metadata: PPhoneMetadataRec;
  FixedOnly, MobileOnly, Merged: TMetadataValidationResult;
  I, Checked: Integer;
  Territory: PPhoneMetadataRec;
  FixedDesc, MobileDesc: PPhoneNumberDescRec;
  FixedLengths, MobileLengths: TMetadataIntegerArray;
  Probe: string;
begin
  { Directed check: a length that only the mobile description allows must still
    be IS_POSSIBLE for FIXED_LINE_OR_MOBILE. Search the baseline for a
    territory that actually has such a length. }
  Checked := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    FixedDesc := GetDesc(Territory, pdkFixedLine);
    MobileDesc := GetDesc(Territory, pdkMobile);
    if not DescHasPossibleNumberData(FixedDesc) then
      Continue;
    if not DescHasPossibleNumberData(MobileDesc) then
      Continue;
    FixedLengths := GetEffectivePossibleLengths(Territory, pdkFixedLine);
    MobileLengths := GetEffectivePossibleLengths(Territory, pdkMobile);
    if (Length(FixedLengths) = 0) or (Length(MobileLengths) = 0) then
      Continue;

    { Look for a mobile only length. }
    Probe := '';
    if MobileLengths[Length(MobileLengths) - 1] > FixedLengths[Length(FixedLengths) - 1] then
      Probe := StringOfChar('2', MobileLengths[Length(MobileLengths) - 1]);
    if Probe = '' then
      Continue;

    Metadata := Territory;
    FixedOnly := TestNumberLengthForType(Probe, Metadata, mntFixedLine);
    MobileOnly := TestNumberLengthForType(Probe, Metadata, mntMobile);
    Merged := TestNumberLengthForType(Probe, Metadata, mntFixedLineOrMobile);

    Assert.AreNotEqual(Ord(mvrIsPossible), Ord(FixedOnly),
      Territory^.Id + ': the probe length must not be a fixed line length.');
    Assert.AreEqual(Ord(mvrIsPossible), Ord(MobileOnly),
      Territory^.Id + ': the probe length must be a mobile length.');
    Assert.AreEqual(Ord(mvrIsPossible), Ord(Merged),
      Territory^.Id + ': FIXED_LINE_OR_MOBILE must merge the mobile lengths in.');

    Inc(Checked);
    if Checked >= 5 then
      Break;
  end;

  Assert.IsTrue(Checked > 0,
    'Expected at least one territory with a mobile only possible length.');
end;

procedure TMetadataCoreTests.FixedLineOrMobile_FallsBackToMobile_WhenNoFixedLineData;
var
  I, Checked: Integer;
  Territory: PPhoneMetadataRec;
  Probe: string;
  MobileLengths: TMetadataIntegerArray;
begin
  { Upstream: if there is no fixedLine possible number data at all (true for
    some non geographical entities), FIXED_LINE_OR_MOBILE degenerates to
    MOBILE. }
  Checked := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    if DescHasPossibleNumberData(GetDesc(Territory, pdkFixedLine)) then
      Continue;
    if not DescHasPossibleNumberData(GetDesc(Territory, pdkMobile)) then
      Continue;
    MobileLengths := GetEffectivePossibleLengths(Territory, pdkMobile);
    if Length(MobileLengths) = 0 then
      Continue;

    Probe := StringOfChar('2', MobileLengths[0]);
    Assert.AreEqual(
      Ord(TestNumberLengthForType(Probe, Territory, mntMobile)),
      Ord(TestNumberLengthForType(Probe, Territory, mntFixedLineOrMobile)),
      Territory^.Id + ': FIXED_LINE_OR_MOBILE must fall back to MOBILE.');
    Inc(Checked);
    if Checked >= 5 then
      Break;
  end;

  Assert.IsTrue(Checked > 0,
    'Expected at least one territory without fixed line data.');
end;

procedure TMetadataCoreTests.LocalOnlyLengths_ExistAndBehaveConsistently;
var
  I, Checked: Integer;
  Territory: PPhoneMetadataRec;
  GeneralDesc: PPhoneNumberDescRec;
  LocalOnly: TMetadataIntegerArray;
  Probe: string;
begin
  Checked := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    GeneralDesc := GetDesc(Territory, pdkGeneralDesc);
    LocalOnly := GetPossibleLengthsLocalOnly(GeneralDesc);
    if Length(LocalOnly) = 0 then
      Continue;

    Probe := StringOfChar('2', LocalOnly[0]);
    Assert.AreEqual(Ord(mvrIsPossibleLocalOnly),
      Ord(IsPossibleNumberWithReason(Territory^.CountryCode, Probe)),
      Format('%s: length %d must be IS_POSSIBLE_LOCAL_ONLY',
        [Territory^.Id, LocalOnly[0]]));
    Assert.IsTrue(IsPossibleNumber(Territory^.CountryCode, Probe),
      Territory^.Id + ': a local only number counts as possible.');

    Inc(Checked);
    if Checked >= 20 then
      Break;
  end;

  Assert.IsTrue(Checked > 0,
    'Expected local only lengths somewhere in the baseline.');
end;

{ ---------------------------------------------------------------------------
  Typing and region spot checks
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.GermanNumbers_AreTypedLikeUpstream;
begin
  Assert.AreEqual('FIXED_LINE', NumberTypeToString(GetNumberType(49, '30123456')),
    '+49 30 123456 is a Berlin fixed line number.');
  Assert.AreEqual('MOBILE', NumberTypeToString(GetNumberType(49, '15123456789')),
    '+49 151 23456789 is a mobile number.');
  Assert.AreEqual('TOLL_FREE', NumberTypeToString(GetNumberType(49, '8001234567890')),
    '+49 800 ... is toll free.');
  Assert.AreEqual('DE', GetRegionCodeForNumber(49, '30123456'));
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(49, '30123456'));
  Assert.IsFalse(LibPhoneNumber.MetadataCore.IsValidNumber(49, '30'),
    'A bare German area code is not a valid number.');
end;

procedure TMetadataCoreTests.UnitedStatesNumbers_AreFixedLineOrMobile;
begin
  { The US metadata uses the same pattern for fixed line and mobile. }
  Assert.AreEqual('FIXED_LINE_OR_MOBILE',
    NumberTypeToString(GetNumberType(1, '2015550123')));
  Assert.AreEqual('TOLL_FREE', NumberTypeToString(GetNumberType(1, '8002345678')));
  Assert.AreEqual('PREMIUM_RATE', NumberTypeToString(GetNumberType(1, '9002345678')));
  Assert.AreEqual('US', GetRegionCodeForNumber(1, '2015550123'));
end;

procedure TMetadataCoreTests.IsValidNumberForRegion_RejectsMismatchedRegion;
begin
  { A German number is not valid "for US": the calling code does not match. }
  Assert.IsFalse(IsValidNumberForRegion(49, '30123456', 'US'));
  { An unknown region has no metadata. }
  Assert.IsFalse(IsValidNumberForRegion(49, '30123456', 'ZZ'));
  Assert.IsFalse(IsValidNumberForRegion(49, '30123456', ''));
  { But it is valid for its own region. }
  Assert.IsTrue(IsValidNumberForRegion(49, '30123456', 'DE'));
end;

procedure TMetadataCoreTests.IsValidNumberForRegion_AcceptsSiblingRegionsOfSharedCallingCode;
var
  Metadata: PPhoneMetadataRec;
  Example: string;
begin
  { Canada shares calling code 1 with the US. isValidNumber resolves the region
    to the main country (US) and still accepts the number, while
    isValidNumberForRegion can name CA explicitly. }
  Assert.IsTrue(TryGetMetadataForRegion('CA', Metadata), 'CA metadata missing.');
  Example := GetDesc(Metadata, pdkFixedLine)^.ExampleNumber;
  Assert.AreNotEqual('', Example, 'CA needs a fixed line example number.');

  Assert.IsTrue(IsValidNumberForRegion(1, Example, 'CA'),
    'The Canadian example number must be valid for CA.');
  Assert.IsTrue(LibPhoneNumber.MetadataCore.IsValidNumber(1, Example),
    'The Canadian example number must be valid.');
  Assert.IsTrue(RegionIsCandidateForCountryCode(
    GetRegionCodeForNumber(1, Example), 1),
    'The resolved region must belong to calling code 1.');
end;

{ ---------------------------------------------------------------------------
  Parsing helpers
  --------------------------------------------------------------------------- }

procedure TMetadataCoreTests.ExtractCountryCode_TakesTheKnownCallingCodePrefix;
var
  Nsn: string;
begin
  { Upstream extractCountryCode walks 1..3 leading digits and takes the first
    prefix that is a known calling code. }
  Assert.AreEqual(44, ExtractCountryCode('442079460321', Nsn));
  Assert.AreEqual('2079460321', Nsn);

  Assert.AreEqual(1, ExtractCountryCode('12025550123', Nsn));
  Assert.AreEqual('2025550123', Nsn);

  { Three digit code in front of a national number that itself starts with a
    zero (the trunk zero case). }
  Assert.AreEqual(229, ExtractCountryCode('2290195123456', Nsn));
  Assert.AreEqual('0195123456', Nsn);

  { Calling codes never start with a zero. }
  Assert.AreEqual(0, ExtractCountryCode('0123456789', Nsn));
  Assert.AreEqual('', Nsn);

  { 9, 99 and 999 are not assigned. }
  Assert.AreEqual(0, ExtractCountryCode('9991234567', Nsn));
  Assert.AreEqual('', Nsn);
end;

procedure TMetadataCoreTests.ParsePrefixAsIdd_UsesTheMetadataInternationalPrefix;
var
  Metadata: PPhoneMetadataRec;
  UsIdd, DeIdd, AuIdd: string;
  Number: string;
begin
  Assert.IsTrue(TryGetMetadataForRegion('US', Metadata), 'US metadata missing.');
  UsIdd := Metadata^.InternationalPrefix;
  Assert.AreEqual('011', UsIdd, 'US must dial out with 011.');

  Assert.IsTrue(TryGetMetadataForRegion('DE', Metadata), 'DE metadata missing.');
  DeIdd := Metadata^.InternationalPrefix;
  Assert.AreEqual('00', DeIdd, 'DE must dial out with 00.');

  Assert.IsTrue(TryGetMetadataForRegion('AU', Metadata), 'AU metadata missing.');
  AuIdd := Metadata^.InternationalPrefix;

  Number := '01144207946032';
  Assert.IsTrue(ParsePrefixAsIdd(UsIdd, Number), 'US IDD 011 not recognised.');
  Assert.AreEqual('44207946032', Number);

  { The NANP does not dial out with 00, so a leading 00 must survive. }
  Number := '0049151123456';
  Assert.IsFalse(ParsePrefixAsIdd(UsIdd, Number), '00 must not be an IDD for the NANP.');
  Assert.AreEqual('0049151123456', Number, 'The number must not be modified.');

  Number := '004420794603';
  Assert.IsTrue(ParsePrefixAsIdd(DeIdd, Number), 'DE IDD 00 not recognised.');
  Assert.AreEqual('4420794603', Number);

  { AU declares an alternation whose preferred branch is the four digit 0011. }
  Number := '00114420794603';
  Assert.IsTrue(ParsePrefixAsIdd(AuIdd, Number), 'AU IDD 0011 not recognised.');
  Assert.AreEqual('4420794603', Number);

  { Upstream refuses the strip when the next digit is a zero, because no
    calling code starts with one. }
  Number := '000123456';
  Assert.IsFalse(ParsePrefixAsIdd(DeIdd, Number),
    'A zero behind the IDD must block the strip.');
  Assert.AreEqual('000123456', Number, 'The number must not be modified.');
end;

procedure TMetadataCoreTests.MaybeStripNationalPrefix_LeavesTerritoriesWithoutNationalPrefixAlone;
const
  Cases: array[0..3] of string = ('BJ', 'CG', 'CI', 'IT');
  Numbers: array[0..3] of string = (
    '0195123456', '061234567', '0123456789', '0212345678');
var
  I: Integer;
  Metadata: PPhoneMetadataRec;
  Number, CarrierCode: string;
begin
  { The trunk zero case: these territories carry no
    nationalPrefixForParsing at all, so their leading zero is part of the
    national significant number and must never be removed. }
  for I := Low(Cases) to High(Cases) do
  begin
    Assert.IsTrue(TryGetMetadataForRegion(Cases[I], Metadata),
      Cases[I] + ' metadata missing.');
    Assert.AreEqual('', Metadata^.NationalPrefixForParsing,
      Cases[I] + ' unexpectedly declares a nationalPrefixForParsing.');

    Number := Numbers[I];
    Assert.IsFalse(MaybeStripNationalPrefixAndCarrierCode(Number, Metadata, CarrierCode),
      Cases[I] + ': nothing may be stripped.');
    Assert.AreEqual(Numbers[I], Number, Cases[I] + ': the number was modified.');
    Assert.AreEqual('', CarrierCode, Cases[I] + ': unexpected carrier code.');
  end;
end;

procedure TMetadataCoreTests.MaybeStripNationalPrefix_StripsWhatTheMetadataDeclares;
var
  Metadata: PPhoneMetadataRec;
  Number, CarrierCode: string;
begin
  Assert.IsTrue(TryGetMetadataForRegion('DE', Metadata), 'DE metadata missing.');
  Number := '0301234567';
  Assert.IsTrue(MaybeStripNationalPrefixAndCarrierCode(Number, Metadata, CarrierCode));
  Assert.AreEqual('301234567', Number, 'DE declares the national prefix 0.');

  Assert.IsTrue(TryGetMetadataForRegion('GB', Metadata), 'GB metadata missing.');
  Number := '02079460321';
  Assert.IsTrue(MaybeStripNationalPrefixAndCarrierCode(Number, Metadata, CarrierCode));
  Assert.AreEqual('2079460321', Number, 'GB declares the national prefix 0.');

  Assert.IsTrue(TryGetMetadataForRegion('US', Metadata), 'US metadata missing.');
  Number := '12025550123';
  Assert.IsTrue(MaybeStripNationalPrefixAndCarrierCode(Number, Metadata, CarrierCode));
  Assert.AreEqual('2025550123', Number, 'The NANP trunk prefix is 1, not 0.');
end;

procedure TMetadataCoreTests.MaybeStripNationalPrefix_KeepsTheNumberViable;
var
  Metadata: PPhoneMetadataRec;
  GeneralDesc: PPhoneNumberDescRec;
  Number, CarrierCode: string;
begin
  { Upstream rolls the strip back when the original number matched the general
    description and the stripped one no longer does. Japanese 00xy numbers are
    exactly that case: nationalPrefixForParsing ends in a plain 0, but
    0012345678 is a viable Japanese number while 012345678 is not. }
  Assert.IsTrue(TryGetMetadataForRegion('JP', Metadata), 'JP metadata missing.');
  GeneralDesc := GetDesc(Metadata, pdkGeneralDesc);
  Assert.IsTrue(MatchesNationalNumberPattern('0012345678', GeneralDesc),
    'Precondition: 0012345678 must be viable for JP.');
  Assert.IsFalse(MatchesNationalNumberPattern('012345678', GeneralDesc),
    'Precondition: 012345678 must not be viable for JP.');

  Number := '0012345678';
  Assert.IsFalse(MaybeStripNationalPrefixAndCarrierCode(Number, Metadata, CarrierCode),
    'A strip that destroys viability must be rolled back.');
  Assert.AreEqual('0012345678', Number, 'The number was modified anyway.');
end;

procedure TMetadataCoreTests.MaybeStripNationalPrefix_AppliesTheTransformRule;
var
  Metadata: PPhoneMetadataRec;
  Number, CarrierCode: string;
begin
  { San Marino uses nationalPrefixForParsing/nationalPrefixTransformRule to
    expand a six digit local number to the full national number. }
  Assert.IsTrue(TryGetMetadataForRegion('SM', Metadata), 'SM metadata missing.');
  Assert.AreEqual('0549$1', Metadata^.NationalPrefixTransformRule);
  Number := '886377';
  Assert.IsTrue(MaybeStripNationalPrefixAndCarrierCode(Number, Metadata, CarrierCode));
  Assert.AreEqual('0549886377', Number, 'The SM transform rule was not applied.');

  { A number that is already national must stay untouched: the pattern is
    anchored on both ends and cannot match ten digits. }
  Number := '0549886377';
  Assert.IsFalse(MaybeStripNationalPrefixAndCarrierCode(Number, Metadata, CarrierCode));
  Assert.AreEqual('0549886377', Number);
end;

function TMetadataCoreTests.CapturingGroupBody(const APattern: string;
  AIndex: Integer): string;
var
  I, Len, Depth, Seen, Start: Integer;
  InClass: Boolean;
begin
  { Returns the body of the AIndex-th capturing group, i.e. what stands between
    its parentheses. Mirrors the group counting of
    LibPhoneNumber.Regex.CountCapturingGroups. }
  Result := '';
  Seen := 0;
  InClass := False;
  I := 1;
  Len := Length(APattern);
  while I <= Len do
  begin
    if APattern[I] = '\' then
      Inc(I)
    else if (APattern[I] = '[') and not InClass then
      InClass := True
    else if (APattern[I] = ']') and InClass then
      InClass := False
    else if (APattern[I] = '(') and not InClass then
    begin
      if (I = Len) or (APattern[I + 1] <> '?') then
      begin
        Inc(Seen);
        if Seen = AIndex then
        begin
          Start := I + 1;
          Depth := 1;
          Inc(I);
          while (I <= Len) and (Depth > 0) do
          begin
            if APattern[I] = '\' then
              Inc(I)
            else if (APattern[I] = '[') and not InClass then
              InClass := True
            else if (APattern[I] = ']') and InClass then
              InClass := False
            else if not InClass then
            begin
              if APattern[I] = '(' then
                Inc(Depth)
              else if APattern[I] = ')' then
              begin
                Dec(Depth);
                if Depth = 0 then
                  Exit(Copy(APattern, Start, I - Start));
              end;
            end;
            Inc(I);
          end;
          Exit;
        end;
      end;
    end;
    Inc(I);
  end;
end;

procedure TMetadataCoreTests.NationalPrefixForParsing_HasNoGroupThatCanMatchEmpty;
var
  I, G, Checked: Integer;
  Territory: PPhoneMetadataRec;
  Pattern, Body: string;
begin
  { LibPhoneNumber.Regex derives "this capturing group participated" from
    the group length being greater than zero, because PCRE maps the unset
    offset pair onto index 1 / length 0 and therefore cannot tell an unset
    group from one that matched the empty string. That shortcut is only correct
    while no capturing group of a nationalPrefixForParsing pattern can match
    empty - which is what this test pins down. If upstream ever ships such a
    pattern, MaybeStripNationalPrefixAndCarrierCode would take the wrong branch
    and this test fails first. }
  Checked := 0;
  for I := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(I);
    Pattern := Territory^.NationalPrefixForParsing;
    if Pattern = '' then
      Continue;

    for G := 1 to CountCapturingGroups(Pattern) do
    begin
      Body := CapturingGroupBody(Pattern, G);
      Assert.IsTrue(Body <> '',
        Format('%s: could not extract capturing group %d of "%s".',
          [Territory^.Id, G, Pattern]));
      Assert.IsFalse(TryMatchFull(Body, ''),
        Format('%s: capturing group %d of "%s" can match the empty string.',
          [Territory^.Id, G, Pattern]));
      Inc(Checked);
    end;
  end;

  Report(Format('Capturing groups of nationalPrefixForParsing checked: %d', [Checked]));
  Assert.IsTrue(Checked > 0, 'No capturing group was checked at all.');
end;


{ ------------------------------------------------------------------
  Entry path of parseHelper.
  ------------------------------------------------------------------ }

procedure TMetadataCoreTests.UnicodeDecimalDigits_CoverTheBmpNdRuns;
const
  { The Nd runs the reference oracle reports for the BMP; the port stores the
    DIGIT ZERO of each one. }
  ZeroCodePoints: array[0..36] of Integer = (
    $0030, $0660, $06F0, $07C0, $0966, $09E6, $0A66, $0AE6, $0B66, $0BE6,
    $0C66, $0CE6, $0D66, $0DE6, $0E50, $0ED0, $0F20, $1040, $1090, $17E0,
    $1810, $1946, $19D0, $1A80, $1A90, $1B50, $1BB0, $1C40, $1C50, $A620,
    $A8D0, $A900, $A9D0, $A9F0, $AA50, $ABF0, $FF10);
var
  I, K, Total: Integer;
begin
  { Every run is ten consecutive code points with the values 0..9, and there
    are exactly 370 decimal digits in the BMP. Both facts are read off the
    oracle runtime (System.Char.IsDigit / GetNumericValue over U+0000..U+FFFF)
    and are what makes the compact zero table exact. }
  Total := 0;
  for I := 0 to High(ZeroCodePoints) do
    for K := 0 to 9 do
    begin
      Assert.AreEqual(K, UnicodeDecimalDigitValue(WideChar(ZeroCodePoints[I] + K)),
        Format('U+%.4X must have the decimal value %d.',
          [ZeroCodePoints[I] + K, K]));
      Inc(Total);
    end;
  Assert.AreEqual(370, Total);

  Assert.AreEqual(-1, UnicodeDecimalDigitValue('a'));
  Assert.AreEqual(-1, UnicodeDecimalDigitValue('+'));
  Assert.AreEqual(-1, UnicodeDecimalDigitValue(WideChar($00B2)),
    'U+00B2 SUPERSCRIPT TWO is category No, not Nd.');
  Assert.IsFalse(IsUnicodeDecimalDigit(WideChar($3007)),
    'U+3007 IDEOGRAPHIC NUMBER ZERO is category Nl, not Nd.');
end;

procedure TMetadataCoreTests.NormalizeDigits_MapsNonAsciiDigitsToAscii;
begin
  Assert.AreEqual('650', NormalizeDigitsOnly('6-5-0'));
  Assert.AreEqual('650',
    NormalizeDigitsOnly(string(WideChar($FF16)) + string(WideChar($FF15))
      + string(WideChar($FF10))), 'Full width digits.');
  Assert.AreEqual('650',
    NormalizeDigitsOnly(string(WideChar($0666)) + string(WideChar($0665))
      + string(WideChar($0660))), 'Arabic-Indic digits.');
  Assert.AreEqual('650',
    NormalizeDigitsOnly(string(WideChar($096C)) + string(WideChar($096B))
      + string(WideChar($0966))), 'Devanagari digits.');

  { keepNonDigits keeps everything else verbatim. }
  Assert.AreEqual('6-5 0',
    NormalizeDigits(string(WideChar($FF16)) + '-' + string(WideChar($0665))
      + ' 0', True));

  { normalizeDiallableCharsOnly is normalizeHelper over
    DIALLABLE_CHAR_MAPPINGS, whose table has ASCII digits only, so a full
    width digit is REMOVED there instead of being normalised. }
  Assert.AreEqual('60', NormalizeDiallableCharsOnly('6'
    + string(WideChar($FF15)) + '0'));
end;

procedure TMetadataCoreTests.ExtractPossibleNumber_PortsTheUpstreamSteps;
begin
  { VALID_START_CHAR_PATTERN: everything before the first plus or digit goes. }
  Assert.AreEqual('650 253 0000', ExtractPossibleNumber('Tel: 650 253 0000'));
  Assert.AreEqual('1234', ExtractPossibleNumber('*1234'),
    'A star is not a start character, so it is dropped.');
  Assert.AreEqual('', ExtractPossibleNumber('abc-def'),
    'No start character at all yields the empty string.');

  { UNWANTED_END_CHAR_PATTERN: the trailing run of non letter, non number
    characters, hash excluded. }
  Assert.AreEqual('650 253 0000', ExtractPossibleNumber('650 253 0000...'));
  Assert.AreEqual('650 253 0000', ExtractPossibleNumber('650 253 0000)'));
  Assert.AreEqual('650 253 0000#', ExtractPossibleNumber('650 253 0000#'),
    'The hash is retained: it may signal an extension.');
  Assert.AreEqual('650 253 0000 x', ExtractPossibleNumber('650 253 0000 x'),
    'A trailing letter is not an unwanted end character.');

  { SECOND_NUMBER_START_PATTERN. }
  Assert.AreEqual('530) 583-6985 x302',
    ExtractPossibleNumber('(530) 583-6985 x302/x2303'),
    'The leading parenthesis goes with the VALID_START_CHAR step.');
  Assert.AreEqual('530) 583-6985 x302',
    ExtractPossibleNumber('(530) 583-6985 x302\x2303'));
  Assert.AreEqual('530) 583-6985 x302',
    ExtractPossibleNumber('(530) 583-6985 x302/ x2303'),
    'Spaces are allowed between the slash and the x.');
  Assert.AreEqual('530 583 6985/X2303',
    ExtractPossibleNumber('530 583 6985/X2303'),
    'SECOND_NUMBER_START is compiled without the case insensitive flag.');
end;

procedure TMetadataCoreTests
  .ExtractPossibleNumber_TreatsALoneSurrogateAsUnwanted;
begin
  { A LONE surrogate is a code point of the general category Cs, neither a
    letter nor a number, so UNWANTED_END_CHARS strips it like any other
    trailing junk. java.util.regex and the .NET oracle agree on Cs; the value
    is not copied from a test suite. The surrogate aware RTL overloads RAISE
    on such a code unit, which is what this test pins against: until the
    FreePascal runtime gate's character sweep found it, ExtractPossibleNumber
    threw EArgumentOutOfRangeException here. }
  Assert.AreEqual('650 253 0000',
    ExtractPossibleNumber('650 253 0000' + string(WideChar($D800))),
    'Trailing lone high surrogate.');
  Assert.AreEqual('650 253 0000',
    ExtractPossibleNumber('650 253 0000' + string(WideChar($DC00))),
    'Trailing lone low surrogate.');
  Assert.AreEqual('650 253 0000',
    ExtractPossibleNumber(string(WideChar($D800)) + '650 253 0000'),
    'A leading lone surrogate is not a start character.');
  Assert.IsTrue(IsUnwantedEndCharBefore(UnicodeString(WideChar($D800)), 1));
  Assert.IsTrue(IsUnwantedEndCharBefore(UnicodeString(WideChar($DC00)), 1));
end;

procedure TMetadataCoreTests.IsViablePhoneNumber_PortsValidPhoneNumber;
begin
  { First alternative: exactly MIN_LENGTH_FOR_NSN digits. }
  Assert.IsTrue(IsViablePhoneNumber('12'));
  Assert.IsFalse(IsViablePhoneNumber('1'));
  Assert.IsFalse(IsViablePhoneNumber(''));
  Assert.IsFalse(IsViablePhoneNumber('1-2'),
    'Two digits with punctuation are neither alternative.');
  Assert.IsTrue(IsViablePhoneNumber(string(WideChar($FF11))
    + string(WideChar($FF12))), 'Full width digits count as digits.');

  { Second alternative: three or more digit groups. }
  Assert.IsTrue(IsViablePhoneNumber('123'));
  Assert.IsTrue(IsViablePhoneNumber('1-2 3'));
  Assert.IsTrue(IsViablePhoneNumber('+1 650 253 0000'));
  Assert.IsTrue(IsViablePhoneNumber('++1 650 253 0000'),
    'A run of plus characters is allowed at the start.');
  Assert.IsTrue(IsViablePhoneNumber('800-FLOWERS'));
  Assert.IsTrue(IsViablePhoneNumber('1*2*3'),
    'The star sign is part of the separator class.');
  Assert.IsFalse(IsViablePhoneNumber('1A2B3C'));
  Assert.IsFalse(IsViablePhoneNumber('+1+1-650-253-0000'),
    'A plus sign in the middle is in no character class of the pattern.');
  { The hash is only reachable through an EXTENSION, and every branch that
    accepts one needs digits behind the marker. Oracle:
    Parse('+49 351 8338916#', 'DE') throws NOT_A_NUMBER, because
    americanStyleExtnWithSuffix caps the digits in front of the hash at six
    and there are seven. The very similar '650 253 0000#' IS viable for
    exactly that reason - the oracle parses it to nsn 650253 with the
    extension '0000'. }
  Assert.IsFalse(IsViablePhoneNumber('+49 351 8338916#'));
  Assert.IsTrue(IsViablePhoneNumber('650 253 0000#'));

  { The optional extension part. Note it belongs to the SECOND alternative
    only, which is why two digits plus an extension are NOT viable. }
  Assert.IsTrue(IsViablePhoneNumber('123;ext=45'));
  Assert.IsFalse(IsViablePhoneNumber('12;ext=34'));
  Assert.IsFalse(IsViablePhoneNumber('+1 650 253 0000;ext=123456789012345678901'),
    'An rfc extension is capped at twenty digits.');
end;

procedure TMetadataCoreTests.MaybeStripExtension_PortsTheExtnPattern;
var
  Number: string;

  function Stripped(const AInput: string; out ARest: string): string;
  begin
    ARest := AInput;
    Result := MaybeStripExtension(ARest);
  end;

begin
  { rfcExtn }
  Assert.AreEqual('1234', Stripped('+1 650 253 0000;ext=1234', Number));
  Assert.AreEqual('+1 650 253 0000', Number);

  { explicitExtn, every label family. }
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 ext. 1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 extension: 1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 xtn 1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 anexo 1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 EXT. 1234', Number),
    'EXTN_PATTERN is case insensitive.');
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 '
    + string(WideChar($0434)) + string(WideChar($043E))
    + string(WideChar($0431)) + ' 1234', Number), 'Cyrillic label.');
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 '
    + string(WideChar($FF45)) + string(WideChar($FF58))
    + string(WideChar($FF54)) + string(WideChar($FF4E)) + ' 1234', Number),
    'Full width label.');
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 extensio'
    + string(WideChar($0301)) + 'n 1234', Number),
    'Combining acute accent on the o.');
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 extensi'
    + string(WideChar($00F3)) + 'n 1234', Number),
    'Precomposed o with acute accent.');

  { ambiguousExtn: nine digits at most. }
  Assert.AreEqual('123456789',
    Stripped('+1 650 253 0000 x123456789', Number));
  Assert.AreEqual('', Stripped('+1 650 253 0000 x1234567890', Number),
    'Ten digits are beyond the ambiguous label cap.');
  Assert.AreEqual('+1 650 253 0000 x1234567890', Number,
    'Nothing is stripped when no alternative matches.');
  Assert.AreEqual('1234', Stripped('+1 650 253 0000#1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000'
    + string(WideChar($FF03)) + '1234', Number), 'Full width hash.');
  Assert.AreEqual('1234', Stripped('+1 650 253 0000~1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000'
    + string(WideChar($FF5E)) + '1234', Number), 'Full width tilde.');
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 int 1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000 '
    + string(WideChar($FF49)) + string(WideChar($FF4E))
    + string(WideChar($FF54)) + ' 1234', Number), 'Full width int.');

  { americanStyleExtnWithSuffix. }
  Assert.AreEqual('503', Stripped('+1 650 253 0000 - 503#', Number));
  Assert.AreEqual('+1 650 253 0000', Number);

  { autoDiallingExtn and onlyCommasExtn. }
  Assert.AreEqual('1234', Stripped('+1 650 253 0000,,1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000;1234', Number));
  Assert.AreEqual('1234', Stripped('+1 650 253 0000,1234', Number));

  { The digits are captured RAW: a full width extension stays full width. }
  Assert.AreEqual(string(WideChar($FF11)) + string(WideChar($FF12)),
    Stripped('+1 650 253 0000 ext. ' + string(WideChar($FF11))
      + string(WideChar($FF12)), Number));

  { The isViablePhoneNumber guard on the part in front of the match. }
  Assert.AreEqual('', Stripped('1AEXT234', Number));
  Assert.AreEqual('1AEXT234', Number,
    'An unviable prefix leaves the number untouched.');

  { A number without any extension is left alone. }
  Assert.AreEqual('', Stripped('+1 650 253 0000', Number));
  Assert.AreEqual('+1 650 253 0000', Number);
end;

procedure TMetadataCoreTests.PhoneContext_FollowsTheRfc3966Syntax;
var
  Value: string;
begin
  Assert.IsFalse(TryExtractPhoneContext('+1 650 253 0000', Value),
    'No phone-context parameter at all.');

  Assert.IsTrue(TryExtractPhoneContext(
    'tel:253-0000;phone-context=+1-650', Value));
  Assert.AreEqual('+1-650', Value);

  Assert.IsTrue(TryExtractPhoneContext(
    'tel:253-0000;phone-context=+1-650;isub=12345', Value),
    'The value ends at the next semicolon.');
  Assert.AreEqual('+1-650', Value);

  Assert.IsTrue(TryExtractPhoneContext('tel:253-0000;phone-context=', Value));
  Assert.AreEqual('', Value, 'A present but empty parameter.');

  { global-number-digits }
  Assert.IsTrue(IsPhoneContextValid('+1-650'));
  Assert.IsTrue(IsPhoneContextValid('+1'));
  Assert.IsTrue(IsPhoneContextValid('+1.(650)'));
  Assert.IsFalse(IsPhoneContextValid('+'), 'At least one digit is required.');
  Assert.IsFalse(IsPhoneContextValid('+1a'));

  { domainname }
  Assert.IsTrue(IsPhoneContextValid('www.google.com'));
  Assert.IsTrue(IsPhoneContextValid('google.com.'),
    'A trailing full stop is allowed.');
  Assert.IsTrue(IsPhoneContextValid('a1-b.example'));
  Assert.IsFalse(IsPhoneContextValid('1-650'),
    'The top label must start with a letter.');
  Assert.IsFalse(IsPhoneContextValid('example-'),
    'A label must not end with a hyphen.');
  Assert.IsFalse(IsPhoneContextValid('[]'));
  Assert.IsFalse(IsPhoneContextValid(''), 'An empty value is invalid.');
end;

procedure TMetadataCoreTests
  .BuildNationalNumberForParsing_HandlesTelUris;
var
  Built: string;
begin
  { No phone-context: extractPossibleNumber. }
  Assert.IsTrue(TryBuildNationalNumberForParsing('Tel: 650 253 0000', Built));
  Assert.AreEqual('650 253 0000', Built);

  { A phone-context that carries a number prefix is prepended. }
  Assert.IsTrue(TryBuildNationalNumberForParsing(
    'tel:253-0000;phone-context=+1-650', Built));
  Assert.AreEqual('+1-650253-0000', Built);

  { A domain phone-context is ignored, only the tel: body survives. }
  Assert.IsTrue(TryBuildNationalNumberForParsing(
    'tel:253-0000;phone-context=www.google.com', Built));
  Assert.AreEqual('253-0000', Built);

  { The tel: prefix may be missing. }
  Assert.IsTrue(TryBuildNationalNumberForParsing(
    '253-0000;phone-context=+1-650', Built));
  Assert.AreEqual('+1-650253-0000', Built);

  { isdn-subaddress and everything behind it is deleted. }
  Assert.IsTrue(TryBuildNationalNumberForParsing(
    'tel:253-0000;isub=12345;phone-context=+1-650', Built));
  Assert.AreEqual('+1-650253-0000', Built);
  Assert.IsTrue(TryBuildNationalNumberForParsing(
    '+1 650 253 0000;isub=12345', Built));
  Assert.AreEqual('+1 650 253 0000', Built);

  { The one case the upstream method rejects itself. }
  Assert.IsFalse(TryBuildNationalNumberForParsing(
    'tel:253-0000;phone-context=1-650', Built));
  Assert.IsFalse(TryBuildNationalNumberForParsing(
    'tel:253-0000;phone-context=', Built));
end;

initialization
  { Explicit registration, like every other fixture of this suite. The
    [TestFixture] attribute alone is enough for DUnitX's RTTI scan, but half
    the units registering explicitly and half relying on the scan is one
    convention too many - and the explicit call is what keeps a fixture in the
    run when a linker or an RTTI setting drops the attribute. }
  TDUnitX.RegisterTestFixture(TMetadataCoreTests);

end.
