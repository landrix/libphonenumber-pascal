unit LibPhoneNumber.TestingMetadata.Data;

{
  GENERATED FILE - DO NOT EDIT.

  Territory table, possible length pool and the region / country calling code indices.

  Source:    vendor/libphonenumber/resources/PhoneNumberMetadataForTesting.xml
  Commit:    8d8d75272c351b60b87163db5328e439c53a6b56
  Generator: tools/generate_metadata.ps1 (testing-metadata-v1)

  Regenerate with:
    pwsh -NoProfile -ExecutionPolicy Bypass -File tools/generate_metadata.ps1

  No generation timestamp is embedded on purpose: the output must stay
  byte identical for an unchanged input.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}

interface

uses
  LibPhoneNumber.Metadata.Types;

const
  MetadataGeneratorVersion = 'testing-metadata-v1';
  MetadataSourceFile = 'resources/PhoneNumberMetadataForTesting.xml';
  MetadataSourceCommit = '8d8d75272c351b60b87163db5328e439c53a6b56';

  PhoneMetadataTerritoryCount = 36;
  PhoneMetadataRegionCount = 33;
  PhoneMetadataNonGeoCount = 3;
  PhoneMetadataCountryCodeCount = 29;
  PhoneMetadataPossibleLengthCount = 66;

  PhoneMetadataPossibleLengths: array[0..65] of SmallInt = (
    6, -1, 9, 8, 5, 6, 6, 7, 8, 9, 10, 11, 6, 7, 8, 9, 10, 10, 11, 10, 9, 10, 7, 11,
    4, 5, 6, 7, 8, 9, 10, 11, 2, 3, 6, 7, 8, 6, 9, 10, 11, 6, 9, 4, 4, 5, 6, 7,
    8, 9, 10, 7, 8, 9, 10, 7, 8, 8, 9, 10, 8, 10, 11, 4, 6, 8
  );

  PhoneMetadataTerritories: array[0..35] of TPhoneMetadataRec = (
    { AD cc=376 }
    (Id: 'AD';
     CountryCode: 376;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 0;
     FormatOffset: 0; FormatCount: 0;
     IntlFormatOffset: 0; IntlFormatCount: 0),
    { AE cc=971 }
    (Id: 'AE';
     CountryCode: 971;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 12;
     FormatOffset: 0; FormatCount: 0;
     IntlFormatOffset: 0; IntlFormatCount: 0),
    { AM cc=374 }
    (Id: 'AM';
     CountryCode: 374;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 24;
     FormatOffset: 0; FormatCount: 0;
     IntlFormatOffset: 0; IntlFormatCount: 0),
    { AO cc=244 }
    (Id: 'AO';
     CountryCode: 244;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0~0';
     NationalPrefixForParsing: '0~0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 36;
     FormatOffset: 0; FormatCount: 1;
     IntlFormatOffset: 0; IntlFormatCount: 0),
    { AR cc=54 }
    (Id: 'AR';
     CountryCode: 54;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0(?:(11|343|3715)15)?';
     NationalPrefixTransformRule: '9$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 48;
     FormatOffset: 1; FormatCount: 5;
     IntlFormatOffset: 0; IntlFormatCount: 5),
    { AU cc=61 }
    (Id: 'AU';
     CountryCode: 61;
     LeadingDigits: '';
     InternationalPrefix: '001[12]';
     PreferredInternationalPrefix: '0011';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 60;
     FormatOffset: 6; FormatCount: 2;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { BB cc=1 }
    (Id: 'BB';
     CountryCode: 1;
     LeadingDigits: '';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 72;
     FormatOffset: 8; FormatCount: 0;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { BR cc=55 }
    (Id: 'BR';
     CountryCode: 55;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 84;
     FormatOffset: 8; FormatCount: 0;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { BS cc=1 }
    (Id: 'BS';
     CountryCode: 1;
     LeadingDigits: '';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '1';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 96;
     FormatOffset: 8; FormatCount: 0;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { BY cc=375 }
    (Id: 'BY';
     CountryCode: 375;
     LeadingDigits: '';
     InternationalPrefix: '810';
     PreferredInternationalPrefix: '';
     NationalPrefix: '8';
     NationalPrefixForParsing: '80?|99999';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 108;
     FormatOffset: 8; FormatCount: 3;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { CA cc=1 }
    (Id: 'CA';
     CountryCode: 1;
     LeadingDigits: '';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 120;
     FormatOffset: 11; FormatCount: 0;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { CC cc=61 }
    (Id: 'CC';
     CountryCode: 61;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 132;
     FormatOffset: 11; FormatCount: 0;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { CN cc=86 }
    (Id: 'CN';
     CountryCode: 86;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 144;
     FormatOffset: 11; FormatCount: 2;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { CO cc=57 }
    (Id: 'CO';
     CountryCode: 57;
     LeadingDigits: '';
     InternationalPrefix: '';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0(4(?:[14]4|56)|[579])?';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 156;
     FormatOffset: 13; FormatCount: 2;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { CX cc=61 }
    (Id: 'CX';
     CountryCode: 61;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 168;
     FormatOffset: 15; FormatCount: 0;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { DE cc=49 }
    (Id: 'DE';
     CountryCode: 49;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 180;
     FormatOffset: 15; FormatCount: 6;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { FR cc=33 }
    (Id: 'FR';
     CountryCode: 33;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 192;
     FormatOffset: 21; FormatCount: 1;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { GB cc=44 }
    (Id: 'GB';
     CountryCode: 44;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 204;
     FormatOffset: 22; FormatCount: 4;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { GG cc=44 }
    (Id: 'GG';
     CountryCode: 44;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 216;
     FormatOffset: 26; FormatCount: 0;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { IT cc=39 }
    (Id: 'IT';
     CountryCode: 39;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 228;
     FormatOffset: 26; FormatCount: 4;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { JP cc=81 }
    (Id: 'JP';
     CountryCode: 81;
     LeadingDigits: '';
     InternationalPrefix: '010';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 240;
     FormatOffset: 30; FormatCount: 7;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { KR cc=82 }
    (Id: 'KR';
     CountryCode: 82;
     LeadingDigits: '';
     InternationalPrefix: '00(?:[124-68]|[37]\d{2})';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0(8[1-46-8]|85\d{2})?';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 252;
     FormatOffset: 37; FormatCount: 12;
     IntlFormatOffset: 5; IntlFormatCount: 0),
    { MX cc=52 }
    (Id: 'MX';
     CountryCode: 52;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '01';
     NationalPrefixForParsing: '01|04[45](\d{10})';
     NationalPrefixTransformRule: '1$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 264;
     FormatOffset: 49; FormatCount: 6;
     IntlFormatOffset: 5; IntlFormatCount: 6),
    { NZ cc=64 }
    (Id: 'NZ';
     CountryCode: 64;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 276;
     FormatOffset: 55; FormatCount: 3;
     IntlFormatOffset: 11; IntlFormatCount: 0),
    { PL cc=48 }
    (Id: 'PL';
     CountryCode: 48;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 288;
     FormatOffset: 58; FormatCount: 1;
     IntlFormatOffset: 11; IntlFormatCount: 0),
    { RE cc=262 }
    (Id: 'RE';
     CountryCode: 262;
     LeadingDigits: '262|6(?:9[23]|47)|8';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 300;
     FormatOffset: 59; FormatCount: 1;
     IntlFormatOffset: 11; IntlFormatCount: 0),
    { RU cc=7 }
    (Id: 'RU';
     CountryCode: 7;
     LeadingDigits: '';
     InternationalPrefix: '810';
     PreferredInternationalPrefix: '';
     NationalPrefix: '8';
     NationalPrefixForParsing: '8';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 312;
     FormatOffset: 60; FormatCount: 0;
     IntlFormatOffset: 11; IntlFormatCount: 0),
    { SE cc=46 }
    (Id: 'SE';
     CountryCode: 46;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 324;
     FormatOffset: 60; FormatCount: 0;
     IntlFormatOffset: 11; IntlFormatCount: 0),
    { SG cc=65 }
    (Id: 'SG';
     CountryCode: 65;
     LeadingDigits: '';
     InternationalPrefix: '0[0-3][0-9]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '777777';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 336;
     FormatOffset: 60; FormatCount: 3;
     IntlFormatOffset: 11; IntlFormatCount: 0),
    { TA cc=290 }
    (Id: 'TA';
     CountryCode: 290;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 348;
     FormatOffset: 63; FormatCount: 0;
     IntlFormatOffset: 11; IntlFormatCount: 0),
    { US cc=1 }
    (Id: 'US';
     CountryCode: 1;
     LeadingDigits: '';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '1';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: ' extn. ';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 360;
     FormatOffset: 63; FormatCount: 2;
     IntlFormatOffset: 11; IntlFormatCount: 1),
    { UZ cc=998 }
    (Id: 'UZ';
     CountryCode: 998;
     LeadingDigits: '';
     InternationalPrefix: '810';
     PreferredInternationalPrefix: '8~10';
     NationalPrefix: '8';
     NationalPrefixForParsing: '8';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 372;
     FormatOffset: 65; FormatCount: 1;
     IntlFormatOffset: 12; IntlFormatCount: 0),
    { YT cc=262 }
    (Id: 'YT';
     CountryCode: 262;
     LeadingDigits: '269|639';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 384;
     FormatOffset: 66; FormatCount: 0;
     IntlFormatOffset: 12; IntlFormatCount: 0),
    { 001 cc=800 }
    (Id: '001';
     CountryCode: 800;
     LeadingDigits: '';
     InternationalPrefix: '';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 396;
     FormatOffset: 66; FormatCount: 1;
     IntlFormatOffset: 12; IntlFormatCount: 0),
    { 001 cc=882 }
    (Id: '001';
     CountryCode: 882;
     LeadingDigits: '';
     InternationalPrefix: '';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 408;
     FormatOffset: 67; FormatCount: 1;
     IntlFormatOffset: 12; IntlFormatCount: 0),
    { 001 cc=979 }
    (Id: '001';
     CountryCode: 979;
     LeadingDigits: '';
     InternationalPrefix: '';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 420;
     FormatOffset: 68; FormatCount: 1;
     IntlFormatOffset: 12; IntlFormatCount: 0)
  );

  { Territory indices of the geographical regions, sorted by ordinal region code. }
  PhoneMetadataRegionOrder: array[0..32] of SmallInt = (
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
    20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32
  );

  { Region codes of the geographical regions, sorted by ordinal region code. }
  PhoneMetadataRegionCodes: array[0..32] of string = (
    'AD', 'AE', 'AM', 'AO', 'AR', 'AU', 'BB', 'BR', 'BS', 'BY',
    'CA', 'CC', 'CN', 'CO', 'CX', 'DE', 'FR', 'GB', 'GG', 'IT',
    'JP', 'KR', 'MX', 'NZ', 'PL', 'RE', 'RU', 'SE', 'SG', 'TA',
    'US', 'UZ', 'YT'
  );

  { Territory indices of the non geographical entities, sorted by country calling code. }
  PhoneMetadataNonGeoOrder: array[0..2] of SmallInt = (
    33, 34, 35
  );

  { Country calling codes of the non geographical entities, ascending. }
  PhoneMetadataNonGeoCallingCodes: array[0..2] of Integer = (
    800, 882, 979
  );

  { Country calling code groups, ascending by calling code. }
  PhoneMetadataCountryCodeGroups: array[0..28] of TCountryCodeGroupRec = (
    (CountryCode: 1; RegionOffset: 0; RegionCount: 4),
    (CountryCode: 7; RegionOffset: 4; RegionCount: 1),
    (CountryCode: 33; RegionOffset: 5; RegionCount: 1),
    (CountryCode: 39; RegionOffset: 6; RegionCount: 1),
    (CountryCode: 44; RegionOffset: 7; RegionCount: 2),
    (CountryCode: 46; RegionOffset: 9; RegionCount: 1),
    (CountryCode: 48; RegionOffset: 10; RegionCount: 1),
    (CountryCode: 49; RegionOffset: 11; RegionCount: 1),
    (CountryCode: 52; RegionOffset: 12; RegionCount: 1),
    (CountryCode: 54; RegionOffset: 13; RegionCount: 1),
    (CountryCode: 55; RegionOffset: 14; RegionCount: 1),
    (CountryCode: 57; RegionOffset: 15; RegionCount: 1),
    (CountryCode: 61; RegionOffset: 16; RegionCount: 3),
    (CountryCode: 64; RegionOffset: 19; RegionCount: 1),
    (CountryCode: 65; RegionOffset: 20; RegionCount: 1),
    (CountryCode: 81; RegionOffset: 21; RegionCount: 1),
    (CountryCode: 82; RegionOffset: 22; RegionCount: 1),
    (CountryCode: 86; RegionOffset: 23; RegionCount: 1),
    (CountryCode: 244; RegionOffset: 24; RegionCount: 1),
    (CountryCode: 262; RegionOffset: 25; RegionCount: 2),
    (CountryCode: 290; RegionOffset: 27; RegionCount: 1),
    (CountryCode: 374; RegionOffset: 28; RegionCount: 1),
    (CountryCode: 375; RegionOffset: 29; RegionCount: 1),
    (CountryCode: 376; RegionOffset: 30; RegionCount: 1),
    (CountryCode: 800; RegionOffset: 31; RegionCount: 1),
    (CountryCode: 882; RegionOffset: 32; RegionCount: 1),
    (CountryCode: 971; RegionOffset: 33; RegionCount: 1),
    (CountryCode: 979; RegionOffset: 34; RegionCount: 1),
    (CountryCode: 998; RegionOffset: 35; RegionCount: 1)
  );

  { Territory indices per calling code group, main country for code first. }
  PhoneMetadataCountryCodeRegions: array[0..35] of SmallInt = (
    30, 6, 8, 10, 26, 16, 19, 17, 18, 27, 24, 15, 22, 4, 7, 13, 5, 11, 14, 23,
    28, 20, 21, 12, 3, 25, 32, 29, 2, 9, 0, 33, 34, 1, 35, 31
  );

implementation

end.
