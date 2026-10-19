program ShortNumbers;

{
  Short numbers and emergency numbers with LibPhoneNumber.ShortNumberInfo:
  possible and valid short numbers, expected cost, emergency numbers, carrier
  specific and SMS numbers, example short numbers.

  The ShortNumberInfo functions take the calling code and the national
  significant number of a parsed number, except the two emergency functions,
  which take the number exactly as dialled.

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
  LibPhoneNumber.ShortNumberInfo;

const
  Region = 'DE';
  { A typed constant array, not a "for S in [...]" literal: FreePascal 3.2.2
    truncates the elements of such a literal to the length of the first one. }
  ShortCases: array[0..4] of string = ('112', '110', '116000', '1120', '22222');

function YesNo(AValue: Boolean): string;
begin
  if AValue then
    Result := 'yes'
  else
    Result := 'no';
end;

procedure ShowShortNumber(const ADialled: string);
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Nsn: string;
  Cc: Integer;
begin
  WriteLn(ADialled, ' dialled in ', Region);
  if not TPhoneNumberUtil.Parse(ADialled, Region, Number, Error) then
  begin
    WriteLn('  parse failed, error ', Ord(Error));
    Exit;
  end;
  Cc := Number.CountryCode;
  Nsn := Number.NationalNumberDigits;
  WriteLn('  possible short number : ', YesNo(IsPossibleShortNumberForRegion(Cc, Nsn, Region)));
  WriteLn('  valid short number    : ', YesNo(IsValidShortNumberForRegion(Cc, Nsn, Region)));
  WriteLn('  expected cost         : ', ShortNumberCostToString(GetExpectedCostForRegion(Cc, Nsn, Region)));
  WriteLn('  emergency number      : ', YesNo(IsEmergencyNumber(ADialled, Region)));
  WriteLn('  connects to emergency : ', YesNo(ConnectsToEmergencyNumber(ADialled, Region)));
  WriteLn('  carrier specific      : ', YesNo(IsCarrierSpecificForRegion(Cc, Nsn, Region)));
  WriteLn('  SMS service           : ', YesNo(IsSmsServiceForRegion(Cc, Nsn, Region)));
  { A short number is not a valid phone number for TPhoneNumberUtil. }
  WriteLn('  TPhoneNumberUtil.IsValidNumber: ', YesNo(TPhoneNumberUtil.IsValidNumber(Number)));
end;

var
  I: Integer;
begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    WriteLn('== Short numbers');
    for I := Low(ShortCases) to High(ShortCases) do
      ShowShortNumber(ShortCases[I]);
    WriteLn;

    WriteLn('== Emergency numbers are checked on the number as dialled');
    WriteLn('IsEmergencyNumber(''911'', ''US'')   : ', YesNo(IsEmergencyNumber('911', 'US')));
    WriteLn('IsEmergencyNumber(''+1 911'', ''US''): ', YesNo(IsEmergencyNumber('+1 911', 'US')));
    WriteLn('IsEmergencyNumber(''112'', ''us'')   : ', YesNo(IsEmergencyNumber('112', 'us')));
    WriteLn;

    WriteLn('== Example short numbers');
    WriteLn('GetExampleShortNumber(DE)              : ', GetExampleShortNumber('DE'));
    WriteLn('GetExampleShortNumberForCost(DE, toll free)   : "',
      GetExampleShortNumberForCost('DE', sncTollFree), '"');
    WriteLn('GetExampleShortNumberForCost(DE, premium rate): "',
      GetExampleShortNumberForCost('DE', sncPremiumRate), '"');
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
