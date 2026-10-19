unit LibPhoneNumber.Metadata;

{
  Lookup layer over the generated libphonenumber metadata tables.

  Scope of this unit: indexing and access only. It contains
  no validation, typing or formatting logic; that lives in
  LibPhoneNumber.MetadataCore and LibPhoneNumber.MetadataFormat, on top of
  the records returned here.

  All indices are generated (see tools/generate_metadata.ps1), so no index has
  to be BUILT at run time and there is nothing to synchronise: every lookup is
  a plain binary search over read only typed constants and is therefore safe to
  call from any number of threads. The one thing the initialization section
  does is install the production data set as the active one (see "Metadata
  source switching"), so the tables are ready before the first lookup.

  Region codes are matched exactly, like upstream Java
  PhoneNumberUtil.getMetadataForRegion does. Callers that accept user input
  should normalise to upper case ASCII first; the public facade
  LibPhoneNumber.PhoneNumberUtil.pas and the other public entry points do exactly that.

  Records and pointers are SOURCE BOUND
  -------------------------------------
  Everything this unit hands out - PPhoneMetadataRec, PPhoneNumberDescRec,
  PNumberFormatRec, and the offsets inside them - points into the tables of the
  data set that was active when it was fetched. A UseMetadataTables switch
  invalidates all of them at once: the same pointer then addresses a different
  territory, and a description offset read from the old data set indexes the new
  description pool. There is no handle type and no generation counter guarding
  that, deliberately - the switch is a test fixture mechanism (see below), and
  every caller in the port fetches its metadata pointer and uses it inside one
  call. Never cache a pointer from this unit across a switch, and never store
  one in a fixture field.

  Metadata source switching
  ---------------------------------------------
  The lookups do not name a generated unit. They read the ACTIVE data
  set, a TPhoneMetadataTables record of pointers into the generated tables,
  which the initialization section fills with the production tables of
  LibPhoneNumber.Metadata.Data / .Descs / .Formats. Production is therefore
  the default and stays the default unless a caller says otherwise.

  UseMetadataTables swaps the whole record at once. That is the point of the
  record: territory indices, region order, description offsets and format
  offsets only make sense TOGETHER, and a half switched state would silently
  read the wrong entries. Swapping the record is ALL it does; there is no other
  derived state in the core.

  In particular it does NOT clear the pattern cache of
  LibPhoneNumber.Regex, and it must not have to: that cache is keyed by
  the PATTERN TEXT itself, so an entry left over from another data set can only
  ever be hit by a pattern that is character for character the same - in which
  case the compiled expression is the correct one. A stale entry is therefore
  unreachable-or-correct, never wrong. Dropping the call also removes the only
  dependency this layer had on the regex layer above it, which is what a lookup
  layer should look like. The (purely hygienic) clear now lives one level up,
  in LibPhoneNumber.TestingMetadata, i.e. in the test-only layer that does
  the switching.

  The switch is NOT thread safe and is not meant to be: upstream swaps its
  metadata source the same way (PhoneNumberUtil.setInstance in
  TestMetadataTestCase, which its own javadoc calls unsafe to run in parallel).
  Call it from test setup/teardown while nothing else runs, never from a
  worker.

  The SHORT number metadata (LibPhoneNumber.ShortMetadata) is deliberately
  NOT part of this: upstream ShortNumberInfoTest runs its shortInfo against the
  PRODUCTION short number metadata and only the PhoneNumberUtil singleton
  behind it against the test metadata, so the two data sets are switched
  independently - and only this one is switched at all.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
  { Interface level only: every declaration below is spelled in the types of
    the data model. The three GENERATED units are an IMPLEMENTATION dependency
    - only ProductionMetadataTables names their tables - and are used down
    there. }
  LibPhoneNumber.Metadata.Types;

{ Provenance of the ACTIVE data set: the label of the generator that wrote
  the tables ("metadata-v1"), the upstream libphonenumber commit and the
  upstream file they were generated from. vendor/versions.md maps the commit
  to the upstream release. }
function MetadataVersion: string;
function MetadataUpstreamCommit: string;
function MetadataSourceName: string;

{ ------------------------------------------------------------------
  Metadata source switching.

  ProductionMetadataTables is the data set of the three generated production
  units; a second one lives in LibPhoneNumber.TestingMetadata, which only
  the test project links. UseMetadataTables installs a data set and is the ONLY
  way the active source changes. It invalidates every record pointer previously
  handed out (see "Records and pointers are SOURCE BOUND" in the unit header).
  ------------------------------------------------------------------ }
function ProductionMetadataTables: TPhoneMetadataTables;
function ActiveMetadataTables: TPhoneMetadataTables;
procedure UseMetadataTables(const ATables: TPhoneMetadataTables);
procedure UseProductionMetadata;
function IsProductionMetadataActive: Boolean;

{ Raw table access }
function GetTerritoryCount: Integer;
function GetTerritory(AIndex: Integer): PPhoneMetadataRec;

{ Region / country calling code lookup. Upstream getSupportedRegions,
  getSupportedCallingCodes, getSupportedGlobalNetworkCallingCodes,
  getRegionCodesForCountryCode (the main region first) and
  getCountryCodeForRegion (0 for an unknown region). Region codes are matched
  EXACTLY: pass upper case CLDR codes ('DE', not 'de'); "001" is the non
  geographical entity, 'ZZ' the unknown region. }
function TryGetMetadataForRegion(const ARegionCode: string;
  out AMetadata: PPhoneMetadataRec): Boolean;
function TryGetMetadataForNonGeoEntity(ACountryCode: Integer;
  out AMetadata: PPhoneMetadataRec): Boolean;
function IsSupportedRegion(const ARegionCode: string): Boolean;
function IsSupportedGlobalNetworkCallingCode(ACountryCode: Integer): Boolean;
function IsSupportedCallingCode(ACountryCode: Integer): Boolean;

function GetSupportedRegions: TMetadataStringArray;
function GetSupportedGlobalNetworkCallingCodes: TMetadataIntegerArray;
function GetSupportedCallingCodes: TMetadataIntegerArray;
function GetRegionCodesForCountryCode(ACountryCode: Integer): TMetadataStringArray;
function GetCountryCodeForRegion(const ARegionCode: string): Integer;

{ Number descriptions }
function GetDesc(AMetadata: PPhoneMetadataRec;
  AKind: TPhoneNumberDescKind): PPhoneNumberDescRec;
function GetPossibleLengths(ADesc: PPhoneNumberDescRec): TMetadataIntegerArray;
function GetPossibleLengthsLocalOnly(ADesc: PPhoneNumberDescRec): TMetadataIntegerArray;
{ Resolves the upstream size optimisation: an empty possible length list on a
  typed description means "the general description applies".

  TEST ONLY. Nothing under src/ calls this; the runtime resolves the same
  optimisation inline in LibPhoneNumber.MetadataCore.TestNumberLength,
  where it also needs the local-only lengths. It stays exported because the
  metadata test suite and the length compare gate check the emitted tables
  through it - it is the readable spelling of the rule the generator
  implements. Do not build runtime logic on it; it materialises an array per
  call. }
function GetEffectivePossibleLengths(AMetadata: PPhoneMetadataRec;
  AKind: TPhoneNumberDescKind): TMetadataIntegerArray;

{ Number formats }
function GetNumberFormatCount(AMetadata: PPhoneMetadataRec): Integer;
function GetNumberFormat(AMetadata: PPhoneMetadataRec;
  AIndex: Integer): PNumberFormatRec;
function GetIntlNumberFormatCount(AMetadata: PPhoneMetadataRec): Integer;
function GetIntlNumberFormat(AMetadata: PPhoneMetadataRec;
  AIndex: Integer): PNumberFormatRec;
function GetLeadingDigitsPatterns(AFormat: PNumberFormatRec): TMetadataStringArray;
{ Single leadingDigits pattern by index, without materialising the whole list.
  The format engine only ever reads the LAST one (upstream
  chooseFormattingPatternForNumber: "we always use the last
  leading_digits_pattern, as it is the most detailed"), and it does so for
  every candidate format of every formatted number. Returns an empty string for
  an out of range index. }
function GetLeadingDigitsPattern(AFormat: PNumberFormatRec;
  AIndex: Integer): string;

implementation

uses
  LibPhoneNumber.Metadata.Data,
  LibPhoneNumber.Metadata.Descs,
  LibPhoneNumber.Metadata.Formats;

var
  { The active data set. Filled with the production tables by the
    initialization section below, so nothing has to be initialised lazily and
    no lookup needs a "is it set up yet" branch. }
  GActive: TPhoneMetadataTables;

function ProductionMetadataTables: TPhoneMetadataTables;
begin
  Result.GeneratorVersion := MetadataGeneratorVersion;
  Result.SourceFile := MetadataSourceFile;
  Result.SourceCommit := MetadataSourceCommit;

  Result.Territories := @PhoneMetadataTerritories;
  Result.TerritoryCount := PhoneMetadataTerritoryCount;

  Result.Descs := @PhoneMetadataDescs;
  Result.DescCount := PhoneMetadataDescCount;

  Result.NumberFormats := @PhoneMetadataNumberFormats;
  Result.NumberFormatCount := PhoneMetadataNumberFormatCount;
  Result.IntlNumberFormats := @PhoneMetadataIntlNumberFormats;
  Result.IntlNumberFormatCount := PhoneMetadataIntlNumberFormatCount;
  Result.LeadingDigits := @PhoneMetadataLeadingDigits;
  Result.LeadingDigitsCount := PhoneMetadataLeadingDigitsCount;

  Result.PossibleLengths := @PhoneMetadataPossibleLengths;
  Result.PossibleLengthCount := PhoneMetadataPossibleLengthCount;

  Result.RegionOrder := @PhoneMetadataRegionOrder;
  Result.RegionCodes := @PhoneMetadataRegionCodes;
  Result.RegionCount := PhoneMetadataRegionCount;

  Result.NonGeoOrder := @PhoneMetadataNonGeoOrder;
  Result.NonGeoCallingCodes := @PhoneMetadataNonGeoCallingCodes;
  Result.NonGeoCount := PhoneMetadataNonGeoCount;

  Result.CountryCodeGroups := @PhoneMetadataCountryCodeGroups;
  Result.CountryCodeRegions := @PhoneMetadataCountryCodeRegions;
  Result.CountryCodeCount := PhoneMetadataCountryCodeCount;
end;

function ActiveMetadataTables: TPhoneMetadataTables;
begin
  Result := GActive;
end;

procedure UseMetadataTables(const ATables: TPhoneMetadataTables);
begin
  { Swapping the record is the whole operation. The regex pattern cache is NOT
    cleared here: its keys are the pattern strings themselves, so an entry of
    another data set is either unreachable or exactly the right one. See the
    unit header. }
  GActive := ATables;
end;

procedure UseProductionMetadata;
begin
  UseMetadataTables(ProductionMetadataTables);
end;

function IsProductionMetadataActive: Boolean;
begin
  Result := GActive.Territories = PPhoneMetadataRecArray(@PhoneMetadataTerritories);
end;

function MetadataVersion: string;
begin
  Result := GActive.GeneratorVersion;
end;

function MetadataUpstreamCommit: string;
begin
  Result := GActive.SourceCommit;
end;

function MetadataSourceName: string;
begin
  Result := GActive.SourceFile;
end;

function GetTerritoryCount: Integer;
begin
  Result := GActive.TerritoryCount;
end;

function GetTerritory(AIndex: Integer): PPhoneMetadataRec;
begin
  if (AIndex < 0) or (AIndex >= GActive.TerritoryCount) then
    Result := nil
  else
    Result := @GActive.Territories^[AIndex];
end;

{ Ordinal string comparison. Deliberately implemented locally so Delphi and
  FreePascal agree regardless of RTL locale handling. }
function CompareRegionCodeOrdinal(const ALeft, ARight: string): Integer;
var
  I, LeftLen, RightLen, MinLen: Integer;
begin
  LeftLen := Length(ALeft);
  RightLen := Length(ARight);
  if LeftLen < RightLen then
    MinLen := LeftLen
  else
    MinLen := RightLen;
  for I := 1 to MinLen do
  begin
    Result := Ord(ALeft[I]) - Ord(ARight[I]);
    if Result <> 0 then
      Exit;
  end;
  Result := LeftLen - RightLen;
end;

function FindRegionSlot(const ARegionCode: string): Integer;
var
  Low, High, Mid, Cmp: Integer;
begin
  Low := 0;
  High := GActive.RegionCount - 1;
  while Low <= High do
  begin
    Mid := Low + (High - Low) div 2;
    Cmp := CompareRegionCodeOrdinal(GActive.RegionCodes^[Mid], ARegionCode);
    if Cmp = 0 then
    begin
      Result := Mid;
      Exit;
    end;
    if Cmp < 0 then
      Low := Mid + 1
    else
      High := Mid - 1;
  end;
  Result := -1;
end;

function FindNonGeoSlot(ACountryCode: Integer): Integer;
var
  Low, High, Mid, Value: Integer;
begin
  Low := 0;
  High := GActive.NonGeoCount - 1;
  while Low <= High do
  begin
    Mid := Low + (High - Low) div 2;
    Value := GActive.NonGeoCallingCodes^[Mid];
    if Value = ACountryCode then
    begin
      Result := Mid;
      Exit;
    end;
    if Value < ACountryCode then
      Low := Mid + 1
    else
      High := Mid - 1;
  end;
  Result := -1;
end;

function FindCountryCodeGroup(ACountryCode: Integer): Integer;
var
  Low, High, Mid, Value: Integer;
begin
  Low := 0;
  High := GActive.CountryCodeCount - 1;
  while Low <= High do
  begin
    Mid := Low + (High - Low) div 2;
    Value := GActive.CountryCodeGroups^[Mid].CountryCode;
    if Value = ACountryCode then
    begin
      Result := Mid;
      Exit;
    end;
    if Value < ACountryCode then
      Low := Mid + 1
    else
      High := Mid - 1;
  end;
  Result := -1;
end;

function TryGetMetadataForRegion(const ARegionCode: string;
  out AMetadata: PPhoneMetadataRec): Boolean;
var
  Slot: Integer;
begin
  AMetadata := nil;
  if ARegionCode = '' then
  begin
    Result := False;
    Exit;
  end;
  Slot := FindRegionSlot(ARegionCode);
  if Slot < 0 then
  begin
    Result := False;
    Exit;
  end;
  AMetadata := @GActive.Territories^[GActive.RegionOrder^[Slot]];
  Result := True;
end;

function TryGetMetadataForNonGeoEntity(ACountryCode: Integer;
  out AMetadata: PPhoneMetadataRec): Boolean;
var
  Slot: Integer;
begin
  AMetadata := nil;
  Slot := FindNonGeoSlot(ACountryCode);
  if Slot < 0 then
  begin
    Result := False;
    Exit;
  end;
  AMetadata := @GActive.Territories^[GActive.NonGeoOrder^[Slot]];
  Result := True;
end;

function IsSupportedRegion(const ARegionCode: string): Boolean;
begin
  Result := (ARegionCode <> '') and (FindRegionSlot(ARegionCode) >= 0);
end;

function IsSupportedGlobalNetworkCallingCode(ACountryCode: Integer): Boolean;
begin
  Result := FindNonGeoSlot(ACountryCode) >= 0;
end;

function IsSupportedCallingCode(ACountryCode: Integer): Boolean;
begin
  Result := FindCountryCodeGroup(ACountryCode) >= 0;
end;

function GetSupportedRegions: TMetadataStringArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, GActive.RegionCount);
  for I := 0 to GActive.RegionCount - 1 do
    Result[I] := GActive.RegionCodes^[I];
end;

function GetSupportedGlobalNetworkCallingCodes: TMetadataIntegerArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, GActive.NonGeoCount);
  for I := 0 to GActive.NonGeoCount - 1 do
    Result[I] := GActive.NonGeoCallingCodes^[I];
end;

function GetSupportedCallingCodes: TMetadataIntegerArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, GActive.CountryCodeCount);
  for I := 0 to GActive.CountryCodeCount - 1 do
    Result[I] := GActive.CountryCodeGroups^[I].CountryCode;
end;

function GetRegionCodesForCountryCode(ACountryCode: Integer): TMetadataStringArray;
var
  Group, I: Integer;
begin
  Result := nil;
  Group := FindCountryCodeGroup(ACountryCode);
  if Group < 0 then
    Exit;
  SetLength(Result, GActive.CountryCodeGroups^[Group].RegionCount);
  for I := 0 to GActive.CountryCodeGroups^[Group].RegionCount - 1 do
    Result[I] := GActive.Territories^[
      GActive.CountryCodeRegions^[
        GActive.CountryCodeGroups^[Group].RegionOffset + I]].Id;
end;

function GetCountryCodeForRegion(const ARegionCode: string): Integer;
var
  Metadata: PPhoneMetadataRec;
begin
  if TryGetMetadataForRegion(ARegionCode, Metadata) then
    Result := Metadata^.CountryCode
  else
    Result := 0;
end;

function GetDesc(AMetadata: PPhoneMetadataRec;
  AKind: TPhoneNumberDescKind): PPhoneNumberDescRec;
begin
  if AMetadata = nil then
    Result := nil
  else
    Result := @GActive.Descs^[AMetadata^.DescOffset + Ord(AKind)];
end;

function SliceLengths(AOffset, ACount: Integer): TMetadataIntegerArray;
var
  I: Integer;
begin
  Result := nil;
  if ACount <= 0 then
    Exit;
  SetLength(Result, ACount);
  for I := 0 to ACount - 1 do
    Result[I] := GActive.PossibleLengths^[AOffset + I];
end;

function GetPossibleLengths(ADesc: PPhoneNumberDescRec): TMetadataIntegerArray;
begin
  Result := nil;
  if ADesc <> nil then
    Result := SliceLengths(ADesc^.LengthOffset, ADesc^.LengthCount);
end;

function GetPossibleLengthsLocalOnly(ADesc: PPhoneNumberDescRec): TMetadataIntegerArray;
begin
  Result := nil;
  if ADesc <> nil then
    Result := SliceLengths(ADesc^.LocalOnlyOffset, ADesc^.LocalOnlyCount);
end;

function GetEffectivePossibleLengths(AMetadata: PPhoneMetadataRec;
  AKind: TPhoneNumberDescKind): TMetadataIntegerArray;
var
  Desc: PPhoneNumberDescRec;
begin
  Result := nil;
  Desc := GetDesc(AMetadata, AKind);
  if Desc = nil then
    Exit;
  if (Desc^.LengthCount = 0) and (AKind <> pdkGeneralDesc) then
    Desc := GetDesc(AMetadata, pdkGeneralDesc);
  Result := SliceLengths(Desc^.LengthOffset, Desc^.LengthCount);
end;

function GetNumberFormatCount(AMetadata: PPhoneMetadataRec): Integer;
begin
  if AMetadata = nil then
    Result := 0
  else
    Result := AMetadata^.FormatCount;
end;

function GetNumberFormat(AMetadata: PPhoneMetadataRec;
  AIndex: Integer): PNumberFormatRec;
begin
  if (AMetadata = nil) or (AIndex < 0) or (AIndex >= AMetadata^.FormatCount) then
    Result := nil
  else
    Result := @GActive.NumberFormats^[AMetadata^.FormatOffset + AIndex];
end;

function GetIntlNumberFormatCount(AMetadata: PPhoneMetadataRec): Integer;
begin
  if AMetadata = nil then
    Result := 0
  else
    Result := AMetadata^.IntlFormatCount;
end;

function GetIntlNumberFormat(AMetadata: PPhoneMetadataRec;
  AIndex: Integer): PNumberFormatRec;
begin
  if (AMetadata = nil) or (AIndex < 0) or (AIndex >= AMetadata^.IntlFormatCount) then
    Result := nil
  else
    Result := @GActive.IntlNumberFormats^[AMetadata^.IntlFormatOffset + AIndex];
end;

function GetLeadingDigitsPattern(AFormat: PNumberFormatRec;
  AIndex: Integer): string;
begin
  if (AFormat = nil) or (AIndex < 0) or (AIndex >= AFormat^.LeadingDigitsCount) then
    Result := ''
  else
    Result := GActive.LeadingDigits^[AFormat^.LeadingDigitsOffset + AIndex];
end;

function GetLeadingDigitsPatterns(AFormat: PNumberFormatRec): TMetadataStringArray;
var
  I: Integer;
begin
  Result := nil;
  if (AFormat = nil) or (AFormat^.LeadingDigitsCount <= 0) then
    Exit;
  SetLength(Result, AFormat^.LeadingDigitsCount);
  for I := 0 to AFormat^.LeadingDigitsCount - 1 do
    Result[I] := GActive.LeadingDigits^[AFormat^.LeadingDigitsOffset + I];
end;

initialization
  { The production tables are the default. Every unit that reads metadata uses
    THIS one, so its initialization section has run before any of them. }
  GActive := ProductionMetadataTables;

end.
