program FindNumbersInText;

{
  Finding phone numbers in free text: FindNumbers, the four leniency levels,
  iterating with TPhoneNumberMatcher, offsets in text with non ASCII
  characters, and the maxTries budget.

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
  LibPhoneNumber.PhoneNumberUtil,
  LibPhoneNumber.PhoneNumberMatcher;

const
  LeniencyNames: array[TPhoneNumberLeniency] of string = (
    'pnlPossible      ',
    'pnlValid         ',
    'pnlStrictGrouping',
    'pnlExactGrouping '
  );

procedure ShowMatches(const AMatches: TPhoneNumberMatchArray);
var
  I: Integer;
begin
  for I := 0 to High(AMatches) do
    WriteLn('  [', AMatches[I].Start, '..', AMatches[I].EndIndex, ') "',
      AMatches[I].RawString, '" -> ', TPhoneNumberUtil.Format(AMatches[I].Number, pnfE164));
end;

procedure FindSection;
const
  Text = 'Call 044 668 18 00 or +1 650-253-0000 before 6 pm.';
begin
  WriteLn('== FindNumbers (region CH, leniency pnlValid)');
  WriteLn('  ', Text);
  ShowMatches(FindNumbers(Text, 'CH'));
  WriteLn;
end;

procedure LeniencySection;
const
  Text = 'Call 650 253 0000, 650 2530000, 65 02 53 00 00 or 253 0000.';
var
  Leniency: TPhoneNumberLeniency;
begin
  WriteLn('== Leniency levels (region US)');
  WriteLn('  ', Text);
  for Leniency := Low(TPhoneNumberLeniency) to High(TPhoneNumberLeniency) do
  begin
    WriteLn(LeniencyNames[Leniency], ':');
    ShowMatches(FindNumbers(Text, 'US', Leniency, UnlimitedTries));
  end;
  WriteLn;
end;

procedure MatcherSection;
const
  Text = 'Call +41 44 668 18 00 or 044 668 18 00, or +1 650-253-0000.';
var
  Matcher: TPhoneNumberMatcher;
  Match: TPhoneNumberMatch;
begin
  WriteLn('== TPhoneNumberMatcher (region ZZ: only numbers with a calling code)');
  WriteLn('  ', Text);
  Matcher := TPhoneNumberMatcher.Create(Text, 'ZZ', pnlValid, UnlimitedTries);
  try
    while Matcher.TryNext(Match) do
      WriteLn('  ', Match.Start, ': ', Match.RawString);
    { Next without a further match raises, like Java's NoSuchElementException. }
    try
      Matcher.Next;
    except
      on E: EPhoneNumberMatcher do
        WriteLn('  Next after the last match raises ', E.ClassName);
    end;
  finally
    Matcher.Free;
  end;
  WriteLn;
end;

procedure OffsetSection;
var
  Text: UnicodeString;
  Matches: TPhoneNumberMatchArray;
  I: Integer;
begin
  WriteLn('== Offsets are UTF-16 code units');
  { "Tel. " followed by U+00FC U+00E4 and a number. Built from code points
    and never printed raw, so the output does not depend on the console. }
  Text := UnicodeString('Tel. ') + UnicodeString(#$00FC#$00E4) + ' 044 668 18 00';
  WriteLn('  text: "Tel. <U+00FC><U+00E4> 044 668 18 00", ', Length(Text), ' UTF-16 code units');
  Matches := FindNumbers(string(Text), 'CH');
  for I := 0 to High(Matches) do
  begin
    WriteLn('  Start = ', Matches[I].Start, ', EndIndex = ', Matches[I].EndIndex);
    { Slice the UnicodeString form: on FreePascal `string` is UTF-8 and its
      byte indices are NOT these offsets. }
    WriteLn('  slice: "', string(Copy(Text, Matches[I].Start + 1,
      Matches[I].EndIndex - Matches[I].Start)), '"');
  end;
  WriteLn;
end;

procedure MaxTriesSection;
const
  Text = 'Codes: 11-22, 33-44, 55-66, 77-88. Call 044 668 18 00.';
var
  Matcher: TPhoneNumberMatcher;
  Match: TPhoneNumberMatch;
  Budget: Integer;
  Found: Boolean;
begin
  WriteLn('== maxTries (region CH)');
  WriteLn('  ', Text);
  { The budget counts candidates that turn out not to be numbers; when it
    runs out, the matcher stops looking. Here the four codes use up four
    tries before the phone number is reached. }
  for Budget := 3 to 5 do
  begin
    Matcher := TPhoneNumberMatcher.Create(Text, 'CH', pnlValid, Budget);
    try
      Found := Matcher.TryNext(Match);
      if Found then
        WriteLn('  maxTries ', Budget, ': found "', Match.RawString, '"')
      else
        WriteLn('  maxTries ', Budget, ': nothing found');
    finally
      Matcher.Free;
    end;
  end;
end;

begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    FindSection;
    LeniencySection;
    MatcherSection;
    OffsetSection;
    MaxTriesSection;
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
