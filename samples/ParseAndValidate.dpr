program ParseAndValidate;

{
  Parsing and validation: what a parsed TPhoneNumber holds, the parse errors,
  possible versus valid, the number types and comparing two numbers.

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
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.PhoneNumberUtil;

type
  TInputCase = record
    Input: string;
    Region: string;
  end;

const
  { A typed constant array, not a "for S in [...]" literal: FreePascal 3.2.2
    truncates the elements of such a literal to the length of the first one. }
  ParseCases: array[0..11] of TInputCase = (
    (Input: '044 668 18 00'; Region: 'CH'),
    (Input: '044 668 18 00'; Region: ' ch '),
    (Input: '+39 02 1234 5678'; Region: 'ZZ'),
    (Input: '030 123456 ext. 42'; Region: 'DE'),
    (Input: '1-800-FLOWERS'; Region: 'US'),
    (Input: 'tel:+41-44-668-18-00'; Region: ''),
    (Input: '0049 30 123456'; Region: 'DE'),
    (Input: 'abc'; Region: 'DE'),
    (Input: '030 123456'; Region: ''),
    (Input: '011'; Region: 'US'),
    (Input: '+49 1'; Region: 'DE'),
    (Input: '+49 123456789012345678'; Region: 'DE')
  );

  TypeCases: array[0..5] of TInputCase = (
    (Input: '044 668 18 00'; Region: 'CH'),
    (Input: '079 123 45 67'; Region: 'CH'),
    (Input: '0800 123 456'; Region: 'CH'),
    (Input: '0900 123 456'; Region: 'CH'),
    (Input: '650 253 0000'; Region: 'US'),
    (Input: '+800 1234 5678'; Region: 'ZZ')
  );

{ The library has no name function for the parse error; keep a local one. }
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

{ Likewise for the result of IsNumberMatch. }
function MatchTypeName(AMatch: TPhoneNumberMatchType): string;
begin
  Result := '';
  case AMatch of
    pnmtNotANumber: Result := 'NOT_A_NUMBER';
    pnmtNoMatch: Result := 'NO_MATCH';
    pnmtShortNsnMatch: Result := 'SHORT_NSN_MATCH';
    pnmtNsnMatch: Result := 'NSN_MATCH';
    pnmtExactMatch: Result := 'EXACT_MATCH';
  end;
end;

{ ADisplay is what is printed for the input: the input itself, or an ASCII
  description of it when it is not ASCII. }
procedure ShowParse(const AInput, ARegion, ADisplay: string);
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  Write(ADisplay, ' in "', ARegion, '": ');
  if not TPhoneNumberUtil.Parse(AInput, ARegion, Number, Error) then
  begin
    WriteLn('FAIL ', ParseErrorName(Error));
    Exit;
  end;
  Write('OK +', Number.CountryCode, ' digits ', Number.NationalNumberDigits,
    ' number ', Number.NationalNumber);
  if Number.Extension <> '' then
    Write(' ext ', Number.Extension);
  WriteLn(' region ', Number.RegionCode);
end;

procedure ParseSection;
var
  I: Integer;
  FullWidth: UnicodeString;
begin
  WriteLn('== Parse');
  for I := Low(ParseCases) to High(ParseCases) do
    ShowParse(ParseCases[I].Input, ParseCases[I].Region, '"' + ParseCases[I].Input + '"');
  { Full width digits U+FF10..U+FF19 are digits too. The input is built from
    code points and only the ASCII result is printed, so the output does not
    depend on the console code page. }
  FullWidth := UnicodeString(#$FF10#$FF13#$FF10#$FF11#$FF12#$FF13#$FF14#$FF15#$FF16);
  ShowParse(string(FullWidth), 'DE', '030123456 in full width digits');
  WriteLn;
end;

procedure PossibleVersusValidSection;
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== Possible versus valid');
  { One digit short: the number parses, but it is neither possible nor valid. }
  if TPhoneNumberUtil.Parse('+1 650 253 000', 'US', Number, Error) then
  begin
    WriteLn('+1 650 253 000 parses     : True');
    WriteLn('  IsPossibleNumberWithReason: ',
      ValidationResultToString(TPhoneNumberUtil.IsPossibleNumberWithReason(Number)));
    WriteLn('  IsValidNumber           : ', BoolToStr(TPhoneNumberUtil.IsValidNumber(Number), True));
    WriteLn('  GetRegionCodeForNumber  : "', TPhoneNumberUtil.GetRegionCodeForNumber(Number), '"');
    WriteLn('  RegionCode field        : "', Number.RegionCode, '"');
  end;
  if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Number, Error) then
  begin
    WriteLn('044 668 18 00 (CH)');
    WriteLn('  IsValidNumber           : ', BoolToStr(TPhoneNumberUtil.IsValidNumber(Number), True));
    WriteLn('  IsValidNumberForRegion CH: ',
      BoolToStr(TPhoneNumberUtil.IsValidNumberForRegion(Number, 'CH'), True));
    WriteLn('  IsValidNumberForRegion ch: ',
      BoolToStr(TPhoneNumberUtil.IsValidNumberForRegion(Number, 'ch'), True));
    WriteLn('  IsValidNumberForRegion DE: ',
      BoolToStr(TPhoneNumberUtil.IsValidNumberForRegion(Number, 'DE'), True));
    WriteLn('  IsPossibleNumberForType MOBILE: ',
      BoolToStr(TPhoneNumberUtil.IsPossibleNumberForType(Number, mntMobile), True));
    WriteLn('  CanBeInternationallyDialled: ',
      BoolToStr(TPhoneNumberUtil.CanBeInternationallyDialled(Number), True));
    { The low level unit function takes the region code exactly. }
    WriteLn('  MetadataCore.IsValidNumberForRegion(cc, nsn, ''ch''): ',
      BoolToStr(LibPhoneNumber.MetadataCore.IsValidNumberForRegion(
        Number.CountryCode, Number.NationalNumberDigits, 'ch'), True));
  end;
  { The string helper parses with the region as DEFAULT region and then
    validates globally: a number with its own calling code is not checked
    against the region. }
  WriteLn('IsValidNumber(''+49 30 123456'', ''CH''): ',
    BoolToStr(TPhoneNumberUtil.IsValidNumber('+49 30 123456', 'CH'), True));
  WriteLn;
end;

procedure TypeSection;
var
  I: Integer;
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== Number types');
  for I := Low(TypeCases) to High(TypeCases) do
    if TPhoneNumberUtil.Parse(TypeCases[I].Input, TypeCases[I].Region, Number, Error) then
      WriteLn(TPhoneNumberUtil.Format(Number, pnfInternational), ': ',
        NumberTypeToString(TPhoneNumberUtil.GetNumberType(Number)), ', region ',
        TPhoneNumberUtil.GetRegionCodeForNumber(Number))
    else
      WriteLn(TypeCases[I].Input, ': FAIL ', ParseErrorName(Error));
  WriteLn;
end;

procedure MatchSection;
var
  First, Second: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  WriteLn('== Comparing numbers');
  WriteLn('+41 44 668 18 00 vs +41446681800    : ',
    MatchTypeName(TPhoneNumberUtil.IsNumberMatch('+41 44 668 18 00', '+41446681800')));
  WriteLn('+41 44 668 18 00 vs 044 668 18 00   : ',
    MatchTypeName(TPhoneNumberUtil.IsNumberMatch('+41 44 668 18 00', '044 668 18 00')));
  WriteLn('+41 44 668 18 00 vs +41 44 668 18 01: ',
    MatchTypeName(TPhoneNumberUtil.IsNumberMatch('+41 44 668 18 00', '+41 44 668 18 01')));
  WriteLn('abc vs +41 44 668 18 00             : ',
    MatchTypeName(TPhoneNumberUtil.IsNumberMatch('abc', '+41 44 668 18 00')));
  if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', First, Error) and
    TPhoneNumberUtil.Parse('+41 44 668 18 00', 'DE', Second, Error) then
  begin
    WriteLn('records 044 668 18 00 (CH) vs +41 44 668 18 00 (DE): ',
      MatchTypeName(TPhoneNumberUtil.IsNumberMatch(First, Second)));
    WriteLn('record 044 668 18 00 (CH) vs string 446681800: ',
      MatchTypeName(TPhoneNumberUtil.IsNumberMatch(First, '446681800')));
  end;
end;

begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    ParseSection;
    PossibleVersusValidSection;
    TypeSection;
    MatchSection;
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
