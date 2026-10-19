unit LibPhoneNumber.PhoneNumberUtil;

{
  The public facade of the library: the parse driver (upstream
  parseHelper), Format and the extended formatter API, isNumberMatch, and the
  parse based half of the accessory API. Everything metadata driven and parse
  free lives in the units below it; see AGENTS.md "Core Status" for the map.

  FreePascal
  ----------
  The unit compiles with Delphi and with FreePascal (in Delphi mode) and is
  part of both FreePascal gates (tools/check_fpc_compile.ps1 and the runtime
  gate tools/run_fpc_runtime_check.ps1). The contract of the `string`
  parameters and results on FreePascal, where `string` is an AnsiString:

  1. `string` is UTF-8. The program must make the conversion between
     AnsiString and UnicodeString lossless - SetMultiByteConversionCodePage
     (CP_UTF8) and, on Unix, `cwstring` in its uses clause (KNOWN_ISSUES.md,
     permanent item 6). Every result string is UTF-8 as well.
  2. Every LENGTH and every character test that upstream performs on a Java
     String is performed on the UnicodeString form of the argument, i.e. in
     UTF-16 code units exactly like Java and like the Delphi build: the
     MAX_INPUT_STRING_LENGTH guard of parseHelper and the plus character tests
     of the parse driver. Byte indices into a UTF-8 string never leave this
     unit. On Delphi `string` IS UnicodeString and these conversions are the
     identity, so the Delphi behaviour is unchanged by them.
  3. A lone surrogate cannot be carried by a UTF-8 `string` (the RTL turns it
     into '?'), so a FreePascal caller cannot hand one in at all.
  4. Record offsets reported by the matcher (TPhoneNumberMatch.Start) are
     UTF-16 code unit offsets on both compilers; see
     LibPhoneNumber.PhoneNumberMatcher.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.MetadataFormat;

type
  TPhoneNumberUtil = class
  private
    class function GetNationalNumberDigits(const AParsed: TPhoneNumber): string; static;
    { Upstream "number.getNationalNumber() == 0", the guard of the raw input
      short circuit of format(). See the implementation for the mapping. }
    class function NationalNumberIsZero(const AParsed: TPhoneNumber): Boolean; static;
    class function FormatThroughEngine(const AParsed: TPhoneNumber;
      const ANsnDigits: string;
      AFormat: TMetadataPhoneNumberFormat): string; static;
    class function ToLegacyDisplayFormat(const AInternational: string): string; static;
    class function TryGetCallingCodeForRegion(const ARegion: string;
      out ACode: Integer): Boolean; static;
    class function ResolveRegionForCallingCode(const ACountryCode: Integer): string; static;
    { Upstream parseHelper(numberToParse, defaultRegion, keepRawInput,
      checkRegion, phoneNumber). ACheckRegion = False is the isNumberMatch
      path: the default region may then be unknown, and a number without a
      calling code comes back with CountryCode = 0 instead of being rejected. }
    class function ParseHelper(const APhoneNumber, ACountry: string;
      AKeepRawInput, ACheckRegion: Boolean; out AParsed: TPhoneNumber;
      out AError: TPhoneNumberParseError): Boolean; static;

    { The core of upstream isNumberMatch(PhoneNumber, PhoneNumber). Both
      comparisons canonicalise their operands first, so a record that carries
      only NationalNumberDigits or only NationalNumber compares correctly. }
    class function CanonicalNationalNumberDigits(
      const ARecord: TPhoneNumber): string; static;
    class function CanonicalNationalNumberValue(
      const ARecord: TPhoneNumber): string; static;
    class function IsNationalNumberSuffixOfTheOther(const AFirst,
      ASecond: TPhoneNumber): Boolean; static;
    class function CoreFieldsEqual(const AFirst,
      ASecond: TPhoneNumber): Boolean; static;

    { Upstream rawInputContainsNationalPrefix, the helper of
      formatInOriginalFormat. Java catches the NumberParseException of its
      inner parse() call and answers False; here Parse reports the failure as a
      Boolean, so the try/catch becomes an if. }
    class function RawInputContainsNationalPrefix(const ARawInput,
      ANationalPrefix, ARegionCode: string): Boolean; static;

    { Maps the public format enum onto the engine enum. The repository specific
      pnfInternationalLegacy has no upstream counterpart and is reported
      separately, because it is a post processing step on the INTERNATIONAL
      string rather than a format of its own. }
    class function TryMapPublicFormat(AFormat: TPhoneNumberFormat;
      out AEngineFormat: TMetadataPhoneNumberFormat;
      out ALegacyDisplay: Boolean): Boolean; static;
  public
    class function Parse(const APhoneNumber, ACountry: string; out AParsed: TPhoneNumber; out AError: TPhoneNumberParseError): Boolean; static;
    { Upstream parseAndKeepRawInput: same result as Parse plus the fields that
      upstream only fills in when keepRawInput is set - RawInput,
      CountryCodeSource and PreferredDomesticCarrierCode. }
    class function ParseAndKeepRawInput(const APhoneNumber, ACountry: string; out AParsed: TPhoneNumber; out AError: TPhoneNumberParseError): Boolean; static;

    { ------------------------------------------------------------------
      Two steps of the parse driver, public on their own.

      Upstream marks both @VisibleForTesting; they are exported here so that
      the upstream tests of the two steps can be ported. Parse and
      ParseAndKeepRawInput run through exactly these two methods. The
      `string` arguments follow the contract of the unit header: plus
      characters are recognised on the UTF-16 form, and every number these
      methods write is normalised to ASCII digits.
      ------------------------------------------------------------------ }

    { Upstream maybeStripInternationalPrefixAndNormalize(number,
      possibleIddPrefix): "Strips any international prefix (such as +, 00,
      011) present in the number provided, normalizes the resulting number,
      and indicates if an international prefix was present."

      ANumber is the non normalised number (Java's StringBuilder, modified in
      place). A leading run of plus characters always wins; otherwise
      APossibleIddPrefix - a regular expression, normally the
      InternationalPrefix of the metadata of the region the number may be
      dialled from - is stripped when it matches at the start of the
      normalised number and the first digit behind it is not a 0. Returns
      pnccsFromNumberWithPlusSign, pnccsFromNumberWithIdd or, when no
      international prefix was present, pnccsFromDefaultCountry. ANumber is
      normalised on return in every case except the empty input, which is
      returned unchanged with pnccsFromDefaultCountry.

      An EMPTY APossibleIddPrefix is upstream's getInternationalPrefix() of a
      territory without one, and it behaves as upstream's compiled "": a
      zero length match, so every number whose normalised form does not
      start with 0 reports pnccsFromNumberWithIdd with nothing stripped.

      Raises EArgumentException (upstream: PatternSyntaxException, an
      IllegalArgumentException) when APossibleIddPrefix does not compile;
      ANumber is then unchanged, because the pattern is compiled before the
      number is normalised, as upstream. A number with a leading plus never
      looks at the pattern. }
    class function MaybeStripInternationalPrefixAndNormalize(
      var ANumber: string;
      const APossibleIddPrefix: string): TCountryCodeSource; static;

    { Upstream maybeExtractCountryCode(number, defaultRegionMetadata,
      nationalNumber, keepRawInput, phoneNumber): "Tries to extract a country
      calling code from a number" - after a plus sign, after the
      international prefix of the default region, or, without either, from
      the start of the number when it begins with the calling code of the
      default region and only makes sense with that code removed.

      ANumber is the non normalised number, it may begin with a plus sign.
      ADefaultRegionMetadata is the metadata of the default region, nil for
      upstream's null (no default region: the international prefix then
      never matches and the calling code of the default region is not
      tried). It is a SOURCE BOUND pointer (AGENTS.md "Metadata Source
      Switching"): fetch it with LibPhoneNumber.Metadata.TryGetMetadataForRegion
      after the last UseMetadataTables switch and do not keep it across one.

      On True, ACountryCode is the extracted calling code or 0 when none is
      considered present, AError is pnpeNone, APhoneNumber.CountryCode is set
      to ACountryCode and, when a calling code was extracted, its national
      significant number is APPENDED to ANationalNumber (otherwise
      ANationalNumber is left unchanged, as upstream's StringBuilder). The
      empty input answers True with ACountryCode = 0 and touches neither
      ANationalNumber nor APhoneNumber, exactly like upstream.

      On False - upstream throws NumberParseException - AError is
      pnpeTooShortAfterIdd or pnpeInvalidCountryCode, ACountryCode is 0, and
      ANationalNumber and APhoneNumber.CountryCode are left unchanged.

      APhoneNumber.CountryCodeSource is only written when AKeepRawInput is
      True, and then also on the False path (upstream records the source
      before it throws). No other field of APhoneNumber is touched.

      The international prefix of ADefaultRegionMetadata goes through
      MaybeStripInternationalPrefixAndNormalize, so a malformed one raises
      EArgumentException out of this method; ANationalNumber and
      APhoneNumber are not written then. The
      generated metadata cannot carry one - the generator validates every
      pattern and the FreePascal runtime gate compiles all of them - so only
      a record built by the caller can. A territory without an international
      prefix (empty) is handled like upstream; see there. }
    class function TryMaybeExtractCountryCode(const ANumber: string;
      ADefaultRegionMetadata: PPhoneMetadataRec; var ANationalNumber: string;
      AKeepRawInput: Boolean; var APhoneNumber: TPhoneNumber;
      out ACountryCode: Integer;
      out AError: TPhoneNumberParseError): Boolean; static;

    { Upstream isPossibleNumber(CharSequence number, String regionDialingFrom):
      Parse in ACountry followed by IsPossibleNumber(TPhoneNumber); False when
      the number does not parse. }
    class function IsPossibleNumber(const APhoneNumber,
      ACountry: string): Boolean; overload; static;
    { Parse plus isValidNumber(PhoneNumber); False when the number does not
      parse in ACountry. No upstream counterpart of its own. }
    class function IsValidNumber(const APhoneNumber,
      ACountry: string): Boolean; overload; static;

    { ------------------------------------------------------------------
      Validation, typing and region resolution of an already parsed number:
      the upstream PhoneNumberUtil methods that take a PhoneNumber.

      Each one is a thin wrapper over the function of the same name in
      LibPhoneNumber.MetadataCore (CanBeInternationallyDialled: in
      LibPhoneNumber.MetadataFormat), applied to the record's calling code
      and its national significant number. The national significant number
      is NationalNumberDigits; a hand built record that carries only the
      numeric NationalNumber falls back to its decimal representation, as in
      every other record taking method of this facade. RegionCode and the
      raw input fields are not read - upstream resolves the region from the
      calling code, and so does every one of these. A region argument is
      canonicalised with UpperCase(Trim(...)). Nothing throws and nothing
      logs; Java's null region is the empty string.
      ------------------------------------------------------------------ }

    { Upstream isValidNumber(PhoneNumber): the number matches a valid pattern
      of the region getRegionCodeForNumber resolves. Only the leading digits
      and the length are checked, not whether the number is in use. }
    class function IsValidNumber(
      const AParsed: TPhoneNumber): Boolean; overload; static;

    { Upstream isValidNumberForRegion(PhoneNumber, regionCode): the number is
      valid in ARegion. False for an unsupported region and when the calling
      code of the number is not the one of ARegion; the non geographical
      "001" accepts every non geographical entity. }
    class function IsValidNumberForRegion(const AParsed: TPhoneNumber;
      const ARegion: string): Boolean; static;

    { Upstream getNumberType(PhoneNumber): mntUnknown for a number that is
      not valid. }
    class function GetNumberType(
      const AParsed: TPhoneNumber): TMetadataNumberType; static;

    { Upstream getRegionCodeForNumber(PhoneNumber): the region the number is
      from, "001" for a non geographical entity, the empty string (Java:
      null) for an unsupported calling code or when no region of a shared
      calling code matches. Only reliable for valid numbers. }
    class function GetRegionCodeForNumber(
      const AParsed: TPhoneNumber): string; static;

    { Upstream isPossibleNumber(PhoneNumber): isPossibleNumberWithReason is
      mvrIsPossible or mvrIsPossibleLocalOnly. }
    class function IsPossibleNumber(
      const AParsed: TPhoneNumber): Boolean; overload; static;

    { Upstream isPossibleNumberWithReason(PhoneNumber): the length check
      against the main region of the calling code, i.e.
      IsPossibleNumberForTypeWithReason with mntUnknown (every length of the
      region). }
    class function IsPossibleNumberWithReason(
      const AParsed: TPhoneNumber): TMetadataValidationResult; static;

    { Upstream isPossibleNumberForType(PhoneNumber, PhoneNumberType). }
    class function IsPossibleNumberForType(const AParsed: TPhoneNumber;
      AType: TMetadataNumberType): Boolean; static;

    { Upstream isPossibleNumberForTypeWithReason(PhoneNumber,
      PhoneNumberType): the length check against the possible lengths of
      AType in the main region of the calling code. }
    class function IsPossibleNumberForTypeWithReason(
      const AParsed: TPhoneNumber;
      AType: TMetadataNumberType): TMetadataValidationResult; static;

    { Upstream canBeInternationallyDialled(PhoneNumber): False when the
      number matches the noInternationalDialling description of its region;
      True for a region without metadata, the non geographical entities
      included. }
    class function CanBeInternationallyDialled(
      const AParsed: TPhoneNumber): Boolean; static;

    class function Format(const AParsed: TPhoneNumber; AFormat: TPhoneNumberFormat): string; static;

    { ------------------------------------------------------------------
      Extended formatter API.

      All five are literal ports of the corresponding PhoneNumberUtil methods.
      Two conventions of this facade apply to them:

      1. A region argument is normalised with UpperCase(Trim(...)) first, the
         same way Parse normalises its default region. Upstream compares region
         codes exactly and expects the caller to pass canonical CLDR codes.
      2. Nothing throws. Upstream never throws in these methods either: an
         unsupported regionCallingFrom makes formatOutOfCountryCallingNumber log
         a warning and fall back to the INTERNATIONAL format, and an invalid
         country calling code makes every one of them return the bare national
         significant number. Note that this is deliberately NOT the empty string
         that the older Format() returns for a number without a calling code -
         the new entry points follow the upstream contract instead.
      ------------------------------------------------------------------ }

    { Upstream formatOutOfCountryCallingNumber. }
    class function FormatOutOfCountryCallingNumber(const AParsed: TPhoneNumber;
      const ARegionCallingFrom: string): string; static;

    { Upstream formatNationalNumberWithCarrierCode. An empty ACarrierCode means
      "national format without any carrier code". }
    class function FormatNationalNumberWithCarrierCode(
      const AParsed: TPhoneNumber; const ACarrierCode: string): string; static;

    { Upstream formatNationalNumberWithPreferredCarrierCode: uses
      TPhoneNumber.PreferredDomesticCarrierCode when it is set and not empty,
      otherwise AFallbackCarrierCode. The field is only filled in by
      ParseAndKeepRawInput, exactly like upstream. }
    class function FormatNationalNumberWithPreferredCarrierCode(
      const AParsed: TPhoneNumber;
      const AFallbackCarrierCode: string): string; static;

    { Upstream formatByPattern. The user defined formats are handed in through
      the adapter record of LibPhoneNumber.MetadataFormat; build them with
      MakeUserNumberFormat.

      pnfInternationalLegacy is this repository's own display variant and has
      no upstream counterpart here either: it formats as INTERNATIONAL and then
      applies the same parenthesising step Format() uses. }
    class function FormatByPattern(const AParsed: TPhoneNumber;
      AFormat: TPhoneNumberFormat;
      const AUserDefinedFormats: TUserNumberFormatArray): string; static;

    { Upstream formatInOriginalFormat: formats the number the way it was
      dialled, which needs RawInput and CountryCodeSource and therefore a
      number that came out of ParseAndKeepRawInput. For a number parsed with
      plain Parse both fields are empty, which is upstream's "no country code
      source" case, and the method degrades to the NATIONAL format - the same
      behaviour Java shows for a PhoneNumber built by hand.

      This method formats through the ENGINE rather than through Format(),
      because upstream format() returns the bare national significant number
      for an invalid calling code where Format() returns the empty string. }
    class function FormatInOriginalFormat(const AParsed: TPhoneNumber;
      const ARegionCallingFrom: string): string; static;

    { Upstream formatNumberForMobileDialing: the number formatted so it can be
      dialled from a mobile phone in ARegionCallingFrom. Returns an empty
      string when the number cannot be reached from there - Brazilian fixed
      line and mobile numbers dialled inside Brazil without a carrier code are
      the case that actually triggers it.

      AWithFormatting = False returns the diallable characters only. The
      carrier code branch reads TPhoneNumber.PreferredDomesticCarrierCode,
      which - like upstream - only ParseAndKeepRawInput fills in. }
    class function FormatNumberForMobileDialing(const AParsed: TPhoneNumber;
      const ARegionCallingFrom: string; AWithFormatting: Boolean): string; static;

    { Upstream formatOutOfCountryKeepingAlphaChars: like
      FormatOutOfCountryCallingNumber, but the alpha characters and the
      grouping of TPhoneNumber.RawInput are kept. Needs a number that came out
      of ParseAndKeepRawInput; without a raw input it degrades to
      FormatOutOfCountryCallingNumber, exactly like upstream. }
    class function FormatOutOfCountryKeepingAlphaChars(
      const AParsed: TPhoneNumber;
      const ARegionCallingFrom: string): string; static;

    { ------------------------------------------------------------------
      isNumberMatch, all three upstream overloads.

      "Takes two phone numbers and compares them for equality.

       Returns EXACT_MATCH if the country_code, NSN, presence of a leading zero
       for Italian numbers and any extension present are the same.
       Returns NSN_MATCH if either or both has no region specified, and the
       NSNs and extensions are the same.
       Returns SHORT_NSN_MATCH if either or both has no region specified, or
       the region specified is the same, and one NSN could be a shorter version
       of the other number. This includes the case where one has an extension
       specified, and the other does not.
       Returns NO_MATCH otherwise."

      The two string overloads add pnmtNotANumber for an input that cannot be
      parsed at all. They know no default region, exactly like upstream: a
      string is first parsed with the unknown region 'ZZ', which only succeeds
      when it carries its own calling code.
      ------------------------------------------------------------------ }
    class function IsNumberMatch(const AFirst,
      ASecond: TPhoneNumber): TPhoneNumberMatchType; overload; static;
    class function IsNumberMatch(const AFirst: TPhoneNumber;
      const ASecond: string): TPhoneNumberMatchType; overload; static;
    class function IsNumberMatch(const AFirst,
      ASecond: string): TPhoneNumberMatchType; overload; static;

    { ------------------------------------------------------------------
      Accessory API (the library surface behind the last PhoneNumberUtilTest
      methods that were still unported).

      Placement: the logic of everything that is metadata driven and parse
      free lives in the FPC gated units - getSupportedTypesFor*,
      isNumberGeographical, getCountryMobileToken, isAlphaNumber and
      truncateTooLongNumber in LibPhoneNumber.MetadataCore, the two
      length methods in LibPhoneNumber.MetadataFormat. The methods below
      that only forward to them exist because they take the TPhoneNumber
      record (and, for regions, canonicalise the argument with
      UpperCase(Trim(...)) like every other public region argument). The
      getExampleNumber* family and getInvalidExampleNumber are implemented
      HERE, because they parse the example number with parse().

      Nothing throws and nothing logs. Java answers null where these answer
      False with ANumber = Default(TPhoneNumber), and the warnings upstream
      logs for an unknown region or calling code are dropped.
      ------------------------------------------------------------------ }

    { Upstream getNationalSignificantNumber: the national significant number
      as digits, leading zeros included. That is the record's canonical
      NationalNumberDigits; a hand built record that carries only the numeric
      NationalNumber falls back to its decimal representation (which cannot
      carry a leading zero - the record has no italianLeadingZero flag), so
      the default record answers "0" like upstream. The upstream cap of ten
      leading zeros is applied; see the implementation for its scope. }
    class function GetNationalSignificantNumber(
      const AParsed: TPhoneNumber): string; static;

    { Upstream isNumberGeographical(phoneNumber). The type overload is
      LibPhoneNumber.MetadataCore.IsNumberGeographical. }
    class function IsNumberGeographical(
      const AParsed: TPhoneNumber): Boolean; static;

    { Upstream getLengthOfGeographicalAreaCode and
      getLengthOfNationalDestinationCode; see
      LibPhoneNumber.MetadataFormat for both. The extension of AParsed is
      ignored (Java clears it on a copy), RawInput is passed on for the raw
      input short circuit of format(). }
    class function GetLengthOfGeographicalAreaCode(
      const AParsed: TPhoneNumber): Integer; static;
    class function GetLengthOfNationalDestinationCode(
      const AParsed: TPhoneNumber): Integer; static;

    { Upstream getCountryMobileToken (static upstream as well). }
    class function GetCountryMobileToken(ACountryCode: Integer): string; static;

    { Upstream getSupportedTypesForRegion / getSupportedTypesForNonGeoEntity. }
    class function GetSupportedTypesForRegion(
      const ARegion: string): TMetadataNumberTypes; static;
    class function GetSupportedTypesForNonGeoEntity(
      ACountryCode: Integer): TMetadataNumberTypes; static;

    { Upstream getExampleNumber(regionCode): the FIXED_LINE example number of
      the region, parsed in that region. False for an unsupported region and
      for the non geographical "001" - use
      TryGetExampleNumberForNonGeoEntity for those. }
    class function TryGetExampleNumber(const ARegion: string;
      out ANumber: TPhoneNumber): Boolean; static;

    { Upstream getExampleNumberForType(regionCode, type). False when the
      region is not supported or the type has no example number there; a
      parse failure of the example number (Java logs it and returns null)
      is False as well. FIXED_LINE_OR_MOBILE reads the fixed line
      description, exactly like getNumberDescByType. }
    class function TryGetExampleNumberForType(const ARegion: string;
      AType: TMetadataNumberType; out ANumber: TPhoneNumber): Boolean;
      overload; static;

    { Upstream getExampleNumberForType(type): the first region that has an
      example number of that type, then the first non geographical entity.
      "First" is the order of LibPhoneNumber.Metadata.GetSupportedRegions
      and GetSupportedGlobalNetworkCallingCodes. Upstream walks a HashSet, so
      which region answers is unspecified there; only "some valid number of
      that type" is the contract. }
    class function TryGetExampleNumberForType(AType: TMetadataNumberType;
      out ANumber: TPhoneNumber): Boolean; overload; static;

    { Upstream getExampleNumberForNonGeoEntity: the first example number among
      the mobile, toll free, shared cost, VoIP, voicemail, UAN and premium rate
      descriptions of the entity, in that upstream order, parsed as
      "+" + calling code + example in the unknown region. }
    class function TryGetExampleNumberForNonGeoEntity(ACountryCode: Integer;
      out ANumber: TPhoneNumber): Boolean; static;

    { Upstream getInvalidExampleNumber: the fixed line example number of the
      region, shortened one digit at a time (down to MIN_LENGTH_FOR_NSN) until
      the parsed result is NOT a valid number. Upstream swallows the parse
      exception of a candidate and moves on; so does this loop. }
    class function TryGetInvalidExampleNumber(const ARegion: string;
      out ANumber: TPhoneNumber): Boolean; static;

    { Upstream truncateTooLongNumber. ANumber is modified only when a shorter
      valid number was found; NationalNumberDigits and NationalNumber are then
      both rewritten, every other field is kept. A number that is valid
      already returns True and is not touched. See
      LibPhoneNumber.MetadataCore.TruncateTooLongNumber for the digit
      string form of the upstream loop. }
    class function TruncateTooLongNumber(var ANumber: TPhoneNumber): Boolean;
      static;

    { Upstream isAlphaNumber (a vanity number check on the raw string). }
    class function IsAlphaNumber(const ANumber: string): Boolean; static;
  end;

implementation

uses
  LibPhoneNumber.Regex;

{ ------------------------------------------------------------------
  Small string helpers. The facade used the Delphi string helpers
  (StartsWith, EndsWith, Substring, Split, UInt64.ToString) before it became
  FreePascal clean; these are plain RTL replacements with the SAME result for
  every argument this unit passes, written out so neither compiler's helper
  semantics are load bearing.
  ------------------------------------------------------------------ }

{ String.startsWith for a non empty prefix (every caller passes one; an empty
  prefix answers True like the helper did). }
function StartsWithText(const AValue, APrefix: string): Boolean;
begin
  Result := (Length(APrefix) <= Length(AValue))
    and (Copy(AValue, 1, Length(APrefix)) = APrefix);
end;

{ Upstream PLUS_CHARS_PATTERN at the start of AValue, i.e. Java
  "plus character at charAt(0)". The test is made on the UTF-16 form: on
  FreePascal AValue is UTF-8 and its first BYTE is not a character (the full
  width plus U+FF0B is three bytes there). }
function StartsWithPlusChar(const AValue: string): Boolean;
var
  Wide: UnicodeString;
begin
  Wide := UnicodeString(AValue);
  Result := (Length(Wide) > 0)
    and LibPhoneNumber.MetadataCore.IsPlusChar(Wide[1]);
end;

{ AValue with its leading run of plus characters removed (upstream
  PLUS_CHARS_PATTERN matches a RUN, and parseHelper continues behind the
  whole match). Scanned in UTF-16 for the reason given above. }
function StripLeadingPlusRun(const AValue: string): string;
var
  Wide: UnicodeString;
  RunEnd: Integer;
begin
  Wide := UnicodeString(AValue);
  RunEnd := 1;
  while (RunEnd <= Length(Wide))
    and LibPhoneNumber.MetadataCore.IsPlusChar(Wide[RunEnd]) do
    Inc(RunEnd);
  Result := string(Copy(Wide, RunEnd, Length(Wide) - RunEnd + 1));
end;

{ String.endsWith; an empty suffix answers True like the helper did. }
function EndsWithText(const AValue, ASuffix: string): Boolean;
begin
  Result := (Length(ASuffix) <= Length(AValue))
    and (Copy(AValue, Length(AValue) - Length(ASuffix) + 1, Length(ASuffix))
      = ASuffix);
end;

{ Everything except pnfE164 is delegated to the metadata
  driven engine, which is the literal port of PhoneNumberUtil.format and covers
  all 254 territories of the pinned baseline.

  Note which region decides: upstream formats with the metadata of
  getRegionCodeForCountryCode(countryCallingCode), NOT with the region the
  number was parsed in, because the format rules of a shared calling code live
  in exactly one territory (US for the NANPA). The engine does that lookup
  itself, so TPhoneNumber.RegionCode is deliberately not consulted here. }
class function TPhoneNumberUtil.FormatThroughEngine(
  const AParsed: TPhoneNumber; const ANsnDigits: string;
  AFormat: TMetadataPhoneNumberFormat): string;
begin
  { This record has no "field present" flags, so a number without a calling
    code or without digits has nothing to format and yields an empty string,
    which is what the previous formatter did too. The rawInput branch of the
    public upstream format(number, numberFormat) is ported separately, in
    Format() below, where upstream has it. }
  if (AParsed.CountryCode <= 0) or (ANsnDigits = '') then
    Exit('');

  Result := LibPhoneNumber.MetadataFormat.FormatNumber(
    AParsed.CountryCode, ANsnDigits, AParsed.Extension, AFormat);
end;

{ Upstream "number.getNationalNumber() == 0", i.e. the guard of the raw input
  short circuit of format().

  Java stores the national significant number as a NUMBER plus the
  italianLeadingZero / numberOfLeadingZeros pair, so a zero national number is
  the numeric field being zero, and getNationalSignificantNumber of such a
  record is a run of zeros ("0", "00", "000", ...). This record stores the
  DIGITS instead, so the equivalent test is that those digits are all zeros;
  an absent national number is Java's field default 0 as well. }
class function TPhoneNumberUtil.NationalNumberIsZero(
  const AParsed: TPhoneNumber): Boolean;
var
  Digits: string;
  I: Integer;
begin
  Digits := GetNationalNumberDigits(AParsed);
  if Digits = '' then
    Exit(True);
  for I := 1 to Length(Digits) do
    if Digits[I] <> '0' then
      Exit(False);
  Result := True;
end;

class function TPhoneNumberUtil.Format(const AParsed: TPhoneNumber;
  AFormat: TPhoneNumberFormat): string;
var
  NsnDigits: string;
begin
  { ------------------------------------------------------------------
    The raw input short circuit at the head of the PUBLIC upstream
    format(number, numberFormat). Note WHICH overload: the StringBuilder
    overload right below it in PhoneNumberUtil.java does NOT have this block,
    and neither does the engine entry point
    LibPhoneNumber.MetadataFormat.FormatNumber, which is the port of that
    overload. This is therefore the upstream equivalent place.

    Upstream, in the order of the Java source (braces left out, they would end
    this comment):

      when getNationalNumber() == 0, read rawInput and then

        IF   rawInput.length() > 0
        AND  number.hasCountryCode()
        AND  getCountryCodeSource() == CountryCodeSource.FROM_DEFAULT_COUNTRY
        AND  numberFormat == PhoneNumberFormat.E164
        THEN return prefixNumberWithCountryCallingCode(countryCallingCode,
               numberFormat, new StringBuilder(rawInput))
        ELSE IF rawInput.length() > 0 OR NOT number.hasCountryCode()
        THEN return rawInput

      and otherwise fall through to the normal formatting path. Note that the
      first branch PREFIXES the raw input with the calling code instead of
      replacing it, and that it is the only branch that looks at the format.

    Two field mappings, both forced by the record having no "field present"
    flags: getNationalNumber() == 0 is NationalNumberIsZero (see there), and
    hasCountryCode() is CountryCode <> 0. The second one is exact for every
    case that can reach here: the first branch needs a calling code it can
    actually prefix, and in the second branch "no calling code" is what makes
    an empty raw input come back as the empty string - which is what this
    method returned for such a number before as well.

    pnfInternationalLegacy has no upstream counterpart and is deliberately not
    E164, so it takes the second branch, exactly like INTERNATIONAL.
    ------------------------------------------------------------------ }
  if NationalNumberIsZero(AParsed) then
  begin
    if (AParsed.RawInput <> '')
      and (AParsed.CountryCode <> 0)
      and (AParsed.CountryCodeSource = pnccsFromDefaultCountry)
      and (AFormat = pnfE164) then
    begin
      Result := AParsed.RawInput;
      PrefixNumberWithCountryCallingCode(AParsed.CountryCode, mpnfE164, Result);
      Exit;
    end
    else if (AParsed.RawInput <> '') or (AParsed.CountryCode = 0) then
      Exit(AParsed.RawInput);
  end;

  NsnDigits := GetNationalNumberDigits(AParsed);

  { Every member of the enum has its branch. There is deliberately no else
    branch (FreePascal reports it as unreachable code); the initialisation
    keeps the empty string for a value outside the enum. }
  Result := '';
  case AFormat of
    pnfE164:
      begin
        if (AParsed.CountryCode > 0) and (NsnDigits <> '') then
          Result := '+' + IntToStr(AParsed.CountryCode) + NsnDigits
        else
          Result := '';
      end;
    pnfInternational:
      Result := FormatThroughEngine(AParsed, NsnDigits, mpnfInternational);
    { pnfInternationalLegacy has no upstream counterpart. It is this
      repository's own display variant and stays defined as "the upstream
      INTERNATIONAL string with the group after the calling code put in
      parentheses", so it inherits the metadata grouping like every other
      format. }
    pnfInternationalLegacy:
      Result := ToLegacyDisplayFormat(
        FormatThroughEngine(AParsed, NsnDigits, mpnfInternational));
    pnfNational:
      Result := FormatThroughEngine(AParsed, NsnDigits, mpnfNational);
    pnfRfc3966:
      Result := FormatThroughEngine(AParsed, NsnDigits, mpnfRfc3966);
  end;
end;

class function TPhoneNumberUtil.TryMapPublicFormat(
  AFormat: TPhoneNumberFormat;
  out AEngineFormat: TMetadataPhoneNumberFormat;
  out ALegacyDisplay: Boolean): Boolean;
begin
  ALegacyDisplay := AFormat = pnfInternationalLegacy;
  { The defaults answer a value outside the enum; every member has its branch,
    so there is no else branch (FreePascal reports it as unreachable code). }
  AEngineFormat := mpnfNational;
  Result := False;
  case AFormat of
    pnfE164:
      begin
        AEngineFormat := mpnfE164;
        Result := True;
      end;
    pnfInternational, pnfInternationalLegacy:
      begin
        AEngineFormat := mpnfInternational;
        Result := True;
      end;
    pnfNational:
      begin
        AEngineFormat := mpnfNational;
        Result := True;
      end;
    pnfRfc3966:
      begin
        AEngineFormat := mpnfRfc3966;
        Result := True;
      end;
  end;
end;

class function TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
  const AParsed: TPhoneNumber; const ARegionCallingFrom: string): string;
begin
  Result := LibPhoneNumber.MetadataFormat.FormatOutOfCountryCallingNumber(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed), AParsed.Extension,
    UpperCase(Trim(ARegionCallingFrom)));
end;

class function TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(
  const AParsed: TPhoneNumber; const ACarrierCode: string): string;
begin
  Result :=
    LibPhoneNumber.MetadataFormat.FormatNationalNumberWithCarrierCode(
      AParsed.CountryCode, GetNationalNumberDigits(AParsed), AParsed.Extension,
      ACarrierCode);
end;

class function TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(
  const AParsed: TPhoneNumber; const AFallbackCarrierCode: string): string;
var
  CarrierCode: string;
begin
  { Upstream comment: "Historically, we set this to an empty string when
    parsing with raw input if none was found in the input string. However, this
    doesn't result in a number we can dial. For this reason, we treat the empty
    string the same as if it isn't set at all." }
  if AParsed.PreferredDomesticCarrierCode <> '' then
    CarrierCode := AParsed.PreferredDomesticCarrierCode
  else
    CarrierCode := AFallbackCarrierCode;

  Result := TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(AParsed,
    CarrierCode);
end;

class function TPhoneNumberUtil.FormatByPattern(const AParsed: TPhoneNumber;
  AFormat: TPhoneNumberFormat;
  const AUserDefinedFormats: TUserNumberFormatArray): string;
var
  EngineFormat: TMetadataPhoneNumberFormat;
  LegacyDisplay: Boolean;
begin
  if not TryMapPublicFormat(AFormat, EngineFormat, LegacyDisplay) then
    Exit('');

  Result := LibPhoneNumber.MetadataFormat.FormatByPattern(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed), AParsed.Extension,
    EngineFormat, AUserDefinedFormats);

  if LegacyDisplay then
    Result := ToLegacyDisplayFormat(Result);
end;

class function TPhoneNumberUtil.FormatNumberForMobileDialing(
  const AParsed: TPhoneNumber; const ARegionCallingFrom: string;
  AWithFormatting: Boolean): string;
begin
  Result := LibPhoneNumber.MetadataFormat.FormatNumberForMobileDialing(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed), AParsed.RawInput,
    AParsed.PreferredDomesticCarrierCode, UpperCase(Trim(ARegionCallingFrom)),
    AWithFormatting);
end;

class function TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(
  const AParsed: TPhoneNumber; const ARegionCallingFrom: string): string;
begin
  Result :=
    LibPhoneNumber.MetadataFormat.FormatOutOfCountryKeepingAlphaChars(
      AParsed.CountryCode, GetNationalNumberDigits(AParsed), AParsed.Extension,
      AParsed.RawInput, UpperCase(Trim(ARegionCallingFrom)));
end;

class function TPhoneNumberUtil.RawInputContainsNationalPrefix(
  const ARawInput, ANationalPrefix, ARegionCode: string): Boolean;
var
  NormalizedNationalNumber: string;
  Candidate: string;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Result := False;
  NormalizedNationalNumber :=
    LibPhoneNumber.MetadataCore.NormalizeDigitsOnly(ARawInput);
  if not StartsWithText(NormalizedNationalNumber, ANationalPrefix) then
    Exit;

  { "Some Japanese numbers (e.g. 00777123) might be mistaken to contain the
    national prefix when written without it (e.g. 0777123) if we just do prefix
    matching. To tackle that, we check the validity of the number if the assumed
    national prefix is removed (777123 won't be valid in Japan)." }
  Candidate := Copy(NormalizedNationalNumber, Length(ANationalPrefix) + 1,
    Length(NormalizedNationalNumber) - Length(ANationalPrefix));
  if not TPhoneNumberUtil.Parse(Candidate, ARegionCode, Parsed,
    ParseError) then
    Exit;

  Result := LibPhoneNumber.MetadataCore.IsValidNumber(Parsed.CountryCode,
    GetNationalNumberDigits(Parsed));
end;

class function TPhoneNumberUtil.FormatInOriginalFormat(
  const AParsed: TPhoneNumber; const ARegionCallingFrom: string): string;
var
  NsnDigits: string;
  FormatRule: PNumberFormatRec;
  FormattedNumber: string;
  RegionCode: string;
  NationalPrefix: string;
  NationalFormat: string;
  CandidateNationalPrefixRule: string;
  IndexOfFirstGroup: Integer;
  UserFormats: TUserNumberFormatArray;
begin
  NsnDigits := GetNationalNumberDigits(AParsed);
  FormatRule := ChooseFormattingPatternForCallingCode(AParsed.CountryCode,
    NsnDigits);

  { "We check if we have the formatting pattern because without that, we might
    format the number as a group without national prefix." Upstream tests
    hasRawInput(); this record models an absent raw input as the empty string,
    so a raw input that was explicitly set to "" is indistinguishable from none
    - a case the parser cannot produce. }
  if (AParsed.RawInput <> '') and (FormatRule = nil) then
    Exit(AParsed.RawInput);

  { Upstream hasCountryCodeSource(): only ParseAndKeepRawInput records it.

    Note which format() this and the branches below call: the ENGINE entry
    point, not the public Format() of this class. The two differ for a number
    without a valid calling code - Format() answers with the empty string
    (its contract since before the metadata switch), while upstream format()
    returns the bare national significant number, and formatInOriginalFormat
    relies on the latter. }
  if AParsed.CountryCodeSource = pnccsUnspecified then
    Exit(LibPhoneNumber.MetadataFormat.FormatNumber(AParsed.CountryCode,
      NsnDigits, AParsed.Extension, mpnfNational));

  case AParsed.CountryCodeSource of
    pnccsFromNumberWithPlusSign:
      FormattedNumber := LibPhoneNumber.MetadataFormat.FormatNumber(
        AParsed.CountryCode, NsnDigits, AParsed.Extension, mpnfInternational);
    pnccsFromNumberWithIdd:
      FormattedNumber := TPhoneNumberUtil.FormatOutOfCountryCallingNumber(
        AParsed, ARegionCallingFrom);
    pnccsFromNumberWithoutPlusSign:
      begin
        { Java: format(number, INTERNATIONAL).substring(1) - the leading plus
          sign is dropped because the caller dialled the number without one. }
        FormattedNumber := LibPhoneNumber.MetadataFormat.FormatNumber(
          AParsed.CountryCode, NsnDigits, AParsed.Extension, mpnfInternational);
        if FormattedNumber <> '' then
          FormattedNumber := Copy(FormattedNumber, 2,
            Length(FormattedNumber) - 1);
      end;
  else
    { FROM_DEFAULT_COUNTRY and the Java default branch. }
    RegionCode := LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(
      AParsed.CountryCode);
    { "We strip non-digits from the NDD here, and from the raw input later, so
      that we can compare them easily." }
    NationalPrefix := LibPhoneNumber.MetadataCore.GetNddPrefixForRegion(
      RegionCode, True);
    NationalFormat := LibPhoneNumber.MetadataFormat.FormatNumber(
      AParsed.CountryCode, NsnDigits, AParsed.Extension, mpnfNational);

    if NationalPrefix = '' then
      { "If the region doesn't have a national prefix at all, we can safely
        return the national format without worrying about a national prefix
        being added." }
      FormattedNumber := NationalFormat
    else if RawInputContainsNationalPrefix(AParsed.RawInput, NationalPrefix,
      RegionCode) then
      { The original number was entered with a national prefix. }
      FormattedNumber := NationalFormat
    else if FormatRule = nil then
      { "The format rule could still be null here if the national number was 0
        and there was no raw input." }
      FormattedNumber := NationalFormat
    else
    begin
      CandidateNationalPrefixRule := FormatRule^.NationalPrefixFormattingRule;
      { "We assume that the first-group symbol will never be _before_ the
        national prefix." Java compares indexOf("$1") <= 0, i.e. "not found" or
        "at the very start"; Delphi's Pos is one based, so the same two cases
        are Pos <= 1. }
      IndexOfFirstGroup := Pos('$1', CandidateNationalPrefixRule);
      if IndexOfFirstGroup <= 1 then
        FormattedNumber := NationalFormat
      else
      begin
        CandidateNationalPrefixRule := Copy(CandidateNationalPrefixRule, 1,
          IndexOfFirstGroup - 1);
        CandidateNationalPrefixRule :=
          LibPhoneNumber.MetadataCore.NormalizeDigitsOnly(
            CandidateNationalPrefixRule);
        if CandidateNationalPrefixRule = '' then
          { National prefix not used when formatting this number. }
          FormattedNumber := NationalFormat
        else
        begin
          { "Otherwise, we need to remove the national prefix from our output."
            Java copies the NumberFormat, clears its
            nationalPrefixFormattingRule and runs formatByPattern with the
            single format. Here that copy is a TUserNumberFormatRec built from
            the chosen generated format: the leadingDigits are materialised out
            of the pool into the record's own array, and the national prefix
            formatting rule is the one field that is deliberately NOT copied. }
          SetLength(UserFormats, 1);
          UserFormats[0].Pattern := FormatRule^.Pattern;
          UserFormats[0].Format := FormatRule^.Format;
          UserFormats[0].LeadingDigits := GetLeadingDigitsPatterns(FormatRule);
          UserFormats[0].NationalPrefixFormattingRule := '';
          UserFormats[0].DomesticCarrierCodeFormattingRule :=
            FormatRule^.DomesticCarrierCodeFormattingRule;
          FormattedNumber := LibPhoneNumber.MetadataFormat.FormatByPattern(
            AParsed.CountryCode, NsnDigits, AParsed.Extension, mpnfNational,
            UserFormats);
        end;
      end;
    end;
  end;

  { "If no digit is inserted/removed/modified as a result of our formatting, we
    return the formatted phone number; otherwise we return the raw input the
    user entered." Java also guards against a null formattedNumber, which a
    Delphi string cannot be. }
  if AParsed.RawInput <> '' then
    if LibPhoneNumber.MetadataCore.NormalizeDiallableCharsOnly(
         FormattedNumber)
       <> LibPhoneNumber.MetadataCore.NormalizeDiallableCharsOnly(
            AParsed.RawInput) then
      FormattedNumber := AParsed.RawInput;

  Result := FormattedNumber;
end;

class function TPhoneNumberUtil.ToLegacyDisplayFormat(
  const AInternational: string): string;
var
  FirstSpace, SecondSpace: Integer;
begin
  Result := AInternational;

  // The legacy display parenthesizes the area-code group. Numbers that have no
  // separate area-code group (e.g. German mobile, formatted as one block) only
  // split into country code + national number, so there is nothing to bracket.
  //
  // "Three space separated parts or more" (empty parts counted) is "at least
  // two spaces", and the rest is the text behind the second space verbatim.
  FirstSpace := Pos(' ', AInternational);
  if FirstSpace = 0 then
    Exit;
  SecondSpace := FirstSpace + 1;
  while (SecondSpace <= Length(AInternational))
    and (AInternational[SecondSpace] <> ' ') do
    Inc(SecondSpace);
  if SecondSpace > Length(AInternational) then
    Exit;

  Result := Copy(AInternational, 1, FirstSpace - 1)
    + ' (' + Copy(AInternational, FirstSpace + 1, SecondSpace - FirstSpace - 1)
    + ') ' + Copy(AInternational, SecondSpace + 1, MaxInt);
end;

class function TPhoneNumberUtil.TryGetCallingCodeForRegion(
  const ARegion: string; out ACode: Integer): Boolean;
begin
  { Upstream getCountryCodeForRegion, minus the "region not supported" logging.
    The region table is the generated metadata. }
  ACode := GetCountryCodeForRegion(UpperCase(Trim(ARegion)));
  Result := ACode <> 0;
end;

class function TPhoneNumberUtil.ResolveRegionForCallingCode(
  const ACountryCode: Integer): string;
begin
  { Upstream getRegionCodeForCountryCode returns the sentinel ZZ for an unknown
    calling code; the record models "no region" as an empty string, which is
    what the previous hand written mapping returned as well. }
  Result := LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(ACountryCode);
  if Result = UnknownRegionCode then
    Result := '';
end;

class function TPhoneNumberUtil.IsValidNumber(const APhoneNumber,
  ACountry: string): Boolean;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  if not Parse(APhoneNumber, ACountry, Parsed, ParseError) then
    Exit(False);

  Result := LibPhoneNumber.MetadataCore.IsValidNumber(
    Parsed.CountryCode, GetNationalNumberDigits(Parsed));
end;

class function TPhoneNumberUtil.IsPossibleNumber(const APhoneNumber,
  ACountry: string): Boolean;
var
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  if not Parse(APhoneNumber, ACountry, Parsed, ParseError) then
    Exit(False);

  Result := LibPhoneNumber.MetadataCore.IsPossibleNumber(
    Parsed.CountryCode, GetNationalNumberDigits(Parsed));
end;

{ ------------------------------------------------------------------
  The record taking validation, typing and region methods. One line each over
  the unit level port; see the interface section.
  ------------------------------------------------------------------ }

class function TPhoneNumberUtil.IsValidNumber(
  const AParsed: TPhoneNumber): Boolean;
begin
  Result := LibPhoneNumber.MetadataCore.IsValidNumber(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed));
end;

class function TPhoneNumberUtil.IsValidNumberForRegion(
  const AParsed: TPhoneNumber; const ARegion: string): Boolean;
begin
  Result := LibPhoneNumber.MetadataCore.IsValidNumberForRegion(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed),
    UpperCase(Trim(ARegion)));
end;

class function TPhoneNumberUtil.GetNumberType(
  const AParsed: TPhoneNumber): TMetadataNumberType;
begin
  Result := LibPhoneNumber.MetadataCore.GetNumberType(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed));
end;

class function TPhoneNumberUtil.GetRegionCodeForNumber(
  const AParsed: TPhoneNumber): string;
begin
  Result := LibPhoneNumber.MetadataCore.GetRegionCodeForNumber(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed));
end;

class function TPhoneNumberUtil.IsPossibleNumber(
  const AParsed: TPhoneNumber): Boolean;
begin
  Result := LibPhoneNumber.MetadataCore.IsPossibleNumber(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed));
end;

class function TPhoneNumberUtil.IsPossibleNumberWithReason(
  const AParsed: TPhoneNumber): TMetadataValidationResult;
begin
  Result := LibPhoneNumber.MetadataCore.IsPossibleNumberWithReason(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed));
end;

class function TPhoneNumberUtil.IsPossibleNumberForType(
  const AParsed: TPhoneNumber; AType: TMetadataNumberType): Boolean;
begin
  Result := LibPhoneNumber.MetadataCore.IsPossibleNumberForType(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed), AType);
end;

class function TPhoneNumberUtil.IsPossibleNumberForTypeWithReason(
  const AParsed: TPhoneNumber;
  AType: TMetadataNumberType): TMetadataValidationResult;
begin
  Result := LibPhoneNumber.MetadataCore.IsPossibleNumberForTypeWithReason(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed), AType);
end;

class function TPhoneNumberUtil.CanBeInternationallyDialled(
  const AParsed: TPhoneNumber): Boolean;
begin
  Result := LibPhoneNumber.MetadataFormat.CanBeInternationallyDialled(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed));
end;

class function TPhoneNumberUtil.GetNationalNumberDigits(
  const AParsed: TPhoneNumber): string;
begin
  if AParsed.NationalNumberDigits <> '' then
    Exit(AParsed.NationalNumberDigits);

  if AParsed.NationalNumber > 0 then
    Exit(UIntToStr(AParsed.NationalNumber));

  Result := '';
end;

{ Upstream maybeStripInternationalPrefixAndNormalize(number, possibleIddPrefix),
  in upstream order. PLUS_CHARS_PATTERN.lookingAt() is the UTF-16 test of
  StartsWithPlusChar, and number.delete(0, m.end()) removes the whole plus RUN
  the pattern matches (StripLeadingPlusRun). normalize(number) is
  NormalizeAlphaPhoneOrDigits; the iddPattern that upstream takes from its
  regexCache is compiled and cached by the regex layer behind
  ParsePrefixAsIdd.

  Upstream compiles the iddPattern BEFORE it normalises the number, so a
  malformed pattern throws (PatternSyntaxException, an
  IllegalArgumentException) with the number untouched. The compile probe of
  the regex layer (TryCompilePattern) runs at the same point here and its
  failure is raised as EArgumentException. The empty pattern is not compiled:
  the probe rejects it by contract, and ParsePrefixAsIdd answers it without an
  engine (see there). }
class function TPhoneNumberUtil.MaybeStripInternationalPrefixAndNormalize(
  var ANumber: string; const APossibleIddPrefix: string): TCountryCodeSource;
var
  CompileError: string;
begin
  if ANumber = '' then
    Exit(pnccsFromDefaultCountry);

  // "Check to see if the number begins with one or more plus signs."
  if StartsWithPlusChar(ANumber) then
  begin
    ANumber := StripLeadingPlusRun(ANumber);
    // "Can now normalize the rest of the number since we've consumed the "+"
    // sign at the start."
    ANumber := LibPhoneNumber.MetadataCore.NormalizeAlphaPhoneOrDigits(ANumber);
    Exit(pnccsFromNumberWithPlusSign);
  end;

  // "Attempt to parse the first digits as an international prefix."
  if (APossibleIddPrefix <> '')
    and not TryCompilePattern(APossibleIddPrefix, CompileError) then
    raise EArgumentException.CreateFmt(
      'Invalid international prefix pattern "%s": %s',
      [APossibleIddPrefix, CompileError]);
  ANumber := LibPhoneNumber.MetadataCore.NormalizeAlphaPhoneOrDigits(ANumber);
  if ParsePrefixAsIdd(APossibleIddPrefix, ANumber) then
    Result := pnccsFromNumberWithIdd
  else
    Result := pnccsFromDefaultCountry;
end;

{ Upstream maybeExtractCountryCode(number, defaultRegionMetadata,
  nationalNumber, keepRawInput, phoneNumber), in upstream order.

  Java throws two error types out of this method and returns 0 for "no country
  calling code present"; this port reports the throw as a False result with
  AError set, and keeps the 0 return as ACountryCode = 0 with a True result.
  The contract of the out and var parameters is in the interface section. }
class function TPhoneNumberUtil.TryMaybeExtractCountryCode(
  const ANumber: string; ADefaultRegionMetadata: PPhoneMetadataRec;
  var ANationalNumber: string; AKeepRawInput: Boolean;
  var APhoneNumber: TPhoneNumber; out ACountryCode: Integer;
  out AError: TPhoneNumberParseError): Boolean;
var
  FullNumber: string;
  PossibleCountryIddPrefix: string;
  Source: TCountryCodeSource;
  PotentialCountryCode: Integer;
  ExtractedNationalNumber: string;
  DefaultCountryCode: Integer;
  DefaultCountryCodeString: string;
  PotentialNationalNumber: string;
  CarrierCode: string;
  GeneralDesc: PPhoneNumberDescRec;
begin
  ACountryCode := 0;
  AError := pnpeNone;

  if ANumber = '' then
    Exit(True);

  FullNumber := ANumber;
  // "Set the default prefix to be something that will never match."
  PossibleCountryIddPrefix := 'NonMatch';
  if ADefaultRegionMetadata <> nil then
    PossibleCountryIddPrefix := ADefaultRegionMetadata^.InternationalPrefix;

  Source := MaybeStripInternationalPrefixAndNormalize(FullNumber,
    PossibleCountryIddPrefix);
  if AKeepRawInput then
    APhoneNumber.CountryCodeSource := Source;

  if Source <> pnccsFromDefaultCountry then
  begin
    if Length(FullNumber) <= MinLengthForNsn then
    begin
      // "Phone number had an IDD, but after this was not long enough to be a
      // viable phone number."
      AError := pnpeTooShortAfterIdd;
      Exit(False);
    end;

    PotentialCountryCode := ExtractCountryCode(FullNumber,
      ExtractedNationalNumber);
    if PotentialCountryCode <> 0 then
    begin
      ANationalNumber := ANationalNumber + ExtractedNationalNumber;
      APhoneNumber.CountryCode := PotentialCountryCode;
      ACountryCode := PotentialCountryCode;
      Exit(True);
    end;

    // "If this fails, they must be using a strange country calling code that
    // we don't recognize, or that doesn't exist."
    AError := pnpeInvalidCountryCode;
    Exit(False);
  end
  else if ADefaultRegionMetadata <> nil then
  begin
    // "Check to see if the number starts with the country calling code for the
    // default region. If so, we remove the country calling code, and do some
    // checks on the validity of the number before and after."
    DefaultCountryCode := ADefaultRegionMetadata^.CountryCode;
    DefaultCountryCodeString := IntToStr(DefaultCountryCode);
    if StartsWithText(FullNumber, DefaultCountryCodeString) then
    begin
      PotentialNationalNumber := Copy(FullNumber,
        Length(DefaultCountryCodeString) + 1, MaxInt);
      GeneralDesc := GetDesc(ADefaultRegionMetadata, pdkGeneralDesc);
      // Upstream passes null: "Don't need the carrier code".
      MaybeStripNationalPrefixAndCarrierCode(PotentialNationalNumber,
        ADefaultRegionMetadata, CarrierCode);
      // "If the number was not valid before but is valid now, or if it was too
      // long before, we consider the number with the country calling code
      // stripped to be a better result and keep that instead."
      if (not MatchesNationalNumberPattern(FullNumber, GeneralDesc)
            and MatchesNationalNumberPattern(PotentialNationalNumber, GeneralDesc))
        or (TestNumberLength(FullNumber, ADefaultRegionMetadata) = mvrTooLong) then
      begin
        ANationalNumber := ANationalNumber + PotentialNationalNumber;
        if AKeepRawInput then
          APhoneNumber.CountryCodeSource := pnccsFromNumberWithoutPlusSign;
        APhoneNumber.CountryCode := DefaultCountryCode;
        ACountryCode := DefaultCountryCode;
        Exit(True);
      end;
    end;
  end;

  // "No country calling code present."
  APhoneNumber.CountryCode := 0;
  ACountryCode := 0;
  Result := True;
end;

class function TPhoneNumberUtil.Parse(const APhoneNumber, ACountry: string;
  out AParsed: TPhoneNumber; out AError: TPhoneNumberParseError): Boolean;
begin
  Result := ParseHelper(APhoneNumber, ACountry, False, True, AParsed, AError);
end;

class function TPhoneNumberUtil.ParseAndKeepRawInput(const APhoneNumber,
  ACountry: string; out AParsed: TPhoneNumber;
  out AError: TPhoneNumberParseError): Boolean;
begin
  Result := ParseHelper(APhoneNumber, ACountry, True, True, AParsed, AError);
end;

class function TPhoneNumberUtil.ParseHelper(const APhoneNumber,
  ACountry: string; AKeepRawInput, ACheckRegion: Boolean;
  out AParsed: TPhoneNumber; out AError: TPhoneNumberParseError): Boolean;
const
  // Upstream MAX_LENGTH_FOR_NSN. The national significant number is carried as
  // a string, so this is a pure upstream compatibility bound and no longer a
  // UInt64 overflow guard: Java and C# report TOO_LONG from 18 digits on.
  MaxNsnDigits = MaxLengthForNsn;
  // Upstream MAX_INPUT_STRING_LENGTH, the first guard of parseHelper. Java
  // reports it as TOO_LONG, which this port spells pnpeTooLongNsn - the enum
  // has no separate "input too long" member and upstream uses the same error
  // type for both.
  MaxInputStringLength = 250;
var
  NationalNumberText: string;
  Extension: string;
  NationalDigits: string;
  PotentialNationalNumber: string;
  CarrierCode: string;
  DefaultRegion: string;
  DefaultMetadata: PPhoneMetadataRec;
  RegionMetadata: PPhoneMetadataRec;
  HasDefaultMetadata: Boolean;
  StartsWithPlus: Boolean;
  PhoneNumberRegion: string;
  CountryCode: Integer;
  RegionCallingCode: Integer;
  CountryCodeWasExtracted: Boolean;
  ExtractTarget: TPhoneNumber;
  LengthResult: TMetadataValidationResult;
begin
  AParsed := Default(TPhoneNumber);
  DefaultRegion := UpperCase(Trim(ACountry));
  AParsed.RegionCode := DefaultRegion;

  // Java String.length(), i.e. UTF-16 code units - on FreePascal `string` is
  // UTF-8 and its byte length is not that.
  if Length(UnicodeString(APhoneNumber)) > MaxInputStringLength then
  begin
    AError := pnpeTooLongNsn;
    Exit(False);
  end;

  // Port of buildNationalNumberForParsing: the RFC3966 tel: URI with its
  // phone-context and isdn-subaddress parameters, or - for everything else -
  // extractPossibleNumber. False is the single NOT_A_NUMBER the upstream
  // method throws itself, "The phone-context value is invalid."
  if not LibPhoneNumber.MetadataCore.TryBuildNationalNumberForParsing(
    APhoneNumber, NationalNumberText) then
  begin
    AError := pnpeNotANumber;
    Exit(False);
  end;

  // The "not a number" gate. This IS upstream's
  // isViablePhoneNumber (VALID_PHONE_NUMBER_PATTERN applied with matches());
  // the weaker "the input must contain at least one ASCII digit" rule this
  // port used before is gone.
  if not LibPhoneNumber.MetadataCore.IsViablePhoneNumber(
    NationalNumberText) then
  begin
    AError := pnpeNotANumber;
    Exit(False);
  end;

  HasDefaultMetadata := TryGetMetadataForRegion(DefaultRegion, DefaultMetadata);
  StartsWithPlus := StartsWithPlusChar(NationalNumberText);

  // Port of checkRegionForParsing: an unsupported default region is only
  // acceptable when the number carries its own plus sign, because the region
  // can then be inferred from the calling code. Upstream skips this check
  // entirely when checkRegion is false, which is the isNumberMatch path.
  if ACheckRegion and not HasDefaultMetadata and not StartsWithPlus then
  begin
    AError := pnpeInvalidCountryCode;
    Exit(False);
  end;

  // Upstream parseHelper sets rawInput only when keepRawInput is requested, so
  // Parse leaves the field empty just like CountryCodeSource and
  // PreferredDomesticCarrierCode. Note it stores the ORIGINAL input, not the
  // string buildNationalNumberForParsing produced.
  if AKeepRawInput then
    AParsed.RawInput := APhoneNumber;

  // "Attempt to parse extension first, since it doesn't require region-
  // specific data and we want to have the non-normalised number here."
  Extension := LibPhoneNumber.MetadataCore.MaybeStripExtension(
    NationalNumberText);
  if Extension <> '' then
    AParsed.Extension := Extension;

  // Port of maybeExtractCountryCode plus the catch/retry that surrounds its
  // call in parseHelper: when the FIRST attempt fails with
  // INVALID_COUNTRY_CODE and the number starts with a run of plus characters,
  // Java strips that run and tries once more. That second attempt runs the
  // whole method again, so the international prefix of the default region gets
  // its chance - which is what makes "+01164 3 331 6005" dialled in the US the
  // New Zealand number +64 3 331 6005: the leading plus is a typo, the real
  // prefix is the NANPA IDD 011.
  //
  // Java hands its PhoneNumber to maybeExtractCountryCode. Here the step
  // writes into a SCRATCH record with keepRawInput forced on, so the country
  // code source is always available and AParsed stays untouched until parsing
  // succeeds; the keepRawInput gate is applied at the end, where it always
  // was. The scratch source is preset to FROM_DEFAULT_COUNTRY for the empty
  // input, the one case in which the step does not write it (unreachable:
  // IsViablePhoneNumber guarantees a digit).
  NationalDigits := '';
  ExtractTarget := Default(TPhoneNumber);
  ExtractTarget.CountryCodeSource := pnccsFromDefaultCountry;
  if not TryMaybeExtractCountryCode(NationalNumberText, DefaultMetadata,
    NationalDigits, True, ExtractTarget, CountryCode, AError) then
  begin
    if (AError <> pnpeInvalidCountryCode) or not StartsWithPlus then
      Exit(False);

    // "Strip the plus-char, and try again." PLUS_CHARS_PATTERN matches a RUN,
    // and Java continues behind the whole match. A failed attempt leaves
    // NationalDigits unchanged (empty), as upstream's StringBuilder.
    if not TryMaybeExtractCountryCode(StripLeadingPlusRun(NationalNumberText),
      DefaultMetadata, NationalDigits, True, ExtractTarget, CountryCode,
      AError) then
      Exit(False);

    if CountryCode = 0 then
    begin
      // "Could not interpret numbers after plus-sign."
      AError := pnpeInvalidCountryCode;
      Exit(False);
    end;
  end;

  // Upstream parseHelper re-resolves the region metadata only when a calling
  // code was actually extracted, so the distinction is tracked here.
  CountryCodeWasExtracted := CountryCode <> 0;

  if not CountryCodeWasExtracted then
  begin
    // "If no extracted country calling code, use the region supplied instead.
    // The national number is just the normalized version of the number we were
    // given to parse."
    NationalDigits := LibPhoneNumber.MetadataCore
      .NormalizeAlphaPhoneOrDigits(NationalNumberText);
    if HasDefaultMetadata then
      CountryCode := DefaultMetadata^.CountryCode;
    // Without default metadata the calling code stays 0. That is only
    // reachable with ACheckRegion = False, i.e. from isNumberMatch, which is
    // exactly the upstream "defaultRegion == null" case.
  end;

  // REPORTED region. Deliberate deviation from upstream, which carries no
  // region on the phone number at all: keep the caller-supplied region when it
  // belongs to the extracted calling code (e.g. CA for +1, which the
  // code->region map cannot disambiguate), otherwise resolve the primary
  // region for the calling code.
  if not (TryGetCallingCodeForRegion(DefaultRegion, RegionCallingCode)
    and (RegionCallingCode = CountryCode)) then
    AParsed.RegionCode := ResolveRegionForCallingCode(CountryCode);

  // METADATA for the national prefix step. This is NOT the reported region.
  // parseHelper starts with getMetadataForRegion(defaultRegion) and replaces
  // it only when a calling code was actually extracted and its MAIN region
  // differs from the default region, so for a shared calling code the main
  // region wins: +1 2345678 dialled with default region BB is stripped with US
  // metadata, which leaves it untouched, while the same number dialled locally
  // as 2345678 keeps BB metadata and is expanded to 2462345678 by the BB rule
  // nationalPrefixForParsing "1|([2-8]\d{6})$" / transform "246$1".
  RegionMetadata := nil;
  if HasDefaultMetadata then
    RegionMetadata := DefaultMetadata;
  if CountryCodeWasExtracted then
  begin
    PhoneNumberRegion :=
      LibPhoneNumber.MetadataCore.GetRegionCodeForCountryCode(CountryCode);
    if PhoneNumberRegion <> DefaultRegion then
      if not TryGetMetadataForRegionOrCallingCode(CountryCode, PhoneNumberRegion,
        RegionMetadata) then
        RegionMetadata := nil;
  end;

  // Port of the national prefix step of parseHelper. The strip is only kept
  // when the remaining number still has a possible length for the region;
  // otherwise the original number could be a valid short number.
  if RegionMetadata <> nil then
  begin
    PotentialNationalNumber := NationalDigits;
    MaybeStripNationalPrefixAndCarrierCode(PotentialNationalNumber,
      RegionMetadata, CarrierCode);
    LengthResult := TestNumberLength(PotentialNationalNumber, RegionMetadata);
    if (LengthResult <> mvrTooShort)
      and (LengthResult <> mvrIsPossibleLocalOnly)
      and (LengthResult <> mvrInvalidLength) then
    begin
      NationalDigits := PotentialNationalNumber;
      if AKeepRawInput and (CarrierCode <> '') then
        AParsed.PreferredDomesticCarrierCode := CarrierCode;
    end;
  end;

  if Length(NationalDigits) < MinLengthForNsn then
  begin
    AError := pnpeTooShortNsn;
    Exit(False);
  end;

  if Length(NationalDigits) > MaxNsnDigits then
  begin
    AError := pnpeTooLongNsn;
    Exit(False);
  end;

  AParsed.CountryCode := CountryCode;
  AParsed.NationalNumberDigits := NationalDigits;
  AParsed.NationalNumber := StrToUInt64Def(NationalDigits, 0);

  // Upstream only records the country code source when parsing with
  // keepRawInput; Parse leaves the field at pnccsUnspecified.
  if AKeepRawInput then
    AParsed.CountryCodeSource := ExtractTarget.CountryCodeSource;

  AError := pnpeNone;
  Result := True;
end;

{ ------------------------------------------------------------------
  isNumberMatch.
  ------------------------------------------------------------------ }

{ Upstream isNationalNumberSuffixOfTheOther. Note it compares
  String.valueOf(getNationalNumber()), i.e. the NUMERIC national number, so a
  significant leading zero does NOT take part in the suffix test - which is
  exactly why the presence or absence of an "Italian leading zero" degrades an
  EXACT_MATCH to SHORT_NSN_MATCH rather than to NO_MATCH. }
{ The national significant number of ARecord in its CANONICAL form.

  TPhoneNumber carries the same value twice - as the digit string
  NationalNumberDigits (leading zeros included, upstream's
  getNationalSignificantNumber) and as the numeric NationalNumber (upstream's
  national_number field). Everything the parser produces fills BOTH, but
  IsNumberMatch is a public entry point that also accepts records a caller
  built by hand, and such a record may well carry only one of the two. Both
  comparisons below therefore go through this canonicalisation - which is the
  existing GetNationalNumberDigits fallback - instead of reading one field
  directly. }
class function TPhoneNumberUtil.CanonicalNationalNumberDigits(
  const ARecord: TPhoneNumber): string;
begin
  Result := GetNationalNumberDigits(ARecord);
end;

{ The same value as upstream String.valueOf(getNationalNumber()) would print:
  the canonical digits WITHOUT their leading zeros, because national_number is
  a number and the leading zeros live in italian_leading_zero /
  number_of_leading_zeros. An unset national number prints as "0" upstream, and
  StrToUInt64Def turns the empty digit string into exactly that. }
class function TPhoneNumberUtil.CanonicalNationalNumberValue(
  const ARecord: TPhoneNumber): string;
begin
  Result := UIntToStr(StrToUInt64Def(CanonicalNationalNumberDigits(ARecord), 0));
end;

class function TPhoneNumberUtil.IsNationalNumberSuffixOfTheOther(
  const AFirst, ASecond: TPhoneNumber): Boolean;
var
  First, Second: string;
begin
  First := CanonicalNationalNumberValue(AFirst);
  Second := CanonicalNationalNumberValue(ASecond);
  { Java's endsWith returns true when the numbers are equal. }
  Result := EndsWithText(First, Second) or EndsWithText(Second, First);
end;

{ Upstream PhoneNumber.exactlySameAs() over the fields copyCoreFieldsOnly
  keeps: country_code, national_number, extension, italian_leading_zero and
  number_of_leading_zeros. The last three of those five are one field here -
  NationalNumberDigits carries the national significant number as a string, so
  comparing it covers the numeric value AND the leading zeros at once. An
  unset extension is the empty string, which is how copyCoreFieldsOnly models
  it as well ("if length > 0"). }
class function TPhoneNumberUtil.CoreFieldsEqual(const AFirst,
  ASecond: TPhoneNumber): Boolean;
begin
  Result := (AFirst.CountryCode = ASecond.CountryCode)
    and (CanonicalNationalNumberDigits(AFirst)
      = CanonicalNationalNumberDigits(ASecond))
    and (AFirst.Extension = ASecond.Extension);
end;

class function TPhoneNumberUtil.IsNumberMatch(const AFirst,
  ASecond: TPhoneNumber): TPhoneNumberMatchType;
var
  First, Second: TPhoneNumber;
begin
  { Java copies the core fields explicitly (copyCoreFieldsOnly) so that the
    context fields - raw input, country code source, carrier code and, here,
    the region - cannot influence the comparison. CoreFieldsEqual reads exactly
    those fields, so the copy is a plain assignment. }
  First := AFirst;
  Second := ASecond;

  { "Early exit if both had extensions and these are different." }
  if (First.Extension <> '') and (Second.Extension <> '')
    and (First.Extension <> Second.Extension) then
    Exit(pnmtNoMatch);

  { Both had country_code specified. }
  if (First.CountryCode <> 0) and (Second.CountryCode <> 0) then
  begin
    if CoreFieldsEqual(First, Second) then
      Exit(pnmtExactMatch);
    if (First.CountryCode = Second.CountryCode)
      and IsNationalNumberSuffixOfTheOther(First, Second) then
      { "A SHORT_NSN_MATCH occurs if there is a difference because of the
        presence or absence of an 'Italian leading zero', the presence or
        absence of an extension, or one NSN being a shorter variant of the
        other." }
      Exit(pnmtShortNsnMatch);
    Exit(pnmtNoMatch);
  end;

  { "Checks cases where one or both country_code fields were not specified. To
    make equality checks easier, we first set the country_code fields to be
    equal." }
  First.CountryCode := Second.CountryCode;
  if CoreFieldsEqual(First, Second) then
    Exit(pnmtNsnMatch);
  if IsNationalNumberSuffixOfTheOther(First, Second) then
    Exit(pnmtShortNsnMatch);
  Result := pnmtNoMatch;
end;

class function TPhoneNumberUtil.IsNumberMatch(const AFirst: TPhoneNumber;
  const ASecond: string): TPhoneNumberMatchType;
var
  SecondParsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  FirstNumberRegion: string;
  Match: TPhoneNumberMatchType;
begin
  { "First see if the second number has an implicit country calling code, by
    attempting to parse it." }
  if Parse(ASecond, UnknownRegionCode, SecondParsed, ParseError) then
    Exit(IsNumberMatch(AFirst, SecondParsed));

  { Java only continues on INVALID_COUNTRY_CODE and reports NOT_A_NUMBER for
    every other failure. }
  if ParseError <> pnpeInvalidCountryCode then
    Exit(pnmtNotANumber);

  { "The second number has no country calling code. EXACT_MATCH is no longer
    possible. We parse it as if the region was the same as that for the first
    number, and if EXACT_MATCH is returned, we replace this with NSN_MATCH." }
  FirstNumberRegion := LibPhoneNumber.MetadataCore
    .GetRegionCodeForCountryCode(AFirst.CountryCode);
  if FirstNumberRegion <> UnknownRegionCode then
  begin
    if not Parse(ASecond, FirstNumberRegion, SecondParsed, ParseError) then
      Exit(pnmtNotANumber);
    Match := IsNumberMatch(AFirst, SecondParsed);
    if Match = pnmtExactMatch then
      Exit(pnmtNsnMatch);
    Exit(Match);
  end;

  { "If the first number didn't have a valid country calling code, then we
    parse the second number without one as well." }
  if not ParseHelper(ASecond, '', False, False, SecondParsed, ParseError) then
    Exit(pnmtNotANumber);
  Result := IsNumberMatch(AFirst, SecondParsed);
end;

class function TPhoneNumberUtil.IsNumberMatch(const AFirst,
  ASecond: string): TPhoneNumberMatchType;
var
  FirstParsed, SecondParsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  if Parse(AFirst, UnknownRegionCode, FirstParsed, ParseError) then
    Exit(IsNumberMatch(FirstParsed, ASecond));
  if ParseError <> pnpeInvalidCountryCode then
    Exit(pnmtNotANumber);

  if Parse(ASecond, UnknownRegionCode, SecondParsed, ParseError) then
    Exit(IsNumberMatch(SecondParsed, AFirst));
  if ParseError <> pnpeInvalidCountryCode then
    Exit(pnmtNotANumber);

  { Neither string carries a calling code of its own. Java falls back to
    parseHelper(number, null, false, false, ...), i.e. no default region and no
    region check, which yields two numbers with country_code 0. }
  if not ParseHelper(AFirst, '', False, False, FirstParsed, ParseError) then
    Exit(pnmtNotANumber);
  if not ParseHelper(ASecond, '', False, False, SecondParsed, ParseError) then
    Exit(pnmtNotANumber);
  Result := IsNumberMatch(FirstParsed, SecondParsed);
end;

{ ------------------------------------------------------------------
  Accessory API.
  ------------------------------------------------------------------ }

class function TPhoneNumberUtil.GetNationalSignificantNumber(
  const AParsed: TPhoneNumber): string;
const
  { Upstream: "Defensively cap the number of leading zeros to avoid OOM from
    malicious input" - Math.min(number.getNumberOfLeadingZeros(), 10). }
  MaxLeadingZeros = 10;
var
  Digits: string;
  ZeroCount: Integer;
begin
  Digits := GetNationalNumberDigits(AParsed);

  { Java appends getNationalNumber() unconditionally, so a number without a
    national number (the proto default 0) prints as "0", not as the empty
    string. GetNationalNumberDigits keeps answering '' there because the
    format and validation paths test for exactly that. }
  if Digits = '' then
    Exit(UIntToStr(AParsed.NationalNumber));

  { The leading zeros of the digits are Java's numberOfLeadingZeros, counted
    the way setItalianLeadingZerosForPhoneNumber counts them (never the last
    digit). Java caps that prefix at ten zeros when it BUILDS the string; the
    rest is String.valueOf(nationalNumber). The oracle 9.0.41 does the same
    (Parse("+100000000000650", "ZZ") -> "0000000000650").

    Scope: only this public method applies the cap. The other entry points
    read the record's digits uncapped, so for a number with MORE than ten
    leading zeros - never a valid number - format/validation see one more
    zero than Java would. Documented divergence, deliberately not spread
    into GetNationalNumberDigits. }
  ZeroCount := 0;
  if (Length(Digits) > 1) and (Digits[1] = '0') then
  begin
    ZeroCount := 1;
    while (ZeroCount < Length(Digits) - 1) and (Digits[ZeroCount + 1] = '0') do
      Inc(ZeroCount);
  end;
  if ZeroCount > MaxLeadingZeros then
    Result := StringOfChar('0', MaxLeadingZeros)
      + Copy(Digits, ZeroCount + 1, MaxInt)
  else
    Result := Digits;
end;

class function TPhoneNumberUtil.IsNumberGeographical(
  const AParsed: TPhoneNumber): Boolean;
begin
  Result := LibPhoneNumber.MetadataCore.IsNumberGeographical(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed));
end;

class function TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(
  const AParsed: TPhoneNumber): Integer;
begin
  Result := LibPhoneNumber.MetadataFormat.GetLengthOfGeographicalAreaCode(
    AParsed.CountryCode, GetNationalNumberDigits(AParsed), AParsed.RawInput);
end;

class function TPhoneNumberUtil.GetLengthOfNationalDestinationCode(
  const AParsed: TPhoneNumber): Integer;
begin
  Result :=
    LibPhoneNumber.MetadataFormat.GetLengthOfNationalDestinationCode(
      AParsed.CountryCode, GetNationalNumberDigits(AParsed), AParsed.RawInput);
end;

class function TPhoneNumberUtil.GetCountryMobileToken(
  ACountryCode: Integer): string;
begin
  Result := LibPhoneNumber.MetadataCore.GetCountryMobileToken(
    ACountryCode);
end;

class function TPhoneNumberUtil.GetSupportedTypesForRegion(
  const ARegion: string): TMetadataNumberTypes;
begin
  Result := LibPhoneNumber.MetadataCore.GetSupportedTypesForRegion(
    UpperCase(Trim(ARegion)));
end;

class function TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(
  ACountryCode: Integer): TMetadataNumberTypes;
begin
  Result := LibPhoneNumber.MetadataCore.GetSupportedTypesForNonGeoEntity(
    ACountryCode);
end;

class function TPhoneNumberUtil.TryGetExampleNumber(const ARegion: string;
  out ANumber: TPhoneNumber): Boolean;
begin
  Result := TryGetExampleNumberForType(ARegion, mntFixedLine, ANumber);
end;

class function TPhoneNumberUtil.TryGetExampleNumberForType(
  const ARegion: string; AType: TMetadataNumberType;
  out ANumber: TPhoneNumber): Boolean;
var
  Region: string;
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  ParseError: TPhoneNumberParseError;
begin
  ANumber := Default(TPhoneNumber);
  Region := UpperCase(Trim(ARegion));

  { "Check the region code is valid." isValidRegionCode plus
    getMetadataForRegion in one step. }
  if not TryGetMetadataForRegion(Region, Metadata) then
    Exit(False);

  Desc := GetNumberDescByType(Metadata, AType);
  if (Desc <> nil) and (Desc^.ExampleNumber <> '') then
  begin
    { Java catches the NumberParseException, logs it and returns null. }
    if Parse(Desc^.ExampleNumber, Region, ANumber, ParseError) then
      Exit(True);
    ANumber := Default(TPhoneNumber);
  end;
  Result := False;
end;

class function TPhoneNumberUtil.TryGetExampleNumberForType(
  AType: TMetadataNumberType; out ANumber: TPhoneNumber): Boolean;
var
  Regions: TMetadataStringArray;
  CallingCodes: TMetadataIntegerArray;
  I: Integer;
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  ParseError: TPhoneNumberParseError;
begin
  Regions := LibPhoneNumber.Metadata.GetSupportedRegions;
  for I := 0 to Length(Regions) - 1 do
    if TryGetExampleNumberForType(Regions[I], AType, ANumber) then
      Exit(True);

  { "If there wasn't an example number for a region, try the
    non-geographical entities." }
  CallingCodes := GetSupportedGlobalNetworkCallingCodes;
  for I := 0 to Length(CallingCodes) - 1 do
  begin
    if not TryGetMetadataForNonGeoEntity(CallingCodes[I], Metadata) then
      Continue;
    Desc := GetNumberDescByType(Metadata, AType);
    if (Desc <> nil) and (Desc^.ExampleNumber <> '') then
    begin
      if Parse('+' + IntToStr(CallingCodes[I]) + Desc^.ExampleNumber,
        UnknownRegionCode, ANumber, ParseError) then
        Exit(True);
    end;
  end;

  { "There are no example numbers of this type for any country in the
    library." }
  ANumber := Default(TPhoneNumber);
  Result := False;
end;

class function TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(
  ACountryCode: Integer; out ANumber: TPhoneNumber): Boolean;
const
  { "For geographical entities, fixed-line data is always present. However,
    for non-geographical entities, this is not the case, so we have to go
    through different types to find the example number. We don't check
    fixed-line or personal number since they aren't used by non-geographical
    entities." The upstream list, in upstream order. }
  CandidateKinds: array[0..6] of TPhoneNumberDescKind = (
    pdkMobile, pdkTollFree, pdkSharedCost, pdkVoip, pdkVoicemail, pdkUan,
    pdkPremiumRate);
var
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  I: Integer;
  ParseError: TPhoneNumberParseError;
begin
  ANumber := Default(TPhoneNumber);
  if not TryGetMetadataForNonGeoEntity(ACountryCode, Metadata) then
    Exit(False);

  for I := Low(CandidateKinds) to High(CandidateKinds) do
  begin
    Desc := GetDesc(Metadata, CandidateKinds[I]);
    if (Desc <> nil) and (Desc^.ExampleNumber <> '') then
    begin
      if Parse('+' + IntToStr(ACountryCode) + Desc^.ExampleNumber,
        UnknownRegionCode, ANumber, ParseError) then
        Exit(True);
      ANumber := Default(TPhoneNumber);
    end;
  end;
  Result := False;
end;

class function TPhoneNumberUtil.TryGetInvalidExampleNumber(
  const ARegion: string; out ANumber: TPhoneNumber): Boolean;
var
  Region: string;
  Metadata: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  ExampleNumber: string;
  PhoneNumberLength: Integer;
  PossiblyValidNumber: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  ANumber := Default(TPhoneNumber);
  Region := UpperCase(Trim(ARegion));
  if not TryGetMetadataForRegion(Region, Metadata) then
    Exit(False);

  { "We start off with a valid fixed-line number since every country supports
    this." }
  Desc := GetNumberDescByType(Metadata, mntFixedLine);
  if (Desc = nil) or (Desc^.ExampleNumber = '') then
    { "This shouldn't happen; we have a test for this." }
    Exit(False);
  ExampleNumber := Desc^.ExampleNumber;

  { "Try and make the number invalid. We do this by changing the length. We
    try reducing the length of the number, since currently no region has a
    number that is the same length as MIN_LENGTH_FOR_NSN." }
  for PhoneNumberLength := Length(ExampleNumber) - 1 downto MinLengthForNsn do
  begin
    { Java: try parse(...) catch (NumberParseException) - "Shouldn't happen". }
    if not Parse(Copy(ExampleNumber, 1, PhoneNumberLength), Region,
      PossiblyValidNumber, ParseError) then
      Continue;
    if not LibPhoneNumber.MetadataCore.IsValidNumber(
      PossiblyValidNumber.CountryCode,
      GetNationalNumberDigits(PossiblyValidNumber)) then
    begin
      ANumber := PossiblyValidNumber;
      Exit(True);
    end;
  end;

  { "We have a test to check that this doesn't happen for any of our
    supported regions." }
  Result := False;
end;

class function TPhoneNumberUtil.TruncateTooLongNumber(
  var ANumber: TPhoneNumber): Boolean;
var
  Original, Digits: string;
begin
  Original := GetNationalNumberDigits(ANumber);
  Digits := Original;
  Result := LibPhoneNumber.MetadataCore.TruncateTooLongNumber(
    ANumber.CountryCode, Digits);
  if Result and (Digits <> Original) then
  begin
    ANumber.NationalNumberDigits := Digits;
    ANumber.NationalNumber := StrToUInt64Def(Digits, 0);
  end;
end;

class function TPhoneNumberUtil.IsAlphaNumber(const ANumber: string): Boolean;
begin
  Result := LibPhoneNumber.MetadataCore.IsAlphaNumber(ANumber);
end;

end.
