unit LibPhoneNumber.UpstreamSuite.Matcher.Tests;

{
  Port of upstream PhoneNumberMatcherTest.java.

  Expected values: see the header of LibPhoneNumber.UpstreamSuite.Tests.
  They come straight out of the Java test class, which is correct here and only
  here, because Setup switches the metadata lookup layer onto the generated
  TESTING tables - the same data set the Java suite runs against - and TearDown
  switches it back.

  Shape of the port
  -----------------
  1. Java iterates an Iterable<PhoneNumberMatch>; this port materialises the
     matches with FindNumbers, except in the four iteration contract tests,
     which drive TPhoneNumberMatcher directly.
  2. PhoneNumberMatch.start()/end() are the upstream ZERO based offsets, and so
     are TPhoneNumberMatch.Start/EndIndex, so every offset assertion is
     literal.
  3. Java's null region is the empty string here, as everywhere in this port.

  Coverage
  --------
  45 of the 46 test methods of PhoneNumberMatcherTest are ported. Not ported:

    testRemovalNotSupported  - Iterator.remove() has no counterpart;
                               TPhoneNumberMatcher has HasNext/Next/TryNext and
                               nothing to remove with.

  Cases that need the alternate format metadata
  ---------------------------------------------
  Seven upstream cases are found at STRICT_GROUPING or EXACT_GROUPING ONLY
  because an alternate format matches them:

    "0900-1 123123"    (DE)  STRICT_GROUPING
    "(0)900-1 123123"  (DE)  STRICT_GROUPING
    "0 900-1 123123"   (DE)  STRICT_GROUPING
    "0900-1 123 123"   (DE)  EXACT_GROUPING
    "(0)900-1 123 123" (DE)  EXACT_GROUPING
    "0 900-1 123 123"  (DE)  EXACT_GROUPING
    "1800-10-10 22"    (AU)  EXACT_GROUPING

  The Java source names the reason in a comment at the six DE cases. The AU
  one it only calls a "Breakdown assistance number", but it is the same case:
  the alternate format block of calling code 61 declares a four-two-two-two
  digit grouping, which is exactly how that candidate is grouped, and no format
  of the ordinary metadata groups it that way.

  PhoneNumberAlternateFormats.xml is a generator input,
  checkNumberGroupingIsValid consults it, and the seven run unflagged like
  every other case.

  Note which metadata they read: the alternate formats are NOT switched with
  the phone metadata. Upstream reaches them through
  DefaultMetadataDependenciesProvider.getInstance(), a static singleton that
  PhoneNumberUtil.setInstance does not touch, so the Java matcher suite matches
  PRODUCTION alternate formats against the TEST phone metadata - and so does
  this fixture.
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
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.TestingMetadata,
  LibPhoneNumber.PhoneNumberMatcher,
  LibPhoneNumber.PhoneNumberUtil;

type
  { Upstream PhoneNumberMatcherTest.NumberTest. }
  TNumberTest = record
    RawString: string;
    Region: string;
  end;
  TNumberTestArray = array of TNumberTest;

  { Upstream PhoneNumberMatcherTest.NumberContext. }
  TNumberContext = record
    LeadingText: string;
    TrailingText: string;
  end;
  TNumberContextArray = array of TNumberContext;

  TUpstreamPhoneNumberMatcherTests = class(TTestCase)
  private
    function ImpossibleCases: TNumberTestArray;
    function PossibleOnlyCases: TNumberTestArray;
    function ValidCases: TNumberTestArray;
    function StrictGroupingCases: TNumberTestArray;
    function ExactGroupingCases: TNumberTestArray;
    function Concat(const A, B: TNumberTestArray): TNumberTestArray; overload;
    function Concat(const A, B, C: TNumberTestArray): TNumberTestArray; overload;
    function Concat(const A, B, C, D: TNumberTestArray): TNumberTestArray; overload;

    function ParseOk(const ANumber, ARegion: string): TPhoneNumber;
    function HasNoMatches(const AText, ARegion: string): Boolean; overload;
    function HasNoMatches(const AText, ARegion: string;
      ALeniency: TPhoneNumberLeniency): Boolean; overload;
    function FirstMatch(const AText, ARegion: string;
      ALeniency: TPhoneNumberLeniency; out AMatch: TPhoneNumberMatch): Boolean;

    procedure AssertMatchProperties(const AMatch: TPhoneNumberMatch;
      AFound: Boolean; const AText, ANumber, ARegion: string);
    procedure AssertEqualRange(const AText: string; AIndex, AStart,
      AEnd: Integer);
    procedure DoTestFindInContext(const ANumber, ADefaultCountry: string);
    procedure FindPossibleInContext(const ANumber, ADefaultCountry: string);
    procedure FindValidInContext(const ANumber, ADefaultCountry: string);
    procedure DoTestInContext(const ANumber, ADefaultCountry: string;
      const AContexts: TNumberContextArray; ALeniency: TPhoneNumberLeniency);
    procedure EnsureTermination(const AText, ADefaultCountry: string;
      ALeniency: TPhoneNumberLeniency);
    procedure FindMatchesInContexts(const AContexts: TNumberContextArray;
      AIsValid, AIsPossible: Boolean; const ARegion, ANumber: string); overload;
    procedure FindMatchesInContexts(const AContexts: TNumberContextArray;
      AIsValid, AIsPossible: Boolean); overload;
    procedure DoTestNumberMatchesForLeniency(const ACases: TNumberTestArray;
      ALeniency: TPhoneNumberLeniency);
    procedure DoTestNumberNonMatchesForLeniency(const ACases: TNumberTestArray;
      ALeniency: TPhoneNumberLeniency);
  public
    procedure Setup; override;
    procedure TearDown; override;

  published
    procedure Test_ContainsMoreThanOneSlashInNationalNumber;
    procedure Test_FindNationalNumber;
    procedure Test_FindWithInternationalPrefixes;
    procedure Test_FindWithLeadingZero;
    procedure Test_FindNationalNumberArgentina;
    procedure Test_FindWithXInNumber;
    procedure Test_FindNumbersMexico;
    procedure Test_FindNumbersWithPlusWithNoRegion;
    procedure Test_FindExtensions;
    procedure Test_FindInterspersedWithSpace;
    procedure Test_IntermediateParsePositions;
    procedure Test_FourMatchesInARow;
    procedure Test_MatchesFoundWithMultipleSpaces;
    procedure Test_MatchWithSurroundingZipcodes;
    procedure Test_IsLatinLetter;
    procedure Test_MatchesWithSurroundingLatinChars;
    procedure Test_MoneyNotSeenAsPhoneNumber;
    procedure Test_PercentageNotSeenAsPhoneNumber;
    procedure Test_PhoneNumberWithLeadingOrTrailingMoneyMatches;
    procedure Test_MatchesWithSurroundingLatinCharsAndLeadingPunctuation;
    procedure Test_MatchesWithSurroundingChineseChars;
    procedure Test_MatchesWithSurroundingPunctuation;
    procedure Test_MatchesMultiplePhoneNumbersSeparatedByPhoneNumberPunctuation;
    procedure Test_DoesNotMatchMultiplePhoneNumbersSeparatedWithNoWhiteSpace;
    procedure Test_MatchesWithPossibleLeniency;
    procedure Test_NonMatchesWithPossibleLeniency;
    procedure Test_MatchesWithValidLeniency;
    procedure Test_NonMatchesWithValidLeniency;
    procedure Test_MatchesWithStrictGroupingLeniency;
    procedure Test_NonMatchesWithStrictGroupLeniency;
    procedure Test_MatchesWithExactGroupingLeniency;
    procedure Test_NonMatchesExactGroupLeniency;
    procedure Test_NonMatchingBracketsAreInvalid;
    procedure Test_NoMatchIfRegionIsNull;
    procedure Test_NoMatchInEmptyString;
    procedure Test_NoMatchIfNoNumber;
    procedure Test_Sequences;
    procedure Test_NullInput;
    procedure Test_MaxMatches;
    procedure Test_MaxMatchesInvalid;
    procedure Test_MaxMatchesMixed;
    procedure Test_NonPlusPrefixedNumbersNotFoundForInvalidRegion;
    procedure Test_EmptyIteration;
    procedure Test_SingleIteration;
    procedure Test_DoubleIteration;
  end;

implementation

uses
{$IFDEF FPC}
  SysUtils;
{$ELSE}
  System.SysUtils;
{$ENDIF}

const
  RC_AR = 'AR';
  RC_AU = 'AU';
  RC_CA = 'CA';
  RC_DE = 'DE';
  RC_FR = 'FR';
  RC_GB = 'GB';
  RC_IT = 'IT';
  RC_MX = 'MX';
  RC_NZ = 'NZ';
  RC_PL = 'PL';
  RC_SG = 'SG';
  RC_US = 'US';
  RC_ZZ = 'ZZ';

function NT(const ARaw, ARegion: string): TNumberTest;
begin
  Result.RawString := ARaw;
  Result.Region := ARegion;
end;

function NC(const ALeading, ATrailing: string): TNumberContext;
begin
  Result.LeadingText := ALeading;
  Result.TrailingText := ATrailing;
end;

{ ---------------------------------------------------------------------------
  Fixture
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberMatcherTests.Setup;
begin
  UseTestingMetadata;
end;

procedure TUpstreamPhoneNumberMatcherTests.TearDown;
begin
  RestoreProductionMetadata;
end;

function TUpstreamPhoneNumberMatcherTests.ParseOk(const ANumber,
  ARegion: string): TPhoneNumber;
var
  Error: TPhoneNumberParseError;
begin
  if not TPhoneNumberUtil.Parse(ANumber, ARegion, Result, Error) then
    Assert.Fail(Format('parse("%s", "%s") failed with error %d',
      [ANumber, ARegion, Ord(Error)]));
end;

function TUpstreamPhoneNumberMatcherTests.HasNoMatches(const AText,
  ARegion: string): Boolean;
begin
  Result := Length(FindNumbers(AText, ARegion)) = 0;
end;

function TUpstreamPhoneNumberMatcherTests.HasNoMatches(const AText,
  ARegion: string; ALeniency: TPhoneNumberLeniency): Boolean;
begin
  Result := Length(FindNumbers(AText, ARegion, ALeniency, UnlimitedTries)) = 0;
end;

function TUpstreamPhoneNumberMatcherTests.FirstMatch(const AText,
  ARegion: string; ALeniency: TPhoneNumberLeniency;
  out AMatch: TPhoneNumberMatch): Boolean;
var
  Matches: TPhoneNumberMatchArray;
begin
  Matches := FindNumbers(AText, ARegion, ALeniency, UnlimitedTries);
  Result := Length(Matches) > 0;
  if Result then
    AMatch := Matches[0]
  else
    AMatch := Default(TPhoneNumberMatch);
end;

function TUpstreamPhoneNumberMatcherTests.Concat(const A,
  B: TNumberTestArray): TNumberTestArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, Length(A) + Length(B));
  for I := 0 to Length(A) - 1 do
    Result[I] := A[I];
  for I := 0 to Length(B) - 1 do
    Result[Length(A) + I] := B[I];
end;

function TUpstreamPhoneNumberMatcherTests.Concat(const A, B,
  C: TNumberTestArray): TNumberTestArray;
begin
  Result := Concat(Concat(A, B), C);
end;

function TUpstreamPhoneNumberMatcherTests.Concat(const A, B, C,
  D: TNumberTestArray): TNumberTestArray;
begin
  Result := Concat(Concat(A, B, C), D);
end;

{ ---------------------------------------------------------------------------
  The upstream case tables
  --------------------------------------------------------------------------- }

function TUpstreamPhoneNumberMatcherTests.ImpossibleCases: TNumberTestArray;
begin
  Result := [
    NT('12345', RC_US),
    NT('23456789', RC_US),
    NT('234567890112', RC_US),
    NT('650+253+1234', RC_US),
    NT('3/10/1984', RC_CA),
    NT('03/27/2011', RC_US),
    NT('31/8/2011', RC_US),
    NT('1/12/2011', RC_US),
    NT('10/12/82', RC_DE),
    NT('650x2531234', RC_US),
    NT('2012-01-02 08:00', RC_US),
    NT('2012/01/02 08:00', RC_US),
    NT('20120102 08:00', RC_US),
    NT('2014-04-12 04:04 PM', RC_US),
    NT('2014-04-12 &nbsp;04:04 PM', RC_US),
    NT('2014-04-12 &nbsp;04:04 PM', RC_US),
    NT('2014-04-12  04:04 PM', RC_US)
  ];
end;

function TUpstreamPhoneNumberMatcherTests.PossibleOnlyCases: TNumberTestArray;
begin
  Result := [
    { US numbers cannot start with 7 in the test metadata to be valid. }
    NT('7121115678', RC_US),
    { 'X' should not be found in numbers at leniencies stricter than POSSIBLE,
      unless it represents a carrier code or extension. }
    NT('1650 x 253 - 1234', RC_US),
    NT('650 x 253 - 1234', RC_US),
    NT('6502531x234', RC_US),
    NT('(20) 3346 1234', RC_GB)
  ];
end;

function TUpstreamPhoneNumberMatcherTests.ValidCases: TNumberTestArray;
begin
  Result := [
    NT('65 02 53 00 00', RC_US),
    NT('6502 538365', RC_US),
    NT('650//253-1234', RC_US),
    NT('650/253/1234', RC_US),
    NT('9002309. 158', RC_US),
    NT('12 7/8 - 14 12/34 - 5', RC_US),
    NT('12.1 - 23.71 - 23.45', RC_US),
    NT('800 234 1 111x1111', RC_US),
    NT('1979-2011 100', RC_US),
    NT('+494949-4-94', RC_DE),
    NT(#$FF14 + #$FF11 + #$FF15 + #$FF16 + #$FF16 + #$FF16 + #$FF16 + '-' +
      #$FF17 + #$FF17 + #$FF17, RC_US),
    NT('2012-0102 08', RC_US),
    NT('2012-01-02 08', RC_US),
    NT('1800-1-0-10 22', RC_AU),
    NT('030-3-2 23 12 34', RC_DE),
    NT('03 0 -3 2 23 12 34', RC_DE),
    NT('(0)3 0 -3 2 23 12 34', RC_DE),
    NT('0 3 0 -3 2 23 12 34', RC_DE),
    NT('+52 332 123 23 23', RC_MX)
  ];
end;

function TUpstreamPhoneNumberMatcherTests.StrictGroupingCases: TNumberTestArray;
begin
  Result := [
    NT('(415) 6667777', RC_US),
    NT('415-6667777', RC_US),
    NT('0800-2491234', RC_DE),
    NT('0900-1 123123', RC_DE),
    NT('(0)900-1 123123', RC_DE),
    NT('0 900-1 123123', RC_DE),
    NT('+33 3 34 2312', RC_FR)
  ];
end;

function TUpstreamPhoneNumberMatcherTests.ExactGroupingCases: TNumberTestArray;
begin
  Result := [
    NT(#$FF14 + #$FF11 + #$FF15 + #$FF16 + #$FF16 + #$FF16 + #$FF17 + #$FF17 +
      #$FF17 + #$FF17, RC_US),
    NT(#$FF14 + #$FF11 + #$FF15 + '-' + #$FF16 + #$FF16 + #$FF16 + '-' +
      #$FF17 + #$FF17 + #$FF17 + #$FF17, RC_US),
    NT('4156667777', RC_US),
    NT('4156667777 x 123', RC_US),
    NT('415-666-7777', RC_US),
    NT('415/666-7777', RC_US),
    NT('415-666-7777 ext. 503', RC_US),
    NT('1 415 666 7777 x 123', RC_US),
    NT('+1 415-666-7777', RC_US),
    NT('+494949 49', RC_DE),
    NT('+49-49-34', RC_DE),
    NT('+49-4931-49', RC_DE),
    NT('04931-49', RC_DE),
    NT('+49-494949', RC_DE),
    NT('+49-494949 ext. 49', RC_DE),
    NT('+49494949 ext. 49', RC_DE),
    NT('0494949', RC_DE),
    NT('0494949 ext. 49', RC_DE),
    NT('01 (33) 3461 2234', RC_MX),
    NT('(33) 3461 2234', RC_MX),
    NT('1800-10-10 22', RC_AU),
    NT('0900-1 123 123', RC_DE),
    NT('(0)900-1 123 123', RC_DE),
    NT('0 900-1 123 123', RC_DE),
    NT('+33 3 34 23 12', RC_FR)
  ];
end;

{ ---------------------------------------------------------------------------
  The upstream helper methods
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberMatcherTests.AssertMatchProperties(
  const AMatch: TPhoneNumberMatch; AFound: Boolean; const AText, ANumber,
  ARegion: string);
var
  Expected: TPhoneNumber;
begin
  Assert.IsTrue(AFound,
    Format('Did not find a number in "%s"; expected %s', [AText, ANumber]));
  Expected := ParseOk(ANumber, ARegion);
  Assert.AreEqual(Expected.CountryCode, AMatch.Number.CountryCode,
    'calling code of the match');
  Assert.AreEqual(Expected.NationalNumberDigits,
    AMatch.Number.NationalNumberDigits, 'national number of the match');
  Assert.AreEqual(Expected.Extension, AMatch.Number.Extension,
    'extension of the match');
  Assert.AreEqual(ANumber, AMatch.RawString, 'raw string of the match');
end;

procedure TUpstreamPhoneNumberMatcherTests.AssertEqualRange(const AText: string;
  AIndex, AStart, AEnd: Integer);
var
  Sub: string;
  Match: TPhoneNumberMatch;
begin
  { AIndex, AStart and AEnd are upstream ZERO based offsets. }
  Sub := Copy(AText, AIndex + 1, MaxInt);
  Assert.IsTrue(FirstMatch(Sub, RC_NZ, pnlPossible, Match),
    Format('No match in "%s"', [Sub]));
  Assert.AreEqual(AStart - AIndex, Match.Start, 'match start');
  Assert.AreEqual(AEnd - AIndex, Match.EndIndex, 'match end');
  Assert.AreEqual(Copy(Sub, Match.Start + 1, Match.EndIndex - Match.Start),
    Match.RawString, 'raw string');
end;

procedure TUpstreamPhoneNumberMatcherTests.DoTestFindInContext(const ANumber,
  ADefaultCountry: string);
var
  Parsed: TPhoneNumber;
begin
  FindPossibleInContext(ANumber, ADefaultCountry);

  Parsed := ParseOk(ANumber, ADefaultCountry);
  if LibPhoneNumber.MetadataCore.IsValidNumber(Parsed.CountryCode,
    Parsed.NationalNumberDigits) then
    FindValidInContext(ANumber, ADefaultCountry);
end;

procedure TUpstreamPhoneNumberMatcherTests.FindPossibleInContext(const ANumber,
  ADefaultCountry: string);
var
  Contexts: TNumberContextArray;
begin
  Contexts := [
    NC('', ''),
    NC('   ', #9),
    NC('Hello ', ''),
    NC('', ' to call me!'),
    NC('Hi there, call ', ' to reach me!'),
    NC('Hi there, call ', ', or don''t'),
    NC('Hi call', ''),
    NC('', 'forme'),
    NC('Hi call', 'forme'),
    NC('It''s cheap! Call ', ' before 6:30'),
    NC('Call ', ' or +1800-123-4567!'),
    NC('Call me on June 2 at', ''),
    NC('As quoted by Alfonso 12-15 (2009), you may call me at ', ''),
    NC('As quoted by Alfonso et al. 12-15 (2009), you may call me at ', ''),
    NC('As I said on 03/10/2011, you may call me at ', ''),
    NC('', ', 45 days a year'),
    NC('', ';x 7246433'),
    NC('Call ', '/x12 more')
  ];
  DoTestInContext(ANumber, ADefaultCountry, Contexts, pnlPossible);
end;

procedure TUpstreamPhoneNumberMatcherTests.FindValidInContext(const ANumber,
  ADefaultCountry: string);
var
  Contexts: TNumberContextArray;
begin
  Contexts := [
    NC('It''s only 9.99! Call ', ' to buy'),
    NC('Call me on 21.6.1984 at ', ''),
    NC('Call me on 06/21 at ', ''),
    NC('Call me on 21.6. at ', ''),
    NC('Call me on 06/21/84 at ', '')
  ];
  DoTestInContext(ANumber, ADefaultCountry, Contexts, pnlValid);
end;

procedure TUpstreamPhoneNumberMatcherTests.DoTestInContext(const ANumber,
  ADefaultCountry: string; const AContexts: TNumberContextArray;
  ALeniency: TPhoneNumberLeniency);
var
  I, Start, Stop: Integer;
  Text, Extracted: string;
  Match: TPhoneNumberMatch;
begin
  for I := 0 to Length(AContexts) - 1 do
  begin
    Text := AContexts[I].LeadingText + ANumber + AContexts[I].TrailingText;
    { Match offsets are UTF-16 code unit offsets (Java String indices) on
      both compilers, so the expected region is measured, and the match cut
      out, on the UnicodeString form; on FreePascal `string` is UTF-8. }
    Start := Length(UnicodeString(AContexts[I].LeadingText));
    Stop := Start + Length(UnicodeString(ANumber));

    Assert.IsTrue(FirstMatch(Text, ADefaultCountry, ALeniency, Match),
      Format('Did not find a number in "%s"; expected "%s"', [Text, ANumber]));

    Extracted := string(Copy(UnicodeString(Text), Match.Start + 1,
      Match.EndIndex - Match.Start));
    Assert.IsTrue((Start = Match.Start) and (Stop = Match.EndIndex),
      Format('Unexpected phone region in "%s"; extracted "%s"',
        [Text, Extracted]));
    Assert.AreEqual(ANumber, Extracted, 'extracted number');
    Assert.AreEqual(Match.RawString, Extracted, 'raw string');

    EnsureTermination(Text, ADefaultCountry, ALeniency);
  end;
end;

procedure TUpstreamPhoneNumberMatcherTests.EnsureTermination(const AText,
  ADefaultCountry: string; ALeniency: TPhoneNumberLeniency);
var
  Index: Integer;
begin
  { Exhaustively searches from every index of AText to make sure finding
    matches always terminates. Upstream discards the results as well. }
  for Index := 0 to Length(AText) do
    FindNumbers(Copy(AText, Index + 1, MaxInt), ADefaultCountry, ALeniency,
      UnlimitedTries);
end;

procedure TUpstreamPhoneNumberMatcherTests.FindMatchesInContexts(
  const AContexts: TNumberContextArray; AIsValid, AIsPossible: Boolean;
  const ARegion, ANumber: string);
var
  I: Integer;
  Text: string;
begin
  if AIsValid then
    DoTestInContext(ANumber, ARegion, AContexts, pnlValid)
  else
    for I := 0 to Length(AContexts) - 1 do
    begin
      Text := AContexts[I].LeadingText + ANumber + AContexts[I].TrailingText;
      Assert.IsTrue(HasNoMatches(Text, ARegion),
        'Should not have found a number in ' + Text);
    end;

  if AIsPossible then
    DoTestInContext(ANumber, ARegion, AContexts, pnlPossible)
  else
    for I := 0 to Length(AContexts) - 1 do
    begin
      Text := AContexts[I].LeadingText + ANumber + AContexts[I].TrailingText;
      Assert.IsTrue(HasNoMatches(Text, ARegion, pnlPossible),
        'Should not have found a number in ' + Text);
    end;
end;

procedure TUpstreamPhoneNumberMatcherTests.FindMatchesInContexts(
  const AContexts: TNumberContextArray; AIsValid, AIsPossible: Boolean);
begin
  FindMatchesInContexts(AContexts, AIsValid, AIsPossible, RC_US, '415-666-7777');
end;

procedure TUpstreamPhoneNumberMatcherTests.DoTestNumberMatchesForLeniency(
  const ACases: TNumberTestArray; ALeniency: TPhoneNumberLeniency);
var
  I, NoMatchFoundCount, WrongMatchFoundCount: Integer;
  Match: TPhoneNumberMatch;
  Report: string;
begin
  NoMatchFoundCount := 0;
  WrongMatchFoundCount := 0;
  Report := '';
  for I := 0 to Length(ACases) - 1 do
  begin
    if not FirstMatch(ACases[I].RawString, ACases[I].Region, ALeniency,
      Match) then
    begin
      Inc(NoMatchFoundCount);
      Report := Report + Format('%sNo match found in "%s" (%s)',
        [sLineBreak, ACases[I].RawString, ACases[I].Region]);
    end
    else if Match.RawString <> ACases[I].RawString then
    begin
      Inc(WrongMatchFoundCount);
      Report := Report + Format('%sFound wrong match in "%s" (%s). Found "%s"',
        [sLineBreak, ACases[I].RawString, ACases[I].Region, Match.RawString]);
    end;
  end;
  Assert.AreEqual(Integer(0), NoMatchFoundCount, Report);
  Assert.AreEqual(Integer(0), WrongMatchFoundCount, Report);
end;

procedure TUpstreamPhoneNumberMatcherTests.DoTestNumberNonMatchesForLeniency(
  const ACases: TNumberTestArray; ALeniency: TPhoneNumberLeniency);
var
  I, MatchFoundCount: Integer;
  Match: TPhoneNumberMatch;
  Report: string;
begin
  MatchFoundCount := 0;
  Report := '';
  for I := 0 to Length(ACases) - 1 do
    if FirstMatch(ACases[I].RawString, ACases[I].Region, ALeniency, Match) then
    begin
      Inc(MatchFoundCount);
      Report := Report + Format('%sMatch found in "%s" (%s)',
        [sLineBreak, ACases[I].RawString, ACases[I].Region]);
    end;
  Assert.AreEqual(Integer(0), MatchFoundCount, Report);
end;

{ ---------------------------------------------------------------------------
  Tests
  --------------------------------------------------------------------------- }

procedure TUpstreamPhoneNumberMatcherTests.Test_ContainsMoreThanOneSlashInNationalNumber;
var
  Number: TPhoneNumber;
begin
  { A date should return true. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 1;
  Number.CountryCodeSource := pnccsFromDefaultCountry;
  Assert.IsTrue(ContainsMoreThanOneSlashInNationalNumber(Number, '1/05/2013'));

  { The country code source thinks it started with a country calling code, but
    that is not the same as the part before the slash, so it's still true. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 274;
  Number.CountryCodeSource := pnccsFromNumberWithoutPlusSign;
  Assert.IsTrue(ContainsMoreThanOneSlashInNationalNumber(Number, '27/4/2013'));

  { Now it should be false, because the first slash is after the country
    calling code. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 49;
  Number.CountryCodeSource := pnccsFromNumberWithPlusSign;
  Assert.IsFalse(ContainsMoreThanOneSlashInNationalNumber(Number, '49/69/2013'));

  Number := Default(TPhoneNumber);
  Number.CountryCode := 49;
  Number.CountryCodeSource := pnccsFromNumberWithoutPlusSign;
  Assert.IsFalse(ContainsMoreThanOneSlashInNationalNumber(Number,
    '+49/69/2013'));
  Assert.IsFalse(ContainsMoreThanOneSlashInNationalNumber(Number,
    '+ 49/69/2013'));
  Assert.IsTrue(ContainsMoreThanOneSlashInNationalNumber(Number,
    '+ 49/69/20/13'));

  { The first group is not assumed to be the country calling code, even though
    it is the same as it. }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 49;
  Number.CountryCodeSource := pnccsFromDefaultCountry;
  Assert.IsTrue(ContainsMoreThanOneSlashInNationalNumber(Number, '49/69/2013'));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindNationalNumber;
begin
  DoTestFindInContext('033316005', RC_NZ);
  { ("33316005", NZ) is omitted upstream since the national prefix is
    obligatory for these types of numbers in New Zealand. }
  DoTestFindInContext('03-331 6005', RC_NZ);
  DoTestFindInContext('03 331 6005', RC_NZ);
  DoTestFindInContext('0064 3 331 6005', RC_NZ);
  DoTestFindInContext('01164 3 331 6005', RC_US);
  DoTestFindInContext('+64 3 331 6005', RC_US);
  DoTestFindInContext('64(0)64123456', RC_NZ);
  { Note that real Polish numbers do *not* start with a 0. }
  DoTestFindInContext('0123/456789', RC_PL);
  DoTestFindInContext('123-456-7890', RC_US);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindWithInternationalPrefixes;
begin
  DoTestFindInContext('+1 (650) 333-6000', RC_NZ);
  DoTestFindInContext('1-650-333-6000', RC_US);
  DoTestFindInContext('0011-650-333-6000', RC_SG);
  DoTestFindInContext('0081-650-333-6000', RC_SG);
  DoTestFindInContext('0191-650-333-6000', RC_SG);
  DoTestFindInContext('0~01-650-333-6000', RC_PL);
  DoTestFindInContext('++1 (650) 333-6000', RC_PL);
  DoTestFindInContext(#$FF0B + '1 (650) 333-6000', RC_SG);
  DoTestFindInContext(
    #$FF0B + #$FF11 + #$3000 + #$FF08 + #$FF16 + #$FF15 + #$FF10 + #$FF09 +
    #$3000 + #$FF13 + #$FF13 + #$FF13 + #$FF0D + #$FF16 + #$FF10 + #$FF10 +
    #$FF10, RC_SG);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindWithLeadingZero;
begin
  DoTestFindInContext('+39 02-36618 300', RC_NZ);
  DoTestFindInContext('02-36618 300', RC_IT);
  DoTestFindInContext('312 345 678', RC_IT);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindNationalNumberArgentina;
begin
  DoTestFindInContext('+54 9 343 555 1212', RC_AR);
  DoTestFindInContext('0343 15 555 1212', RC_AR);
  DoTestFindInContext('+54 9 3715 65 4320', RC_AR);
  DoTestFindInContext('03715 15 65 4320', RC_AR);
  DoTestFindInContext('+54 11 3797 0000', RC_AR);
  DoTestFindInContext('011 3797 0000', RC_AR);
  DoTestFindInContext('+54 3715 65 4321', RC_AR);
  DoTestFindInContext('03715 65 4321', RC_AR);
  DoTestFindInContext('+54 23 1234 0000', RC_AR);
  DoTestFindInContext('023 1234 0000', RC_AR);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindWithXInNumber;
begin
  DoTestFindInContext('(0xx) 123456789', RC_AR);
  { A case where x denotes both carrier codes and extension symbol. }
  DoTestFindInContext('(0xx) 123456789 x 1234', RC_AR);
  DoTestFindInContext('011xx5481429712', RC_US);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindNumbersMexico;
begin
  DoTestFindInContext('+52 (449)978-0001', RC_MX);
  DoTestFindInContext('01 (449)978-0001', RC_MX);
  DoTestFindInContext('(449)978-0001', RC_MX);
  DoTestFindInContext('+52 1 33 1234-5678', RC_MX);
  DoTestFindInContext('044 (33) 1234-5678', RC_MX);
  DoTestFindInContext('045 33 1234-5678', RC_MX);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindNumbersWithPlusWithNoRegion;
begin
  DoTestFindInContext('+64 3 331 6005', RC_ZZ);
  { Java also allows null for the region code in these cases. }
  DoTestFindInContext('+64 3 331 6005', '');
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindExtensions;
begin
  DoTestFindInContext('03 331 6005 ext 3456', RC_NZ);
  DoTestFindInContext('03-3316005x3456', RC_NZ);
  DoTestFindInContext('03-3316005 int.3456', RC_NZ);
  DoTestFindInContext('03 3316005 #3456', RC_NZ);
  DoTestFindInContext('0~0 1800 7493 524', RC_PL);
  DoTestFindInContext('(1800) 7493.524', RC_US);
  DoTestFindInContext('0~0 1800 7493 524 ~1234', RC_PL);
  DoTestFindInContext('+44 2034567890x456', RC_NZ);
  DoTestFindInContext('+44 2034567890x456', RC_GB);
  DoTestFindInContext('+44 2034567890 x456', RC_GB);
  DoTestFindInContext('+44 2034567890 X456', RC_GB);
  DoTestFindInContext('+44 2034567890 X 456', RC_GB);
  DoTestFindInContext('+44 2034567890 X  456', RC_GB);
  DoTestFindInContext('+44 2034567890  X 456', RC_GB);
  DoTestFindInContext('(800) 901-3355 x 7246433', RC_US);
  DoTestFindInContext('(800) 901-3355 , ext 7246433', RC_US);
  DoTestFindInContext('(800) 901-3355 ,extension 7246433', RC_US);
  { When matching we don't consider a lone comma to indicate an extension,
    although we accept it when parsing. }
  DoTestFindInContext('(800) 901-3355 ,x 7246433', RC_US);
  DoTestFindInContext('(800) 901-3355 ext: 7246433', RC_US);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FindInterspersedWithSpace;
begin
  DoTestFindInContext('0 3   3 3 1   6 0 0 5', RC_NZ);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_IntermediateParsePositions;
const
  Text = 'Call 033316005  or 032316005!';
var
  I: Integer;
begin
  for I := 0 to 5 do
    AssertEqualRange(Text, I, 5, 14);
  { 7 and 8 digits in a row are still parsed as number. }
  AssertEqualRange(Text, 6, 6, 14);
  AssertEqualRange(Text, 7, 7, 14);
  { Anything smaller is skipped to the second instance. }
  for I := 8 to 19 do
    AssertEqualRange(Text, I, 19, 28);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_FourMatchesInARow;
const
  Number1 = '415-666-7777';
  Number2 = '800-443-1223';
  Number3 = '212-443-1223';
  Number4 = '650-443-1223';
var
  Text: string;
  Matches: TPhoneNumberMatchArray;
begin
  Text := Number1 + ' - ' + Number2 + ' - ' + Number3 + ' - ' + Number4;
  Matches := FindNumbers(Text, RC_US);
  Assert.AreEqual(Integer(4), Integer(Length(Matches)), 'number of matches');
  AssertMatchProperties(Matches[0], True, Text, Number1, RC_US);
  AssertMatchProperties(Matches[1], True, Text, Number2, RC_US);
  AssertMatchProperties(Matches[2], True, Text, Number3, RC_US);
  AssertMatchProperties(Matches[3], True, Text, Number4, RC_US);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesFoundWithMultipleSpaces;
const
  Number1 = '(415) 666-7777';
  Number2 = '(800) 443-1223';
var
  Text: string;
  Matches: TPhoneNumberMatchArray;
begin
  Text := Number1 + ' ' + Number2;
  Matches := FindNumbers(Text, RC_US);
  Assert.IsTrue(Length(Matches) >= 2, 'two matches expected');
  AssertMatchProperties(Matches[0], True, Text, Number1, RC_US);
  AssertMatchProperties(Matches[1], True, Text, Number2, RC_US);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchWithSurroundingZipcodes;
var
  Number, Text: string;
  Match: TPhoneNumberMatch;
begin
  Number := '415-666-7777';
  Text := 'My address is CA 34215 - ' + Number + ' is my number.';
  AssertMatchProperties(Match, FirstMatch(Text, RC_US, pnlValid, Match), Text,
    Number, RC_US);

  { Now repeat, but this time the phone number has spaces in it. }
  Number := '(415) 666 7777';
  Text := 'My number is ' + Number + '. 34215 is my zip-code.';
  AssertMatchProperties(Match, FirstMatch(Text, RC_US, pnlValid, Match), Text,
    Number, RC_US);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_IsLatinLetter;
begin
  Assert.IsTrue(IsLatinLetter('c'));
  Assert.IsTrue(IsLatinLetter('C'));
  Assert.IsTrue(IsLatinLetter(#$00C9));
  { Combining acute accent. }
  Assert.IsTrue(IsLatinLetter(#$0301));
  { Punctuation, digits and white-space are not "latin letters". }
  Assert.IsFalse(IsLatinLetter(':'));
  Assert.IsFalse(IsLatinLetter('5'));
  Assert.IsFalse(IsLatinLetter('-'));
  Assert.IsFalse(IsLatinLetter('.'));
  Assert.IsFalse(IsLatinLetter(' '));
  { Chinese character and Hiragana letter no. }
  Assert.IsFalse(IsLatinLetter(#$6211));
  Assert.IsFalse(IsLatinLetter(#$306E));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithSurroundingLatinChars;
var
  Contexts: TNumberContextArray;
begin
  Contexts := [
    NC('abc', 'def'),
    NC('abc', ''),
    NC('', 'def'),
    { Latin capital letter e with an acute accent. }
    NC(#$00C9, ''),
    { e with an acute accent decomposed (with combining mark). }
    NC('e' + #$0301, '')
  ];
  FindMatchesInContexts(Contexts, False, True);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MoneyNotSeenAsPhoneNumber;
var
  Contexts: TNumberContextArray;
begin
  Contexts := [
    NC('$', ''),
    NC('', '$'),
    NC(#$00A3, ''),
    NC(#$00A5, '')
  ];
  FindMatchesInContexts(Contexts, False, True);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_PercentageNotSeenAsPhoneNumber;
var
  Contexts: TNumberContextArray;
begin
  Contexts := [NC('', '%')];
  FindMatchesInContexts(Contexts, False, True);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_PhoneNumberWithLeadingOrTrailingMoneyMatches;
var
  Contexts: TNumberContextArray;
begin
  Contexts := [
    NC('$20 ', ''),
    NC('', ' 100$')
  ];
  FindMatchesInContexts(Contexts, True, True);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithSurroundingLatinCharsAndLeadingPunctuation;
var
  PossibleOnly, Valid: TNumberContextArray;
begin
  PossibleOnly := [
    NC('abc', 'def'),
    NC('', 'def'),
    NC('', #$00C9)
  ];
  FindMatchesInContexts(PossibleOnly, False, True, RC_US, '+14156667777');
  FindMatchesInContexts(PossibleOnly, False, True, RC_US, '(415)6667777');

  Valid := [
    NC('abc', ''),
    NC(#$00C9, ''),
    { Trailing punctuation and trailing white-space. }
    NC(#$00C9, '.'),
    NC(#$00C9, ' def')
  ];
  FindMatchesInContexts(Valid, True, True, RC_US, '+14156667777');
  FindMatchesInContexts(Valid, True, True, RC_US, '(415)6667777');
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithSurroundingChineseChars;
var
  Contexts: TNumberContextArray;
begin
  Contexts := [
    NC(#$6211 + #$7684 + #$7535 + #$8BDD + #$53F7 + #$7801 + #$662F, ''),
    NC('', #$662F + #$6211 + #$7684 + #$7535 + #$8BDD + #$53F7 + #$7801),
    NC(#$8BF7 + #$62E8 + #$6253, #$6211 + #$5728 + #$660E + #$5929)
  ];
  FindMatchesInContexts(Contexts, True, True);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithSurroundingPunctuation;
var
  Contexts: TNumberContextArray;
begin
  Contexts := [
    NC('My number-', ''),
    NC('', '.Nice day.'),
    NC('Tel:', '.'),
    NC('Tel: ', ' on Saturdays.')
  ];
  FindMatchesInContexts(Contexts, True, True);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesMultiplePhoneNumbersSeparatedByPhoneNumberPunctuation;
const
  Text = 'Call 650-253-4561 -- 455-234-3451';
var
  Matches: TPhoneNumberMatchArray;
begin
  Matches := FindNumbers(Text, RC_US);
  Assert.IsTrue(Length(Matches) >= 2, 'two matches expected');

  Assert.AreEqual(Integer(5), Matches[0].Start);
  Assert.AreEqual('650-253-4561', Matches[0].RawString);
  Assert.AreEqual(Integer(1), Matches[0].Number.CountryCode);
  Assert.AreEqual('6502534561', Matches[0].Number.NationalNumberDigits);

  Assert.AreEqual(Integer(21), Matches[1].Start);
  Assert.AreEqual('455-234-3451', Matches[1].RawString);
  Assert.AreEqual(Integer(1), Matches[1].Number.CountryCode);
  Assert.AreEqual('4552343451', Matches[1].Number.NationalNumberDigits);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_DoesNotMatchMultiplePhoneNumbersSeparatedWithNoWhiteSpace;
begin
  Assert.IsTrue(HasNoMatches('Call 650-253-4561--455-234-3451', RC_US));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithPossibleLeniency;
begin
  DoTestNumberMatchesForLeniency(Concat(StrictGroupingCases, ExactGroupingCases,
    ValidCases, PossibleOnlyCases), pnlPossible);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NonMatchesWithPossibleLeniency;
begin
  DoTestNumberNonMatchesForLeniency(ImpossibleCases, pnlPossible);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithValidLeniency;
begin
  DoTestNumberMatchesForLeniency(Concat(StrictGroupingCases, ExactGroupingCases,
    ValidCases), pnlValid);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NonMatchesWithValidLeniency;
begin
  DoTestNumberNonMatchesForLeniency(Concat(ImpossibleCases, PossibleOnlyCases),
    pnlValid);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithStrictGroupingLeniency;
begin
  DoTestNumberMatchesForLeniency(Concat(StrictGroupingCases,
    ExactGroupingCases), pnlStrictGrouping);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NonMatchesWithStrictGroupLeniency;
begin
  DoTestNumberNonMatchesForLeniency(Concat(ImpossibleCases, PossibleOnlyCases,
    ValidCases), pnlStrictGrouping);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MatchesWithExactGroupingLeniency;
begin
  DoTestNumberMatchesForLeniency(ExactGroupingCases, pnlExactGrouping);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NonMatchesExactGroupLeniency;
begin
  DoTestNumberNonMatchesForLeniency(Concat(ImpossibleCases, PossibleOnlyCases,
    ValidCases, StrictGroupingCases), pnlExactGrouping);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NonMatchingBracketsAreInvalid;
begin
  { The digits up to the ", " form a valid US number, but it shouldn't be
    matched as one since there was a non-matching bracket present. }
  Assert.IsTrue(HasNoMatches('80.585 [79.964, 81.191]', RC_US));
  { The trailing "]" is thrown away before parsing. }
  Assert.IsTrue(HasNoMatches('80.585 [79.964]', RC_US));
  Assert.IsTrue(HasNoMatches('80.585 ((79.964)', RC_US));
  { Too many sets of brackets to be valid. }
  Assert.IsTrue(HasNoMatches('(80).(585) (79).(9)64', RC_US));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NoMatchIfRegionIsNull;
begin
  { Fail on non-international prefix if the region code is null. }
  Assert.IsTrue(HasNoMatches(
    'Random text body - number is 0331 6005, see you there', ''));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NoMatchInEmptyString;
begin
  Assert.IsTrue(HasNoMatches('', RC_US));
  Assert.IsTrue(HasNoMatches('  ', RC_US));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NoMatchIfNoNumber;
begin
  Assert.IsTrue(HasNoMatches(
    'Random text body - number is foobar, see you there', RC_US));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_Sequences;
const
  Text = 'Call 033316005  or 032316005!';
var
  Matches: TPhoneNumberMatchArray;
begin
  Matches := FindNumbers(Text, RC_NZ, pnlPossible, UnlimitedTries);
  Assert.IsTrue(Length(Matches) >= 2, 'two matches expected');

  Assert.AreEqual(Integer(5), Matches[0].Start);
  Assert.AreEqual('033316005', Matches[0].RawString);
  Assert.AreEqual(Integer(64), Matches[0].Number.CountryCode);
  Assert.AreEqual('33316005', Matches[0].Number.NationalNumberDigits);

  Assert.AreEqual(Integer(19), Matches[1].Start);
  Assert.AreEqual('032316005', Matches[1].RawString);
  Assert.AreEqual(Integer(64), Matches[1].Number.CountryCode);
  Assert.AreEqual('32316005', Matches[1].Number.NationalNumberDigits);
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NullInput;
begin
  { Java passes null for the text; the empty string is this port's
    equivalent. }
  Assert.IsTrue(HasNoMatches('', RC_US));
  Assert.IsTrue(HasNoMatches('', ''));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MaxMatches;
var
  I: Integer;
  Numbers: string;
  Matches: TPhoneNumberMatchArray;
begin
  Numbers := '';
  for I := 1 to 100 do
    Numbers := Numbers + 'My info: 415-666-7777,';

  { Matches all 100. Max only applies to failed cases. }
  Matches := FindNumbers(Numbers, RC_US, pnlValid, 10);
  Assert.AreEqual(Integer(100), Integer(Length(Matches)));
  for I := 0 to Length(Matches) - 1 do
  begin
    Assert.AreEqual(Integer(1), Matches[I].Number.CountryCode);
    Assert.AreEqual('4156667777', Matches[I].Number.NationalNumberDigits);
  end;
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MaxMatchesInvalid;
var
  I: Integer;
  Numbers: string;
begin
  Numbers := '';
  for I := 1 to 10 do
    Numbers := Numbers + 'My address 949-8945-0';
  for I := 1 to 100 do
    Numbers := Numbers + 'My info: 415-666-7777,';

  Assert.AreEqual(Integer(0),
    Integer(Length(FindNumbers(Numbers, RC_US, pnlValid, 10))));
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_MaxMatchesMixed;
var
  I: Integer;
  Numbers: string;
  Matches: TPhoneNumberMatchArray;
begin
  Numbers := '';
  for I := 1 to 100 do
    Numbers := Numbers + 'My info: 415-666-7777 123 fake street';

  { Only matches the first 10 despite there being 100 numbers. }
  Matches := FindNumbers(Numbers, RC_US, pnlValid, 10);
  Assert.AreEqual(Integer(10), Integer(Length(Matches)));
  for I := 0 to Length(Matches) - 1 do
  begin
    Assert.AreEqual(Integer(1), Matches[I].Number.CountryCode);
    Assert.AreEqual('4156667777', Matches[I].Number.NationalNumberDigits);
  end;
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_NonPlusPrefixedNumbersNotFoundForInvalidRegion;
var
  Matcher: TPhoneNumberMatcher;
  Raised: Boolean;
begin
  Matcher := TPhoneNumberMatcher.Create('1 456 764 156', RC_ZZ, pnlValid,
    UnlimitedTries);
  try
    Assert.IsFalse(Matcher.HasNext);
    Raised := False;
    try
      Matcher.Next;
    except
      on EPhoneNumberMatcher do
        Raised := True;
    end;
    Assert.IsTrue(Raised, 'Violation of the iterator contract.');
    Assert.IsFalse(Matcher.HasNext);
  finally
    Matcher.Free;
  end;
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_EmptyIteration;
var
  Matcher: TPhoneNumberMatcher;
  Raised: Boolean;
begin
  Matcher := TPhoneNumberMatcher.Create('', RC_ZZ, pnlValid, UnlimitedTries);
  try
    Assert.IsFalse(Matcher.HasNext);
    Assert.IsFalse(Matcher.HasNext);
    Raised := False;
    try
      Matcher.Next;
    except
      on EPhoneNumberMatcher do
        Raised := True;
    end;
    Assert.IsTrue(Raised, 'Violation of the iterator contract.');
    Assert.IsFalse(Matcher.HasNext);
  finally
    Matcher.Free;
  end;
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_SingleIteration;
var
  Matcher: TPhoneNumberMatcher;
  Raised: Boolean;
begin
  Matcher := TPhoneNumberMatcher.Create('+14156667777', RC_ZZ, pnlValid,
    UnlimitedTries);
  try
    { Double HasNext to ensure it does not advance. }
    Assert.IsTrue(Matcher.HasNext);
    Assert.IsTrue(Matcher.HasNext);
    Assert.AreNotEqual('', Matcher.Next.RawString);
    Assert.IsFalse(Matcher.HasNext);
    Raised := False;
    try
      Matcher.Next;
    except
      on EPhoneNumberMatcher do
        Raised := True;
    end;
    Assert.IsTrue(Raised, 'Violation of the iterator contract.');
    Assert.IsFalse(Matcher.HasNext);
  finally
    Matcher.Free;
  end;

  { With Next only. }
  Matcher := TPhoneNumberMatcher.Create('+14156667777', RC_ZZ, pnlValid,
    UnlimitedTries);
  try
    Assert.AreNotEqual('', Matcher.Next.RawString);
    Raised := False;
    try
      Matcher.Next;
    except
      on EPhoneNumberMatcher do
        Raised := True;
    end;
    Assert.IsTrue(Raised, 'Violation of the iterator contract.');
  finally
    Matcher.Free;
  end;
end;

procedure TUpstreamPhoneNumberMatcherTests.Test_DoubleIteration;
var
  Matcher: TPhoneNumberMatcher;
  Raised: Boolean;
begin
  Matcher := TPhoneNumberMatcher.Create('+14156667777 foobar +14156667777 ',
    RC_ZZ, pnlValid, UnlimitedTries);
  try
    Assert.IsTrue(Matcher.HasNext);
    Assert.IsTrue(Matcher.HasNext);
    Assert.AreNotEqual('', Matcher.Next.RawString);
    Assert.IsTrue(Matcher.HasNext);
    Assert.IsTrue(Matcher.HasNext);
    Assert.AreNotEqual('', Matcher.Next.RawString);
    Assert.IsFalse(Matcher.HasNext);
    Raised := False;
    try
      Matcher.Next;
    except
      on EPhoneNumberMatcher do
        Raised := True;
    end;
    Assert.IsTrue(Raised, 'Violation of the iterator contract.');
    Assert.IsFalse(Matcher.HasNext);
  finally
    Matcher.Free;
  end;

  { With Next only. }
  Matcher := TPhoneNumberMatcher.Create('+14156667777 foobar +14156667777 ',
    RC_ZZ, pnlValid, UnlimitedTries);
  try
    Assert.AreNotEqual('', Matcher.Next.RawString);
    Assert.AreNotEqual('', Matcher.Next.RawString);
    Raised := False;
    try
      Matcher.Next;
    except
      on EPhoneNumberMatcher do
        Raised := True;
    end;
    Assert.IsTrue(Raised, 'Violation of the iterator contract.');
  finally
    Matcher.Free;
  end;
end;

initialization
  RegisterTest(TUpstreamPhoneNumberMatcherTests);

end.
