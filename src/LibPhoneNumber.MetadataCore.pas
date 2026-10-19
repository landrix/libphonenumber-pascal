unit LibPhoneNumber.MetadataCore;

{
  Metadata driven validation and typing core.

  This unit is a literal port of the range interpretation part of upstream
  com/google/i18n/phonenumbers/PhoneNumberUtil.java (Java is the source of
  truth; the C# port was used as a translation aid only). Ported methods:

    descHasPossibleNumberData          -> DescHasPossibleNumberData
    getNumberDescByType                -> GetNumberDescByType
    isNumberMatchingDesc               -> IsNumberMatchingDesc
    testNumberLength (both overloads)  -> TestNumberLength / TestNumberLengthForType
    isPossibleNumberForTypeWithReason  -> IsPossibleNumberForTypeWithReason
    isPossibleNumberWithReason         -> IsPossibleNumberWithReason
    isPossibleNumberForType            -> IsPossibleNumberForType
    isPossibleNumber                   -> IsPossibleNumber
    getNumberTypeHelper                -> GetNumberTypeHelper
    getNumberType                      -> GetNumberType
    isValidNumberForRegion             -> IsValidNumberForRegion
    isValidNumber                      -> IsValidNumber
    getRegionCodeForNumber             -> GetRegionCodeForNumber
    getRegionCodeForNumberFromRegionList
                                       -> GetRegionCodeForNumberFromRegionList
    getRegionCodeForCountryCode        -> GetRegionCodeForCountryCode
    getMetadataForRegionOrCallingCode  -> TryGetMetadataForRegionOrCallingCode

  Also ported (the parsing helpers of PhoneNumberUtil
  that need metadata; the surrounding parse driver stays in
  LibPhoneNumber.PhoneNumberUtil):

    extractCountryCode                 -> ExtractCountryCode
    parsePrefixAsIdd                   -> ParsePrefixAsIdd
    maybeStripNationalPrefixAndCarrierCode
                                       -> MaybeStripNationalPrefixAndCarrierCode

  Also ported (the small PhoneNumberUtil helpers the
  extended formatter APIs need; the formatters themselves live in
  LibPhoneNumber.MetadataFormat and LibPhoneNumber.PhoneNumberUtil):

    isNANPACountry                     -> IsNanpaCountry
    getNddPrefixForRegion              -> GetNddPrefixForRegion
    normalizeDigitsOnly                -> NormalizeDigitsOnly
    normalizeDiallableCharsOnly        -> NormalizeDiallableCharsOnly

  Also ported (the remaining normalizeHelper tables;
  the alpha table is a parse path helper as well, which is why all three live
  here and not in LibPhoneNumber.MetadataFormat):

    ALPHA_MAPPINGS                     -> MapAlphaCharacterToDigit
    convertAlphaCharactersInNumber     -> ConvertAlphaCharactersInNumber
    VALID_ALPHA_PHONE_PATTERN          -> IsValidAlphaPhone
    normalize(StringBuilder)           -> NormalizeAlphaPhoneOrDigits
    ALL_PLUS_NUMBER_GROUPING_SYMBOLS   -> NormalizeAllPlusNumberGroupingSymbols

  Also ported (the ENTRY path of parseHelper, i.e. everything that runs on
  the raw input before the calling code is extracted, plus the Unicode digit
  handling):

    normalizeDigits(number, keepNonDigits)
                                       -> NormalizeDigits
    DIGITS (the Unicode decimal digit class) and Character.digit(c, 10)
                                       -> IsUnicodeDecimalDigit /
                                          UnicodeDecimalDigitValue
    VALID_PUNCTUATION                  -> IsValidPunctuation (MOVED here from
                                          LibPhoneNumber.MetadataFormat,
                                          which had the only caller until now)
    PLUS_CHARS                         -> IsPlusChar
    extractPossibleNumber              -> ExtractPossibleNumber
    VALID_PHONE_NUMBER / isViablePhoneNumber
                                       -> IsViablePhoneNumber
    EXTN_PATTERNS_FOR_PARSING / maybeStripExtension
                                       -> MaybeStripExtension
    extractPhoneContext                -> TryExtractPhoneContext
    isPhoneContextValid                -> IsPhoneContextValid
    buildNationalNumberForParsing      -> TryBuildNationalNumberForParsing

  Also ported (the second half of createExtnPattern,
  needed by LibPhoneNumber.PhoneNumberMatcher; the matcher itself lives
  in that unit):

    EXTN_PATTERNS_FOR_MATCHING, i.e. createExtnPattern(false)
                                       -> TryMatchExtensionForMatchingAt

  It is the SAME scanner: TryMatchExtensionAt gained the two Booleans of the
  upstream builder call site - AForParsing (six alternatives versus four) and
  AAnchorEnd (the end anchor of EXTN_PATTERN versus the unanchored use inside
  PhoneNumberMatcher.PATTERN) - instead of getting a second copy. That block
  also exports the code point primitives the matcher scanners need
  (CodePoint, CodePointLengthAt/Before, IsUnicodeDecimalDigitAt,
  IsUnwantedEndCharBefore); see the "Shared scanner surface" section of the
  interface.

  The three pattern ports of that block - VALID_PHONE_NUMBER,
  EXTN_PATTERNS_FOR_PARSING and the two RFC3966 phone-context patterns - are
  SCANNERS, not compiled regular expressions. Three reasons, all of them the
  same ones that make VALID_PUNCTUATION a predicate:

  1. They are built from non ASCII code points (full width labels, the
     Cyrillic label U+0434 U+043E U+0431, the combining acute accent, the
     full width tilde and hash). Spelling those into a pattern literal would
     make the source encoding load bearing on two compilers.
  2. They need the Unicode decimal digit class DIGITS and a case
     insensitive match with UNICODE_CASE. .NET regex, PCRE (Delphi) and
     TRegExpr (FreePascal) disagree about both, and this port keeps engine
     dialect differences out of the metadata layer by construction.
  3. The grammars are small and closed. EXTN_PATTERNS_FOR_PARSING is six
     concatenations over four tiny character classes and a finite label list;
     VALID_PHONE_NUMBER is two alternatives. Both are scanned exactly, with
     the reduction argument written down at the implementation.

  Ported in the accessory API step (the library surface behind the last
  unported PhoneNumberUtilTest methods; the length methods live in
  LibPhoneNumber.MetadataFormat, the example number family on the
  facade):

    descHasData                        -> DescHasData
    getSupportedTypesForMetadata       -> GetSupportedTypesForMetadata
    getSupportedTypesForRegion         -> GetSupportedTypesForRegion
    getSupportedTypesForNonGeoEntity   -> GetSupportedTypesForNonGeoEntity
    isNumberGeographical (both)        -> IsNumberGeographical
    GEO_MOBILE_COUNTRIES_WITHOUT_MOBILE_AREA_CODES /
    COUNTRIES_WITHOUT_NATIONAL_PREFIX_WITH_AREA_CODES
                                       -> IsGeoMobileCountryWithoutMobileAreaCodes /
                                          IsCountryWithoutNationalPrefixWithAreaCodes
    getCountryMobileToken              -> GetCountryMobileToken
    isAlphaNumber                      -> IsAlphaNumber
    truncateTooLongNumber              -> TruncateTooLongNumber (on the digits)

  Deliberate deviations from the Java source, all of them shape only:

  1. There is no PhoneNumber object. Every entry point takes the pair
     (ACountryCode, ANationalNumber) that upstream would derive through
     getNationalSignificantNumber(number); the existing parser in
     LibPhoneNumber.PhoneNumberUtil already produces exactly that pair. In particular the
     italianLeadingZero / numberOfLeadingZeros handling of
     getNationalSignificantNumber lives in the parser, not here.
  2. Java returns null for "no region"; this port returns an empty string.
     getRegionCodeForCountryCode keeps returning the upstream sentinel 'ZZ'.
  3. Java throws on missing metadata; the Try* accessors of
     LibPhoneNumber.Metadata report it as a Boolean instead. The pinned
     baseline never hits that path.
  4. Java caches PhoneNumberDesc objects; here descriptions are pointers into
     the generated read only tables.

  Runtime position: this unit IS the runtime path. The public API in
  LibPhoneNumber.PhoneNumberUtil validates, types and parses through it,
  LibPhoneNumber.MetadataFormat formats on top of it. The length compare
  gate compares the GENERATED metadata against the upstream XML
  (tools/compare_generated_metadata_with_upstream.ps1).
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
  { Interface level only: every declaration below is spelled in the types of
    the data model. The lookup layer LibPhoneNumber.Metadata is an
    IMPLEMENTATION dependency and is used down there. }
  LibPhoneNumber.Metadata.Types;

type
  { Upstream PhoneNumberUtil.PhoneNumberType, in upstream declaration order. }
  TMetadataNumberType = (
    mntFixedLine,
    mntMobile,
    mntFixedLineOrMobile,
    mntTollFree,
    mntPremiumRate,
    mntSharedCost,
    mntVoip,
    mntPersonalNumber,
    mntPager,
    mntUan,
    mntVoicemail,
    mntUnknown
  );

  { Upstream PhoneNumberUtil.ValidationResult, in upstream declaration order. }
  TMetadataValidationResult = (
    mvrIsPossible,
    mvrIsPossibleLocalOnly,
    mvrInvalidCountryCode,
    mvrTooShort,
    mvrInvalidLength,
    mvrTooLong
  );

const
  { Upstream PhoneNumberUtil.UNKNOWN_REGION. }
  UnknownRegionCode = 'ZZ';

  { Upstream PhoneNumberUtil.MAX_LENGTH_COUNTRY_CODE. }
  MaxLengthCountryCode = 3;

  { Upstream PhoneNumberUtil.NANPA_COUNTRY_CODE. }
  NanpaCountryCode = 1;

  { Upstream PhoneNumberUtil.MIN_LENGTH_FOR_NSN / MAX_LENGTH_FOR_NSN. }
  MinLengthForNsn = 2;
  MaxLengthForNsn = 17;

{ Metadata helpers }
function GetNumberDescByType(AMetadata: PPhoneMetadataRec;
  AType: TMetadataNumberType): PPhoneNumberDescRec;
function DescHasPossibleNumberData(ADesc: PPhoneNumberDescRec): Boolean;
{ Upstream descHasData: "true if there is any data set for a particular
  PhoneNumberDesc" - an example number, possible number data
  (DescHasPossibleNumberData) or a national number pattern. Added together
  with its only upstream caller, getSupportedTypesForMetadata (accessory API
  step, see GetSupportedTypesForRegion). A nil description has no data. }
function DescHasData(ADesc: PPhoneNumberDescRec): Boolean;
function IsNumberMatchingDesc(const ANationalNumber: string;
  ADesc: PPhoneNumberDescRec): Boolean;

{ Region resolution }
function GetRegionCodeForCountryCode(ACountryCode: Integer): string;
function TryGetMetadataForRegionOrCallingCode(ACountryCode: Integer;
  const ARegionCode: string; out AMetadata: PPhoneMetadataRec): Boolean;
function GetRegionCodeForNumber(ACountryCode: Integer;
  const ANationalNumber: string): string;

{ Upstream isNANPACountry: True when ARegionCode is one of the territories of
  country calling code 1. Java keeps a precomputed nanpaRegions set; here the
  region list of the calling code is walked, which is nine entries at most per
  call and needs no run time initialisation. }
function IsNanpaCountry(const ARegionCode: string): Boolean;

{ Upstream getNddPrefixForRegion(regionCode, stripNonDigits): the national
  dialling prefix of a region.

  Java returns null both for an unknown region and for a region without a
  national prefix; this port returns an empty string for both, which is what
  every caller of the upstream method tests for anyway
  ("nationalPrefix == null || nationalPrefix.length() == 0"). }
function GetNddPrefixForRegion(const ARegionCode: string;
  AStripNonDigits: Boolean): string;

{ Upstream DIGITS, i.e. the regular expression class for the Unicode general
  category Nd, and the value
  Java reads off such a character with Character.digit(c, 10).

  UnicodeDecimalDigitValue returns 0..9 for every BMP decimal digit and -1 for
  anything else. The table behind it holds the code point of the DIGIT ZERO of
  each Nd run; every Unicode Nd block is a contiguous run of ten code points in
  ascending value order, which is what makes the table this small and the
  lookup exact. It is enumerated from the same Unicode data the C# oracle uses
  (System.Char.IsDigit / GetNumericValue over the whole BMP), so oracle and
  port agree by construction; see tools/README.md.

  Only the BMP is covered. That is not a shortcut: Java walks its input with
  charAt() and calls the CHAR overload of Character.digit, which cannot see a
  supplementary code point either, so a surrogate pair is not a digit upstream
  and is not one here. }
function UnicodeDecimalDigitValue(ACh: WideChar): Integer;
function IsUnicodeDecimalDigit(ACh: WideChar): Boolean;

{ Upstream normalizeDigits(number, keepNonDigits): every decimal digit is
  replaced by its ASCII form, everything else is either kept (keepNonDigits) or
  dropped. }
function NormalizeDigits(const AValue: string; AKeepNonDigits: Boolean): string;

{ Upstream normalizeDigitsOnly, i.e. normalizeDigits(number, false): keeps the
  digits and drops everything else.

  This is Unicode complete like upstream - a full width or
  Arabic-Indic digit is mapped onto its ASCII value instead of being dropped. }
function NormalizeDigitsOnly(const AValue: string): string;

{ Upstream normalizeDiallableCharsOnly: keeps the characters that can actually
  be dialled - ASCII digits, '+', '*' and '#' - and drops everything else.

  ASCII digits ONLY, deliberately and exactly like upstream: this method is
  normalizeHelper(number, DIALLABLE_CHAR_MAPPINGS, true), and that table has an
  entry for the ten ASCII digits and for '+', '*' and '#'. A full width digit
  is not in it and is therefore REMOVED, not normalised - the opposite of what
  normalizeDigitsOnly does. }
function NormalizeDiallableCharsOnly(const AValue: string): string;

{ Upstream VALID_PUNCTUATION, i.e. the class SEPARATOR_PATTERN is built from.

  It lives here rather than in LibPhoneNumber.MetadataFormat because the
  parse path needs it too: VALID_PHONE_NUMBER is built from VALID_PUNCTUATION,
  and MetadataCore cannot use MetadataFormat (the dependency runs the other
  way).

  The parameter is WideChar, not Char: on Delphi the two are the same type, but
  on FreePascal in Delphi mode Char is a single byte and every one of the
  eighteen non ASCII members of the class would be unreachable. All callers
  scan a UnicodeString for the same reason. }
function IsValidPunctuation(ACh: WideChar): Boolean;

{ Upstream PLUS_CHARS, i.e. the ASCII plus sign and its full width variant
  U+FF0B. PLUS_CHARS_PATTERN is "[PLUS_CHARS]+", so a leading RUN of these is
  what the parse path strips; the predicate is the per character half of it. }
function IsPlusChar(ACh: WideChar): Boolean;

{ Upstream ALPHA_MAPPINGS applied to a single character: the vanity number dial
  pad table (A/B/C -> 2 ... W/X/Y/Z -> 9). The lookup upper cases first, like
  normalizeHelper does. Returns #0 for anything that is not an ASCII letter. }
function MapAlphaCharacterToDigit(ACh: WideChar): Char;

{ Upstream convertAlphaCharactersInNumber:
  normalizeHelper(number, ALPHA_PHONE_MAPPINGS, false) - every ASCII letter
  becomes its dial pad digit, ASCII digits stay, and because removeNonMatches
  is false every other character is KEPT unchanged. }
function ConvertAlphaCharactersInNumber(const AValue: string): string;

{ Upstream VALID_ALPHA_PHONE_PATTERN applied with matches(): the value
  contains at least three ASCII letters. Ported as a counter because that is
  all the pattern says - it is a non greedy "any run then a letter" repeated
  three times, followed by anything. The pattern itself is not quoted here
  because its bounded repetition uses braces, which end a Pascal comment. }
function IsValidAlphaPhone(const AValue: string): Boolean;

{ Upstream normalize(StringBuilder): a number that looks like a vanity number
  (three or more ASCII letters) is normalised through ALPHA_PHONE_MAPPINGS with
  removeNonMatches, every other number through normalizeDigitsOnly. This is the
  normalisation the parse path applies before it extracts the calling code. }
function NormalizeAlphaPhoneOrDigits(const AValue: string): string;

{ Upstream normalizeHelper(number, ALL_PLUS_NUMBER_GROUPING_SYMBOLS, true):
  keeps letters (upper cased), ASCII digits and the grouping symbols '-', '/',
  ' ' and '.', mapping the typographic and full width variants onto their ASCII
  form, and drops everything else. Only
  formatOutOfCountryKeepingAlphaChars uses it. }
function NormalizeAllPlusNumberGroupingSymbols(const AValue: string): string;

{ Length based checks (upstream testNumberLength) }
function TestNumberLength(const ANationalNumber: string;
  AMetadata: PPhoneMetadataRec): TMetadataValidationResult;
function TestNumberLengthForType(const ANationalNumber: string;
  AMetadata: PPhoneMetadataRec;
  AType: TMetadataNumberType): TMetadataValidationResult;

{ Possible number API }
function IsPossibleNumberWithReason(ACountryCode: Integer;
  const ANationalNumber: string): TMetadataValidationResult;
function IsPossibleNumberForTypeWithReason(ACountryCode: Integer;
  const ANationalNumber: string;
  AType: TMetadataNumberType): TMetadataValidationResult;
function IsPossibleNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
function IsPossibleNumberForType(ACountryCode: Integer;
  const ANationalNumber: string; AType: TMetadataNumberType): Boolean;

{ Typing and validity }
function GetNumberTypeHelper(const ANationalNumber: string;
  AMetadata: PPhoneMetadataRec): TMetadataNumberType;
function GetNumberType(ACountryCode: Integer;
  const ANationalNumber: string): TMetadataNumberType;
function IsValidNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
function IsValidNumberForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionCode: string): Boolean;

{ ------------------------------------------------------------------
  Accessory API (the library surface behind the last PhoneNumberUtilTest
  methods that were not ported; see "Accessory API" in docs/ARCHITECTURE.md).

  Everything here is metadata driven and parse free, which is why it lives in
  this FPC gated unit. The two methods that need the INTERNATIONAL format
  (getLengthOfGeographicalAreaCode, getLengthOfNationalDestinationCode) are in
  LibPhoneNumber.MetadataFormat, the ones that need the parse driver
  (the getExampleNumber* family and getInvalidExampleNumber) on the facade in
  LibPhoneNumber.PhoneNumberUtil. Region arguments are taken EXACTLY here, like every
  other region argument of this unit; the facade wrappers canonicalise them.
  ------------------------------------------------------------------ }

type
  { Upstream Set<PhoneNumberType>. A Pascal set is ordered by the enum, which
    is the TreeSet order upstream returns as well. }
  TMetadataNumberTypes = set of TMetadataNumberType;

{ Upstream getSupportedTypesForMetadata (private upstream; exported because
  the two public entry points below are one line each over it): every type
  whose description has data, never FIXED_LINE_OR_MOBILE ("a convenience type")
  and never UNKNOWN ("the non-type"). A nil AMetadata yields the empty set. }
function GetSupportedTypesForMetadata(
  AMetadata: PPhoneMetadataRec): TMetadataNumberTypes;

{ Upstream getSupportedTypesForRegion. An unsupported region - including the
  non geographical "001" and the unknown "ZZ" - yields the empty set; Java logs
  a warning there, this port does not log. }
function GetSupportedTypesForRegion(
  const ARegionCode: string): TMetadataNumberTypes;

{ Upstream getSupportedTypesForNonGeoEntity. A calling code that is not a non
  geographical entity yields the empty set. }
function GetSupportedTypesForNonGeoEntity(
  ACountryCode: Integer): TMetadataNumberTypes;

{ Upstream isNumberGeographical(phoneNumberType, countryCallingCode): FIXED_LINE
  and FIXED_LINE_OR_MOBILE always, MOBILE only for the GEO_MOBILE_COUNTRIES
  (52 MX, 54 AR, 55 BR, 62 ID and 86 CN). }
function IsNumberGeographical(AType: TMetadataNumberType;
  ACountryCode: Integer): Boolean; overload;

{ Upstream isNumberGeographical(phoneNumber): the overload above applied to
  getNumberType(number). }
function IsNumberGeographical(ACountryCode: Integer;
  const ANationalNumber: string): Boolean; overload;

{ Upstream GEO_MOBILE_COUNTRIES_WITHOUT_MOBILE_AREA_CODES (86 CN) and
  COUNTRIES_WITHOUT_NATIONAL_PREFIX_WITH_AREA_CODES (52 MX), the two private
  sets getLengthOfGeographicalAreaCode consults. Exported so that the method
  in LibPhoneNumber.MetadataFormat reads the SAME set as this unit's
  GEO_MOBILE_COUNTRIES, of which the first one is a part. }
function IsGeoMobileCountryWithoutMobileAreaCodes(
  ACountryCode: Integer): Boolean;
function IsCountryWithoutNationalPrefixWithAreaCodes(
  ACountryCode: Integer): Boolean;

{ Upstream getCountryMobileToken: the mobile token of a calling code
  (MOBILE_TOKEN_MAPPINGS, which holds exactly 54 -> "9" at the pinned
  baseline), or the empty string. }
function GetCountryMobileToken(ACountryCode: Integer): string;

{ Upstream isAlphaNumber: True when the number is a viable phone number that,
  after a trailing extension is removed, carries at least three ASCII
  letters. Java counts the letters with hasAtLeastThreeAlphaChars, which is
  the same predicate IsValidAlphaPhone ports (the C# port even calls it
  IsValidAlphaPhone); the length guard is MAX_INPUT_STRING_LENGTH in UTF-16
  code units, like Java's CharSequence.length(). }
function IsAlphaNumber(const AValue: string): Boolean;

{ Upstream truncateTooLongNumber on the national significant number.

  Java divides the NUMERIC national number by ten until the number is valid
  and keeps the italianLeadingZero / numberOfLeadingZeros pair untouched. The
  digit string of this port carries that pair as its leading zeros, so the
  same loop is: split off the leading zeros the way
  setItalianLeadingZerosForPhoneNumber counts them (all of them except the
  last digit of an all zero number), drop the last digit of the REST, and
  stop with False as soon as the rest is empty - Java's "nationalNumber == 0"
  - or the candidate is TOO_SHORT. ANationalNumber is only written on
  success, which is the upstream "will not be modified" contract. A number
  that is valid already returns True unchanged. }
function TruncateTooLongNumber(ACountryCode: Integer;
  var ANationalNumber: string): Boolean;

{ Parsing helpers (upstream PhoneNumberUtil parse path) }

{ ------------------------------------------------------------------
  Entry path of parseHelper.

  Upstream order, which TPhoneNumberUtil.ParseHelper reproduces exactly:

    buildNationalNumberForParsing(numberToParse, nationalNumber)
    isViablePhoneNumber(nationalNumber)          -> NOT_A_NUMBER
    checkRegionForParsing(...)                   -> INVALID_COUNTRY_CODE
    maybeStripExtension(nationalNumber)          -> the extension
    ... only then the calling code is extracted
  ------------------------------------------------------------------ }

{ Upstream extractPossibleNumber: drops everything in front of the first
  character that can START a phone number (VALID_START_CHAR = a plus character
  or a decimal digit), then the trailing run of characters that are neither a
  letter nor a number and not '#' (UNWANTED_END_CHAR_PATTERN), then everything
  from the start of a SECOND number on (SECOND_NUMBER_START_PATTERN, i.e. a
  backslash or a slash followed by spaces and a lower case 'x').

  Returns the empty string when the input holds no start character at all. }
function ExtractPossibleNumber(const AValue: string): string;

{ Upstream isViablePhoneNumber, i.e. VALID_PHONE_NUMBER_PATTERN applied with
  matches() after a length check against MIN_LENGTH_FOR_NSN.

  VALID_PHONE_NUMBER_PATTERN is VALID_PHONE_NUMBER followed by an OPTIONAL
  extension. Note the alternation precedence of the upstream expression: the
  optional extension binds to the SECOND alternative of VALID_PHONE_NUMBER
  only, so the "exactly MIN_LENGTH_FOR_NSN digits" short number form cannot
  carry an extension. }
function IsViablePhoneNumber(const AValue: string): Boolean;

{ Upstream maybeStripExtension: strips a trailing extension from ANUMBER and
  returns it, or returns the empty string and leaves ANumber alone.

  ANumber is the NON normalised number, exactly like upstream, and the returned
  extension is the raw captured group - a full width digit in the extension
  survives as a full width digit, which is what upstream does and what the
  reference oracle confirms. }
function MaybeStripExtension(var ANumber: string): string;

{ Upstream extractPhoneContext(numberToExtractFrom, indexOfPhoneContext).

  Java returns null when there is no ";phone-context=" at all and the (possibly
  empty) value otherwise; this port splits that into the Boolean result and the
  out parameter, so False means "no phone-context parameter". }
function TryExtractPhoneContext(const ANumberToExtractFrom: string;
  out APhoneContext: string): Boolean;

{ Upstream isPhoneContextValid for a phone-context that IS present: the value
  must be either RFC3966 global-number-digits or an RFC3966 domainname. The
  upstream "null is valid" case is the False result of TryExtractPhoneContext
  and is handled by the caller. }
function IsPhoneContextValid(const APhoneContext: string): Boolean;

{ Upstream buildNationalNumberForParsing. Returns False for the one case in
  which Java throws NOT_A_NUMBER out of this method, "The phone-context value
  is invalid." }
function TryBuildNationalNumberForParsing(const ANumberToParse: string;
  out ANationalNumber: string): Boolean;


{ Upstream extractCountryCode: the leading 1..3 digits of AFullNumber that form
  a known country calling code. AFullNumber must already have the plus sign or
  the IDD removed. Returns 0 and leaves ANationalNumber empty when no calling
  code can be extracted.

  Upstream tries the SHORTEST prefix first; because E.164 calling codes are
  prefix free that is the same as the longest valid one, and the loop is kept
  in upstream order so the port stays literal. }
function ExtractCountryCode(const AFullNumber: string;
  out ANationalNumber: string): Integer;

{ Upstream parsePrefixAsIdd: removes AIddPattern from the front of ANumber, but
  only when the first digit that follows is not '0' (calling codes never start
  with zero). ANumber must be normalised to digits already. }
function ParsePrefixAsIdd(const AIddPattern: string; var ANumber: string): Boolean;

{ Upstream maybeStripNationalPrefixAndCarrierCode. ANumber is modified in place
  when (and only when) a national prefix or carrier code was removed; the
  transform rule of the territory is applied like Matcher.replaceFirst does.

  The upstream viability rule is what makes this correct for territories
  without a national prefix: nothing is stripped when the territory has no
  nationalPrefixForParsing at all, and a strip that would turn a number which
  matched the general description into one that no longer does is rolled
  back. }
function MaybeStripNationalPrefixAndCarrierCode(var ANumber: string;
  AMetadata: PPhoneMetadataRec; out ACarrierCode: string): Boolean;

{ Upstream RegexBasedMatcher.matchNationalNumber(number, desc, false): a plain
  full match against the description pattern. Unlike IsNumberMatchingDesc this
  skips the possible length pre-check, because the upstream parse path calls
  the matcher API directly. }
function MatchesNationalNumberPattern(const ANumber: string;
  ADesc: PPhoneNumberDescRec): Boolean;

{ ------------------------------------------------------------------
  Shared scanner surface.

  LibPhoneNumber.PhoneNumberMatcher is the second consumer of the code
  point primitives and of the extension grammar of this unit. Everything it
  needs is exported here rather than copied, so there is exactly ONE
  createExtnPattern in the port, exactly like upstream has exactly one.

  All of them take a UnicodeString and a ONE BASED index into it, because the
  matcher has to report java.util.regex offsets and must therefore stay on
  UTF-16 code units; note that `string` is AnsiString on FreePascal, so a
  `string` parameter could not carry an index at all.
  ------------------------------------------------------------------ }

{ One code point as a string. Every non ASCII literal of the port is built
  through this helper instead of being written into the source, so the files
  stay pure ASCII and their encoding never becomes load bearing. }
function CodePoint(ACode: Integer): UnicodeString;

{ Number of UTF-16 code units of the code point that STARTS at AIndex,
  respectively of the one that ENDS at AIndex: 2 for a well formed surrogate
  pair, 1 otherwise (a lone surrogate counts as one code point, which is what
  java.util.regex does with it as well). }
function CodePointLengthAt(const AWide: UnicodeString; AIndex: Integer): Integer;
function CodePointLengthBefore(const AWide: UnicodeString;
  AIndex: Integer): Integer;

{ Upstream DIGITS for the code point at AIndex. }
function IsUnicodeDecimalDigitAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;

{ Upstream UNWANTED_END_CHARS, i.e. one code point of the class "neither a
  Unicode letter nor a Unicode number, and not the hash sign". AIndex is the
  index of the LAST code unit of the code point. }
function IsUnwantedEndCharBefore(const AWide: UnicodeString;
  AIndex: Integer): Boolean;

{ Upstream EXTN_PATTERNS_FOR_MATCHING, i.e. createExtnPattern(FALSE): the same
  grammar MaybeStripExtension runs on, minus the two alternatives that only
  exist for auto dialling (autoDiallingExtn and onlyCommasExtn), and applied
  as an UNANCHORED prefix match instead of an end anchored one.

  That is exactly how PhoneNumberMatcher.PATTERN uses it: the extension is the
  last, optional element of the pattern and nothing follows it, so the match
  simply has to start at AStart and may end anywhere up to ATo.

  Returns the index of the first character AFTER the match in AMatchEnd. }
function TryMatchExtensionForMatchingAt(const AWide: UnicodeString;
  AStart, ATo: Integer; out AMatchEnd: Integer): Boolean;

{ Diagnostics }
function NumberTypeToString(AType: TMetadataNumberType): string;
function ValidationResultToString(AResult: TMetadataValidationResult): string;
{ Maps a stored description kind to the number type it represents; returns
  False for the kinds that are not a PhoneNumberType (generalDesc,
  noInternationalDialling). }
function TryDescKindToNumberType(AKind: TPhoneNumberDescKind;
  out AType: TMetadataNumberType): Boolean;

implementation

uses
{$IFDEF FPC}
  Character,
{$ELSE}
  System.Character,
{$ENDIF}
  LibPhoneNumber.Metadata,
  LibPhoneNumber.Regex;

{ ------------------------------------------------------------------
  Character classes of the parse path.

  Why the RTL is used for exactly ONE of them: UNWANTED_END_CHARS is defined
  by the OPEN Unicode general categories L (letter) and N (number) - it matches
  a trailing run of characters that are in NEITHER of them and are not the hash
  sign. Every other class this unit ports is a
  closed, enumerable set and is spelled out as a case statement; that one is
  not, so TCharacter.IsLetter / TCharacter.IsNumber answer it. Both exist on
  Delphi (System.Character) and on FreePascal (Character) and both are defined
  as exactly those general categories.
  ------------------------------------------------------------------ }

function GetNumberDescByType(AMetadata: PPhoneMetadataRec;
  AType: TMetadataNumberType): PPhoneNumberDescRec;
var
  Kind: TPhoneNumberDescKind;
begin
  { Literal port of PhoneNumberUtil.getNumberDescByType, including the shared
    FIXED_LINE / FIXED_LINE_OR_MOBILE branch and the generalDesc default. }
  case AType of
    mntPremiumRate: Kind := pdkPremiumRate;
    mntTollFree: Kind := pdkTollFree;
    mntMobile: Kind := pdkMobile;
    mntFixedLine, mntFixedLineOrMobile: Kind := pdkFixedLine;
    mntSharedCost: Kind := pdkSharedCost;
    mntVoip: Kind := pdkVoip;
    mntPersonalNumber: Kind := pdkPersonalNumber;
    mntPager: Kind := pdkPager;
    mntUan: Kind := pdkUan;
    mntVoicemail: Kind := pdkVoicemail;
  else
    Kind := pdkGeneralDesc;
  end;
  Result := GetDesc(AMetadata, Kind);
end;

function TryDescKindToNumberType(AKind: TPhoneNumberDescKind;
  out AType: TMetadataNumberType): Boolean;
begin
  Result := True;
  case AKind of
    pdkFixedLine: AType := mntFixedLine;
    pdkMobile: AType := mntMobile;
    pdkTollFree: AType := mntTollFree;
    pdkPremiumRate: AType := mntPremiumRate;
    pdkSharedCost: AType := mntSharedCost;
    pdkPersonalNumber: AType := mntPersonalNumber;
    pdkVoip: AType := mntVoip;
    pdkPager: AType := mntPager;
    pdkUan: AType := mntUan;
    pdkVoicemail: AType := mntVoicemail;
  else
    AType := mntUnknown;
    Result := False;
  end;
end;

function DescHasPossibleNumberData(ADesc: PPhoneNumberDescRec): Boolean;
var
  Lengths: TMetadataIntegerArray;
begin
  { Upstream: possibleLengthCount != 1 || possibleLength(0) != -1.
    An empty list means "inherits from the general desc"; the single value -1
    means "no numbers of this type exist". }
  if ADesc = nil then
  begin
    Result := False;
    Exit;
  end;
  Lengths := GetPossibleLengths(ADesc);
  Result := (Length(Lengths) <> 1) or (Lengths[0] <> NoPossibleLength);
end;

function DescHasData(ADesc: PPhoneNumberDescRec): Boolean;
begin
  { Upstream: "Checking most properties since we don't know what's present,
    since a custom build may have stripped just one of them (e.g. liteBuild
    strips exampleNumber). We don't bother checking the
    possibleLengthsLocalOnly, since if this is the only thing that's present we
    don't really support the type at all."

    hasExampleNumber / hasNationalNumberPattern are "the string is not empty"
    here: the generator writes an absent element as the empty string, and an
    element that is present is never empty in the upstream XML. }
  if ADesc = nil then
  begin
    Result := False;
    Exit;
  end;
  Result := (ADesc^.ExampleNumber <> '')
    or DescHasPossibleNumberData(ADesc)
    or (ADesc^.NationalNumberPattern <> '');
end;

function ContainsLength(const ALengths: TMetadataIntegerArray;
  AValue: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to Length(ALengths) - 1 do
    if ALengths[I] = AValue then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

function IsNumberMatchingDesc(const ANationalNumber: string;
  ADesc: PPhoneNumberDescRec): Boolean;
var
  PossibleLengths: TMetadataIntegerArray;
begin
  if ADesc = nil then
  begin
    Result := False;
    Exit;
  end;

  { Upstream isNumberMatchingDesc: the description's OWN possible length list
    is consulted (not the effective one). An empty list means the lengths are
    identical to the general description, which the caller has already
    checked. }
  PossibleLengths := GetPossibleLengths(ADesc);
  if (Length(PossibleLengths) > 0)
    and not ContainsLength(PossibleLengths, Length(ANationalNumber)) then
  begin
    Result := False;
    Exit;
  end;

  { RegexBasedMatcher.matchNationalNumber(number, desc, allowPrefixMatch=false)
    is a full match, and refuses an empty pattern. }
  Result := TryMatchFull(ADesc^.NationalNumberPattern, ANationalNumber);
end;

function GetRegionCodeForCountryCode(ACountryCode: Integer): string;
var
  Regions: TMetadataStringArray;
begin
  Regions := GetRegionCodesForCountryCode(ACountryCode);
  if Length(Regions) = 0 then
    Result := UnknownRegionCode
  else
    Result := Regions[0];
end;

function IsNanpaCountry(const ARegionCode: string): Boolean;
var
  Regions: TMetadataStringArray;
  I: Integer;
begin
  Result := False;
  if ARegionCode = '' then
    Exit;
  Regions := GetRegionCodesForCountryCode(NanpaCountryCode);
  for I := 0 to Length(Regions) - 1 do
    if Regions[I] = ARegionCode then
    begin
      Result := True;
      Exit;
    end;
end;

function GetNddPrefixForRegion(const ARegionCode: string;
  AStripNonDigits: Boolean): string;
var
  Metadata: PPhoneMetadataRec;
  I: Integer;
  Stripped: string;
begin
  Result := '';
  if not TryGetMetadataForRegion(ARegionCode, Metadata) then
    Exit;
  Result := Metadata^.NationalPrefix;
  if Result = '' then
    Exit;
  if not AStripNonDigits then
    Exit;
  { Upstream comment: "if any other non-numeric symbols are ever used in
    national prefixes, these would have to be removed here as well". Java does
    a literal String.replace("~", ""). }
  Stripped := '';
  for I := 1 to Length(Result) do
    if Result[I] <> '~' then
      Stripped := Stripped + Result[I];
  Result := Stripped;
end;

{ Code point of the DIGIT ZERO of every Unicode Nd run inside the BMP, in
  ascending order. Enumerated from the Unicode data of the reference oracle's
  runtime, and verified there: each entry starts a contiguous run of ten code
  points whose numeric values are 0..9, and the 37 runs together are ALL 370
  BMP characters the oracle reports as decimal digits. }
const
  UnicodeDigitZeroCount = 37;
  UnicodeDigitZeros: array[0..UnicodeDigitZeroCount - 1] of Integer = (
    $0030,  { ASCII }
    $0660,  { Arabic-Indic }
    $06F0,  { extended Arabic-Indic }
    $07C0,  { NKo }
    $0966,  { Devanagari }
    $09E6,  { Bengali }
    $0A66,  { Gurmukhi }
    $0AE6,  { Gujarati }
    $0B66,  { Oriya }
    $0BE6,  { Tamil }
    $0C66,  { Telugu }
    $0CE6,  { Kannada }
    $0D66,  { Malayalam }
    $0DE6,  { Sinhala Lith }
    $0E50,  { Thai }
    $0ED0,  { Lao }
    $0F20,  { Tibetan }
    $1040,  { Myanmar }
    $1090,  { Myanmar Shan }
    $17E0,  { Khmer }
    $1810,  { Mongolian }
    $1946,  { Limbu }
    $19D0,  { New Tai Lue }
    $1A80,  { Tai Tham Hora }
    $1A90,  { Tai Tham Tham }
    $1B50,  { Balinese }
    $1BB0,  { Sundanese }
    $1C40,  { Lepcha }
    $1C50,  { Ol Chiki }
    $A620,  { Vai }
    $A8D0,  { Saurashtra }
    $A900,  { Kayah Li }
    $A9D0,  { Javanese }
    $A9F0,  { Myanmar Tai Laing }
    $AA50,  { Cham }
    $ABF0,  { Meetei Mayek }
    $FF10   { full width }
  );

function UnicodeDecimalDigitValue(ACh: WideChar): Integer;
var
  Code, I: Integer;
begin
  Code := Ord(ACh);
  { The ASCII run is first in the table anyway; testing it separately keeps the
    hot path of every normalisation at one comparison. }
  if (Code >= Ord('0')) and (Code <= Ord('9')) then
  begin
    Result := Code - Ord('0');
    Exit;
  end;
  for I := 1 to UnicodeDigitZeroCount - 1 do
    if (Code >= UnicodeDigitZeros[I]) and (Code < UnicodeDigitZeros[I] + 10) then
    begin
      Result := Code - UnicodeDigitZeros[I];
      Exit;
    end;
  Result := -1;
end;

function IsUnicodeDecimalDigit(ACh: WideChar): Boolean;
begin
  Result := UnicodeDecimalDigitValue(ACh) >= 0;
end;

function IsPlusChar(ACh: WideChar): Boolean;
begin
  Result := (Ord(ACh) = Ord('+')) or (Ord(ACh) = $FF0B);
end;

function IsValidPunctuation(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  { The ordinal is widened to Integer FIRST. Case labels are checked against
    the type of the selector, and Ord(WideChar) is a Word typed expression on
    both compilers; the Integer local keeps the case statement free of any
    range assumption about the selector type. }
  Code := Ord(ACh);
  case Code of
    $0020,          { space }
    $0028, $0029,   { ( ) }
    $002D,          { - ; note VALID_PUNCTUATION starts with the dash }
    $002E,          { . }
    $002F,          { / }
    $005B, $005D,   { [ ] }
    $0078,          { x - a carrier information placeholder upstream treats as
                      punctuation }
    $007E,          { ~ }
    $00A0,          { no break space }
    $00AD,          { soft hyphen }
    $200B,          { zero width space }
    $2010..$2015,   { hyphen .. horizontal bar }
    $2053,          { swung dash }
    $2060,          { word joiner }
    $2212,          { minus sign }
    $223C,          { tilde operator }
    $3000,          { ideographic space }
    $30FC,          { katakana-hiragana prolonged sound mark }
    $FF08, $FF09,   { full width ( ) }
    $FF0D..$FF0F,   { full width hyphen-minus, full stop, solidus }
    $FF3B, $FF3D,   { full width [ ] }
    $FF5E:          { full width tilde }
      Result := True;
  else
    Result := False;
  end;
end;

function NormalizeDigits(const AValue: string; AKeepNonDigits: Boolean): string;
var
  Wide, Built: UnicodeString;
  I, Digit: Integer;
begin
  { Scanned as UTF-16 for the reason spelled out at IsValidPunctuation: on
    FreePascal a Char is a single byte and no non ASCII digit would ever be
    seen. }
  Wide := UnicodeString(AValue);
  Built := '';
  for I := 1 to Length(Wide) do
  begin
    Digit := UnicodeDecimalDigitValue(Wide[I]);
    if Digit >= 0 then
      Built := Built + WideChar(Ord('0') + Digit)
    else if AKeepNonDigits then
      Built := Built + Wide[I];
  end;
  Result := string(Built);
end;

function NormalizeDigitsOnly(const AValue: string): string;
begin
  Result := NormalizeDigits(AValue, False);
end;

function NormalizeDiallableCharsOnly(const AValue: string): string;
var
  I: Integer;
  Ch: Char;
begin
  Result := '';
  for I := 1 to Length(AValue) do
  begin
    Ch := AValue[I];
    if ((Ch >= '0') and (Ch <= '9')) or (Ch = '+') or (Ch = '*') or (Ch = '#') then
      Result := Result + Ch;
  end;
end;

{ Upstream ALPHA_MAPPINGS, indexed by 'A'..'Z'. }
const
  AlphaMappingDigits = '22233344455566677778889999';

function MapAlphaCharacterToDigit(ACh: WideChar): Char;
var
  Code: Integer;
begin
  { normalizeHelper looks the UPPER CASED character up, which is why only the
    upper case half of ALPHA_MAPPINGS needs an entry here. }
  Code := Ord(ACh);
  if (Code >= Ord('a')) and (Code <= Ord('z')) then
    Code := Code - (Ord('a') - Ord('A'));
  if (Code >= Ord('A')) and (Code <= Ord('Z')) then
    Result := AlphaMappingDigits[Code - Ord('A') + 1]
  else
    Result := #0;
end;

function ConvertAlphaCharactersInNumber(const AValue: string): string;
var
  Wide, Built: UnicodeString;
  I: Integer;
  Digit: Char;
begin
  { ALPHA_PHONE_MAPPINGS is ALPHA_MAPPINGS plus the identity mapping of the
    ASCII digits; with removeNonMatches = False every other character survives
    unchanged, so the digit identity mapping is not observable and the letter
    table alone reproduces the method. }
  Wide := UnicodeString(AValue);
  Built := '';
  for I := 1 to Length(Wide) do
  begin
    Digit := MapAlphaCharacterToDigit(Wide[I]);
    if Digit <> #0 then
      Built := Built + WideChar(Ord(Digit))
    else
      Built := Built + Wide[I];
  end;
  Result := string(Built);
end;

function IsValidAlphaPhone(const AValue: string): Boolean;
var
  I, Letters: Integer;
  Ch: Char;
begin
  Letters := 0;
  for I := 1 to Length(AValue) do
  begin
    Ch := AValue[I];
    if ((Ch >= 'A') and (Ch <= 'Z')) or ((Ch >= 'a') and (Ch <= 'z')) then
    begin
      Inc(Letters);
      if Letters >= 3 then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
  Result := False;
end;

function NormalizeAlphaPhoneOrDigits(const AValue: string): string;
var
  Wide, Built: UnicodeString;
  I: Integer;
  Digit: Char;
begin
  if not IsValidAlphaPhone(AValue) then
  begin
    Result := NormalizeDigitsOnly(AValue);
    Exit;
  end;

  { normalizeHelper(number, ALPHA_PHONE_MAPPINGS, true): letters become their
    dial pad digit, ASCII digits survive, everything else is dropped. }
  Wide := UnicodeString(AValue);
  Built := '';
  for I := 1 to Length(Wide) do
  begin
    Digit := MapAlphaCharacterToDigit(Wide[I]);
    if Digit <> #0 then
      Built := Built + WideChar(Ord(Digit))
    else if (Wide[I] >= '0') and (Wide[I] <= '9') then
      Built := Built + Wide[I];
  end;
  Result := string(Built);
end;

function NormalizeAllPlusNumberGroupingSymbols(const AValue: string): string;
var
  Wide, Built: UnicodeString;
  I, Code: Integer;
begin
  { Literal port of the ALL_PLUS_NUMBER_GROUPING_SYMBOLS table. normalizeHelper
    looks the UPPER CASED character up and drops everything the table does not
    know.

    Scanned as UTF-16 for the same reason IsValidPunctuation is a WideChar
    predicate: the typographic and full width variants are non ASCII code
    points and would be unreachable on FreePascal if this walked a single byte
    Char. }
  Wide := UnicodeString(AValue);
  Built := '';
  for I := 1 to Length(Wide) do
  begin
    Code := Ord(Wide[I]);
    if (Code >= Ord('a')) and (Code <= Ord('z')) then
      Code := Code - (Ord('a') - Ord('A'));
    case Code of
      Ord('A')..Ord('Z'), Ord('0')..Ord('9'):
        Built := Built + WideChar(Code);
      Ord('-'), $2010, $2011, $2012, $2013, $2014, $2015, $2212, $FF0D:
        Built := Built + '-';
      Ord('/'), $FF0F:
        Built := Built + '/';
      Ord(' '), $2060, $3000:
        Built := Built + ' ';
      Ord('.'), $FF0E:
        Built := Built + '.';
    else
      { Not in the table: the character is removed. }
    end;
  end;
  Result := string(Built);
end;

function TryGetMetadataForRegionOrCallingCode(ACountryCode: Integer;
  const ARegionCode: string; out AMetadata: PPhoneMetadataRec): Boolean;
begin
  if ARegionCode = NonGeoRegionCode then
    Result := TryGetMetadataForNonGeoEntity(ACountryCode, AMetadata)
  else
    Result := TryGetMetadataForRegion(ARegionCode, AMetadata);
end;

function GetRegionCodeForNumberFromRegionList(const ANationalNumber: string;
  const ARegionCodes: TMetadataStringArray): string;
var
  I: Integer;
  Metadata: PPhoneMetadataRec;
begin
  for I := 0 to Length(ARegionCodes) - 1 do
  begin
    { The region codes come from the country calling code map, so metadata is
      always present. The non geographical entities never share a calling code
      with a geographical region, so a region lookup is enough here. }
    if not TryGetMetadataForRegion(ARegionCodes[I], Metadata) then
      Continue;

    if Metadata^.LeadingDigits <> '' then
    begin
      { Upstream uses Matcher.lookingAt() for leadingDigits. }
      if TryMatchPrefix(Metadata^.LeadingDigits, ANationalNumber) then
      begin
        Result := ARegionCodes[I];
        Exit;
      end;
    end
    else if GetNumberTypeHelper(ANationalNumber, Metadata) <> mntUnknown then
    begin
      Result := ARegionCodes[I];
      Exit;
    end;
  end;
  Result := '';
end;

function GetRegionCodeForNumber(ACountryCode: Integer;
  const ANationalNumber: string): string;
var
  Regions: TMetadataStringArray;
begin
  Regions := GetRegionCodesForCountryCode(ACountryCode);
  if Length(Regions) = 0 then
  begin
    { Upstream logs and returns null. }
    Result := '';
    Exit;
  end;
  if Length(Regions) = 1 then
  begin
    Result := Regions[0];
    Exit;
  end;
  Result := GetRegionCodeForNumberFromRegionList(ANationalNumber, Regions);
end;

{ Java merges the mobile lengths into a copy of the current list and re-sorts
  it, keeping duplicates. Reproduced verbatim; the lists hold a handful of
  entries, so an insertion sort is the right tool. }
function ConcatAndSort(const ALeft, ARight: TMetadataIntegerArray): TMetadataIntegerArray;
var
  I, J, Value: Integer;
begin
  Result := nil;
  SetLength(Result, Length(ALeft) + Length(ARight));
  for I := 0 to Length(ALeft) - 1 do
    Result[I] := ALeft[I];
  for I := 0 to Length(ARight) - 1 do
    Result[Length(ALeft) + I] := ARight[I];

  for I := 1 to Length(Result) - 1 do
  begin
    Value := Result[I];
    J := I - 1;
    while (J >= 0) and (Result[J] > Value) do
    begin
      Result[J + 1] := Result[J];
      Dec(J);
    end;
    Result[J + 1] := Value;
  end;
end;

function TestNumberLengthForType(const ANationalNumber: string;
  AMetadata: PPhoneMetadataRec;
  AType: TMetadataNumberType): TMetadataValidationResult;
var
  DescForType, MobileDesc: PPhoneNumberDescRec;
  PossibleLengths, LocalLengths, MobileLengths: TMetadataIntegerArray;
  ActualLength, MinimumLength, I: Integer;
begin
  if AMetadata = nil then
  begin
    Result := mvrInvalidLength;
    Exit;
  end;

  DescForType := GetNumberDescByType(AMetadata, AType);

  { Size optimisation of the upstream metadata: a sub description with the same
    possible lengths as its parent stores none at all. }
  PossibleLengths := GetPossibleLengths(DescForType);
  if Length(PossibleLengths) = 0 then
    PossibleLengths := GetPossibleLengths(GetDesc(AMetadata, pdkGeneralDesc));

  LocalLengths := GetPossibleLengthsLocalOnly(DescForType);

  if AType = mntFixedLineOrMobile then
  begin
    if not DescHasPossibleNumberData(GetNumberDescByType(AMetadata, mntFixedLine)) then
    begin
      { Rare case: no fixedLine data at all (some non geographical entities),
        so only mobile is checked. }
      Result := TestNumberLengthForType(ANationalNumber, AMetadata, mntMobile);
      Exit;
    end;

    MobileDesc := GetNumberDescByType(AMetadata, mntMobile);
    if DescHasPossibleNumberData(MobileDesc) then
    begin
      if MobileDesc^.LengthCount = 0 then
        MobileLengths := GetPossibleLengths(GetDesc(AMetadata, pdkGeneralDesc))
      else
        MobileLengths := GetPossibleLengths(MobileDesc);
      PossibleLengths := ConcatAndSort(PossibleLengths, MobileLengths);

      if Length(LocalLengths) = 0 then
        LocalLengths := GetPossibleLengthsLocalOnly(MobileDesc)
      else
        LocalLengths := ConcatAndSort(LocalLengths,
          GetPossibleLengthsLocalOnly(MobileDesc));
    end;
  end;

  { A type that does not exist at all is encoded as the single length -1. }
  if (Length(PossibleLengths) = 0)
    or (PossibleLengths[0] = NoPossibleLength) then
  begin
    Result := mvrInvalidLength;
    Exit;
  end;

  ActualLength := Length(ANationalNumber);
  { Safe because possible lengths and local only lengths never overlap; that is
    checked at metadata build time. }
  if ContainsLength(LocalLengths, ActualLength) then
  begin
    Result := mvrIsPossibleLocalOnly;
    Exit;
  end;

  MinimumLength := PossibleLengths[0];
  if MinimumLength = ActualLength then
  begin
    Result := mvrIsPossible;
    Exit;
  end;
  if MinimumLength > ActualLength then
  begin
    Result := mvrTooShort;
    Exit;
  end;
  if PossibleLengths[Length(PossibleLengths) - 1] < ActualLength then
  begin
    Result := mvrTooLong;
    Exit;
  end;

  { The first element has already been compared. }
  for I := 1 to Length(PossibleLengths) - 1 do
    if PossibleLengths[I] = ActualLength then
    begin
      Result := mvrIsPossible;
      Exit;
    end;
  Result := mvrInvalidLength;
end;

function TestNumberLength(const ANationalNumber: string;
  AMetadata: PPhoneMetadataRec): TMetadataValidationResult;
begin
  Result := TestNumberLengthForType(ANationalNumber, AMetadata, mntUnknown);
end;

function IsPossibleNumberForTypeWithReason(ACountryCode: Integer;
  const ANationalNumber: string;
  AType: TMetadataNumberType): TMetadataValidationResult;
var
  RegionCode: string;
  Metadata: PPhoneMetadataRec;
begin
  { Upstream note: for regions that share a country calling code the rules of
    the main region are used, because getRegionCodeForNumber cannot resolve a
    number that is possible but not valid. }
  if not IsSupportedCallingCode(ACountryCode) then
  begin
    Result := mvrInvalidCountryCode;
    Exit;
  end;
  RegionCode := GetRegionCodeForCountryCode(ACountryCode);
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, RegionCode, Metadata) then
  begin
    { Cannot happen for the pinned baseline: the calling code is supported. }
    Result := mvrInvalidCountryCode;
    Exit;
  end;
  Result := TestNumberLengthForType(ANationalNumber, Metadata, AType);
end;

function IsPossibleNumberWithReason(ACountryCode: Integer;
  const ANationalNumber: string): TMetadataValidationResult;
begin
  Result := IsPossibleNumberForTypeWithReason(ACountryCode, ANationalNumber,
    mntUnknown);
end;

function IsPossibleNumberForType(ACountryCode: Integer;
  const ANationalNumber: string; AType: TMetadataNumberType): Boolean;
var
  Reason: TMetadataValidationResult;
begin
  Reason := IsPossibleNumberForTypeWithReason(ACountryCode, ANationalNumber, AType);
  Result := (Reason = mvrIsPossible) or (Reason = mvrIsPossibleLocalOnly);
end;

function IsPossibleNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
begin
  Result := IsPossibleNumberForType(ACountryCode, ANationalNumber, mntUnknown);
end;

function GetNumberTypeHelper(const ANationalNumber: string;
  AMetadata: PPhoneMetadataRec): TMetadataNumberType;
var
  IsFixedLine: Boolean;
begin
  if AMetadata = nil then
  begin
    Result := mntUnknown;
    Exit;
  end;

  if not IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkGeneralDesc)) then
  begin
    Result := mntUnknown;
    Exit;
  end;

  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkPremiumRate)) then
  begin
    Result := mntPremiumRate;
    Exit;
  end;
  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkTollFree)) then
  begin
    Result := mntTollFree;
    Exit;
  end;
  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkSharedCost)) then
  begin
    Result := mntSharedCost;
    Exit;
  end;
  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkVoip)) then
  begin
    Result := mntVoip;
    Exit;
  end;
  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkPersonalNumber)) then
  begin
    Result := mntPersonalNumber;
    Exit;
  end;
  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkPager)) then
  begin
    Result := mntPager;
    Exit;
  end;
  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkUan)) then
  begin
    Result := mntUan;
    Exit;
  end;
  if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkVoicemail)) then
  begin
    Result := mntVoicemail;
    Exit;
  end;

  IsFixedLine := IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkFixedLine));
  if IsFixedLine then
  begin
    if AMetadata^.SameMobileAndFixedLinePattern then
      Result := mntFixedLineOrMobile
    else if IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkMobile)) then
      Result := mntFixedLineOrMobile
    else
      Result := mntFixedLine;
    Exit;
  end;

  { Only worth testing mobile separately when the patterns are known to differ. }
  if (not AMetadata^.SameMobileAndFixedLinePattern)
    and IsNumberMatchingDesc(ANationalNumber, GetDesc(AMetadata, pdkMobile)) then
  begin
    Result := mntMobile;
    Exit;
  end;

  Result := mntUnknown;
end;

function GetNumberType(ACountryCode: Integer;
  const ANationalNumber: string): TMetadataNumberType;
var
  RegionCode: string;
  Metadata: PPhoneMetadataRec;
begin
  RegionCode := GetRegionCodeForNumber(ACountryCode, ANationalNumber);
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, RegionCode, Metadata) then
  begin
    Result := mntUnknown;
    Exit;
  end;
  Result := GetNumberTypeHelper(ANationalNumber, Metadata);
end;

function IsValidNumberForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionCode: string): Boolean;
var
  Metadata: PPhoneMetadataRec;
begin
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, ARegionCode, Metadata) then
  begin
    Result := False;
    Exit;
  end;
  if (ARegionCode <> NonGeoRegionCode)
    and (ACountryCode <> GetCountryCodeForRegion(ARegionCode)) then
  begin
    { The country calling code of the number does not match the region. }
    Result := False;
    Exit;
  end;
  Result := GetNumberTypeHelper(ANationalNumber, Metadata) <> mntUnknown;
end;

function IsValidNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
begin
  Result := IsValidNumberForRegion(ACountryCode, ANationalNumber,
    GetRegionCodeForNumber(ACountryCode, ANationalNumber));
end;

{ ------------------------------------------------------------------
  Accessory API.
  ------------------------------------------------------------------ }

function GetSupportedTypesForMetadata(
  AMetadata: PPhoneMetadataRec): TMetadataNumberTypes;
var
  NumberType: TMetadataNumberType;
begin
  Result := [];
  if AMetadata = nil then
    Exit;
  for NumberType := Low(TMetadataNumberType) to High(TMetadataNumberType) do
  begin
    { "Never return FIXED_LINE_OR_MOBILE (it is a convenience type, and
      represents that a particular number type can't be determined) or UNKNOWN
      (the non-type)." }
    if (NumberType = mntFixedLineOrMobile) or (NumberType = mntUnknown) then
      Continue;
    if DescHasData(GetNumberDescByType(AMetadata, NumberType)) then
      Include(Result, NumberType);
  end;
end;

function GetSupportedTypesForRegion(
  const ARegionCode: string): TMetadataNumberTypes;
var
  Metadata: PPhoneMetadataRec;
begin
  { Upstream isValidRegionCode(regionCode) followed by getMetadataForRegion;
    the Try accessor is both at once ("001" and "ZZ" have no region metadata). }
  if not TryGetMetadataForRegion(ARegionCode, Metadata) then
  begin
    Result := [];
    Exit;
  end;
  Result := GetSupportedTypesForMetadata(Metadata);
end;

function GetSupportedTypesForNonGeoEntity(
  ACountryCode: Integer): TMetadataNumberTypes;
var
  Metadata: PPhoneMetadataRec;
begin
  if not TryGetMetadataForNonGeoEntity(ACountryCode, Metadata) then
  begin
    Result := [];
    Exit;
  end;
  Result := GetSupportedTypesForMetadata(Metadata);
end;

function IsGeoMobileCountryWithoutMobileAreaCodes(
  ACountryCode: Integer): Boolean;
begin
  { GEO_MOBILE_COUNTRIES_WITHOUT_MOBILE_AREA_CODES: "in China mobile numbers
    start with a carrier indicator, and beyond that are geographically
    assigned: this carrier indicator is not considered to be an area code." }
  Result := ACountryCode = 86;
end;

function IsCountryWithoutNationalPrefixWithAreaCodes(
  ACountryCode: Integer): Boolean;
begin
  { COUNTRIES_WITHOUT_NATIONAL_PREFIX_WITH_AREA_CODES: Mexico. }
  Result := ACountryCode = 52;
end;

{ Upstream GEO_MOBILE_COUNTRIES: Mexico, Argentina, Brazil, Indonesia ("some
  prefixes only (fixed CMDA wireless)") plus every member of
  GEO_MOBILE_COUNTRIES_WITHOUT_MOBILE_AREA_CODES. }
function IsGeoMobileCountry(ACountryCode: Integer): Boolean;
begin
  case ACountryCode of
    52, 54, 55, 62:
      Result := True;
  else
    Result := IsGeoMobileCountryWithoutMobileAreaCodes(ACountryCode);
  end;
end;

function IsNumberGeographical(AType: TMetadataNumberType;
  ACountryCode: Integer): Boolean;
begin
  Result := (AType = mntFixedLine)
    or (AType = mntFixedLineOrMobile)
    or (IsGeoMobileCountry(ACountryCode) and (AType = mntMobile));
end;

function IsNumberGeographical(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
begin
  Result := IsNumberGeographical(GetNumberType(ACountryCode, ANationalNumber),
    ACountryCode);
end;

function GetCountryMobileToken(ACountryCode: Integer): string;
begin
  { MOBILE_TOKEN_MAPPINGS of the pinned baseline: one entry, 54 -> "9". }
  if ACountryCode = 54 then
    Result := '9'
  else
    Result := '';
end;

function IsAlphaNumber(const AValue: string): Boolean;
const
  { Upstream MAX_INPUT_STRING_LENGTH; the parse driver uses the same bound. }
  MaxInputStringLength = 250;
var
  StrippedNumber: string;
begin
  if Length(UnicodeString(AValue)) > MaxInputStringLength then
  begin
    Result := False;
    Exit;
  end;
  if not IsViablePhoneNumber(AValue) then
  begin
    { "Number is too short, or doesn't match the basic phone number pattern." }
    Result := False;
    Exit;
  end;
  StrippedNumber := AValue;
  MaybeStripExtension(StrippedNumber);
  Result := IsValidAlphaPhone(StrippedNumber);
end;

function TruncateTooLongNumber(ACountryCode: Integer;
  var ANationalNumber: string): Boolean;
var
  LeadingZeros, Rest, Candidate: string;
  ZeroCount: Integer;
begin
  if IsValidNumber(ACountryCode, ANationalNumber) then
  begin
    Result := True;
    Exit;
  end;

  { The italianLeadingZero / numberOfLeadingZeros part of the number, counted
    exactly like setItalianLeadingZerosForPhoneNumber: only for a number of at
    least two digits that starts with '0', and never the last digit ("if the
    national number is all 0s, the last 0 is not counted as a leading zero").
    Rest is then String.valueOf(nationalNumber). }
  ZeroCount := 0;
  if (Length(ANationalNumber) > 1) and (ANationalNumber[1] = '0') then
  begin
    ZeroCount := 1;
    while (ZeroCount < Length(ANationalNumber) - 1)
      and (ANationalNumber[ZeroCount + 1] = '0') do
      Inc(ZeroCount);
  end;
  LeadingZeros := Copy(ANationalNumber, 1, ZeroCount);
  Rest := Copy(ANationalNumber, ZeroCount + 1, MaxInt);

  { Java: a do-while loop that runs "nationalNumber /= 10" until
    isValidNumber(numberCopy) holds. Dropping the last digit of the decimal representation IS the integer
    division, and an empty rest is the quotient 0. Java evaluates the TOO_SHORT
    test before the zero test; both end the loop with False and neither has a
    side effect, so the order is not observable. }
  repeat
    Rest := Copy(Rest, 1, Length(Rest) - 1);
    Candidate := LeadingZeros + Rest;
    if (Rest = '')
      or (IsPossibleNumberWithReason(ACountryCode, Candidate) = mvrTooShort) then
    begin
      Result := False;
      Exit;
    end;
  until IsValidNumber(ACountryCode, Candidate);

  ANationalNumber := Candidate;
  Result := True;
end;

function NumberTypeToString(AType: TMetadataNumberType): string;
begin
  case AType of
    mntFixedLine: Result := 'FIXED_LINE';
    mntMobile: Result := 'MOBILE';
    mntFixedLineOrMobile: Result := 'FIXED_LINE_OR_MOBILE';
    mntTollFree: Result := 'TOLL_FREE';
    mntPremiumRate: Result := 'PREMIUM_RATE';
    mntSharedCost: Result := 'SHARED_COST';
    mntVoip: Result := 'VOIP';
    mntPersonalNumber: Result := 'PERSONAL_NUMBER';
    mntPager: Result := 'PAGER';
    mntUan: Result := 'UAN';
    mntVoicemail: Result := 'VOICEMAIL';
  else
    Result := 'UNKNOWN';
  end;
end;

function ValidationResultToString(AResult: TMetadataValidationResult): string;
begin
  { No else branch: the case covers every enumeration value, and FreePascal
    reports an unreachable else as a warning. }
  Result := 'UNKNOWN';
  case AResult of
    mvrIsPossible: Result := 'IS_POSSIBLE';
    mvrIsPossibleLocalOnly: Result := 'IS_POSSIBLE_LOCAL_ONLY';
    mvrInvalidCountryCode: Result := 'INVALID_COUNTRY_CODE';
    mvrTooShort: Result := 'TOO_SHORT';
    mvrInvalidLength: Result := 'INVALID_LENGTH';
    mvrTooLong: Result := 'TOO_LONG';
  end;
end;

{ ---------------------------------------------------------------------------
  Parsing helpers
  --------------------------------------------------------------------------- }

{ Upstream RegexBasedMatcher.matchNationalNumber(number, desc, false). Unlike
  IsNumberMatchingDesc this deliberately skips the possible length pre-check:
  the upstream parse path calls the matcher API directly. }
function MatchesNationalNumberPattern(const ANumber: string;
  ADesc: PPhoneNumberDescRec): Boolean;
begin
  if ADesc = nil then
    Result := False
  else
    Result := TryMatchFull(ADesc^.NationalNumberPattern, ANumber);
end;

function ExtractCountryCode(const AFullNumber: string;
  out ANationalNumber: string): Integer;
var
  I, Code: Integer;
  Digit: Char;
begin
  ANationalNumber := '';
  Result := 0;

  { Country codes do not begin with a '0'. }
  if (AFullNumber = '') or (AFullNumber[1] = '0') then
    Exit;

  Code := 0;
  for I := 1 to MaxLengthCountryCode do
  begin
    if I > Length(AFullNumber) then
      Exit;
    Digit := AFullNumber[I];
    if (Digit < '0') or (Digit > '9') then
      Exit;
    Code := Code * 10 + (Ord(Digit) - Ord('0'));
    if IsSupportedCallingCode(Code) then
    begin
      ANationalNumber := Copy(AFullNumber, I + 1, Length(AFullNumber) - I);
      Result := Code;
      Exit;
    end;
  end;
end;

function ParsePrefixAsIdd(const AIddPattern: string; var ANumber: string): Boolean;
var
  Match: TRegexPrefixMatch;
  Rest: string;
begin
  Result := False;
  if (AIddPattern = '') or (ANumber = '') then
    Exit;
  if not TryMatchPrefixEx(AIddPattern, ANumber, Match) then
    Exit;

  Rest := Copy(ANumber, Match.MatchEnd, Length(ANumber) - Match.MatchEnd + 1);

  { Upstream looks up the first captured digit behind the match and refuses the
    strip when it is a zero. ANumber is digits only here, so the first digit of
    the remainder is its first character. }
  if (Rest <> '') and (Rest[1] = '0') then
    Exit;

  ANumber := Rest;
  Result := True;
end;

{ Expands a nationalPrefixTransformRule against a prefix match, i.e. the
  replacement half of the Matcher.replaceFirst upstream calls here.

  It uses LibPhoneNumber.Regex.ExpandJavaReplacement, the one implementation
  of the template grammar, which ports Matcher.appendReplacement (multi digit
  group references and the '\' escape included).

  GroupValue carries the empty string for a group that did not participate,
  which is exactly what ExpandJavaReplacement expects and what Java appends for
  a null group, so the GroupMatched flags need not be consulted separately. }
function ExpandTransformRule(const ARule: string;
  const AMatch: TRegexPrefixMatch): string;
begin
  Result := ExpandJavaReplacement(ARule, AMatch.GroupValue, AMatch.GroupCount);
end;

function MaybeStripNationalPrefixAndCarrierCode(var ANumber: string;
  AMetadata: PPhoneMetadataRec; out ACarrierCode: string): Boolean;
var
  PossibleNationalPrefix, TransformRule, Remainder, Transformed: string;
  GeneralDesc: PPhoneNumberDescRec;
  Match: TRegexPrefixMatch;
  IsViableOriginalNumber: Boolean;
  NumOfGroups: Integer;
begin
  ACarrierCode := '';
  Result := False;

  if AMetadata = nil then
    Exit;

  PossibleNationalPrefix := AMetadata^.NationalPrefixForParsing;
  if (ANumber = '') or (PossibleNationalPrefix = '') then
    Exit;

  if not TryMatchPrefixEx(PossibleNationalPrefix, ANumber, Match) then
    Exit;

  GeneralDesc := GetDesc(AMetadata, pdkGeneralDesc);
  IsViableOriginalNumber := MatchesNationalNumberPattern(ANumber, GeneralDesc);
  NumOfGroups := Match.GroupCount;
  TransformRule := AMetadata^.NationalPrefixTransformRule;

  { GroupMatched[0] is always True, which mirrors Java's group(0) never being
    null; that is what keeps a pattern without capturing groups on the
    transform branch when the territory declares a transform rule. }
  if (TransformRule = '') or (not Match.GroupMatched[NumOfGroups]) then
  begin
    Remainder := Copy(ANumber, Match.MatchEnd, Length(ANumber) - Match.MatchEnd + 1);
    if IsViableOriginalNumber
      and not MatchesNationalNumberPattern(Remainder, GeneralDesc) then
      Exit;
    if (NumOfGroups > 0) and Match.GroupMatched[NumOfGroups] then
      ACarrierCode := Match.GroupValue[1];
    ANumber := Remainder;
    Result := True;
  end
  else
  begin
    Transformed := ExpandTransformRule(TransformRule, Match)
      + Copy(ANumber, Match.MatchEnd, Length(ANumber) - Match.MatchEnd + 1);
    if IsViableOriginalNumber
      and not MatchesNationalNumberPattern(Transformed, GeneralDesc) then
      Exit;
    if NumOfGroups > 1 then
      ACarrierCode := Match.GroupValue[1];
    ANumber := Transformed;
    Result := True;
  end;
end;


{ ==================================================================
  Entry path of parseHelper.

  Everything below runs on the RAW input, before the calling code is
  extracted and before any normalisation. The three grammars - the trailing
  garbage of extractPossibleNumber, VALID_PHONE_NUMBER and
  EXTN_PATTERNS_FOR_PARSING - are scanned rather than compiled; see the unit
  header for the three reasons.
  ================================================================== }

{ One code point as a string. Every non ASCII literal of this block is built
  through this helper instead of being written into the source, so the file
  stays pure ASCII and its encoding never becomes load bearing (the same rule
  DIGIT_PLACEHOLDER follows in LibPhoneNumber.AsYouTypeFormatter). }
function CodePoint(ACode: Integer): UnicodeString;
begin
  SetLength(Result, 1);
  Result[1] := WideChar(ACode);
end;

{ ------------------------------------------------------------------
  Code point scanning.

  java.util.regex matches CODE POINTS, not UTF-16 code units, so for every
  character class of the parse path a supplementary character is ONE unit of
  input. The scanners below therefore step through the string with
  CodePointLengthAt / CodePointLengthBefore and ask the category predicates
  about the whole code point.

  This is NOT the same question as Character.digit(char, 10), which
  normalizeDigits calls in a charAt() loop and which cannot see a supplementary
  code point at all. That parity is deliberately kept: UnicodeDecimalDigitValue
  and NormalizeDigits stay BMP only, while the regex derived classes below
  decode surrogate pairs.

  Consequence, documented rather than smoothed over: for a supplementary
  character this port follows JAVA, and the C# reference oracle differs.
  System.Text.RegularExpressions matches UTF-16 code units, so .NET sees the
  two halves of a surrogate pair as two characters that are neither a letter
  nor a number nor a digit. Two observable cases, both pinned by the test
  suite:

    three MATHEMATICAL BOLD DIGITs (U+1D7CF U+1D7D0 U+1D7D1), region US
      Java  : viable (three DIGITS groups), then normalize() drops all six
              code units because Character.digit(char) returns -1, which
              leaves nothing and reports TOO_SHORT_NSN
      oracle: not viable, reports NOT_A_NUMBER

    a trailing GOTHIC LETTER AHSA (U+10330) behind a US number, region ZZ
      Java  : the letter survives UNWANTED_END_CHARS (it IS a letter), and
              then VALID_PHONE_NUMBER rejects it because VALID_ALPHA is ASCII
              only, so the result is NOT_A_NUMBER
      oracle: both halves are stripped as unwanted end characters and the
              number parses

  Java is the functional source of truth of this port (see AGENTS.md), so the
  Java answer is what the scanners produce.
  ------------------------------------------------------------------ }

function IsHighSurrogateCode(ACode: Integer): Boolean;
begin
  Result := (ACode >= $D800) and (ACode <= $DBFF);
end;

function IsLowSurrogateCode(ACode: Integer): Boolean;
begin
  Result := (ACode >= $DC00) and (ACode <= $DFFF);
end;

{ Number of UTF-16 code units the code point at AIndex occupies: 2 for a well
  formed surrogate pair, 1 otherwise. A LONE surrogate counts as one code
  point, which is what java.util.regex does with it as well. }
function CodePointLengthAt(const AWide: UnicodeString; AIndex: Integer): Integer;
begin
  if (AIndex < Length(AWide)) and IsHighSurrogateCode(Ord(AWide[AIndex]))
    and IsLowSurrogateCode(Ord(AWide[AIndex + 1])) then
    Result := 2
  else
    Result := 1;
end;

{ Number of code units of the code point that ENDS at AIndex. }
function CodePointLengthBefore(const AWide: UnicodeString;
  AIndex: Integer): Integer;
begin
  if (AIndex > 1) and IsLowSurrogateCode(Ord(AWide[AIndex]))
    and IsHighSurrogateCode(Ord(AWide[AIndex - 1])) then
    Result := 2
  else
    Result := 1;
end;

{ The two OPEN Unicode general categories of UNWANTED_END_CHARS, and the class
  DIGITS, for the code point at AIndex.

  A BMP code point is answered by this unit itself - the case statement for
  DIGITS, the RTL for the two categories - while a supplementary one goes to
  the surrogate aware string overload of the RTL. Both compilers provide it
  (Delphi System.Character, FreePascal Character), and it is the only way to
  ask about a code point above U+FFFF without carrying a second, much larger
  category table. }
{$IFNDEF FPC}
{ The surrogate aware string overloads of System.Character are marked
  deprecated in favour of TCharHelper, but TCharHelper is a helper for Char and
  therefore has no code point (string plus index) counterpart at all. The three
  predicates below are the only place that needs one, so the warning is
  switched off around exactly them and back on afterwards. }
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
{ A LONE surrogate is a code point of its own (see CodePointLengthAt) of the
  general category Cs, so it is neither a letter nor a number - which is what
  the java.util.regex categories L and N answer for it. The RTL is not asked:
  the surrogate aware string overloads RAISE on a lone surrogate (Delphi:
  EArgumentOutOfRangeException), and an exception out of a no-throw parse
  helper for malformed UTF-16 input is not an acceptable answer. Found by the
  FreePascal runtime gate's character sweep. }
function IsLoneSurrogateAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
begin
  Result := (CodePointLengthAt(AWide, AIndex) = 1)
    and (IsHighSurrogateCode(Ord(AWide[AIndex]))
      or IsLowSurrogateCode(Ord(AWide[AIndex])));
end;

function IsUnicodeLetterAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
begin
  if IsLoneSurrogateAt(AWide, AIndex) then
    Result := False
  else
{$IFDEF FPC}
    Result := TCharacter.IsLetter(AWide, AIndex);
{$ELSE}
    Result := System.Character.IsLetter(AWide, AIndex);
{$ENDIF}
end;

function IsUnicodeNumberAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
begin
  if IsLoneSurrogateAt(AWide, AIndex) then
    Result := False
  else
{$IFDEF FPC}
    Result := TCharacter.IsNumber(AWide, AIndex);
{$ELSE}
    Result := System.Character.IsNumber(AWide, AIndex);
{$ENDIF}
end;

function IsUnicodeDecimalDigitAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
begin
  if CodePointLengthAt(AWide, AIndex) = 1 then
    Result := IsUnicodeDecimalDigit(AWide[AIndex])
  else
{$IFDEF FPC}
    Result := TCharacter.IsDigit(AWide, AIndex);
{$ELSE}
    Result := System.Character.IsDigit(AWide, AIndex);
{$ENDIF}
end;

{$IFNDEF FPC}
{$WARN SYMBOL_DEPRECATED ON}
{$ENDIF}

{ Upstream VALID_START_CHAR, i.e. a plus character or a decimal digit. }
function IsValidStartCharAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
begin
  Result := ((CodePointLengthAt(AWide, AIndex) = 1)
      and IsPlusChar(AWide[AIndex]))
    or IsUnicodeDecimalDigitAt(AWide, AIndex);
end;

{ Upstream UNWANTED_END_CHARS, i.e. one code point of the class "neither a
  Unicode letter nor a Unicode number, and not the hash sign". AIndex is the
  index of the LAST code unit of the code point. }
function IsUnwantedEndCharBefore(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
var
  Start: Integer;
begin
  Start := AIndex - CodePointLengthBefore(AWide, AIndex) + 1;
  Result := not ((Start = AIndex) and (Ord(AWide[AIndex]) = Ord('#')))
    and not IsUnicodeLetterAt(AWide, Start)
    and not IsUnicodeNumberAt(AWide, Start);
end;

function ExtractPossibleNumber(const AValue: string): string;
var
  Wide: UnicodeString;
  I, J, Len, Start: Integer;
begin
  Wide := UnicodeString(AValue);
  Len := Length(Wide);

  { VALID_START_CHAR_PATTERN.find(): everything in front of the first code
    point that can start a phone number is dropped; no such code point at all
    means "not a phone number", which Java reports as the empty string. }
  Start := 0;
  I := 1;
  while I <= Len do
  begin
    if IsValidStartCharAt(Wide, I) then
    begin
      Start := I;
      Break;
    end;
    Inc(I, CodePointLengthAt(Wide, I));
  end;
  if Start = 0 then
  begin
    Result := '';
    Exit;
  end;
  Wide := Copy(Wide, Start, Len - Start + 1);
  Len := Length(Wide);

  { UNWANTED_END_CHAR_PATTERN.find(): the pattern is end anchored and greedy,
    so its leftmost match is the start of the MAXIMAL trailing run. }
  I := Len;
  while (I >= 1) and IsUnwantedEndCharBefore(Wide, I) do
    Dec(I, CodePointLengthBefore(Wide, I));
  if I < Len then
  begin
    Wide := Copy(Wide, 1, I);
    Len := I;
  end;

  { SECOND_NUMBER_START_PATTERN.find(): a backslash or a slash, then ASCII
    spaces, then a LOWER CASE x. That pattern is compiled without REGEX_FLAGS
    upstream, so it really is case sensitive. Every character it looks at is
    ASCII and no half of a surrogate pair can equal an ASCII code unit, so this
    loop may walk code units. }
  I := 1;
  while I <= Len do
  begin
    if (Ord(Wide[I]) = Ord('\')) or (Ord(Wide[I]) = Ord('/')) then
    begin
      J := I + 1;
      while (J <= Len) and (Ord(Wide[J]) = Ord(' ')) do
        Inc(J);
      if (J <= Len) and (Ord(Wide[J]) = Ord('x')) then
      begin
        Wide := Copy(Wide, 1, I - 1);
        Break;
      end;
    end;
    Inc(I);
  end;

  Result := string(Wide);
end;

function IsAsciiLetter(ACh: WideChar): Boolean;
begin
  Result := ((ACh >= 'A') and (ACh <= 'Z')) or ((ACh >= 'a') and (ACh <= 'z'));
end;

{ "[" + VALID_PUNCTUATION + STAR_SIGN + "]", the class the repeated digit group
  of VALID_PHONE_NUMBER is separated by. }
function IsPunctuationOrStar(ACh: WideChar): Boolean;
begin
  Result := IsValidPunctuation(ACh) or (Ord(ACh) = Ord('*'));
end;

{ "[" + VALID_PUNCTUATION + STAR_SIGN + VALID_ALPHA + DIGITS + "]", the
  trailing class of VALID_PHONE_NUMBER, for the code point at AIndex.
  VALID_PUNCTUATION, STAR_SIGN and VALID_ALPHA (the ASCII letters in both
  cases) are BMP only, so a supplementary code point can only get in through
  DIGITS. }
function IsValidPhoneNumberTailCharAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
begin
  Result := ((CodePointLengthAt(AWide, AIndex) = 1)
      and (IsPunctuationOrStar(AWide[AIndex]) or IsAsciiLetter(AWide[AIndex])))
    or IsUnicodeDecimalDigitAt(AWide, AIndex);
end;

{ VALID_PHONE_NUMBER applied to AWide[AFrom..ATo] with matches().

  In words - the braces of the bounded repetitions would end this comment:
  either exactly MIN_LENGTH_FOR_NSN digits, or a run of PLUS_CHARS followed by
  three or more repetitions of "a run of punctuation or star, then one digit",
  followed by any run of punctuation, star, ASCII letters and digits.

  AAllowShortForm selects whether the first alternative may be used. It must be
  False whenever an EXTENSION follows, because the alternation bar has the
  lowest precedence in the upstream expression: VALID_PHONE_NUMBER_PATTERN is
  "<short form>|<general form>(?:<extension>)?", so the optional extension
  belongs to the general form ONLY.

  Everything is counted in CODE POINTS, so the short form is two DIGITS and not
  two code units, and a supplementary digit is one repetition of the group.

  No backtracking is needed in the general form. The greedy digit group loop
  can only consume code points the trailing class also accepts, so stopping it
  later never turns a matching string into a non matching one; and the leading
  PLUS_CHARS run is possessive upstream anyway. }
function ValidPhoneNumberMatches(const AWide: UnicodeString;
  AFrom, ATo: Integer; AAllowShortForm: Boolean): Boolean;
var
  I, Saved, Groups, CodePoints: Integer;
  AllDigits: Boolean;
begin
  Result := False;
  if ATo < AFrom then
    Exit;

  if AAllowShortForm then
  begin
    AllDigits := True;
    CodePoints := 0;
    I := AFrom;
    while I <= ATo do
    begin
      if not IsUnicodeDecimalDigitAt(AWide, I) then
      begin
        AllDigits := False;
        Break;
      end;
      Inc(CodePoints);
      Inc(I, CodePointLengthAt(AWide, I));
    end;
    if AllDigits and (CodePoints = MinLengthForNsn) then
    begin
      Result := True;
      Exit;
    end;
  end;

  I := AFrom;
  while (I <= ATo) and (CodePointLengthAt(AWide, I) = 1)
    and IsPlusChar(AWide[I]) do
    Inc(I);

  Groups := 0;
  while I <= ATo do
  begin
    Saved := I;
    while (I <= ATo) and (CodePointLengthAt(AWide, I) = 1)
      and IsPunctuationOrStar(AWide[I]) do
      Inc(I);
    if (I <= ATo) and IsUnicodeDecimalDigitAt(AWide, I) then
    begin
      Inc(I, CodePointLengthAt(AWide, I));
      Inc(Groups);
    end
    else
    begin
      { The separator run belongs to the trailing class instead. }
      I := Saved;
      Break;
    end;
  end;

  if Groups < 3 then
    Exit;

  while I <= ATo do
  begin
    if not IsValidPhoneNumberTailCharAt(AWide, I) then
      Exit;
    Inc(I, CodePointLengthAt(AWide, I));
  end;

  Result := True;
end;

{ ------------------------------------------------------------------
  EXTN_PATTERNS_FOR_PARSING, i.e. createExtnPattern(true).

  Upstream builds the expression from four character classes, two label sets
  and four digit caps; all of them are reproduced below under the upstream
  names. The six alternatives are tried in the upstream order, because
  java.util.regex prefers the first alternative that matches.
  ------------------------------------------------------------------ }

const
  { The four digit caps of createExtnPattern. }
  ExtLimitAfterExplicitLabel = 20;
  ExtLimitAfterLikelyLabel = 15;
  ExtLimitAfterAmbiguousChar = 9;
  ExtLimitWhenNotSure = 6;

var
  { explicitExtLabels and ambiguousExtLabels, expanded into the finite string
    sets they generate. Both are stored CASE FOLDED (see FoldExtnLabelChar),
    because EXTN_PATTERN is compiled with CASE_INSENSITIVE and UNICODE_CASE. }
  GExplicitExtnLabels: array of UnicodeString;
  GAmbiguousExtnLabels: array of UnicodeString;

{ EXTN_PATTERN is compiled with CASE_INSENSITIVE and UNICODE_CASE. Java
  implements a single literal character of such a pattern as

    lower == ch or lower == toLowerCase(toUpperCase(ch))

  with lower = toLowerCase(toUpperCase(patternChar)). This function is that
  right hand side, restricted to what the label sets can actually ask for.

  The four RANGES cover the four alphabets the labels live in: ASCII, Latin-1
  Supplement (for the o with acute accent), Cyrillic (for the Russian label)
  and the full width forms.

  The three SINGLE code points below are the rest of the equivalence closure of
  the label letters. The letters that occur in a label are a, e, i, n, o, s, t,
  x, the o with acute accent, the three Cyrillic ones and the full width
  e/i/n/t/x; walking Java's rule over the BMP leaves exactly three code points
  outside the ranges:

    U+017F LATIN SMALL LETTER LONG S     -> s   (in "exten<s>io", "exten<s>ion")
    U+0131 LATIN SMALL LETTER DOTLESS I  -> i   (in "int", "ensi", "anexo" has no i)
    U+0130 LATIN CAPITAL LETTER I WITH DOT ABOVE -> i

  No general folding table is built, deliberately: the label sets are finite,
  so their closure is, and a general table would be Unicode version dependent
  data with no other caller.

  DIVERGENCE FROM THE C# ORACLE, pinned by the test suite: .NET matches case
  insensitively with ToLower(invariant), and ToLowerInvariant leaves all three
  of the code points above unchanged, so the oracle rejects an extension label
  spelled with them while Java (and this port) accepts it. Java is the
  functional source of truth here; see AGENTS.md. }
function FoldExtnLabelChar(ACh: WideChar): Integer;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  if (Code >= Ord('A')) and (Code <= Ord('Z')) then
    Inc(Code, Ord('a') - Ord('A'))
  else if (Code >= $00C0) and (Code <= $00DE) and (Code <> $00D7) then
    Inc(Code, $20)
  else if (Code >= $0410) and (Code <= $042F) then
    Inc(Code, $20)
  else if (Code >= $FF21) and (Code <= $FF3A) then
    Inc(Code, $20)
  else if Code = $017F then
    Code := Ord('s')
  else if (Code = $0131) or (Code = $0130) then
    Code := Ord('i');
  Result := Code;
end;

{ ALabel must already be case folded. }
function MatchesExtnLabel(const AWide: UnicodeString; AIndex, ATo: Integer;
  const ALabel: UnicodeString): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (AIndex + Length(ALabel) - 1) > ATo then
    Exit;
  for I := 1 to Length(ALabel) do
    if FoldExtnLabelChar(AWide[AIndex + I - 1]) <> Ord(ALabel[I]) then
      Exit;
  Result := True;
end;

procedure BuildExtnLabelTables;
var
  Prefixes, Suffixes: array[0..1] of UnicodeString;
  Middles: array[0..3] of UnicodeString;
  P, M, Su, N: Integer;
begin
  { explicitExtLabels, first branch. In words: an optional 'e', then "xt", then
    optionally "ensi" followed by either an 'o' with an optional combining
    acute accent U+0301 or the precomposed U+00F3, then an optional 'n'. Every
    quantifier in it is optional or a single character, so the branch generates
    exactly 2 x 4 x 2 = 16 strings. }
  Prefixes[0] := '';
  Prefixes[1] := 'e';
  Middles[0] := '';
  Middles[1] := 'ensio';
  Middles[2] := 'ensio' + CodePoint($0301);   { combining acute accent }
  Middles[3] := 'ensi' + CodePoint($00F3);    { o with acute accent }
  Suffixes[0] := '';
  Suffixes[1] := 'n';

  SetLength(GExplicitExtnLabels, 16 + 4 + 2);
  N := 0;
  for P := 0 to 1 do
    for M := 0 to 3 do
      for Su := 0 to 1 do
      begin
        GExplicitExtnLabels[N] := Prefixes[P] + 'xt' + Middles[M] + Suffixes[Su];
        Inc(N);
      end;

  { Second branch, the full width spelling: an optional U+FF45, then U+FF58
    U+FF54, then an optional U+FF4E. }
  for P := 0 to 1 do
    for Su := 0 to 1 do
    begin
      GExplicitExtnLabels[N] := '';
      if P = 1 then
        GExplicitExtnLabels[N] := CodePoint($FF45);
      GExplicitExtnLabels[N] := GExplicitExtnLabels[N]
        + CodePoint($FF58) + CodePoint($FF54);
      if Su = 1 then
        GExplicitExtnLabels[N] := GExplicitExtnLabels[N] + CodePoint($FF4E);
      Inc(N);
    end;

  { Third and fourth branch: the Cyrillic label U+0434 U+043E U+0431 and the
    Portuguese/Spanish "anexo". }
  GExplicitExtnLabels[N] := CodePoint($0434) + CodePoint($043E)
    + CodePoint($0431);
  Inc(N);
  GExplicitExtnLabels[N] := 'anexo';

  { ambiguousExtLabels: the six single character labels 'x', U+FF58, '#',
    U+FF03, '~' and U+FF5E, plus "int" and its full width spelling U+FF49
    U+FF4E U+FF54. }
  SetLength(GAmbiguousExtnLabels, 8);
  GAmbiguousExtnLabels[0] := 'x';
  GAmbiguousExtnLabels[1] := CodePoint($FF58);
  GAmbiguousExtnLabels[2] := '#';
  GAmbiguousExtnLabels[3] := CodePoint($FF03);
  GAmbiguousExtnLabels[4] := '~';
  GAmbiguousExtnLabels[5] := CodePoint($FF5E);
  GAmbiguousExtnLabels[6] := 'int';
  GAmbiguousExtnLabels[7] := CodePoint($FF49) + CodePoint($FF4E)
    + CodePoint($FF54);
end;

{ possibleSeparatorsBetweenNumberAndExtLabel: space, U+00A0, tab or comma. }
function IsExtnSeparator(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  Result := (Code = Ord(' ')) or (Code = $00A0) or (Code = 9)
    or (Code = Ord(','));
end;

{ possibleSeparatorsNumberExtLabelNoComma: space, U+00A0 or tab. }
function IsExtnSeparatorNoComma(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  Result := (Code = Ord(' ')) or (Code = $00A0) or (Code = 9);
end;

{ possibleCharsAfterExtLabel: an optional colon, full stop or U+FF0E, then a
  run of spaces, U+00A0, tabs, commas and hyphens. }
function SkipCharsAfterExtLabel(const AWide: UnicodeString;
  AIndex, ATo: Integer): Integer;
var
  Code: Integer;
begin
  Result := AIndex;
  if Result <= ATo then
  begin
    Code := Ord(AWide[Result]);
    if (Code = Ord(':')) or (Code = Ord('.')) or (Code = $FF0E) then
      Inc(Result);
  end;
  while Result <= ATo do
  begin
    Code := Ord(AWide[Result]);
    if (Code = Ord(' ')) or (Code = $00A0) or (Code = 9) or (Code = Ord(','))
      or (Code = Ord('-')) then
      Inc(Result)
    else
      Break;
  end;
end;

{ extnDigits(maxLength) followed by the optional or mandatory hash sign of the
  alternative, and - when AAnchorEnd is set - the end anchor of EXTN_PATTERN:
  the match MUST then end at ATo.

  AHash: 0 = the alternative has no hash sign at all, 1 = optionalExtnSuffix,
  2 = the mandatory hash sign of americanStyleExtnWithSuffix.

  AAnchorEnd = False is the EXTN_PATTERNS_FOR_MATCHING use,
  where the expression is the last, optional element of
  PhoneNumberMatcher.PATTERN and nothing follows it. AEnd then reports where
  the match ended.

  The greedy digit run needs no backtracking in EITHER mode:

    * giving a digit back can only put another DIGIT in front of the suffix,
      and neither a hash sign nor the end of input matches a digit;
    * if the cap AMaxDigits was reached and the next character is a digit as
      well, then every shorter run ends on a digit too, so all of them fail
      for the same reason.

  The same argument covers the optional hash sign: not taking it can only put
  the '#' itself in front of the suffix or the end anchor, and '#' is
  neither. }
function TryExtnDigits(const AWide: UnicodeString;
  AIndex, ATo, AMaxDigits, AHash: Integer; AAnchorEnd: Boolean;
  out AExtension: string; out AEnd: Integer): Boolean;
var
  Start, DigitEnd, I, Digits: Integer;
begin
  Result := False;
  AExtension := '';
  AEnd := AIndex;
  Start := AIndex;
  I := AIndex;
  Digits := 0;
  { extnDigits counts DIGITS, i.e. code points, not code units. }
  while (I <= ATo) and (Digits < AMaxDigits)
    and IsUnicodeDecimalDigitAt(AWide, I) do
  begin
    Inc(Digits);
    Inc(I, CodePointLengthAt(AWide, I));
  end;
  DigitEnd := I;
  if DigitEnd = Start then
    Exit;

  if AHash = 1 then
  begin
    if (I <= ATo) and (Ord(AWide[I]) = Ord('#')) then
      Inc(I);
  end
  else if AHash = 2 then
  begin
    if (I > ATo) or (Ord(AWide[I]) <> Ord('#')) then
      Exit;
    Inc(I);
  end;

  if AAnchorEnd and (I <> (ATo + 1)) then
    Exit;

  { The capturing group of the alternative holds the DIGITS only, never the
    hash sign. It is the raw substring, so a full width digit in the extension
    stays a full width digit - which is what upstream stores and what the
    reference oracle confirms. }
  AExtension := string(Copy(AWide, Start, DigitEnd - Start));
  AEnd := I;
  Result := True;
end;

{ The alternatives of createExtnPattern, anchored at AStart. Upstream order.

  AForParsing selects the constant: True is EXTN_PATTERNS_FOR_PARSING (all
  six alternatives), False is EXTN_PATTERNS_FOR_MATCHING (the first four; the
  auto dialling ones are "additional pattern that is supported when parsing,
  not when matching").

  AAnchorEnd = True adds the end anchor of EXTN_PATTERN, i.e. the match must
  end at ATo. AEnd reports where it actually ended.

  Note that the four label alternations of the expression are MUTUALLY
  EXCLUSIVE at any one position, so the order in which the finite label sets
  are enumerated below cannot change the result: after a label, upstream
  accepts only possibleCharsAfterExtLabel and then a digit, and no label is a
  prefix of another one followed by such a character. That is why the tables
  may be built in any order at all. }
function TryMatchExtensionAt(const AWide: UnicodeString; AStart, ATo: Integer;
  AForParsing, AAnchorEnd: Boolean;
  out AExtension: string; out AEnd: Integer): Boolean;
var
  I, J, K: Integer;
  Ext: string;
  MatchEnd: Integer;
begin
  Result := False;
  AExtension := '';
  AEnd := AStart;

  { 1. rfcExtn = RFC3966_EXTN_PREFIX + extnDigits(20). The whole pattern is
       case insensitive, so ";EXT=" is accepted as well. }
  if MatchesExtnLabel(AWide, AStart, ATo, ';ext=') then
    if TryExtnDigits(AWide, AStart + 5, ATo,
      ExtLimitAfterExplicitLabel, 0, AAnchorEnd, Ext, MatchEnd) then
    begin
      AExtension := Ext;
      AEnd := MatchEnd;
      Result := True;
      Exit;
    end;

  { 2. explicitExtn. The leading separator run is greedy without backtracking
       because no label starts with one of its characters; the LABEL choice is
       backtracked over the whole set. }
  I := AStart;
  while (I <= ATo) and IsExtnSeparator(AWide[I]) do
    Inc(I);
  for K := 0 to High(GExplicitExtnLabels) do
    if MatchesExtnLabel(AWide, I, ATo, GExplicitExtnLabels[K]) then
    begin
      J := SkipCharsAfterExtLabel(AWide,
        I + Length(GExplicitExtnLabels[K]), ATo);
      if TryExtnDigits(AWide, J, ATo,
        ExtLimitAfterExplicitLabel, 1, AAnchorEnd, Ext, MatchEnd) then
      begin
        AExtension := Ext;
        AEnd := MatchEnd;
        Result := True;
        Exit;
      end;
    end;

  { 3. ambiguousExtn. }
  I := AStart;
  while (I <= ATo) and IsExtnSeparator(AWide[I]) do
    Inc(I);
  for K := 0 to High(GAmbiguousExtnLabels) do
    if MatchesExtnLabel(AWide, I, ATo, GAmbiguousExtnLabels[K]) then
    begin
      J := SkipCharsAfterExtLabel(AWide,
        I + Length(GAmbiguousExtnLabels[K]), ATo);
      if TryExtnDigits(AWide, J, ATo,
        ExtLimitAfterAmbiguousChar, 1, AAnchorEnd, Ext, MatchEnd) then
      begin
        AExtension := Ext;
        AEnd := MatchEnd;
        Result := True;
        Exit;
      end;
    end;

  { 4. americanStyleExtnWithSuffix: the ambiguousSeparator run of hyphens and
       spaces, then extnDigits(6), then a mandatory hash sign. }
  I := AStart;
  if (I <= ATo) and ((AWide[I] = '-') or (AWide[I] = ' ')) then
  begin
    while (I <= ATo) and ((AWide[I] = '-') or (AWide[I] = ' ')) do
      Inc(I);
    if TryExtnDigits(AWide, I, ATo, ExtLimitWhenNotSure, 2, AAnchorEnd,
      Ext, MatchEnd) then
    begin
      AExtension := Ext;
      AEnd := MatchEnd;
      Result := True;
      Exit;
    end;
  end;

  { The last two alternatives only exist in createExtnPattern(true). }
  if not AForParsing then
    Exit;

  { 5. autoDiallingExtn: the no comma separator run, then either exactly two
       commas or one semicolon. }
  I := AStart;
  while (I <= ATo) and IsExtnSeparatorNoComma(AWide[I]) do
    Inc(I);
  if (I + 1 <= ATo) and (AWide[I] = ',') and (AWide[I + 1] = ',') then
    if TryExtnDigits(AWide, SkipCharsAfterExtLabel(AWide, I + 2, ATo),
      ATo, ExtLimitAfterLikelyLabel, 1, AAnchorEnd, Ext, MatchEnd) then
    begin
      AExtension := Ext;
      AEnd := MatchEnd;
      Result := True;
      Exit;
    end;
  if (I <= ATo) and (AWide[I] = ';') then
    if TryExtnDigits(AWide, SkipCharsAfterExtLabel(AWide, I + 1, ATo),
      ATo, ExtLimitAfterLikelyLabel, 1, AAnchorEnd, Ext, MatchEnd) then
    begin
      AExtension := Ext;
      AEnd := MatchEnd;
      Result := True;
      Exit;
    end;

  { 6. onlyCommasExtn. The greedy comma run is equivalent to the upstream
       backtracking one, because possibleCharsAfterExtLabel accepts commas as
       well and would consume exactly the same characters. }
  I := AStart;
  while (I <= ATo) and IsExtnSeparatorNoComma(AWide[I]) do
    Inc(I);
  if (I <= ATo) and (AWide[I] = ',') then
  begin
    J := I;
    while (J <= ATo) and (AWide[J] = ',') do
      Inc(J);
    if TryExtnDigits(AWide, SkipCharsAfterExtLabel(AWide, J, ATo), ATo,
      ExtLimitAfterAmbiguousChar, 1, AAnchorEnd, Ext, MatchEnd) then
    begin
      AExtension := Ext;
      AEnd := MatchEnd;
      Result := True;
      Exit;
    end;
  end;
end;

function TryMatchExtensionForMatchingAt(const AWide: UnicodeString;
  AStart, ATo: Integer; out AMatchEnd: Integer): Boolean;
var
  Ignored: string;
begin
  Result := TryMatchExtensionAt(AWide, AStart, ATo, False, False,
    Ignored, AMatchEnd);
end;

function IsViablePhoneNumber(const AValue: string): Boolean;
var
  Wide: UnicodeString;
  Len, S, ExtEnd: Integer;
  Ext: string;
begin
  Wide := UnicodeString(AValue);
  Len := Length(Wide);
  if Len < MinLengthForNsn then
  begin
    Result := False;
    Exit;
  end;

  { VALID_PHONE_NUMBER on its own, both alternatives. }
  if ValidPhoneNumberMatches(Wide, 1, Len, True) then
  begin
    Result := True;
    Exit;
  end;

  { VALID_PHONE_NUMBER followed by an extension. Only the SECOND alternative
    may carry one; see ValidPhoneNumberMatches for the precedence argument.
    The split walks CODE POINT boundaries, so it never cuts a surrogate pair
    in half. }
  S := 1;
  while S <= Len do
  begin
    if ValidPhoneNumberMatches(Wide, 1, S - 1, False)
      and TryMatchExtensionAt(Wide, S, Len, True, True, Ext, ExtEnd) then
    begin
      Result := True;
      Exit;
    end;
    Inc(S, CodePointLengthAt(Wide, S));
  end;

  Result := False;
end;

function MaybeStripExtension(var ANumber: string): string;
var
  Wide: UnicodeString;
  Len, S, ExtEnd: Integer;
  Ext, Prefix: string;
begin
  Result := '';
  Wide := UnicodeString(ANumber);
  Len := Length(Wide);

  { EXTN_PATTERN.find(): the LEFTMOST match wins, and Java gives up after that
    one - if the part in front of it is not viable, nothing is stripped. The
    scan walks CODE POINT boundaries like Matcher.find() does. }
  S := 1;
  while S <= Len do
  begin
    if TryMatchExtensionAt(Wide, S, Len, True, True, Ext, ExtEnd) then
    begin
      Prefix := string(Copy(Wide, 1, S - 1));
      if IsViablePhoneNumber(Prefix) then
      begin
        ANumber := Prefix;
        Result := Ext;
      end;
      Exit;
    end;
    Inc(S, CodePointLengthAt(Wide, S));
  end;
end;

{ ------------------------------------------------------------------
  RFC3966 phone-context handling.
  ------------------------------------------------------------------ }

const
  { Upstream RFC3966_PREFIX, RFC3966_PHONE_CONTEXT and
    RFC3966_ISDN_SUBADDRESS. All three are located with String.indexOf
    upstream, i.e. CASE SENSITIVELY, which is what Pos does here. }
  Rfc3966Prefix = 'tel:';
  Rfc3966PhoneContext = ';phone-context=';
  Rfc3966IsdnSubaddress = ';isub=';

function TryExtractPhoneContext(const ANumberToExtractFrom: string;
  out APhoneContext: string): Boolean;
var
  IndexOfPhoneContext, Start, EndPos, I: Integer;
begin
  APhoneContext := '';
  IndexOfPhoneContext := Pos(Rfc3966PhoneContext, ANumberToExtractFrom);
  if IndexOfPhoneContext = 0 then
  begin
    { Java returns null here, and isPhoneContextValid(null) is true. }
    Result := False;
    Exit;
  end;

  Result := True;
  Start := IndexOfPhoneContext + Length(Rfc3966PhoneContext);
  if Start > Length(ANumberToExtractFrom) then
    Exit;   { the parameter is present but empty }

  EndPos := 0;
  for I := Start to Length(ANumberToExtractFrom) do
    if ANumberToExtractFrom[I] = ';' then
    begin
      EndPos := I;
      Break;
    end;

  if EndPos > 0 then
    APhoneContext := Copy(ANumberToExtractFrom, Start, EndPos - Start)
  else
    APhoneContext := Copy(ANumberToExtractFrom, Start,
      Length(ANumberToExtractFrom) - Start + 1);
end;

{ RFC3966_VISUAL_SEPARATOR: an optional hyphen, full stop or parenthesis. }
function IsRfc3966VisualSeparator(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  Result := (Code = Ord('-')) or (Code = Ord('.'))
    or (Code = Ord('(')) or (Code = Ord(')'));
end;

{ RFC3966_GLOBAL_NUMBER_DIGITS, applied with matches().

  The upstream expression is an ASCII plus sign, then any number of
  RFC3966_PHONE_DIGIT, then one DIGITS, then any number of RFC3966_PHONE_DIGIT.
  RFC3966_PHONE_DIGIT is a group of "DIGITS or RFC3966_VISUAL_SEPARATOR" and
  the visual separator is itself OPTIONAL, so the group can match the empty
  string: the language the expression describes is simply "a plus sign followed
  by digits and visual separators, with at least one digit". }
function IsRfc3966GlobalNumberDigits(const AValue: string): Boolean;
var
  Wide: UnicodeString;
  I: Integer;
  SeenDigit: Boolean;
begin
  Result := False;
  Wide := UnicodeString(AValue);
  if (Length(Wide) < 2) or (Ord(Wide[1]) <> Ord('+')) then
    Exit;
  SeenDigit := False;
  I := 2;
  while I <= Length(Wide) do
  begin
    if IsUnicodeDecimalDigitAt(Wide, I) then
      SeenDigit := True
    else if not ((CodePointLengthAt(Wide, I) = 1)
      and IsRfc3966VisualSeparator(Wide[I])) then
      Exit;
    Inc(I, CodePointLengthAt(Wide, I));
  end;
  Result := SeenDigit;
end;

{ ALPHANUM = VALID_ALPHA + DIGITS, for the code point at AIndex. VALID_ALPHA
  is the ASCII letters, so a supplementary code point can only get in through
  DIGITS. }
function IsRfc3966AlphaNumAt(const AWide: UnicodeString;
  AIndex: Integer): Boolean;
begin
  Result := ((CodePointLengthAt(AWide, AIndex) = 1)
      and IsAsciiLetter(AWide[AIndex]))
    or IsUnicodeDecimalDigitAt(AWide, AIndex);
end;

{ RFC3966_DOMAINLABEL and RFC3966_TOPLABEL. Both describe a non empty string
  over ALPHANUM and the hyphen that ENDS in an ALPHANUM; the only difference is
  that a top label must START with a letter while a domain label may also start
  with a digit. }
function IsRfc3966Label(const AWide: UnicodeString; AFrom, ATo: Integer;
  ARequireAlphaStart: Boolean): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ATo < AFrom then
    Exit;
  if ARequireAlphaStart then
  begin
    if not ((CodePointLengthAt(AWide, AFrom) = 1)
      and IsAsciiLetter(AWide[AFrom])) then
      Exit;
  end
  else if not IsRfc3966AlphaNumAt(AWide, AFrom) then
    Exit;
  { The label must END in an ALPHANUM; ATo is the last code unit, so the code
    point that ends there starts one CodePointLengthBefore earlier. }
  if not IsRfc3966AlphaNumAt(AWide,
    ATo - CodePointLengthBefore(AWide, ATo) + 1) then
    Exit;
  I := AFrom;
  while I <= ATo do
  begin
    if not (IsRfc3966AlphaNumAt(AWide, I)
      or ((CodePointLengthAt(AWide, I) = 1) and (Ord(AWide[I]) = Ord('-')))) then
      Exit;
    Inc(I, CodePointLengthAt(AWide, I));
  end;
  Result := True;
end;

{ RFC3966_DOMAINNAME: any number of domain labels followed by a full stop, then
  a top label, then an optional trailing full stop. }
function IsRfc3966DomainName(const AValue: string): Boolean;
var
  Wide: UnicodeString;
  Len, I, Start: Integer;
begin
  Result := False;
  Wide := UnicodeString(AValue);
  Len := Length(Wide);
  if Len = 0 then
    Exit;

  if Ord(Wide[Len]) = Ord('.') then
  begin
    Dec(Len);
    if Len = 0 then
      Exit;
  end;

  Start := 1;
  for I := 1 to Len do
    if Ord(Wide[I]) = Ord('.') then
    begin
      if not IsRfc3966Label(Wide, Start, I - 1, False) then
        Exit;
      Start := I + 1;
    end;

  Result := IsRfc3966Label(Wide, Start, Len, True);
end;

function IsPhoneContextValid(const APhoneContext: string): Boolean;
begin
  { Java also answers true for a phone-context that is NOT PRESENT; that case
    is the False result of TryExtractPhoneContext and belongs to the caller. An
    empty value is invalid. }
  if APhoneContext = '' then
  begin
    Result := False;
    Exit;
  end;
  Result := IsRfc3966GlobalNumberDigits(APhoneContext)
    or IsRfc3966DomainName(APhoneContext);
end;

function TryBuildNationalNumberForParsing(const ANumberToParse: string;
  out ANationalNumber: string): Boolean;
var
  PhoneContext, Built: string;
  HasPhoneContext: Boolean;
  IndexOfPhoneContext, IndexOfRfc3966Prefix, IndexOfNationalNumber,
    IndexOfIsdn: Integer;
begin
  ANationalNumber := '';
  HasPhoneContext := TryExtractPhoneContext(ANumberToParse, PhoneContext);
  if HasPhoneContext and not IsPhoneContextValid(PhoneContext) then
  begin
    Result := False;
    Exit;
  end;

  if HasPhoneContext then
  begin
    IndexOfPhoneContext := Pos(Rfc3966PhoneContext, ANumberToParse);
    Built := '';
    { "If the phone context contains a phone number prefix, we need to capture
      it, whereas domains will be ignored." }
    if (PhoneContext <> '') and (PhoneContext[1] = '+') then
      Built := PhoneContext;
    { "Now append everything between the tel: prefix and the phone-context."
      Java also handles a missing prefix by starting at the beginning. }
    IndexOfRfc3966Prefix := Pos(Rfc3966Prefix, ANumberToParse);
    if IndexOfRfc3966Prefix > 0 then
      IndexOfNationalNumber := IndexOfRfc3966Prefix + Length(Rfc3966Prefix)
    else
      IndexOfNationalNumber := 1;
    { Deliberate difference in ONE degenerate case: when the tel: prefix sits
      BEHIND the phone-context, Java's substring() throws
      StringIndexOutOfBoundsException out of parse(); Copy with a negative
      count yields the empty string here instead of crashing the caller. }
    Built := Built + Copy(ANumberToParse, IndexOfNationalNumber,
      IndexOfPhoneContext - IndexOfNationalNumber);
  end
  else
    Built := ExtractPossibleNumber(ANumberToParse);

  { "Delete the isdn-subaddress and everything after it if it is present."
    Java tests indexOf > 0, i.e. an isdn-subaddress at the very beginning is
    NOT deleted; the 1 based equivalent of that is > 1. }
  IndexOfIsdn := Pos(Rfc3966IsdnSubaddress, Built);
  if IndexOfIsdn > 1 then
    Built := Copy(Built, 1, IndexOfIsdn - 1);

  ANationalNumber := Built;
  Result := True;
end;

initialization
  BuildExtnLabelTables;

end.
