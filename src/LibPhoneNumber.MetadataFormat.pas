unit LibPhoneNumber.MetadataFormat;

{
  Metadata driven format engine.

  Literal port of the formatting part of upstream
  com/google/i18n/phonenumbers/PhoneNumberUtil.java (Java is the source of
  truth; the C# port was used as a translation aid only). Ported methods:

    format(PhoneNumber, PhoneNumberFormat)      -> FormatNumber
    format(..., StringBuilder)                  -> FormatNumber (same body;
                                                    Delphi returns the string)
    formatNsn (both overloads)                  -> FormatNsn
    chooseFormattingPatternForNumber (both)     -> ChooseFormattingPatternForNumber
                                                   ChooseFormattingPatternForCallingCode
    formatNsnUsingPattern (both overloads)      -> FormatNsnUsingPattern
    prefixNumberWithCountryCallingCode          -> PrefixNumberWithCountryCallingCode
    maybeAppendFormattedExtension               -> MaybeAppendFormattedExtension

  Extended formatter API:

    formatOutOfCountryCallingNumber             -> FormatOutOfCountryCallingNumber
    formatNationalNumberWithCarrierCode         -> FormatNationalNumberWithCarrierCode
    formatByPattern                             -> FormatByPattern
    chooseFormattingPatternForNumber(userFormats)
                                                -> ChooseFormattingPatternForUserFormats
    SINGLE_INTERNATIONAL_PREFIX                 -> IsSingleInternationalPrefix

  Complete formatter API:

    formattingRuleHasFirstGroupOnly             -> FormattingRuleHasFirstGroupOnly
    canBeInternationallyDialled                 -> CanBeInternationallyDialled
    formatNumberForMobileDialing                -> FormatNumberForMobileDialing
    formatOutOfCountryKeepingAlphaChars         -> FormatOutOfCountryKeepingAlphaChars

  Added in the accessory API step:

    getLengthOfNationalDestinationCode          -> GetLengthOfNationalDestinationCode
    getLengthOfGeographicalAreaCode             -> GetLengthOfGeographicalAreaCode
    NON_DIGITS_PATTERN.split                    -> SplitOnNonDigits (private)

  The three normalizeHelper tables the formatters need - ALPHA_MAPPINGS,
  ALPHA_PHONE_MAPPINGS and ALL_PLUS_NUMBER_GROUPING_SYMBOLS - live in
  LibPhoneNumber.MetadataCore next to their siblings normalizeDigitsOnly
  and normalizeDiallableCharsOnly, because the parser needs the alpha table
  too (upstream normalize() converts a vanity number before it extracts the
  calling code).

  formatOutOfCountryKeepingAlphaChars uses the full upstream ports of
  maybeStripExtension and isViablePhoneNumber in LibPhoneNumber.MetadataCore,
  which is also where VALID_PUNCTUATION (IsValidPunctuation) lives: the parse
  path needs all three and cannot use this unit.

  formatNationalNumberWithPreferredCarrierCode and formatInOriginalFormat are
  NOT here: the first is a one line wrapper over the carrier code entry point
  and the second needs parse() and isValidNumber(), i.e. the parse driver, so
  both live on the facade in LibPhoneNumber.PhoneNumberUtil.

  Deliberate deviations from the Java source, all of them shape only (the same
  set LibPhoneNumber.MetadataCore documents):

  1. There is no PhoneNumber object. Every entry point takes the triple
     (ACountryCode, ANationalNumber, AExtension); ANationalNumber is the
     national SIGNIFICANT number as a digit string, i.e. what upstream
     getNationalSignificantNumber(number) returns, leading zeros included.
     The italianLeadingZero / numberOfLeadingZeros handling therefore lives in
     the parser, not here.
  2. Java grows a StringBuilder in place; this port returns strings and takes
     the two "insert/append into the buffer" helpers as var parameters, so the
     call order of the Java body is preserved one to one.
  3. Java throws on missing metadata; here the Try* accessors of
     LibPhoneNumber.Metadata report it as a Boolean. On the pinned
     baseline the path is unreachable because hasValidCountryCallingCode has
     already been checked, exactly like the upstream comment claims.
  4. The E164 early exit of the Java format() body is kept, so the engine is
     complete on its own; the public facade in LibPhoneNumber.PhoneNumberUtil keeps its
     own E164 implementation.

  Carrier codes
  -------------
  formatNsn/formatNsnUsingPattern carry the optional ACarrierCode parameter of
  the upstream signature and implement the $CC branch. Passing an empty string
  selects the nationalPrefix branch, which is exactly what Java does for a null
  carrierCode.

  Character scanning
  ------------------
  Two upstream character classes are ported as predicates rather than as
  compiled patterns (SEPARATOR_PATTERN, which now lives in
  LibPhoneNumber.MetadataCore as IsValidPunctuation, and the waiting tone
  part of SINGLE_INTERNATIONAL_PREFIX); see IsValidPunctuation for why. Both
  predicates and every scanner that uses them work on WideChar and
  UnicodeString, NOT on the native Char/string of the compiler.

  That is not cosmetic. On Delphi, Char is WideChar and string is
  UnicodeString, so the two spellings are the same type and nothing changes.
  On FreePascal in Delphi mode without the unicodestrings modeswitch, Char is a
  single BYTE: a case label above 255 is then unreachable, and scanning a
  string one Char at a time never sees a code point above U+00FF at all. Every
  non ASCII member of VALID_PUNCTUATION - and three of the four waiting tone
  characters - would silently stop being recognised. The generated metadata is
  ASCII only, so the metadata path alone could live with that, but formatByPattern takes format
  templates straight from the caller and those may contain any separator
  upstream accepts. The scanners therefore widen their input once and index it
  as UTF-16, which makes the non ASCII branches reachable on both compilers.

  User defined formats
  --------------------
  formatByPattern is handed formats that are NOT in the generated pools, so
  their leadingDigits patterns cannot be addressed by a pool offset. The public
  record TUserNumberFormatRec therefore carries exactly the five things a
  client can supply - Pattern, Format, LeadingDigits, NationalPrefixFormatting
  Rule, DomesticCarrierCodeFormattingRule - and nothing else. It deliberately
  does NOT embed the internal TNumberFormatRec: that record's
  LeadingDigitsOffset/LeadingDigitsCount pair addresses the GENERATED pool and
  is meaningless for a client format, so exposing it would invite callers to
  fill in a field that could only ever be wrong, and tie a public API to the storage
  layout of the generated tables. The conversion into a TNumberFormatRec for
  the format engine happens internally (ToNumberFormatRec).

  Client supplied PATTERNS are validated before use: unlike the generated ones
  they never passed the generator's compile gate, and TryMatchFull/
  TryMatchPrefix let a compile error of the underlying engine escape. Since
  the whole public surface of this port is documented as non throwing,
  ChooseFormattingPatternForUserFormats compiles Pattern and the leadingDigits
  of a candidate through TryCompilePattern first and simply does not consider a
  format whose patterns do not compile. FormatByPattern then falls back to its
  documented no-match behaviour and formats the number as a whole.

  What is NOT in this unit: formatInOriginalFormat (it lives on
  the facade) and the AsYouTypeFormatter, which is stateful and
  therefore has its own unit, LibPhoneNumber.AsYouTypeFormatter.
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
  { Upstream PhoneNumberUtil.PhoneNumberFormat, in upstream declaration order.

    Deliberately NOT the public TPhoneNumberFormat of
    LibPhoneNumber.Types: that enum carries the repository specific
    pnfInternationalLegacy display variant, which upstream does not know. The
    facade maps between the two. }
  TMetadataPhoneNumberFormat = (
    mpnfE164,
    mpnfInternational,
    mpnfNational,
    mpnfRfc3966
  );

  { A client supplied Phonemetadata.NumberFormat, as formatByPattern takes it.

    These five fields are everything upstream formatByPattern reads off a user
    defined NumberFormat, and everything a caller can meaningfully set:

      Pattern                            NumberFormat.pattern, matched against
                                         the whole national significant number
      Format                             NumberFormat.format, the replacement
                                         template with $1..$n
      LeadingDigits                      NumberFormat.leading_digits_pattern,
                                         of which only the LAST one is read
                                         (upstream: "the most detailed")
      NationalPrefixFormattingRule       may contain $NP and $FG, which
                                         FormatByPattern resolves
      DomesticCarrierCodeFormattingRule  may contain $CC and $FG

    Build one with MakeUserNumberFormat. The record is NOT the internal
    TNumberFormatRec of the generated tables and must not become it again: that
    one addresses the generated leadingDigits pool by offset, which a client
    format has no place in. See "User defined formats" in the unit header. }
  TUserNumberFormatRec = record
    Pattern: string;
    Format: string;
    LeadingDigits: TMetadataStringArray;
    NationalPrefixFormattingRule: string;
    DomesticCarrierCodeFormattingRule: string;
  end;
  TUserNumberFormatArray = array of TUserNumberFormatRec;

const
  { Upstream PhoneNumberUtil.RFC3966_EXTN_PREFIX / RFC3966_PREFIX /
    DEFAULT_EXTN_PREFIX. }
  Rfc3966ExtnPrefix = ';ext=';
  Rfc3966Prefix = 'tel:';
  DefaultExtnPrefix = ' ext. ';

  { Upstream PhoneNumberUtil.CC_STRING / NP_STRING / FG_STRING.

    $NP and $FG never occur in the GENERATED metadata: BuildMetadataFromXml
    already resolves them when it builds the tables (see
    getNationalPrefixFormattingRuleFromElement), so the stored rules contain
    the national prefix and $1 literally, and only $CC survives into the
    runtime. The two placeholders are needed anyway because formatByPattern
    receives its rules straight from the caller and therefore has to resolve
    them itself, which is exactly what the Java body does. }
  CcString = '$CC';
  NpString = '$NP';
  FgString = '$FG';

  { Upstream PhoneNumberUtil.FIRST_GROUP_PATTERN. Matches the FIRST group
    reference of a format template - not literally "$1", because some regions
    (Argentina) do not use group 1 in their national format. }
  FirstGroupPattern = '(\$\d)';

{ Upstream format(number, numberFormat): the complete formatting entry point.

  ANationalNumber is the national significant number as digits, AExtension the
  bare extension digits (empty when there is none). }
function FormatNumber(ACountryCode: Integer;
  const ANationalNumber, AExtension: string;
  AFormat: TMetadataPhoneNumberFormat): string;

{ Upstream formatNsn: formats the national significant number only, without
  calling code prefix and without extension. }
function FormatNsn(const ANumber: string; AMetadata: PPhoneMetadataRec;
  AFormat: TMetadataPhoneNumberFormat; const ACarrierCode: string): string;

{ Upstream chooseFormattingPatternForNumber(availableFormats, nationalNumber).

  AUseIntlFormats selects the intlNumberFormat list of the territory instead of
  its numberFormat list; that choice is made by formatNsn, mirroring the
  availableFormats expression of the Java body. }
function ChooseFormattingPatternForNumber(AMetadata: PPhoneMetadataRec;
  AUseIntlFormats: Boolean;
  const ANationalNumber: string): PNumberFormatRec;

{ Upstream chooseFormattingPatternForNumber(number): resolves the metadata for
  the calling code first and always searches the NATIONAL format list. }
function ChooseFormattingPatternForCallingCode(ACountryCode: Integer;
  const ANationalNumber: string): PNumberFormatRec;

{ Upstream formatNsnUsingPattern. ACarrierCode is optional; an empty string
  means "no carrier code", which is Java's null.

  AFormattingPattern = nil returns ANationalNumber unchanged. Upstream cannot
  be called with a null formattingPattern - every caller there has already
  chosen one - but the pointer is reachable from outside this unit (the matcher
  passes the result of ChooseFormattingPatternForCallingCode straight in), and
  a nil dereference is not an acceptable failure mode for a no-throw surface.
  "No pattern" therefore means the same as "no pattern matched" in formatNsn:
  the number is formatted as a whole. }
function FormatNsnUsingPattern(const ANationalNumber: string;
  AFormattingPattern: PNumberFormatRec;
  AFormat: TMetadataPhoneNumberFormat;
  const ACarrierCode: string): string;

{ Upstream prefixNumberWithCountryCallingCode. }
procedure PrefixNumberWithCountryCallingCode(ACountryCode: Integer;
  AFormat: TMetadataPhoneNumberFormat; var AFormattedNumber: string);

{ Upstream maybeAppendFormattedExtension. }
procedure MaybeAppendFormattedExtension(const AExtension: string;
  AMetadata: PPhoneMetadataRec; AFormat: TMetadataPhoneNumberFormat;
  var AFormattedNumber: string);

{ Upstream formatOutOfCountryCallingNumber(number, regionCallingFrom).

  ARegionCallingFrom must already be an upper case CLDR region code; an
  unsupported one falls back to the INTERNATIONAL format, which is what
  upstream does after logging a warning (it does not throw). }
function FormatOutOfCountryCallingNumber(ACountryCode: Integer;
  const ANationalNumber, AExtension, ARegionCallingFrom: string): string;

{ Upstream formatNationalNumberWithCarrierCode(number, carrierCode). An empty
  ACarrierCode is Java's empty string, i.e. "national format without any
  carrier code". }
function FormatNationalNumberWithCarrierCode(ACountryCode: Integer;
  const ANationalNumber, AExtension, ACarrierCode: string): string;

{ Upstream formatByPattern(number, numberFormat, userDefinedFormats).

  Does not raise, whatever AUserDefinedFormats contains. A format whose Pattern
  or leadingDigits do not compile as a regular expression is skipped instead of
  letting the engine's compile error escape; if no format is left that matches,
  the number is formatted as a whole, which is what upstream does when nothing
  matched. }
function FormatByPattern(ACountryCode: Integer;
  const ANationalNumber, AExtension: string;
  AFormat: TMetadataPhoneNumberFormat;
  const AUserDefinedFormats: TUserNumberFormatArray): string;

{ Upstream chooseFormattingPatternForNumber(availableFormats, nationalNumber)
  over a list of user defined formats. Returns the index of the first matching
  format or -1; an index keeps the caller free to copy the record before it
  rewrites the national prefix rule, which is what the Java body does with
  NumberFormat.Builder.mergeFrom.

  A format whose Pattern or leadingDigits do not compile is skipped, so this
  function does not raise on client input either. }
function ChooseFormattingPatternForUserFormats(
  const AUserDefinedFormats: TUserNumberFormatArray;
  const ANationalNumber: string): Integer;

{ Convenience constructor for TUserNumberFormatRec. }
function MakeUserNumberFormat(const APattern, AFormat: string;
  const ALeadingDigitsPatterns: array of string;
  const ANationalPrefixFormattingRule: string;
  const ADomesticCarrierCodeFormattingRule: string): TUserNumberFormatRec;

{ Upstream SINGLE_INTERNATIONAL_PREFIX applied with Matcher.matches().

  Ported as a scanner for the same reason IsValidPunctuation is a predicate:
  three of the four accepted waiting tone characters are non ASCII code points,
  and writing them into a pattern literal would make the source encoding load
  bearing on two compilers. The grammar is small enough to read off the regular
  expression - a run of ASCII digits, optionally followed by one waiting tone
  character and a second run of ASCII digits, and nothing else. }
function IsSingleInternationalPrefix(const AValue: string): Boolean;

{ Upstream formattingRuleHasFirstGroupOnly, i.e.

    rule.length() == 0 || FIRST_GROUP_ONLY_PREFIX_PATTERN.matches(rule)

  with FIRST_GROUP_ONLY_PREFIX_PATTERN = "\(?\$1\)?". Ported as a scanner
  because the grammar is four characters wide; the AsYouTypeFormatter is its
  only runtime caller (getAvailableFormats). }
function FormattingRuleHasFirstGroupOnly(
  const ANationalPrefixFormattingRule: string): Boolean;

{ Upstream canBeInternationallyDialled(number).

  "Returns true if the number can be dialled from outside the region, or
  unknown." A calling code without region metadata - the non geographical
  entities - is always internationally diallable and returns True here. }
function CanBeInternationallyDialled(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;

{ Upstream formatNumberForMobileDialing(number, regionCallingFrom,
  withFormatting).

  ARawInput and APreferredDomesticCarrierCode are the two PhoneNumber fields
  the Java body reads besides the calling code and the national number; both
  are only ever filled by ParseAndKeepRawInput, exactly like upstream.

  There is deliberately NO extension parameter, unlike every other entry point
  of this unit: the Java body clears the extension on its working copy before
  it formats ("that part cannot normally be dialled together with the main
  number"), so an extension could only ever be ignored here. }
function FormatNumberForMobileDialing(ACountryCode: Integer;
  const ANationalNumber, ARawInput, APreferredDomesticCarrierCode,
  ARegionCallingFrom: string; AWithFormatting: Boolean): string;

{ Upstream formatOutOfCountryKeepingAlphaChars(number, regionCallingFrom).

  ARawInput is TPhoneNumber.RawInput; an empty one means there are no alpha
  characters to keep and the call degrades to FormatOutOfCountryCallingNumber,
  exactly like upstream. }
function FormatOutOfCountryKeepingAlphaChars(ACountryCode: Integer;
  const ANationalNumber, AExtension, ARawInput,
  ARegionCallingFrom: string): string;

{ ------------------------------------------------------------------
  Accessory API (see "Accessory API" in docs/ARCHITECTURE.md). Both methods live
  here and not in LibPhoneNumber.MetadataCore because the national
  destination code is read off the INTERNATIONAL format, and MetadataCore
  cannot use this unit.

  ARawInput is TPhoneNumber.RawInput. Java formats through the PUBLIC
  format(number, INTERNATIONAL), whose raw input short circuit answers the raw
  input for a number whose national number is zero; that is the only thing the
  parameter is read for. Pass the empty string for a number without one.
  ------------------------------------------------------------------ }

{ Upstream getLengthOfNationalDestinationCode: the length of the first group
  after the calling code in the INTERNATIONAL format, provided a subscriber
  number group follows it; for a MOBILE number of a calling code with a mobile
  token (54 AR) the token group is counted as well. 0 when the format has no
  separate NDC group - including an unsupported calling code, for which
  format() returns the bare national significant number. }
function GetLengthOfNationalDestinationCode(ACountryCode: Integer;
  const ANationalNumber, ARawInput: string): Integer;

{ Upstream getLengthOfGeographicalAreaCode: 0 for a number without region
  metadata, for a closed dialling plan (no national prefix, no Italian leading
  zero, not one of COUNTRIES_WITHOUT_NATIONAL_PREFIX_WITH_AREA_CODES), for a
  mobile number of GEO_MOBILE_COUNTRIES_WITHOUT_MOBILE_AREA_CODES and for a
  number that is not geographical; otherwise the NDC length.

  Java reads number.isItalianLeadingZero(). This record carries the leading
  zeros as digits, so the flag is derived the way the parser sets it: the
  national significant number has at least two digits and starts with '0'.
  That is exactly what upstream parse() produces, and for a hand built Java
  number with italianLeadingZero = true the digits carry the zero as well.
  (The C# oracle spells the same flag HasNumberOfLeadingZeros; its parser sets
  NumberOfLeadingZeros to the count of leading zeros, i.e. non zero exactly
  when Java sets italianLeadingZero.) }
function GetLengthOfGeographicalAreaCode(ACountryCode: Integer;
  const ANationalNumber, ARawInput: string): Integer;

implementation

uses
{$IFDEF FPC}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.Regex;

{ VALID_PUNCTUATION / SEPARATOR_PATTERN live in
  LibPhoneNumber.MetadataCore: the parse path needs the
  same class (VALID_PHONE_NUMBER is built from it) and MetadataCore cannot use
  this unit. IsValidPunctuation is still reached from here through the uses
  clause below, and the reasoning why it is a WideChar predicate rather than a
  compiled pattern now lives next to it. }

{ The waiting tone characters of SINGLE_INTERNATIONAL_PREFIX: the ASCII tilde
  plus the three non ASCII tilde variants U+2053, U+223C and U+FF5E. WideChar
  and the Integer widening for exactly the same reason as in
  IsValidPunctuation - on FreePascal a Char parameter would make the three non
  ASCII variants unreachable. }
function IsWaitingToneChar(ACh: WideChar): Boolean;
var
  Code: Integer;
begin
  Code := Ord(ACh);
  Result := (Code = $007E)    { ~ }
    or (Code = $2053)         { swung dash }
    or (Code = $223C)         { tilde operator }
    or (Code = $FF5E);        { fullwidth tilde }
end;

function IsAsciiDigit(ACh: WideChar): Boolean;
begin
  Result := (ACh >= '0') and (ACh <= '9');
end;

function IsSingleInternationalPrefix(const AValue: string): Boolean;
var
  Wide: UnicodeString;
  I, Len, Start: Integer;
begin
  { Scanned as UTF-16 so the three non ASCII waiting tone characters stay
    reachable on FreePascal; on Delphi this assignment is the identity. }
  Wide := UnicodeString(AValue);
  Len := Length(Wide);
  I := 1;

  { The mandatory leading digit run. }
  Start := I;
  while (I <= Len) and IsAsciiDigit(Wide[I]) do
    Inc(I);
  if I = Start then
  begin
    Result := False;
    Exit;
  end;
  if I > Len then
  begin
    Result := True;
    Exit;
  end;

  { The optional group: once its waiting tone character is consumed the second
    digit run is mandatory and nothing may follow it. }
  if not IsWaitingToneChar(Wide[I]) then
  begin
    Result := False;
    Exit;
  end;
  Inc(I);
  Start := I;
  while (I <= Len) and IsAsciiDigit(Wide[I]) do
    Inc(I);
  Result := (I > Start) and (I > Len);
end;

{ SEPARATOR_PATTERN.matcher(x).lookingAt() followed by replaceFirst("") - drops
  a leading run of punctuation. }
function StripLeadingSeparators(const AValue: string): string;
var
  Wide: UnicodeString;
  I: Integer;
begin
  { UTF-16 for the same reason as IsSingleInternationalPrefix: a leading run of
    non ASCII punctuation must be stripped on FreePascal too. On Delphi both
    conversions are the identity. }
  Wide := UnicodeString(AValue);
  I := 1;
  while (I <= Length(Wide)) and IsValidPunctuation(Wide[I]) do
    Inc(I);
  if I = 1 then
    Result := AValue
  else
    Result := string(Copy(Wide, I, Length(Wide) - I + 1));
end;

{ SEPARATOR_PATTERN.matcher(x).replaceAll("-") - every remaining run of
  punctuation becomes a single dash. }
function ReplaceSeparatorsWithDash(const AValue: string): string;
var
  Wide, Built: UnicodeString;
  I, Len: Integer;
begin
  Wide := UnicodeString(AValue);
  Built := '';
  I := 1;
  Len := Length(Wide);
  while I <= Len do
  begin
    if IsValidPunctuation(Wide[I]) then
    begin
      Built := Built + '-';
      while (I <= Len) and IsValidPunctuation(Wide[I]) do
        Inc(I);
    end
    else
    begin
      Built := Built + Wide[I];
      Inc(I);
    end;
  end;
  Result := string(Built);
end;

{ Java String.replace(CharSequence, CharSequence): a literal replace of every
  occurrence, not a regular expression. }
function ReplaceLiteralAll(const AValue, ASearch, AReplacement: string): string;
var
  Position, Start: Integer;
begin
  if (ASearch = '') or (AValue = '') then
  begin
    Result := AValue;
    Exit;
  end;
  Result := '';
  Start := 1;
  repeat
    Position := Pos(ASearch, Copy(AValue, Start, Length(AValue) - Start + 1));
    if Position = 0 then
      Break;
    Position := Start + Position - 1;
    Result := Result + Copy(AValue, Start, Position - Start) + AReplacement;
    Start := Position + Length(ASearch);
  until Start > Length(AValue);
  Result := Result + Copy(AValue, Start, Length(AValue) - Start + 1);
end;

{ THE format selection predicate of upstream chooseFormattingPatternForNumber:

    (size == 0 || nationalNumber matches the LAST leading_digits_pattern)
    && the whole nationalNumber matches the format's pattern

  Both selection loops - the one over the generated formats of a territory and
  the one over the user defined formats of formatByPattern - are the same rule
  over two different storage layouts, so the rule itself lives here once. The
  caller resolves its own "last leadingDigits pattern"; an empty
  ALastLeadingDigitsPattern with ALeadingDigitsCount = 0 is the "no
  leadingDigits, candidate unconditionally" case. }
function FormatMatchesNationalNumber(ALeadingDigitsCount: Integer;
  const ALastLeadingDigitsPattern, APattern, ANationalNumber: string): Boolean;
begin
  Result := ((ALeadingDigitsCount = 0)
      or TryMatchPrefix(ALastLeadingDigitsPattern, ANationalNumber))
    and TryMatchFull(APattern, ANationalNumber);
end;

function ChooseFormattingPatternForNumber(AMetadata: PPhoneMetadataRec;
  AUseIntlFormats: Boolean;
  const ANationalNumber: string): PNumberFormatRec;
var
  I, Count, LeadingDigitsCount: Integer;
  NumFormat: PNumberFormatRec;
  LastLeadingDigits: string;
begin
  Result := nil;
  if AMetadata = nil then
    Exit;

  if AUseIntlFormats then
    Count := GetIntlNumberFormatCount(AMetadata)
  else
    Count := GetNumberFormatCount(AMetadata);

  for I := 0 to Count - 1 do
  begin
    if AUseIntlFormats then
      NumFormat := GetIntlNumberFormat(AMetadata, I)
    else
      NumFormat := GetNumberFormat(AMetadata, I);
    if NumFormat = nil then
      Continue;

    { "We always use the last leading_digits_pattern, as it is the most
      detailed." Read by index so the whole list never has to be materialised;
      see GetLeadingDigitsPattern. }
    LeadingDigitsCount := NumFormat^.LeadingDigitsCount;
    if LeadingDigitsCount > 0 then
      LastLeadingDigits := GetLeadingDigitsPattern(NumFormat,
        LeadingDigitsCount - 1)
    else
      LastLeadingDigits := '';

    if FormatMatchesNationalNumber(LeadingDigitsCount, LastLeadingDigits,
      NumFormat^.Pattern, ANationalNumber) then
    begin
      Result := NumFormat;
      Exit;
    end;
  end;
end;

function ChooseFormattingPatternForCallingCode(ACountryCode: Integer;
  const ANationalNumber: string): PNumberFormatRec;
var
  PhoneNumberRegion: string;
  Metadata: PPhoneMetadataRec;
begin
  Result := nil;
  PhoneNumberRegion :=
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, PhoneNumberRegion,
    Metadata) then
    Exit;
  Result := ChooseFormattingPatternForNumber(Metadata, False, ANationalNumber);
end;

function FormatNsnUsingPattern(const ANationalNumber: string;
  AFormattingPattern: PNumberFormatRec;
  AFormat: TMetadataPhoneNumberFormat;
  const ACarrierCode: string): string;
var
  NumberFormatRule: string;
  CarrierCodeFormattingRule: string;
  NationalPrefixFormattingRule: string;
  FormattedNationalNumber: string;
begin
  { See the declaration: no pattern is treated like no MATCHING pattern. }
  if AFormattingPattern = nil then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  NumberFormatRule := AFormattingPattern^.Format;

  if (AFormat = mpnfNational) and (ACarrierCode <> '')
    and (AFormattingPattern^.DomesticCarrierCodeFormattingRule <> '') then
  begin
    { Replace the $CC in the formatting rule with the desired carrier code. }
    CarrierCodeFormattingRule := ReplaceLiteralAll(
      AFormattingPattern^.DomesticCarrierCodeFormattingRule,
      CcString, ACarrierCode);
    { Now replace the $FG in the formatting rule with the first group and the
      carrier code combined in the appropriate way. Note that the $1 inside the
      carrier code rule is a BACKREFERENCE to the group reference that
      FirstGroupPattern just matched, so "0$CC $1" applied to "$2 15-$3-$4"
      yields "0<cc> $2 15-$3-$4". }
    NumberFormatRule := ReplaceFirst(FirstGroupPattern, NumberFormatRule,
      CarrierCodeFormattingRule);
    FormattedNationalNumber := ReplaceAll(AFormattingPattern^.Pattern,
      ANationalNumber, NumberFormatRule);
  end
  else
  begin
    { Use the national prefix formatting rule instead. }
    NationalPrefixFormattingRule := AFormattingPattern^.NationalPrefixFormattingRule;
    if (AFormat = mpnfNational) and (NationalPrefixFormattingRule <> '') then
      FormattedNationalNumber := ReplaceAll(AFormattingPattern^.Pattern,
        ANationalNumber,
        ReplaceFirst(FirstGroupPattern, NumberFormatRule,
          NationalPrefixFormattingRule))
    else
      FormattedNationalNumber := ReplaceAll(AFormattingPattern^.Pattern,
        ANationalNumber, NumberFormatRule);
  end;

  if AFormat = mpnfRfc3966 then
  begin
    { Strip any leading punctuation, then replace the rest with a dash between
      each number group. }
    FormattedNationalNumber := StripLeadingSeparators(FormattedNationalNumber);
    FormattedNationalNumber := ReplaceSeparatorsWithDash(FormattedNationalNumber);
  end;

  Result := FormattedNationalNumber;
end;

function FormatNsn(const ANumber: string; AMetadata: PPhoneMetadataRec;
  AFormat: TMetadataPhoneNumberFormat; const ACarrierCode: string): string;
var
  UseIntlFormats: Boolean;
  FormattingPattern: PNumberFormatRec;
begin
  { "When the intlNumberFormats exists, we use that to format national number
    for the INTERNATIONAL format instead of using the numberDesc
    .numberFormats." An empty intl list therefore falls back to the national
    formats, and NATIONAL always uses the national formats. RFC3966 shares the
    international selection, which is what makes tel: URIs carry no national
    prefix. }
  UseIntlFormats := (GetIntlNumberFormatCount(AMetadata) > 0)
    and (AFormat <> mpnfNational);
  FormattingPattern := ChooseFormattingPatternForNumber(AMetadata,
    UseIntlFormats, ANumber);
  if FormattingPattern = nil then
    Result := ANumber
  else
    Result := FormatNsnUsingPattern(ANumber, FormattingPattern, AFormat,
      ACarrierCode);
end;

procedure PrefixNumberWithCountryCallingCode(ACountryCode: Integer;
  AFormat: TMetadataPhoneNumberFormat; var AFormattedNumber: string);
begin
  case AFormat of
    mpnfE164:
      AFormattedNumber := '+' + IntToStr(ACountryCode) + AFormattedNumber;
    mpnfInternational:
      AFormattedNumber := '+' + IntToStr(ACountryCode) + ' ' + AFormattedNumber;
    mpnfRfc3966:
      AFormattedNumber := Rfc3966Prefix + '+' + IntToStr(ACountryCode) + '-'
        + AFormattedNumber;
  else
    { NATIONAL and the Java default branch: nothing to prefix. }
  end;
end;

procedure MaybeAppendFormattedExtension(const AExtension: string;
  AMetadata: PPhoneMetadataRec; AFormat: TMetadataPhoneNumberFormat;
  var AFormattedNumber: string);
begin
  if AExtension = '' then
    Exit;

  if AFormat = mpnfRfc3966 then
  begin
    AFormattedNumber := AFormattedNumber + Rfc3966ExtnPrefix + AExtension;
    Exit;
  end;

  { Java's metadata.hasPreferredExtnPrefix(); the generator stores an absent
    attribute as an empty string. }
  if (AMetadata <> nil) and (AMetadata^.PreferredExtnPrefix <> '') then
    AFormattedNumber := AFormattedNumber + AMetadata^.PreferredExtnPrefix
      + AExtension
  else
    AFormattedNumber := AFormattedNumber + DefaultExtnPrefix + AExtension;
end;

function FormatNumber(ACountryCode: Integer;
  const ANationalNumber, AExtension: string;
  AFormat: TMetadataPhoneNumberFormat): string;
var
  RegionCode: string;
  Metadata: PPhoneMetadataRec;
begin
  if AFormat = mpnfE164 then
  begin
    { Early exit for E164 (even if the country calling code is invalid) since
      no formatting of the national number needs to be applied. Extensions are
      not formatted. }
    Result := ANationalNumber;
    PrefixNumberWithCountryCallingCode(ACountryCode, mpnfE164, Result);
    Exit;
  end;

  { Upstream hasValidCountryCallingCode. }
  if not IsSupportedCallingCode(ACountryCode) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  { getRegionCodeForCountryCode is used because formatting information for
    regions which share a country calling code is contained by only one region
    - for the NANPA regions it lives in the metadata for US. }
  RegionCode :=
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  { Java states the metadata cannot be null here because the calling code is
    valid; the Boolean guard keeps the port total anyway. }
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, RegionCode,
    Metadata) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  Result := FormatNsn(ANationalNumber, Metadata, AFormat, '');
  MaybeAppendFormattedExtension(AExtension, Metadata, AFormat, Result);
  PrefixNumberWithCountryCallingCode(ACountryCode, AFormat, Result);
end;

function FormatNationalNumberWithCarrierCode(ACountryCode: Integer;
  const ANationalNumber, AExtension, ACarrierCode: string): string;
var
  RegionCode: string;
  Metadata: PPhoneMetadataRec;
begin
  { Upstream hasValidCountryCallingCode. }
  if not IsSupportedCallingCode(ACountryCode) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  RegionCode :=
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  { Metadata cannot be null because the country calling code is valid. }
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, RegionCode,
    Metadata) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  Result := FormatNsn(ANationalNumber, Metadata, mpnfNational, ACarrierCode);
  MaybeAppendFormattedExtension(AExtension, Metadata, mpnfNational, Result);
  PrefixNumberWithCountryCallingCode(ACountryCode, mpnfNational, Result);
end;

function FormatOutOfCountryCallingNumber(ACountryCode: Integer;
  const ANationalNumber, AExtension, ARegionCallingFrom: string): string;
var
  MetadataForRegionCallingFrom: PPhoneMetadataRec;
  MetadataForRegion: PPhoneMetadataRec;
  InternationalPrefix: string;
  InternationalPrefixForFormatting: string;
  RegionCode: string;
begin
  { Upstream isValidRegionCode. The non geographical entity '001' is NOT a
    supported region, so "calling from 001" lands here as well. Java logs a
    warning and falls back to INTERNATIONAL; this port only does the latter. }
  if not IsSupportedRegion(ARegionCallingFrom) then
  begin
    Result := FormatNumber(ACountryCode, ANationalNumber, AExtension,
      mpnfInternational);
    Exit;
  end;

  { Upstream hasValidCountryCallingCode. }
  if not IsSupportedCallingCode(ACountryCode) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  if ACountryCode = NanpaCountryCode then
  begin
    if IsNanpaCountry(ARegionCallingFrom) then
    begin
      { "For NANPA regions, return the national format for these regions but
        prefix it with the country calling code." }
      Result := IntToStr(ACountryCode) + ' '
        + FormatNumber(ACountryCode, ANationalNumber, AExtension, mpnfNational);
      Exit;
    end;
  end
  else if ACountryCode = GetCountryCodeForRegion(ARegionCallingFrom) then
  begin
    { "If regions share a country calling code, the country calling code need
      not be dialled. This also applies when dialling within a region." }
    Result := FormatNumber(ACountryCode, ANationalNumber, AExtension,
      mpnfNational);
    Exit;
  end;

  { Metadata cannot be null because isValidRegionCode() was checked above. }
  if not TryGetMetadataForRegion(ARegionCallingFrom,
    MetadataForRegionCallingFrom) then
  begin
    Result := FormatNumber(ACountryCode, ANationalNumber, AExtension,
      mpnfInternational);
    Exit;
  end;
  InternationalPrefix := MetadataForRegionCallingFrom^.InternationalPrefix;

  { "In general, if there is a preferred international prefix, use that.
    Otherwise, for regions that have multiple international prefixes, the
    international format of the number is returned since we would not know
    which one to use." }
  InternationalPrefixForFormatting := '';
  if MetadataForRegionCallingFrom^.PreferredInternationalPrefix <> '' then
    InternationalPrefixForFormatting :=
      MetadataForRegionCallingFrom^.PreferredInternationalPrefix
  else if IsSingleInternationalPrefix(InternationalPrefix) then
    InternationalPrefixForFormatting := InternationalPrefix;

  RegionCode :=
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  { Metadata cannot be null because the country calling code is valid. }
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, RegionCode,
    MetadataForRegion) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  Result := FormatNsn(ANationalNumber, MetadataForRegion, mpnfInternational, '');
  MaybeAppendFormattedExtension(AExtension, MetadataForRegion,
    mpnfInternational, Result);
  if InternationalPrefixForFormatting <> '' then
    Result := InternationalPrefixForFormatting + ' ' + IntToStr(ACountryCode)
      + ' ' + Result
  else
    PrefixNumberWithCountryCallingCode(ACountryCode, mpnfInternational, Result);
end;

function MakeUserNumberFormat(const APattern, AFormat: string;
  const ALeadingDigitsPatterns: array of string;
  const ANationalPrefixFormattingRule: string;
  const ADomesticCarrierCodeFormattingRule: string): TUserNumberFormatRec;
var
  I: Integer;
begin
  Result.Pattern := APattern;
  Result.Format := AFormat;
  Result.NationalPrefixFormattingRule := ANationalPrefixFormattingRule;
  Result.DomesticCarrierCodeFormattingRule :=
    ADomesticCarrierCodeFormattingRule;
  SetLength(Result.LeadingDigits, Length(ALeadingDigitsPatterns));
  for I := 0 to Length(ALeadingDigitsPatterns) - 1 do
    Result.LeadingDigits[I] := ALeadingDigitsPatterns[I];
end;

{ The internal shape the format engine works on. LeadingDigitsOffset/Count stay
  zero: a client format has no entry in the generated leadingDigits pool, and
  FormatNsnUsingPattern never reads them - only chooseFormattingPattern* does,
  and for user formats that is ChooseFormattingPatternForUserFormats, which
  reads the local array instead. }
function ToNumberFormatRec(
  const AUserFormat: TUserNumberFormatRec): TNumberFormatRec;
begin
  Result.Pattern := AUserFormat.Pattern;
  Result.Format := AUserFormat.Format;
  Result.LeadingDigitsOffset := 0;
  Result.LeadingDigitsCount := 0;
  Result.NationalPrefixFormattingRule :=
    AUserFormat.NationalPrefixFormattingRule;
  Result.NationalPrefixOptionalWhenFormatting := False;
  Result.DomesticCarrierCodeFormattingRule :=
    AUserFormat.DomesticCarrierCodeFormattingRule;
  Result.IntlFormatKind := ifkInheritedFromNational;
  Result.IntlFormat := '';
end;

{ Every pattern of a client supplied format must compile before it is matched.

  The generated patterns went through the generator's compile gate; these did
  not, and TryMatchFull/TryMatchPrefix would let the engine's compile error
  escape through a public API that is documented as non throwing. An empty
  Pattern counts as non compilable, which is the same outcome it had before:
  TryMatchFull refuses an empty pattern, so such a format never matched
  anyway. }
function UserFormatPatternsCompile(
  const AUserFormat: TUserNumberFormatRec): Boolean;
var
  I: Integer;
  CompileError: string;
begin
  Result := False;
  if not TryCompilePattern(AUserFormat.Pattern, CompileError) then
    Exit;
  for I := 0 to Length(AUserFormat.LeadingDigits) - 1 do
    if not TryCompilePattern(AUserFormat.LeadingDigits[I], CompileError) then
      Exit;
  Result := True;
end;

function ChooseFormattingPatternForUserFormats(
  const AUserDefinedFormats: TUserNumberFormatArray;
  const ANationalNumber: string): Integer;
var
  I, LeadingDigitsCount: Integer;
  LastLeadingDigits: string;
begin
  Result := -1;
  for I := 0 to Length(AUserDefinedFormats) - 1 do
  begin
    { A format whose patterns do not compile is not a candidate. See
      UserFormatPatternsCompile and "User defined formats" in the unit header. }
    if not UserFormatPatternsCompile(AUserDefinedFormats[I]) then
      Continue;

    { Same rule as the generated formats, over the local array instead of the
      pool. }
    LeadingDigitsCount := Length(AUserDefinedFormats[I].LeadingDigits);
    if LeadingDigitsCount > 0 then
      LastLeadingDigits :=
        AUserDefinedFormats[I].LeadingDigits[LeadingDigitsCount - 1]
    else
      LastLeadingDigits := '';

    if FormatMatchesNationalNumber(LeadingDigitsCount, LastLeadingDigits,
      AUserDefinedFormats[I].Pattern, ANationalNumber) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function FormatByPattern(ACountryCode: Integer;
  const ANationalNumber, AExtension: string;
  AFormat: TMetadataPhoneNumberFormat;
  const AUserDefinedFormats: TUserNumberFormatArray): string;
var
  RegionCode: string;
  Metadata: PPhoneMetadataRec;
  PatternIndex: Integer;
  NumFormatCopy: TNumberFormatRec;
  NationalPrefixFormattingRule: string;
  NationalPrefix: string;
begin
  { Upstream hasValidCountryCallingCode. }
  if not IsSupportedCallingCode(ACountryCode) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  RegionCode :=
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  { Metadata cannot be null because the country calling code is valid. }
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, RegionCode,
    Metadata) then
  begin
    Result := ANationalNumber;
    Exit;
  end;

  PatternIndex := ChooseFormattingPatternForUserFormats(AUserDefinedFormats,
    ANationalNumber);
  if PatternIndex < 0 then
    { "If no pattern above is matched, we format the number as a whole." }
    Result := ANationalNumber
  else
  begin
    { Java copies the NumberFormat before it rewrites $NP, "so that subsequent
      replacements for different numbers have the appropriate national
      prefix". A Delphi record assignment is that copy. }
    NumFormatCopy := ToNumberFormatRec(AUserDefinedFormats[PatternIndex]);
    NationalPrefixFormattingRule := NumFormatCopy.NationalPrefixFormattingRule;
    if NationalPrefixFormattingRule <> '' then
    begin
      NationalPrefix := Metadata^.NationalPrefix;
      if NationalPrefix <> '' then
      begin
        NationalPrefixFormattingRule := ReplaceLiteralAll(
          NationalPrefixFormattingRule, NpString, NationalPrefix);
        NationalPrefixFormattingRule := ReplaceLiteralAll(
          NationalPrefixFormattingRule, FgString, '$1');
        NumFormatCopy.NationalPrefixFormattingRule :=
          NationalPrefixFormattingRule;
      end
      else
        { "We don't want to have a rule for how to format the national prefix
          if there isn't one." }
        NumFormatCopy.NationalPrefixFormattingRule := '';
    end;
    Result := FormatNsnUsingPattern(ANationalNumber, @NumFormatCopy, AFormat,
      '');
  end;

  MaybeAppendFormattedExtension(AExtension, Metadata, AFormat, Result);
  PrefixNumberWithCountryCallingCode(ACountryCode, AFormat, Result);
end;

{ ---------------------------------------------------------------------------
  formatNumberForMobileDialing and
  formatOutOfCountryKeepingAlphaChars
  --------------------------------------------------------------------------- }

function FormattingRuleHasFirstGroupOnly(
  const ANationalPrefixFormattingRule: string): Boolean;
var
  Rule: string;
begin
  { FIRST_GROUP_ONLY_PREFIX_PATTERN is "\(?\$1\)?" applied with matches(): an
    optional opening parenthesis, "$1", an optional closing parenthesis, and
    nothing else. }
  Rule := ANationalPrefixFormattingRule;
  if Rule = '' then
  begin
    Result := True;
    Exit;
  end;
  if (Length(Rule) > 0) and (Rule[1] = '(') then
    Rule := Copy(Rule, 2, Length(Rule) - 1);
  if (Length(Rule) > 0) and (Rule[Length(Rule)] = ')') then
    Rule := Copy(Rule, 1, Length(Rule) - 1);
  Result := Rule = '$1';
end;

function CanBeInternationallyDialled(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
var
  RegionCode: string;
  Metadata: PPhoneMetadataRec;
begin
  RegionCode := LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(
    ACountryCode, ANationalNumber);
  if not TryGetMetadataForRegion(RegionCode, Metadata) then
  begin
    { "Note numbers belonging to non-geographical entities (e.g. +800 numbers)
      are always internationally diallable, and will be caught here." }
    Result := True;
    Exit;
  end;
  Result := not IsNumberMatchingDesc(ANationalNumber,
    GetDesc(Metadata, pdkNoInternationalDialling));
end;

function FormatNumberForMobileDialing(ACountryCode: Integer;
  const ANationalNumber, ARawInput, APreferredDomesticCarrierCode,
  ARegionCallingFrom: string; AWithFormatting: Boolean): string;
var
  FormattedNumber: string;
  RegionCode: string;
  NumberType: TMetadataNumberType;
  IsValid, IsFixedLineOrMobile: Boolean;
  RegionMetadata: PPhoneMetadataRec;
begin
  { Upstream hasValidCountryCallingCode. }
  if not IsSupportedCallingCode(ACountryCode) then
  begin
    Result := ARawInput;
    Exit;
  end;

  FormattedNumber := '';
  { "Clear the extension, as that part cannot normally be dialed together with
    the main number." Every format call below therefore passes an empty
    extension. }
  RegionCode :=
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  NumberType := LibPhoneNumber.MetadataCore.GetNumberType(ACountryCode,
    ANationalNumber);
  IsValid := NumberType <> mntUnknown;

  if ARegionCallingFrom = RegionCode then
  begin
    IsFixedLineOrMobile := (NumberType = mntFixedLine)
      or (NumberType = mntMobile) or (NumberType = mntFixedLineOrMobile);
    { Carrier codes may be needed in some countries. }
    if (RegionCode = 'BR') and IsFixedLineOrMobile then
    begin
      { "Historically, we set this to an empty string when parsing with raw
        input if none was found in the input string. However, this doesn't
        result in a number we can dial." Brazilian fixed line and mobile
        numbers need a carrier code when called within Brazil, so without one
        upstream returns the empty string. }
      if APreferredDomesticCarrierCode <> '' then
        FormattedNumber := FormatNationalNumberWithCarrierCode(ACountryCode,
          ANationalNumber, '', APreferredDomesticCarrierCode)
      else
        FormattedNumber := '';
    end
    else if ACountryCode = NanpaCountryCode then
    begin
      { "For NANPA countries, we output international format for numbers that
        can be dialed internationally, since that always works, except for
        numbers which might potentially be short numbers, which are always
        dialled in national format." }
      if not TryGetMetadataForRegion(ARegionCallingFrom, RegionMetadata) then
        RegionMetadata := nil;
      if CanBeInternationallyDialled(ACountryCode, ANationalNumber)
        and (RegionMetadata <> nil)
        and (TestNumberLength(ANationalNumber, RegionMetadata) <> mvrTooShort) then
        FormattedNumber := FormatNumber(ACountryCode, ANationalNumber, '',
          mpnfInternational)
      else
        FormattedNumber := FormatNumber(ACountryCode, ANationalNumber, '',
          mpnfNational);
    end
    else
    begin
      { "For non-geographical countries, and Mexican, Chilean, and Uzbek fixed
        line and mobile numbers, we output international format for numbers
        that can be dialed internationally as that always works." }
      if ((RegionCode = NonGeoRegionCode)
        or (((RegionCode = 'MX') or (RegionCode = 'CL') or (RegionCode = 'UZ'))
          and IsFixedLineOrMobile))
        and CanBeInternationallyDialled(ACountryCode, ANationalNumber) then
        FormattedNumber := FormatNumber(ACountryCode, ANationalNumber, '',
          mpnfInternational)
      else
        FormattedNumber := FormatNumber(ACountryCode, ANationalNumber, '',
          mpnfNational);
    end;
  end
  else if IsValid and CanBeInternationallyDialled(ACountryCode,
    ANationalNumber) then
  begin
    { "We assume that short numbers are not diallable from outside their
      region, so if a number is not a valid regular length phone number, we
      treat it as if it cannot be internationally dialled." }
    if AWithFormatting then
      Result := FormatNumber(ACountryCode, ANationalNumber, '',
        mpnfInternational)
    else
      Result := FormatNumber(ACountryCode, ANationalNumber, '', mpnfE164);
    Exit;
  end;

  if AWithFormatting then
    Result := FormattedNumber
  else
    Result := NormalizeDiallableCharsOnly(FormattedNumber);
end;

function FormatOutOfCountryKeepingAlphaChars(ACountryCode: Integer;
  const ANationalNumber, AExtension, ARawInput,
  ARegionCallingFrom: string): string;
var
  RawInput: string;
  FirstNationalNumberDigit: Integer;
  MetadataForRegionCallingFrom: PPhoneMetadataRec;
  MetadataForRegion: PPhoneMetadataRec;
  FormattingPattern: PNumberFormatRec;
  NewFormat: TNumberFormatRec;
  InternationalPrefix, InternationalPrefixForFormatting: string;
  RegionCode: string;
  FormattedNumber: string;
begin
  { "If there is no raw input, then we can't keep alpha characters because
    there aren't any." }
  if ARawInput = '' then
  begin
    Result := FormatOutOfCountryCallingNumber(ACountryCode, ANationalNumber,
      AExtension, ARegionCallingFrom);
    Exit;
  end;

  { Upstream hasValidCountryCallingCode. }
  if not IsSupportedCallingCode(ACountryCode) then
  begin
    Result := ARawInput;
    Exit;
  end;

  { "Strip any prefix such as country calling code, IDD, that was present. We
    do this by comparing the number in raw_input with the parsed number. To do
    this, first we normalize punctuation. We retain number grouping symbols
    such as ' ' only." }
  RawInput := LibPhoneNumber.MetadataCore
    .NormalizeAllPlusNumberGroupingSymbols(ARawInput);

  { "Now we trim everything before the first three digits in the parsed number.
    We choose three because all valid alpha numbers have 3 digits at the start
    - if it does not, then we don't trim anything at all." }
  if Length(ANationalNumber) > 3 then
  begin
    FirstNationalNumberDigit := Pos(Copy(ANationalNumber, 1, 3), RawInput);
    if FirstNationalNumberDigit > 0 then
      RawInput := Copy(RawInput, FirstNationalNumberDigit,
        Length(RawInput) - FirstNationalNumberDigit + 1);
  end;

  if not TryGetMetadataForRegion(ARegionCallingFrom,
    MetadataForRegionCallingFrom) then
    MetadataForRegionCallingFrom := nil;

  if ACountryCode = NanpaCountryCode then
  begin
    if IsNanpaCountry(ARegionCallingFrom) then
    begin
      Result := IntToStr(ACountryCode) + ' ' + RawInput;
      Exit;
    end;
  end
  else if (MetadataForRegionCallingFrom <> nil)
    and (ACountryCode = GetCountryCodeForRegion(ARegionCallingFrom)) then
  begin
    FormattingPattern := ChooseFormattingPatternForNumber(
      MetadataForRegionCallingFrom, False, ANationalNumber);
    if FormattingPattern = nil then
    begin
      { "If no pattern above is matched, we format the original input." }
      Result := RawInput;
      Exit;
    end;
    { Java copies the NumberFormat and overrides its pattern and format: "The
      first group is the first group of digits that the user wrote together",
      and the two groups are simply concatenated back together after the
      national prefix has been fixed. }
    NewFormat := FormattingPattern^;
    NewFormat.Pattern := '(\d+)(.*)';
    NewFormat.Format := '$1$2';
    Result := FormatNsnUsingPattern(RawInput, @NewFormat, mpnfNational, '');
    Exit;
  end;

  InternationalPrefixForFormatting := '';
  { Note the order is the REVERSE of formatOutOfCountryCallingNumber: here a
    single international prefix wins and the preferred one is the fallback. }
  if MetadataForRegionCallingFrom <> nil then
  begin
    InternationalPrefix := MetadataForRegionCallingFrom^.InternationalPrefix;
    if IsSingleInternationalPrefix(InternationalPrefix) then
      InternationalPrefixForFormatting := InternationalPrefix
    else
      InternationalPrefixForFormatting :=
        MetadataForRegionCallingFrom^.PreferredInternationalPrefix;
  end;

  FormattedNumber := RawInput;
  RegionCode :=
    LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  { Metadata cannot be null because the country calling code is valid. }
  if not TryGetMetadataForRegionOrCallingCode(ACountryCode, RegionCode,
    MetadataForRegion) then
    MetadataForRegion := nil;

  { "Strip any extension." This is the FULL upstream
    maybeStripExtension of LibPhoneNumber.MetadataCore, including its
    isViablePhoneNumber() guard. }
  MaybeStripExtension(FormattedNumber);
  MaybeAppendFormattedExtension(AExtension, MetadataForRegion,
    mpnfInternational, FormattedNumber);

  if InternationalPrefixForFormatting <> '' then
    FormattedNumber := InternationalPrefixForFormatting + ' '
      + IntToStr(ACountryCode) + ' ' + FormattedNumber
  else
    { "Invalid region entered as country-calling-from (so no metadata was found
      for it) or the region chosen has multiple international dialling
      prefixes." Java additionally logs a warning; this port only formats. }
    PrefixNumberWithCountryCallingCode(ACountryCode, mpnfInternational,
      FormattedNumber);

  Result := FormattedNumber;
end;

{ ------------------------------------------------------------------
  Accessory API: area code and national destination code lengths.
  ------------------------------------------------------------------ }

{ Upstream "number.getNationalNumber() == 0": the digit string is empty or
  consists of zeros only (the leading zeros of the record are Java's
  italianLeadingZero / numberOfLeadingZeros, which do not change the numeric
  field). The facade has the same test as NationalNumberIsZero. }
function NationalNumberIsZero(const ANationalNumber: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(ANationalNumber) do
    if ANationalNumber[I] <> '0' then
    begin
      Result := False;
      Exit;
    end;
end;

{ What the PUBLIC upstream format(number, INTERNATIONAL) returns for a number
  without an extension: the raw input short circuit at its head (only its
  second branch can fire, the first one is E164 only), then the engine. }
function FormatInternationalWithoutExtension(ACountryCode: Integer;
  const ANationalNumber, ARawInput: string): string;
begin
  if NationalNumberIsZero(ANationalNumber)
    and ((ARawInput <> '') or (ACountryCode = 0)) then
  begin
    Result := ARawInput;
    Exit;
  end;
  Result := FormatNumber(ACountryCode, ANationalNumber, '', mpnfInternational);
end;

{ Upstream NON_DIGITS_PATTERN.split(value), i.e. String.split over the
  pattern "\D+" (ASCII digits only, Java runs it without
  UNICODE_CHARACTER_CLASS). Only what the caller reads is produced: the number
  of groups and the lengths of the groups at index 2 and 3.

  String.split semantics, all three of them observable here: a leading
  separator run yields a leading EMPTY group, trailing empty groups are
  removed, and an input without any separator is one group (itself, even
  when it is empty). Every byte that is not an ASCII digit is a separator, so
  scanning a UTF-8 AnsiString on FreePascal counts the same groups and the
  same group lengths as scanning UTF-16 on Delphi. }
procedure SplitOnNonDigits(const AValue: string; out AGroupCount,
  AGroup2Length, AGroup3Length: Integer);
var
  Lengths: array of Integer;
  I, Count, Current: Integer;
  InDigits, SawSeparator: Boolean;
begin
  SetLength(Lengths, Length(AValue) + 2);
  Count := 0;
  Current := 0;
  InDigits := False;
  SawSeparator := False;
  for I := 1 to Length(AValue) do
    if (AValue[I] >= '0') and (AValue[I] <= '9') then
    begin
      Inc(Current);
      InDigits := True;
    end
    else
    begin
      { Start of a separator run: the group in front of it is complete. A run
        of several separators is ONE match of "\D+". }
      if InDigits or (I = 1) then
      begin
        Lengths[Count] := Current;
        Inc(Count);
        Current := 0;
      end;
      InDigits := False;
      SawSeparator := True;
    end;

  if not SawSeparator then
  begin
    AGroupCount := 1;
    AGroup2Length := 0;
    AGroup3Length := 0;
    Exit;
  end;

  { The group behind the last separator run (empty when the value ends with a
    separator). }
  Lengths[Count] := Current;
  Inc(Count);

  { "Trailing empty strings are not included in the resulting array." }
  while (Count > 0) and (Lengths[Count - 1] = 0) do
    Dec(Count);

  AGroupCount := Count;
  AGroup2Length := 0;
  AGroup3Length := 0;
  if Count > 2 then
    AGroup2Length := Lengths[2];
  if Count > 3 then
    AGroup3Length := Lengths[3];
end;

function GetLengthOfNationalDestinationCode(ACountryCode: Integer;
  const ANationalNumber, ARawInput: string): Integer;
var
  GroupCount, Group2Length, Group3Length: Integer;
begin
  { Java clears the extension on a copy before it formats; there is no
    extension parameter to clear here. }
  SplitOnNonDigits(FormatInternationalWithoutExtension(ACountryCode,
    ANationalNumber, ARawInput), GroupCount, Group2Length, Group3Length);

  { "The pattern will start with "+COUNTRY_CODE " so the first group will
    always be the empty string (before the + symbol) and the second group will
    be the country calling code. The third group will be area code if it is
    not the last group." }
  if GroupCount <= 3 then
  begin
    Result := 0;
    Exit;
  end;

  if GetNumberType(ACountryCode, ANationalNumber) = mntMobile then
    { "For example Argentinian mobile numbers, when formatted in the
      international format, are in the form of +54 9 NDC XXXX.... As a result,
      we take the length of the third group (NDC) and add the length of the
      second group (which is the mobile token), which also forms part of the
      national significant number." }
    if GetCountryMobileToken(ACountryCode) <> '' then
    begin
      Result := Group2Length + Group3Length;
      Exit;
    end;

  Result := Group2Length;
end;

function GetLengthOfGeographicalAreaCode(ACountryCode: Integer;
  const ANationalNumber, ARawInput: string): Integer;
var
  Metadata: PPhoneMetadataRec;
  NumberType: TMetadataNumberType;
  ItalianLeadingZero: Boolean;
begin
  Result := 0;
  { getMetadataForRegion(getRegionCodeForNumber(number)): no region, the
    unknown region and the non geographical "001" all have no region
    metadata. }
  if not TryGetMetadataForRegion(
    LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(ACountryCode,
      ANationalNumber), Metadata) then
    Exit;

  NumberType := GetNumberType(ACountryCode, ANationalNumber);

  { number.isItalianLeadingZero(), derived from the digits the way
    setItalianLeadingZerosForPhoneNumber sets it. }
  ItalianLeadingZero := (Length(ANationalNumber) > 1)
    and (ANationalNumber[1] = '0');

  { "If a country doesn't use a national prefix, and this number doesn't have
    an Italian leading zero, we assume it is a closed dialling plan with no
    area codes." - with the exceptions of
    COUNTRIES_WITHOUT_NATIONAL_PREFIX_WITH_AREA_CODES. }
  if (Metadata^.NationalPrefix = '') and not ItalianLeadingZero
    and not IsCountryWithoutNationalPrefixWithAreaCodes(ACountryCode) then
    Exit;

  { "Note this is a rough heuristic; it doesn't cover Indonesia well." }
  if (NumberType = mntMobile)
    and IsGeoMobileCountryWithoutMobileAreaCodes(ACountryCode) then
    Exit;

  if not IsNumberGeographical(NumberType, ACountryCode) then
    Exit;

  Result := GetLengthOfNationalDestinationCode(ACountryCode, ANationalNumber,
    ARawInput);
end;

end.
