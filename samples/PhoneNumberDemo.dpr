program PhoneNumberDemo;

{
  Minimal console tour of libphonenumber-pascal: parse, validate, classify,
  format, format as you type and find numbers in free text.

  Builds unchanged with Delphi and with FreePascal; see samples/README.md for
  the command lines.

  FreePascal string contract: on FreePascal in Delphi mode `string` is an
  AnsiString that the library treats as UTF-8. A program therefore sets
  SetMultiByteConversionCodePage(CP_UTF8) before it calls the library and,
  on Unix, links the `cwstring` widestring manager. On Delphi `string` is
  UnicodeString and neither step is needed.
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
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.PhoneNumberUtil,
  LibPhoneNumber.AsYouTypeFormatter,
  LibPhoneNumber.PhoneNumberMatcher;

{ The library has no name function for the parse error (upstream has an
  exception instead); a program that wants to print one keeps its own. }
function ParseErrorName(AError: TPhoneNumberParseError): string;
begin
  Result := '';
  case AError of
    pnpeNone: Result := 'NONE';
    pnpeNotANumber: Result := 'NOT_A_NUMBER';
    pnpeInvalidCountryCode: Result := 'INVALID_COUNTRY_CODE';
    pnpeTooShortAfterIdd: Result := 'TOO_SHORT_AFTER_IDD';
    pnpeTooShortNsn: Result := 'TOO_SHORT_NSN';
    pnpeTooLongNsn: Result := 'TOO_LONG';
  end;
end;

procedure ShowNumber(const AInput, ARegion: string);
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('Input            : ', AInput, ' (region ', ARegion, ')');
  if not TPhoneNumberUtil.Parse(AInput, ARegion, Number, Error) then
  begin
    WriteLn('  parse failed   : ', ParseErrorName(Error));
    Exit;
  end;
  WriteLn('  calling code   : ', Number.CountryCode);
  WriteLn('  national number: ', Number.NationalNumberDigits);
  WriteLn('  region         : ', Number.RegionCode);
  WriteLn('  valid          : ', BoolToStr(TPhoneNumberUtil.IsValidNumber(Number), True));
  WriteLn('  type           : ', NumberTypeToString(TPhoneNumberUtil.GetNumberType(Number)));
  WriteLn('  E164           : ', TPhoneNumberUtil.Format(Number, pnfE164));
  WriteLn('  INTERNATIONAL  : ', TPhoneNumberUtil.Format(Number, pnfInternational));
  WriteLn('  NATIONAL       : ', TPhoneNumberUtil.Format(Number, pnfNational));
  WriteLn('  RFC3966        : ', TPhoneNumberUtil.Format(Number, pnfRfc3966));
  WriteLn('  dialled from US: ', TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, 'US'));
end;

procedure ShowAsYouType(const ADigits: UnicodeString; const ARegion: string);
var
  Formatter: TAsYouTypeFormatter;
  I: Integer;
  Current: UnicodeString;
begin
  WriteLn('As you type (region ', ARegion, '):');
  Formatter := TAsYouTypeFormatter.Create(ARegion);
  try
    for I := 1 to Length(ADigits) do
    begin
      Current := Formatter.InputDigit(ADigits[I]);
      WriteLn('  ', string(Current));
    end;
  finally
    Formatter.Free;
  end;
end;

procedure ShowFindNumbers(const AText, ARegion: string);
var
  Matches: TPhoneNumberMatchArray;
  I: Integer;
begin
  WriteLn('Numbers in "', AText, '":');
  Matches := FindNumbers(AText, ARegion);
  for I := 0 to High(Matches) do
    WriteLn(Format('  [%d..%d) %s -> %s', [Matches[I].Start, Matches[I].EndIndex,
      Matches[I].RawString, TPhoneNumberUtil.Format(Matches[I].Number, pnfE164)]));
end;

begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    ShowNumber('044 668 18 00', 'CH');
    WriteLn;
    ShowNumber('+1 650-253-0000', 'US');
    WriteLn;
    ShowNumber('030 123456', 'DE');
    WriteLn;
    ShowNumber('030 123456', '');
    WriteLn;
    ShowAsYouType('6502530000', 'US');
    WriteLn;
    ShowFindNumbers('Call 044 668 18 00 or +1 650-253-0000 before 6 pm.', 'CH');
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
