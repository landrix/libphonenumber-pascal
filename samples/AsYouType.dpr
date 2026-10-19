program AsYouType;

{
  TAsYouTypeFormatter: format a number while it is typed, reuse the
  formatter with Clear, track the cursor with InputDigitAndRememberPosition,
  and what happens when the user types punctuation or an international
  number.

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
  LibPhoneNumber.AsYouTypeFormatter;

{ Feeds AKeys into AFormatter one character at a time and prints every
  intermediate result. The keys are a UnicodeString because InputDigit takes a
  WideChar, which is also what lets a FreePascal program pass a full width
  digit. }
procedure TypeKeys(AFormatter: TAsYouTypeFormatter; const AKeys: UnicodeString);
var
  I: Integer;
begin
  for I := 1 to Length(AKeys) do
    WriteLn('  ', string(AKeys[I]), ' -> "', string(AFormatter.InputDigit(AKeys[I])), '"');
end;

procedure RememberPosition;
const
  Keys = '6502530000';
var
  Formatter: TAsYouTypeFormatter;
  Keys16: UnicodeString;
  Output: UnicodeString;
  I: Integer;
begin
  WriteLn('== InputDigitAndRememberPosition (US, the 4th key is remembered)');
  Formatter := TAsYouTypeFormatter.Create('US');
  try
    Keys16 := Keys;
    for I := 1 to Length(Keys16) do
    begin
      if I = 4 then
        Output := Formatter.InputDigitAndRememberPosition(Keys16[I])
      else
        Output := Formatter.InputDigit(Keys16[I]);
      { The remembered position is the cursor position right behind the
        remembered key in the formatted output; 0 until a key was
        remembered. It follows the key when formatting moves it. }
      WriteLn('  ', string(Keys16[I]), ' -> "', string(Output), '", remembered position ',
        Formatter.GetRememberedPosition);
    end;
  finally
    Formatter.Free;
  end;
  WriteLn;
end;

var
  Formatter: TAsYouTypeFormatter;
begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    { One formatter per input field, created for the region of the user. }
    Formatter := TAsYouTypeFormatter.Create('US');
    try
      WriteLn('== US, digits only');
      TypeKeys(Formatter, '6502530000');
      WriteLn;

      { Clear starts a new number with the same formatter. }
      Formatter.Clear;
      WriteLn('== US, an international number after Clear');
      TypeKeys(Formatter, '+41446681800');
      WriteLn;

      { As soon as the user types a formatting character, the input is echoed
        as typed and no longer formatted. }
      Formatter.Clear;
      WriteLn('== US, the user types a dash');
      TypeKeys(Formatter, '650-253');
      WriteLn;
    finally
      Formatter.Free;
    end;

    { An unknown region still formats numbers that start with a plus. }
    Formatter := TAsYouTypeFormatter.Create('ZZ');
    try
      WriteLn('== Unknown region ZZ');
      TypeKeys(Formatter, '+4930123456');
      WriteLn;
    finally
      Formatter.Free;
    end;

    RememberPosition;
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
