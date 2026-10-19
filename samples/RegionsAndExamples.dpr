program RegionsAndExamples;

{
  Regions, calling codes and example numbers: the lookup functions of
  LibPhoneNumber.Metadata and LibPhoneNumber.MetadataCore, the supported
  number types of a region, the example number family of the facade and the
  metadata version.

  The facade TPhoneNumberUtil canonicalises a region argument with
  UpperCase(Trim(...)). The unit functions of LibPhoneNumber.Metadata and
  LibPhoneNumber.MetadataCore take region codes exactly, like upstream: pass
  upper case CLDR codes, or canonicalise them yourself (CanonicalRegion
  below).

  Builds unchanged with Delphi and with FreePascal; see samples/README.md.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}
{$APPTYPE CONSOLE}

uses
{$IFDEF FPC}
  {$IFDEF UNIX}
  cwstring,
  {$ENDIF}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.PhoneNumberUtil;

function CanonicalRegion(const ARegion: string): string;
begin
  Result := UpperCase(Trim(ARegion));
end;

function JoinStrings(const AValues: TMetadataStringArray): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(AValues) do
  begin
    if I > 0 then
      Result := Result + ' ';
    Result := Result + AValues[I];
  end;
end;

function JoinTypes(const ATypes: TMetadataNumberTypes): string;
var
  T: TMetadataNumberType;
begin
  Result := '';
  for T := Low(TMetadataNumberType) to High(TMetadataNumberType) do
    if T in ATypes then
    begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + NumberTypeToString(T);
    end;
end;

procedure LookupSection;
var
  Metadata: PPhoneMetadataRec;
begin
  WriteLn('== Regions and calling codes');
  WriteLn('GetCountryCodeForRegion(''DE'')                 : ', GetCountryCodeForRegion('DE'));
  WriteLn('GetCountryCodeForRegion(''de'')                 : ', GetCountryCodeForRegion('de'));
  WriteLn('GetCountryCodeForRegion(CanonicalRegion(''de'')): ',
    GetCountryCodeForRegion(CanonicalRegion('de')));
  WriteLn('GetRegionCodeForCountryCode(1)                : ', GetRegionCodeForCountryCode(1));
  WriteLn('GetRegionCodeForCountryCode(999)              : ', GetRegionCodeForCountryCode(999));
  WriteLn('GetRegionCodesForCountryCode(44)              : ', JoinStrings(GetRegionCodesForCountryCode(44)));
  WriteLn('IsSupportedRegion(''CH'')                       : ', BoolToStr(IsSupportedRegion('CH'), True));
  WriteLn('IsSupportedRegion(''ZZ'')                       : ', BoolToStr(IsSupportedRegion('ZZ'), True));
  WriteLn('IsSupportedCallingCode(800)                   : ', BoolToStr(IsSupportedCallingCode(800), True));
  WriteLn('IsNanpaCountry(''CA'')                          : ', BoolToStr(IsNanpaCountry('CA'), True));
  WriteLn('GetNddPrefixForRegion(''DE'', True)             : "', GetNddPrefixForRegion('DE', True), '"');
  WriteLn('GetNddPrefixForRegion(''US'', True)             : "', GetNddPrefixForRegion('US', True), '"');
  WriteLn('GetNddPrefixForRegion(''IT'', True)             : "', GetNddPrefixForRegion('IT', True), '"');
  { isMobileNumberPortableRegion is a metadata field, not a function. }
  if TryGetMetadataForRegion('DE', Metadata) then
    WriteLn('mobile number portable region DE              : ',
      BoolToStr(Metadata^.MobileNumberPortableRegion, True));
  WriteLn;
end;

procedure TypesSection;
begin
  WriteLn('== Supported number types');
  WriteLn('DE : ', JoinTypes(TPhoneNumberUtil.GetSupportedTypesForRegion('de')));
  WriteLn('800: ', JoinTypes(TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(800)));
  WriteLn;
end;

procedure ExampleSection;
var
  Number: TPhoneNumber;
begin
  WriteLn('== Example numbers');
  if TPhoneNumberUtil.TryGetExampleNumber('DE', Number) then
    WriteLn('TryGetExampleNumber(DE)               : ', TPhoneNumberUtil.Format(Number, pnfInternational));
  if TPhoneNumberUtil.TryGetExampleNumberForType('DE', mntMobile, Number) then
    WriteLn('TryGetExampleNumberForType(DE, MOBILE): ', TPhoneNumberUtil.Format(Number, pnfInternational));
  if TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(800, Number) then
    WriteLn('TryGetExampleNumberForNonGeoEntity(800): ', TPhoneNumberUtil.Format(Number, pnfInternational),
      ', region ', TPhoneNumberUtil.GetRegionCodeForNumber(Number));
  if TPhoneNumberUtil.TryGetInvalidExampleNumber('DE', Number) then
    WriteLn('TryGetInvalidExampleNumber(DE)        : ', TPhoneNumberUtil.Format(Number, pnfE164),
      ', valid ', BoolToStr(TPhoneNumberUtil.IsValidNumber(Number), True));
  WriteLn('TryGetExampleNumber(ZZ) succeeds      : ',
    BoolToStr(TPhoneNumberUtil.TryGetExampleNumber('ZZ', Number), True));
  WriteLn;
end;

procedure VersionSection;
begin
  WriteLn('== Metadata');
  { MetadataVersion is the label of the generator that produced the tables,
    MetadataSourceName the upstream file they come from. The upstream commit
    (MetadataUpstreamCommit) changes with every metadata refresh, so this
    sample does not print it. }
  WriteLn('MetadataVersion   : ', MetadataVersion);
  WriteLn('MetadataSourceName: ', MetadataSourceName);
end;

begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    LookupSection;
    TypesSection;
    ExampleSection;
    VersionSection;
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
