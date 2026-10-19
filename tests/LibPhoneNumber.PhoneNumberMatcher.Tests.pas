unit LibPhoneNumber.PhoneNumberMatcher.Tests;

{
  Tests for the PhoneNumberMatcher port.

  Where the expected values come from
  -----------------------------------
  The test IDEAS come from upstream
  java/libphonenumber/test/com/google/i18n/phonenumbers/PhoneNumberMatcherTest.java;
  the expected VALUES do not (that suite runs against
  PhoneNumberMetadataForTesting.xml - see AGENTS.md "Test Expectations").
  Every value below was recomputed with the NuGet oracle
  (libphonenumber-csharp 9.0.38, the metadata release matching the pinned Java
  baseline) through

    [PhoneNumbers.PhoneNumberUtil]::GetInstance().FindNumbers(
      $text, $region, [PhoneNumbers.PhoneNumberUtil+Leniency]::$leniency,
      [long]::MaxValue)

  reading PhoneNumberMatch.Start, .RawString and Format(.Number, E164).

  THE ORACLE IS NOT A FAITHFUL PhoneNumberMatcher (important)
  ----------------------------------------------------------
  Unlike every other part of this port, the C# PhoneNumberMatcher is NOT a
  current translation of the Java one. Verified against
  vendor/libphonenumber-csharp/csharp/PhoneNumbers/PhoneNumberMatcher.cs at the
  pinned commit, the C# class differs from PhoneNumberMatcher.java in five
  places:

  1. extractInnerMatch is an OLDER algorithm entirely. Java walks the six
     INNER_MATCHES patterns (slash, opening bracket, spaced hyphen, wide
     hyphen, full stop, space); C# has a single "GroupSeparator" white space
     regex and tries only "first group", "without first group" and "without
     last group".
  2. PUB_PAGES is tested in extractMatch in C# (which kills the inner matches
     of that candidate too); Java tests it inside parseAndVerify, so only the
     one candidate is rejected.
  3. MATCHING_BRACKETS is a structurally different expression built from
     atomic groups.
  4. PATTERN is written with \d where Java writes \p<Nd>, again with atomic
     groups. This is a SOURCE PATTERN difference, not an ASCII versus Unicode
     one: .NET's \d is Unicode Nd by default (only RegexOptions.ECMAScript
     narrows it to [0-9]), so the two spellings agree on the digit class and
     differ in the atomic groups around it.
  5. TIME_STAMPS_SUFFIX, trimAfterFirstMatch(SECOND_NUMBER_START) and
     trimAfterFirstMatch(UNWANTED_END_CHARS) are hand written in C# and
     UNWANTED_END_CHARS is spelled with char.IsLetterOrDigit rather than the
     upstream [\P<N>&&\P<L>] class.

  Java is the functional source of truth of this port (AGENTS.md "Source of
  Truth"), so the port follows Java. The consequence is recorded here rather
  than smoothed over: the fixture below is split into

    * cases where oracle and Java agree - the overwhelming majority, and the
      value is the oracle answer;
    * a block of PINNED JAVA-VERSUS-ORACLE DIVERGENCES near the end, each with
      the Java trace that produces the expected value and the oracle answer
      written next to it;
    * one test for the ALTERNATE FORMAT metadata, which pins the upstream
      behaviour of the grouping levels.

  Offsets
  -------
  Start is the upstream zero based offset, i.e. Java PhoneNumberMatch.start().

  Notation
  --------
  A closing brace ends a Pascal comment, so upstream expressions are quoted
  with ANGLE brackets where they use a Unicode property class: \p<Z> is \p
  and the brace form of Z.
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
  LibPhoneNumber.PhoneNumberMatcher;

type
  TPhoneNumberMatcherTests = class(TTestCase)
  private
    function E164(const AMatch: TPhoneNumberMatch): string;
    function Describe(const AMatches: TPhoneNumberMatchArray): string;
    { Assert.AreEqual has overloads for word, Integer, Int64, cardinal and
      three float types plus a generic one, so an INTEGER LITERAL as the
      expected value is ambiguous. Everything integral goes through this
      helper, whose parameters pin the overload. }
    procedure CheckInt(AExpected, AActual: Integer; const AMessage: string);
    { One BMP code point as a string. Every non ASCII literal of this fixture
      is built through this helper, so the file stays pure ASCII and its
      encoding never becomes load bearing - the same rule the ported units
      follow with CodePoint(). }
    function Cp(ACode: Integer): string;
    { The surrogate PAIR of a supplementary code point, as the two UTF-16 code
      units java.util.regex and this port both see. }
    function SupplementaryCp(ACode: Integer): string;
    { The extension the parse path assigns to AText, for the tests that
      contrast the PARSING extension grammar with the MATCHING one. }
    function ParsedExtension(const AText, ARegion: string): string;
    { AExpected holds one 'start|rawString|e164' entry per expected match, in
      order. An empty array means "no matches at all". }
    procedure CheckFind(const AText, ARegion: string;
      ALeniency: TPhoneNumberLeniency; AMaxTries: Int64;
      const AExpected: array of string);
    procedure CheckValid(const AText, ARegion: string;
      const AExpected: array of string);
  published
    { --- basic finding -------------------------------------------------- }
    procedure PlainSentence_EN_FindsBothNumbers;

    procedure PlainSentence_DE_FindsBothNumbers;

    procedure TwoNumbersInOneText_KeepOrderAndOffsets;

    procedure NumberSurroundedByPunctuation_IsFound;

    procedure EmptyText_HasNoMatches;

    procedure TextWithoutAnyNumber_HasNoMatches;

    procedure UnknownRegion_OnlyFindsNumbersWithTheirOwnCallingCode;

    { --- MATCHING_BRACKETS ---------------------------------------------- }
    procedure MatchingBrackets_AcceptsBalancedAndDroppedBrackets;

    procedure MatchingBrackets_RejectsUnbalancedBrackets;

    procedure MatchingBrackets_RejectsUpstreamNonMatchingBracketCases;

    { --- dates, time stamps, publication pages -------------------------- }
    procedure SlashSeparatedDates_AreNotNumbers;

    procedure TimeStamps_AreNotNumbers;

    procedure TimeStampWithoutTheMinuteSuffix_IsStillANumber;

    procedure PublicationPages_AreNotNumbers;

    { --- Latin letter and currency context ------------------------------ }
    procedure LatinLetterContext_IsRejectedFromValidOn;

    procedure LatinLetterContext_IsAcceptedWithPossible;

    procedure LeadClassStart_SkipsThePreviousCharacterCheck;

    procedure CurrencyAndPercentContext_IsRejected;

    procedure IsLatinLetter_MatchesUpstream;

    procedure SupplementaryCharacterContext_UsesUtf16Offsets;

    { --- leniency ------------------------------------------------------- }
    procedure Leniency_PossibleButNotValid;

    procedure Leniency_ValidButNotStrictGrouping;

    procedure Leniency_StrictButNotExactGrouping;

    procedure Leniency_AcceptedByEveryLevel;

    procedure Leniency_GroupingRejectsScatteredDigits;

    procedure Leniency_ValidRejectsAnInvalidCarrierCodeX;

    procedure Leniency_SlashRightAfterTheCountryCodeIsAllowed;

    procedure Leniency_NationalPrefixIsRequiredWhenTheFormatSaysSo;

    procedure Leniency_ExactGroupingSkipsTheExtensionGroup;

    procedure Leniency_GroupingSkipsTheCountryCodeInTheCandidate;

    { --- extensions ----------------------------------------------------- }
    procedure Extensions_ArePartOfTheMatch;

    procedure ExtnPatternsForMatching_HasNoAutoDiallingAlternatives;

    { --- inner matches -------------------------------------------------- }
    procedure InnerMatch_SpacedHyphenSplitsTheCandidate;

    procedure InnerMatch_FullStopSplitsTheCandidate;

    procedure InnerMatch_SpaceSplitsTheCandidate;

    procedure InnerMatch_SpacedHyphenAlsoReleasesTheSecondNumber;

    procedure InnerMatch_SeparatorRunInFrontOfTheGroupIsConsumed;

    procedure InnerMatch_FindIsRepeatedOnTheSameCandidate;

    procedure InnerMatch_MaxTriesIsSpentInsideTheInnerExtraction;

    procedure InnerMatch_NoWhiteSpaceBetweenNumbersFindsNothing;

    { --- maxTries and the iterator -------------------------------------- }
    procedure MaxTries_LimitsTheNumberOfCandidates;

    procedure MaxTries_ZeroFindsNothing;

    procedure Iterator_HasNextIsIdempotentAndNextAdvances;

    procedure Iterator_NextRaisesAtTheEnd;

    procedure Constructor_RejectsNegativeMaxTries;

    { --- mass smoke ----------------------------------------------------- }
    procedure ExampleNumbersInASentence_AreFoundInBothFormats;

    { --- pinned Java versus oracle divergences -------------------------- }
    procedure Divergence_SlashInnerMatchIsFoundLikeJava;

    procedure Divergence_BracketInnerMatchIsFoundLikeJava;

    procedure Divergence_DoubledOpeningBracketFallsBackToTheInnerMatch;

    procedure Divergence_WideHyphensSplitTheCandidateLikeJava;

    procedure Divergence_SlashRunIsConsumedAsAWholeLikeJava;

    { --- alternate format metadata ------------------------- }
    procedure AlternateFormatsAreConsultedByTheGroupingCheck;
  end;

implementation

uses
{$IFDEF FPC}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.PhoneNumberUtil;

function TPhoneNumberMatcherTests.E164(
  const AMatch: TPhoneNumberMatch): string;
begin
  Result := TPhoneNumberUtil.Format(AMatch.Number, pnfE164);
end;

procedure TPhoneNumberMatcherTests.CheckInt(AExpected,
  AActual: Integer; const AMessage: string);
begin
  Assert.AreEqual(AExpected, AActual, AMessage);
end;

function TPhoneNumberMatcherTests.Cp(ACode: Integer): string;
begin
  Result := WideChar(ACode);
end;

function TPhoneNumberMatcherTests.SupplementaryCp(
  ACode: Integer): string;
var
  Rest: Integer;
begin
  Rest := ACode - $10000;
  Result := WideChar($D800 + (Rest shr 10)) + WideChar($DC00 + (Rest and $3FF));
end;

function TPhoneNumberMatcherTests.ParsedExtension(const AText,
  ARegion: string): string;
var
  Parsed: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  Assert.IsTrue(TPhoneNumberUtil.ParseAndKeepRawInput(AText, ARegion,
    Parsed, Error), 'Parse("' + AText + '")');
  Result := Parsed.Extension;
end;

function TPhoneNumberMatcherTests.Describe(
  const AMatches: TPhoneNumberMatchArray): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(AMatches) do
  begin
    if Result <> '' then
      Result := Result + ' , ';
    Result := Result + Format('%d|%s|%s',
      [AMatches[I].Start, AMatches[I].RawString, E164(AMatches[I])]);
  end;
  if Result = '' then
    Result := '<none>';
end;

procedure TPhoneNumberMatcherTests.CheckFind(const AText,
  ARegion: string; ALeniency: TPhoneNumberLeniency; AMaxTries: Int64;
  const AExpected: array of string);
var
  Matches: TPhoneNumberMatchArray;
  Expected: string;
  I: Integer;
begin
  Matches := FindNumbers(AText, ARegion, ALeniency, AMaxTries);

  Expected := '';
  for I := 0 to High(AExpected) do
  begin
    if Expected <> '' then
      Expected := Expected + ' , ';
    Expected := Expected + AExpected[I];
  end;
  if Expected = '' then
    Expected := '<none>';

  Assert.AreEqual(Expected, Describe(Matches),
    Format('FindNumbers("%s", "%s")', [AText, ARegion]));

  { The end offset is derived, but it is part of the public contract. }
  for I := 0 to High(Matches) do
    CheckInt(Matches[I].Start + Length(Matches[I].RawString),
      Matches[I].EndIndex, 'EndIndex');
end;

procedure TPhoneNumberMatcherTests.CheckValid(const AText,
  ARegion: string; const AExpected: array of string);
begin
  CheckFind(AText, ARegion, pnlValid, UnlimitedTries, AExpected);
end;


{ ------------------------------------------------------------------
  Basic finding. Oracle verified.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.PlainSentence_EN_FindsBothNumbers;
begin
  CheckValid('Call me at 510-748-8230 if it''s before 9:30, '
    + 'or on 703-4800500 after 10am.', 'US',
    ['11|510-748-8230|+15107488230',
     '51|703-4800500|+17034800500']);
end;

procedure TPhoneNumberMatcherTests.PlainSentence_DE_FindsBothNumbers;
begin
  CheckValid('Bitte rufen Sie 030 12345678 oder +49 30 901820 an.', 'DE',
    ['16|030 12345678|+493012345678',
     '34|+49 30 901820|+4930901820']);
end;

procedure TPhoneNumberMatcherTests.TwoNumbersInOneText_KeepOrderAndOffsets;
begin
  CheckValid('My number is 650-253-0000 and my fax is 650-253-0001.', 'US',
    ['13|650-253-0000|+16502530000',
     '40|650-253-0001|+16502530001']);
  CheckValid('Rufen Sie mich unter 089 12345678 an oder schreiben Sie.', 'DE',
    ['21|089 12345678|+498912345678']);
end;

procedure TPhoneNumberMatcherTests.NumberSurroundedByPunctuation_IsFound;
begin
  { Upstream testMatchesWithSurroundingPunctuation, with a productive US
    number. }
  CheckValid('My number-415-666-7777', 'US', ['10|415-666-7777|+14156667777']);
  CheckValid('415-666-7777.Nice day.', 'US', ['0|415-666-7777|+14156667777']);
  CheckValid('Tel:415-666-7777.', 'US', ['4|415-666-7777|+14156667777']);
  CheckValid('Tel: 415-666-7777 on Saturdays.', 'US',
    ['5|415-666-7777|+14156667777']);
end;

procedure TPhoneNumberMatcherTests.EmptyText_HasNoMatches;
begin
  CheckValid('', 'US', []);
  CheckFind('', 'US', pnlPossible, UnlimitedTries, []);
end;

procedure TPhoneNumberMatcherTests.TextWithoutAnyNumber_HasNoMatches;
begin
  CheckValid('no numbers here at all', 'US', []);
  CheckFind('no numbers here at all', 'US', pnlPossible, UnlimitedTries, []);
end;

procedure TPhoneNumberMatcherTests.UnknownRegion_OnlyFindsNumbersWithTheirOwnCallingCode;
begin
  CheckValid('+1 650 253 0000', 'ZZ', ['0|+1 650 253 0000|+16502530000']);
  CheckValid('650 253 0000', 'ZZ', []);
  CheckValid('+1 650 253 0000', '', ['0|+1 650 253 0000|+16502530000']);
end;

{ ------------------------------------------------------------------
  MATCHING_BRACKETS. Oracle verified.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.MatchingBrackets_AcceptsBalancedAndDroppedBrackets;
begin
  CheckValid('(650) 253-0000', 'US', ['0|(650) 253-0000|+16502530000']);
  { An opening bracket at the beginning may stay unclosed. }
  CheckValid('(650 253-0000', 'US', ['0|(650 253-0000|+16502530000']);
  { The leading bracket may have been dropped. }
  CheckValid('650) 253-0000', 'US', ['0|650) 253-0000|+16502530000']);
  { The national prefix in brackets, a common German spelling. }
  CheckValid('Hotline: +49 (0)30 901820', 'DE',
    ['9|+49 (0)30 901820|+4930901820']);
end;

procedure TPhoneNumberMatcherTests.MatchingBrackets_RejectsUnbalancedBrackets;
begin
  CheckValid('(650) 253) 0000', 'US', []);
  CheckValid('(650) 2)53-0000', 'US', []);
  { '((650) 253-0000' is NOT here: MATCHING_BRACKETS rejects the whole
    candidate, but the second bracket group is a match of its own; see
    Divergence_DoubledOpeningBracketFallsBackToTheInnerMatch. }
end;

procedure TPhoneNumberMatcherTests.MatchingBrackets_RejectsUpstreamNonMatchingBracketCases;
begin
  { Upstream testNonMatchingBracketsAreInvalid, verbatim inputs. }
  CheckValid('80.585 [79.964, 81.191]', 'US', []);
  CheckValid('80.585 [79.964]', 'US', []);
  CheckValid('80.585 ((79.964)', 'US', []);
  { Too many sets of brackets to be valid. }
  CheckValid('(80).(585) (79).(9)64', 'US', []);
end;

{ ------------------------------------------------------------------
  Dates, time stamps, publication pages. Oracle verified.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.SlashSeparatedDates_AreNotNumbers;
begin
  CheckValid('The date 03/10/2011 is not a number.', 'US', []);
  CheckFind('3/10/1984', 'CA', pnlPossible, UnlimitedTries, []);
  CheckFind('10/12/82', 'DE', pnlPossible, UnlimitedTries, []);
end;

procedure TPhoneNumberMatcherTests.TimeStamps_AreNotNumbers;
begin
  CheckValid('2012-01-02 08:00', 'US', []);
  CheckValid('2012-01-02 08:00:23', 'US', []);
  CheckFind('2012-01-02 08:00', 'US', pnlPossible, UnlimitedTries, []);
end;

procedure TPhoneNumberMatcherTests.TimeStampWithoutTheMinuteSuffix_IsStillANumber;
begin
  { TIME_STAMPS matches "2012-01-02 08", but the candidate is only dropped
    when TIME_STAMPS_SUFFIX also matches the text that FOLLOWS it. Nothing
    follows here, so the digits are treated as the US number they form. }
  CheckValid('2012-01-02 08', 'US', ['0|2012-01-02 08|+12012010208']);
end;

procedure TPhoneNumberMatcherTests.PublicationPages_AreNotNumbers;
begin
  { The PUB_PAGES example of the upstream doc comment. }
  CheckValid('Chen Li. VLDB J. 12(3): 211-227 (2003).', 'US', []);
end;

{ ------------------------------------------------------------------
  Latin letter and currency context. Oracle verified.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.LatinLetterContext_IsRejectedFromValidOn;
begin
  CheckValid('abc8005001234', 'US', []);
  CheckValid('8005001234def', 'US', []);
  CheckValid('abc415-666-7777def', 'US', []);
end;

procedure TPhoneNumberMatcherTests.LatinLetterContext_IsAcceptedWithPossible;
begin
  CheckFind('abc8005001234', 'US', pnlPossible, UnlimitedTries,
    ['3|8005001234|+18005001234']);
  CheckFind('abc415-666-7777def', 'US', pnlPossible, UnlimitedTries,
    ['3|415-666-7777|+14156667777']);
end;

procedure TPhoneNumberMatcherTests.LeadClassStart_SkipsThePreviousCharacterCheck;
begin
  { The candidate starts with a LEAD_CLASS character, so the Latin letter in
    front of it is not looked at at all. }
  CheckValid('x (650) 253-0000', 'US', ['2|(650) 253-0000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.CurrencyAndPercentContext_IsRejected;
begin
  CheckValid('The number is 650 253 0000$', 'US', []);
  CheckValid('The number is 650 253 0000%', 'US', []);
end;

procedure TPhoneNumberMatcherTests.IsLatinLetter_MatchesUpstream;
begin
  { Upstream testIsLatinLetter, verbatim. }
  Assert.IsTrue(IsLatinLetter('c'), 'c');
  Assert.IsTrue(IsLatinLetter('C'), 'C');
  Assert.IsTrue(IsLatinLetter(WideChar($00C9)), 'E with acute accent');
  Assert.IsTrue(IsLatinLetter(WideChar($0301)), 'combining acute accent');
  Assert.IsFalse(IsLatinLetter(':'), 'colon');
  Assert.IsFalse(IsLatinLetter('5'), 'digit');
  Assert.IsFalse(IsLatinLetter('-'), 'hyphen');
  Assert.IsFalse(IsLatinLetter('.'), 'full stop');
  Assert.IsFalse(IsLatinLetter(' '), 'space');
  Assert.IsFalse(IsLatinLetter(WideChar($6211)), 'Chinese character');
  Assert.IsFalse(IsLatinLetter(WideChar($306E)), 'Hiragana letter no');

  Assert.IsTrue(IsInvalidPunctuationSymbol('%'), 'percent');
  Assert.IsTrue(IsInvalidPunctuationSymbol('$'), 'dollar');
  Assert.IsTrue(IsInvalidPunctuationSymbol(WideChar($20AC)), 'euro');
  Assert.IsFalse(IsInvalidPunctuationSymbol('-'), 'hyphen');
end;

procedure TPhoneNumberMatcherTests.SupplementaryCharacterContext_UsesUtf16Offsets;
var
  Bold: string;
begin
  { MATHEMATICAL BOLD CAPITAL A, a LETTER that lives outside the BMP. Upstream
    isLatinLetter takes a CHAR, so it sees the two halves of the surrogate
    pair separately and answers false for both - a supplementary letter next
    to a number therefore does NOT reject the match, unlike an ASCII one.

    The offsets are UTF-16 offsets, which is what makes this worth pinning:
    the pair counts as TWO. }
  Bold := SupplementaryCp($1D400);
  { Measured in UTF-16 code units: on FreePascal `string` is UTF-8. }
  Assert.AreEqual(2, Length(UnicodeString(Bold)), 'surrogate pair length');

  CheckValid(Bold + '650-253-0000', 'US', ['2|650-253-0000|+16502530000']);
  CheckValid('650-253-0000' + Bold, 'US', ['0|650-253-0000|+16502530000']);

  { The contrast in one string: the ASCII letter would reject the match, but
    it is not the character next to the candidate - the low surrogate is. }
  CheckValid('x' + Bold + '650-253-0000', 'US',
    ['3|650-253-0000|+16502530000']);
  CheckValid('x650-253-0000', 'US', []);
end;

{ ------------------------------------------------------------------
  Leniency. Oracle verified; every one of these four levels is
  discriminating on the case it is used with.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.Leniency_PossibleButNotValid;
begin
  { 123-456-7890 has the right LENGTH for the NANPA but neither a valid area
    code nor a valid exchange code. }
  CheckFind('Call 1234567890 now', 'US', pnlPossible, UnlimitedTries,
    ['5|1234567890|+11234567890']);
  CheckFind('Call 1234567890 now', 'US', pnlValid, UnlimitedTries, []);
  CheckFind('Call 1234567890 now', 'US', pnlStrictGrouping, UnlimitedTries, []);
  CheckFind('Call 1234567890 now', 'US', pnlExactGrouping, UnlimitedTries, []);
end;

procedure TPhoneNumberMatcherTests.Leniency_ValidButNotStrictGrouping;
begin
  { The area code is broken across the first grouping boundary. }
  CheckFind('Call 650253 0000 now', 'US', pnlPossible, UnlimitedTries,
    ['5|650253 0000|+16502530000']);
  CheckFind('Call 650253 0000 now', 'US', pnlValid, UnlimitedTries,
    ['5|650253 0000|+16502530000']);
  CheckFind('Call 650253 0000 now', 'US', pnlStrictGrouping, UnlimitedTries,
    []);
  CheckFind('Call 650253 0000 now', 'US', pnlExactGrouping, UnlimitedTries,
    []);
end;

procedure TPhoneNumberMatcherTests.Leniency_StrictButNotExactGrouping;
begin
  { The groups remain grouped, but this is not how the number would be
    formatted, and it is not one single block either. }
  CheckFind('Call 650 2530000 now', 'US', pnlValid, UnlimitedTries,
    ['5|650 2530000|+16502530000']);
  CheckFind('Call 650 2530000 now', 'US', pnlStrictGrouping, UnlimitedTries,
    ['5|650 2530000|+16502530000']);
  CheckFind('Call 650 2530000 now', 'US', pnlExactGrouping, UnlimitedTries,
    []);
end;

procedure TPhoneNumberMatcherTests.Leniency_AcceptedByEveryLevel;
begin
  CheckFind('Call 650 253 0000 now', 'US', pnlPossible, UnlimitedTries,
    ['5|650 253 0000|+16502530000']);
  CheckFind('Call 650 253 0000 now', 'US', pnlValid, UnlimitedTries,
    ['5|650 253 0000|+16502530000']);
  CheckFind('Call 650 253 0000 now', 'US', pnlStrictGrouping, UnlimitedTries,
    ['5|650 253 0000|+16502530000']);
  CheckFind('Call 650 253 0000 now', 'US', pnlExactGrouping, UnlimitedTries,
    ['5|650 253 0000|+16502530000']);

  { As one single block. }
  CheckFind('Call 6502530000 now', 'US', pnlStrictGrouping, UnlimitedTries,
    ['5|6502530000|+16502530000']);
  CheckFind('Call 6502530000 now', 'US', pnlExactGrouping, UnlimitedTries,
    ['5|6502530000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.Leniency_GroupingRejectsScatteredDigits;
begin
  CheckFind('Call 65 02 53 00 00 now', 'US', pnlValid, UnlimitedTries,
    ['5|65 02 53 00 00|+16502530000']);
  CheckFind('Call 65 02 53 00 00 now', 'US', pnlStrictGrouping, UnlimitedTries,
    []);
  CheckFind('Call 65 02 53 00 00 now', 'US', pnlExactGrouping, UnlimitedTries,
    []);
end;

procedure TPhoneNumberMatcherTests.Leniency_ValidRejectsAnInvalidCarrierCodeX;
begin
  { containsOnlyValidXChars. A SINGLE 'x' is an extension sign, so the digits
    behind it have to be the extension - which they are here. }
  CheckFind('6502530000x12', 'US', pnlValid, UnlimitedTries,
    ['0|6502530000x12|+16502530000']);
  Assert.AreEqual('12',
    FindNumbers('6502530000x12', 'US')[0].Number.Extension, 'extension');

  { TWO consecutive 'x' are a carrier code, and a carrier code always PRECEDES
    the national significant number: the rest of the candidate has to be an
    NSN_MATCH of the parsed number. Here it is "x12", so the check fails and
    everything from VALID on rejects the number - while it stays possible. }
  CheckFind('6502530000xx12', 'US', pnlPossible, UnlimitedTries,
    ['0|6502530000xx12|+16502530000']);
  CheckFind('6502530000xx12', 'US', pnlValid, UnlimitedTries, []);
  CheckFind('6502530000xx12', 'US', pnlStrictGrouping, UnlimitedTries, []);
  CheckFind('6502530000xx12', 'US', pnlExactGrouping, UnlimitedTries, []);

  { The carrier code case that DOES hold: the Brazilian "0xx" placeholder in
    front of the number, which is what the check was written for. }
  CheckValid('(0xx11) 2345-6789', 'BR',
    ['0|(0xx11) 2345-6789|+551123456789']);
  CheckFind('(0xx11) 2345-6789', 'BR', pnlExactGrouping, UnlimitedTries,
    ['0|(0xx11) 2345-6789|+551123456789']);
end;

procedure TPhoneNumberMatcherTests.Leniency_SlashRightAfterTheCountryCodeIsAllowed;
begin
  { containsMoreThanOneSlashInNationalNumber, which only the two grouping
    levels consult. ONE slash is always fine. }
  CheckFind('0121/234 5678', 'GB', pnlValid, UnlimitedTries,
    ['0|0121/234 5678|+441212345678']);
  CheckFind('0121/234 5678', 'GB', pnlStrictGrouping, UnlimitedTries,
    ['0|0121/234 5678|+441212345678']);

  { Two slashes are fine as well when the FIRST one sits right behind the
    country calling code. }
  CheckFind('+44/121/234 5678', 'GB', pnlPossible, UnlimitedTries,
    ['0|+44/121/234 5678|+441212345678']);
  CheckFind('+44/121/234 5678', 'GB', pnlValid, UnlimitedTries,
    ['0|+44/121/234 5678|+441212345678']);
  CheckFind('+44/121/234 5678', 'GB', pnlStrictGrouping, UnlimitedTries,
    ['0|+44/121/234 5678|+441212345678']);
  CheckFind('+44/121/234 5678', 'GB', pnlExactGrouping, UnlimitedTries,
    ['0|+44/121/234 5678|+441212345678']);

  { A THIRD slash behind the exempted one is illegal again - and note that
    VALID still accepts the number, because VALID does not look at slashes at
    all. That is what makes this the discriminating pair. }
  CheckFind('+44/121/234/5678', 'GB', pnlValid, UnlimitedTries,
    ['0|+44/121/234/5678|+441212345678']);
  CheckFind('+44/121/234/5678', 'GB', pnlStrictGrouping, UnlimitedTries, []);
  CheckFind('+44/121/234/5678', 'GB', pnlExactGrouping, UnlimitedTries, []);
end;

procedure TPhoneNumberMatcherTests.Leniency_NationalPrefixIsRequiredWhenTheFormatSaysSo;
begin
  { isNationalPrefixPresentIfRequired. The German national format carries the
    national prefix formatting rule "0$1", which is neither optional nor the
    bare first group symbol, so a number written in national format WITHOUT
    the leading zero is possible but not valid. }
  CheckFind('30 123456', 'DE', pnlPossible, UnlimitedTries,
    ['0|30 123456|+4930123456']);
  CheckFind('30 123456', 'DE', pnlValid, UnlimitedTries, []);
  CheckFind('89 12345678', 'DE', pnlPossible, UnlimitedTries,
    ['0|89 12345678|+498912345678']);
  CheckFind('89 12345678', 'DE', pnlValid, UnlimitedTries, []);

  { With the national prefix in place both are accepted. }
  CheckValid('030 123456', 'DE', ['0|030 123456|+4930123456']);
  CheckValid('089 12345678', 'DE', ['0|089 12345678|+498912345678']);

  { Same rule in the United Kingdom, which is why this candidate never even
    reaches the slash check of the grouping levels. }
  CheckFind('121/234/5678', 'GB', pnlPossible, UnlimitedTries,
    ['0|121/234/5678|+441212345678']);
  CheckFind('121/234/5678', 'GB', pnlValid, UnlimitedTries, []);

  { The counter case that shows it is really the PREFIX and not the region:
    written in international format the check is skipped entirely, because
    the calling code was not deduced from the default region. }
  CheckValid('+49 30 123456', 'DE', ['0|+49 30 123456|+4930123456']);
end;

procedure TPhoneNumberMatcherTests.Leniency_ExactGroupingSkipsTheExtensionGroup;
begin
  { allNumberGroupsAreExactlyPresent starts at the last candidate group, or
    at the one before it when the number has an extension. With the extension
    group skipped, "650 253 0000" is grouped exactly as it would be
    formatted. }
  CheckFind('650 253 0000 ext. 1234', 'US', pnlStrictGrouping, UnlimitedTries,
    ['0|650 253 0000 ext. 1234|+16502530000']);
  CheckFind('650 253 0000 ext. 1234', 'US', pnlExactGrouping, UnlimitedTries,
    ['0|650 253 0000 ext. 1234|+16502530000']);

  { The national number as one single block plus an extension is accepted as
    well - that is the "candidateGroups[index] contains the national
    significant number" branch. }
  CheckFind('6502530000 ext. 1234', 'US', pnlExactGrouping, UnlimitedTries,
    ['0|6502530000 ext. 1234|+16502530000']);

  { And the discriminating one: the same extension, but the national number
    is grouped in a way this library would not produce. STRICT still accepts
    it, EXACT does not. }
  CheckFind('650 2530000 ext. 1234', 'US', pnlStrictGrouping, UnlimitedTries,
    ['0|650 2530000 ext. 1234|+16502530000']);
  CheckFind('650 2530000 ext. 1234', 'US', pnlExactGrouping, UnlimitedTries,
    []);
end;

procedure TPhoneNumberMatcherTests.Leniency_GroupingSkipsTheCountryCodeInTheCandidate;
begin
  { allNumberGroupsRemainGrouped skips the country calling code in the
    normalized candidate before it walks the formatted groups. Here the
    calling code "1" occurs twice, so the skip has to consume the FIRST
    occurrence and the group walk has to start behind it. }
  CheckFind('+1 1 650 253 0000', 'US', pnlValid, UnlimitedTries,
    ['0|+1 1 650 253 0000|+16502530000']);
  CheckFind('+1 1 650 253 0000', 'US', pnlStrictGrouping, UnlimitedTries,
    ['0|+1 1 650 253 0000|+16502530000']);
  CheckFind('+1 1 650 253 0000', 'US', pnlExactGrouping, UnlimitedTries,
    ['0|+1 1 650 253 0000|+16502530000']);

  { The German national destination code 4921 repeats the calling code 49,
    which is the same situation one level deeper. }
  CheckFind('+49 4921 12345', 'DE', pnlValid, UnlimitedTries,
    ['0|+49 4921 12345|+49492112345']);
  CheckFind('+49 4921 12345', 'DE', pnlStrictGrouping, UnlimitedTries,
    ['0|+49 4921 12345|+49492112345']);
  CheckFind('+49 4921 12345', 'DE', pnlExactGrouping, UnlimitedTries,
    ['0|+49 4921 12345|+49492112345']);

  { Discriminating counter case: the same digits, but the grouping boundary
    falls inside the national destination code, so the first formatted group
    is not present as a run any more. }
  CheckFind('+4949211 2345', 'DE', pnlValid, UnlimitedTries,
    ['0|+4949211 2345|+49492112345']);
  CheckFind('+4949211 2345', 'DE', pnlStrictGrouping, UnlimitedTries, []);
  CheckFind('+4949211 2345', 'DE', pnlExactGrouping, UnlimitedTries, []);
end;

{ ------------------------------------------------------------------
  Extensions. Oracle verified.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.Extensions_ArePartOfTheMatch;
var
  Matches: TPhoneNumberMatchArray;
begin
  CheckValid('Call 650-253-4561 x 1234', 'US',
    ['5|650-253-4561 x 1234|+16502534561']);
  CheckValid('Tel: 650-253-0000 ext. 1234', 'US',
    ['5|650-253-0000 ext. 1234|+16502530000']);
  CheckValid('03 331 6005 ext 3456', 'NZ',
    ['0|03 331 6005 ext 3456|+6433316005']);

  Matches := FindNumbers('Tel: 650-253-0000 ext. 1234', 'US');
  CheckInt(1, Length(Matches), 'one match');
  Assert.AreEqual('1234', Matches[0].Number.Extension, 'extension');
end;

procedure TPhoneNumberMatcherTests.ExtnPatternsForMatching_HasNoAutoDiallingAlternatives;
var
  Matches: TPhoneNumberMatchArray;

  { The discriminating shape: the PARSE path finds the extension, the MATCH
    path does not even take the marker into the raw string. }
  procedure CheckParsingOnlyMarker(const AText: string);
  begin
    Assert.AreEqual('1234', ParsedExtension(AText, 'US'),
      'parse("' + AText + '") must see the extension');
    CheckValid(AText, 'US', ['0|650-253-0000|+16502530000']);
    Assert.AreEqual('', FindNumbers(AText, 'US')[0].Number.Extension,
      'match("' + AText + '") must NOT see the extension');
  end;

begin
  { createExtnPattern(false) drops the two alternatives that only exist for
    auto dialling: autoDiallingExtn (a semicolon, or exactly two commas) and
    onlyCommasExtn (a run of commas). Neither marker is VALID_PUNCTUATION
    either, so PATTERN stops in front of it and the raw string ends with the
    national number. }
  CheckParsingOnlyMarker('650-253-0000;1234');
  CheckParsingOnlyMarker('650-253-0000,,1234');
  CheckParsingOnlyMarker('650-253-0000,1234');

  { The contrast: rfcExtn IS in both constants, so the very same semicolon
    followed by "ext=" extends the raw string and yields the extension. }
  CheckValid('650-253-0000;ext=1234', 'US',
    ['0|650-253-0000;ext=1234|+16502530000']);
  Matches := FindNumbers('650-253-0000;ext=1234', 'US');
  Assert.AreEqual('1234', Matches[0].Number.Extension, 'rfc3966 extension');

  { And the upstream note that a lone comma is not an extension label when
    matching: here the comma is only a separator in front of the ambiguous
    'x' label, which IS one of the four matching alternatives. }
  CheckValid('(800) 901-3355 ,x 7246433', 'US',
    ['0|(800) 901-3355 ,x 7246433|+18009013355']);
  Matches := FindNumbers('(800) 901-3355 ,x 7246433', 'US');
  Assert.AreEqual('7246433', Matches[0].Number.Extension, 'ambiguous label');

  CheckValid('(800) 901-3355 , ext 7246433', 'US',
    ['0|(800) 901-3355 , ext 7246433|+18009013355']);
  Matches := FindNumbers('(800) 901-3355 , ext 7246433', 'US');
  Assert.AreEqual('7246433', Matches[0].Number.Extension, 'explicit label');
end;

{ ------------------------------------------------------------------
  INNER_MATCHES. Oracle verified.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.InnerMatch_SpacedHyphenSplitsTheCandidate;
begin
  { INNER_MATCHES[2], "(?:\p<Z>-|-\p<Z>)\p<Z>*(.+)". }
  CheckValid('12345 - 650-253-0000 is my number.', 'US',
    ['8|650-253-0000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.InnerMatch_FullStopSplitsTheCandidate;
begin
  { INNER_MATCHES[4], "\.+\p<Z>*([^.]+)". }
  CheckValid('12345. 650-253-0000 is my number.', 'US',
    ['7|650-253-0000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.InnerMatch_SpaceSplitsTheCandidate;
begin
  { INNER_MATCHES[5], "\p<Z>+(\P<Z>+)". The first match handles the text in
    front of the separator, which is why the FIRST number is reported from the
    inner match and the second one from the next PATTERN find. }
  CheckValid('3324451234 8002341234', 'US',
    ['0|3324451234|+13324451234',
     '11|8002341234|+18002341234']);
end;

procedure TPhoneNumberMatcherTests.InnerMatch_SpacedHyphenAlsoReleasesTheSecondNumber;
begin
  { Upstream testMatchesMultiplePhoneNumbersSeparatedByPhoneNumberPunctuation.
    Its second number, 455-234-3451, is only valid under the upstream TESTING
    metadata, so this uses the productive 415-666-7777 instead (AGENTS.md
    "Test Expectations"); the oracle confirms both matches.

    " -- " is four punctuation characters, so PATTERN swallows both numbers.
    INNER_MATCHES[2] then yields the first one, and the next PATTERN find,
    which starts behind it, yields the second. }
  CheckValid('Call 650-253-4561 -- 415-666-7777', 'US',
    ['5|650-253-4561|+16502534561',
     '21|415-666-7777|+14156667777']);
end;

procedure TPhoneNumberMatcherTests.InnerMatch_SeparatorRunInFrontOfTheGroupIsConsumed;
begin
  { INNER_MATCHES[2] is "(?:\p<Z>-|-\p<Z>)\p<Z>*(.+)": the separator RUN
    behind the hyphen belongs to the match, not to the captured group, so the
    reported offset moves with it. One space and two spaces, one apart. }
  CheckValid('12345 - 650-253-0000', 'US', ['8|650-253-0000|+16502530000']);
  CheckValid('12345 -  650-253-0000', 'US', ['9|650-253-0000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.InnerMatch_FindIsRepeatedOnTheSameCandidate;
begin
  { INNER_MATCHES[5] is applied in a find() LOOP, so a candidate can be cut
    more than once. Here the leading group and the first captured group are
    both rejected and only the third attempt - the second find() - carries a
    number.

    ORACLE: no match. Its single "first group / without first group / without
    last group" attempt never reaches the third group. }
  CheckValid('12345 99999 650-253-0000', 'US',
    ['12|650-253-0000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.InnerMatch_MaxTriesIsSpentInsideTheInnerExtraction;
const
  Text = '12345 99999 650-253-0000';
begin
  { Every rejected inner group costs one try, and the budget is only re-read
    at the TOP of the find() loop, exactly like upstream. The leading group
    "12345" and the captured group "99999" are two rejects, so the number is
    out of reach until the third try.

    Java derived, like InnerMatch_FindIsRepeatedOnTheSameCandidate: the C#
    matcher spends its budget in a different place. }
  CheckFind(Text, 'US', pnlValid, 1, []);
  CheckFind(Text, 'US', pnlValid, 2, []);
  CheckFind(Text, 'US', pnlValid, 3, ['12|650-253-0000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.InnerMatch_NoWhiteSpaceBetweenNumbersFindsNothing;
begin
  { Upstream testDoesNotMatchMultiplePhoneNumbersSeparatedWithNoWhiteSpace:
    INNER_MATCHES[2] requires a separator NEXT to the hyphen, so nothing
    splits this candidate and the 20 digit whole is not a number. }
  CheckValid('Call 650-253-4561--415-666-7777', 'US', []);
  CheckValid('Call 650-253-4561--455-234-3451', 'US', []);
end;

{ ------------------------------------------------------------------
  maxTries and the iterator.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.MaxTries_LimitsTheNumberOfCandidates;
const
  Text = 'Call me at 510-748-8230 if it''s before 9:30, '
    + 'or on 703-4800500 after 10am.';
begin
  { The text holds two numbers with exactly two failing candidates between
    them. Neither of those is "9:30": the colon is not VALID_PUNCTUATION, so
    PATTERN cannot join the two digit blocks and produces "9" at offset 39 and
    "30" at offset 41 as two SEPARATE candidates. Each costs one try, and a
    SUCCESSFUL candidate costs none, which is why the budget has to reach 3
    before the second number becomes reachable. "10am" is never looked at. }
  CheckFind(Text, 'US', pnlValid, 1, ['11|510-748-8230|+15107488230']);
  CheckFind(Text, 'US', pnlValid, 2, ['11|510-748-8230|+15107488230']);
  CheckFind(Text, 'US', pnlValid, 3,
    ['11|510-748-8230|+15107488230',
     '51|703-4800500|+17034800500']);
  CheckFind(Text, 'US', pnlValid, UnlimitedTries,
    ['11|510-748-8230|+15107488230',
     '51|703-4800500|+17034800500']);
end;

procedure TPhoneNumberMatcherTests.MaxTries_ZeroFindsNothing;
begin
  CheckFind('Call me at 510-748-8230.', 'US', pnlValid, 0, []);
end;

procedure TPhoneNumberMatcherTests.Iterator_HasNextIsIdempotentAndNextAdvances;
var
  Matcher: TPhoneNumberMatcher;
  First, Second: TPhoneNumberMatch;
begin
  Matcher := TPhoneNumberMatcher.Create(
    'My number is 650-253-0000 and my fax is 650-253-0001.', 'US', pnlValid,
    UnlimitedTries);
  try
    Assert.IsTrue(Matcher.HasNext, 'first HasNext');
    Assert.IsTrue(Matcher.HasNext, 'HasNext is idempotent');
    First := Matcher.Next;
    CheckInt(13, First.Start, 'first start');
    Assert.AreEqual('650-253-0000', First.RawString, 'first raw');
    CheckInt(25, First.EndIndex, 'first end');

    Assert.IsTrue(Matcher.HasNext, 'second HasNext');
    Second := Matcher.Next;
    CheckInt(40, Second.Start, 'second start');

    Assert.IsFalse(Matcher.HasNext, 'no third match');
  finally
    Matcher.Free;
  end;
end;

procedure TPhoneNumberMatcherTests.Iterator_NextRaisesAtTheEnd;
var
  Matcher: TPhoneNumberMatcher;
  Raised: Boolean;
begin
  Matcher := TPhoneNumberMatcher.Create('no numbers here', 'US', pnlValid,
    UnlimitedTries);
  try
    Assert.IsFalse(Matcher.HasNext, 'HasNext');
    Raised := False;
    try
      Matcher.Next;
    except
      on EPhoneNumberMatcher do
        Raised := True;
    end;
    Assert.IsTrue(Raised, 'Next must raise when there is no further match');
  finally
    Matcher.Free;
  end;
end;

procedure TPhoneNumberMatcherTests.Constructor_RejectsNegativeMaxTries;
var
  Matcher: TPhoneNumberMatcher;
  Raised: Boolean;
begin
  Raised := False;
  Matcher := nil;
  try
    Matcher := TPhoneNumberMatcher.Create('x', 'US', pnlValid, -1);
  except
    on EPhoneNumberMatcher do
      Raised := True;
  end;
  Matcher.Free;
  Assert.IsTrue(Raised, 'a negative maxTries must be rejected');
end;

{ ------------------------------------------------------------------
  Mass smoke.

  For each region the sentence "Call me at <INTERNATIONAL> or <NATIONAL>."
  is built from the FIXED_LINE example number of the region and both numbers
  have to be found, in this order, with the same E164.

  The three columns are the international spelling, the national spelling and
  the expected E164; all of them were read off the NuGet oracle
  (GetExampleNumberForType(region, FIXED_LINE) plus Format), and the oracle
  finds exactly these two matches in each sentence.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.ExampleNumbersInASentence_AreFoundInBothFormats;
const
  Cases: array[0..24, 0..3] of string = (
    ('US', '+1 201-555-0123',   '(201) 555-0123',  '+12015550123'),
    ('DE', '+49 30 123456',     '030 123456',      '+4930123456'),
    ('GB', '+44 121 234 5678',  '0121 234 5678',   '+441212345678'),
    ('FR', '+33 1 23 45 67 89', '01 23 45 67 89',  '+33123456789'),
    ('IT', '+39 02 1234 5678',  '02 1234 5678',    '+390212345678'),
    ('ES', '+34 810 12 34 56',  '810 12 34 56',    '+34810123456'),
    ('NL', '+31 10 123 4567',   '010 123 4567',    '+31101234567'),
    ('CH', '+41 21 234 56 78',  '021 234 56 78',   '+41212345678'),
    ('AT', '+43 1 234567890',   '01 234567890',    '+431234567890'),
    ('SE', '+46 8 12 34 56',    '08-12 34 56',     '+468123456'),
    ('PL', '+48 12 345 67 89',  '12 345 67 89',    '+48123456789'),
    ('BR', '+55 11 2345-6789',  '(11) 2345-6789',  '+551123456789'),
    ('AU', '+61 2 1234 5678',   '(02) 1234 5678',  '+61212345678'),
    ('JP', '+81 3-1234-5678',   '03-1234-5678',    '+81312345678'),
    ('CA', '+1 506-234-5678',   '(506) 234-5678',  '+15062345678'),
    ('MX', '+52 200 123 4567',  '200 123 4567',    '+522001234567'),
    ('IN', '+91 74104 10123',   '074104 10123',    '+917410410123'),
    ('ZA', '+27 10 123 4567',   '010 123 4567',    '+27101234567'),
    ('NZ', '+64 3 234 5678',    '03 234 5678',     '+6432345678'),
    ('BE', '+32 12 34 56 78',   '012 34 56 78',    '+3212345678'),
    ('DK', '+45 32 12 34 56',   '32 12 34 56',     '+4532123456'),
    ('NO', '+47 21 23 45 67',   '21 23 45 67',     '+4721234567'),
    ('FI', '+358 13 1234567',   '013 1234567',     '+358131234567'),
    ('PT', '+351 21 234 5678',  '21 234 5678',     '+351212345678'),
    ('IE', '+353 22 12345',     '(022) 12345',     '+3532212345')
  );
var
  I: Integer;
  Text: string;
  Matches: TPhoneNumberMatchArray;
begin
  for I := Low(Cases) to High(Cases) do
  begin
    Text := 'Call me at ' + Cases[I, 1] + ' or ' + Cases[I, 2] + '.';
    Matches := FindNumbers(Text, Cases[I, 0]);

    CheckInt(2, Length(Matches),
      Format('%s: "%s" -> %s', [Cases[I, 0], Text, Describe(Matches)]));
    Assert.AreEqual(Cases[I, 1], Matches[0].RawString,
      Cases[I, 0] + ': international raw string');
    CheckInt(11, Matches[0].Start, Cases[I, 0] + ': international start');
    Assert.AreEqual(Cases[I, 3], E164(Matches[0]),
      Cases[I, 0] + ': international E164');
    Assert.AreEqual(Cases[I, 2], Matches[1].RawString,
      Cases[I, 0] + ': national raw string');
    CheckInt(11 + Length(Cases[I, 1]) + 4, Matches[1].Start,
      Cases[I, 0] + ': national start');
    Assert.AreEqual(Cases[I, 3], E164(Matches[1]),
      Cases[I, 0] + ': national E164');
  end;
end;

{ ------------------------------------------------------------------
  PINNED JAVA VERSUS ORACLE DIVERGENCES.

  Every case below exercises PhoneNumberMatcher.extractInnerMatch, which the
  C# port implements with an older, different algorithm (see the unit header).
  The expected value is therefore the JAVA one, derived from the Java source,
  and the oracle answer is written down next to it.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.Divergence_SlashInnerMatchIsFoundLikeJava;
begin
  { PATTERN matches the whole string, because '/' is VALID_PUNCTUATION, and
    the whole string does not parse (20 digits). Java then runs
    INNER_MATCHES[0] = "/+(.*)", whose FIRST match makes it look at the text
    in FRONT of the slash - "651-234-2345", a valid US number at offset 0.
    The next PATTERN find starts behind it and yields "332-445-1234"; both
    numbers are valid in the productive metadata (checked with the oracle).

    ORACLE: no matches at all. The C# port has no slash inner match (its
    single GroupSeparator pattern needs white space), so it never looks
    inside this candidate. }
  CheckValid('651-234-2345/332-445-1234', 'US',
    ['0|651-234-2345|+16512342345',
     '13|332-445-1234|+13324451234']);
end;

procedure TPhoneNumberMatcherTests.Divergence_BracketInnerMatchIsFoundLikeJava;
begin
  { INNER_MATCHES[1] = "(\([^(]*)", the case the upstream comment names
    explicitly ("Will match a pattern like (650) 223 3345 (754) 223 3321").
    The whole candidate does not parse, so the first bracket group
    "(650) 223 3345" is tried and accepted; the next PATTERN find then starts
    at the second bracket.

    ORACLE: no matches. Its ExtractInnerMatch cuts on white space only, and
    the first white space separated group "(650)" is not a number. }
  CheckValid('(650) 223 3345 (754) 223 3321', 'US',
    ['0|(650) 223 3345|+16502233345',
     '15|(754) 223 3321|+17542233321']);
end;

procedure TPhoneNumberMatcherTests.Divergence_DoubledOpeningBracketFallsBackToTheInnerMatch;
begin
  { MATCHING_BRACKETS rejects "((650) 253-0000" as a whole - its leading
    "(?:[openingParens])?" can absorb only ONE of the two brackets and
    "nonParens+" cannot match the second. Java then runs INNER_MATCHES[1]:
    its first match is the bare "(" at index 0 (which trims to nothing), its
    second match is "(650) 253-0000" at index 1, and that one is a valid US
    number.

    ORACLE: no match under VALID, and "253-0000" at offset 7 under POSSIBLE -
    both artefacts of the older C# ExtractInnerMatch. }
  CheckValid('((650) 253-0000', 'US', ['1|(650) 253-0000|+16502530000']);
end;

procedure TPhoneNumberMatcherTests.Divergence_WideHyphensSplitTheCandidateLikeJava;

  procedure CheckWideHyphen(ACode: Integer; const AName: string);
  var
    Text: string;
  begin
    Text := '650-253-0000' + Cp(ACode) + '415-666-7777';
    { UTF-16 code units, like the match offsets (FreePascal: `string` is UTF-8). }
    Assert.AreEqual(25, Length(UnicodeString(Text)), AName + ': text length');
    CheckValid(Text, 'US',
      ['0|650-253-0000|+16502530000',
       '13|415-666-7777|+14156667777']);
  end;

begin
  { INNER_MATCHES[3] is the wide hyphen class, and it is the only one of the
    six that does NOT require a separator next to the break character - "it's
    possible that it's supposed to be used to break two numbers without
    spaces". All members of the class are VALID_PUNCTUATION too, so PATTERN
    swallows both numbers into one candidate first.

    ORACLE: no match at all for any of the three, at any leniency - the C#
    matcher has no wide hyphen inner match. }
  CheckWideHyphen($2012, 'FIGURE DASH');
  CheckWideHyphen($2013, 'EN DASH');
  CheckWideHyphen($2015, 'HORIZONTAL BAR');
  CheckWideHyphen($FF0D, 'FULLWIDTH HYPHEN-MINUS');
end;

procedure TPhoneNumberMatcherTests.Divergence_SlashRunIsConsumedAsAWholeLikeJava;
begin
  { INNER_MATCHES[0] is "/+(.*)": the whole RUN of slashes belongs to the
    match, so the captured group starts at 14 and not at 13.

    Note that the empty capture of that group is unreachable from a PATTERN
    candidate: such a candidate always ends in a digit or in the hash sign of
    an extension, never in a slash, so ".*" always has at least the rest of
    the second number to consume.

    ORACLE: no match - see Divergence_SlashInnerMatchIsFoundLikeJava. }
  CheckValid('650-253-0000//415-666-7777', 'US',
    ['0|650-253-0000|+16502530000',
     '14|415-666-7777|+14156667777']);
end;

{ ------------------------------------------------------------------
  THE ALTERNATE FORMAT METADATA.

  checkNumberGroupingIsValid consults PhoneNumberAlternateFormats.xml after
  the default grouping check failed. That XML is a generator input
  (src/LibPhoneNumber.AlternateFormats.Data.pas, reached through
  LibPhoneNumber.AlternateFormats), and the case here answers exactly what
  the oracle answers.
  ------------------------------------------------------------------ }

procedure TPhoneNumberMatcherTests.AlternateFormatsAreConsultedByTheGroupingCheck;
begin
  { +49 4921 12345 formats as "04921 12345", so the default grouping check
    finds "4921" as a run and passes. Written as "49 21" the run is broken and
    the default check fails; one of the 41 ALTERNATE formats of calling code 49
    still accepts it, which is what the retry loop of
    checkNumberGroupingIsValid is for.

    ORACLE: 0|+49 49 21 12345|+49492112345 at STRICT_GROUPING. }
  CheckFind('+49 49 21 12345', 'DE', pnlValid, UnlimitedTries,
    ['0|+49 49 21 12345|+49492112345']);
  CheckFind('+49 49 21 12345', 'DE', pnlStrictGrouping, UnlimitedTries,
    ['0|+49 49 21 12345|+49492112345']);
  { EXACT_GROUPING rejects it upstream as well: the alternate format groups the
    number 49-21-123-45, the candidate is written 49 21 12345. }
  CheckFind('+49 49 21 12345', 'DE', pnlExactGrouping, UnlimitedTries, []);
end;

initialization
  RegisterTest(TPhoneNumberMatcherTests);

end.
