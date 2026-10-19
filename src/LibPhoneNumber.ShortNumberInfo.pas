unit LibPhoneNumber.ShortNumberInfo;

{
  Short number information.

  A literal port of upstream
  com/google/i18n/phonenumbers/ShortNumberInfo.java (Java is the source of
  truth; the C# port was used as a translation aid only). Ported methods, in
  upstream declaration order:

    getRegionCodesForCountryCode       -> (the phone metadata lookup
                                          LibPhoneNumber.Metadata
                                          .GetRegionCodesForCountryCode)
    regionDialingFromMatchesNumber     -> RegionDialingFromMatchesNumber
    getShortNumberMetadataForRegion    -> (the Try* lookup of
                                          LibPhoneNumber.ShortMetadata)
    isPossibleShortNumberForRegion     -> IsPossibleShortNumberForRegion
    isPossibleShortNumber              -> IsPossibleShortNumber
    isValidShortNumberForRegion        -> IsValidShortNumberForRegion
    isValidShortNumber                 -> IsValidShortNumber
    getExpectedCostForRegion           -> GetExpectedCostForRegion
    getExpectedCost                    -> GetExpectedCost
    getRegionCodeForShortNumberFromRegionList
                                       -> GetRegionCodeForShortNumberFromRegionList
    getExampleShortNumber              -> GetExampleShortNumber
    getExampleShortNumberForCost       -> GetExampleShortNumberForCost
    connectsToEmergencyNumber          -> ConnectsToEmergencyNumber
    isEmergencyNumber                  -> IsEmergencyNumber
    matchesEmergencyNumberHelper       -> MatchesEmergencyNumberHelper
    isCarrierSpecific                  -> IsCarrierSpecific
    isCarrierSpecificForRegion         -> IsCarrierSpecificForRegion
    isSmsServiceForRegion              -> IsSmsServiceForRegion
    getNationalSignificantNumber       -> (the caller's ANationalNumber, see
                                          deviation 1 below)
    matchesPossibleNumberAndNationalNumber
                                       -> MatchesPossibleNumberAndNationalNumber

  Note which map is which: the region list of a country calling code comes from
  the PHONE metadata (upstream reads CountryCodeToRegionCodeMap here, not a
  short number table), while every description comes from the SHORT number
  metadata. Short number metadata has no calling code of its own; it is keyed
  by region code only.

  Deliberate deviations from the Java source, all of them shape only and all of
  them the same ones LibPhoneNumber.MetadataCore already documents:

  1. There is no PhoneNumber object. Every entry point that upstream declares
     on PhoneNumber takes the pair (ACountryCode, ANationalNumber) instead,
     where ANationalNumber is what upstream derives through
     getNationalSignificantNumber(number) - i.e. the national significant
     number INCLUDING a significant leading zero. The parser in
     LibPhoneNumber.PhoneNumberUtil produces exactly that as
     TPhoneNumber.NationalNumberDigits, so the caller passes
     (Parsed.CountryCode, Parsed.NationalNumberDigits). The two emergency
     number methods keep their upstream signature, because upstream declares
     them on a raw string on purpose (they must be able to tell "+1 911" from
     "911").
  2. Java returns null for "no region"; this port returns an empty string, and
     an empty region code never matches a region list, which reproduces what
     Java's List.contains(null) does on the pinned metadata.
  3. Java throws / logs on missing metadata; the Try* accessors report it as a
     Boolean and the unreachable "Unrecognised cost" logging branch of
     getExpectedCost has no counterpart because TShortNumberCost is exhaustive
     in a Pascal case statement.
  4. Java holds a singleton with an injected MatcherApi. There is no object
     here: the tables are read only typed constants and the matcher is the
     process wide pattern cache of LibPhoneNumber.Regex, so plain unit
     level functions are the equivalent - the same shape MetadataCore and
     MetadataFormat use.

  No facade wrapper in LibPhoneNumber.PhoneNumberUtil, on purpose. Two reasons:
  upstream ShortNumberInfo is a class of its own next to PhoneNumberUtil and
  not part of it; and GetExpectedCost returns TShortNumberCost, which is
  declared here, so a caller has to reference this unit anyway. This is the
  same decision the AsYouTypeFormatter got.

  Region arguments are CANONICALISED
  ----------------------------------
  Every public function of this unit that takes a region code applies
  UpperCase(Trim(...)) to it before anything else, and so does the public
  facade LibPhoneNumber.PhoneNumberUtil and the AsYouTypeFormatter constructor. Upstream
  compares region codes exactly and would answer "unknown region" for ' de ';
  the canonical spellings are a strict superset of the codes it accepts, so a
  caller that already passes CLDR codes sees no change at all and one that does
  not gets a defined answer instead of a silent miss. This is a deliberate
  service of this port, not an upstream behaviour - it is the ONE region
  handling rule of the whole library, and a new public entry point that takes a
  region has to follow it.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.ShortMetadata;

type
  { Upstream ShortNumberInfo.ShortNumberCost, in upstream declaration order. }
  TShortNumberCost = (
    sncTollFree,
    sncStandardRate,
    sncPremiumRate,
    sncUnknownCost
  );

{ Upstream isPossibleShortNumberForRegion: a more lenient check than
  IsValidShortNumberForRegion - only the LENGTH is tested, against the general
  description of the region dialled from. }
function IsPossibleShortNumberForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;

{ Upstream isPossibleShortNumber: True when the number is possible in ANY of
  the regions that share ACountryCode. }
function IsPossibleShortNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;

{ Upstream isValidShortNumberForRegion: the number must match the general
  description AND the shortCode description of the region dialled from. }
function IsValidShortNumberForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;

{ Upstream isValidShortNumber: True when the number is valid in ANY of the
  regions that share ACountryCode. }
function IsValidShortNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;

{ Upstream getExpectedCostForRegion. Nothing is implied about validity; check
  that separately with IsValidShortNumberForRegion when it matters. Emergency
  numbers are implicitly toll free. }
function GetExpectedCostForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): TShortNumberCost;

{ Upstream getExpectedCost. For a calling code shared by several regions this
  returns the HIGHEST cost in the sequence
  PREMIUM_RATE, UNKNOWN_COST, STANDARD_RATE, TOLL_FREE - UNKNOWN_COST sits
  second because a number that is unknown in one region might be premium rate
  there. Prefer GetExpectedCostForRegion whenever the region is known. }
function GetExpectedCost(ACountryCode: Integer;
  const ANationalNumber: string): TShortNumberCost;

{ Upstream connectsToEmergencyNumber: True when ANumber, EXACTLY AS DIALLED,
  might reach an emergency service in ARegionCode. Formatting is tolerated and
  so are additional digits appended to the emergency number - except in the
  three regions where that breaks the call (BR, CL, NI). }
function ConnectsToEmergencyNumber(const ANumber, ARegionCode: string): Boolean;

{ Upstream isEmergencyNumber: True when ANumber matches an emergency number of
  ARegionCode EXACTLY. Formatting is tolerated, appended digits are not.
  IsEmergencyNumber implies ConnectsToEmergencyNumber. }
function IsEmergencyNumber(const ANumber, ARegionCode: string): Boolean;

{ Upstream isCarrierSpecific: whether a VALID short number is carrier specific,
  resolved over the regions of ACountryCode. Nothing is implied about validity;
  check it separately when it matters. }
function IsCarrierSpecific(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;

{ Upstream isCarrierSpecificForRegion. }
function IsCarrierSpecificForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;

{ Upstream isSmsServiceForRegion: whether a VALID short number is a number
  whose primary or only intended usage is sending and receiving text
  messages. }
function IsSmsServiceForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;

{ Upstream getExampleShortNumber: the shortCode example number of ARegionCode,
  or an empty string when there is none. Package private upstream
  (@VisibleForTesting); public here because it is what the metadata gate of the
  test suite runs on and it exposes no more than the generated table does. }
function GetExampleShortNumber(const ARegionCode: string): string;

{ Upstream getExampleShortNumberForCost: the example number of the cost
  category, or an empty string when there is none. UNKNOWN_COST always yields
  an empty string - upstream computes that category by elimination and has no
  description for it. }
function GetExampleShortNumberForCost(const ARegionCode: string;
  ACost: TShortNumberCost): string;

{ Diagnostics: the upstream enum name, "TOLL_FREE", "STANDARD_RATE", ... }
function ShortNumberCostToString(ACost: TShortNumberCost): string;

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

{ The one region normalisation rule of this port; see the unit header. Applied
  at every public entry point of this unit that takes a region code, so nothing
  below this line has to think about the spelling again. }
function CanonicalRegion(const ARegionCode: string): string;
begin
  Result := UpperCase(Trim(ARegionCode));
end;

{ Upstream REGIONS_WHERE_EMERGENCY_NUMBERS_MUST_BE_EXACT: in these countries an
  emergency number with extra digits appended no longer connects to the
  emergency service. }
function EmergencyNumbersMustBeExact(const ARegionCode: string): Boolean;
begin
  Result := (ARegionCode = 'BR') or (ARegionCode = 'CL') or (ARegionCode = 'NI');
end;

{ Upstream RegexBasedMatcher.matchNationalNumber(number, desc, allowPrefixMatch).

  An empty pattern never matches, not even as a prefix - that is the explicit
  upstream guard "we don't want to consider it a prefix match when matching
  non-empty input against an empty pattern". Both regex entry points below
  carry it already.

  allowPrefixMatch = False is Matcher.matches(), allowPrefixMatch = True is
  Matcher.lookingAt(): upstream returns lookingAt() && (matches() ||
  allowPrefixMatch), and matches() implies lookingAt(). }
function MatchNationalNumber(const ANumber: string;
  ADesc: PPhoneNumberDescRec; AAllowPrefixMatch: Boolean): Boolean;
begin
  if ADesc = nil then
  begin
    Result := False;
    Exit;
  end;
  if AAllowPrefixMatch then
    Result := TryMatchPrefix(ADesc^.NationalNumberPattern, ANumber)
  else
    Result := TryMatchFull(ADesc^.NationalNumberPattern, ANumber);
end;

{ Upstream matchesPossibleNumberAndNationalNumber: the length pre-check runs on
  the description's OWN possible length list. An empty list means "the same
  lengths as the general description" (the upstream size optimisation), which
  is why the check is skipped in that case. }
function MatchesPossibleNumberAndNationalNumber(const ANumber: string;
  ADesc: PPhoneNumberDescRec): Boolean;
begin
  if ADesc = nil then
  begin
    Result := False;
    Exit;
  end;
  if (ADesc^.LengthCount > 0)
    and not ShortDescHasPossibleLength(ADesc, Length(ANumber)) then
  begin
    Result := False;
    Exit;
  end;
  Result := MatchNationalNumber(ANumber, ADesc, False);
end;

{ Upstream regionDialingFromMatchesNumber: the calling code of the number must
  belong to the region the number is dialled from. }
function RegionDialingFromMatchesNumber(ACountryCode: Integer;
  const ARegionDialingFrom: string): Boolean;
var
  Regions: TMetadataStringArray;
  I: Integer;
begin
  Result := False;
  if ARegionDialingFrom = '' then
    Exit;
  Regions := GetRegionCodesForCountryCode(ACountryCode);
  for I := 0 to Length(Regions) - 1 do
    if Regions[I] = ARegionDialingFrom then
    begin
      Result := True;
      Exit;
    end;
end;

{ Upstream getRegionCodeForShortNumberFromRegionList: the first region of the
  list in which the number matches the shortCode description. Java returns null
  when there is none; here that is the empty string.

  Note the two shortcuts upstream takes before it looks at the number at all:
  an empty list answers null and a single element list answers that element
  WITHOUT checking the number. }
function GetRegionCodeForShortNumberFromRegionList(const ANationalNumber: string;
  const ARegionCodes: TMetadataStringArray): string;
var
  I: Integer;
  Metadata: PShortMetadataRec;
begin
  if Length(ARegionCodes) = 0 then
  begin
    Result := '';
    Exit;
  end;
  if Length(ARegionCodes) = 1 then
  begin
    Result := ARegionCodes[0];
    Exit;
  end;
  for I := 0 to Length(ARegionCodes) - 1 do
    if TryGetShortMetadataForRegion(ARegionCodes[I], Metadata)
      and MatchesPossibleNumberAndNationalNumber(ANationalNumber,
        GetShortDesc(Metadata, sdkShortCode)) then
    begin
      Result := ARegionCodes[I];
      Exit;
    end;
  Result := '';
end;

function IsPossibleShortNumberForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;
var
  Metadata: PShortMetadataRec;
  Region: string;
begin
  Region := CanonicalRegion(ARegionDialingFrom);
  if not RegionDialingFromMatchesNumber(ACountryCode, Region) then
  begin
    Result := False;
    Exit;
  end;
  if not TryGetShortMetadataForRegion(Region, Metadata) then
  begin
    Result := False;
    Exit;
  end;
  Result := ShortDescHasPossibleLength(GetShortDesc(Metadata, sdkGeneralDesc),
    Length(ANationalNumber));
end;

function IsPossibleShortNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
var
  Regions: TMetadataStringArray;
  I: Integer;
  Metadata: PShortMetadataRec;
begin
  Result := False;
  Regions := GetRegionCodesForCountryCode(ACountryCode);
  for I := 0 to Length(Regions) - 1 do
  begin
    if not TryGetShortMetadataForRegion(Regions[I], Metadata) then
      Continue;
    if ShortDescHasPossibleLength(GetShortDesc(Metadata, sdkGeneralDesc),
      Length(ANationalNumber)) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function IsValidShortNumberForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;
var
  Metadata: PShortMetadataRec;
  Region: string;
begin
  Region := CanonicalRegion(ARegionDialingFrom);
  if not RegionDialingFromMatchesNumber(ACountryCode, Region) then
  begin
    Result := False;
    Exit;
  end;
  if not TryGetShortMetadataForRegion(Region, Metadata) then
  begin
    Result := False;
    Exit;
  end;
  if not MatchesPossibleNumberAndNationalNumber(ANationalNumber,
    GetShortDesc(Metadata, sdkGeneralDesc)) then
  begin
    Result := False;
    Exit;
  end;
  Result := MatchesPossibleNumberAndNationalNumber(ANationalNumber,
    GetShortDesc(Metadata, sdkShortCode));
end;

function IsValidShortNumber(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
var
  Regions: TMetadataStringArray;
  RegionCode: string;
begin
  Regions := GetRegionCodesForCountryCode(ACountryCode);
  RegionCode := GetRegionCodeForShortNumberFromRegionList(ANationalNumber, Regions);
  if (Length(Regions) > 1) and (RegionCode <> '') then
  begin
    { A matching region was found among two or more, which already verified
      validity for that region. }
    Result := True;
    Exit;
  end;
  Result := IsValidShortNumberForRegion(ACountryCode, ANationalNumber, RegionCode);
end;

function GetExpectedCostForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): TShortNumberCost;
var
  Metadata: PShortMetadataRec;
  Region: string;
begin
  Region := CanonicalRegion(ARegionDialingFrom);
  if not RegionDialingFromMatchesNumber(ACountryCode, Region) then
  begin
    Result := sncUnknownCost;
    Exit;
  end;
  if not TryGetShortMetadataForRegion(Region, Metadata) then
  begin
    Result := sncUnknownCost;
    Exit;
  end;

  { The possible lengths are absent on a sub type whose lengths equal the
    general description's, so the general description is checked first - an
    early exit upstream takes for the same reason. }
  if not ShortDescHasPossibleLength(GetShortDesc(Metadata, sdkGeneralDesc),
    Length(ANationalNumber)) then
  begin
    Result := sncUnknownCost;
    Exit;
  end;

  { Tested in order of DECREASING expense: should the patterns overlap, the
    most expensive matching category wins. }
  if MatchesPossibleNumberAndNationalNumber(ANationalNumber,
    GetShortDesc(Metadata, sdkPremiumRate)) then
  begin
    Result := sncPremiumRate;
    Exit;
  end;
  if MatchesPossibleNumberAndNationalNumber(ANationalNumber,
    GetShortDesc(Metadata, sdkStandardRate)) then
  begin
    Result := sncStandardRate;
    Exit;
  end;
  if MatchesPossibleNumberAndNationalNumber(ANationalNumber,
    GetShortDesc(Metadata, sdkTollFree)) then
  begin
    Result := sncTollFree;
    Exit;
  end;
  if IsEmergencyNumber(ANationalNumber, ARegionDialingFrom) then
  begin
    { Emergency numbers are implicitly toll free. }
    Result := sncTollFree;
    Exit;
  end;
  Result := sncUnknownCost;
end;

function GetExpectedCost(ACountryCode: Integer;
  const ANationalNumber: string): TShortNumberCost;
var
  Regions: TMetadataStringArray;
  I: Integer;
  CostForRegion: TShortNumberCost;
begin
  Regions := GetRegionCodesForCountryCode(ACountryCode);
  if Length(Regions) = 0 then
  begin
    Result := sncUnknownCost;
    Exit;
  end;
  if Length(Regions) = 1 then
  begin
    Result := GetExpectedCostForRegion(ACountryCode, ANationalNumber, Regions[0]);
    Exit;
  end;

  Result := sncTollFree;
  for I := 0 to Length(Regions) - 1 do
  begin
    CostForRegion := GetExpectedCostForRegion(ACountryCode, ANationalNumber,
      Regions[I]);
    case CostForRegion of
      sncPremiumRate:
        begin
          Result := sncPremiumRate;
          Exit;
        end;
      sncUnknownCost:
        Result := sncUnknownCost;
      sncStandardRate:
        if Result <> sncUnknownCost then
          Result := sncStandardRate;
      sncTollFree:
        ; { Do nothing. }
    end;
  end;
end;

{ Upstream matchesEmergencyNumberHelper. }
function MatchesEmergencyNumberHelper(const ANumber, ARegionCode: string;
  AAllowPrefixMatch: Boolean): Boolean;
var
  PossibleNumber: string;
  Wide: UnicodeString;
  Metadata: PShortMetadataRec;
  Emergency: PPhoneNumberDescRec;
  NormalizedNumber: string;
  AllowPrefixMatchForRegion: Boolean;
  Region: string;
begin
  { Both public callers reach the region only through here, so this is the one
    place it has to be canonicalised. }
  Region := CanonicalRegion(ARegionCode);
  PossibleNumber := ExtractPossibleNumber(ANumber);

  { PLUS_CHARS_PATTERN.matcher(possibleNumber).lookingAt(): a leading run of
    plus characters. A number that starts with a plus sign is rejected -
    dialling the country code in front of an emergency number is not believed
    to work. Only the FIRST character has to be tested, because the pattern is
    a one-or-more run of the same class. }
  Wide := UnicodeString(PossibleNumber);
  if (Length(Wide) > 0) and IsPlusChar(Wide[1]) then
  begin
    Result := False;
    Exit;
  end;

  if not TryGetShortMetadataForRegion(Region, Metadata) then
  begin
    Result := False;
    Exit;
  end;
  Emergency := GetShortDesc(Metadata, sdkEmergency);
  { Upstream metadata.hasEmergency(): the <emergency> element was present. }
  if (Emergency = nil) or not Emergency^.HasData then
  begin
    Result := False;
    Exit;
  end;

  NormalizedNumber := NormalizeDigitsOnly(PossibleNumber);
  AllowPrefixMatchForRegion := AAllowPrefixMatch
    and not EmergencyNumbersMustBeExact(Region);
  Result := MatchNationalNumber(NormalizedNumber, Emergency,
    AllowPrefixMatchForRegion);
end;

function ConnectsToEmergencyNumber(const ANumber, ARegionCode: string): Boolean;
begin
  Result := MatchesEmergencyNumberHelper(ANumber, ARegionCode, True);
end;

function IsEmergencyNumber(const ANumber, ARegionCode: string): Boolean;
begin
  Result := MatchesEmergencyNumberHelper(ANumber, ARegionCode, False);
end;

function IsCarrierSpecific(ACountryCode: Integer;
  const ANationalNumber: string): Boolean;
var
  Regions: TMetadataStringArray;
  RegionCode: string;
  Metadata: PShortMetadataRec;
begin
  Regions := GetRegionCodesForCountryCode(ACountryCode);
  RegionCode := GetRegionCodeForShortNumberFromRegionList(ANationalNumber, Regions);
  Result := TryGetShortMetadataForRegion(RegionCode, Metadata)
    and MatchesPossibleNumberAndNationalNumber(ANationalNumber,
      GetShortDesc(Metadata, sdkCarrierSpecific));
end;

function IsCarrierSpecificForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;
var
  Metadata: PShortMetadataRec;
  Region: string;
begin
  Region := CanonicalRegion(ARegionDialingFrom);
  if not RegionDialingFromMatchesNumber(ACountryCode, Region) then
  begin
    Result := False;
    Exit;
  end;
  Result := TryGetShortMetadataForRegion(Region, Metadata)
    and MatchesPossibleNumberAndNationalNumber(ANationalNumber,
      GetShortDesc(Metadata, sdkCarrierSpecific));
end;

function IsSmsServiceForRegion(ACountryCode: Integer;
  const ANationalNumber, ARegionDialingFrom: string): Boolean;
var
  Metadata: PShortMetadataRec;
  Region: string;
begin
  Region := CanonicalRegion(ARegionDialingFrom);
  if not RegionDialingFromMatchesNumber(ACountryCode, Region) then
  begin
    Result := False;
    Exit;
  end;
  Result := TryGetShortMetadataForRegion(Region, Metadata)
    and MatchesPossibleNumberAndNationalNumber(ANationalNumber,
      GetShortDesc(Metadata, sdkSmsServices));
end;

function GetExampleShortNumber(const ARegionCode: string): string;
var
  Metadata: PShortMetadataRec;
  Desc: PPhoneNumberDescRec;
begin
  Result := '';
  if not TryGetShortMetadataForRegion(CanonicalRegion(ARegionCode),
    Metadata) then
    Exit;
  Desc := GetShortDesc(Metadata, sdkShortCode);
  if (Desc <> nil) and (Desc^.ExampleNumber <> '') then
    Result := Desc^.ExampleNumber;
end;

function GetExampleShortNumberForCost(const ARegionCode: string;
  ACost: TShortNumberCost): string;
var
  Metadata: PShortMetadataRec;
  Desc: PPhoneNumberDescRec;
begin
  Result := '';
  if not TryGetShortMetadataForRegion(CanonicalRegion(ARegionCode),
    Metadata) then
    Exit;
  Desc := nil;
  case ACost of
    sncTollFree: Desc := GetShortDesc(Metadata, sdkTollFree);
    sncStandardRate: Desc := GetShortDesc(Metadata, sdkStandardRate);
    sncPremiumRate: Desc := GetShortDesc(Metadata, sdkPremiumRate);
    sncUnknownCost: Desc := nil;
      { UNKNOWN_COST numbers are computed by elimination from the other cost
        categories and therefore have no description of their own. }
  end;
  if (Desc <> nil) and (Desc^.ExampleNumber <> '') then
    Result := Desc^.ExampleNumber;
end;

function ShortNumberCostToString(ACost: TShortNumberCost): string;
begin
  case ACost of
    sncTollFree: Result := 'TOLL_FREE';
    sncStandardRate: Result := 'STANDARD_RATE';
    sncPremiumRate: Result := 'PREMIUM_RATE';
  else
    Result := 'UNKNOWN_COST';
  end;
end;

end.
