program QuickStart;

{
  The quick start of README.md: parse, validate, classify and format one
  number, format digits as they are typed and find numbers in a sentence.
  README.md shows this program verbatim; change both together.

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
  cwstring, // FreePascal on Unix: the widestring manager
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

var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Formatter: TAsYouTypeFormatter;
  Digits, Typed: UnicodeString;
  Matches: TPhoneNumberMatchArray;
  I: Integer;
begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8); // FreePascal: string is UTF-8
{$ENDIF}
  try
    // Parsing reports failure through its result, never through an exception.
    if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Number, Error) then
    begin
      WriteLn(TPhoneNumberUtil.Format(Number, pnfE164));          // +41446681800
      WriteLn(TPhoneNumberUtil.Format(Number, pnfInternational)); // +41 44 668 18 00
      WriteLn(TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, 'US'));
                                                                  // 011 41 44 668 18 00
      WriteLn(BoolToStr(TPhoneNumberUtil.IsValidNumber(Number), True)); // True
      WriteLn(NumberTypeToString(TPhoneNumberUtil.GetNumberType(Number)));
                                                                  // FIXED_LINE
    end
    else
      WriteLn('Not a phone number, error ', Ord(Error));

    // One formatter per input field; feed it one character at a time.
    Formatter := TAsYouTypeFormatter.Create('US');
    try
      Digits := '6502530000';
      for I := 1 to Length(Digits) do
        Typed := Formatter.InputDigit(Digits[I]);
      WriteLn(string(Typed));                                     // (650) 253-0000
    finally
      Formatter.Free;
    end;

    // Offsets are zero based, in UTF-16 code units, on both compilers.
    Matches := FindNumbers('Call 044 668 18 00 or +1 650-253-0000.', 'CH');
    for I := 0 to High(Matches) do
      WriteLn(Matches[I].Start, ': ', Matches[I].RawString);    // 5: 044 668 18 00
                                                                  // 22: +1 650-253-0000
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
