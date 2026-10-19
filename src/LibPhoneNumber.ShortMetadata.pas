unit LibPhoneNumber.ShortMetadata;

{
  Lookup layer over the generated short number metadata tables.

  This is the short number counterpart of LibPhoneNumber.Metadata and is
  deliberately a UNIT OF ITS OWN rather than a few more functions there:

  1. The two data sets are independent. Upstream keeps them in separate
     resources (PhoneNumberMetadata.xml / ShortNumberMetadata.xml), loads them
     through separate metadata sources and consumes them from separate classes
     (PhoneNumberUtil / ShortNumberInfo). A caller that never touches short
     numbers should not link the short number tables.
  2. The lookup surface is genuinely smaller. Short number metadata has no
     country calling code, no non geographical entities and no number formats,
     so there is no calling code index and no format accessor here - the only
     key is the region code, exactly like upstream
     ShortNumberInfo.getShortNumberMetadataForRegion.

  What IS shared with the phone metadata is the record type of a single
  description (TPhoneNumberDescRec in LibPhoneNumber.Metadata.Types),
  because upstream BuildMetadataFromXml builds both through the very same
  processPhoneNumberDescElement.

  Like the phone metadata lookup, every index is generated, so there is no run
  time initialisation and every lookup is a plain binary search over read only
  typed constants; the unit is therefore safe to call from any number of
  threads. Region codes are matched exactly.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.ShortMetadata.Data,
  LibPhoneNumber.ShortMetadata.Descs;

{ Provenance }
function ShortMetadataVersion: string;
function ShortMetadataUpstreamCommit: string;
function ShortMetadataSourceFileName: string;

{ Raw table access }
function GetShortTerritoryCount: Integer;
function GetShortTerritory(AIndex: Integer): PShortMetadataRec;

{ Region lookup. Upstream ShortNumberInfo.getShortNumberMetadataForRegion
  answers null both for a null region code and for a region without short
  number metadata; here both are the False result. }
function TryGetShortMetadataForRegion(const ARegionCode: string;
  out AMetadata: PShortMetadataRec): Boolean;
function HasShortMetadataForRegion(const ARegionCode: string): Boolean;
function GetShortMetadataRegions: TMetadataStringArray;

{ Number descriptions }
function GetShortDesc(AMetadata: PShortMetadataRec;
  AKind: TShortNumberDescKind): PPhoneNumberDescRec;
function GetShortPossibleLengths(ADesc: PPhoneNumberDescRec): TMetadataIntegerArray;
{ True when ALength is one of the possible lengths of ADesc. The array free
  form of the upstream
  "desc.getPossibleLengthList().contains(number.length())" test, which
  ShortNumberInfo performs on every call. }
function ShortDescHasPossibleLength(ADesc: PPhoneNumberDescRec;
  ALength: Integer): Boolean;

implementation

function ShortMetadataVersion: string;
begin
  Result := ShortMetadataGeneratorVersion;
end;

function ShortMetadataUpstreamCommit: string;
begin
  Result := ShortMetadataSourceCommit;
end;

function ShortMetadataSourceFileName: string;
begin
  Result := ShortMetadataSourceFile;
end;

function GetShortTerritoryCount: Integer;
begin
  Result := ShortMetadataTerritoryCount;
end;

function GetShortTerritory(AIndex: Integer): PShortMetadataRec;
begin
  if (AIndex < 0) or (AIndex >= ShortMetadataTerritoryCount) then
    Result := nil
  else
    Result := @ShortMetadataTerritories[AIndex];
end;

{ Ordinal string comparison, implemented locally for the same reason
  LibPhoneNumber.Metadata does it: Delphi and FreePascal must agree
  regardless of RTL locale handling. }
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

function FindShortRegionSlot(const ARegionCode: string): Integer;
var
  Low, High, Mid, Cmp: Integer;
begin
  Low := 0;
  High := ShortMetadataTerritoryCount - 1;
  while Low <= High do
  begin
    Mid := Low + (High - Low) div 2;
    Cmp := CompareRegionCodeOrdinal(ShortMetadataRegionCodes[Mid], ARegionCode);
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

function TryGetShortMetadataForRegion(const ARegionCode: string;
  out AMetadata: PShortMetadataRec): Boolean;
var
  Slot: Integer;
begin
  AMetadata := nil;
  if ARegionCode = '' then
  begin
    Result := False;
    Exit;
  end;
  Slot := FindShortRegionSlot(ARegionCode);
  if Slot < 0 then
  begin
    Result := False;
    Exit;
  end;
  AMetadata := @ShortMetadataTerritories[ShortMetadataRegionOrder[Slot]];
  Result := True;
end;

function HasShortMetadataForRegion(const ARegionCode: string): Boolean;
begin
  Result := (ARegionCode <> '') and (FindShortRegionSlot(ARegionCode) >= 0);
end;

function GetShortMetadataRegions: TMetadataStringArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, ShortMetadataTerritoryCount);
  for I := 0 to ShortMetadataTerritoryCount - 1 do
    Result[I] := ShortMetadataRegionCodes[I];
end;

function GetShortDesc(AMetadata: PShortMetadataRec;
  AKind: TShortNumberDescKind): PPhoneNumberDescRec;
begin
  if AMetadata = nil then
    Result := nil
  else
    Result := @ShortMetadataDescs[AMetadata^.DescOffset + Ord(AKind)];
end;

function GetShortPossibleLengths(ADesc: PPhoneNumberDescRec): TMetadataIntegerArray;
var
  I: Integer;
begin
  Result := nil;
  if (ADesc = nil) or (ADesc^.LengthCount <= 0) then
    Exit;
  SetLength(Result, ADesc^.LengthCount);
  for I := 0 to ADesc^.LengthCount - 1 do
    Result[I] := ShortMetadataPossibleLengths[ADesc^.LengthOffset + I];
end;

function ShortDescHasPossibleLength(ADesc: PPhoneNumberDescRec;
  ALength: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ADesc = nil then
    Exit;
  for I := 0 to ADesc^.LengthCount - 1 do
    if ShortMetadataPossibleLengths[ADesc^.LengthOffset + I] = ALength then
    begin
      Result := True;
      Exit;
    end;
end;

end.
