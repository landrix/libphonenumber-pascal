unit LibPhoneNumber.UpstreamSuite.ShortNumber.Tests;

{
  Port of upstream ShortNumberInfoTest.java.

  Expected values: see the header of LibPhoneNumber.UpstreamSuite.Tests.
  They come straight out of the Java test class, which is correct here and only
  here, because this fixture runs against the same metadata the Java suite runs
  against.

  WHICH metadata is that? Two data sets at once, and the split matters:

  1. The PHONE metadata is the upstream TEST data set. ShortNumberInfoTest
     extends TestMetadataTestCase, so the PhoneNumberUtil singleton behind
     ShortNumberInfo reads PhoneNumberMetadataForTesting.xml. ShortNumberInfo
     consults it for exactly one thing - getRegionCodesForCountryCode, i.e.
     which regions share a calling code - and that is what makes the
     "cc 61 means AU and CC and CX" cases below behave as they do.
  2. The SHORT NUMBER metadata is the PRODUCTION one. There is no
     ShortNumberMetadataForTesting.xml in the upstream resources at the pinned
     baseline, and ShortNumberInfo.getInstance() builds its source from
     DefaultMetadataDependenciesProvider, i.e. from the shipped
     ShortNumberMetadata.xml. Every description - shortCode, emergency,
     carrierSpecific, cost - therefore comes from production data.

  This fixture reproduces that split exactly: Setup switches ONLY the phone
  metadata (LibPhoneNumber.Metadata) onto the testing tables and leaves
  LibPhoneNumber.ShortMetadata alone, which is the production short
  number data set and the only one that exists.

  Note that the stale comments in the Java source ("Angola doesn't have any
  metadata for emergency numbers in the test metadata") talk about a short
  number test data set that no longer exists; the assertions themselves are
  satisfied by the production short number metadata.

  Coverage
  --------
  All 28 test methods of ShortNumberInfoTest are ported; nothing is left out.
}

interface

uses
  DUnitX.TestFramework,
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.TestingMetadata,
  LibPhoneNumber.ShortNumberInfo,
  LibPhoneNumber.PhoneNumberUtil;

type
  [TestFixture]
  TUpstreamShortNumberInfoTests = class
  private
    { Upstream ShortNumberInfoTest.parse: the test data must always parse. }
    function ParseOk(const ANumber, ARegion: string): TPhoneNumber;
    procedure CheckCost(ACountryCode: Integer; const ANsn, ARegion: string;
      AExpected: TShortNumberCost);
    procedure CheckCostNoRegion(ACountryCode: Integer; const ANsn: string;
      AExpected: TShortNumberCost);
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Test_IsPossibleShortNumber;
    [Test]
    procedure Test_IsValidShortNumber;
    [Test]
    procedure Test_IsCarrierSpecific;
    [Test]
    procedure Test_IsSmsService;
    [Test]
    procedure Test_GetExpectedCost;
    [Test]
    procedure Test_GetExpectedCostForSharedCountryCallingCode;
    [Test]
    procedure Test_ExampleShortNumberPresence;
    [Test]
    procedure Test_ConnectsToEmergencyNumber_US;
    [Test]
    procedure Test_ConnectsToEmergencyNumberLongNumber_US;
    [Test]
    procedure Test_ConnectsToEmergencyNumberWithFormatting_US;
    [Test]
    procedure Test_ConnectsToEmergencyNumberWithPlusSign_US;
    [Test]
    procedure Test_ConnectsToEmergencyNumber_BR;
    [Test]
    procedure Test_ConnectsToEmergencyNumberLongNumber_BR;
    [Test]
    procedure Test_ConnectsToEmergencyNumber_CL;
    [Test]
    procedure Test_ConnectsToEmergencyNumberLongNumber_CL;
    [Test]
    procedure Test_ConnectsToEmergencyNumber_AO;
    [Test]
    procedure Test_ConnectsToEmergencyNumber_ZW;
    [Test]
    procedure Test_IsEmergencyNumber_US;
    [Test]
    procedure Test_IsEmergencyNumberLongNumber_US;
    [Test]
    procedure Test_IsEmergencyNumberWithFormatting_US;
    [Test]
    procedure Test_IsEmergencyNumberWithPlusSign_US;
    [Test]
    procedure Test_IsEmergencyNumber_BR;
    [Test]
    procedure Test_IsEmergencyNumberLongNumber_BR;
    [Test]
    procedure Test_IsEmergencyNumber_AO;
    [Test]
    procedure Test_IsEmergencyNumber_ZW;
    [Test]
    procedure Test_EmergencyNumberForSharedCountryCallingCode;
    [Test]
    procedure Test_OverlappingNANPANumber;
    [Test]
    procedure Test_CountryCallingCodeIsNotIgnored;
  end;

implementation

uses
  System.SysUtils;

const
  RC_AD = 'AD';
  RC_AO = 'AO';
  RC_AU = 'AU';
  RC_BB = 'BB';
  RC_BR = 'BR';
  RC_CA = 'CA';
  RC_CX = 'CX';
  RC_FR = 'FR';
  RC_SE = 'SE';
  RC_UN001 = '001';
  RC_US = 'US';
  RC_ZZ = 'ZZ';

procedure TUpstreamShortNumberInfoTests.Setup;
begin
  UseTestingMetadata;
end;

procedure TUpstreamShortNumberInfoTests.TearDown;
begin
  RestoreProductionMetadata;
end;

function TUpstreamShortNumberInfoTests.ParseOk(const ANumber,
  ARegion: string): TPhoneNumber;
var
  Error: TPhoneNumberParseError;
begin
  if not TPhoneNumberUtil.Parse(ANumber, ARegion, Result, Error) then
    Assert.Fail(Format('Test input data should always parse correctly: %s (%s)',
      [ANumber, ARegion]));
end;

procedure TUpstreamShortNumberInfoTests.CheckCost(ACountryCode: Integer;
  const ANsn, ARegion: string; AExpected: TShortNumberCost);
begin
  Assert.AreEqual(ShortNumberCostToString(AExpected),
    ShortNumberCostToString(GetExpectedCostForRegion(ACountryCode, ANsn,
      ARegion)),
    Format('getExpectedCostForRegion(+%d %s, %s)', [ACountryCode, ANsn, ARegion]));
end;

procedure TUpstreamShortNumberInfoTests.CheckCostNoRegion(ACountryCode: Integer;
  const ANsn: string; AExpected: TShortNumberCost);
begin
  Assert.AreEqual(ShortNumberCostToString(AExpected),
    ShortNumberCostToString(GetExpectedCost(ACountryCode, ANsn)),
    Format('getExpectedCost(+%d %s)', [ACountryCode, ANsn]));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsPossibleShortNumber;
var
  Parsed: TPhoneNumber;
begin
  Assert.IsTrue(IsPossibleShortNumber(33, '123456'));
  Parsed := ParseOk('123456', RC_FR);
  Assert.IsTrue(IsPossibleShortNumberForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_FR));

  Assert.IsFalse(IsPossibleShortNumber(33, '9'));

  { GB and GG share the country calling code 44; this number is possible but
    not valid. }
  Assert.IsTrue(IsPossibleShortNumber(44, '11001'));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsValidShortNumber;
var
  Parsed: TPhoneNumber;
begin
  Assert.IsTrue(IsValidShortNumber(33, '1010'));
  Parsed := ParseOk('1010', RC_FR);
  Assert.IsTrue(IsValidShortNumberForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_FR));

  Assert.IsFalse(IsValidShortNumber(33, '123456'));
  Parsed := ParseOk('123456', RC_FR);
  Assert.IsFalse(IsValidShortNumberForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_FR));

  { GB and GG share the country calling code 44. }
  Assert.IsTrue(IsValidShortNumber(44, '18001'));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsCarrierSpecific;
var
  Parsed: TPhoneNumber;
begin
  Assert.IsTrue(IsCarrierSpecific(1, '33669'));
  Parsed := ParseOk('33669', RC_US);
  Assert.IsTrue(IsCarrierSpecificForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_US));

  Assert.IsFalse(IsCarrierSpecific(1, '911'));
  Parsed := ParseOk('911', RC_US);
  Assert.IsFalse(IsCarrierSpecificForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_US));

  Assert.IsTrue(IsCarrierSpecific(1, '211'));
  Assert.IsTrue(IsCarrierSpecificForRegion(1, '211', RC_US));
  Assert.IsFalse(IsCarrierSpecificForRegion(1, '211', RC_BB));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsSmsService;
begin
  Assert.IsTrue(IsSmsServiceForRegion(1, '21234', RC_US));
  Assert.IsFalse(IsSmsServiceForRegion(1, '21234', RC_BB));
end;

procedure TUpstreamShortNumberInfoTests.Test_GetExpectedCost;
var
  PremiumRateExample, StandardRateExample, TollFreeExample: string;
  Parsed: TPhoneNumber;
begin
  PremiumRateExample := GetExampleShortNumberForCost(RC_FR, sncPremiumRate);
  Parsed := ParseOk(PremiumRateExample, RC_FR);
  CheckCost(Parsed.CountryCode, Parsed.NationalNumberDigits, RC_FR,
    sncPremiumRate);
  CheckCostNoRegion(33, PremiumRateExample, sncPremiumRate);

  StandardRateExample := GetExampleShortNumberForCost(RC_FR, sncStandardRate);
  Parsed := ParseOk(StandardRateExample, RC_FR);
  CheckCost(Parsed.CountryCode, Parsed.NationalNumberDigits, RC_FR,
    sncStandardRate);
  CheckCostNoRegion(33, StandardRateExample, sncStandardRate);

  TollFreeExample := GetExampleShortNumberForCost(RC_FR, sncTollFree);
  Parsed := ParseOk(TollFreeExample, RC_FR);
  CheckCost(Parsed.CountryCode, Parsed.NationalNumberDigits, RC_FR, sncTollFree);
  CheckCostNoRegion(33, TollFreeExample, sncTollFree);

  Parsed := ParseOk('12345', RC_FR);
  CheckCost(Parsed.CountryCode, Parsed.NationalNumberDigits, RC_FR,
    sncUnknownCost);
  CheckCostNoRegion(33, '12345', sncUnknownCost);

  { An invalid number may nevertheless have a cost other than UNKNOWN_COST. }
  Parsed := ParseOk('116123', RC_FR);
  Assert.IsFalse(IsValidShortNumberForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_FR));
  CheckCost(Parsed.CountryCode, Parsed.NationalNumberDigits, RC_FR, sncTollFree);
  Assert.IsFalse(IsValidShortNumber(33, '116123'));
  CheckCostNoRegion(33, '116123', sncTollFree);

  { A nonexistent country code. }
  Parsed := ParseOk('911', RC_US);
  CheckCost(Parsed.CountryCode, Parsed.NationalNumberDigits, RC_ZZ,
    sncUnknownCost);
  CheckCostNoRegion(123, '911', sncUnknownCost);
end;

procedure TUpstreamShortNumberInfoTests.Test_GetExpectedCostForSharedCountryCallingCode;
begin
  { In Australia, 1234 is premium-rate, 1194 is standard-rate and 733 is
    toll-free. These are not known to be valid numbers in the Christmas
    Islands. }
  Assert.IsTrue(IsValidShortNumber(61, '1234'));
  Assert.IsTrue(IsValidShortNumber(61, '1194'));
  Assert.IsTrue(IsValidShortNumber(61, '733'));

  Assert.IsTrue(IsValidShortNumberForRegion(61, '1234', RC_AU));
  CheckCost(61, '1234', RC_AU, sncPremiumRate);
  Assert.IsFalse(IsValidShortNumberForRegion(61, '1234', RC_CX));
  CheckCost(61, '1234', RC_CX, sncUnknownCost);
  { PREMIUM_RATE takes precedence over UNKNOWN_COST. }
  CheckCostNoRegion(61, '1234', sncPremiumRate);

  Assert.IsTrue(IsValidShortNumberForRegion(61, '1194', RC_AU));
  CheckCost(61, '1194', RC_AU, sncStandardRate);
  Assert.IsFalse(IsValidShortNumberForRegion(61, '1194', RC_CX));
  CheckCost(61, '1194', RC_CX, sncUnknownCost);
  CheckCostNoRegion(61, '1194', sncUnknownCost);

  Assert.IsTrue(IsValidShortNumberForRegion(61, '733', RC_AU));
  CheckCost(61, '733', RC_AU, sncTollFree);
  Assert.IsFalse(IsValidShortNumberForRegion(61, '733', RC_CX));
  CheckCost(61, '733', RC_CX, sncUnknownCost);
  CheckCostNoRegion(61, '733', sncUnknownCost);
end;

procedure TUpstreamShortNumberInfoTests.Test_ExampleShortNumberPresence;
begin
  Assert.AreNotEqual('', GetExampleShortNumber(RC_AD));
  Assert.AreNotEqual('', GetExampleShortNumber(RC_FR));
  Assert.AreEqual('', GetExampleShortNumber(RC_UN001));
  { Java passes null here; the empty string is this port's equivalent. }
  Assert.AreEqual('', GetExampleShortNumber(''));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumber_US;
begin
  Assert.IsTrue(ConnectsToEmergencyNumber('911', RC_US));
  Assert.IsTrue(ConnectsToEmergencyNumber('112', RC_US));
  Assert.IsFalse(ConnectsToEmergencyNumber('999', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumberLongNumber_US;
begin
  Assert.IsTrue(ConnectsToEmergencyNumber('9116666666', RC_US));
  Assert.IsTrue(ConnectsToEmergencyNumber('1126666666', RC_US));
  Assert.IsFalse(ConnectsToEmergencyNumber('9996666666', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumberWithFormatting_US;
begin
  Assert.IsTrue(ConnectsToEmergencyNumber('9-1-1', RC_US));
  Assert.IsTrue(ConnectsToEmergencyNumber('1-1-2', RC_US));
  Assert.IsFalse(ConnectsToEmergencyNumber('9-9-9', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumberWithPlusSign_US;
begin
  Assert.IsFalse(ConnectsToEmergencyNumber('+911', RC_US));
  Assert.IsFalse(ConnectsToEmergencyNumber(#$FF0B + '911', RC_US));
  Assert.IsFalse(ConnectsToEmergencyNumber(' +911', RC_US));
  Assert.IsFalse(ConnectsToEmergencyNumber('+112', RC_US));
  Assert.IsFalse(ConnectsToEmergencyNumber('+999', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumber_BR;
begin
  Assert.IsTrue(ConnectsToEmergencyNumber('911', RC_BR));
  Assert.IsTrue(ConnectsToEmergencyNumber('190', RC_BR));
  Assert.IsFalse(ConnectsToEmergencyNumber('999', RC_BR));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumberLongNumber_BR;
begin
  { Brazilian emergency numbers don't work when additional digits are
    appended. }
  Assert.IsFalse(ConnectsToEmergencyNumber('9111', RC_BR));
  Assert.IsFalse(ConnectsToEmergencyNumber('1900', RC_BR));
  Assert.IsFalse(ConnectsToEmergencyNumber('9996', RC_BR));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumber_CL;
begin
  Assert.IsTrue(ConnectsToEmergencyNumber('131', 'CL'));
  Assert.IsTrue(ConnectsToEmergencyNumber('133', 'CL'));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumberLongNumber_CL;
begin
  { Chilean emergency numbers don't work when additional digits are appended. }
  Assert.IsFalse(ConnectsToEmergencyNumber('1313', 'CL'));
  Assert.IsFalse(ConnectsToEmergencyNumber('1330', 'CL'));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumber_AO;
begin
  Assert.IsFalse(ConnectsToEmergencyNumber('911', RC_AO));
  Assert.IsFalse(ConnectsToEmergencyNumber('222123456', RC_AO));
  Assert.IsFalse(ConnectsToEmergencyNumber('923123456', RC_AO));
end;

procedure TUpstreamShortNumberInfoTests.Test_ConnectsToEmergencyNumber_ZW;
begin
  Assert.IsFalse(ConnectsToEmergencyNumber('911', 'ZW'));
  Assert.IsFalse(ConnectsToEmergencyNumber('01312345', 'ZW'));
  Assert.IsFalse(ConnectsToEmergencyNumber('0711234567', 'ZW'));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumber_US;
begin
  Assert.IsTrue(IsEmergencyNumber('911', RC_US));
  Assert.IsTrue(IsEmergencyNumber('112', RC_US));
  Assert.IsFalse(IsEmergencyNumber('999', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumberLongNumber_US;
begin
  Assert.IsFalse(IsEmergencyNumber('9116666666', RC_US));
  Assert.IsFalse(IsEmergencyNumber('1126666666', RC_US));
  Assert.IsFalse(IsEmergencyNumber('9996666666', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumberWithFormatting_US;
begin
  Assert.IsTrue(IsEmergencyNumber('9-1-1', RC_US));
  Assert.IsTrue(IsEmergencyNumber('*911', RC_US));
  Assert.IsTrue(IsEmergencyNumber('1-1-2', RC_US));
  Assert.IsTrue(IsEmergencyNumber('*112', RC_US));
  Assert.IsFalse(IsEmergencyNumber('9-9-9', RC_US));
  Assert.IsFalse(IsEmergencyNumber('*999', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumberWithPlusSign_US;
begin
  Assert.IsFalse(IsEmergencyNumber('+911', RC_US));
  Assert.IsFalse(IsEmergencyNumber(#$FF0B + '911', RC_US));
  Assert.IsFalse(IsEmergencyNumber(' +911', RC_US));
  Assert.IsFalse(IsEmergencyNumber('+112', RC_US));
  Assert.IsFalse(IsEmergencyNumber('+999', RC_US));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumber_BR;
begin
  Assert.IsTrue(IsEmergencyNumber('911', RC_BR));
  Assert.IsTrue(IsEmergencyNumber('190', RC_BR));
  Assert.IsFalse(IsEmergencyNumber('999', RC_BR));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumberLongNumber_BR;
begin
  Assert.IsFalse(IsEmergencyNumber('9111', RC_BR));
  Assert.IsFalse(IsEmergencyNumber('1900', RC_BR));
  Assert.IsFalse(IsEmergencyNumber('9996', RC_BR));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumber_AO;
begin
  Assert.IsFalse(IsEmergencyNumber('911', RC_AO));
  Assert.IsFalse(IsEmergencyNumber('222123456', RC_AO));
  Assert.IsFalse(IsEmergencyNumber('923123456', RC_AO));
end;

procedure TUpstreamShortNumberInfoTests.Test_IsEmergencyNumber_ZW;
begin
  Assert.IsFalse(IsEmergencyNumber('911', 'ZW'));
  Assert.IsFalse(IsEmergencyNumber('01312345', 'ZW'));
  Assert.IsFalse(IsEmergencyNumber('0711234567', 'ZW'));
end;

procedure TUpstreamShortNumberInfoTests.Test_EmergencyNumberForSharedCountryCallingCode;
begin
  { 112 is valid in both Australia and the Christmas Islands. }
  Assert.IsTrue(IsEmergencyNumber('112', RC_AU));
  Assert.IsTrue(IsValidShortNumberForRegion(61, '112', RC_AU));
  CheckCost(61, '112', RC_AU, sncTollFree);
  Assert.IsTrue(IsEmergencyNumber('112', RC_CX));
  Assert.IsTrue(IsValidShortNumberForRegion(61, '112', RC_CX));
  CheckCost(61, '112', RC_CX, sncTollFree);
  Assert.IsTrue(IsValidShortNumber(61, '112'));
  CheckCostNoRegion(61, '112', sncTollFree);
end;

procedure TUpstreamShortNumberInfoTests.Test_OverlappingNANPANumber;
begin
  { 211 is an emergency number in Barbados, while it is a toll-free information
    line in Canada and the USA. }
  Assert.IsTrue(IsEmergencyNumber('211', RC_BB));
  CheckCost(1, '211', RC_BB, sncTollFree);
  Assert.IsFalse(IsEmergencyNumber('211', RC_US));
  CheckCost(1, '211', RC_US, sncUnknownCost);
  Assert.IsFalse(IsEmergencyNumber('211', RC_CA));
  CheckCost(1, '211', RC_CA, sncTollFree);
end;

procedure TUpstreamShortNumberInfoTests.Test_CountryCallingCodeIsNotIgnored;
var
  Parsed: TPhoneNumber;
begin
  { +46 is the country calling code for Sweden (SE), and 40404 is a valid short
    number in the US. }
  Parsed := ParseOk('+4640404', RC_SE);
  Assert.IsFalse(IsPossibleShortNumberForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_US));
  Assert.IsFalse(IsValidShortNumberForRegion(Parsed.CountryCode,
    Parsed.NationalNumberDigits, RC_US));
  CheckCost(Parsed.CountryCode, Parsed.NationalNumberDigits, RC_US,
    sncUnknownCost);
end;

initialization
  TDUnitX.RegisterTestFixture(TUpstreamShortNumberInfoTests);

end.
