unit LibPhoneNumber.AlternateFormats;

{
  Lookup layer over the generated ALTERNATE FORMAT tables.

  Upstream counterpart: the FormattingMetadataSource behind
  DefaultMetadataDependenciesProvider.getAlternateFormatsMetadataSource(). It
  is built from resources/PhoneNumberAlternateFormats.xml and has exactly one
  consumer, PhoneNumberMatcher.checkNumberGroupingIsValid, which asks it for
  the PhoneMetadata of a COUNTRY CALLING CODE and then iterates
  getNumberFormatList().

  A unit of its own, like LibPhoneNumber.ShortMetadata, and for the same
  reasons:

  1. The data set is independent. Upstream keeps it in a separate resource,
     loads it through a separate metadata source and consumes it from a
     separate class. A caller that never runs the matcher at STRICT_GROUPING or
     EXACT_GROUPING should not link these tables.
  2. The lookup surface is tiny. Alternate format territories carry NO id -
     upstream buildCountryCodeToRegionCodeMap has an explicit "for alternate
     formats, there are no region codes at all" branch - and NO description
     elements at all, because loadCountryMetadata skips setRelevantDescPatterns
     for this input. The country calling code is the whole key, and number
     formats are the whole payload.

  THE LEADING DIGITS POOL IS THIS UNIT'S OWN. A TNumberFormatRec obtained here
  addresses AlternateFormatsLeadingDigits through its LeadingDigitsOffset, NOT
  the leadingDigits pool of the active phone metadata. Read it with
  GetAlternateLeadingDigitsPattern and never with
  LibPhoneNumber.Metadata.GetLeadingDigitsPattern; the reverse mix up is
  just as wrong. Everything else on the record - Pattern, Format, the two
  formatting rules - is self contained and can be handed to
  MetadataFormat.FormatNsnUsingPattern as is, which is exactly what upstream
  getNationalNumberGroups(util, number, formattingPattern) does.

  NOT SWITCHED WITH THE TEST METADATA, deliberately. Upstream reaches this data
  set through DefaultMetadataDependenciesProvider.getInstance(), a static
  singleton that PhoneNumberUtil.setInstance does not touch, so the Java
  matcher test suite runs the PRODUCTION alternate formats against the TEST
  phone metadata. This port reproduces that split, the same way the short
  number metadata is not switched either (see the header of
  LibPhoneNumber.TestingMetadata).

  Like the other lookup layers every index is generated, so there is no run
  time initialisation and every lookup is a plain binary search over read only
  typed constants; the unit is safe to call from any number of threads.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.AlternateFormats.Data;

{ Provenance }
function AlternateFormatsVersion: string;
function AlternateFormatsUpstreamCommit: string;
function AlternateFormatsSourceFileName: string;

{ Calling code index. Upstream
  getFormattingMetadataForCountryCallingCode answers null for a calling code
  without alternate formats; here that is a count of 0. }
function HasAlternateFormats(ACountryCode: Integer): Boolean;
function GetAlternateFormatCount(ACountryCode: Integer): Integer;
{ AIndex is zero based within the calling code, mirroring
  PhoneMetadata.getNumberFormat(i). Returns nil when out of range. }
function GetAlternateFormat(ACountryCode: Integer;
  AIndex: Integer): PNumberFormatRec;

{ leadingDigits of an alternate format, out of THIS unit's pool. Upstream reads
  index 0 only ("there is only one leading digits pattern for alternate
  formats"), and the generator refuses an input that declares more. }
function GetAlternateLeadingDigitsPattern(AFormat: PNumberFormatRec;
  AIndex: Integer): string;

{ Raw table access, for the table consistency tests. }
function GetAlternateFormatsGroupCount: Integer;
function GetAlternateFormatsGroup(AIndex: Integer): PAlternateFormatGroupRec;
function GetAlternateFormatsTotalFormatCount: Integer;
function GetAlternateFormatsLeadingDigitsCount: Integer;

implementation

function AlternateFormatsVersion: string;
begin
  Result := AlternateFormatsGeneratorVersion;
end;

function AlternateFormatsUpstreamCommit: string;
begin
  Result := AlternateFormatsSourceCommit;
end;

function AlternateFormatsSourceFileName: string;
begin
  Result := AlternateFormatsSourceFile;
end;

{ Binary search over AlternateFormatsGroups, which the generator emits
  ascending by calling code. }
function FindAlternateGroupSlot(ACountryCode: Integer): Integer;
var
  Low, High, Mid, Value: Integer;
begin
  Low := 0;
  High := AlternateFormatsGroupCount - 1;
  while Low <= High do
  begin
    Mid := Low + (High - Low) div 2;
    Value := AlternateFormatsGroups[Mid].CountryCode;
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

function HasAlternateFormats(ACountryCode: Integer): Boolean;
begin
  Result := FindAlternateGroupSlot(ACountryCode) >= 0;
end;

function GetAlternateFormatCount(ACountryCode: Integer): Integer;
var
  Slot: Integer;
begin
  Slot := FindAlternateGroupSlot(ACountryCode);
  if Slot < 0 then
    Result := 0
  else
    Result := AlternateFormatsGroups[Slot].FormatCount;
end;

function GetAlternateFormat(ACountryCode: Integer;
  AIndex: Integer): PNumberFormatRec;
var
  Slot: Integer;
begin
  Result := nil;
  Slot := FindAlternateGroupSlot(ACountryCode);
  if Slot < 0 then
    Exit;
  if (AIndex < 0) or (AIndex >= AlternateFormatsGroups[Slot].FormatCount) then
    Exit;
  Result := @AlternateFormatsNumberFormats[
    AlternateFormatsGroups[Slot].FormatOffset + AIndex];
end;

function GetAlternateLeadingDigitsPattern(AFormat: PNumberFormatRec;
  AIndex: Integer): string;
begin
  if (AFormat = nil) or (AIndex < 0) or (AIndex >= AFormat^.LeadingDigitsCount) then
    Result := ''
  else
    Result := AlternateFormatsLeadingDigits[AFormat^.LeadingDigitsOffset + AIndex];
end;

function GetAlternateFormatsGroupCount: Integer;
begin
  Result := AlternateFormatsGroupCount;
end;

function GetAlternateFormatsGroup(AIndex: Integer): PAlternateFormatGroupRec;
begin
  if (AIndex < 0) or (AIndex >= AlternateFormatsGroupCount) then
    Result := nil
  else
    Result := @AlternateFormatsGroups[AIndex];
end;

function GetAlternateFormatsTotalFormatCount: Integer;
begin
  Result := AlternateFormatsNumberFormatCount;
end;

function GetAlternateFormatsLeadingDigitsCount: Integer;
begin
  Result := AlternateFormatsLeadingDigitsCount;
end;

end.
