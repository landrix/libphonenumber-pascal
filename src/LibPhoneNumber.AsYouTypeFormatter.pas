unit LibPhoneNumber.AsYouTypeFormatter;

{
  Literal port of
  vendor/libphonenumber/java/libphonenumber/src/com/google/i18n/phonenumbers/
  AsYouTypeFormatter.java. The C# port was used as a
  translation aid only; where the two differ, Java wins.

  Ported members, in upstream order: getMetadataForRegion,
  maybeCreateNewTemplate, getAvailableFormats, narrowDownPossibleFormats,
  createFormattingTemplate, getFormattingTemplate, clear, inputDigit,
  inputDigitAndRememberPosition, inputDigitWithOptionToRememberPosition,
  attemptToChoosePatternWithPrefixExtracted, getExtractedNationalPrefix,
  ableToExtractLongerNdd, isDigitOrLeadingPlusSign,
  attemptToFormatAccruedDigits, getRememberedPosition, appendNationalNumber,
  attemptToChooseFormattingPattern, inputAccruedNationalNumber,
  isNanpaNumberWithNationalPrefix, removeNationalPrefixFromNationalNumber,
  attemptToExtractIdd, attemptToExtractCountryCallingCode,
  normalizeAndAccrueDigitsAndPlusSign and inputDigitHelper, plus the constants
  SEPARATOR_BEFORE_NATIONAL_NUMBER, EMPTY_METADATA, ELIGIBLE_FORMAT_PATTERN,
  NATIONAL_PREFIX_SEPARATORS_PATTERN, MIN_LEADING_DIGITS_LENGTH and
  DIGIT_PLACEHOLDER.

  A class, not a set of procedures
  -------------------------------
  The rest of the library is deliberately procedural, because upstream
  PhoneNumberUtil is a stateless singleton over read only metadata. The
  AsYouTypeFormatter is the opposite: it accumulates input across calls and its
  whole contract is the evolution of that state. It is therefore modelled as a
  class, with one instance per number being typed.

  Character handling
  ------------------
  DIGIT_PLACEHOLDER is U+2008 (punctuation space). It is NEVER written as a
  source literal - that would make the file encoding behaviour relevant on two
  compilers - but used as the code point constant DigitPlaceholderCodePoint,
  and the formatting template is held as a UnicodeString so the placeholder
  survives on FreePascal, where Char and the default string type are single
  byte in Delphi mode. This is the same rule the format engine follows for
  VALID_PUNCTUATION (see LibPhoneNumber.MetadataFormat).

  Only the TEMPLATE needs the wide type. The strings that leave this class are
  ASCII by construction: the formatted prefix returned by inputDigitHelper
  contains digits and the format separators only, and every number format of
  the pinned baseline is pure ASCII. The accrued buffers therefore stay in the
  native string type, which is single byte on FreePascal; that is sound because
  every character this class accrues is ASCII (see deviation 1 below), and a
  non ASCII character entered on FreePascal is echoed through the platform
  AnsiString conversion rather than verbatim - a second, narrower face of the
  same deviation.

  Deliberate deviations from Java (form only)
  -------------------------------------------
  1. Unicode decimal digits are accepted and normalised exactly like
     upstream: isDigitOrLeadingPlusSign uses Character.isDigit there,
     and normalizeAndAccrueDigitsAndPlusSign turns the character into its ASCII
     form with Character.forDigit(Character.digit(c, 10), 10) before accruing
     it. Both are ported onto
     LibPhoneNumber.MetadataCore.UnicodeDecimalDigitValue, so a full width
     or Arabic-Indic digit is accrued as its ASCII equivalent.
  2. The formatter takes WideChar rather than Char so a caller on FreePascal
     can hand in a code point above U+00FF at all - which it must
     be able to do for a full width digit to be recognised.
  3. Missing metadata is reported through the Try* API of the metadata layer
     instead of null; the EMPTY_METADATA fallback of the Java constructor is
     ported as a unit level record.
  4. clear() compares currentMetadata with defaultMetadata by POINTER. Java
     compares the protos by value; both metadata handles always come from the
     generated read only table (or both are the empty record), so the two
     tests coincide.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata;

type
  { A formatter which formats phone numbers as they are entered.

    Create one per number, feed it InputDigit character by character and use
    the returned string as the current display value. Call Clear before
    formatting a new number. }
  TAsYouTypeFormatter = class
  private
    { UnicodeString, like FAccruedInput below and for the same reason: this is
      what InputDigit returns, and in the "cannot format" path that IS the raw
      accrued input. }
    FCurrentOutput: UnicodeString;
    { The template with DIGIT_PLACEHOLDER for every digit not entered yet.
      UnicodeString because DIGIT_PLACEHOLDER is U+2008; see the unit header. }
    FFormattingTemplate: UnicodeString;
    { The pattern from numberFormat currently used to build FFormattingTemplate. }
    FCurrentFormattingPattern: string;
    { The RAW characters the caller typed, echoed unchanged whenever formatting
      is off - including a non ASCII decimal digit that has not been
      normalised yet because fewer than three characters have been accrued.
      UnicodeString, not the native string type: on FreePascal in Delphi mode
      the latter is a single byte AnsiString and every such character would be
      squeezed through the platform code page on the way in AND on the way out.

      FAccruedInputWithoutFormatting deliberately stays in the native string
      type: everything that reaches it has been normalised to an ASCII digit,
      an ASCII plus sign or the U+0000 the full width plus sign produces, so it
      survives a single byte representation losslessly - and it is the buffer
      the regex layer and the country code slicing work on. }
    FAccruedInput: UnicodeString;
    FAccruedInputWithoutFormatting: string;
    FAbleToFormat: Boolean;
    FInputHasFormatting: Boolean;
    FIsCompleteNumber: Boolean;
    FIsExpectingCountryCallingCode: Boolean;
    FDefaultCountry: string;
    FDefaultMetadata: PPhoneMetadataRec;
    FCurrentMetadata: PPhoneMetadataRec;
    { Java Matcher index semantics: 0 based offset into FFormattingTemplate. }
    FLastMatchPosition: Integer;
    FOriginalPosition: Integer;
    FPositionToRemember: Integer;
    FPrefixBeforeNationalNumber: string;
    FShouldAddSpaceAfterNationalPrefix: Boolean;
    FExtractedNationalPrefix: string;
    FNationalNumber: string;
    FPossibleFormats: array of PNumberFormatRec;

    function GetMetadataForRegion(const ARegionCode: string): PPhoneMetadataRec;
    procedure RemovePossibleFormat(AIndex: Integer);
    function MaybeCreateNewTemplate: Boolean;
    procedure GetAvailableFormats(const ALeadingDigits: string);
    procedure NarrowDownPossibleFormats(const ALeadingDigits: string);
    function CreateFormattingTemplate(AFormat: PNumberFormatRec): Boolean;
    function GetFormattingTemplate(const ANumberPattern,
      ANumberFormat: string): UnicodeString;
    function InputDigitWithOptionToRememberPosition(ACh: WideChar;
      ARememberPosition: Boolean): UnicodeString;
    function AttemptToChoosePatternWithPrefixExtracted: UnicodeString;
    function AbleToExtractLongerNdd: Boolean;
    function IsDigitOrLeadingPlusSign(ACh: WideChar): Boolean;
    function AttemptToFormatAccruedDigits: UnicodeString;
    function AppendNationalNumber(
      const ANationalNumberPart: UnicodeString): UnicodeString;
    function AttemptToChooseFormattingPattern: UnicodeString;
    function InputAccruedNationalNumber: UnicodeString;
    function IsNanpaNumberWithNationalPrefix: Boolean;
    function RemoveNationalPrefixFromNationalNumber: string;
    function AttemptToExtractIdd: Boolean;
    function AttemptToExtractCountryCallingCode: Boolean;
    function NormalizeAndAccrueDigitsAndPlusSign(ACh: WideChar;
      ARememberPosition: Boolean): WideChar;
    function InputDigitHelper(ACh: WideChar): UnicodeString;
  public
    { ARegionCode is the country/region where the phone number is being
      entered. An unknown region is not an error: the formatter falls back to
      the empty metadata and still formats numbers entered with a leading
      plus.

      ARegionCode is CANONICALISED with UpperCase(Trim(...)) before it is used,
      the same way the facade TPhoneNumberUtil and the ShortNumberInfo
      functions normalise a region argument. Upstream compares region codes exactly and would treat
      ' de ' as an unknown region; the canonical codes are a superset of what
      it accepts, so accepting them changes no answer for a caller that already
      passes CLDR codes and is a deliberate service for one that does not. }
    constructor Create(const ARegionCode: string);

    { Formats a phone number on the fly as each character is entered and
      returns the partially formatted number. Formatting characters are
      allowed, but as soon as one is seen the input is echoed as entered and
      not formatted "as you type" any more. }
    function InputDigit(ACh: WideChar): UnicodeString;

    { As InputDigit, but remembers the position where ACh is inserted so it can
      be retrieved with GetRememberedPosition. The remembered position is
      adjusted automatically when formatting characters are inserted or removed
      in front of it. }
    function InputDigitAndRememberPosition(ACh: WideChar): UnicodeString;

    { The current position, in the partially formatted number, of the character
      most recently passed to InputDigitAndRememberPosition. }
    function GetRememberedPosition: Integer;

    { Clears the internal state so the instance can be reused. }
    procedure Clear;

    { Java's package private getExtractedNationalPrefix, kept for the test
      suite. }
    property ExtractedNationalPrefix: string read FExtractedNationalPrefix;
  end;

const
  { Java AsYouTypeFormatter.SEPARATOR_BEFORE_NATIONAL_NUMBER. }
  SeparatorBeforeNationalNumber = ' ';

  { Java AsYouTypeFormatter.MIN_LEADING_DIGITS_LENGTH. }
  MinLeadingDigitsLength = 3;

  { Java AsYouTypeFormatter.DIGIT_PLACEHOLDER, the punctuation space U+2008, as
    a code point instead of a literal. See "Character handling" in the header. }
  DigitPlaceholderCodePoint = $2008;

{ Java AsYouTypeFormatter.ELIGIBLE_FORMAT_PATTERN applied with
  Matcher.matches():

    [VALID_PUNCTUATION]* \$1 [VALID_PUNCTUATION]* (\$\d [VALID_PUNCTUATION]*)*

  Ported as a scanner rather than a compiled pattern for the same reason
  IsValidPunctuation itself is a predicate: the character class holds eighteen
  non ASCII code points and spelling them into a pattern literal would make the
  source encoding load bearing on two compilers. Exposed for the test suite. }
function IsFormatEligible(const AFormat: string): Boolean;

{ Java AsYouTypeFormatter.NATIONAL_PREFIX_SEPARATORS_PATTERN applied with
  Matcher.find(): the rule contains a dash or a space somewhere. Exposed for
  the test suite. }
function NationalPrefixHasSeparator(const ARule: string): Boolean;

implementation

uses
{$IFDEF FPC}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.MetadataFormat,
  LibPhoneNumber.Regex;

var
  { Java's EMPTY_METADATA:
      PhoneMetadata.newBuilder().setId("<ignored>").setInternationalPrefix("NA")
    Every other field stays at its proto default, which for this record means
    zero/empty, so there are no formats, no descriptions and no national prefix
    for parsing. Filled once in the initialisation section and never written
    again, so sharing one instance across formatters is safe. }
  GEmptyMetadata: TPhoneMetadataRec;

function IsAsciiDigit(ACh: WideChar): Boolean;
begin
  Result := (ACh >= '0') and (ACh <= '9');
end;

function IsFormatEligible(const AFormat: string): Boolean;
var
  Wide: UnicodeString;
  I, Len: Integer;
begin
  { Scanned as UTF-16 so a non ASCII punctuation character stays reachable on
    FreePascal; on Delphi the widening is the identity. }
  Wide := UnicodeString(AFormat);
  Len := Length(Wide);
  I := 1;

  while (I <= Len) and IsValidPunctuation(Wide[I]) do
    Inc(I);

  { The mandatory "\$1": upstream requires the FIRST group in the output so no
    digits can be lost while formatting. }
  if (I + 1 > Len) or (Wide[I] <> '$') or (Wide[I + 1] <> '1') then
  begin
    Result := False;
    Exit;
  end;
  Inc(I, 2);

  while (I <= Len) and IsValidPunctuation(Wide[I]) do
    Inc(I);

  { ("\$\d" [punctuation]*)* }
  while I <= Len do
  begin
    if (Wide[I] <> '$') or (I + 1 > Len) or not IsAsciiDigit(Wide[I + 1]) then
    begin
      Result := False;
      Exit;
    end;
    Inc(I, 2);
    while (I <= Len) and IsValidPunctuation(Wide[I]) do
      Inc(I);
  end;

  Result := True;
end;

function NationalPrefixHasSeparator(const ARule: string): Boolean;
var
  I: Integer;
begin
  for I := 1 to Length(ARule) do
    if (ARule[I] = '-') or (ARule[I] = ' ') then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

{ Java PLUS_CHARS_PATTERN applied to a single character: the ASCII plus sign
  or the full width plus U+FF0B. Written as code points, not as a literal, so
  the source file stays pure ASCII on both compilers. }
function IsPlusChar(ACh: WideChar): Boolean;
begin
  Result := (Ord(ACh) = Ord('+')) or (Ord(ACh) = $FF0B);
end;

{ Java StringBuilder.lastIndexOf: the 0 BASED index of the last occurrence of
  ASub in AValue, or -1. }
function LastIndexOfSubstring(const AValue, ASub: string): Integer;
var
  I, SubLen: Integer;
begin
  SubLen := Length(ASub);
  if SubLen = 0 then
  begin
    Result := Length(AValue);
    Exit;
  end;
  for I := Length(AValue) - SubLen + 1 downto 1 do
    if Copy(AValue, I, SubLen) = ASub then
    begin
      Result := I - 1;
      Exit;
    end;
  Result := -1;
end;

{ 1 based index of the first DIGIT_PLACEHOLDER at or after AStart, or 0. }
function IndexOfPlaceholder(const ATemplate: UnicodeString;
  AStart: Integer): Integer;
var
  I: Integer;
begin
  if AStart < 1 then
    AStart := 1;
  for I := AStart to Length(ATemplate) do
    if Ord(ATemplate[I]) = DigitPlaceholderCodePoint then
    begin
      Result := I;
      Exit;
    end;
  Result := 0;
end;

{ ------------------------------------------------------------------------- }

constructor TAsYouTypeFormatter.Create(const ARegionCode: string);
begin
  inherited Create;
  FCurrentOutput := '';
  FFormattingTemplate := '';
  FCurrentFormattingPattern := '';
  FAccruedInput := '';
  FAccruedInputWithoutFormatting := '';
  FAbleToFormat := True;
  FInputHasFormatting := False;
  FIsCompleteNumber := False;
  FIsExpectingCountryCallingCode := False;
  FLastMatchPosition := 0;
  FOriginalPosition := 0;
  FPositionToRemember := 0;
  FPrefixBeforeNationalNumber := '';
  FShouldAddSpaceAfterNationalPrefix := False;
  FExtractedNationalPrefix := '';
  FNationalNumber := '';
  FPossibleFormats := nil;

  { Canonicalise once, here: FDefaultCountry is compared against region codes
    from the metadata later on (isNanpaNumberWithNationalPrefix among others),
    so a non canonical spelling would silently fall through to the empty
    metadata instead of being an unknown region. See the constructor's
    declaration for why this port canonicalises where upstream compares
    exactly. }
  FDefaultCountry := UpperCase(Trim(ARegionCode));
  FCurrentMetadata := GetMetadataForRegion(FDefaultCountry);
  FDefaultMetadata := FCurrentMetadata;
end;

{ "The metadata needed by this class is the same for all regions sharing the
  same country calling code. Therefore, we return the metadata for the main
  region for this country calling code." }
function TAsYouTypeFormatter.GetMetadataForRegion(
  const ARegionCode: string): PPhoneMetadataRec;
var
  CountryCallingCode: Integer;
  MainCountry: string;
  Metadata: PPhoneMetadataRec;
begin
  CountryCallingCode := LibPhoneNumber.Metadata.GetCountryCodeForRegion(
    ARegionCode);
  MainCountry := LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(
    CountryCallingCode);
  { Upstream uses getMetadataForRegion, NOT getMetadataForRegionOrCallingCode:
    a non geographical entity has no region metadata here and falls back to the
    empty instance; attemptToExtractCountryCallingCode picks it up separately. }
  if TryGetMetadataForRegion(MainCountry, Metadata) then
    Result := Metadata
  else
    { "Set to a default instance of the metadata. This allows us to function
      with an incorrect region code, even if formatting only works for numbers
      specified with '+'." }
    Result := @GEmptyMetadata;
end;

procedure TAsYouTypeFormatter.RemovePossibleFormat(AIndex: Integer);
var
  I: Integer;
begin
  for I := AIndex to Length(FPossibleFormats) - 2 do
    FPossibleFormats[I] := FPossibleFormats[I + 1];
  SetLength(FPossibleFormats, Length(FPossibleFormats) - 1);
end;

{ Returns True if a new template is created as opposed to reusing the existing
  template. The Java body walks possibleFormats with an Iterator and removes
  the entries that cannot produce a template; the index loop below does the
  same without advancing on a removal. }
function TAsYouTypeFormatter.MaybeCreateNewTemplate: Boolean;
var
  I: Integer;
  NumberFormat: PNumberFormatRec;
  Pattern: string;
begin
  I := 0;
  while I < Length(FPossibleFormats) do
  begin
    NumberFormat := FPossibleFormats[I];
    Pattern := NumberFormat^.Pattern;
    if FCurrentFormattingPattern = Pattern then
    begin
      Result := False;
      Exit;
    end;
    if CreateFormattingTemplate(NumberFormat) then
    begin
      FCurrentFormattingPattern := Pattern;
      FShouldAddSpaceAfterNationalPrefix := NationalPrefixHasSeparator(
        NumberFormat^.NationalPrefixFormattingRule);
      { "With a new formatting template, the matched position using the old
        template needs to be reset." }
      FLastMatchPosition := 0;
      Result := True;
      Exit;
    end;
    { Remove the current number format from possibleFormats. }
    RemovePossibleFormat(I);
  end;
  FAbleToFormat := False;
  Result := False;
end;

procedure TAsYouTypeFormatter.GetAvailableFormats(const ALeadingDigits: string);
var
  IsInternationalNumber: Boolean;
  UseIntl: Boolean;
  Count, I: Integer;
  NumFormat: PNumberFormatRec;
begin
  { First decide whether we should use international or national number
    rules. }
  IsInternationalNumber := FIsCompleteNumber
    and (Length(FExtractedNationalPrefix) = 0);
  UseIntl := IsInternationalNumber
    and (GetIntlNumberFormatCount(FCurrentMetadata) > 0);

  if UseIntl then
    Count := GetIntlNumberFormatCount(FCurrentMetadata)
  else
    Count := GetNumberFormatCount(FCurrentMetadata);

  for I := 0 to Count - 1 do
  begin
    if UseIntl then
      NumFormat := GetIntlNumberFormat(FCurrentMetadata, I)
    else
      NumFormat := GetNumberFormat(FCurrentMetadata, I);
    if NumFormat = nil then
      Continue;

    { "Discard a few formats that we know are not relevant based on the
      presence of the national prefix." }
    if (Length(FExtractedNationalPrefix) > 0)
      and FormattingRuleHasFirstGroupOnly(
        NumFormat^.NationalPrefixFormattingRule)
      and (not NumFormat^.NationalPrefixOptionalWhenFormatting)
      and (NumFormat^.DomesticCarrierCodeFormattingRule = '') then
      { "If it is a national number that had a national prefix, any rules that
        aren't valid with a national prefix should be excluded. A rule that has
        a carrier-code formatting rule is kept since the national prefix might
        actually be an extracted carrier code - we don't distinguish between
        these when extracting it in the AYTF." }
      Continue
    else if (Length(FExtractedNationalPrefix) = 0)
      and (not FIsCompleteNumber)
      and (not FormattingRuleHasFirstGroupOnly(
        NumFormat^.NationalPrefixFormattingRule))
      and (not NumFormat^.NationalPrefixOptionalWhenFormatting) then
      { "This number was entered without a national prefix, and this formatting
        rule requires one, so we discard it." }
      Continue;

    if IsFormatEligible(NumFormat^.Format) then
    begin
      SetLength(FPossibleFormats, Length(FPossibleFormats) + 1);
      FPossibleFormats[Length(FPossibleFormats) - 1] := NumFormat;
    end;
  end;

  NarrowDownPossibleFormats(ALeadingDigits);
end;

procedure TAsYouTypeFormatter.NarrowDownPossibleFormats(
  const ALeadingDigits: string);
var
  IndexOfLeadingDigitsPattern, LastLeadingDigitsPattern, I: Integer;
  NumFormat: PNumberFormatRec;
begin
  IndexOfLeadingDigitsPattern := Length(ALeadingDigits) - MinLeadingDigitsLength;
  I := 0;
  while I < Length(FPossibleFormats) do
  begin
    NumFormat := FPossibleFormats[I];
    if NumFormat^.LeadingDigitsCount = 0 then
    begin
      { Keep everything that isn't restricted by leading digits. }
      Inc(I);
      Continue;
    end;
    LastLeadingDigitsPattern := IndexOfLeadingDigitsPattern;
    if LastLeadingDigitsPattern > NumFormat^.LeadingDigitsCount - 1 then
      LastLeadingDigitsPattern := NumFormat^.LeadingDigitsCount - 1;
    { Java would throw for a negative index. Every upstream call site feeds at
      least MIN_LEADING_DIGITS_LENGTH characters, so the clamp is unreachable
      on the pinned baseline and only keeps this port total. }
    if LastLeadingDigitsPattern < 0 then
      LastLeadingDigitsPattern := 0;

    if TryMatchPrefix(GetLeadingDigitsPattern(NumFormat,
      LastLeadingDigitsPattern), ALeadingDigits) then
      Inc(I)
    else
      RemovePossibleFormat(I);
  end;
end;

function TAsYouTypeFormatter.CreateFormattingTemplate(
  AFormat: PNumberFormatRec): Boolean;
var
  TempTemplate: UnicodeString;
begin
  FFormattingTemplate := '';
  TempTemplate := GetFormattingTemplate(AFormat^.Pattern, AFormat^.Format);
  if Length(TempTemplate) > 0 then
  begin
    FFormattingTemplate := TempTemplate;
    Result := True;
  end
  else
    Result := False;
end;

{ "Gets a formatting template which can be used to efficiently format a partial
  number where digits are added one by one." }
function TAsYouTypeFormatter.GetFormattingTemplate(const ANumberPattern,
  ANumberFormat: string): UnicodeString;
const
  LongestPhoneNumber = '999999999999999';
var
  APhoneNumber, Template: string;
  MatchStart, I: Integer;
  Built: UnicodeString;
begin
  Result := '';
  { "Creates a phone number consisting only of the digit 9 that matches the
    numberPattern by applying the pattern to the longestPhoneNumber string."
    Java calls find() and relies on it always succeeding; a pattern that does
    not match anywhere would raise IllegalStateException there and yields an
    unusable template here. }
  if not TryFindFirst(ANumberPattern, LongestPhoneNumber, APhoneNumber,
    MatchStart) then
    Exit;

  { "No formatting template can be created if the number of digits entered so
    far is longer than the maximum the current formatting rule can
    accommodate." }
  if Length(APhoneNumber) < Length(FNationalNumber) then
    Exit;

  { Formats the number according to numberFormat. }
  Template := ReplaceAll(ANumberPattern, APhoneNumber, ANumberFormat);

  { Replaces each digit with the character DIGIT_PLACEHOLDER. Java runs
    replaceAll("9", DIGIT_PLACEHOLDER) here; the template can only contain the
    digit nine at this point, so a plain character substitution is the same
    operation without dragging a Unicode literal into a pattern. }
  Built := '';
  for I := 1 to Length(Template) do
    if Template[I] = '9' then
      Built := Built + WideChar(DigitPlaceholderCodePoint)
    else
      Built := Built + WideChar(Ord(Template[I]));
  Result := Built;
end;

procedure TAsYouTypeFormatter.Clear;
begin
  FCurrentOutput := '';
  FAccruedInput := '';
  FAccruedInputWithoutFormatting := '';
  FFormattingTemplate := '';
  FLastMatchPosition := 0;
  FCurrentFormattingPattern := '';
  FPrefixBeforeNationalNumber := '';
  FExtractedNationalPrefix := '';
  FNationalNumber := '';
  FAbleToFormat := True;
  FInputHasFormatting := False;
  FPositionToRemember := 0;
  FOriginalPosition := 0;
  FIsCompleteNumber := False;
  FIsExpectingCountryCallingCode := False;
  FPossibleFormats := nil;
  FShouldAddSpaceAfterNationalPrefix := False;
  { Pointer comparison; see deviation 4 in the unit header. }
  if FCurrentMetadata <> FDefaultMetadata then
    FCurrentMetadata := GetMetadataForRegion(FDefaultCountry);
end;

function TAsYouTypeFormatter.InputDigit(ACh: WideChar): UnicodeString;
begin
  FCurrentOutput := InputDigitWithOptionToRememberPosition(ACh, False);
  Result := FCurrentOutput;
end;

function TAsYouTypeFormatter.InputDigitAndRememberPosition(
  ACh: WideChar): UnicodeString;
begin
  FCurrentOutput := InputDigitWithOptionToRememberPosition(ACh, True);
  Result := FCurrentOutput;
end;

function TAsYouTypeFormatter.InputDigitWithOptionToRememberPosition(
  ACh: WideChar; ARememberPosition: Boolean): UnicodeString;
var
  NextChar: WideChar;
  TempNationalNumber, FormattedNumber: UnicodeString;
begin
  NextChar := ACh;
  FAccruedInput := FAccruedInput + NextChar;
  if ARememberPosition then
    FOriginalPosition := Length(FAccruedInput);

  { "We do formatting on-the-fly only when each character entered is either a
    digit, or a plus sign (accepted at the start of the number only)." }
  if not IsDigitOrLeadingPlusSign(NextChar) then
  begin
    FAbleToFormat := False;
    FInputHasFormatting := True;
  end
  else
    NextChar := NormalizeAndAccrueDigitsAndPlusSign(NextChar,
      ARememberPosition);

  if not FAbleToFormat then
  begin
    { "When we are unable to format because of reasons other than that
      formatting chars have been entered, it can be due to really long IDDs or
      NDDs. If that is the case, we might be able to do formatting again after
      extracting them." }
    if FInputHasFormatting then
    begin
      Result := FAccruedInput;
      Exit;
    end
    else if AttemptToExtractIdd then
    begin
      if AttemptToExtractCountryCallingCode then
      begin
        Result := AttemptToChoosePatternWithPrefixExtracted;
        Exit;
      end;
    end
    else if AbleToExtractLongerNdd then
    begin
      { "Add an additional space to separate long NDD and national significant
        number for readability. We don't set shouldAddSpaceAfterNationalPrefix
        to true, since we don't want this to change later when we choose
        formatting templates." }
      FPrefixBeforeNationalNumber := FPrefixBeforeNationalNumber
        + SeparatorBeforeNationalNumber;
      Result := AttemptToChoosePatternWithPrefixExtracted;
      Exit;
    end;
    Result := FAccruedInput;
    Exit;
  end;

  { "We start to attempt to format only when at least
    MIN_LEADING_DIGITS_LENGTH digits (the plus sign is counted as a digit as
    well for this purpose) have been entered." The Java body is a switch with a
    documented fall through from case 3 into the default. }
  case Length(FAccruedInputWithoutFormatting) of
    0, 1, 2:
      begin
        Result := FAccruedInput;
        Exit;
      end;
    3:
      begin
        if AttemptToExtractIdd then
          FIsExpectingCountryCallingCode := True
        else
        begin
          { No IDD or plus sign is found, might be entering in national
            format. }
          FExtractedNationalPrefix := RemoveNationalPrefixFromNationalNumber;
          Result := AttemptToChooseFormattingPattern;
          Exit;
        end;
        { fall through }
      end;
  end;

  if FIsExpectingCountryCallingCode then
  begin
    if AttemptToExtractCountryCallingCode then
      FIsExpectingCountryCallingCode := False;
    Result := UnicodeString(FPrefixBeforeNationalNumber + FNationalNumber);
    Exit;
  end;

  if Length(FPossibleFormats) > 0 then
  begin
    { The formatting patterns are already chosen. }
    TempNationalNumber := InputDigitHelper(NextChar);
    { "See if the accrued digits can be formatted properly already. If not, use
      the results from inputDigitHelper, which does formatting based on the
      formatting pattern chosen." }
    FormattedNumber := AttemptToFormatAccruedDigits;
    if Length(FormattedNumber) > 0 then
    begin
      Result := FormattedNumber;
      Exit;
    end;
    NarrowDownPossibleFormats(FNationalNumber);
    if MaybeCreateNewTemplate then
    begin
      Result := InputAccruedNationalNumber;
      Exit;
    end;
    if FAbleToFormat then
      Result := AppendNationalNumber(TempNationalNumber)
    else
      Result := FAccruedInput;
  end
  else
    Result := AttemptToChooseFormattingPattern;
end;

function TAsYouTypeFormatter.AttemptToChoosePatternWithPrefixExtracted: UnicodeString;
begin
  FAbleToFormat := True;
  FIsExpectingCountryCallingCode := False;
  FPossibleFormats := nil;
  FLastMatchPosition := 0;
  FFormattingTemplate := '';
  FCurrentFormattingPattern := '';
  Result := AttemptToChooseFormattingPattern;
end;

{ "Some national prefixes are a substring of others. If extracting the shorter
  NDD doesn't result in a number we can format, we try to see if we can extract
  a longer version here." }
function TAsYouTypeFormatter.AbleToExtractLongerNdd: Boolean;
var
  IndexOfPreviousNdd: Integer;
begin
  if Length(FExtractedNationalPrefix) > 0 then
  begin
    { Put the extracted NDD back to the national number before attempting to
      extract a new NDD. }
    FNationalNumber := FExtractedNationalPrefix + FNationalNumber;
    { "Remove the previously extracted NDD from prefixBeforeNationalNumber. We
      cannot simply set it to empty string because people sometimes incorrectly
      enter national prefix after the country code, e.g. +44 (0)20-1234-5678."
      Java uses StringBuilder.lastIndexOf, i.e. the 0 based index of the LAST
      occurrence, and setLength() to that index. }
    IndexOfPreviousNdd := LastIndexOfSubstring(FPrefixBeforeNationalNumber,
      FExtractedNationalPrefix);
    { Java would throw on setLength(-1). The extracted NDD is always part of
      the prefix at this point, so the guard is unreachable on the pinned
      baseline and only keeps the port total. }
    if IndexOfPreviousNdd >= 0 then
      FPrefixBeforeNationalNumber := Copy(FPrefixBeforeNationalNumber, 1,
        IndexOfPreviousNdd);
  end;
  Result := FExtractedNationalPrefix <> RemoveNationalPrefixFromNationalNumber;
end;

function TAsYouTypeFormatter.IsDigitOrLeadingPlusSign(ACh: WideChar): Boolean;
begin
  { Java's Character.isDigit, i.e. every Unicode decimal digit, not just the
    ASCII ten. }
  Result := IsUnicodeDecimalDigit(ACh)
    or ((Length(FAccruedInput) = 1) and IsPlusChar(ACh));
end;

{ "Checks to see if there is an exact pattern match for these digits. If so, we
  should use this instead of any other formatting template whose
  leadingDigitsPattern also matches the input." }
function TAsYouTypeFormatter.AttemptToFormatAccruedDigits: UnicodeString;
var
  I: Integer;
  NumFormat: PNumberFormatRec;
  FormattedNumber, DigitsOnly: string;
  FullOutput: UnicodeString;
begin
  for I := 0 to Length(FPossibleFormats) - 1 do
  begin
    NumFormat := FPossibleFormats[I];
    if TryMatchFull(NumFormat^.Pattern, FNationalNumber) then
    begin
      FShouldAddSpaceAfterNationalPrefix := NationalPrefixHasSeparator(
        NumFormat^.NationalPrefixFormattingRule);
      FormattedNumber := ReplaceAll(NumFormat^.Pattern, FNationalNumber,
        NumFormat^.Format);
      { "Check that we did not remove nor add any extra digits when we matched
        this formatting pattern. This usually happens after we entered the last
        digit during AYTF. Eg: In case of MX, we swallow mobile token (1) when
        formatted but AYTF should retain all the number entered and not change
        in order to match a format (of same leading digits and length) display
        in that way." }
      FullOutput := AppendNationalNumber(UnicodeString(FormattedNumber));
      DigitsOnly := NormalizeDiallableCharsOnly(string(FullOutput));
      if DigitsOnly = FAccruedInputWithoutFormatting then
      begin
        { "If it's the same (i.e entered number and format is same), then it's
          safe to return this in formatted number as nothing is lost / added." }
        Result := FullOutput;
        Exit;
      end;
    end;
  end;
  Result := '';
end;

function TAsYouTypeFormatter.GetRememberedPosition: Integer;
var
  AccruedInputIndex, CurrentOutputIndex: Integer;
begin
  if not FAbleToFormat then
  begin
    Result := FOriginalPosition;
    Exit;
  end;
  AccruedInputIndex := 0;
  CurrentOutputIndex := 0;
  while (AccruedInputIndex < FPositionToRemember)
    and (CurrentOutputIndex < Length(FCurrentOutput)) do
  begin
    if (AccruedInputIndex < Length(FAccruedInputWithoutFormatting))
      and (FAccruedInputWithoutFormatting[AccruedInputIndex + 1]
        = FCurrentOutput[CurrentOutputIndex + 1]) then
      Inc(AccruedInputIndex);
    Inc(CurrentOutputIndex);
  end;
  Result := CurrentOutputIndex;
end;

{ "Combines the national number with any prefix (IDD/+ and country code or
  national prefix) that was collected. A space will be inserted between them if
  the current formatting template indicates this to be suitable." }
function TAsYouTypeFormatter.AppendNationalNumber(
  const ANationalNumberPart: UnicodeString): UnicodeString;
var
  PrefixLength: Integer;
begin
  PrefixLength := Length(FPrefixBeforeNationalNumber);
  if FShouldAddSpaceAfterNationalPrefix and (PrefixLength > 0)
    and (FPrefixBeforeNationalNumber[PrefixLength]
      <> SeparatorBeforeNationalNumber) then
    { "We want to add a space after the national prefix if the national prefix
      formatting rule indicates that this would normally be done, with the
      exception of the case where we already appended a space because the NDD
      was surprisingly long." }
    Result := UnicodeString(FPrefixBeforeNationalNumber
        + SeparatorBeforeNationalNumber) + ANationalNumberPart
  else
    Result := UnicodeString(FPrefixBeforeNationalNumber)
      + ANationalNumberPart;
end;

{ "Attempts to set the formatting template and returns a string which contains
  the formatted version of the digits entered so far." }
function TAsYouTypeFormatter.AttemptToChooseFormattingPattern: UnicodeString;
var
  FormattedNumber: UnicodeString;
begin
  { "We start to attempt to format only when at least
    MIN_LEADING_DIGITS_LENGTH digits of national number (excluding national
    prefix) have been entered." }
  if Length(FNationalNumber) >= MinLeadingDigitsLength then
  begin
    GetAvailableFormats(FNationalNumber);
    { See if the accrued digits can be formatted properly already. }
    FormattedNumber := AttemptToFormatAccruedDigits;
    if Length(FormattedNumber) > 0 then
    begin
      Result := FormattedNumber;
      Exit;
    end;
    if MaybeCreateNewTemplate then
      Result := InputAccruedNationalNumber
    else
      Result := FAccruedInput;
  end
  else
    Result := AppendNationalNumber(UnicodeString(FNationalNumber));
end;

{ "Invokes inputDigitHelper on each digit of the national number accrued, and
  returns a formatted string in the end." }
function TAsYouTypeFormatter.InputAccruedNationalNumber: UnicodeString;
var
  LengthOfNationalNumber, I: Integer;
  TempNationalNumber: UnicodeString;
begin
  LengthOfNationalNumber := Length(FNationalNumber);
  if LengthOfNationalNumber > 0 then
  begin
    TempNationalNumber := '';
    for I := 1 to LengthOfNationalNumber do
      TempNationalNumber := InputDigitHelper(WideChar(FNationalNumber[I]));
    if FAbleToFormat then
      Result := AppendNationalNumber(TempNationalNumber)
    else
      Result := FAccruedInput;
  end
  else
    Result := UnicodeString(FPrefixBeforeNationalNumber);
end;

{ "Returns true if the current country is a NANPA country and the national
  number begins with the national prefix." }
function TAsYouTypeFormatter.IsNanpaNumberWithNationalPrefix: Boolean;
begin
  { "For NANPA numbers beginning with 1[2-9], treat the 1 as the national
    prefix. The reason is that national significant numbers in NANPA always
    start with [2-9] after the national prefix. Numbers beginning with 1[01]
    can only be short/emergency numbers, which don't need the national prefix."

    Java indexes nationalNumber.charAt(0) and charAt(1) unguarded; the only
    call site runs with at least three accrued characters, so the length guard
    below is unreachable on the pinned baseline and only keeps the port total. }
  Result := (FCurrentMetadata^.CountryCode = NanpaCountryCode)
    and (Length(FNationalNumber) >= 2)
    and (FNationalNumber[1] = '1')
    and (FNationalNumber[2] <> '0')
    and (FNationalNumber[2] <> '1');
end;

{ Returns the national prefix extracted, or an empty string if it is not
  present. }
function TAsYouTypeFormatter.RemoveNationalPrefixFromNationalNumber: string;
var
  StartOfNationalNumber: Integer;
  Match: TRegexPrefixMatch;
  NationalPrefix: string;
begin
  StartOfNationalNumber := 0;
  if IsNanpaNumberWithNationalPrefix then
  begin
    StartOfNationalNumber := 1;
    FPrefixBeforeNationalNumber := FPrefixBeforeNationalNumber + '1'
      + SeparatorBeforeNationalNumber;
    FIsCompleteNumber := True;
  end
  else if FCurrentMetadata^.NationalPrefixForParsing <> '' then
  begin
    { "Since some national prefix patterns are entirely optional, check that a
      national prefix could actually be extracted." Java tests
      m.lookingAt() && m.end() > 0; TRegexPrefixMatch.MatchEnd is the 1 based
      index of the character AFTER the match, so Java's end() is MatchEnd - 1. }
    if TryMatchPrefixEx(FCurrentMetadata^.NationalPrefixForParsing,
      FNationalNumber, Match) and (Match.MatchEnd - 1 > 0) then
    begin
      { "When the national prefix is detected, we use international formatting
        rules instead of national ones, because national formatting rules could
        contain local formatting rules for numbers entered without area code." }
      FIsCompleteNumber := True;
      StartOfNationalNumber := Match.MatchEnd - 1;
      FPrefixBeforeNationalNumber := FPrefixBeforeNationalNumber
        + Copy(FNationalNumber, 1, StartOfNationalNumber);
    end;
  end;

  NationalPrefix := Copy(FNationalNumber, 1, StartOfNationalNumber);
  FNationalNumber := Copy(FNationalNumber, StartOfNationalNumber + 1,
    Length(FNationalNumber) - StartOfNationalNumber);
  Result := NationalPrefix;
end;

{ "Extracts IDD and plus sign to prefixBeforeNationalNumber when they are
  available, and places the remaining input into nationalNumber."

  Returns True when accruedInputWithoutFormatting begins with the plus sign or
  a valid IDD for defaultCountry. }
function TAsYouTypeFormatter.AttemptToExtractIdd: Boolean;
var
  Pattern: string;
  Match: TRegexPrefixMatch;
  StartOfCountryCallingCode: Integer;
begin
  { Java builds "\\+|" + internationalPrefix. The regex layer wraps the pattern
    in a non capturing group, so the leading alternation binds correctly. }
  Pattern := '\+|' + FCurrentMetadata^.InternationalPrefix;
  if TryMatchPrefixEx(Pattern, FAccruedInputWithoutFormatting, Match) then
  begin
    FIsCompleteNumber := True;
    StartOfCountryCallingCode := Match.MatchEnd - 1;
    FNationalNumber := Copy(FAccruedInputWithoutFormatting,
      StartOfCountryCallingCode + 1,
      Length(FAccruedInputWithoutFormatting) - StartOfCountryCallingCode);
    FPrefixBeforeNationalNumber := Copy(FAccruedInputWithoutFormatting, 1,
      StartOfCountryCallingCode);
    if (FAccruedInputWithoutFormatting <> '')
      and (FAccruedInputWithoutFormatting[1] <> '+') then
      FPrefixBeforeNationalNumber := FPrefixBeforeNationalNumber
        + SeparatorBeforeNationalNumber;
    Result := True;
    Exit;
  end;
  Result := False;
end;

{ "Extracts the country calling code from the beginning of nationalNumber to
  prefixBeforeNationalNumber when they are available, and places the remaining
  input into nationalNumber."

  Returns True when a valid country calling code can be found. }
function TAsYouTypeFormatter.AttemptToExtractCountryCallingCode: Boolean;
var
  NumberWithoutCountryCallingCode: string;
  CountryCode: Integer;
  NewRegionCode: string;
  NonGeoMetadata: PPhoneMetadataRec;
begin
  if FNationalNumber = '' then
  begin
    Result := False;
    Exit;
  end;

  CountryCode := ExtractCountryCode(FNationalNumber,
    NumberWithoutCountryCallingCode);
  if CountryCode = 0 then
  begin
    Result := False;
    Exit;
  end;

  FNationalNumber := NumberWithoutCountryCallingCode;
  NewRegionCode := LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(
    CountryCode);
  if NewRegionCode = NonGeoRegionCode then
  begin
    if TryGetMetadataForNonGeoEntity(CountryCode, NonGeoMetadata) then
      FCurrentMetadata := NonGeoMetadata
    else
      FCurrentMetadata := @GEmptyMetadata;
  end
  else if NewRegionCode <> FDefaultCountry then
    FCurrentMetadata := GetMetadataForRegion(NewRegionCode);

  FPrefixBeforeNationalNumber := FPrefixBeforeNationalNumber
    + IntToStr(CountryCode) + SeparatorBeforeNationalNumber;
  { "When we have successfully extracted the IDD, the previously extracted NDD
    should be cleared because it is no longer valid." }
  FExtractedNationalPrefix := '';
  Result := True;
end;

{ "Accrues digits and the plus sign to accruedInputWithoutFormatting for later
  use. If nextChar contains a digit in non-ASCII format (e.g. the full-width
  version of digits), it is first normalized to the ASCII version." }
function TAsYouTypeFormatter.NormalizeAndAccrueDigitsAndPlusSign(ACh: WideChar;
  ARememberPosition: Boolean): WideChar;
var
  Digit: Integer;
begin
  if Ord(ACh) = Ord('+') then
  begin
    Result := ACh;
    FAccruedInputWithoutFormatting := FAccruedInputWithoutFormatting
      + string(ACh);
  end
  else
  begin
    { Java: Character.forDigit(Character.digit(nextChar, 10), 10). The ONLY
      character that reaches this branch without being a decimal digit is the
      FULL WIDTH plus sign U+FF0B, which isDigitOrLeadingPlusSign accepts
      through PLUS_CHARS_PATTERN while the Java body still sends it down the
      digit branch: Character.digit returns -1 there and
      Character.forDigit(-1, 10) yields U+0000. The behaviour is reproduced
      rather than "fixed" so the port stays literal. }
    Digit := UnicodeDecimalDigitValue(ACh);
    if Digit >= 0 then
      Result := WideChar(Ord('0') + Digit)
    else
      Result := WideChar(0);
    FAccruedInputWithoutFormatting := FAccruedInputWithoutFormatting
      + string(Result);
    FNationalNumber := FNationalNumber + string(Result);
  end;
  if ARememberPosition then
    FPositionToRemember := Length(FAccruedInputWithoutFormatting);
end;

function TAsYouTypeFormatter.InputDigitHelper(ACh: WideChar): UnicodeString;
var
  FoundFromLastMatch, FirstPlaceholder: Integer;
begin
  { "Note that formattingTemplate is not guaranteed to have a value, it could be
    empty, e.g. when the next digit is entered after extracting an IDD or NDD."

    Java runs DIGIT_PATTERN.matcher(formattingTemplate).find(lastMatchPosition)
    and then replaceFirst(), which RESETS the matcher and therefore replaces the
    first placeholder of the whole template. Both scans are kept: every position
    before lastMatchPosition already holds an entered digit, so they always find
    the same one, and writing it out makes that invariant visible. }
  FoundFromLastMatch := IndexOfPlaceholder(FFormattingTemplate,
    FLastMatchPosition + 1);
  if FoundFromLastMatch > 0 then
  begin
    FirstPlaceholder := IndexOfPlaceholder(FFormattingTemplate, 1);
    FFormattingTemplate[FirstPlaceholder] := ACh;
    FLastMatchPosition := FirstPlaceholder - 1;
    Result := Copy(FFormattingTemplate, 1, FLastMatchPosition + 1);
  end
  else
  begin
    if Length(FPossibleFormats) = 1 then
      { "More digits are entered than we could handle, and there are no other
        valid patterns to try." }
      FAbleToFormat := False;
    { else, we just reset the formatting pattern. }
    FCurrentFormattingPattern := '';
    Result := FAccruedInput;
  end;
end;

initialization
  GEmptyMetadata.Id := '<ignored>';
  GEmptyMetadata.CountryCode := 0;
  GEmptyMetadata.LeadingDigits := '';
  GEmptyMetadata.InternationalPrefix := 'NA';
  GEmptyMetadata.PreferredInternationalPrefix := '';
  GEmptyMetadata.NationalPrefix := '';
  GEmptyMetadata.NationalPrefixForParsing := '';
  GEmptyMetadata.NationalPrefixTransformRule := '';
  GEmptyMetadata.PreferredExtnPrefix := '';
  GEmptyMetadata.MainCountryForCode := False;
  GEmptyMetadata.MobileNumberPortableRegion := False;
  GEmptyMetadata.SameMobileAndFixedLinePattern := False;
  GEmptyMetadata.DescOffset := -1;
  GEmptyMetadata.FormatOffset := 0;
  GEmptyMetadata.FormatCount := 0;
  GEmptyMetadata.IntlFormatOffset := 0;
  GEmptyMetadata.IntlFormatCount := 0;

end.
