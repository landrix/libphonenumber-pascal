program FormatNumbers;

{
  Formatting: the five TPhoneNumberFormat values, dialling from abroad, the
  original format, mobile dialling, vanity numbers, carrier codes and user
  defined patterns.

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
  LibPhoneNumber.MetadataFormat,
  LibPhoneNumber.PhoneNumberUtil;

const
  FormatNames: array[TPhoneNumberFormat] of string = (
    'pnfE164                ',
    'pnfInternational       ',
    'pnfInternationalLegacy ',
    'pnfNational            ',
    'pnfRfc3966             '
  );

procedure ShowAllFormats(const AInput, ARegion: string);
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Fmt: TPhoneNumberFormat;
begin
  WriteLn(AInput, ' (', ARegion, ')');
  if not TPhoneNumberUtil.Parse(AInput, ARegion, Number, Error) then
  begin
    WriteLn('  parse failed, error ', Ord(Error));
    Exit;
  end;
  for Fmt := Low(TPhoneNumberFormat) to High(TPhoneNumberFormat) do
    WriteLn('  ', FormatNames[Fmt], ': ', TPhoneNumberUtil.Format(Number, Fmt));
end;

procedure FormatSection;
begin
  WriteLn('== Format');
  ShowAllFormats('044 668 18 00', 'CH');
  ShowAllFormats('650 253 0000', 'US');
  ShowAllFormats('030 123456 ext. 42', 'DE');
  WriteLn;
end;

procedure OutOfCountrySection;
var
  Swiss, American: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== FormatOutOfCountryCallingNumber');
  if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Swiss, Error) and
    TPhoneNumberUtil.Parse('650 253 0000', 'US', American, Error) then
  begin
    WriteLn('CH number from US: ', TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Swiss, 'US'));
    WriteLn('CH number from DE: ', TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Swiss, 'DE'));
    WriteLn('CH number from CH: ', TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Swiss, 'CH'));
    WriteLn('US number from US: ', TPhoneNumberUtil.FormatOutOfCountryCallingNumber(American, 'US'));
    WriteLn('US number from CA: ', TPhoneNumberUtil.FormatOutOfCountryCallingNumber(American, 'CA'));
    WriteLn('US number from GB: ', TPhoneNumberUtil.FormatOutOfCountryCallingNumber(American, 'GB'));
  end;
  WriteLn;
end;

procedure RawInputSection;
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== Formats that need ParseAndKeepRawInput');
  if TPhoneNumberUtil.ParseAndKeepRawInput('0446681800', 'CH', Number, Error) then
  begin
    WriteLn('RawInput                        : ', Number.RawInput);
    WriteLn('FormatInOriginalFormat (CH)     : ', TPhoneNumberUtil.FormatInOriginalFormat(Number, 'CH'));
    WriteLn('FormatNumberForMobileDialing CH : ',
      TPhoneNumberUtil.FormatNumberForMobileDialing(Number, 'CH', True));
    WriteLn('FormatNumberForMobileDialing US : ',
      TPhoneNumberUtil.FormatNumberForMobileDialing(Number, 'US', False));
  end;
  if TPhoneNumberUtil.ParseAndKeepRawInput('+41 44 668 18 00', 'CH', Number, Error) then
    WriteLn('FormatInOriginalFormat of +41 44 668 18 00 (CH): ',
      TPhoneNumberUtil.FormatInOriginalFormat(Number, 'CH'));
  if TPhoneNumberUtil.ParseAndKeepRawInput('1-800-FLOWERS', 'US', Number, Error) then
  begin
    WriteLn('1-800-FLOWERS NATIONAL          : ', TPhoneNumberUtil.Format(Number, pnfNational));
    WriteLn('1-800-FLOWERS from DE keeping alpha characters: ',
      TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number, 'DE'));
  end;
  WriteLn;
end;

procedure CarrierCodeSection;
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== Carrier codes (Brazil)');
  { In Brazil a national call from a fixed line needs a carrier selection
    code; without one, FormatNumberForMobileDialing answers ''. }
  if TPhoneNumberUtil.Parse('+55 11 2345 6789', 'BR', Number, Error) then
  begin
    WriteLn('NATIONAL                           : ', TPhoneNumberUtil.Format(Number, pnfNational));
    WriteLn('FormatNationalNumberWithCarrierCode 15: ',
      TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(Number, '15'));
    WriteLn('FormatNumberForMobileDialing BR    : "',
      TPhoneNumberUtil.FormatNumberForMobileDialing(Number, 'BR', True), '"');
  end;
  { ParseAndKeepRawInput remembers the carrier code the user dialled. }
  if TPhoneNumberUtil.ParseAndKeepRawInput('0 15 11 2345 6789', 'BR', Number, Error) then
  begin
    WriteLn('PreferredDomesticCarrierCode       : ', Number.PreferredDomesticCarrierCode);
    WriteLn('FormatNationalNumberWithPreferredCarrierCode, fallback 21: ',
      TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(Number, '21'));
    WriteLn('FormatNumberForMobileDialing BR    : "',
      TPhoneNumberUtil.FormatNumberForMobileDialing(Number, 'BR', True), '"');
  end;
  WriteLn;
end;

procedure ByPatternSection;
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Formats: TUserNumberFormatArray;
begin
  WriteLn('== FormatByPattern');
  SetLength(Formats, 1);
  Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1.$2.$3', [], '', '');
  if TPhoneNumberUtil.Parse('650 253 0000', 'US', Number, Error) then
  begin
    WriteLn('NATIONAL     : ', TPhoneNumberUtil.FormatByPattern(Number, pnfNational, Formats));
    WriteLn('INTERNATIONAL: ', TPhoneNumberUtil.FormatByPattern(Number, pnfInternational, Formats));
  end;
  WriteLn;
end;

procedure PartsSection;
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== Parts of a number');
  if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Number, Error) then
  begin
    WriteLn('GetNationalSignificantNumber      : ', TPhoneNumberUtil.GetNationalSignificantNumber(Number));
    WriteLn('GetLengthOfNationalDestinationCode: ', TPhoneNumberUtil.GetLengthOfNationalDestinationCode(Number));
    WriteLn('GetLengthOfGeographicalAreaCode   : ', TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(Number));
  end;
  WriteLn;
end;

procedure PitfallsSection;
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== Pitfalls');
  { Format does not validate: an invalid number is still formatted. }
  if TPhoneNumberUtil.Parse('+1 650 253 000', 'US', Number, Error) then
    WriteLn('invalid +1 650 253 000 as E164: ', TPhoneNumberUtil.Format(Number, pnfE164),
      ', valid: ', BoolToStr(TPhoneNumberUtil.IsValidNumber(Number), True));
  { A record without a calling code formats to the empty string. }
  Number := Default(TPhoneNumber);
  WriteLn('Format(Default(TPhoneNumber), pnfE164): "', TPhoneNumberUtil.Format(Number, pnfE164), '"');
end;

begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    FormatSection;
    OutOfCountrySection;
    RawInputSection;
    CarrierCodeSection;
    ByPatternSection;
    PartsSection;
    PitfallsSection;
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
