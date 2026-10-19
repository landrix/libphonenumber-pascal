unit LibPhoneNumber.PhoneNumberMatcher;

{
  Phone number matcher.

  A literal port of upstream
  com/google/i18n/phonenumbers/PhoneNumberMatcher.java plus the four
  PhoneNumberUtil.Leniency levels and the three PhoneNumberUtil entry points
  that create a matcher (findNumbers). Java is the source of truth; the C#
  port was used as a translation aid and as the reference oracle for every
  expected value in the test suite WHERE JAVA AND C# AGREE. That
  qualification matters here and nowhere else in this port: the C#
  PhoneNumberMatcher is not a current translation of the Java one (five
  documented deviations, extractInnerMatch above all), so a handful of test
  expectations are derived from the Java source instead and are pinned as
  such. The test unit header lists the deviations and the pinned cases.

  Notation in the comments of this unit
  -------------------------------------
  A closing brace ends a Pascal comment, so the upstream expressions are
  quoted with ANGLE brackets wherever they use a Unicode property class or a
  bounded repetition: \p<Nd> is \p and the brace form of Nd, ")<0,2>" is the
  brace form of the quantifier "0 to 2 times". The pattern STRINGS in the code
  below are of course spelled normally.

  Ported members, in upstream order:

    PATTERN / LEAD_CLASS / MATCHING_BRACKETS (static initialiser)
                                       -> the scanners and pattern constants
                                          of the PATTERNS section below
    PUB_PAGES                          -> PubPagesPattern
    SLASH_SEPARATED_DATES              -> SlashSeparatedDatesPattern
    TIME_STAMPS / TIME_STAMPS_SUFFIX   -> TimeStampsPattern /
                                          TimeStampsSuffixPattern
    INNER_MATCHES                      -> TInnerMatchKind /
                                          TryFindInnerMatch
    limit(lower, upper)                -> the *Limit constants
    find(index)                        -> TPhoneNumberMatcher.Find
    trimAfterFirstMatch                -> TrimAtSecondNumberStart /
                                          TrimUnwantedEndChars
    isLatinLetter                      -> IsLatinLetter
    isInvalidPunctuationSymbol         -> IsInvalidPunctuationSymbol
    extractMatch                       -> TPhoneNumberMatcher.ExtractMatch
    extractInnerMatch                  -> TPhoneNumberMatcher.ExtractInnerMatch
    parseAndVerify                     -> TPhoneNumberMatcher.ParseAndVerify
    allNumberGroupsRemainGrouped       -> AllNumberGroupsRemainGrouped
    allNumberGroupsAreExactlyPresent   -> AllNumberGroupsAreExactlyPresent
    getNationalNumberGroups (both)     -> GetNationalNumberGroups /
                                          GetNationalNumberGroupsForPattern
    checkNumberGroupingIsValid         -> TPhoneNumberMatcher
                                            .CheckNumberGroupingIsValid
    containsMoreThanOneSlashInNationalNumber
                                       -> ContainsMoreThanOneSlashInNationalNumber
    containsOnlyValidXChars            -> ContainsOnlyValidXChars
    isNationalPrefixPresentIfRequired  -> IsNationalPrefixPresentIfRequired
    hasNext / next                     -> TPhoneNumberMatcher.HasNext / Next
    Leniency.verify (all four)         -> TPhoneNumberMatcher.Verify
    PhoneNumberUtil.findNumbers        -> FindNumbers

  Shape decisions
  ---------------
  1. CLASS, like the AsYouTypeFormatter and unlike the rest of the port: the
     upstream type is a stateful java.util.Iterator, so a class is the shape
     that survives the translation. Iteration is the upstream HasNext/Next
     pair; TryNext is a convenience wrapper over the two for the common
     "while there is another match" loop. There is deliberately no Delphi
     enumerator: a for-in loop cannot report the maxTries budget running out,
     which is an observable part of the upstream contract.

  2. The module level FindNumbers is upstream PhoneNumberUtil.findNumbers.
     Upstream returns an Iterable that creates a fresh matcher per iteration;
     here it materialises the matches into an array, because that is what
     every caller of a findNumbers in this port does and because an array
     needs no lifetime management. Use TPhoneNumberMatcher directly when the
     text is large and only the first match is interesting.

  3. Offsets are UPSTREAM offsets: TPhoneNumberMatch.Start is
     PhoneNumberMatch.start(), i.e. a ZERO based index into the text, and
     EndIndex is PhoneNumberMatch.end(). Both are UTF-16 code unit offsets
     on both compilers: add one to index the UnicodeString form of the text
     with them (on Delphi that is the `string` itself; on FreePascal the
     `string` is UTF-8 and the offsets are NOT byte offsets). The scanners
     inside this unit work on a UnicodeString with one based indices and
     convert at the boundary, and every length or index this unit computes
     from a `string` (a candidate, a raw string, a normalized candidate) is
     taken from its UnicodeString form - see the Java string helpers.

  4. FreePascal: the unit compiles and runs with FreePascal and is part of
     both FreePascal gates (tools/check_fpc_compile.ps1, and the runtime gate
     tools/run_fpc_runtime_check.ps1, which runs findNumbers under all four
     leniencies over the texts of the two matcher test units, in context,
     and over sentences built from every example number). It could only join
     them together with the facade, because parseAndVerify calls
     parseAndKeepRawInput and containsOnlyValidXChars calls isNumberMatch.
     The `string` contract is the facade's: UTF-8 on FreePascal (see the
     header of LibPhoneNumber.PhoneNumberUtil). EXTN_PATTERNS_FOR_MATCHING lives next to
     EXTN_PATTERNS_FOR_PARSING in LibPhoneNumber.MetadataCore, where it
     belongs anyway.

  Scanner versus regular expression, per construct
  ------------------------------------------------
  The port keeps engine dialect differences out of the metadata layer by
  construction (see the header of LibPhoneNumber.Regex). The rule applied
  here is the one the parse path uses: an expression goes through the regex
  abstraction when it is pure ASCII, needs no Unicode general categories and
  no flags; otherwise it is scanned.

    MATCHING_BRACKETS   REGEX over a FOLDED candidate. It is a plain
                        concatenation of character classes with bounded
                        repetition, compiled WITHOUT flags upstream, and it
                        is used with matches(). It only ever asks which of
                        three classes a character belongs to - opening
                        bracket, closing bracket, anything else - so the
                        candidate is folded onto one ASCII representative per
                        class first (FoldBracketClasses) and the pattern is
                        pure ASCII. See there for why the four non ASCII
                        brackets (U+FF08 U+FF3B U+FF09 U+FF3D) must not reach
                        the regex engine on FreePascal.
    PUB_PAGES           REGEX, with \d and \s EXPANDED to their Java meaning
    SLASH_SEPARATED     ([0-9] and [ \t\n\x0B\f\r]). Java's \d and \s are
    _DATES              ASCII only unless UNICODE_CHARACTER_CLASS is set,
    TIME_STAMPS         while .NET's \d is Unicode Nd and its \s is Unicode
    TIME_STAMPS_SUFFIX  white space unless RegexOptions.ECMAScript is passed,
                        and TRegExpr brings a third answer again. Writing the
                        classes out is what makes these four patterns mean the
                        JAVA thing on every engine.
    PATTERN             SCANNER. It needs \p<Nd> over code points, the non
                        ASCII VALID_PUNCTUATION and PLUS_CHARS classes, and it
                        ends in EXTN_PATTERNS_FOR_MATCHING, which is exactly
                        the case insensitive, non ASCII, Unicode digit
                        expression the parse path already scans. Its grammar is
                        four bounded repetitions over three character classes,
                        so the greedy reduction is written out and argued at
                        MatchPatternLead / MatchPatternDigitBlocks.
    LEAD_CLASS          SCANNER (a one character class, used with lookingAt).
    INNER_MATCHES       SCANNERS. All six need \p<Z> or \P<Z>, and the caller
                        needs Matcher.start(1) and group(1), which the regex
                        abstraction of this port does not expose (it has
                        groups for lookingAt only). Six one line grammars are
                        cheaper than a seventh regex operation.
    SECOND_NUMBER_START SCANNERS. Both are consumed through Matcher.start()
    UNWANTED_END_CHARS  only (trimAfterFirstMatch), and UNWANTED_END_CHARS is
                        the Unicode category expression
                        LibPhoneNumber.MetadataCore already scans for
                        extractPossibleNumber - its predicate is reused.

  Alternate format metadata
  ---------------------------------------
  checkNumberGroupingIsValid retries with the ALTERNATE FORMAT metadata of the
  calling code after the default grouping check failed, exactly like upstream.
  The data comes from LibPhoneNumber.AlternateFormats, the port of the
  FormattingMetadataSource behind DefaultMetadataDependenciesProvider. Note
  that this source is a static singleton upstream which
  PhoneNumberUtil.setInstance does NOT touch, so it stays on the PRODUCTION
  alternate formats even while the phone metadata is switched to the test data
  set; this port keeps that split.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  SysUtils,
  Character,
{$ELSE}
  System.SysUtils,
  System.Character,
{$ENDIF}
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata.Types;

type
  { Raised by TPhoneNumberMatcher.Next when there is no further match (Java
    throws NoSuchElementException there) and by the constructor for a negative
    maxTries (Java throws IllegalArgumentException). }
  EPhoneNumberMatcher = class(Exception);

  { Port of PhoneNumberUtil.Leniency, in upstream declaration order. The order
    is load bearing: parseAndVerify compares with
    "leniency.compareTo(Leniency.VALID) >= 0", which is the >= pnlValid test
    here. }
  TPhoneNumberLeniency = (
    { Numbers accepted are possible, but not necessarily valid. }
    pnlPossible,
    { Numbers accepted are possible AND valid. A number written in national
      format must carry its national prefix if that is how a number of its
      type is usually written. }
    pnlValid,
    { Valid, and grouped in a possible way for the region. A US number written
      as "65 02 53 00 00" or "650253 0000" is not accepted here, while
      "650 253 0000", "650 2530000" and "6502530000" are. }
    pnlStrictGrouping,
    { Valid, and grouped exactly the way this library would have formatted it,
      or as one single block. "650 2530000" is rejected here, "650 253 0000"
      and "6502530000" are accepted. }
    pnlExactGrouping
  );

  { Port of PhoneNumberMatch.

    Start is the UPSTREAM offset: a ZERO based index into the searched text,
    i.e. PhoneNumberMatch.start(). EndIndex is PhoneNumberMatch.end().
    RawString is the matched text, Number the parsed number - with
    CountryCodeSource, RawInput and PreferredDomesticCarrierCode cleared,
    exactly like upstream clears them before it builds the match. }
  TPhoneNumberMatch = record
    Start: Integer;
    RawString: string;
    Number: TPhoneNumber;
    function EndIndex: Integer;
  end;

  TPhoneNumberMatchArray = array of TPhoneNumberMatch;

  { Port of PhoneNumberMatcher, the stateful Iterator<PhoneNumberMatch>.

    Not thread safe, exactly like upstream. }
  TPhoneNumberMatcher = class
  private
    type
      { Upstream PhoneNumberMatcher.State. }
      TMatcherState = (msNotReady, msReady, msDone);
    var
      { The searched text. Held as a UnicodeString because every offset this
        class reports is a java.util.regex offset, i.e. a UTF-16 code unit
        index; `string` is AnsiString on FreePascal and could not carry one. }
      FText: UnicodeString;
      FTextLength: Integer;
      FPreferredRegion: string;
      FLeniency: TPhoneNumberLeniency;
      FMaxTries: Int64;
      FState: TMatcherState;
      FLastMatch: TPhoneNumberMatch;
      { The next index to start searching at, ONE based. }
      FSearchIndex: Integer;

    function Find(AIndex: Integer; out AMatch: TPhoneNumberMatch): Boolean;
    function ExtractMatch(const ACandidate: string; AOffset: Integer;
      out AMatch: TPhoneNumberMatch): Boolean;
    function ExtractInnerMatch(const ACandidate: string; AOffset: Integer;
      out AMatch: TPhoneNumberMatch): Boolean;
    function ParseAndVerify(const ACandidate: string; AOffset: Integer;
      out AMatch: TPhoneNumberMatch): Boolean;
    { Upstream Leniency.verify for the level this matcher was created with. }
    function Verify(const ANumber: TPhoneNumber;
      const ACandidate: string): Boolean;
    { Upstream checkNumberGroupingIsValid. AExact selects the checker:
      False is allNumberGroupsRemainGrouped (STRICT_GROUPING), True is
      allNumberGroupsAreExactlyPresent (EXACT_GROUPING). The upstream
      NumberGroupingChecker interface collapses into that Boolean because the
      two implementations are the only ones that exist. }
    function CheckNumberGroupingIsValid(const ANumber: TPhoneNumber;
      const ACandidate: string; AExact: Boolean): Boolean;
  public
    { Upstream constructor. ACountry is the region to assume for numbers not
      written in international format; pass an empty string or 'ZZ' to accept
      only numbers that carry their own calling code. AMaxTries is the number
      of invalid candidates to try before giving up on the text and must not
      be negative. }
    constructor Create(const AText, ACountry: string;
      ALeniency: TPhoneNumberLeniency; AMaxTries: Int64);

    { Upstream Iterator.hasNext / Iterator.next. Next raises when there is no
      further match, exactly like Java's NoSuchElementException. }
    function HasNext: Boolean;
    function Next: TPhoneNumberMatch;

    { HasNext and Next in one call, for the usual iteration loop. }
    function TryNext(out AMatch: TPhoneNumberMatch): Boolean;
  end;

const
  { Upstream Long.MAX_VALUE, the maxTries of the two convenience overloads of
    PhoneNumberUtil.findNumbers. }
  UnlimitedTries = High(Int64);

{ Upstream PhoneNumberUtil.findNumbers(text, defaultRegion, leniency,
  maxTries), materialised into an array (see the unit header). }
function FindNumbers(const AText, ADefaultRegion: string;
  ALeniency: TPhoneNumberLeniency;
  AMaxTries: Int64): TPhoneNumberMatchArray; overload;

{ Upstream PhoneNumberUtil.findNumbers(text, defaultRegion), i.e. leniency
  VALID and an unlimited number of tries. }
function FindNumbers(const AText,
  ADefaultRegion: string): TPhoneNumberMatchArray; overload;

{ ------------------------------------------------------------------
  The static helpers of PhoneNumberMatcher. Package private upstream and
  exported here for the same reason: they are separately testable and the
  test suite pins them.
  ------------------------------------------------------------------ }

{ Upstream isLatinLetter(char). }
function IsLatinLetter(ACh: WideChar): Boolean;

{ Upstream isInvalidPunctuationSymbol(char). }
function IsInvalidPunctuationSymbol(ACh: WideChar): Boolean;

{ Upstream containsOnlyValidXChars(number, candidate, util). }
function ContainsOnlyValidXChars(const ANumber: TPhoneNumber;
  const ACandidate: string): Boolean;

{ Upstream containsMoreThanOneSlashInNationalNumber(number, candidate). }
function ContainsMoreThanOneSlashInNationalNumber(const ANumber: TPhoneNumber;
  const ACandidate: string): Boolean;

{ Upstream isNationalPrefixPresentIfRequired(number, util). }
function IsNationalPrefixPresentIfRequired(
  const ANumber: TPhoneNumber): Boolean;

{ Upstream allNumberGroupsRemainGrouped / allNumberGroupsAreExactlyPresent.
  ANormalizedCandidate is the candidate after normalizeDigits(keepNonDigits),
  AFormattedNumberGroups the digit blocks the number would be formatted in. }
function AllNumberGroupsRemainGrouped(const ANumber: TPhoneNumber;
  const ANormalizedCandidate: string;
  const AFormattedNumberGroups: TMetadataStringArray): Boolean;
function AllNumberGroupsAreExactlyPresent(const ANumber: TPhoneNumber;
  const ANormalizedCandidate: string;
  const AFormattedNumberGroups: TMetadataStringArray): Boolean;

implementation

uses
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.MetadataFormat,
  LibPhoneNumber.AlternateFormats,
  LibPhoneNumber.Regex,
  LibPhoneNumber.PhoneNumberUtil;

{ ==================================================================
  Constants of the static initialiser.
  ================================================================== }

const
  { Upstream PhoneNumberUtil.MAX_LENGTH_FOR_NSN / MAX_LENGTH_COUNTRY_CODE. }
  MaxLengthForNsn = 17;
  MaxLengthCountryCode = 3;

  { digitBlockLimit: "the maximum number of digits allowed in a digit
    separated block. As we allow all digits in a single block, set high enough
    to accommodate the entire national number and the international country
    code." }
  DigitBlockLimit = MaxLengthForNsn + MaxLengthCountryCode;

  { limit(0, 2) - the number of leading (plus) characters. }
  LeadLimit = 2;
  { limit(0, 4) - the number of consecutive punctuation characters. }
  PunctuationLimit = 4;
  { limit(0, digitBlockLimit) - the number of blocks separated by
    punctuation. Uses digitBlockLimit "since some formats use spaces to
    separate each digit". }
  BlockLimit = DigitBlockLimit;

{ ==================================================================
  PATTERNS.

  The four expressions below are the ones that go through the regex
  abstraction; see the "Scanner versus regular expression" section of the unit
  header for why these four and not the others.
  ================================================================== }

const
  { MATCHING_BRACKETS, built the way the upstream static initialiser builds
    it, over the FOLDED bracket classes (see FoldBracketClasses):

    "Pattern to check that brackets match. Opening brackets should be closed
    within a phone number. This also checks that there is something inside
    the brackets. Having no brackets at all is also fine."

    openingParens / closingParens are already escaped for use inside a
    character class, exactly like upstream writes them; nonParens is
    "[^" + openingParens + closingParens + "]"; the pair limit is
    limit(0, 3), the number of PAIRS of brackets in a phone number. "An
    opening bracket at the beginning may not be closed, but subsequent ones
    should be. It's also possible that the leading bracket was dropped, so we
    shouldn't be surprised if we see a closing bracket first." }
  FoldedOpeningParens = '(\[';
  FoldedClosingParens = ')\]';
  FoldedNonParens = '[^' + FoldedOpeningParens + FoldedClosingParens + ']';
  MatchingBracketsPattern =
    '(?:[' + FoldedOpeningParens + '])?'
    + '(?:' + FoldedNonParens + '+' + '[' + FoldedClosingParens + '])?'
    + FoldedNonParens + '+'
    + '(?:[' + FoldedOpeningParens + ']' + FoldedNonParens + '+['
    + FoldedClosingParens + '])'
    + '{0,3}'
    + FoldedNonParens + '*';

  { Java \d without UNICODE_CHARACTER_CLASS. }
  AsciiDigitClass = '[0-9]';
  { Java \s without UNICODE_CHARACTER_CLASS: space, tab, newline, vertical
    tab, form feed, carriage return. }
  AsciiSpaceClass = '[ ' + #9 + #10 + #11 + #12 + #13 + ']';

  { PUB_PAGES = "\d<1,5>-+\d<1,5>\s<0,4>\(\d<1,4>" - "matches strings that
    look like publication pages", used with find(). }
  PubPagesPattern = AsciiDigitClass + '{1,5}-+' + AsciiDigitClass + '{1,5}'
    + AsciiSpaceClass + '{0,4}\(' + AsciiDigitClass + '{1,4}';

  { SLASH_SEPARATED_DATES, used with find(). }
  SlashSeparatedDatesPattern =
    '(?:(?:[0-3]?' + AsciiDigitClass + '/[01]?' + AsciiDigitClass + ')'
    + '|(?:[01]?' + AsciiDigitClass + '/[0-3]?' + AsciiDigitClass + '))'
    + '/(?:[12]' + AsciiDigitClass + ')?' + AsciiDigitClass + '{2}';

  { TIME_STAMPS, used with find(). The trailing ":\d\d" is deliberately NOT
    part of it; that is TIME_STAMPS_SUFFIX, which is applied with lookingAt()
    to the text FOLLOWING the candidate. }
  TimeStampsPattern = '[12]' + AsciiDigitClass + '{3}[-/]?[01]'
    + AsciiDigitClass + '[-/]?[0-3]' + AsciiDigitClass + ' +[0-2]'
    + AsciiDigitClass + '$';

  { TIME_STAMPS_SUFFIX, used with lookingAt(). }
  TimeStampsSuffixPattern = ':[0-5]' + AsciiDigitClass;

{ ==================================================================
  Character classes that are scanned.
  ================================================================== }

{ openingParens of the static initialiser: '(', '[', U+FF08 FULLWIDTH LEFT
  PARENTHESIS, U+FF3B FULLWIDTH LEFT SQUARE BRACKET. }
function IsOpeningParen(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  Result := (Code = Ord('(')) or (Code = Ord('[')) or (Code = $FF08)
    or (Code = $FF3B);
end;

{ LEAD_CLASS = "[" + openingParens + PLUS_CHARS + "]", "punctuation that may
  be at the start of a phone number - brackets and plus signs". }
function IsLeadClassChar(ACh: WideChar): Boolean;
begin
  Result := IsOpeningParen(ACh) or IsPlusChar(ACh);
end;

{ The Unicode general category group Z (Zs, Zl, Zp), i.e. java.util.regex
  \p<Z>, which five of the six INNER_MATCHES need.

  Written out rather than asked of the RTL because the two RTLs disagree about
  what a "separator" is (Delphi TCharacter.IsSeparator and FreePascal's
  Character unit both fold Zs/Zl/Zp differently into their helpers) and
  because the set is small and closed. U+180E MONGOLIAN VOWEL SEPARATOR is
  deliberately NOT in it: it was reclassified from Zs to Cf in Unicode 6.3,
  and every Java version this port targets is past that. }
function IsUnicodeSeparator(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  case Code of
    $0020, $00A0, $1680, $202F, $205F, $3000,
    $2028, $2029:
      Result := True;
    $2000..$200A:
      Result := True;
  else
    Result := False;
  end;
end;

{ The characters java.util.regex '.' does NOT match without DOTALL. }
function IsLineTerminator(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  Result := (Code = $000A) or (Code = $000D) or (Code = $0085)
    or (Code = $2028) or (Code = $2029);
end;

{ Upstream isLatinLetter:

    if (!Character.isLetter(letter) && Character.getType(letter) != NON_SPACING_MARK)
      return false;
    UnicodeBlock block = UnicodeBlock.of(letter);
    return block is one of BASIC_LATIN, LATIN_1_SUPPLEMENT, LATIN_EXTENDED_A,
                           LATIN_EXTENDED_ADDITIONAL, LATIN_EXTENDED_B,
                           COMBINING_DIACRITICAL_MARKS;

  The six blocks are contiguous code point ranges and are listed as such; the
  letter / non spacing mark question goes to the RTL, which is the only
  Unicode category table this port does not carry itself.

  Note the upstream signature: a CHAR, not a code point. A supplementary
  character is therefore two calls with two lone surrogates upstream, both of
  which answer false - and both of which answer false here as well, because a
  surrogate is neither a letter nor a mark and lies outside every block
  above. }
{$IFNDEF FPC}
{ The Char overloads of System.Character are marked deprecated in favour of
  TCharHelper, but a helper cannot be reached from a unit that only wants the
  two category questions below without also pulling the helper into scope for
  every Char in this unit. The warning is switched off around exactly the two
  predicates that need them and back on afterwards - the same bracket
  LibPhoneNumber.MetadataCore uses for its code point predicates. }
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
function IsLatinLetter(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  if not (TCharacter.IsLetter(ACh)
    or (TCharacter.GetUnicodeCategory(ACh) = TUnicodeCategory.ucNonSpacingMark))
  then
  begin
    Result := False;
    Exit;
  end;

  Code := Ord(ACh);
  Result := (Code <= $007F)                          { BASIC_LATIN }
    or ((Code >= $0080) and (Code <= $00FF))         { LATIN_1_SUPPLEMENT }
    or ((Code >= $0100) and (Code <= $017F))         { LATIN_EXTENDED_A }
    or ((Code >= $0180) and (Code <= $024F))         { LATIN_EXTENDED_B }
    or ((Code >= $0300) and (Code <= $036F))         { COMBINING_DIACRITICAL_MARKS }
    or ((Code >= $1E00) and (Code <= $1EFF));        { LATIN_EXTENDED_ADDITIONAL }
end;

{ Upstream isInvalidPunctuationSymbol: the percent sign or a currency symbol
  (Unicode general category Sc). }
function IsInvalidPunctuationSymbol(ACh: WideChar): Boolean;
begin
  Result := (ACh = '%')
    or (TCharacter.GetUnicodeCategory(ACh) = TUnicodeCategory.ucCurrencySymbol);
end;
{$IFNDEF FPC}
{$WARN SYMBOL_DEPRECATED ON}
{$ENDIF}

{ ==================================================================
  PATTERN, the phone number pattern find() runs.

    PATTERN = (?: leadClass punctuation )<0,2>
              digitSequence
              (?: punctuation digitSequence )<0,20>
              (?: EXTN_PATTERNS_FOR_MATCHING )?

  with punctuation = "[VALID_PUNCTUATION]<0,4>" and
  digitSequence = "\p<Nd><1,20>".

  Greedy reduction, which is what makes a scanner equivalent to the regular
  expression:

  1. Everything AFTER the mandatory first digitSequence is optional - the
     block repetition may run zero times and the extension group is a "?" -
     so the tail can never fail. A greedy decision taken there therefore never
     has to be given back, which removes backtracking from
     MatchPatternDigitBlocks entirely. The same argument makes the digit runs
     themselves backtracking free: a shorter run only puts another digit in
     front of the continuation, and neither punctuation nor an extension label
     nor the end of input matches a digit.

  2. Inside ONE block iteration the punctuation run does need backtracking,
     because a digitSequence must follow it; MatchPatternDigitBlocks tries the
     run lengths from the greedy maximum down to zero. If none of them works,
     the repetition simply stops - by (1) it does not have to unwind.

  3. The leading "(?: leadClass punctuation )<0,2>" is the only construct with
     a mandatory continuation (the first digitSequence), so it is the only one
     that is written recursively. MatchPatternLead reproduces the java.util
     .regex order exactly: match the body once more first, with its own
     punctuation run tried from the greedy maximum downwards, and only when
     every one of those fails try the continuation at the current position.

  Note that this is a LONGEST-per-greedy-decision match, not a longest match
  overall - just like java.util.regex. "12 34#" matches as "12 34" (the block
  repetition swallows " 34" and the extension group then matches empty), not
  as "12" plus the americanStyleExtnWithSuffix " 34#".
  ================================================================== }

{ Greedy run of at most AMax punctuation code points starting at AIndex.
  Returns the index after the run. Every VALID_PUNCTUATION member is a BMP
  character, so counting code units counts code points. }
function PunctuationRunEnd(const AWide: UnicodeString;
  AIndex, ATo, AMax: Integer): Integer;
var
  N: Integer;
begin
  Result := AIndex;
  N := 0;
  while (Result <= ATo) and (N < AMax) and IsValidPunctuation(AWide[Result]) do
  begin
    Inc(Result);
    Inc(N);
  end;
end;

{ Greedy run of at most AMax DIGITS (code points) starting at AIndex. Returns
  the index after the run, i.e. AIndex when there is no digit at all. }
function DigitRunEnd(const AWide: UnicodeString;
  AIndex, ATo, AMax: Integer): Integer;
var
  N: Integer;
begin
  Result := AIndex;
  N := 0;
  while (Result <= ATo) and (N < AMax)
    and IsUnicodeDecimalDigitAt(AWide, Result) do
  begin
    Inc(Result, CodePointLengthAt(AWide, Result));
    Inc(N);
  end;
end;

{ digitSequence (?: punctuation digitSequence )<0,blockLimit>
  (?: EXTN_PATTERNS_FOR_MATCHING )?

  Returns the index after the match, or -1 when the mandatory first
  digitSequence is not there. }
function MatchPatternDigitBlocks(const AWide: UnicodeString;
  AIndex, ATo: Integer): Integer;
var
  Position, Blocks, PunctEnd, K, DigitEnd, ExtEnd: Integer;
begin
  Position := DigitRunEnd(AWide, AIndex, ATo, DigitBlockLimit);
  if Position = AIndex then
  begin
    Result := -1;
    Exit;
  end;

  Blocks := 0;
  while Blocks < BlockLimit do
  begin
    PunctEnd := PunctuationRunEnd(AWide, Position, ATo, PunctuationLimit);
    DigitEnd := -1;
    for K := PunctEnd downto Position do
    begin
      DigitEnd := DigitRunEnd(AWide, K, ATo, DigitBlockLimit);
      if DigitEnd > K then
        Break;
      DigitEnd := -1;
    end;
    if DigitEnd < 0 then
      Break;
    Position := DigitEnd;
    Inc(Blocks);
  end;

  if TryMatchExtensionForMatchingAt(AWide, Position, ATo, ExtEnd) then
    Position := ExtEnd;

  Result := Position;
end;

{ (?: leadClass punctuation )<0,AIterLeft> followed by the rest of PATTERN.
  Returns the index after the whole match, or -1. }
function MatchPatternLead(const AWide: UnicodeString;
  AIndex, ATo, AIterLeft: Integer): Integer;
var
  PunctEnd, K, R: Integer;
begin
  if (AIterLeft > 0) and (AIndex <= ATo) and IsLeadClassChar(AWide[AIndex]) then
  begin
    PunctEnd := PunctuationRunEnd(AWide, AIndex + 1, ATo, PunctuationLimit);
    for K := PunctEnd downto AIndex + 1 do
    begin
      R := MatchPatternLead(AWide, K, ATo, AIterLeft - 1);
      if R > 0 then
      begin
        Result := R;
        Exit;
      end;
    end;
  end;

  Result := MatchPatternDigitBlocks(AWide, AIndex, ATo);
end;

{ Java Matcher.find(index) for PATTERN: the leftmost match at or after AFrom.
  Start positions are walked by CODE POINT, like every other scanner of this
  port. }
function TryFindPattern(const AWide: UnicodeString; AFrom, ATo: Integer;
  out AStart, AEnd: Integer): Boolean;
var
  I, E: Integer;
begin
  AStart := 0;
  AEnd := 0;
  I := AFrom;
  if I < 1 then
    I := 1;
  while I <= ATo do
  begin
    E := MatchPatternLead(AWide, I, ATo, LeadLimit);
    if E > 0 then
    begin
      AStart := I;
      AEnd := E;
      Result := True;
      Exit;
    end;
    Inc(I, CodePointLengthAt(AWide, I));
  end;
  Result := False;
end;

{ ==================================================================
  trimAfterFirstMatch, for the two patterns it is called with.
  ================================================================== }

{ trimAfterFirstMatch(SECOND_NUMBER_START_PATTERN, candidate) with
  SECOND_NUMBER_START = "[\\/] *x": everything from the start of a second
  number on is dropped. }
function TrimAtSecondNumberStart(const ACandidate: string): string;
var
  Wide: UnicodeString;
  I, J, Len: Integer;
begin
  Wide := UnicodeString(ACandidate);
  Len := Length(Wide);
  I := 1;
  while I <= Len do
  begin
    if (Wide[I] = '\') or (Wide[I] = '/') then
    begin
      J := I + 1;
      while (J <= Len) and (Wide[J] = ' ') do
        Inc(J);
      if (J <= Len) and (Wide[J] = 'x') then
      begin
        Result := string(Copy(Wide, 1, I - 1));
        Exit;
      end;
    end;
    Inc(I);
  end;
  Result := ACandidate;
end;

{ trimAfterFirstMatch(UNWANTED_END_CHAR_PATTERN, candidate): the trailing run
  of characters that are neither a Unicode letter nor a Unicode number and not
  '#' is dropped. The class predicate is the one MetadataCore already scans
  for extractPossibleNumber. }
function TrimUnwantedEndChars(const AValue: string): string;
var
  Wide: UnicodeString;
  I, Keep: Integer;
begin
  Wide := UnicodeString(AValue);
  I := Length(Wide);
  Keep := I;
  while I >= 1 do
  begin
    if not IsUnwantedEndCharBefore(Wide, I) then
      Break;
    Dec(I, CodePointLengthBefore(Wide, I));
    Keep := I;
  end;
  Result := string(Copy(Wide, 1, Keep));
end;

{ ==================================================================
  INNER_MATCHES.

  "Patterns used to extract phone numbers from a larger phone-number-like
  pattern. These are ordered according to specificity."

  Each entry is scanned by TryFindInnerMatch, which reports what the caller
  reads off the java.util.regex Matcher: start(), end(), start(1) and the
  group(1) bounds. All indices are ONE based indices into the candidate.
  ================================================================== }

type
  TInnerMatchKind = (
    { "/+(.*)" - breaks on the slash, e.g. "651-234-2345/332-445-1234". }
    imkSlash,
    { "(\([^(]*)" - the bracket is INSIDE the capturing group, since it is
      considered part of the phone number; matches "(650) 223 3345 (754) 223
      3321". }
    imkOpeningParen,
    { "(?:\p<Z>-|-\p<Z>)\p<Z>*(.+)" - breaks on a hyphen that has a space on
      either side. }
    imkHyphen,
    { "[U+2012-U+2015 U+FF0D]\p<Z>*(.+)" - the various wide hyphens. Upstream
      decided NOT to require a space here, "since it's possible that it's
      supposed to be used to break two numbers without spaces". }
    imkWideHyphen,
    { "\.+\p<Z>*([^.]+)" - breaks on a full stop. }
    imkFullStop,
    { "\p<Z>+(\P<Z>+)" - breaks on space, e.g. "3324451234 8002341234". }
    imkSpace
  );

  TInnerMatchRec = record
    MatchStart: Integer;
    MatchEnd: Integer;
    GroupStart: Integer;
    GroupEnd: Integer;
  end;

{ The wide hyphen class of imkWideHyphen: U+2012..U+2015 and U+FF0D. }
function IsWideHyphen(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  Result := ((Code >= $2012) and (Code <= $2015)) or (Code = $FF0D);
end;

{ The "\p<Z>*(.+)" tail shared by imkHyphen and imkWideHyphen, starting at
  AIndex.

  The separator run is greedy, but "(.+)" needs at least one character, so the
  run is given back one separator at a time until something is left - which is
  exactly what java.util.regex does, and which is why the captured group can
  itself start with a separator. }
function TrySeparatorRunThenAnyChars(const AWide: UnicodeString;
  AIndex, ATo: Integer; out AGroupStart, AGroupEnd: Integer): Boolean;
var
  ZEnd, Q, K: Integer;
begin
  AGroupStart := 0;
  AGroupEnd := 0;

  ZEnd := AIndex;
  while (ZEnd <= ATo) and IsUnicodeSeparator(AWide[ZEnd]) do
    Inc(ZEnd);

  Q := ZEnd;
  while (Q > AIndex) and ((Q > ATo) or IsLineTerminator(AWide[Q])) do
    Dec(Q);
  if (Q > ATo) or IsLineTerminator(AWide[Q]) then
  begin
    Result := False;
    Exit;
  end;

  K := Q;
  while (K <= ATo) and not IsLineTerminator(AWide[K]) do
    Inc(K);

  AGroupStart := Q;
  AGroupEnd := K;
  Result := True;
end;

{ Java Matcher.find() for one INNER_MATCHES entry: the leftmost match at or
  after AFrom. }
function TryFindInnerMatch(AKind: TInnerMatchKind;
  const AWide: UnicodeString; AFrom, ATo: Integer;
  out AMatch: TInnerMatchRec): Boolean;
var
  I, J, K, ZEnd, Q: Integer;
  Ok: Boolean;
begin
  Result := False;
  AMatch.MatchStart := 0;
  AMatch.MatchEnd := 0;
  AMatch.GroupStart := 0;
  AMatch.GroupEnd := 0;

  I := AFrom;
  if I < 1 then
    I := 1;

  while I <= ATo do
  begin
    case AKind of
      imkSlash:
        if AWide[I] = '/' then
        begin
          J := I;
          while (J <= ATo) and (AWide[J] = '/') do
            Inc(J);
          K := J;
          while (K <= ATo) and not IsLineTerminator(AWide[K]) do
            Inc(K);
          AMatch.MatchStart := I;
          AMatch.GroupStart := J;
          AMatch.GroupEnd := K;
          AMatch.MatchEnd := K;
          Result := True;
          Exit;
        end;

      imkOpeningParen:
        if AWide[I] = '(' then
        begin
          J := I + 1;
          while (J <= ATo) and (AWide[J] <> '(') do
            Inc(J);
          AMatch.MatchStart := I;
          AMatch.GroupStart := I;
          AMatch.GroupEnd := J;
          AMatch.MatchEnd := J;
          Result := True;
          Exit;
        end;

      imkHyphen:
        begin
          Ok := False;
          if I + 1 <= ATo then
            Ok := (IsUnicodeSeparator(AWide[I]) and (AWide[I + 1] = '-'))
              or ((AWide[I] = '-') and IsUnicodeSeparator(AWide[I + 1]));
          if Ok and TrySeparatorRunThenAnyChars(AWide, I + 2, ATo, Q, K) then
          begin
            AMatch.MatchStart := I;
            AMatch.GroupStart := Q;
            AMatch.GroupEnd := K;
            AMatch.MatchEnd := K;
            Result := True;
            Exit;
          end;
        end;

      imkWideHyphen:
        if IsWideHyphen(AWide[I])
          and TrySeparatorRunThenAnyChars(AWide, I + 1, ATo, Q, K) then
        begin
          AMatch.MatchStart := I;
          AMatch.GroupStart := Q;
          AMatch.GroupEnd := K;
          AMatch.MatchEnd := K;
          Result := True;
          Exit;
        end;

      imkFullStop:
        if AWide[I] = '.' then
        begin
          J := I;
          while (J <= ATo) and (AWide[J] = '.') do
            Inc(J);
          ZEnd := J;
          while (ZEnd <= ATo) and IsUnicodeSeparator(AWide[ZEnd]) do
            Inc(ZEnd);
          { "([^.]+)" needs at least one character; the separator run is given
            back one at a time, exactly like the "(.+)" case above. }
          Q := ZEnd;
          while (Q > J) and ((Q > ATo) or (AWide[Q] = '.')) do
            Dec(Q);
          if (Q <= ATo) and (AWide[Q] <> '.') then
          begin
            K := Q;
            while (K <= ATo) and (AWide[K] <> '.') do
              Inc(K);
            AMatch.MatchStart := I;
            AMatch.GroupStart := Q;
            AMatch.GroupEnd := K;
            AMatch.MatchEnd := K;
            Result := True;
            Exit;
          end;
        end;

      imkSpace:
        if IsUnicodeSeparator(AWide[I]) then
        begin
          J := I;
          while (J <= ATo) and IsUnicodeSeparator(AWide[J]) do
            Inc(J);
          if J <= ATo then
          begin
            K := J;
            while (K <= ATo) and not IsUnicodeSeparator(AWide[K]) do
              Inc(K);
            AMatch.MatchStart := I;
            AMatch.GroupStart := J;
            AMatch.GroupEnd := K;
            AMatch.MatchEnd := K;
            Result := True;
            Exit;
          end;
        end;
    end;

    Inc(I);
  end;
end;

{ ==================================================================
  Small string helpers with JAVA semantics.

  They work on UnicodeString, i.e. on UTF-16 code units like java.lang.String,
  so every index they take or return is a Java index on both compilers. On
  FreePascal `string` is UTF-8 and a byte index into it is NOT a Java index;
  callers widen their `string` arguments explicitly. On Delphi the widening is
  the identity.
  ================================================================== }

{ Java String.indexOf(str, fromIndex) with ZERO based indices: -1 when there
  is no occurrence, a negative fromIndex is treated as 0. Written out instead
  of using Pos with an offset because the offset overload is not available on
  every supported compiler. }
function JavaIndexOf(const ASub, AStr: UnicodeString; AFrom: Integer): Integer;
var
  I, J, LastStart, SubLen: Integer;
  Hit: Boolean;
begin
  if AFrom < 0 then
    AFrom := 0;
  SubLen := Length(ASub);
  if SubLen = 0 then
  begin
    if AFrom > Length(AStr) then
      Result := Length(AStr)
    else
      Result := AFrom;
    Exit;
  end;

  LastStart := Length(AStr) - SubLen;
  I := AFrom;
  while I <= LastStart do
  begin
    Hit := True;
    for J := 1 to SubLen do
      if AStr[I + J] <> ASub[J] then
      begin
        Hit := False;
        Break;
      end;
    if Hit then
    begin
      Result := I;
      Exit;
    end;
    Inc(I);
  end;
  Result := -1;
end;

{ Java String.substring(beginIndex) with a ZERO based index. }
function JavaSubstring(const AStr: UnicodeString;
  AFrom: Integer): UnicodeString;
begin
  if AFrom < 0 then
    AFrom := 0;
  Result := Copy(AStr, AFrom + 1, Length(AStr) - AFrom);
end;

function JavaContains(const AStr, ASub: UnicodeString): Boolean;
begin
  Result := JavaIndexOf(ASub, AStr, 0) >= 0;
end;

function JavaStartsWith(const AStr, APrefix: UnicodeString): Boolean;
begin
  Result := (Length(APrefix) <= Length(AStr))
    and (Copy(AStr, 1, Length(APrefix)) = APrefix);
end;

function JavaEndsWith(const AStr, ASuffix: UnicodeString): Boolean;
begin
  Result := (Length(ASuffix) <= Length(AStr))
    and (Copy(AStr, Length(AStr) - Length(ASuffix) + 1, Length(ASuffix)) = ASuffix);
end;

{ Java String.split(regex) with the default limit: trailing empty strings are
  removed, a leading delimiter DOES produce an empty first element, and an
  input without any delimiter yields the input itself.

  AOnNonDigitRuns = False splits on single '-' characters (the "-" of
  getNationalNumberGroups); True splits on maximal runs of non ASCII digits
  (NON_DIGITS_PATTERN = "(\D+)"). }
function JavaSplit(const AValue: UnicodeString;
  AOnNonDigitRuns: Boolean): TMetadataStringArray;
var
  Parts: TMetadataStringArray;
  Count, I, Len, RunEnd, SegmentStart: Integer;

  procedure Add(const AItem: string);
  begin
    if Count = Length(Parts) then
      SetLength(Parts, (Count * 2) + 8);
    Parts[Count] := AItem;
    Inc(Count);
  end;

  function IsDelimiterAt(AIndex: Integer): Boolean;
  begin
    if AOnNonDigitRuns then
      Result := not ((AValue[AIndex] >= '0') and (AValue[AIndex] <= '9'))
    else
      Result := AValue[AIndex] = '-';
  end;

begin
  Count := 0;
  SetLength(Parts, 8);
  Len := Length(AValue);
  SegmentStart := 1;
  I := 1;
  while I <= Len do
  begin
    if IsDelimiterAt(I) then
    begin
      RunEnd := I + 1;
      if AOnNonDigitRuns then
        while (RunEnd <= Len) and IsDelimiterAt(RunEnd) do
          Inc(RunEnd);
      Add(string(Copy(AValue, SegmentStart, I - SegmentStart)));
      SegmentStart := RunEnd;
      I := RunEnd;
    end
    else
      Inc(I);
  end;
  Add(string(Copy(AValue, SegmentStart, Len - SegmentStart + 1)));

  { Java removes trailing empty strings when the limit is zero. }
  while (Count > 0) and (Parts[Count - 1] = '') do
    Dec(Count);

  SetLength(Parts, Count);
  Result := Parts;
end;

{ Upstream getNationalSignificantNumber(number). The parser of this port
  already stores it; the numeric fallback mirrors the facade. }
function NationalSignificantNumber(const ANumber: TPhoneNumber): string;
begin
  if ANumber.NationalNumberDigits <> '' then
    Result := ANumber.NationalNumberDigits
  else if ANumber.NationalNumber > 0 then
    Result := UIntToStr(ANumber.NationalNumber)
  else
    Result := '';
end;

{ ==================================================================
  The static helpers of PhoneNumberMatcher.
  ================================================================== }

function AllNumberGroupsRemainGrouped(const ANumber: TPhoneNumber;
  const ANormalizedCandidate: string;
  const AFormattedNumberGroups: TMetadataStringArray): Boolean;
var
  FromIndex, I: Integer;
  CountryCodeText, Region, Nsn: string;
  NormalizedWide: UnicodeString;
begin
  NormalizedWide := UnicodeString(ANormalizedCandidate);
  FromIndex := 0;
  if ANumber.CountryCodeSource <> pnccsFromDefaultCountry then
  begin
    { First skip the country code if the normalized candidate contained it. }
    CountryCodeText := IntToStr(ANumber.CountryCode);
    FromIndex := JavaIndexOf(UnicodeString(CountryCodeText), NormalizedWide, 0)
      + Length(CountryCodeText);
  end;

  { Check each group of consecutive digits is not broken into separate
    groupings in the normalized candidate. }
  for I := 0 to High(AFormattedNumberGroups) do
  begin
    FromIndex := JavaIndexOf(UnicodeString(AFormattedNumberGroups[I]),
      NormalizedWide, FromIndex);
    if FromIndex < 0 then
    begin
      Result := False;
      Exit;
    end;
    Inc(FromIndex, Length(AFormattedNumberGroups[I]));
    if (I = 0) and (FromIndex < Length(NormalizedWide)) then
    begin
      { We are at the position right after the NDC. The region used for the
        formatting information comes from the CALLING CODE, not from the
        number itself. }
      Region := GetRegionCodeForCountryCode(ANumber.CountryCode);
      if (GetNddPrefixForRegion(Region, True) <> '')
        and IsUnicodeDecimalDigit(NormalizedWide[FromIndex + 1]) then
      begin
        { No formatting symbol after the NDC: only accept the number when
          there is no formatting symbol at all, except for extensions. }
        Nsn := NationalSignificantNumber(ANumber);
        Result := JavaStartsWith(
          JavaSubstring(NormalizedWide,
            FromIndex - Length(AFormattedNumberGroups[I])),
          UnicodeString(Nsn));
        Exit;
      end;
    end;
  end;

  { Makes sure the extension was not already used to match the last group of
    the subscriber number. Note the extension cannot have formatting between
    its digits. }
  Result := JavaContains(JavaSubstring(NormalizedWide, FromIndex),
    UnicodeString(ANumber.Extension));
end;

function AllNumberGroupsAreExactlyPresent(const ANumber: TPhoneNumber;
  const ANormalizedCandidate: string;
  const AFormattedNumberGroups: TMetadataStringArray): Boolean;
var
  CandidateGroups: TMetadataStringArray;
  CandidateIndex, FormattedIndex: Integer;
begin
  CandidateGroups := JavaSplit(UnicodeString(ANormalizedCandidate), True);

  { The last group, skipped when the number has an extension. }
  if ANumber.Extension <> '' then
    CandidateIndex := Length(CandidateGroups) - 2
  else
    CandidateIndex := Length(CandidateGroups) - 1;

  { First check whether the national significant number is formatted as one
    block. "contains" and not "equals", because the block may carry a national
    prefix or the calling code in front of it. }
  if (Length(CandidateGroups) = 1)
    or JavaContains(UnicodeString(CandidateGroups[CandidateIndex]),
      UnicodeString(NationalSignificantNumber(ANumber))) then
  begin
    Result := True;
    Exit;
  end;

  { Going backwards, excluding the first group, candidate and number groups
    have to be identical. }
  FormattedIndex := High(AFormattedNumberGroups);
  while (FormattedIndex > 0) and (CandidateIndex >= 0) do
  begin
    if CandidateGroups[CandidateIndex] <> AFormattedNumberGroups[FormattedIndex]
    then
    begin
      Result := False;
      Exit;
    end;
    Dec(FormattedIndex);
    Dec(CandidateIndex);
  end;

  { The first group may carry a national prefix, so it only has to END with
    the formatted group. }
  Result := (CandidateIndex >= 0)
    and JavaEndsWith(UnicodeString(CandidateGroups[CandidateIndex]),
      UnicodeString(AFormattedNumberGroups[0]));
end;

{ Upstream getNationalNumberGroups(util, number): the RFC3966 format without
  the extension, split on the '-' that separates its digit blocks. }
function GetNationalNumberGroups(
  const ANumber: TPhoneNumber): TMetadataStringArray;
var
  Rfc3966Format, Body: UnicodeString;
  EndIndex, StartIndex: Integer;
begin
  Rfc3966Format := UnicodeString(FormatNumber(ANumber.CountryCode,
    NationalSignificantNumber(ANumber), ANumber.Extension, mpnfRfc3966));

  { Drop the extension part before splitting. }
  EndIndex := JavaIndexOf(';', Rfc3966Format, 0);
  if EndIndex < 0 then
    EndIndex := Length(Rfc3966Format);
  { The country code is followed by a '-'. }
  StartIndex := JavaIndexOf('-', Rfc3966Format, 0) + 1;

  Body := Copy(Rfc3966Format, StartIndex + 1, EndIndex - StartIndex);
  Result := JavaSplit(Body, False);
end;

{ Upstream getNationalNumberGroups(util, number, formattingPattern): the
  national significant number formatted with the given pattern, split on
  '-'. }
function GetNationalNumberGroupsForPattern(const ANumber: TPhoneNumber;
  AFormattingPattern: PNumberFormatRec): TMetadataStringArray;
begin
  Result := JavaSplit(UnicodeString(
    FormatNsnUsingPattern(NationalSignificantNumber(ANumber),
      AFormattingPattern, mpnfRfc3966, '')), False);
end;

function ContainsMoreThanOneSlashInNationalNumber(const ANumber: TPhoneNumber;
  const ACandidate: string): Boolean;
var
  FirstSlash, SecondSlash: Integer;
  CandidateHasCountryCode: Boolean;
  Wide: UnicodeString;
begin
  Wide := UnicodeString(ACandidate);
  FirstSlash := JavaIndexOf('/', Wide, 0);
  if FirstSlash < 0 then
  begin
    { No slashes, this is okay. }
    Result := False;
    Exit;
  end;

  SecondSlash := JavaIndexOf('/', Wide, FirstSlash + 1);
  if SecondSlash < 0 then
  begin
    { Only one slash, this is okay. }
    Result := False;
    Exit;
  end;

  { A first slash after the country calling code is permitted. }
  CandidateHasCountryCode :=
    (ANumber.CountryCodeSource = pnccsFromNumberWithPlusSign)
    or (ANumber.CountryCodeSource = pnccsFromNumberWithoutPlusSign);
  if CandidateHasCountryCode
    and (NormalizeDigitsOnly(string(Copy(Wide, 1, FirstSlash)))
      = IntToStr(ANumber.CountryCode)) then
  begin
    { Any more slashes and this is illegal. }
    Result := JavaContains(JavaSubstring(Wide, SecondSlash + 1), '/');
    Exit;
  end;

  Result := True;
end;

function ContainsOnlyValidXChars(const ANumber: TPhoneNumber;
  const ACandidate: string): Boolean;
var
  Index: Integer;
  CharAtIndex, CharAtNextIndex: WideChar;
  Wide: UnicodeString;
begin
  { "The characters 'x' and 'X' can be (1) a carrier code, in which case they
    always precede the national significant number or (2) an extension sign,
    in which case they always precede the extension number. We assume a
    carrier code is more than 1 digit, so the first case has to have more than
    1 consecutive 'x' or 'X', whereas the second case can only have exactly
    1 'x' or 'X'. We ignore the character if it appears as the last character
    of the string." }
  Wide := UnicodeString(ACandidate);
  Index := 0;
  while Index < Length(Wide) - 1 do
  begin
    CharAtIndex := Wide[Index + 1];
    if (CharAtIndex = 'x') or (CharAtIndex = 'X') then
    begin
      CharAtNextIndex := Wide[Index + 2];
      if (CharAtNextIndex = 'x') or (CharAtNextIndex = 'X') then
      begin
        { Carrier code case: the 'X's always precede the national significant
          number. }
        Inc(Index);
        if TPhoneNumberUtil.IsNumberMatch(ANumber,
          string(JavaSubstring(Wide, Index))) <> pnmtNsnMatch then
        begin
          Result := False;
          Exit;
        end;
      end
      else if NormalizeDigitsOnly(string(JavaSubstring(Wide, Index)))
        <> ANumber.Extension then
      begin
        { Extension sign case: the 'x' or 'X' always precedes the extension
          number. }
        Result := False;
        Exit;
      end;
    end;
    Inc(Index);
  end;
  Result := True;
end;

function IsNationalPrefixPresentIfRequired(
  const ANumber: TPhoneNumber): Boolean;
var
  PhoneNumberRegion: string;
  Metadata: PPhoneMetadataRec;
  NationalNumber, RawInputCopy, CarrierCode: string;
  FormatRule: PNumberFormatRec;
begin
  { If the calling code was written in international format, the national
    prefix is not required. }
  if ANumber.CountryCodeSource <> pnccsFromDefaultCountry then
  begin
    Result := True;
    Exit;
  end;

  PhoneNumberRegion := GetRegionCodeForCountryCode(ANumber.CountryCode);
  if not TryGetMetadataForRegion(PhoneNumberRegion, Metadata) then
  begin
    Result := True;
    Exit;
  end;

  { Is a national prefix expected when this number is formatted? }
  NationalNumber := NationalSignificantNumber(ANumber);
  FormatRule := ChooseFormattingPatternForNumber(Metadata, False,
    NationalNumber);

  { A national prefix formatting rule has to be present, and it must be more
    than the first group symbol with punctuation around it. }
  if (FormatRule <> nil) and (FormatRule^.NationalPrefixFormattingRule <> '')
  then
  begin
    if FormatRule^.NationalPrefixOptionalWhenFormatting then
    begin
      Result := True;
      Exit;
    end;
    if FormattingRuleHasFirstGroupOnly(
      FormatRule^.NationalPrefixFormattingRule) then
    begin
      Result := True;
      Exit;
    end;
    { Normalize the remainder and report whether a national prefix and/or a
      carrier code was found at the start of the raw input. }
    RawInputCopy := NormalizeDigitsOnly(ANumber.RawInput);
    Result := MaybeStripNationalPrefixAndCarrierCode(RawInputCopy, Metadata,
      CarrierCode);
    Exit;
  end;

  Result := True;
end;

{ ==================================================================
  MATCHING_BRACKETS input folding.
  ================================================================== }

{ The candidate as MatchingBracketsPattern sees it: every code unit replaced
  by the ASCII representative of its MATCHING_BRACKETS class.

    openingParens  '(' '[' U+FF08 U+FF3B  ->  '(' / '['
    closingParens  ')' ']' U+FF09 U+FF3D  ->  ')' / ']'
    any other non ASCII code unit         ->  'a'
    any other ASCII character             ->  itself

  The upstream pattern only ever tests membership in openingParens, in
  closingParens or in neither (nonParens), and every class membership is
  preserved by the fold, so the full match answers exactly what the upstream
  pattern answers on the original candidate. A supplementary character
  becomes two 'a' instead of one code point; nonParens only occurs as "+" and
  "*", for which one and two characters are the same.

  Why the fold exists (found by the FreePascal runtime gate): the upstream
  pattern names the four full width brackets. On FreePascal `string` is UTF-8
  and the regexpr unit matches BYTES, so a class holding U+FF08 holds the
  three bytes EF BC 88 instead - which also excludes every full width digit
  (EF BC 90..99) from nonParens. And a pattern built in a unit
  initialization section is converted to `string` BEFORE the program can set
  the UTF-8 conversion code page, which turned the four brackets into '(' '['
  ')' ']' or '?' and broke the class syntax: the FreePascal matcher found no
  number at all. With the fold the pattern is pure ASCII, a constant, and the
  same expression on every engine. }
function FoldBracketClasses(const ACandidate: string): string;
var
  Wide: UnicodeString;
  I: Integer;
begin
  Wide := UnicodeString(ACandidate);
  for I := 1 to Length(Wide) do
    case Ord(Wide[I]) of
      $FF08:
        Wide[I] := '(';
      $FF3B:
        Wide[I] := '[';
      $FF09:
        Wide[I] := ')';
      $FF3D:
        Wide[I] := ']';
      $0080..$FF07, $FF0A..$FF3A, $FF3C, $FF3E..$FFFF:
        Wide[I] := 'a';
    end;
  Result := string(Wide);
end;

{ ==================================================================
  TPhoneNumberMatch.
  ================================================================== }

function TPhoneNumberMatch.EndIndex: Integer;
begin
  { PhoneNumberMatch.end() is a UTF-16 offset; RawString is UTF-8 on
    FreePascal, so its length is taken in UTF-16 code units. }
  Result := Start + Length(UnicodeString(RawString));
end;

{ ==================================================================
  TPhoneNumberMatcher.
  ================================================================== }

constructor TPhoneNumberMatcher.Create(const AText, ACountry: string;
  ALeniency: TPhoneNumberLeniency; AMaxTries: Int64);
begin
  inherited Create;
  if AMaxTries < 0 then
    raise EPhoneNumberMatcher.Create(
      'PhoneNumberMatcher: maxTries must not be negative.');

  FText := UnicodeString(AText);
  FTextLength := Length(FText);
  FPreferredRegion := ACountry;
  FLeniency := ALeniency;
  FMaxTries := AMaxTries;
  FState := msNotReady;
  FSearchIndex := 1;
end;

function TPhoneNumberMatcher.Find(AIndex: Integer;
  out AMatch: TPhoneNumberMatch): Boolean;
var
  Start, MatchEnd: Integer;
  Candidate: string;
begin
  while (FMaxTries > 0)
    and TryFindPattern(FText, AIndex, FTextLength, Start, MatchEnd) do
  begin
    Candidate := string(Copy(FText, Start, MatchEnd - Start));

    { Check for extra numbers at the end. }
    Candidate := TrimAtSecondNumberStart(Candidate);

    if ExtractMatch(Candidate, Start, AMatch) then
    begin
      Result := True;
      Exit;
    end;

    { FText offsets are UTF-16 code units, so is the candidate length. }
    if Length(Candidate) > 0 then
      AIndex := Start + Length(UnicodeString(Candidate))
    else
      { Unreachable: a PATTERN candidate starts with a lead class character or
        a digit, and SECOND_NUMBER_START begins with a backslash or a slash,
        so the trim can never consume the whole candidate. The guard is here
        so a future change cannot turn the loop into a non terminating one. }
      AIndex := Start + 1;
    Dec(FMaxTries);
  end;

  Result := False;
end;

function TPhoneNumberMatcher.ExtractMatch(const ACandidate: string;
  AOffset: Integer; out AMatch: TPhoneNumberMatch): Boolean;
var
  MatchValue, FollowingText: string;
  MatchStart: Integer;
begin
  { Skip a match that is more likely to be a date. }
  if TryFindFirst(SlashSeparatedDatesPattern, ACandidate, MatchValue,
    MatchStart) then
  begin
    Result := False;
    Exit;
  end;

  { Skip potential time stamps. }
  if TryFindFirst(TimeStampsPattern, ACandidate, MatchValue, MatchStart) then
  begin
    FollowingText := string(Copy(FText,
      AOffset + Length(UnicodeString(ACandidate)), FTextLength));
    if TryMatchPrefix(TimeStampsSuffixPattern, FollowingText) then
    begin
      Result := False;
      Exit;
    end;
  end;

  { Try to come up with a valid match given the entire candidate. }
  if ParseAndVerify(ACandidate, AOffset, AMatch) then
  begin
    Result := True;
    Exit;
  end;

  { If that failed, there might still be a phone number INSIDE the
    candidate. }
  Result := ExtractInnerMatch(ACandidate, AOffset, AMatch);
end;

function TPhoneNumberMatcher.ExtractInnerMatch(const ACandidate: string;
  AOffset: Integer; out AMatch: TPhoneNumberMatch): Boolean;
var
  Kind: TInnerMatchKind;
  Wide: UnicodeString;
  Len, From: Integer;
  Inner: TInnerMatchRec;
  IsFirstMatch: Boolean;
  Group: string;
begin
  Wide := UnicodeString(ACandidate);
  Len := Length(Wide);

  for Kind := Low(TInnerMatchKind) to High(TInnerMatchKind) do
  begin
    From := 1;
    IsFirstMatch := True;
    while TryFindInnerMatch(Kind, Wide, From, Len, Inner) and (FMaxTries > 0) do
    begin
      if IsFirstMatch then
      begin
        { Any group in front of this one has to be handled as well. }
        Group := TrimUnwantedEndChars(
          string(Copy(Wide, 1, Inner.MatchStart - 1)));
        if ParseAndVerify(Group, AOffset, AMatch) then
        begin
          Result := True;
          Exit;
        end;
        Dec(FMaxTries);
        IsFirstMatch := False;
      end;

      Group := TrimUnwantedEndChars(string(Copy(Wide, Inner.GroupStart,
        Inner.GroupEnd - Inner.GroupStart)));
      if ParseAndVerify(Group, AOffset + Inner.GroupStart - 1, AMatch) then
      begin
        Result := True;
        Exit;
      end;
      Dec(FMaxTries);

      From := Inner.MatchEnd;
    end;
  end;

  Result := False;
end;

function TPhoneNumberMatcher.ParseAndVerify(const ACandidate: string;
  AOffset: Integer; out AMatch: TPhoneNumberMatch): Boolean;
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  MatchValue: string;
  MatchStart, LastCharIndex: Integer;
  PreviousChar, NextChar: WideChar;
  CandidateWide: UnicodeString;
begin
  Result := False;

  { Check the candidate does not contain any formatting which would indicate
    that it really is not a phone number. }
  if not TryMatchFull(MatchingBracketsPattern, FoldBracketClasses(ACandidate))
  then
    Exit;
  if TryFindFirst(PubPagesPattern, ACandidate, MatchValue, MatchStart) then
    Exit;

  { From leniency VALID on, numbers surrounded by Latin letters are skipped,
    so cases like abc8005001234 or 8005001234def do not match. }
  if FLeniency >= pnlValid then
  begin
    CandidateWide := UnicodeString(ACandidate);
    { If the candidate is not at the start of the text and does not start with
      phone number punctuation, look at the previous character. }
    if (AOffset > 1)
      and not ((Length(CandidateWide) > 0)
        and IsLeadClassChar(CandidateWide[1])) then
    begin
      PreviousChar := FText[AOffset - 1];
      if IsInvalidPunctuationSymbol(PreviousChar)
        or IsLatinLetter(PreviousChar) then
        Exit;
    end;
    LastCharIndex := AOffset + Length(CandidateWide);
    if LastCharIndex <= FTextLength then
    begin
      NextChar := FText[LastCharIndex];
      if IsInvalidPunctuationSymbol(NextChar) or IsLatinLetter(NextChar) then
        Exit;
    end;
  end;

  if not TPhoneNumberUtil.ParseAndKeepRawInput(ACandidate, FPreferredRegion,
    Number, Error) then
    { Java catches the NumberParseException here and continues. }
    Exit;

  if Verify(Number, ACandidate) then
  begin
    { The number was created with parseAndKeepRawInput, but the extra values
      are not returned; upstream clears exactly these three. }
    Number.CountryCodeSource := pnccsUnspecified;
    Number.RawInput := '';
    Number.PreferredDomesticCarrierCode := '';

    AMatch.Start := AOffset - 1;
    AMatch.RawString := ACandidate;
    AMatch.Number := Number;
    Result := True;
  end;
end;

function TPhoneNumberMatcher.CheckNumberGroupingIsValid(
  const ANumber: TPhoneNumber; const ACandidate: string;
  AExact: Boolean): Boolean;
var
  NormalizedCandidate: string;
  FormattedNumberGroups: TMetadataStringArray;
  NationalSignificant: string;
  AlternateCount, I: Integer;
  AlternateFormat: PNumberFormatRec;

  function CheckGroups(const AGroups: TMetadataStringArray): Boolean;
  begin
    if AExact then
      Result := AllNumberGroupsAreExactlyPresent(ANumber, NormalizedCandidate,
        AGroups)
    else
      Result := AllNumberGroupsRemainGrouped(ANumber, NormalizedCandidate,
        AGroups);
  end;

begin
  NormalizedCandidate := NormalizeDigits(ACandidate, True { keep non-digits });
  FormattedNumberGroups := GetNationalNumberGroups(ANumber);
  if CheckGroups(FormattedNumberGroups) then
  begin
    Result := True;
    Exit;
  end;

  { "If this didn't pass, see if there are any alternate formats that match,
    and try them instead." Upstream asks the alternate formats metadata source
    for the PhoneMetadata of the CALLING CODE and iterates its number formats;
    a missing entry is a null there and a zero count here. }
  NationalSignificant := NationalSignificantNumber(ANumber);
  AlternateCount := GetAlternateFormatCount(ANumber.CountryCode);
  for I := 0 to AlternateCount - 1 do
  begin
    AlternateFormat := GetAlternateFormat(ANumber.CountryCode, I);
    if AlternateFormat = nil then
      Continue;

    if AlternateFormat^.LeadingDigitsCount > 0 then
      { "There is only one leading digits pattern for alternate formats." }
      if not TryMatchPrefix(
        GetAlternateLeadingDigitsPattern(AlternateFormat, 0),
        NationalSignificant) then
        { Leading digits don't match; try another one. }
        Continue;

    FormattedNumberGroups := GetNationalNumberGroupsForPattern(ANumber,
      AlternateFormat);
    if CheckGroups(FormattedNumberGroups) then
    begin
      Result := True;
      Exit;
    end;
  end;

  Result := False;
end;

function TPhoneNumberMatcher.Verify(const ANumber: TPhoneNumber;
  const ACandidate: string): Boolean;
var
  Nsn: string;
begin
  Nsn := NationalSignificantNumber(ANumber);

  { Every leniency has its branch; no else branch, which FreePascal would
    report as unreachable code. }
  Result := False;
  case FLeniency of
    pnlPossible:
      Result := IsPossibleNumber(ANumber.CountryCode, Nsn);

    pnlValid:
      Result := IsValidNumber(ANumber.CountryCode, Nsn)
        and ContainsOnlyValidXChars(ANumber, ACandidate)
        and IsNationalPrefixPresentIfRequired(ANumber);

    pnlStrictGrouping, pnlExactGrouping:
      begin
        if not IsValidNumber(ANumber.CountryCode, Nsn)
          or not ContainsOnlyValidXChars(ANumber, ACandidate)
          or ContainsMoreThanOneSlashInNationalNumber(ANumber, ACandidate)
          or not IsNationalPrefixPresentIfRequired(ANumber) then
        begin
          Result := False;
          Exit;
        end;
        Result := CheckNumberGroupingIsValid(ANumber, ACandidate,
          FLeniency = pnlExactGrouping);
      end;
  end;
end;

function TPhoneNumberMatcher.HasNext: Boolean;
begin
  if FState = msNotReady then
  begin
    if Find(FSearchIndex, FLastMatch) then
    begin
      { FSearchIndex is one based, PhoneNumberMatch.end() is not. }
      FSearchIndex := FLastMatch.EndIndex + 1;
      FState := msReady;
    end
    else
      FState := msDone;
  end;
  Result := FState = msReady;
end;

function TPhoneNumberMatcher.Next: TPhoneNumberMatch;
begin
  if not HasNext then
    raise EPhoneNumberMatcher.Create('PhoneNumberMatcher: no further match.');

  Result := FLastMatch;
  { Upstream sets lastMatch = null here, "don't retain that memory any longer
    than necessary". }
  FLastMatch := Default(TPhoneNumberMatch);
  FState := msNotReady;
end;

function TPhoneNumberMatcher.TryNext(out AMatch: TPhoneNumberMatch): Boolean;
begin
  Result := HasNext;
  if Result then
    AMatch := Next;
end;

{ ==================================================================
  PhoneNumberUtil.findNumbers.
  ================================================================== }

function FindNumbers(const AText, ADefaultRegion: string;
  ALeniency: TPhoneNumberLeniency;
  AMaxTries: Int64): TPhoneNumberMatchArray;
var
  Matcher: TPhoneNumberMatcher;
  Matches: TPhoneNumberMatchArray;
  Count: Integer;
  Match: TPhoneNumberMatch;
begin
  Count := 0;
  SetLength(Matches, 4);
  Matcher := TPhoneNumberMatcher.Create(AText, ADefaultRegion, ALeniency,
    AMaxTries);
  try
    while Matcher.TryNext(Match) do
    begin
      if Count = Length(Matches) then
        SetLength(Matches, Count * 2);
      Matches[Count] := Match;
      Inc(Count);
    end;
  finally
    Matcher.Free;
  end;
  SetLength(Matches, Count);
  Result := Matches;
end;

function FindNumbers(const AText,
  ADefaultRegion: string): TPhoneNumberMatchArray;
begin
  Result := FindNumbers(AText, ADefaultRegion, pnlValid, UnlimitedTries);
end;

end.
