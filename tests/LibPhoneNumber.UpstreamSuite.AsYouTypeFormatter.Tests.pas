unit LibPhoneNumber.UpstreamSuite.AsYouTypeFormatter.Tests;

{
  Port of upstream AsYouTypeFormatterTest.java.

  Expected values: see the header of LibPhoneNumber.UpstreamSuite.Tests.
  They come straight out of the Java test class, which is correct here and only
  here, because Setup switches the metadata lookup layer onto the generated
  TESTING tables - the same data set the Java suite runs against - and TearDown
  switches it back.

  Shape of the port
  -----------------
  1. Java calls phoneUtil.getAsYouTypeFormatter(region); this port constructs
     TAsYouTypeFormatter directly. NewFormatter frees the previous instance and
     creates the next one, so a test method reads exactly like the Java one.
  2. Java char literals are Pascal WideChar literals, and the non ASCII ones
     are written as code point escapes so this file stays pure ASCII, the same
     convention the rest of the port follows.
  3. getExtractedNationalPrefix is package private upstream and a read only
     property here; both exist only for this test.

  Every one of the 33 test methods of the Java class is ported; nothing is left
  out.

  This unit is a mechanical transcription of the Java source. Keep it that way:
  when upstream changes the file, transcribe again rather than editing single
  expectations.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{ The test sources are pure ASCII and spell every non ASCII character as a
  numeric constant (#$XXXX). Without a source code page FreePascal converts
  such a constant to an AnsiString `string` at COMPILE time through its
  default code page and turns every character outside it into '?'. UTF-8
  as the source code page makes that conversion lossless and matches the
  UTF-8 string contract of the library on FreePascal. }
{$CODEPAGE UTF8}
{ Implicit UnicodeString <-> AnsiString conversions are the documented
  string contract here: the runner sets the UTF-8 conversion code page, so
  they are lossless, and the warning would bury every other one. }
{$WARN 4105 OFF}
{$ENDIF}

interface

uses
  LibPhoneNumber.TestFramework,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.TestingMetadata,
  LibPhoneNumber.AsYouTypeFormatter;

type
  TUpstreamAsYouTypeFormatterTests = class(TTestCase)
  private
    FFormatter: TAsYouTypeFormatter;
    procedure NewFormatter(const ARegionCode: string);
  public
    procedure Setup; override;
    procedure TearDown; override;

  published
    procedure Test_InvalidRegion;
    procedure Test_InvalidPlusSign;
    procedure Test_TooLongNumberMatchingMultipleLeadingDigits;
    procedure Test_CountryWithSpaceInNationalPrefixFormattingRule;
    procedure Test_CountryWithSpaceInNationalPrefixFormattingRuleAndLongNdd;
    procedure Test_AYTFUS;
    procedure Test_AYTFUSFullWidthCharacters;
    procedure Test_AYTFUSMobileShortCode;
    procedure Test_AYTFUSVanityNumber;
    procedure Test_AYTFAndRememberPositionUS;
    procedure Test_AYTFGBFixedLine;
    procedure Test_AYTFGBTollFree;
    procedure Test_AYTFGBPremiumRate;
    procedure Test_AYTFNZMobile;
    procedure Test_AYTFDE;
    procedure Test_AYTFAR;
    procedure Test_AYTFARMobile;
    procedure Test_AYTFKR;
    procedure Test_AYTF_MX;
    procedure Test_AYTF_International_Toll_Free;
    procedure Test_AYTFMultipleLeadingDigitPatterns;
    procedure Test_AYTFLongIDD_AU;
    procedure Test_AYTFLongIDD_KR;
    procedure Test_AYTFLongNDD_KR;
    procedure Test_AYTFLongNDD_SG;
    procedure Test_AYTFShortNumberFormattingFix_AU;
    procedure Test_AYTFShortNumberFormattingFix_KR;
    procedure Test_AYTFShortNumberFormattingFix_MX;
    procedure Test_AYTFNoNationalPrefix;
    procedure Test_AYTFNoNationalPrefixFormattingRule;
    procedure Test_AYTFShortNumberFormattingFix_US;
    procedure Test_AYTFClearNDDAfterIDDExtraction;
    procedure Test_AYTFNumberPatternsBecomingInvalidShouldNotResultInDigitLoss;
  end;

implementation

uses
{$IFDEF FPC}
  SysUtils;
{$ELSE}
  System.SysUtils;
{$ENDIF}

const
  RC_AO = 'AO';
  RC_AR = 'AR';
  RC_AU = 'AU';
  RC_BY = 'BY';
  RC_CN = 'CN';
  RC_DE = 'DE';
  RC_GB = 'GB';
  RC_IT = 'IT';
  RC_JP = 'JP';
  RC_KR = 'KR';
  RC_MX = 'MX';
  RC_NZ = 'NZ';
  RC_SG = 'SG';
  RC_US = 'US';
  RC_ZZ = 'ZZ';

procedure TUpstreamAsYouTypeFormatterTests.Setup;
begin
  UseTestingMetadata;
end;

procedure TUpstreamAsYouTypeFormatterTests.TearDown;
begin
  FreeAndNil(FFormatter);
  RestoreProductionMetadata;
end;

procedure TUpstreamAsYouTypeFormatterTests.NewFormatter(const ARegionCode: string);
begin
  FreeAndNil(FFormatter);
  FFormatter := TAsYouTypeFormatter.Create(ARegionCode);
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_InvalidRegion;
begin
  NewFormatter(RC_ZZ);
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+4', FFormatter.InputDigit('4'));
  Assert.AreEqual('+48 ', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 88', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 88 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+48 88 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+48 88 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+48 88 123 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+48 88 123 12', FFormatter.InputDigit('2'));

  FFormatter.Clear;
  Assert.AreEqual('6', FFormatter.InputDigit('6'));
  Assert.AreEqual('65', FFormatter.InputDigit('5'));
  Assert.AreEqual('650', FFormatter.InputDigit('0'));
  Assert.AreEqual('6502', FFormatter.InputDigit('2'));
  Assert.AreEqual('65025', FFormatter.InputDigit('5'));
  Assert.AreEqual('650253', FFormatter.InputDigit('3'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_InvalidPlusSign;
begin
  NewFormatter(RC_ZZ);
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+4', FFormatter.InputDigit('4'));
  Assert.AreEqual('+48 ', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 88', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 88 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+48 88 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+48 88 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+48 88 123 1', FFormatter.InputDigit('1'));
  { A plus sign can only appear at the beginning of the number; otherwise, no formatting is
    applied. }
  Assert.AreEqual('+48881231+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+48881231+2', FFormatter.InputDigit('2'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_TooLongNumberMatchingMultipleLeadingDigits;
begin
  { See https://github.com/google/libphonenumber/issues/36
    The bug occurred last time for countries which have two formatting rules with exactly the
    same leading digits pattern but differ in length. }
  NewFormatter(RC_ZZ);
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+81 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('+81 9', FFormatter.InputDigit('9'));
  Assert.AreEqual('+81 90', FFormatter.InputDigit('0'));
  Assert.AreEqual('+81 90 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+81 90 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 90 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+81 90 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+81 90 1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+81 90 1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+81 90 1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+81 90 1234 5678', FFormatter.InputDigit('8'));
  Assert.AreEqual('+81 90 12 345 6789', FFormatter.InputDigit('9'));
  Assert.AreEqual('+81901234567890', FFormatter.InputDigit('0'));
  Assert.AreEqual('+819012345678901', FFormatter.InputDigit('1'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_CountryWithSpaceInNationalPrefixFormattingRule;
begin
  NewFormatter(RC_BY);
  Assert.AreEqual('8', FFormatter.InputDigit('8'));
  Assert.AreEqual('88', FFormatter.InputDigit('8'));
  Assert.AreEqual('881', FFormatter.InputDigit('1'));
  Assert.AreEqual('8 819', FFormatter.InputDigit('9'));
  Assert.AreEqual('8 8190', FFormatter.InputDigit('0'));
  { The formatting rule for 5 digit numbers states that no space should be present after the
    national prefix. }
  Assert.AreEqual('881 901', FFormatter.InputDigit('1'));
  Assert.AreEqual('8 819 012', FFormatter.InputDigit('2'));
  { Too long, no formatting rule applies. }
  Assert.AreEqual('88190123', FFormatter.InputDigit('3'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_CountryWithSpaceInNationalPrefixFormattingRuleAndLongNdd;
begin
  NewFormatter(RC_BY);
  Assert.AreEqual('9', FFormatter.InputDigit('9'));
  Assert.AreEqual('99', FFormatter.InputDigit('9'));
  Assert.AreEqual('999', FFormatter.InputDigit('9'));
  Assert.AreEqual('9999', FFormatter.InputDigit('9'));
  Assert.AreEqual('99999 ', FFormatter.InputDigit('9'));
  Assert.AreEqual('99999 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('99999 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('99999 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('99999 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('99999 12 345', FFormatter.InputDigit('5'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFUS;
begin
  NewFormatter(RC_US);
  Assert.AreEqual('6', FFormatter.InputDigit('6'));
  Assert.AreEqual('65', FFormatter.InputDigit('5'));
  Assert.AreEqual('650', FFormatter.InputDigit('0'));
  Assert.AreEqual('650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('650 253', FFormatter.InputDigit('3'));
  { Note this is how a US local number (without area code) should be formatted.
    Note this is how a US local number (without area code) should be formatted. }
  Assert.AreEqual('650 2532', FFormatter.InputDigit('2'));
  Assert.AreEqual('650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual('650 253 2222', FFormatter.InputDigit('2'));

  FFormatter.Clear;
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('16', FFormatter.InputDigit('6'));
  Assert.AreEqual('1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual('1 650', FFormatter.InputDigit('0'));
  Assert.AreEqual('1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('1 650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 253 2222', FFormatter.InputDigit('2'));

  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 4', FFormatter.InputDigit('4'));
  Assert.AreEqual('011 44 ', FFormatter.InputDigit('4'));
  Assert.AreEqual('011 44 6', FFormatter.InputDigit('6'));
  Assert.AreEqual('011 44 61', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 44 6 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 44 6 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('011 44 6 123 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 44 6 123 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 44 6 123 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('011 44 6 123 123 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 44 6 123 123 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 44 6 123 123 123', FFormatter.InputDigit('3'));

  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('011 54 ', FFormatter.InputDigit('4'));
  Assert.AreEqual('011 54 9', FFormatter.InputDigit('9'));
  Assert.AreEqual('011 54 91', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 54 9 11', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 54 9 11 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 54 9 11 23', FFormatter.InputDigit('3'));
  Assert.AreEqual('011 54 9 11 231', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 54 9 11 2312', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 54 9 11 2312 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 54 9 11 2312 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 54 9 11 2312 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('011 54 9 11 2312 1234', FFormatter.InputDigit('4'));

  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 24', FFormatter.InputDigit('4'));
  Assert.AreEqual('011 244 ', FFormatter.InputDigit('4'));
  Assert.AreEqual('011 244 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 244 28', FFormatter.InputDigit('8'));
  Assert.AreEqual('011 244 280', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 244 280 0', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 244 280 00', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 244 280 000', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 244 280 000 0', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 244 280 000 00', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 244 280 000 000', FFormatter.InputDigit('0'));

  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+4', FFormatter.InputDigit('4'));
  Assert.AreEqual('+48 ', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 88', FFormatter.InputDigit('8'));
  Assert.AreEqual('+48 88 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+48 88 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+48 88 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+48 88 123 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+48 88 123 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+48 88 123 12 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+48 88 123 12 12', FFormatter.InputDigit('2'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFUSFullWidthCharacters;
begin
  NewFormatter(RC_US);
  Assert.AreEqual(#$FF16, FFormatter.InputDigit(#$FF16));
  Assert.AreEqual(#$FF16 + #$FF15, FFormatter.InputDigit(#$FF15));
  Assert.AreEqual('650', FFormatter.InputDigit(#$FF10));
  Assert.AreEqual('650 2', FFormatter.InputDigit(#$FF12));
  Assert.AreEqual('650 25', FFormatter.InputDigit(#$FF15));
  Assert.AreEqual('650 253', FFormatter.InputDigit(#$FF13));
  Assert.AreEqual('650 2532', FFormatter.InputDigit(#$FF12));
  Assert.AreEqual('650 253 22', FFormatter.InputDigit(#$FF12));
  Assert.AreEqual('650 253 222', FFormatter.InputDigit(#$FF12));
  Assert.AreEqual('650 253 2222', FFormatter.InputDigit(#$FF12));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFUSMobileShortCode;
begin
  NewFormatter(RC_US);
  Assert.AreEqual('*', FFormatter.InputDigit('*'));
  Assert.AreEqual('*1', FFormatter.InputDigit('1'));
  Assert.AreEqual('*12', FFormatter.InputDigit('2'));
  Assert.AreEqual('*121', FFormatter.InputDigit('1'));
  Assert.AreEqual('*121#', FFormatter.InputDigit('#'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFUSVanityNumber;
begin
  NewFormatter(RC_US);
  Assert.AreEqual('8', FFormatter.InputDigit('8'));
  Assert.AreEqual('80', FFormatter.InputDigit('0'));
  Assert.AreEqual('800', FFormatter.InputDigit('0'));
  Assert.AreEqual('800 ', FFormatter.InputDigit(' '));
  Assert.AreEqual('800 M', FFormatter.InputDigit('M'));
  Assert.AreEqual('800 MY', FFormatter.InputDigit('Y'));
  Assert.AreEqual('800 MY ', FFormatter.InputDigit(' '));
  Assert.AreEqual('800 MY A', FFormatter.InputDigit('A'));
  Assert.AreEqual('800 MY AP', FFormatter.InputDigit('P'));
  Assert.AreEqual('800 MY APP', FFormatter.InputDigit('P'));
  Assert.AreEqual('800 MY APPL', FFormatter.InputDigit('L'));
  Assert.AreEqual('800 MY APPLE', FFormatter.InputDigit('E'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFAndRememberPositionUS;
begin
  NewFormatter(RC_US);
  Assert.AreEqual('1', FFormatter.InputDigitAndRememberPosition('1'));
  Assert.AreEqual(Integer(1), FFormatter.GetRememberedPosition);
  Assert.AreEqual('16', FFormatter.InputDigit('6'));
  Assert.AreEqual('1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual(Integer(1), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650', FFormatter.InputDigitAndRememberPosition('0'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 25', FFormatter.InputDigit('5'));
  { Note the remembered position for digit "0" changes from 4 to 5, because a space is now
    inserted in the front. }
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650 253 222',
    FFormatter.InputDigitAndRememberPosition('2'));
  Assert.AreEqual(Integer(13), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650 253 2222', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(13), FFormatter.GetRememberedPosition);
  Assert.AreEqual('165025322222', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(10), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1650253222222', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(10), FFormatter.GetRememberedPosition);

  FFormatter.Clear;
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('16', FFormatter.InputDigitAndRememberPosition('6'));
  Assert.AreEqual(Integer(2), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual('1 650', FFormatter.InputDigit('0'));
  Assert.AreEqual(Integer(3), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual(Integer(3), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(3), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1 650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 650 253 2222', FFormatter.InputDigit('2'));
  Assert.AreEqual('165025322222', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(2), FFormatter.GetRememberedPosition);
  Assert.AreEqual('1650253222222', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(2), FFormatter.GetRememberedPosition);

  FFormatter.Clear;
  Assert.AreEqual('6', FFormatter.InputDigit('6'));
  Assert.AreEqual('65', FFormatter.InputDigit('5'));
  Assert.AreEqual('650', FFormatter.InputDigit('0'));
  Assert.AreEqual('650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('650 2532', FFormatter.InputDigitAndRememberPosition('2'));
  Assert.AreEqual(Integer(8), FFormatter.GetRememberedPosition);
  Assert.AreEqual('650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(9), FFormatter.GetRememberedPosition);
  Assert.AreEqual('650 253 222', FFormatter.InputDigit('2'));
  { No more formatting when semicolon is entered. }
  Assert.AreEqual('650253222;', FFormatter.InputDigit(';'));
  Assert.AreEqual(Integer(7), FFormatter.GetRememberedPosition);
  Assert.AreEqual('650253222;2', FFormatter.InputDigit('2'));

  FFormatter.Clear;
  Assert.AreEqual('6', FFormatter.InputDigit('6'));
  Assert.AreEqual('65', FFormatter.InputDigit('5'));
  Assert.AreEqual('650', FFormatter.InputDigit('0'));
  { No more formatting when users choose to do their own formatting. }
  Assert.AreEqual('650-', FFormatter.InputDigit('-'));
  Assert.AreEqual('650-2', FFormatter.InputDigitAndRememberPosition('2'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('650-25', FFormatter.InputDigit('5'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('650-253', FFormatter.InputDigit('3'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('650-253-', FFormatter.InputDigit('-'));
  Assert.AreEqual('650-253-2', FFormatter.InputDigit('2'));
  Assert.AreEqual('650-253-22', FFormatter.InputDigit('2'));
  Assert.AreEqual('650-253-222', FFormatter.InputDigit('2'));
  Assert.AreEqual('650-253-2222', FFormatter.InputDigit('2'));

  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 4', FFormatter.InputDigitAndRememberPosition('4'));
  Assert.AreEqual('011 48 ', FFormatter.InputDigit('8'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('011 48 8', FFormatter.InputDigit('8'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('011 48 88', FFormatter.InputDigit('8'));
  Assert.AreEqual('011 48 88 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 48 88 12', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('011 48 88 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('011 48 88 123 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 48 88 123 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('011 48 88 123 12 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 48 88 123 12 12', FFormatter.InputDigit('2'));

  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+1 6', FFormatter.InputDigitAndRememberPosition('6'));
  Assert.AreEqual('+1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual('+1 650', FFormatter.InputDigit('0'));
  Assert.AreEqual(Integer(4), FFormatter.GetRememberedPosition);
  Assert.AreEqual('+1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(4), FFormatter.GetRememberedPosition);
  Assert.AreEqual('+1 650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('+1 650 253', FFormatter.InputDigitAndRememberPosition('3'));
  Assert.AreEqual('+1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('+1 650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(10), FFormatter.GetRememberedPosition);

  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+1 6', FFormatter.InputDigitAndRememberPosition('6'));
  Assert.AreEqual('+1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual('+1 650', FFormatter.InputDigit('0'));
  Assert.AreEqual(Integer(4), FFormatter.GetRememberedPosition);
  Assert.AreEqual('+1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual(Integer(4), FFormatter.GetRememberedPosition);
  Assert.AreEqual('+1 650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('+1 650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('+1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('+1 650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual('+1650253222;', FFormatter.InputDigit(';'));
  Assert.AreEqual(Integer(3), FFormatter.GetRememberedPosition);
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFGBFixedLine;
begin
  NewFormatter(RC_GB);
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('02', FFormatter.InputDigit('2'));
  Assert.AreEqual('020', FFormatter.InputDigit('0'));
  Assert.AreEqual('020 7', FFormatter.InputDigitAndRememberPosition('7'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('020 70', FFormatter.InputDigit('0'));
  Assert.AreEqual('020 703', FFormatter.InputDigit('3'));
  Assert.AreEqual(Integer(5), FFormatter.GetRememberedPosition);
  Assert.AreEqual('020 7031', FFormatter.InputDigit('1'));
  Assert.AreEqual('020 7031 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('020 7031 30', FFormatter.InputDigit('0'));
  Assert.AreEqual('020 7031 300', FFormatter.InputDigit('0'));
  Assert.AreEqual('020 7031 3000', FFormatter.InputDigit('0'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFGBTollFree;
begin
  NewFormatter(RC_GB);
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('08', FFormatter.InputDigit('8'));
  Assert.AreEqual('080', FFormatter.InputDigit('0'));
  Assert.AreEqual('080 7', FFormatter.InputDigit('7'));
  Assert.AreEqual('080 70', FFormatter.InputDigit('0'));
  Assert.AreEqual('080 703', FFormatter.InputDigit('3'));
  Assert.AreEqual('080 7031', FFormatter.InputDigit('1'));
  Assert.AreEqual('080 7031 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('080 7031 30', FFormatter.InputDigit('0'));
  Assert.AreEqual('080 7031 300', FFormatter.InputDigit('0'));
  Assert.AreEqual('080 7031 3000', FFormatter.InputDigit('0'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFGBPremiumRate;
begin
  NewFormatter(RC_GB);
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('09', FFormatter.InputDigit('9'));
  Assert.AreEqual('090', FFormatter.InputDigit('0'));
  Assert.AreEqual('090 7', FFormatter.InputDigit('7'));
  Assert.AreEqual('090 70', FFormatter.InputDigit('0'));
  Assert.AreEqual('090 703', FFormatter.InputDigit('3'));
  Assert.AreEqual('090 7031', FFormatter.InputDigit('1'));
  Assert.AreEqual('090 7031 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('090 7031 30', FFormatter.InputDigit('0'));
  Assert.AreEqual('090 7031 300', FFormatter.InputDigit('0'));
  Assert.AreEqual('090 7031 3000', FFormatter.InputDigit('0'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFNZMobile;
begin
  NewFormatter(RC_NZ);
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('02', FFormatter.InputDigit('2'));
  Assert.AreEqual('021', FFormatter.InputDigit('1'));
  Assert.AreEqual('02-11', FFormatter.InputDigit('1'));
  Assert.AreEqual('02-112', FFormatter.InputDigit('2'));
  { Note the unittest is using fake metadata which might produce non-ideal results.
    Note the unittest is using fake metadata which might produce non-ideal results. }
  Assert.AreEqual('02-112 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('02-112 34', FFormatter.InputDigit('4'));
  Assert.AreEqual('02-112 345', FFormatter.InputDigit('5'));
  Assert.AreEqual('02-112 3456', FFormatter.InputDigit('6'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFDE;
begin
  NewFormatter(RC_DE);
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('03', FFormatter.InputDigit('3'));
  Assert.AreEqual('030', FFormatter.InputDigit('0'));
  Assert.AreEqual('030/1', FFormatter.InputDigit('1'));
  Assert.AreEqual('030/12', FFormatter.InputDigit('2'));
  Assert.AreEqual('030/123', FFormatter.InputDigit('3'));
  Assert.AreEqual('030/1234', FFormatter.InputDigit('4'));

  { 04134 1234 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('04', FFormatter.InputDigit('4'));
  Assert.AreEqual('041', FFormatter.InputDigit('1'));
  Assert.AreEqual('041 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('041 34', FFormatter.InputDigit('4'));
  Assert.AreEqual('04134 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('04134 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('04134 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('04134 1234', FFormatter.InputDigit('4'));

  { 08021 2345 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('08', FFormatter.InputDigit('8'));
  Assert.AreEqual('080', FFormatter.InputDigit('0'));
  Assert.AreEqual('080 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('080 21', FFormatter.InputDigit('1'));
  Assert.AreEqual('08021 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('08021 23', FFormatter.InputDigit('3'));
  Assert.AreEqual('08021 234', FFormatter.InputDigit('4'));
  Assert.AreEqual('08021 2345', FFormatter.InputDigit('5'));

  { 00 1 650 253 2250 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('00', FFormatter.InputDigit('0'));
  Assert.AreEqual('00 1 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('00 1 6', FFormatter.InputDigit('6'));
  Assert.AreEqual('00 1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual('00 1 650', FFormatter.InputDigit('0'));
  Assert.AreEqual('00 1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('00 1 650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('00 1 650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('00 1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('00 1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('00 1 650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual('00 1 650 253 2222', FFormatter.InputDigit('2'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFAR;
begin
  NewFormatter(RC_AR);
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 7', FFormatter.InputDigit('7'));
  Assert.AreEqual('011 70', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 703', FFormatter.InputDigit('3'));
  Assert.AreEqual('011 7031', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 7031-3', FFormatter.InputDigit('3'));
  Assert.AreEqual('011 7031-30', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 7031-300', FFormatter.InputDigit('0'));
  Assert.AreEqual('011 7031-3000', FFormatter.InputDigit('0'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFARMobile;
begin
  NewFormatter(RC_AR);
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+54 ', FFormatter.InputDigit('4'));
  Assert.AreEqual('+54 9', FFormatter.InputDigit('9'));
  Assert.AreEqual('+54 91', FFormatter.InputDigit('1'));
  Assert.AreEqual('+54 9 11', FFormatter.InputDigit('1'));
  Assert.AreEqual('+54 9 11 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+54 9 11 23', FFormatter.InputDigit('3'));
  Assert.AreEqual('+54 9 11 231', FFormatter.InputDigit('1'));
  Assert.AreEqual('+54 9 11 2312', FFormatter.InputDigit('2'));
  Assert.AreEqual('+54 9 11 2312 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+54 9 11 2312 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+54 9 11 2312 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+54 9 11 2312 1234', FFormatter.InputDigit('4'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFKR;
begin
  { +82 51 234 5678 }
  NewFormatter(RC_KR);
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+82 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+82 51', FFormatter.InputDigit('1'));
  Assert.AreEqual('+82 51-2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 51-23', FFormatter.InputDigit('3'));
  Assert.AreEqual('+82 51-234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+82 51-234-5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+82 51-234-56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+82 51-234-567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+82 51-234-5678', FFormatter.InputDigit('8'));

  { +82 2 531 5678 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+82 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('+82 2-53', FFormatter.InputDigit('3'));
  Assert.AreEqual('+82 2-531', FFormatter.InputDigit('1'));
  Assert.AreEqual('+82 2-531-5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+82 2-531-56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+82 2-531-567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+82 2-531-5678', FFormatter.InputDigit('8'));

  { +82 2 3665 5678 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+82 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 23', FFormatter.InputDigit('3'));
  Assert.AreEqual('+82 2-36', FFormatter.InputDigit('6'));
  Assert.AreEqual('+82 2-366', FFormatter.InputDigit('6'));
  Assert.AreEqual('+82 2-3665', FFormatter.InputDigit('5'));
  Assert.AreEqual('+82 2-3665-5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+82 2-3665-56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+82 2-3665-567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+82 2-3665-5678', FFormatter.InputDigit('8'));

  { 02-114 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('02', FFormatter.InputDigit('2'));
  Assert.AreEqual('021', FFormatter.InputDigit('1'));
  Assert.AreEqual('02-11', FFormatter.InputDigit('1'));
  Assert.AreEqual('02-114', FFormatter.InputDigit('4'));

  { 02-1300 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('02', FFormatter.InputDigit('2'));
  Assert.AreEqual('021', FFormatter.InputDigit('1'));
  Assert.AreEqual('02-13', FFormatter.InputDigit('3'));
  Assert.AreEqual('02-130', FFormatter.InputDigit('0'));
  Assert.AreEqual('02-1300', FFormatter.InputDigit('0'));

  { 011-456-7890 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011', FFormatter.InputDigit('1'));
  Assert.AreEqual('011-4', FFormatter.InputDigit('4'));
  Assert.AreEqual('011-45', FFormatter.InputDigit('5'));
  Assert.AreEqual('011-456', FFormatter.InputDigit('6'));
  Assert.AreEqual('011-456-7', FFormatter.InputDigit('7'));
  Assert.AreEqual('011-456-78', FFormatter.InputDigit('8'));
  Assert.AreEqual('011-456-789', FFormatter.InputDigit('9'));
  Assert.AreEqual('011-456-7890', FFormatter.InputDigit('0'));

  { 011-9876-7890 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011', FFormatter.InputDigit('1'));
  Assert.AreEqual('011-9', FFormatter.InputDigit('9'));
  Assert.AreEqual('011-98', FFormatter.InputDigit('8'));
  Assert.AreEqual('011-987', FFormatter.InputDigit('7'));
  Assert.AreEqual('011-9876', FFormatter.InputDigit('6'));
  Assert.AreEqual('011-9876-7', FFormatter.InputDigit('7'));
  Assert.AreEqual('011-9876-78', FFormatter.InputDigit('8'));
  Assert.AreEqual('011-9876-789', FFormatter.InputDigit('9'));
  Assert.AreEqual('011-9876-7890', FFormatter.InputDigit('0'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTF_MX;
begin
  NewFormatter(RC_MX);

  { +52 800 123 4567 }
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+52 80', FFormatter.InputDigit('0'));
  Assert.AreEqual('+52 800', FFormatter.InputDigit('0'));
  Assert.AreEqual('+52 800 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 800 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 800 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+52 800 123 4', FFormatter.InputDigit('4'));
  Assert.AreEqual('+52 800 123 45', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 800 123 456', FFormatter.InputDigit('6'));
  Assert.AreEqual('+52 800 123 4567', FFormatter.InputDigit('7'));

  { +529011234567, proactively ensuring that no formatting is applied, where a format is chosen
    that would otherwise have led to some digits being dropped. }
  FFormatter.Clear;
  Assert.AreEqual('9', FFormatter.InputDigit('9'));
  Assert.AreEqual('90', FFormatter.InputDigit('0'));
  Assert.AreEqual('901', FFormatter.InputDigit('1'));
  Assert.AreEqual('9011', FFormatter.InputDigit('1'));
  Assert.AreEqual('90112', FFormatter.InputDigit('2'));
  Assert.AreEqual('901123', FFormatter.InputDigit('3'));
  Assert.AreEqual('9011234', FFormatter.InputDigit('4'));
  Assert.AreEqual('90112345', FFormatter.InputDigit('5'));
  Assert.AreEqual('901123456', FFormatter.InputDigit('6'));
  Assert.AreEqual('9011234567', FFormatter.InputDigit('7'));

  { +52 55 1234 5678 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 55', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 55 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 55 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 55 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+52 55 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+52 55 1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 55 1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+52 55 1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+52 55 1234 5678', FFormatter.InputDigit('8'));

  { +52 212 345 6789 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 21', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 212', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 212 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('+52 212 34', FFormatter.InputDigit('4'));
  Assert.AreEqual('+52 212 345', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 212 345 6', FFormatter.InputDigit('6'));
  Assert.AreEqual('+52 212 345 67', FFormatter.InputDigit('7'));
  Assert.AreEqual('+52 212 345 678', FFormatter.InputDigit('8'));
  Assert.AreEqual('+52 212 345 6789', FFormatter.InputDigit('9'));

  { +52 1 55 1234 5678 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 15', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 1 55', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 1 55 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 1 55 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 1 55 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+52 1 55 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+52 1 55 1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 1 55 1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+52 1 55 1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+52 1 55 1234 5678', FFormatter.InputDigit('8'));

  { +52 1 541 234 5678 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 15', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 1 54', FFormatter.InputDigit('4'));
  Assert.AreEqual('+52 1 541', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 1 541 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 1 541 23', FFormatter.InputDigit('3'));
  Assert.AreEqual('+52 1 541 234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+52 1 541 234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 1 541 234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+52 1 541 234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+52 1 541 234 5678', FFormatter.InputDigit('8'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTF_International_Toll_Free;
begin
  NewFormatter(RC_US);
  { +800 1234 5678 }
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+80', FFormatter.InputDigit('0'));
  Assert.AreEqual('+800 ', FFormatter.InputDigit('0'));
  Assert.AreEqual('+800 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+800 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+800 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+800 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+800 1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+800 1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+800 1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+800 1234 5678', FFormatter.InputDigit('8'));
  Assert.AreEqual('+800123456789', FFormatter.InputDigit('9'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFMultipleLeadingDigitPatterns;
begin
  { +81 50 2345 6789 }
  NewFormatter(RC_JP);
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+81 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('+81 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+81 50', FFormatter.InputDigit('0'));
  Assert.AreEqual('+81 50 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 50 23', FFormatter.InputDigit('3'));
  Assert.AreEqual('+81 50 234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+81 50 2345', FFormatter.InputDigit('5'));
  Assert.AreEqual('+81 50 2345 6', FFormatter.InputDigit('6'));
  Assert.AreEqual('+81 50 2345 67', FFormatter.InputDigit('7'));
  Assert.AreEqual('+81 50 2345 678', FFormatter.InputDigit('8'));
  Assert.AreEqual('+81 50 2345 6789', FFormatter.InputDigit('9'));

  { +81 222 12 5678 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+81 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('+81 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 22 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 22 21', FFormatter.InputDigit('1'));
  Assert.AreEqual('+81 2221 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 222 12 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+81 222 12 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+81 222 12 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+81 222 12 5678', FFormatter.InputDigit('8'));

  { 011113 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('01', FFormatter.InputDigit('1'));
  Assert.AreEqual('011', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('011 11', FFormatter.InputDigit('1'));
  Assert.AreEqual('011113', FFormatter.InputDigit('3'));

  { +81 3332 2 5678 }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+81 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('+81 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('+81 33', FFormatter.InputDigit('3'));
  Assert.AreEqual('+81 33 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('+81 3332', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 3332 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+81 3332 2 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+81 3332 2 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+81 3332 2 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+81 3332 2 5678', FFormatter.InputDigit('8'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFLongIDD_AU;
begin
  NewFormatter(RC_AU);
  { 0011 1 650 253 2250 }
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('00', FFormatter.InputDigit('0'));
  Assert.AreEqual('001', FFormatter.InputDigit('1'));
  Assert.AreEqual('0011', FFormatter.InputDigit('1'));
  Assert.AreEqual('0011 1 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('0011 1 6', FFormatter.InputDigit('6'));
  Assert.AreEqual('0011 1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual('0011 1 650', FFormatter.InputDigit('0'));
  Assert.AreEqual('0011 1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 1 650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('0011 1 650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('0011 1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 1 650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 1 650 253 2222', FFormatter.InputDigit('2'));

  { 0011 81 3332 2 5678 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('00', FFormatter.InputDigit('0'));
  Assert.AreEqual('001', FFormatter.InputDigit('1'));
  Assert.AreEqual('0011', FFormatter.InputDigit('1'));
  Assert.AreEqual('00118', FFormatter.InputDigit('8'));
  Assert.AreEqual('0011 81 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('0011 81 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('0011 81 33', FFormatter.InputDigit('3'));
  Assert.AreEqual('0011 81 33 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('0011 81 3332', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 81 3332 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 81 3332 2 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('0011 81 3332 2 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('0011 81 3332 2 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('0011 81 3332 2 5678', FFormatter.InputDigit('8'));

  { 0011 244 250 253 222 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('00', FFormatter.InputDigit('0'));
  Assert.AreEqual('001', FFormatter.InputDigit('1'));
  Assert.AreEqual('0011', FFormatter.InputDigit('1'));
  Assert.AreEqual('00112', FFormatter.InputDigit('2'));
  Assert.AreEqual('001124', FFormatter.InputDigit('4'));
  Assert.AreEqual('0011 244 ', FFormatter.InputDigit('4'));
  Assert.AreEqual('0011 244 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 244 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('0011 244 250', FFormatter.InputDigit('0'));
  Assert.AreEqual('0011 244 250 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 244 250 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('0011 244 250 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('0011 244 250 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 244 250 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('0011 244 250 253 222', FFormatter.InputDigit('2'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFLongIDD_KR;
begin
  NewFormatter(RC_KR);
  { 00300 1 650 253 2222 }
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('00', FFormatter.InputDigit('0'));
  Assert.AreEqual('003', FFormatter.InputDigit('3'));
  Assert.AreEqual('0030', FFormatter.InputDigit('0'));
  Assert.AreEqual('00300', FFormatter.InputDigit('0'));
  Assert.AreEqual('00300 1 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('00300 1 6', FFormatter.InputDigit('6'));
  Assert.AreEqual('00300 1 65', FFormatter.InputDigit('5'));
  Assert.AreEqual('00300 1 650', FFormatter.InputDigit('0'));
  Assert.AreEqual('00300 1 650 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('00300 1 650 25', FFormatter.InputDigit('5'));
  Assert.AreEqual('00300 1 650 253', FFormatter.InputDigit('3'));
  Assert.AreEqual('00300 1 650 253 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('00300 1 650 253 22', FFormatter.InputDigit('2'));
  Assert.AreEqual('00300 1 650 253 222', FFormatter.InputDigit('2'));
  Assert.AreEqual('00300 1 650 253 2222', FFormatter.InputDigit('2'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFLongNDD_KR;
begin
  NewFormatter(RC_KR);
  { 08811-9876-7890 }
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('08', FFormatter.InputDigit('8'));
  Assert.AreEqual('088', FFormatter.InputDigit('8'));
  Assert.AreEqual('0881', FFormatter.InputDigit('1'));
  Assert.AreEqual('08811', FFormatter.InputDigit('1'));
  Assert.AreEqual('08811-9', FFormatter.InputDigit('9'));
  Assert.AreEqual('08811-98', FFormatter.InputDigit('8'));
  Assert.AreEqual('08811-987', FFormatter.InputDigit('7'));
  Assert.AreEqual('08811-9876', FFormatter.InputDigit('6'));
  Assert.AreEqual('08811-9876-7', FFormatter.InputDigit('7'));
  Assert.AreEqual('08811-9876-78', FFormatter.InputDigit('8'));
  Assert.AreEqual('08811-9876-789', FFormatter.InputDigit('9'));
  Assert.AreEqual('08811-9876-7890', FFormatter.InputDigit('0'));

  { 08500 11-9876-7890 }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('08', FFormatter.InputDigit('8'));
  Assert.AreEqual('085', FFormatter.InputDigit('5'));
  Assert.AreEqual('0850', FFormatter.InputDigit('0'));
  Assert.AreEqual('08500 ', FFormatter.InputDigit('0'));
  Assert.AreEqual('08500 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('08500 11', FFormatter.InputDigit('1'));
  Assert.AreEqual('08500 11-9', FFormatter.InputDigit('9'));
  Assert.AreEqual('08500 11-98', FFormatter.InputDigit('8'));
  Assert.AreEqual('08500 11-987', FFormatter.InputDigit('7'));
  Assert.AreEqual('08500 11-9876', FFormatter.InputDigit('6'));
  Assert.AreEqual('08500 11-9876-7', FFormatter.InputDigit('7'));
  Assert.AreEqual('08500 11-9876-78', FFormatter.InputDigit('8'));
  Assert.AreEqual('08500 11-9876-789', FFormatter.InputDigit('9'));
  Assert.AreEqual('08500 11-9876-7890', FFormatter.InputDigit('0'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFLongNDD_SG;
begin
  NewFormatter(RC_SG);
  { 777777 9876 7890 }
  Assert.AreEqual('7', FFormatter.InputDigit('7'));
  Assert.AreEqual('77', FFormatter.InputDigit('7'));
  Assert.AreEqual('777', FFormatter.InputDigit('7'));
  Assert.AreEqual('7777', FFormatter.InputDigit('7'));
  Assert.AreEqual('77777', FFormatter.InputDigit('7'));
  Assert.AreEqual('777777 ', FFormatter.InputDigit('7'));
  Assert.AreEqual('777777 9', FFormatter.InputDigit('9'));
  Assert.AreEqual('777777 98', FFormatter.InputDigit('8'));
  Assert.AreEqual('777777 987', FFormatter.InputDigit('7'));
  Assert.AreEqual('777777 9876', FFormatter.InputDigit('6'));
  Assert.AreEqual('777777 9876 7', FFormatter.InputDigit('7'));
  Assert.AreEqual('777777 9876 78', FFormatter.InputDigit('8'));
  Assert.AreEqual('777777 9876 789', FFormatter.InputDigit('9'));
  Assert.AreEqual('777777 9876 7890', FFormatter.InputDigit('0'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFShortNumberFormattingFix_AU;
begin
  { For Australia, the national prefix is not optional when formatting. }
  NewFormatter(RC_AU);

  { 1234567890 - For leading digit 1, the national prefix formatting rule has first group only.
    1234567890 - For leading digit 1, the national prefix formatting rule has first group only. }
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('12', FFormatter.InputDigit('2'));
  Assert.AreEqual('123', FFormatter.InputDigit('3'));
  Assert.AreEqual('1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('1234 567 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('1234 567 89', FFormatter.InputDigit('9'));
  Assert.AreEqual('1234 567 890', FFormatter.InputDigit('0'));

  { +61 1234 567 890 - Test the same number, but with the country code. }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+6', FFormatter.InputDigit('6'));
  Assert.AreEqual('+61 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('+61 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+61 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+61 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+61 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+61 1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+61 1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+61 1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+61 1234 567 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+61 1234 567 89', FFormatter.InputDigit('9'));
  Assert.AreEqual('+61 1234 567 890', FFormatter.InputDigit('0'));

  { 212345678 - For leading digit 2, the national prefix formatting rule puts the national prefix
    before the first group. }
  FFormatter.Clear;
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('02', FFormatter.InputDigit('2'));
  Assert.AreEqual('021', FFormatter.InputDigit('1'));
  Assert.AreEqual('02 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('02 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('02 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('02 1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('02 1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('02 1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('02 1234 5678', FFormatter.InputDigit('8'));

  { 212345678 - Test the same number, but without the leading 0. }
  FFormatter.Clear;
  Assert.AreEqual('2', FFormatter.InputDigit('2'));
  Assert.AreEqual('21', FFormatter.InputDigit('1'));
  Assert.AreEqual('212', FFormatter.InputDigit('2'));
  Assert.AreEqual('2123', FFormatter.InputDigit('3'));
  Assert.AreEqual('21234', FFormatter.InputDigit('4'));
  Assert.AreEqual('212345', FFormatter.InputDigit('5'));
  Assert.AreEqual('2123456', FFormatter.InputDigit('6'));
  Assert.AreEqual('21234567', FFormatter.InputDigit('7'));
  Assert.AreEqual('212345678', FFormatter.InputDigit('8'));

  { +61 2 1234 5678 - Test the same number, but with the country code. }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+6', FFormatter.InputDigit('6'));
  Assert.AreEqual('+61 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('+61 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+61 21', FFormatter.InputDigit('1'));
  Assert.AreEqual('+61 2 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+61 2 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+61 2 1234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+61 2 1234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+61 2 1234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('+61 2 1234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('+61 2 1234 5678', FFormatter.InputDigit('8'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFShortNumberFormattingFix_KR;
begin
  { For Korea, the national prefix is not optional when formatting, and the national prefix
    formatting rule doesn't consist of only the first group. }
  NewFormatter(RC_KR);

  { 111 }
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('11', FFormatter.InputDigit('1'));
  Assert.AreEqual('111', FFormatter.InputDigit('1'));

  { 114 }
  FFormatter.Clear;
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('11', FFormatter.InputDigit('1'));
  Assert.AreEqual('114', FFormatter.InputDigit('4'));

  { 13121234 - Test a mobile number without the national prefix. Even though it is not an
    emergency number, it should be formatted as a block. }
  FFormatter.Clear;
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('13', FFormatter.InputDigit('3'));
  Assert.AreEqual('131', FFormatter.InputDigit('1'));
  Assert.AreEqual('1312', FFormatter.InputDigit('2'));
  Assert.AreEqual('13121', FFormatter.InputDigit('1'));
  Assert.AreEqual('131212', FFormatter.InputDigit('2'));
  Assert.AreEqual('1312123', FFormatter.InputDigit('3'));
  Assert.AreEqual('13121234', FFormatter.InputDigit('4'));

  { +82 131-2-1234 - Test the same number, but with the country code. }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+82 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+82 13', FFormatter.InputDigit('3'));
  Assert.AreEqual('+82 131', FFormatter.InputDigit('1'));
  Assert.AreEqual('+82 131-2', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 131-2-1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+82 131-2-12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+82 131-2-123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+82 131-2-1234', FFormatter.InputDigit('4'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFShortNumberFormattingFix_MX;
begin
  { For Mexico, the national prefix is optional when formatting. }
  NewFormatter(RC_MX);

  { 911 }
  Assert.AreEqual('9', FFormatter.InputDigit('9'));
  Assert.AreEqual('91', FFormatter.InputDigit('1'));
  Assert.AreEqual('911', FFormatter.InputDigit('1'));

  { 800 123 4567 - Test a toll-free number, which should have a formatting rule applied to it
    even though it doesn't begin with the national prefix. }
  FFormatter.Clear;
  Assert.AreEqual('8', FFormatter.InputDigit('8'));
  Assert.AreEqual('80', FFormatter.InputDigit('0'));
  Assert.AreEqual('800', FFormatter.InputDigit('0'));
  Assert.AreEqual('800 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('800 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('800 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('800 123 4', FFormatter.InputDigit('4'));
  Assert.AreEqual('800 123 45', FFormatter.InputDigit('5'));
  Assert.AreEqual('800 123 456', FFormatter.InputDigit('6'));
  Assert.AreEqual('800 123 4567', FFormatter.InputDigit('7'));

  { +52 800 123 4567 - Test the same number, but with the country code. }
  FFormatter.Clear;
  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+5', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 ', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+52 80', FFormatter.InputDigit('0'));
  Assert.AreEqual('+52 800', FFormatter.InputDigit('0'));
  Assert.AreEqual('+52 800 1', FFormatter.InputDigit('1'));
  Assert.AreEqual('+52 800 12', FFormatter.InputDigit('2'));
  Assert.AreEqual('+52 800 123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+52 800 123 4', FFormatter.InputDigit('4'));
  Assert.AreEqual('+52 800 123 45', FFormatter.InputDigit('5'));
  Assert.AreEqual('+52 800 123 456', FFormatter.InputDigit('6'));
  Assert.AreEqual('+52 800 123 4567', FFormatter.InputDigit('7'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFNoNationalPrefix;
begin
  NewFormatter(RC_IT);

  Assert.AreEqual('3', FFormatter.InputDigit('3'));
  Assert.AreEqual('33', FFormatter.InputDigit('3'));
  Assert.AreEqual('333', FFormatter.InputDigit('3'));
  Assert.AreEqual('333 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('333 33', FFormatter.InputDigit('3'));
  Assert.AreEqual('333 333', FFormatter.InputDigit('3'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFNoNationalPrefixFormattingRule;
begin
  NewFormatter(RC_AO);

  Assert.AreEqual('3', FFormatter.InputDigit('3'));
  Assert.AreEqual('33', FFormatter.InputDigit('3'));
  Assert.AreEqual('333', FFormatter.InputDigit('3'));
  Assert.AreEqual('333 3', FFormatter.InputDigit('3'));
  Assert.AreEqual('333 33', FFormatter.InputDigit('3'));
  Assert.AreEqual('333 333', FFormatter.InputDigit('3'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFShortNumberFormattingFix_US;
begin
  { For the US, an initial 1 is treated specially. }
  NewFormatter(RC_US);

  { 101 - Test that the initial 1 is not treated as a national prefix. }
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('10', FFormatter.InputDigit('0'));
  Assert.AreEqual('101', FFormatter.InputDigit('1'));

  { 112 - Test that the initial 1 is not treated as a national prefix. }
  FFormatter.Clear;
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('11', FFormatter.InputDigit('1'));
  Assert.AreEqual('112', FFormatter.InputDigit('2'));

  { 122 - Test that the initial 1 is treated as a national prefix. }
  FFormatter.Clear;
  Assert.AreEqual('1', FFormatter.InputDigit('1'));
  Assert.AreEqual('12', FFormatter.InputDigit('2'));
  Assert.AreEqual('1 22', FFormatter.InputDigit('2'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFClearNDDAfterIDDExtraction;
begin
  NewFormatter(RC_KR);

  { Check that when we have successfully extracted an IDD, the previously extracted NDD is
    cleared since it is no longer valid. }
  Assert.AreEqual('0', FFormatter.InputDigit('0'));
  Assert.AreEqual('00', FFormatter.InputDigit('0'));
  Assert.AreEqual('007', FFormatter.InputDigit('7'));
  Assert.AreEqual('0070', FFormatter.InputDigit('0'));
  Assert.AreEqual('00700', FFormatter.InputDigit('0'));
  Assert.AreEqual('0', FFormatter.ExtractedNationalPrefix);

  { Once the IDD "00700" has been extracted, it no longer makes sense for the initial "0" to be
    treated as an NDD. }
  Assert.AreEqual('00700 1 ', FFormatter.InputDigit('1'));
  Assert.AreEqual('', FFormatter.ExtractedNationalPrefix);

  Assert.AreEqual('00700 1 2', FFormatter.InputDigit('2'));
  Assert.AreEqual('00700 1 23', FFormatter.InputDigit('3'));
  Assert.AreEqual('00700 1 234', FFormatter.InputDigit('4'));
  Assert.AreEqual('00700 1 234 5', FFormatter.InputDigit('5'));
  Assert.AreEqual('00700 1 234 56', FFormatter.InputDigit('6'));
  Assert.AreEqual('00700 1 234 567', FFormatter.InputDigit('7'));
  Assert.AreEqual('00700 1 234 567 8', FFormatter.InputDigit('8'));
  Assert.AreEqual('00700 1 234 567 89', FFormatter.InputDigit('9'));
  Assert.AreEqual('00700 1 234 567 890', FFormatter.InputDigit('0'));
  Assert.AreEqual('00700 1 234 567 8901', FFormatter.InputDigit('1'));
  Assert.AreEqual('00700123456789012', FFormatter.InputDigit('2'));
  Assert.AreEqual('007001234567890123', FFormatter.InputDigit('3'));
  Assert.AreEqual('0070012345678901234', FFormatter.InputDigit('4'));
  Assert.AreEqual('00700123456789012345', FFormatter.InputDigit('5'));
  Assert.AreEqual('007001234567890123456', FFormatter.InputDigit('6'));
  Assert.AreEqual('0070012345678901234567', FFormatter.InputDigit('7'));
end;

procedure TUpstreamAsYouTypeFormatterTests.Test_AYTFNumberPatternsBecomingInvalidShouldNotResultInDigitLoss;
begin
  NewFormatter(RC_CN);

  Assert.AreEqual('+', FFormatter.InputDigit('+'));
  Assert.AreEqual('+8', FFormatter.InputDigit('8'));
  Assert.AreEqual('+86 ', FFormatter.InputDigit('6'));
  Assert.AreEqual('+86 9', FFormatter.InputDigit('9'));
  Assert.AreEqual('+86 98', FFormatter.InputDigit('8'));
  Assert.AreEqual('+86 988', FFormatter.InputDigit('8'));
  Assert.AreEqual('+86 988 1', FFormatter.InputDigit('1'));
  { Now the number pattern is no longer valid because there are multiple leading digit patterns;
    when we try again to extract a country code we should ensure we use the last leading digit
    pattern, rather than the first one such that it *thinks* it's found a valid formatting rule
    again.
    https://github.com/google/libphonenumber/issues/437 }
  Assert.AreEqual('+8698812', FFormatter.InputDigit('2'));
  Assert.AreEqual('+86988123', FFormatter.InputDigit('3'));
  Assert.AreEqual('+869881234', FFormatter.InputDigit('4'));
  Assert.AreEqual('+8698812345', FFormatter.InputDigit('5'));
end;

initialization
  RegisterTest(TUpstreamAsYouTypeFormatterTests);

end.
