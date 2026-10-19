unit LibPhoneNumber.Metadata.Data;

{
  GENERATED FILE - DO NOT EDIT.

  Territory table, possible length pool and the region / country calling code indices.

  Source:    vendor/libphonenumber/resources/PhoneNumberMetadata.xml
  Commit:    33be5664343676b27761213d8f5500d682568ea7
  Generator: tools/generate_metadata.ps1 (metadata-v1)

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
  MetadataGeneratorVersion = 'metadata-v1';
  MetadataSourceFile = 'resources/PhoneNumberMetadata.xml';
  MetadataSourceCommit = '33be5664343676b27761213d8f5500d682568ea7';

  PhoneMetadataTerritoryCount = 254;
  PhoneMetadataRegionCount = 245;
  PhoneMetadataNonGeoCount = 9;
  PhoneMetadataCountryCodeCount = 215;
  PhoneMetadataPossibleLengthCount = 490;

  PhoneMetadataPossibleLengths: array[0..489] of SmallInt = (
    5, 6, 5, -1, 6, 6, 8, 9, 6, 9, 8, 5, 6, 7, 8, 9, 10, 11, 12, 7, 9, 10, 6, 7,
    8, 9, 5, 6, 7, 10, 11, 6, 7, 8, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 3, 7, 8, 9,
    10, 11, 12, 13, 9, 10, 11, 12, 13, 8, 9, 10, 11, 12, 13, 5, 6, 7, 8, 9, 10, 11, 12, 13,
    5, 6, 7, 8, 9, 10, 12, 7, 10, 6, 8, 10, 12, 5, 6, 7, 8, 9, 6, 7, 8, 10, 12, 6,
    7, 8, 9, 10, 7, 8, 9, 8, 9, 6, 7, 8, 9, 12, 4, 5, 8, 12, 8, 10, 8, 9, 10, 11,
    9, 10, 8, 9, 10, 7, 8, 7, 8, 10, 6, 7, 8, 9, 10, 11, 7, 11, 11, 6, 7, 8, 9, 10,
    12, 7, 8, 9, 10, 7, 9, 9, 12, 12, 9, 10, 11, 9, 11, 7, 8, 9, 10, 11, 12, 7, 8, 9,
    10, 11, 10, 12, 10, 11, 12, 8, 10, 11, 4, 7, 6, 7, 8, 10, 9, 10, 11, 12, 4, 5, 6, 7,
    8, 9, 10, 11, 12, 13, 14, 15, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 2, 3, 4,
    10, 11, 12, 13, 14, 15, 7, 8, 9, 10, 11, 12, 13, 14, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
    14, 8, 9, 10, 11, 12, 13, 14, 12, 13, 6, 7, 7, 9, 10, 4, 5, 6, 8, 4, 5, 6, 7, 8,
    8, 11, 5, 6, 7, 8, 9, 11, 5, 6, 7, 8, 11, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
    8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 10, 11, 12, 13, 14, 15, 16, 17, 8, 11, 12, 11, 12, 13,
    4, 5, 6, 7, 10, 6, 7, 10, 4, 5, 8, 4, 5, 10, 6, 7, 8, 9, 10, 11, 12, 6, 8, 9,
    10, 5, 8, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 3, 4, 7, 5, 6, 8, 9, 10, 9, 11, 12,
    13, 14, 11, 12, 13, 14, 10, 14, 4, 5, 6, 7, 8, 9, 10, 11, 4, 5, 6, 7, 8, 9, 10, 4,
    5, 6, 10, 11, 12, 13, 14, 5, 6, 7, 8, 9, 10, 11, 5, 6, 9, 5, 6, 7, 8, 9, 10, 7,
    8, 10, 11, 6, 8, 9, 10, 11, 12, 13, 4, 5, 7, 11, 12, 13, 8, 9, 10, 11, 12, 5, 6, 7,
    8, 7, 8, 9, 11, 7, 9, 11, 5, 7, 6, 7, 9, 7, 8, 11, 8, 9, 10, 13, 10, 13, 3, 5,
    6, 7, 4, 5, 6, 7, 7, 10, 12, 13, 10, 12, 13, 6, 7, 8, 9, 10, 11, 12, 13, 5, 6, 7,
    10, 3, 4, 5, 6, 7, 8, 9, 10, 12
  );

  PhoneMetadataTerritories: array[0..253] of TPhoneMetadataRec = (
    { AC cc=247 }
    (Id: 'AC';
     CountryCode: 247;
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
     DescOffset: 12;
     FormatOffset: 0; FormatCount: 3;
     IntlFormatOffset: 0; IntlFormatCount: 0),
    { AE cc=971 }
    (Id: 'AE';
     CountryCode: 971;
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
     DescOffset: 24;
     FormatOffset: 3; FormatCount: 4;
     IntlFormatOffset: 0; IntlFormatCount: 0),
    { AF cc=93 }
    (Id: 'AF';
     CountryCode: 93;
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
     DescOffset: 36;
     FormatOffset: 7; FormatCount: 2;
     IntlFormatOffset: 0; IntlFormatCount: 1),
    { AG cc=1 }
    (Id: 'AG';
     CountryCode: 1;
     LeadingDigits: '268';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([457]\d{6})$|1';
     NationalPrefixTransformRule: '268$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 48;
     FormatOffset: 9; FormatCount: 0;
     IntlFormatOffset: 1; IntlFormatCount: 0),
    { AI cc=1 }
    (Id: 'AI';
     CountryCode: 1;
     LeadingDigits: '264';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2457]\d{6})$|1';
     NationalPrefixTransformRule: '264$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 60;
     FormatOffset: 9; FormatCount: 0;
     IntlFormatOffset: 1; IntlFormatCount: 0),
    { AL cc=355 }
    (Id: 'AL';
     CountryCode: 355;
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
     DescOffset: 72;
     FormatOffset: 9; FormatCount: 5;
     IntlFormatOffset: 1; IntlFormatCount: 0),
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
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 84;
     FormatOffset: 14; FormatCount: 4;
     IntlFormatOffset: 1; IntlFormatCount: 0),
    { AO cc=244 }
    (Id: 'AO';
     CountryCode: 244;
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
     DescOffset: 96;
     FormatOffset: 18; FormatCount: 1;
     IntlFormatOffset: 1; IntlFormatCount: 0),
    { AR cc=54 }
    (Id: 'AR';
     CountryCode: 54;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0?(?:(11|2(?:2(?:02?|[13]|2[13-79]|4[1-6]|5[2457]|6[124-8]|7[1-4]|8[13-6]|9[1267])|3(?:02?|1[467' +
       ']|2[03-6]|3[13-8]|[49][2-6]|5[2-8]|[67])|4(?:7[3-578]|9)|6(?:[0136]|2[24-6]|4[6-8]?|5[15-8])|80|' +
       '9(?:0[1-3]|[19]|2\d|3[1-6]|4[02568]?|5[2-4]|6[2-46]|72?|8[23]?))|3(?:3(?:2[79]|6|8[2578])|4(?:0[' +
       '0-24-9]|[12]|3[5-8]?|4[24-7]|5[4-68]?|6[02-9]|7[126]|8[2379]?|9[1-36-8])|5(?:1|2[1245]|3[237]?|4' +
       '[1-46-9]|6[2-4]|7[1-6]|8[2-5]?)|6[24]|7(?:[069]|1[1568]|2[15]|3[145]|4[13]|5[14-8]|7[2-57]|8[126' +
       '])|8(?:[01]|2[15-7]|3[2578]?|4[13-6]|5[4-8]?|6[1-357-9]|7[36-8]?|8[5-8]?|9[124])))15)?';
     NationalPrefixTransformRule: '9$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 108;
     FormatOffset: 19; FormatCount: 12;
     IntlFormatOffset: 1; IntlFormatCount: 8),
    { AS cc=1 }
    (Id: 'AS';
     CountryCode: 1;
     LeadingDigits: '684';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([267]\d{6})$|1';
     NationalPrefixTransformRule: '684$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 120;
     FormatOffset: 31; FormatCount: 0;
     IntlFormatOffset: 9; IntlFormatCount: 0),
    { AT cc=43 }
    (Id: 'AT';
     CountryCode: 43;
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
     DescOffset: 132;
     FormatOffset: 31; FormatCount: 9;
     IntlFormatOffset: 9; IntlFormatCount: 7),
    { AU cc=61 }
    (Id: 'AU';
     CountryCode: 61;
     LeadingDigits: '';
     InternationalPrefix: '001[14-689]|14(?:1[14]|34|4[17]|[56]6|7[47]|88)0011';
     PreferredInternationalPrefix: '0011';
     NationalPrefix: '0';
     NationalPrefixForParsing: '(183[12])|0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 144;
     FormatOffset: 40; FormatCount: 10;
     IntlFormatOffset: 16; IntlFormatCount: 5),
    { AW cc=297 }
    (Id: 'AW';
     CountryCode: 297;
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
     DescOffset: 156;
     FormatOffset: 50; FormatCount: 1;
     IntlFormatOffset: 21; IntlFormatCount: 0),
    { AX cc=358 }
    (Id: 'AX';
     CountryCode: 358;
     LeadingDigits: '18';
     InternationalPrefix: '00|99(?:[01469]|5(?:[14]1|3[23]|5[59]|77|88|9[09]))';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 168;
     FormatOffset: 51; FormatCount: 0;
     IntlFormatOffset: 21; IntlFormatCount: 0),
    { AZ cc=994 }
    (Id: 'AZ';
     CountryCode: 994;
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
     DescOffset: 180;
     FormatOffset: 51; FormatCount: 4;
     IntlFormatOffset: 21; IntlFormatCount: 3),
    { BA cc=387 }
    (Id: 'BA';
     CountryCode: 387;
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
     DescOffset: 192;
     FormatOffset: 55; FormatCount: 4;
     IntlFormatOffset: 24; IntlFormatCount: 3),
    { BB cc=1 }
    (Id: 'BB';
     CountryCode: 1;
     LeadingDigits: '246';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-9]\d{6})$|1';
     NationalPrefixTransformRule: '246$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 204;
     FormatOffset: 59; FormatCount: 0;
     IntlFormatOffset: 27; IntlFormatCount: 0),
    { BD cc=880 }
    (Id: 'BD';
     CountryCode: 880;
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
     DescOffset: 216;
     FormatOffset: 59; FormatCount: 4;
     IntlFormatOffset: 27; IntlFormatCount: 0),
    { BE cc=32 }
    (Id: 'BE';
     CountryCode: 32;
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
     DescOffset: 228;
     FormatOffset: 63; FormatCount: 4;
     IntlFormatOffset: 27; IntlFormatCount: 0),
    { BF cc=226 }
    (Id: 'BF';
     CountryCode: 226;
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
     DescOffset: 240;
     FormatOffset: 67; FormatCount: 1;
     IntlFormatOffset: 27; IntlFormatCount: 0),
    { BG cc=359 }
    (Id: 'BG';
     CountryCode: 359;
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
     DescOffset: 252;
     FormatOffset: 68; FormatCount: 9;
     IntlFormatOffset: 27; IntlFormatCount: 8),
    { BH cc=973 }
    (Id: 'BH';
     CountryCode: 973;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 264;
     FormatOffset: 77; FormatCount: 1;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BI cc=257 }
    (Id: 'BI';
     CountryCode: 257;
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
     DescOffset: 276;
     FormatOffset: 78; FormatCount: 1;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BJ cc=229 }
    (Id: 'BJ';
     CountryCode: 229;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 288;
     FormatOffset: 79; FormatCount: 2;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BL cc=590 }
    (Id: 'BL';
     CountryCode: 590;
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
     DescOffset: 300;
     FormatOffset: 81; FormatCount: 0;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BM cc=1 }
    (Id: 'BM';
     CountryCode: 1;
     LeadingDigits: '441';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-9]\d{6})$|1';
     NationalPrefixTransformRule: '441$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 312;
     FormatOffset: 81; FormatCount: 0;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BN cc=673 }
    (Id: 'BN';
     CountryCode: 673;
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
     DescOffset: 324;
     FormatOffset: 81; FormatCount: 1;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BO cc=591 }
    (Id: 'BO';
     CountryCode: 591;
     LeadingDigits: '';
     InternationalPrefix: '00(?:1\d)?';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0(1\d)?';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 336;
     FormatOffset: 82; FormatCount: 3;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BQ cc=599 }
    (Id: 'BQ';
     CountryCode: 599;
     LeadingDigits: '[347]';
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
     FormatOffset: 85; FormatCount: 0;
     IntlFormatOffset: 35; IntlFormatCount: 0),
    { BR cc=55 }
    (Id: 'BR';
     CountryCode: 55;
     LeadingDigits: '';
     InternationalPrefix: '00(?:1[245]|2[1-35]|31|4[13]|[56]5|99)';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '(?:0|90)(?:(1[245]|2[1-35]|31|4[13]|[56]5|99)(\d{10,11}))?';
     NationalPrefixTransformRule: '$2';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 360;
     FormatOffset: 85; FormatCount: 7;
     IntlFormatOffset: 35; IntlFormatCount: 4),
    { BS cc=1 }
    (Id: 'BS';
     CountryCode: 1;
     LeadingDigits: '242';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([3-8]\d{6})$|1';
     NationalPrefixTransformRule: '242$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 372;
     FormatOffset: 92; FormatCount: 0;
     IntlFormatOffset: 39; IntlFormatCount: 0),
    { BT cc=975 }
    (Id: 'BT';
     CountryCode: 975;
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
     DescOffset: 384;
     FormatOffset: 92; FormatCount: 3;
     IntlFormatOffset: 39; IntlFormatCount: 2),
    { BW cc=267 }
    (Id: 'BW';
     CountryCode: 267;
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
     DescOffset: 396;
     FormatOffset: 95; FormatCount: 5;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { BY cc=375 }
    (Id: 'BY';
     CountryCode: 375;
     LeadingDigits: '';
     InternationalPrefix: '810';
     PreferredInternationalPrefix: '8~10';
     NationalPrefix: '8';
     NationalPrefixForParsing: '0|80?';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 408;
     FormatOffset: 100; FormatCount: 6;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { BZ cc=501 }
    (Id: 'BZ';
     CountryCode: 501;
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
     DescOffset: 420;
     FormatOffset: 106; FormatCount: 2;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CA cc=1 }
    (Id: 'CA';
     CountryCode: 1;
     LeadingDigits: '';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '1';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 432;
     FormatOffset: 108; FormatCount: 0;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CC cc=61 }
    (Id: 'CC';
     CountryCode: 61;
     LeadingDigits: '';
     InternationalPrefix: '001[14-689]|14(?:1[14]|34|4[17]|[56]6|7[47]|88)0011';
     PreferredInternationalPrefix: '0011';
     NationalPrefix: '0';
     NationalPrefixForParsing: '([59]\d{7})$|0';
     NationalPrefixTransformRule: '8$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 444;
     FormatOffset: 108; FormatCount: 0;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CD cc=243 }
    (Id: 'CD';
     CountryCode: 243;
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
     DescOffset: 456;
     FormatOffset: 108; FormatCount: 6;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CF cc=236 }
    (Id: 'CF';
     CountryCode: 236;
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
     DescOffset: 468;
     FormatOffset: 114; FormatCount: 1;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CG cc=242 }
    (Id: 'CG';
     CountryCode: 242;
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
     DescOffset: 480;
     FormatOffset: 115; FormatCount: 2;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CH cc=41 }
    (Id: 'CH';
     CountryCode: 41;
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
     DescOffset: 492;
     FormatOffset: 117; FormatCount: 3;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CI cc=225 }
    (Id: 'CI';
     CountryCode: 225;
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
     DescOffset: 504;
     FormatOffset: 120; FormatCount: 2;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CK cc=682 }
    (Id: 'CK';
     CountryCode: 682;
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
     DescOffset: 516;
     FormatOffset: 122; FormatCount: 1;
     IntlFormatOffset: 41; IntlFormatCount: 0),
    { CL cc=56 }
    (Id: 'CL';
     CountryCode: 56;
     LeadingDigits: '';
     InternationalPrefix: '(?:0|1(?:1[0-69]|2[02-5]|5[13-58]|69|7[0167]|8[018]))0';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 528;
     FormatOffset: 123; FormatCount: 10;
     IntlFormatOffset: 41; IntlFormatCount: 9),
    { CM cc=237 }
    (Id: 'CM';
     CountryCode: 237;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 540;
     FormatOffset: 133; FormatCount: 2;
     IntlFormatOffset: 50; IntlFormatCount: 0),
    { CN cc=86 }
    (Id: 'CN';
     CountryCode: 86;
     LeadingDigits: '';
     InternationalPrefix: '00|1(?:[12]\d|79)\d\d00';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '0';
     NationalPrefixForParsing: '(1(?:[12]\d|79)\d\d)|0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 552;
     FormatOffset: 135; FormatCount: 17;
     IntlFormatOffset: 50; IntlFormatCount: 10),
    { CO cc=57 }
    (Id: 'CO';
     CountryCode: 57;
     LeadingDigits: '';
     InternationalPrefix: '00(?:4(?:[14]4|56)|[579])';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0([3579]|4(?:[14]4|56))?';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 564;
     FormatOffset: 152; FormatCount: 4;
     IntlFormatOffset: 60; IntlFormatCount: 4),
    { CR cc=506 }
    (Id: 'CR';
     CountryCode: 506;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '(19(?:0[0-2468]|1[09]|20|66|77|99))';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 576;
     FormatOffset: 156; FormatCount: 2;
     IntlFormatOffset: 64; IntlFormatCount: 0),
    { CU cc=53 }
    (Id: 'CU';
     CountryCode: 53;
     LeadingDigits: '';
     InternationalPrefix: '119';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 588;
     FormatOffset: 158; FormatCount: 4;
     IntlFormatOffset: 64; IntlFormatCount: 0),
    { CV cc=238 }
    (Id: 'CV';
     CountryCode: 238;
     LeadingDigits: '';
     InternationalPrefix: '0';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 600;
     FormatOffset: 162; FormatCount: 1;
     IntlFormatOffset: 64; IntlFormatCount: 0),
    { CW cc=599 }
    (Id: 'CW';
     CountryCode: 599;
     LeadingDigits: '[69]';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 612;
     FormatOffset: 163; FormatCount: 2;
     IntlFormatOffset: 64; IntlFormatCount: 0),
    { CX cc=61 }
    (Id: 'CX';
     CountryCode: 61;
     LeadingDigits: '';
     InternationalPrefix: '001[14-689]|14(?:1[14]|34|4[17]|[56]6|7[47]|88)0011';
     PreferredInternationalPrefix: '0011';
     NationalPrefix: '0';
     NationalPrefixForParsing: '([59]\d{7})$|0';
     NationalPrefixTransformRule: '8$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 624;
     FormatOffset: 165; FormatCount: 0;
     IntlFormatOffset: 64; IntlFormatCount: 0),
    { CY cc=357 }
    (Id: 'CY';
     CountryCode: 357;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 636;
     FormatOffset: 165; FormatCount: 1;
     IntlFormatOffset: 64; IntlFormatCount: 0),
    { CZ cc=420 }
    (Id: 'CZ';
     CountryCode: 420;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 648;
     FormatOffset: 166; FormatCount: 4;
     IntlFormatOffset: 64; IntlFormatCount: 0),
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
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 660;
     FormatOffset: 170; FormatCount: 19;
     IntlFormatOffset: 64; IntlFormatCount: 18),
    { DJ cc=253 }
    (Id: 'DJ';
     CountryCode: 253;
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
     DescOffset: 672;
     FormatOffset: 189; FormatCount: 1;
     IntlFormatOffset: 82; IntlFormatCount: 0),
    { DK cc=45 }
    (Id: 'DK';
     CountryCode: 45;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 684;
     FormatOffset: 190; FormatCount: 1;
     IntlFormatOffset: 82; IntlFormatCount: 0),
    { DM cc=1 }
    (Id: 'DM';
     CountryCode: 1;
     LeadingDigits: '767';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-7]\d{6})$|1';
     NationalPrefixTransformRule: '767$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 696;
     FormatOffset: 191; FormatCount: 0;
     IntlFormatOffset: 82; IntlFormatCount: 0),
    { DO cc=1 }
    (Id: 'DO';
     CountryCode: 1;
     LeadingDigits: '8001|8[024]9';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '1';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 708;
     FormatOffset: 191; FormatCount: 0;
     IntlFormatOffset: 82; IntlFormatCount: 0),
    { DZ cc=213 }
    (Id: 'DZ';
     CountryCode: 213;
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
     DescOffset: 720;
     FormatOffset: 191; FormatCount: 3;
     IntlFormatOffset: 82; IntlFormatCount: 0),
    { EC cc=593 }
    (Id: 'EC';
     CountryCode: 593;
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
     DescOffset: 732;
     FormatOffset: 194; FormatCount: 4;
     IntlFormatOffset: 82; IntlFormatCount: 3),
    { EE cc=372 }
    (Id: 'EE';
     CountryCode: 372;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 744;
     FormatOffset: 198; FormatCount: 4;
     IntlFormatOffset: 85; IntlFormatCount: 0),
    { EG cc=20 }
    (Id: 'EG';
     CountryCode: 20;
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
     DescOffset: 756;
     FormatOffset: 202; FormatCount: 4;
     IntlFormatOffset: 85; IntlFormatCount: 0),
    { EH cc=212 }
    (Id: 'EH';
     CountryCode: 212;
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
     DescOffset: 768;
     FormatOffset: 206; FormatCount: 0;
     IntlFormatOffset: 85; IntlFormatCount: 0),
    { ER cc=291 }
    (Id: 'ER';
     CountryCode: 291;
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
     DescOffset: 780;
     FormatOffset: 206; FormatCount: 1;
     IntlFormatOffset: 85; IntlFormatCount: 0),
    { ES cc=34 }
    (Id: 'ES';
     CountryCode: 34;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 792;
     FormatOffset: 207; FormatCount: 4;
     IntlFormatOffset: 85; IntlFormatCount: 2),
    { ET cc=251 }
    (Id: 'ET';
     CountryCode: 251;
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
     DescOffset: 804;
     FormatOffset: 211; FormatCount: 1;
     IntlFormatOffset: 87; IntlFormatCount: 0),
    { FI cc=358 }
    (Id: 'FI';
     CountryCode: 358;
     LeadingDigits: '1[03-79]|[2-9]';
     InternationalPrefix: '00|99(?:[01469]|5(?:[14]1|3[23]|5[59]|77|88|9[09]))';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 816;
     FormatOffset: 212; FormatCount: 7;
     IntlFormatOffset: 87; IntlFormatCount: 5),
    { FJ cc=679 }
    (Id: 'FJ';
     CountryCode: 679;
     LeadingDigits: '';
     InternationalPrefix: '0(?:0|52)';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 828;
     FormatOffset: 219; FormatCount: 2;
     IntlFormatOffset: 92; IntlFormatCount: 0),
    { FK cc=500 }
    (Id: 'FK';
     CountryCode: 500;
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
     DescOffset: 840;
     FormatOffset: 221; FormatCount: 0;
     IntlFormatOffset: 92; IntlFormatCount: 0),
    { FM cc=691 }
    (Id: 'FM';
     CountryCode: 691;
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
     DescOffset: 852;
     FormatOffset: 221; FormatCount: 1;
     IntlFormatOffset: 92; IntlFormatCount: 0),
    { FO cc=298 }
    (Id: 'FO';
     CountryCode: 298;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '(10(?:01|[12]0|88))';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 864;
     FormatOffset: 222; FormatCount: 1;
     IntlFormatOffset: 92; IntlFormatCount: 0),
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
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 876;
     FormatOffset: 223; FormatCount: 4;
     IntlFormatOffset: 92; IntlFormatCount: 2),
    { GA cc=241 }
    (Id: 'GA';
     CountryCode: 241;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '0(11\d{6}|60\d{6}|61\d{6}|6[256]\d{6}|7[467]\d{6})';
     NationalPrefixTransformRule: '$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 888;
     FormatOffset: 227; FormatCount: 3;
     IntlFormatOffset: 94; IntlFormatCount: 0),
    { GB cc=44 }
    (Id: 'GB';
     CountryCode: 44;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0|180020';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: ' x';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 900;
     FormatOffset: 230; FormatCount: 8;
     IntlFormatOffset: 94; IntlFormatCount: 0),
    { GD cc=1 }
    (Id: 'GD';
     CountryCode: 1;
     LeadingDigits: '473';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-9]\d{6})$|1';
     NationalPrefixTransformRule: '473$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 912;
     FormatOffset: 238; FormatCount: 0;
     IntlFormatOffset: 94; IntlFormatCount: 0),
    { GE cc=995 }
    (Id: 'GE';
     CountryCode: 995;
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
     DescOffset: 924;
     FormatOffset: 238; FormatCount: 4;
     IntlFormatOffset: 94; IntlFormatCount: 0),
    { GF cc=594 }
    (Id: 'GF';
     CountryCode: 594;
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
     DescOffset: 936;
     FormatOffset: 242; FormatCount: 2;
     IntlFormatOffset: 94; IntlFormatCount: 0),
    { GG cc=44 }
    (Id: 'GG';
     CountryCode: 44;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '([25-9]\d{5})$|0|180020';
     NationalPrefixTransformRule: '1481$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 948;
     FormatOffset: 244; FormatCount: 0;
     IntlFormatOffset: 94; IntlFormatCount: 0),
    { GH cc=233 }
    (Id: 'GH';
     CountryCode: 233;
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
     DescOffset: 960;
     FormatOffset: 244; FormatCount: 3;
     IntlFormatOffset: 94; IntlFormatCount: 2),
    { GI cc=350 }
    (Id: 'GI';
     CountryCode: 350;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 972;
     FormatOffset: 247; FormatCount: 1;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GL cc=299 }
    (Id: 'GL';
     CountryCode: 299;
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
     DescOffset: 984;
     FormatOffset: 248; FormatCount: 1;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GM cc=220 }
    (Id: 'GM';
     CountryCode: 220;
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
     DescOffset: 996;
     FormatOffset: 249; FormatCount: 2;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GN cc=224 }
    (Id: 'GN';
     CountryCode: 224;
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
     DescOffset: 1008;
     FormatOffset: 251; FormatCount: 2;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GP cc=590 }
    (Id: 'GP';
     CountryCode: 590;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1020;
     FormatOffset: 253; FormatCount: 2;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GQ cc=240 }
    (Id: 'GQ';
     CountryCode: 240;
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
     DescOffset: 1032;
     FormatOffset: 255; FormatCount: 2;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GR cc=30 }
    (Id: 'GR';
     CountryCode: 30;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1044;
     FormatOffset: 257; FormatCount: 4;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GT cc=502 }
    (Id: 'GT';
     CountryCode: 502;
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
     DescOffset: 1056;
     FormatOffset: 261; FormatCount: 2;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GU cc=1 }
    (Id: 'GU';
     CountryCode: 1;
     LeadingDigits: '671';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-9]\d{6})$|1';
     NationalPrefixTransformRule: '671$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 1068;
     FormatOffset: 263; FormatCount: 0;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GW cc=245 }
    (Id: 'GW';
     CountryCode: 245;
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
     DescOffset: 1080;
     FormatOffset: 263; FormatCount: 2;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { GY cc=592 }
    (Id: 'GY';
     CountryCode: 592;
     LeadingDigits: '';
     InternationalPrefix: '001';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1092;
     FormatOffset: 265; FormatCount: 1;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { HK cc=852 }
    (Id: 'HK';
     CountryCode: 852;
     LeadingDigits: '';
     InternationalPrefix: '00(?:30|5[09]|[126-9]?)';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1104;
     FormatOffset: 266; FormatCount: 4;
     IntlFormatOffset: 96; IntlFormatCount: 0),
    { HN cc=504 }
    (Id: 'HN';
     CountryCode: 504;
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
     DescOffset: 1116;
     FormatOffset: 270; FormatCount: 2;
     IntlFormatOffset: 96; IntlFormatCount: 1),
    { HR cc=385 }
    (Id: 'HR';
     CountryCode: 385;
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
     DescOffset: 1128;
     FormatOffset: 272; FormatCount: 7;
     IntlFormatOffset: 97; IntlFormatCount: 0),
    { HT cc=509 }
    (Id: 'HT';
     CountryCode: 509;
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
     DescOffset: 1140;
     FormatOffset: 279; FormatCount: 1;
     IntlFormatOffset: 97; IntlFormatCount: 0),
    { HU cc=36 }
    (Id: 'HU';
     CountryCode: 36;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '06';
     NationalPrefixForParsing: '06';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1152;
     FormatOffset: 280; FormatCount: 3;
     IntlFormatOffset: 97; IntlFormatCount: 0),
    { ID cc=62 }
    (Id: 'ID';
     CountryCode: 62;
     LeadingDigits: '';
     InternationalPrefix: '00[89]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1164;
     FormatOffset: 283; FormatCount: 11;
     IntlFormatOffset: 97; IntlFormatCount: 9),
    { IE cc=353 }
    (Id: 'IE';
     CountryCode: 353;
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
     DescOffset: 1176;
     FormatOffset: 294; FormatCount: 10;
     IntlFormatOffset: 106; IntlFormatCount: 0),
    { IL cc=972 }
    (Id: 'IL';
     CountryCode: 972;
     LeadingDigits: '';
     InternationalPrefix: '0(?:0|1(?:05|[2-9]))';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1188;
     FormatOffset: 304; FormatCount: 8;
     IntlFormatOffset: 106; IntlFormatCount: 0),
    { IM cc=44 }
    (Id: 'IM';
     CountryCode: 44;
     LeadingDigits: '74576|(?:16|7[56])24';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '([25-8]\d{5})$|0|180020';
     NationalPrefixTransformRule: '1624$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1200;
     FormatOffset: 312; FormatCount: 0;
     IntlFormatOffset: 106; IntlFormatCount: 0),
    { IN cc=91 }
    (Id: 'IN';
     CountryCode: 91;
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
     DescOffset: 1212;
     FormatOffset: 312; FormatCount: 11;
     IntlFormatOffset: 106; IntlFormatCount: 9),
    { IO cc=246 }
    (Id: 'IO';
     CountryCode: 246;
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
     DescOffset: 1224;
     FormatOffset: 323; FormatCount: 1;
     IntlFormatOffset: 115; IntlFormatCount: 0),
    { IQ cc=964 }
    (Id: 'IQ';
     CountryCode: 964;
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
     DescOffset: 1236;
     FormatOffset: 324; FormatCount: 3;
     IntlFormatOffset: 115; IntlFormatCount: 0),
    { IR cc=98 }
    (Id: 'IR';
     CountryCode: 98;
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
     DescOffset: 1248;
     FormatOffset: 327; FormatCount: 4;
     IntlFormatOffset: 115; IntlFormatCount: 0),
    { IS cc=354 }
    (Id: 'IS';
     CountryCode: 354;
     LeadingDigits: '';
     InternationalPrefix: '00|1(?:0(?:01|[12]0)|100)';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1260;
     FormatOffset: 331; FormatCount: 2;
     IntlFormatOffset: 115; IntlFormatCount: 0),
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
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1272;
     FormatOffset: 333; FormatCount: 12;
     IntlFormatOffset: 115; IntlFormatCount: 10),
    { JE cc=44 }
    (Id: 'JE';
     CountryCode: 44;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '([0-24-8]\d{5})$|0|180020';
     NationalPrefixTransformRule: '1534$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1284;
     FormatOffset: 345; FormatCount: 0;
     IntlFormatOffset: 125; IntlFormatCount: 0),
    { JM cc=1 }
    (Id: 'JM';
     CountryCode: 1;
     LeadingDigits: '658|876';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '1';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1296;
     FormatOffset: 345; FormatCount: 0;
     IntlFormatOffset: 125; IntlFormatCount: 0),
    { JO cc=962 }
    (Id: 'JO';
     CountryCode: 962;
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
     DescOffset: 1308;
     FormatOffset: 345; FormatCount: 4;
     IntlFormatOffset: 125; IntlFormatCount: 0),
    { JP cc=81 }
    (Id: 'JP';
     CountryCode: 81;
     LeadingDigits: '';
     InternationalPrefix: '010';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '(000[2569]\d{4,6})$|(?:(?:003768)0?)|0';
     NationalPrefixTransformRule: '$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1320;
     FormatOffset: 349; FormatCount: 16;
     IntlFormatOffset: 125; IntlFormatCount: 8),
    { KE cc=254 }
    (Id: 'KE';
     CountryCode: 254;
     LeadingDigits: '';
     InternationalPrefix: '000';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1332;
     FormatOffset: 365; FormatCount: 3;
     IntlFormatOffset: 133; IntlFormatCount: 0),
    { KG cc=996 }
    (Id: 'KG';
     CountryCode: 996;
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
     DescOffset: 1344;
     FormatOffset: 368; FormatCount: 3;
     IntlFormatOffset: 133; IntlFormatCount: 0),
    { KH cc=855 }
    (Id: 'KH';
     CountryCode: 855;
     LeadingDigits: '';
     InternationalPrefix: '00[14-9]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1356;
     FormatOffset: 371; FormatCount: 2;
     IntlFormatOffset: 133; IntlFormatCount: 0),
    { KI cc=686 }
    (Id: 'KI';
     CountryCode: 686;
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
     DescOffset: 1368;
     FormatOffset: 373; FormatCount: 0;
     IntlFormatOffset: 133; IntlFormatCount: 0),
    { KM cc=269 }
    (Id: 'KM';
     CountryCode: 269;
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
     DescOffset: 1380;
     FormatOffset: 373; FormatCount: 1;
     IntlFormatOffset: 133; IntlFormatCount: 0),
    { KN cc=1 }
    (Id: 'KN';
     CountryCode: 1;
     LeadingDigits: '869';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-7]\d{6})$|1';
     NationalPrefixTransformRule: '869$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1392;
     FormatOffset: 374; FormatCount: 0;
     IntlFormatOffset: 133; IntlFormatCount: 0),
    { KP cc=850 }
    (Id: 'KP';
     CountryCode: 850;
     LeadingDigits: '';
     InternationalPrefix: '00|99';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1404;
     FormatOffset: 374; FormatCount: 3;
     IntlFormatOffset: 133; IntlFormatCount: 0),
    { KR cc=82 }
    (Id: 'KR';
     CountryCode: 82;
     LeadingDigits: '';
     InternationalPrefix: '00(?:[125689]|3(?:[46]5|91)|7(?:00|27|3|55|6[126]))';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0(8(?:[1-46-8]|5\d\d))?';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1416;
     FormatOffset: 377; FormatCount: 11;
     IntlFormatOffset: 133; IntlFormatCount: 7),
    { KW cc=965 }
    (Id: 'KW';
     CountryCode: 965;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1428;
     FormatOffset: 388; FormatCount: 2;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { KY cc=1 }
    (Id: 'KY';
     CountryCode: 1;
     LeadingDigits: '345';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-9]\d{6})$|1';
     NationalPrefixTransformRule: '345$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1440;
     FormatOffset: 390; FormatCount: 0;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { KZ cc=7 }
    (Id: 'KZ';
     CountryCode: 7;
     LeadingDigits: '7';
     InternationalPrefix: '810';
     PreferredInternationalPrefix: '8~10';
     NationalPrefix: '8';
     NationalPrefixForParsing: '8';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1452;
     FormatOffset: 390; FormatCount: 0;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LA cc=856 }
    (Id: 'LA';
     CountryCode: 856;
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
     DescOffset: 1464;
     FormatOffset: 390; FormatCount: 3;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LB cc=961 }
    (Id: 'LB';
     CountryCode: 961;
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
     DescOffset: 1476;
     FormatOffset: 393; FormatCount: 2;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LC cc=1 }
    (Id: 'LC';
     CountryCode: 1;
     LeadingDigits: '758';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-8]\d{6})$|1';
     NationalPrefixTransformRule: '758$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1488;
     FormatOffset: 395; FormatCount: 0;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LI cc=423 }
    (Id: 'LI';
     CountryCode: 423;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '(1001)|0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1500;
     FormatOffset: 395; FormatCount: 4;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LK cc=94 }
    (Id: 'LK';
     CountryCode: 94;
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
     DescOffset: 1512;
     FormatOffset: 399; FormatCount: 2;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LR cc=231 }
    (Id: 'LR';
     CountryCode: 231;
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
     DescOffset: 1524;
     FormatOffset: 401; FormatCount: 3;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LS cc=266 }
    (Id: 'LS';
     CountryCode: 266;
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
     DescOffset: 1536;
     FormatOffset: 404; FormatCount: 1;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LT cc=370 }
    (Id: 'LT';
     CountryCode: 370;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '[08]';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1548;
     FormatOffset: 405; FormatCount: 4;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LU cc=352 }
    (Id: 'LU';
     CountryCode: 352;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '(15(?:0[06]|1[12]|[35]5|4[04]|6[26]|77|88|99)\d)';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1560;
     FormatOffset: 409; FormatCount: 9;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LV cc=371 }
    (Id: 'LV';
     CountryCode: 371;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1572;
     FormatOffset: 418; FormatCount: 1;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { LY cc=218 }
    (Id: 'LY';
     CountryCode: 218;
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
     DescOffset: 1584;
     FormatOffset: 419; FormatCount: 1;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { MA cc=212 }
    (Id: 'MA';
     CountryCode: 212;
     LeadingDigits: '[5-8]';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1596;
     FormatOffset: 420; FormatCount: 3;
     IntlFormatOffset: 140; IntlFormatCount: 0),
    { MC cc=377 }
    (Id: 'MC';
     CountryCode: 377;
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
     DescOffset: 1608;
     FormatOffset: 423; FormatCount: 4;
     IntlFormatOffset: 140; IntlFormatCount: 3),
    { MD cc=373 }
    (Id: 'MD';
     CountryCode: 373;
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
     DescOffset: 1620;
     FormatOffset: 427; FormatCount: 3;
     IntlFormatOffset: 143; IntlFormatCount: 0),
    { ME cc=382 }
    (Id: 'ME';
     CountryCode: 382;
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
     DescOffset: 1632;
     FormatOffset: 430; FormatCount: 1;
     IntlFormatOffset: 143; IntlFormatCount: 0),
    { MF cc=590 }
    (Id: 'MF';
     CountryCode: 590;
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
     DescOffset: 1644;
     FormatOffset: 431; FormatCount: 0;
     IntlFormatOffset: 143; IntlFormatCount: 0),
    { MG cc=261 }
    (Id: 'MG';
     CountryCode: 261;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '([24-9]\d{6})$|0';
     NationalPrefixTransformRule: '20$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1656;
     FormatOffset: 431; FormatCount: 1;
     IntlFormatOffset: 143; IntlFormatCount: 0),
    { MH cc=692 }
    (Id: 'MH';
     CountryCode: 692;
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
     DescOffset: 1668;
     FormatOffset: 432; FormatCount: 1;
     IntlFormatOffset: 143; IntlFormatCount: 0),
    { MK cc=389 }
    (Id: 'MK';
     CountryCode: 389;
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
     DescOffset: 1680;
     FormatOffset: 433; FormatCount: 3;
     IntlFormatOffset: 143; IntlFormatCount: 0),
    { ML cc=223 }
    (Id: 'ML';
     CountryCode: 223;
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
     DescOffset: 1692;
     FormatOffset: 436; FormatCount: 2;
     IntlFormatOffset: 143; IntlFormatCount: 1),
    { MM cc=95 }
    (Id: 'MM';
     CountryCode: 95;
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
     DescOffset: 1704;
     FormatOffset: 438; FormatCount: 9;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MN cc=976 }
    (Id: 'MN';
     CountryCode: 976;
     LeadingDigits: '';
     InternationalPrefix: '001';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1716;
     FormatOffset: 447; FormatCount: 5;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MO cc=853 }
    (Id: 'MO';
     CountryCode: 853;
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
     DescOffset: 1728;
     FormatOffset: 452; FormatCount: 2;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MP cc=1 }
    (Id: 'MP';
     CountryCode: 1;
     LeadingDigits: '670';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-9]\d{6})$|1';
     NationalPrefixTransformRule: '670$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 1740;
     FormatOffset: 454; FormatCount: 0;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MQ cc=596 }
    (Id: 'MQ';
     CountryCode: 596;
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
     DescOffset: 1752;
     FormatOffset: 454; FormatCount: 2;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MR cc=222 }
    (Id: 'MR';
     CountryCode: 222;
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
     DescOffset: 1764;
     FormatOffset: 456; FormatCount: 1;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MS cc=1 }
    (Id: 'MS';
     CountryCode: 1;
     LeadingDigits: '664';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([34]\d{6})$|1';
     NationalPrefixTransformRule: '664$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1776;
     FormatOffset: 457; FormatCount: 0;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MT cc=356 }
    (Id: 'MT';
     CountryCode: 356;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1788;
     FormatOffset: 457; FormatCount: 1;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MU cc=230 }
    (Id: 'MU';
     CountryCode: 230;
     LeadingDigits: '';
     InternationalPrefix: '0(?:0|[24-7]0|3[03])';
     PreferredInternationalPrefix: '020';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1800;
     FormatOffset: 458; FormatCount: 3;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MV cc=960 }
    (Id: 'MV';
     CountryCode: 960;
     LeadingDigits: '';
     InternationalPrefix: '0(?:0|19)';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1812;
     FormatOffset: 461; FormatCount: 2;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MW cc=265 }
    (Id: 'MW';
     CountryCode: 265;
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
     DescOffset: 1824;
     FormatOffset: 463; FormatCount: 2;
     IntlFormatOffset: 144; IntlFormatCount: 0),
    { MX cc=52 }
    (Id: 'MX';
     CountryCode: 52;
     LeadingDigits: '';
     InternationalPrefix: '0[09]';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1836;
     FormatOffset: 465; FormatCount: 3;
     IntlFormatOffset: 144; IntlFormatCount: 2),
    { MY cc=60 }
    (Id: 'MY';
     CountryCode: 60;
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
     DescOffset: 1848;
     FormatOffset: 468; FormatCount: 6;
     IntlFormatOffset: 146; IntlFormatCount: 0),
    { MZ cc=258 }
    (Id: 'MZ';
     CountryCode: 258;
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
     DescOffset: 1860;
     FormatOffset: 474; FormatCount: 2;
     IntlFormatOffset: 146; IntlFormatCount: 0),
    { NA cc=264 }
    (Id: 'NA';
     CountryCode: 264;
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
     DescOffset: 1872;
     FormatOffset: 476; FormatCount: 4;
     IntlFormatOffset: 146; IntlFormatCount: 0),
    { NC cc=687 }
    (Id: 'NC';
     CountryCode: 687;
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
     DescOffset: 1884;
     FormatOffset: 480; FormatCount: 2;
     IntlFormatOffset: 146; IntlFormatCount: 1),
    { NE cc=227 }
    (Id: 'NE';
     CountryCode: 227;
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
     DescOffset: 1896;
     FormatOffset: 482; FormatCount: 2;
     IntlFormatOffset: 147; IntlFormatCount: 0),
    { NF cc=672 }
    (Id: 'NF';
     CountryCode: 672;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '([0-258]\d{4})$';
     NationalPrefixTransformRule: '3$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1908;
     FormatOffset: 484; FormatCount: 2;
     IntlFormatOffset: 147; IntlFormatCount: 0),
    { NG cc=234 }
    (Id: 'NG';
     CountryCode: 234;
     LeadingDigits: '';
     InternationalPrefix: '009';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1920;
     FormatOffset: 486; FormatCount: 5;
     IntlFormatOffset: 147; IntlFormatCount: 0),
    { NI cc=505 }
    (Id: 'NI';
     CountryCode: 505;
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
     DescOffset: 1932;
     FormatOffset: 491; FormatCount: 1;
     IntlFormatOffset: 147; IntlFormatCount: 0),
    { NL cc=31 }
    (Id: 'NL';
     CountryCode: 31;
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
     DescOffset: 1944;
     FormatOffset: 492; FormatCount: 9;
     IntlFormatOffset: 147; IntlFormatCount: 6),
    { NO cc=47 }
    (Id: 'NO';
     CountryCode: 47;
     LeadingDigits: '[02-689]|7[0-8]';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 1956;
     FormatOffset: 501; FormatCount: 2;
     IntlFormatOffset: 153; IntlFormatCount: 0),
    { NP cc=977 }
    (Id: 'NP';
     CountryCode: 977;
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
     DescOffset: 1968;
     FormatOffset: 503; FormatCount: 4;
     IntlFormatOffset: 153; IntlFormatCount: 3),
    { NR cc=674 }
    (Id: 'NR';
     CountryCode: 674;
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
     DescOffset: 1980;
     FormatOffset: 507; FormatCount: 1;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { NU cc=683 }
    (Id: 'NU';
     CountryCode: 683;
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
     DescOffset: 1992;
     FormatOffset: 508; FormatCount: 1;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { NZ cc=64 }
    (Id: 'NZ';
     CountryCode: 64;
     LeadingDigits: '';
     InternationalPrefix: '0(?:0|161)';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2004;
     FormatOffset: 509; FormatCount: 6;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { OM cc=968 }
    (Id: 'OM';
     CountryCode: 968;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2016;
     FormatOffset: 515; FormatCount: 3;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PA cc=507 }
    (Id: 'PA';
     CountryCode: 507;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2028;
     FormatOffset: 518; FormatCount: 3;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PE cc=51 }
    (Id: 'PE';
     CountryCode: 51;
     LeadingDigits: '';
     InternationalPrefix: '00|19(?:1[124]|77|90)00';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: ' Anexo ';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2040;
     FormatOffset: 521; FormatCount: 4;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PF cc=689 }
    (Id: 'PF';
     CountryCode: 689;
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
     DescOffset: 2052;
     FormatOffset: 525; FormatCount: 3;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PG cc=675 }
    (Id: 'PG';
     CountryCode: 675;
     LeadingDigits: '';
     InternationalPrefix: '00|140[1-3]';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2064;
     FormatOffset: 528; FormatCount: 2;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PH cc=63 }
    (Id: 'PH';
     CountryCode: 63;
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
     DescOffset: 2076;
     FormatOffset: 530; FormatCount: 8;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PK cc=92 }
    (Id: 'PK';
     CountryCode: 92;
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
     DescOffset: 2088;
     FormatOffset: 538; FormatCount: 8;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PL cc=48 }
    (Id: 'PL';
     CountryCode: 48;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2100;
     FormatOffset: 546; FormatCount: 7;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PM cc=508 }
    (Id: 'PM';
     CountryCode: 508;
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
     DescOffset: 2112;
     FormatOffset: 553; FormatCount: 3;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PR cc=1 }
    (Id: 'PR';
     CountryCode: 1;
     LeadingDigits: '787|939';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '1';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 2124;
     FormatOffset: 556; FormatCount: 0;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PS cc=970 }
    (Id: 'PS';
     CountryCode: 970;
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
     DescOffset: 2136;
     FormatOffset: 556; FormatCount: 3;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PT cc=351 }
    (Id: 'PT';
     CountryCode: 351;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2148;
     FormatOffset: 559; FormatCount: 2;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PW cc=680 }
    (Id: 'PW';
     CountryCode: 680;
     LeadingDigits: '';
     InternationalPrefix: '01[12]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2160;
     FormatOffset: 561; FormatCount: 1;
     IntlFormatOffset: 156; IntlFormatCount: 0),
    { PY cc=595 }
    (Id: 'PY';
     CountryCode: 595;
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
     DescOffset: 2172;
     FormatOffset: 562; FormatCount: 9;
     IntlFormatOffset: 156; IntlFormatCount: 8),
    { QA cc=974 }
    (Id: 'QA';
     CountryCode: 974;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2184;
     FormatOffset: 571; FormatCount: 2;
     IntlFormatOffset: 164; IntlFormatCount: 0),
    { RE cc=262 }
    (Id: 'RE';
     CountryCode: 262;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2196;
     FormatOffset: 573; FormatCount: 1;
     IntlFormatOffset: 164; IntlFormatCount: 0),
    { RO cc=40 }
    (Id: 'RO';
     CountryCode: 40;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: ' int ';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2208;
     FormatOffset: 574; FormatCount: 4;
     IntlFormatOffset: 164; IntlFormatCount: 0),
    { RS cc=381 }
    (Id: 'RS';
     CountryCode: 381;
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
     DescOffset: 2220;
     FormatOffset: 578; FormatCount: 2;
     IntlFormatOffset: 164; IntlFormatCount: 0),
    { RU cc=7 }
    (Id: 'RU';
     CountryCode: 7;
     LeadingDigits: '[3489]';
     InternationalPrefix: '810';
     PreferredInternationalPrefix: '8~10';
     NationalPrefix: '8';
     NationalPrefixForParsing: '8';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2232;
     FormatOffset: 580; FormatCount: 6;
     IntlFormatOffset: 164; IntlFormatCount: 5),
    { RW cc=250 }
    (Id: 'RW';
     CountryCode: 250;
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
     DescOffset: 2244;
     FormatOffset: 586; FormatCount: 3;
     IntlFormatOffset: 169; IntlFormatCount: 0),
    { SA cc=966 }
    (Id: 'SA';
     CountryCode: 966;
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
     DescOffset: 2256;
     FormatOffset: 589; FormatCount: 4;
     IntlFormatOffset: 169; IntlFormatCount: 0),
    { SB cc=677 }
    (Id: 'SB';
     CountryCode: 677;
     LeadingDigits: '';
     InternationalPrefix: '0[01]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2268;
     FormatOffset: 593; FormatCount: 1;
     IntlFormatOffset: 169; IntlFormatCount: 0),
    { SC cc=248 }
    (Id: 'SC';
     CountryCode: 248;
     LeadingDigits: '';
     InternationalPrefix: '010|0[0-2]';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2280;
     FormatOffset: 594; FormatCount: 1;
     IntlFormatOffset: 169; IntlFormatCount: 0),
    { SD cc=249 }
    (Id: 'SD';
     CountryCode: 249;
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
     DescOffset: 2292;
     FormatOffset: 595; FormatCount: 1;
     IntlFormatOffset: 169; IntlFormatCount: 0),
    { SE cc=46 }
    (Id: 'SE';
     CountryCode: 46;
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
     DescOffset: 2304;
     FormatOffset: 596; FormatCount: 12;
     IntlFormatOffset: 169; IntlFormatCount: 12),
    { SG cc=65 }
    (Id: 'SG';
     CountryCode: 65;
     LeadingDigits: '';
     InternationalPrefix: '0[0-3]\d';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2316;
     FormatOffset: 608; FormatCount: 5;
     IntlFormatOffset: 181; IntlFormatCount: 4),
    { SH cc=290 }
    (Id: 'SH';
     CountryCode: 290;
     LeadingDigits: '[256]';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2328;
     FormatOffset: 613; FormatCount: 0;
     IntlFormatOffset: 185; IntlFormatCount: 0),
    { SI cc=386 }
    (Id: 'SI';
     CountryCode: 386;
     LeadingDigits: '';
     InternationalPrefix: '00|10(?:22|66|88|99)';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2340;
     FormatOffset: 613; FormatCount: 4;
     IntlFormatOffset: 185; IntlFormatCount: 0),
    { SJ cc=47 }
    (Id: 'SJ';
     CountryCode: 47;
     LeadingDigits: '79';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2352;
     FormatOffset: 617; FormatCount: 0;
     IntlFormatOffset: 185; IntlFormatCount: 0),
    { SK cc=421 }
    (Id: 'SK';
     CountryCode: 421;
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
     DescOffset: 2364;
     FormatOffset: 617; FormatCount: 6;
     IntlFormatOffset: 185; IntlFormatCount: 5),
    { SL cc=232 }
    (Id: 'SL';
     CountryCode: 232;
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
     DescOffset: 2376;
     FormatOffset: 623; FormatCount: 1;
     IntlFormatOffset: 190; IntlFormatCount: 0),
    { SM cc=378 }
    (Id: 'SM';
     CountryCode: 378;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '([89]\d{5})$';
     NationalPrefixTransformRule: '0549$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2388;
     FormatOffset: 624; FormatCount: 3;
     IntlFormatOffset: 190; IntlFormatCount: 2),
    { SN cc=221 }
    (Id: 'SN';
     CountryCode: 221;
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
     DescOffset: 2400;
     FormatOffset: 627; FormatCount: 2;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { SO cc=252 }
    (Id: 'SO';
     CountryCode: 252;
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
     DescOffset: 2412;
     FormatOffset: 629; FormatCount: 6;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { SR cc=597 }
    (Id: 'SR';
     CountryCode: 597;
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
     DescOffset: 2424;
     FormatOffset: 635; FormatCount: 3;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { SS cc=211 }
    (Id: 'SS';
     CountryCode: 211;
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
     DescOffset: 2436;
     FormatOffset: 638; FormatCount: 1;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { ST cc=239 }
    (Id: 'ST';
     CountryCode: 239;
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
     DescOffset: 2448;
     FormatOffset: 639; FormatCount: 1;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { SV cc=503 }
    (Id: 'SV';
     CountryCode: 503;
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
     DescOffset: 2460;
     FormatOffset: 640; FormatCount: 3;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { SX cc=1 }
    (Id: 'SX';
     CountryCode: 1;
     LeadingDigits: '721';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '(5\d{6})$|1';
     NationalPrefixTransformRule: '721$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2472;
     FormatOffset: 643; FormatCount: 0;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { SY cc=963 }
    (Id: 'SY';
     CountryCode: 963;
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
     DescOffset: 2484;
     FormatOffset: 643; FormatCount: 2;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { SZ cc=268 }
    (Id: 'SZ';
     CountryCode: 268;
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
     DescOffset: 2496;
     FormatOffset: 645; FormatCount: 2;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TA cc=290 }
    (Id: 'TA';
     CountryCode: 290;
     LeadingDigits: '8';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2508;
     FormatOffset: 647; FormatCount: 0;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TC cc=1 }
    (Id: 'TC';
     CountryCode: 1;
     LeadingDigits: '649';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-479]\d{6})$|1';
     NationalPrefixTransformRule: '649$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2520;
     FormatOffset: 647; FormatCount: 0;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TD cc=235 }
    (Id: 'TD';
     CountryCode: 235;
     LeadingDigits: '';
     InternationalPrefix: '00|16';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2532;
     FormatOffset: 647; FormatCount: 1;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TG cc=228 }
    (Id: 'TG';
     CountryCode: 228;
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
     DescOffset: 2544;
     FormatOffset: 648; FormatCount: 1;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TH cc=66 }
    (Id: 'TH';
     CountryCode: 66;
     LeadingDigits: '';
     InternationalPrefix: '00[1-9]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2556;
     FormatOffset: 649; FormatCount: 3;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TJ cc=992 }
    (Id: 'TJ';
     CountryCode: 992;
     LeadingDigits: '';
     InternationalPrefix: '810';
     PreferredInternationalPrefix: '8~10';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2568;
     FormatOffset: 652; FormatCount: 4;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TK cc=690 }
    (Id: 'TK';
     CountryCode: 690;
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
     DescOffset: 2580;
     FormatOffset: 656; FormatCount: 0;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TL cc=670 }
    (Id: 'TL';
     CountryCode: 670;
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
     DescOffset: 2592;
     FormatOffset: 656; FormatCount: 2;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TM cc=993 }
    (Id: 'TM';
     CountryCode: 993;
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
     DescOffset: 2604;
     FormatOffset: 658; FormatCount: 3;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TN cc=216 }
    (Id: 'TN';
     CountryCode: 216;
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
     DescOffset: 2616;
     FormatOffset: 661; FormatCount: 1;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TO cc=676 }
    (Id: 'TO';
     CountryCode: 676;
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
     DescOffset: 2628;
     FormatOffset: 662; FormatCount: 3;
     IntlFormatOffset: 192; IntlFormatCount: 0),
    { TR cc=90 }
    (Id: 'TR';
     CountryCode: 90;
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
     DescOffset: 2640;
     FormatOffset: 665; FormatCount: 5;
     IntlFormatOffset: 192; IntlFormatCount: 4),
    { TT cc=1 }
    (Id: 'TT';
     CountryCode: 1;
     LeadingDigits: '868';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-46-8]\d{6})$|1';
     NationalPrefixTransformRule: '868$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2652;
     FormatOffset: 670; FormatCount: 0;
     IntlFormatOffset: 196; IntlFormatCount: 0),
    { TV cc=688 }
    (Id: 'TV';
     CountryCode: 688;
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
     DescOffset: 2664;
     FormatOffset: 670; FormatCount: 3;
     IntlFormatOffset: 196; IntlFormatCount: 0),
    { TW cc=886 }
    (Id: 'TW';
     CountryCode: 886;
     LeadingDigits: '';
     InternationalPrefix: '0(?:0[25-79]|19)';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '#';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2676;
     FormatOffset: 673; FormatCount: 8;
     IntlFormatOffset: 196; IntlFormatCount: 0),
    { TZ cc=255 }
    (Id: 'TZ';
     CountryCode: 255;
     LeadingDigits: '';
     InternationalPrefix: '00[056]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2688;
     FormatOffset: 681; FormatCount: 4;
     IntlFormatOffset: 196; IntlFormatCount: 0),
    { UA cc=380 }
    (Id: 'UA';
     CountryCode: 380;
     LeadingDigits: '';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '0~0';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2700;
     FormatOffset: 685; FormatCount: 4;
     IntlFormatOffset: 196; IntlFormatCount: 0),
    { UG cc=256 }
    (Id: 'UG';
     CountryCode: 256;
     LeadingDigits: '';
     InternationalPrefix: '00[057]';
     PreferredInternationalPrefix: '';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2712;
     FormatOffset: 689; FormatCount: 3;
     IntlFormatOffset: 196; IntlFormatCount: 0),
    { US cc=1 }
    (Id: 'US';
     CountryCode: 1;
     LeadingDigits: '';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '1';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: True;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 2724;
     FormatOffset: 692; FormatCount: 3;
     IntlFormatOffset: 196; IntlFormatCount: 2),
    { UY cc=598 }
    (Id: 'UY';
     CountryCode: 598;
     LeadingDigits: '';
     InternationalPrefix: '0(?:0|1[3-9]\d)';
     PreferredInternationalPrefix: '00';
     NationalPrefix: '0';
     NationalPrefixForParsing: '0';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: ' int. ';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2736;
     FormatOffset: 695; FormatCount: 7;
     IntlFormatOffset: 198; IntlFormatCount: 0),
    { UZ cc=998 }
    (Id: 'UZ';
     CountryCode: 998;
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
     DescOffset: 2748;
     FormatOffset: 702; FormatCount: 1;
     IntlFormatOffset: 198; IntlFormatCount: 0),
    { VA cc=39 }
    (Id: 'VA';
     CountryCode: 39;
     LeadingDigits: '06698';
     InternationalPrefix: '00';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2760;
     FormatOffset: 703; FormatCount: 0;
     IntlFormatOffset: 198; IntlFormatCount: 0),
    { VC cc=1 }
    (Id: 'VC';
     CountryCode: 1;
     LeadingDigits: '784';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-7]\d{6})$|1';
     NationalPrefixTransformRule: '784$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2772;
     FormatOffset: 703; FormatCount: 0;
     IntlFormatOffset: 198; IntlFormatCount: 0),
    { VE cc=58 }
    (Id: 'VE';
     CountryCode: 58;
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
     DescOffset: 2784;
     FormatOffset: 703; FormatCount: 1;
     IntlFormatOffset: 198; IntlFormatCount: 0),
    { VG cc=1 }
    (Id: 'VG';
     CountryCode: 1;
     LeadingDigits: '284';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-578]\d{6})$|1';
     NationalPrefixTransformRule: '284$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: True;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2796;
     FormatOffset: 704; FormatCount: 0;
     IntlFormatOffset: 198; IntlFormatCount: 0),
    { VI cc=1 }
    (Id: 'VI';
     CountryCode: 1;
     LeadingDigits: '340';
     InternationalPrefix: '011';
     PreferredInternationalPrefix: '';
     NationalPrefix: '1';
     NationalPrefixForParsing: '([2-9]\d{6})$|1';
     NationalPrefixTransformRule: '340$1';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: True;
     DescOffset: 2808;
     FormatOffset: 704; FormatCount: 0;
     IntlFormatOffset: 198; IntlFormatCount: 0),
    { VN cc=84 }
    (Id: 'VN';
     CountryCode: 84;
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
     DescOffset: 2820;
     FormatOffset: 704; FormatCount: 7;
     IntlFormatOffset: 198; IntlFormatCount: 5),
    { VU cc=678 }
    (Id: 'VU';
     CountryCode: 678;
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
     DescOffset: 2832;
     FormatOffset: 711; FormatCount: 1;
     IntlFormatOffset: 203; IntlFormatCount: 0),
    { WF cc=681 }
    (Id: 'WF';
     CountryCode: 681;
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
     DescOffset: 2844;
     FormatOffset: 712; FormatCount: 2;
     IntlFormatOffset: 203; IntlFormatCount: 0),
    { WS cc=685 }
    (Id: 'WS';
     CountryCode: 685;
     LeadingDigits: '';
     InternationalPrefix: '0';
     PreferredInternationalPrefix: '';
     NationalPrefix: '';
     NationalPrefixForParsing: '';
     NationalPrefixTransformRule: '';
     PreferredExtnPrefix: '';
     MainCountryForCode: False;
     MobileNumberPortableRegion: False;
     SameMobileAndFixedLinePattern: False;
     DescOffset: 2856;
     FormatOffset: 714; FormatCount: 3;
     IntlFormatOffset: 203; IntlFormatCount: 0),
    { XK cc=383 }
    (Id: 'XK';
     CountryCode: 383;
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
     DescOffset: 2868;
     FormatOffset: 717; FormatCount: 4;
     IntlFormatOffset: 203; IntlFormatCount: 0),
    { YE cc=967 }
    (Id: 'YE';
     CountryCode: 967;
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
     DescOffset: 2880;
     FormatOffset: 721; FormatCount: 2;
     IntlFormatOffset: 203; IntlFormatCount: 0),
    { YT cc=262 }
    (Id: 'YT';
     CountryCode: 262;
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
     DescOffset: 2892;
     FormatOffset: 723; FormatCount: 0;
     IntlFormatOffset: 203; IntlFormatCount: 0),
    { ZA cc=27 }
    (Id: 'ZA';
     CountryCode: 27;
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
     DescOffset: 2904;
     FormatOffset: 723; FormatCount: 5;
     IntlFormatOffset: 203; IntlFormatCount: 0),
    { ZM cc=260 }
    (Id: 'ZM';
     CountryCode: 260;
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
     DescOffset: 2916;
     FormatOffset: 728; FormatCount: 3;
     IntlFormatOffset: 203; IntlFormatCount: 2),
    { ZW cc=263 }
    (Id: 'ZW';
     CountryCode: 263;
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
     DescOffset: 2928;
     FormatOffset: 731; FormatCount: 9;
     IntlFormatOffset: 205; IntlFormatCount: 0),
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
     DescOffset: 2940;
     FormatOffset: 740; FormatCount: 1;
     IntlFormatOffset: 205; IntlFormatCount: 0),
    { 001 cc=808 }
    (Id: '001';
     CountryCode: 808;
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
     DescOffset: 2952;
     FormatOffset: 741; FormatCount: 1;
     IntlFormatOffset: 205; IntlFormatCount: 0),
    { 001 cc=870 }
    (Id: '001';
     CountryCode: 870;
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
     DescOffset: 2964;
     FormatOffset: 742; FormatCount: 1;
     IntlFormatOffset: 205; IntlFormatCount: 0),
    { 001 cc=878 }
    (Id: '001';
     CountryCode: 878;
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
     DescOffset: 2976;
     FormatOffset: 743; FormatCount: 1;
     IntlFormatOffset: 205; IntlFormatCount: 0),
    { 001 cc=881 }
    (Id: '001';
     CountryCode: 881;
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
     DescOffset: 2988;
     FormatOffset: 744; FormatCount: 2;
     IntlFormatOffset: 205; IntlFormatCount: 0),
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
     DescOffset: 3000;
     FormatOffset: 746; FormatCount: 8;
     IntlFormatOffset: 205; IntlFormatCount: 0),
    { 001 cc=883 }
    (Id: '001';
     CountryCode: 883;
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
     DescOffset: 3012;
     FormatOffset: 754; FormatCount: 5;
     IntlFormatOffset: 205; IntlFormatCount: 0),
    { 001 cc=888 }
    (Id: '001';
     CountryCode: 888;
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
     DescOffset: 3024;
     FormatOffset: 759; FormatCount: 1;
     IntlFormatOffset: 205; IntlFormatCount: 0),
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
     DescOffset: 3036;
     FormatOffset: 760; FormatCount: 1;
     IntlFormatOffset: 205; IntlFormatCount: 0)
  );

  { Territory indices of the geographical regions, sorted by ordinal region code. }
  PhoneMetadataRegionOrder: array[0..244] of SmallInt = (
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
    20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
    40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
    60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
    80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
    100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
    120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139,
    140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
    160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179,
    180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199,
    200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
    220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
    240, 241, 242, 243, 244
  );

  { Region codes of the geographical regions, sorted by ordinal region code. }
  PhoneMetadataRegionCodes: array[0..244] of string = (
    'AC', 'AD', 'AE', 'AF', 'AG', 'AI', 'AL', 'AM', 'AO', 'AR',
    'AS', 'AT', 'AU', 'AW', 'AX', 'AZ', 'BA', 'BB', 'BD', 'BE',
    'BF', 'BG', 'BH', 'BI', 'BJ', 'BL', 'BM', 'BN', 'BO', 'BQ',
    'BR', 'BS', 'BT', 'BW', 'BY', 'BZ', 'CA', 'CC', 'CD', 'CF',
    'CG', 'CH', 'CI', 'CK', 'CL', 'CM', 'CN', 'CO', 'CR', 'CU',
    'CV', 'CW', 'CX', 'CY', 'CZ', 'DE', 'DJ', 'DK', 'DM', 'DO',
    'DZ', 'EC', 'EE', 'EG', 'EH', 'ER', 'ES', 'ET', 'FI', 'FJ',
    'FK', 'FM', 'FO', 'FR', 'GA', 'GB', 'GD', 'GE', 'GF', 'GG',
    'GH', 'GI', 'GL', 'GM', 'GN', 'GP', 'GQ', 'GR', 'GT', 'GU',
    'GW', 'GY', 'HK', 'HN', 'HR', 'HT', 'HU', 'ID', 'IE', 'IL',
    'IM', 'IN', 'IO', 'IQ', 'IR', 'IS', 'IT', 'JE', 'JM', 'JO',
    'JP', 'KE', 'KG', 'KH', 'KI', 'KM', 'KN', 'KP', 'KR', 'KW',
    'KY', 'KZ', 'LA', 'LB', 'LC', 'LI', 'LK', 'LR', 'LS', 'LT',
    'LU', 'LV', 'LY', 'MA', 'MC', 'MD', 'ME', 'MF', 'MG', 'MH',
    'MK', 'ML', 'MM', 'MN', 'MO', 'MP', 'MQ', 'MR', 'MS', 'MT',
    'MU', 'MV', 'MW', 'MX', 'MY', 'MZ', 'NA', 'NC', 'NE', 'NF',
    'NG', 'NI', 'NL', 'NO', 'NP', 'NR', 'NU', 'NZ', 'OM', 'PA',
    'PE', 'PF', 'PG', 'PH', 'PK', 'PL', 'PM', 'PR', 'PS', 'PT',
    'PW', 'PY', 'QA', 'RE', 'RO', 'RS', 'RU', 'RW', 'SA', 'SB',
    'SC', 'SD', 'SE', 'SG', 'SH', 'SI', 'SJ', 'SK', 'SL', 'SM',
    'SN', 'SO', 'SR', 'SS', 'ST', 'SV', 'SX', 'SY', 'SZ', 'TA',
    'TC', 'TD', 'TG', 'TH', 'TJ', 'TK', 'TL', 'TM', 'TN', 'TO',
    'TR', 'TT', 'TV', 'TW', 'TZ', 'UA', 'UG', 'US', 'UY', 'UZ',
    'VA', 'VC', 'VE', 'VG', 'VI', 'VN', 'VU', 'WF', 'WS', 'XK',
    'YE', 'YT', 'ZA', 'ZM', 'ZW'
  );

  { Territory indices of the non geographical entities, sorted by country calling code. }
  PhoneMetadataNonGeoOrder: array[0..8] of SmallInt = (
    245, 246, 247, 248, 249, 250, 251, 252, 253
  );

  { Country calling codes of the non geographical entities, ascending. }
  PhoneMetadataNonGeoCallingCodes: array[0..8] of Integer = (
    800, 808, 870, 878, 881, 882, 883, 888, 979
  );

  { Country calling code groups, ascending by calling code. }
  PhoneMetadataCountryCodeGroups: array[0..214] of TCountryCodeGroupRec = (
    (CountryCode: 1; RegionOffset: 0; RegionCount: 25),
    (CountryCode: 7; RegionOffset: 25; RegionCount: 2),
    (CountryCode: 20; RegionOffset: 27; RegionCount: 1),
    (CountryCode: 27; RegionOffset: 28; RegionCount: 1),
    (CountryCode: 30; RegionOffset: 29; RegionCount: 1),
    (CountryCode: 31; RegionOffset: 30; RegionCount: 1),
    (CountryCode: 32; RegionOffset: 31; RegionCount: 1),
    (CountryCode: 33; RegionOffset: 32; RegionCount: 1),
    (CountryCode: 34; RegionOffset: 33; RegionCount: 1),
    (CountryCode: 36; RegionOffset: 34; RegionCount: 1),
    (CountryCode: 39; RegionOffset: 35; RegionCount: 2),
    (CountryCode: 40; RegionOffset: 37; RegionCount: 1),
    (CountryCode: 41; RegionOffset: 38; RegionCount: 1),
    (CountryCode: 43; RegionOffset: 39; RegionCount: 1),
    (CountryCode: 44; RegionOffset: 40; RegionCount: 4),
    (CountryCode: 45; RegionOffset: 44; RegionCount: 1),
    (CountryCode: 46; RegionOffset: 45; RegionCount: 1),
    (CountryCode: 47; RegionOffset: 46; RegionCount: 2),
    (CountryCode: 48; RegionOffset: 48; RegionCount: 1),
    (CountryCode: 49; RegionOffset: 49; RegionCount: 1),
    (CountryCode: 51; RegionOffset: 50; RegionCount: 1),
    (CountryCode: 52; RegionOffset: 51; RegionCount: 1),
    (CountryCode: 53; RegionOffset: 52; RegionCount: 1),
    (CountryCode: 54; RegionOffset: 53; RegionCount: 1),
    (CountryCode: 55; RegionOffset: 54; RegionCount: 1),
    (CountryCode: 56; RegionOffset: 55; RegionCount: 1),
    (CountryCode: 57; RegionOffset: 56; RegionCount: 1),
    (CountryCode: 58; RegionOffset: 57; RegionCount: 1),
    (CountryCode: 60; RegionOffset: 58; RegionCount: 1),
    (CountryCode: 61; RegionOffset: 59; RegionCount: 3),
    (CountryCode: 62; RegionOffset: 62; RegionCount: 1),
    (CountryCode: 63; RegionOffset: 63; RegionCount: 1),
    (CountryCode: 64; RegionOffset: 64; RegionCount: 1),
    (CountryCode: 65; RegionOffset: 65; RegionCount: 1),
    (CountryCode: 66; RegionOffset: 66; RegionCount: 1),
    (CountryCode: 81; RegionOffset: 67; RegionCount: 1),
    (CountryCode: 82; RegionOffset: 68; RegionCount: 1),
    (CountryCode: 84; RegionOffset: 69; RegionCount: 1),
    (CountryCode: 86; RegionOffset: 70; RegionCount: 1),
    (CountryCode: 90; RegionOffset: 71; RegionCount: 1),
    (CountryCode: 91; RegionOffset: 72; RegionCount: 1),
    (CountryCode: 92; RegionOffset: 73; RegionCount: 1),
    (CountryCode: 93; RegionOffset: 74; RegionCount: 1),
    (CountryCode: 94; RegionOffset: 75; RegionCount: 1),
    (CountryCode: 95; RegionOffset: 76; RegionCount: 1),
    (CountryCode: 98; RegionOffset: 77; RegionCount: 1),
    (CountryCode: 211; RegionOffset: 78; RegionCount: 1),
    (CountryCode: 212; RegionOffset: 79; RegionCount: 2),
    (CountryCode: 213; RegionOffset: 81; RegionCount: 1),
    (CountryCode: 216; RegionOffset: 82; RegionCount: 1),
    (CountryCode: 218; RegionOffset: 83; RegionCount: 1),
    (CountryCode: 220; RegionOffset: 84; RegionCount: 1),
    (CountryCode: 221; RegionOffset: 85; RegionCount: 1),
    (CountryCode: 222; RegionOffset: 86; RegionCount: 1),
    (CountryCode: 223; RegionOffset: 87; RegionCount: 1),
    (CountryCode: 224; RegionOffset: 88; RegionCount: 1),
    (CountryCode: 225; RegionOffset: 89; RegionCount: 1),
    (CountryCode: 226; RegionOffset: 90; RegionCount: 1),
    (CountryCode: 227; RegionOffset: 91; RegionCount: 1),
    (CountryCode: 228; RegionOffset: 92; RegionCount: 1),
    (CountryCode: 229; RegionOffset: 93; RegionCount: 1),
    (CountryCode: 230; RegionOffset: 94; RegionCount: 1),
    (CountryCode: 231; RegionOffset: 95; RegionCount: 1),
    (CountryCode: 232; RegionOffset: 96; RegionCount: 1),
    (CountryCode: 233; RegionOffset: 97; RegionCount: 1),
    (CountryCode: 234; RegionOffset: 98; RegionCount: 1),
    (CountryCode: 235; RegionOffset: 99; RegionCount: 1),
    (CountryCode: 236; RegionOffset: 100; RegionCount: 1),
    (CountryCode: 237; RegionOffset: 101; RegionCount: 1),
    (CountryCode: 238; RegionOffset: 102; RegionCount: 1),
    (CountryCode: 239; RegionOffset: 103; RegionCount: 1),
    (CountryCode: 240; RegionOffset: 104; RegionCount: 1),
    (CountryCode: 241; RegionOffset: 105; RegionCount: 1),
    (CountryCode: 242; RegionOffset: 106; RegionCount: 1),
    (CountryCode: 243; RegionOffset: 107; RegionCount: 1),
    (CountryCode: 244; RegionOffset: 108; RegionCount: 1),
    (CountryCode: 245; RegionOffset: 109; RegionCount: 1),
    (CountryCode: 246; RegionOffset: 110; RegionCount: 1),
    (CountryCode: 247; RegionOffset: 111; RegionCount: 1),
    (CountryCode: 248; RegionOffset: 112; RegionCount: 1),
    (CountryCode: 249; RegionOffset: 113; RegionCount: 1),
    (CountryCode: 250; RegionOffset: 114; RegionCount: 1),
    (CountryCode: 251; RegionOffset: 115; RegionCount: 1),
    (CountryCode: 252; RegionOffset: 116; RegionCount: 1),
    (CountryCode: 253; RegionOffset: 117; RegionCount: 1),
    (CountryCode: 254; RegionOffset: 118; RegionCount: 1),
    (CountryCode: 255; RegionOffset: 119; RegionCount: 1),
    (CountryCode: 256; RegionOffset: 120; RegionCount: 1),
    (CountryCode: 257; RegionOffset: 121; RegionCount: 1),
    (CountryCode: 258; RegionOffset: 122; RegionCount: 1),
    (CountryCode: 260; RegionOffset: 123; RegionCount: 1),
    (CountryCode: 261; RegionOffset: 124; RegionCount: 1),
    (CountryCode: 262; RegionOffset: 125; RegionCount: 2),
    (CountryCode: 263; RegionOffset: 127; RegionCount: 1),
    (CountryCode: 264; RegionOffset: 128; RegionCount: 1),
    (CountryCode: 265; RegionOffset: 129; RegionCount: 1),
    (CountryCode: 266; RegionOffset: 130; RegionCount: 1),
    (CountryCode: 267; RegionOffset: 131; RegionCount: 1),
    (CountryCode: 268; RegionOffset: 132; RegionCount: 1),
    (CountryCode: 269; RegionOffset: 133; RegionCount: 1),
    (CountryCode: 290; RegionOffset: 134; RegionCount: 2),
    (CountryCode: 291; RegionOffset: 136; RegionCount: 1),
    (CountryCode: 297; RegionOffset: 137; RegionCount: 1),
    (CountryCode: 298; RegionOffset: 138; RegionCount: 1),
    (CountryCode: 299; RegionOffset: 139; RegionCount: 1),
    (CountryCode: 350; RegionOffset: 140; RegionCount: 1),
    (CountryCode: 351; RegionOffset: 141; RegionCount: 1),
    (CountryCode: 352; RegionOffset: 142; RegionCount: 1),
    (CountryCode: 353; RegionOffset: 143; RegionCount: 1),
    (CountryCode: 354; RegionOffset: 144; RegionCount: 1),
    (CountryCode: 355; RegionOffset: 145; RegionCount: 1),
    (CountryCode: 356; RegionOffset: 146; RegionCount: 1),
    (CountryCode: 357; RegionOffset: 147; RegionCount: 1),
    (CountryCode: 358; RegionOffset: 148; RegionCount: 2),
    (CountryCode: 359; RegionOffset: 150; RegionCount: 1),
    (CountryCode: 370; RegionOffset: 151; RegionCount: 1),
    (CountryCode: 371; RegionOffset: 152; RegionCount: 1),
    (CountryCode: 372; RegionOffset: 153; RegionCount: 1),
    (CountryCode: 373; RegionOffset: 154; RegionCount: 1),
    (CountryCode: 374; RegionOffset: 155; RegionCount: 1),
    (CountryCode: 375; RegionOffset: 156; RegionCount: 1),
    (CountryCode: 376; RegionOffset: 157; RegionCount: 1),
    (CountryCode: 377; RegionOffset: 158; RegionCount: 1),
    (CountryCode: 378; RegionOffset: 159; RegionCount: 1),
    (CountryCode: 380; RegionOffset: 160; RegionCount: 1),
    (CountryCode: 381; RegionOffset: 161; RegionCount: 1),
    (CountryCode: 382; RegionOffset: 162; RegionCount: 1),
    (CountryCode: 383; RegionOffset: 163; RegionCount: 1),
    (CountryCode: 385; RegionOffset: 164; RegionCount: 1),
    (CountryCode: 386; RegionOffset: 165; RegionCount: 1),
    (CountryCode: 387; RegionOffset: 166; RegionCount: 1),
    (CountryCode: 389; RegionOffset: 167; RegionCount: 1),
    (CountryCode: 420; RegionOffset: 168; RegionCount: 1),
    (CountryCode: 421; RegionOffset: 169; RegionCount: 1),
    (CountryCode: 423; RegionOffset: 170; RegionCount: 1),
    (CountryCode: 500; RegionOffset: 171; RegionCount: 1),
    (CountryCode: 501; RegionOffset: 172; RegionCount: 1),
    (CountryCode: 502; RegionOffset: 173; RegionCount: 1),
    (CountryCode: 503; RegionOffset: 174; RegionCount: 1),
    (CountryCode: 504; RegionOffset: 175; RegionCount: 1),
    (CountryCode: 505; RegionOffset: 176; RegionCount: 1),
    (CountryCode: 506; RegionOffset: 177; RegionCount: 1),
    (CountryCode: 507; RegionOffset: 178; RegionCount: 1),
    (CountryCode: 508; RegionOffset: 179; RegionCount: 1),
    (CountryCode: 509; RegionOffset: 180; RegionCount: 1),
    (CountryCode: 590; RegionOffset: 181; RegionCount: 3),
    (CountryCode: 591; RegionOffset: 184; RegionCount: 1),
    (CountryCode: 592; RegionOffset: 185; RegionCount: 1),
    (CountryCode: 593; RegionOffset: 186; RegionCount: 1),
    (CountryCode: 594; RegionOffset: 187; RegionCount: 1),
    (CountryCode: 595; RegionOffset: 188; RegionCount: 1),
    (CountryCode: 596; RegionOffset: 189; RegionCount: 1),
    (CountryCode: 597; RegionOffset: 190; RegionCount: 1),
    (CountryCode: 598; RegionOffset: 191; RegionCount: 1),
    (CountryCode: 599; RegionOffset: 192; RegionCount: 2),
    (CountryCode: 670; RegionOffset: 194; RegionCount: 1),
    (CountryCode: 672; RegionOffset: 195; RegionCount: 1),
    (CountryCode: 673; RegionOffset: 196; RegionCount: 1),
    (CountryCode: 674; RegionOffset: 197; RegionCount: 1),
    (CountryCode: 675; RegionOffset: 198; RegionCount: 1),
    (CountryCode: 676; RegionOffset: 199; RegionCount: 1),
    (CountryCode: 677; RegionOffset: 200; RegionCount: 1),
    (CountryCode: 678; RegionOffset: 201; RegionCount: 1),
    (CountryCode: 679; RegionOffset: 202; RegionCount: 1),
    (CountryCode: 680; RegionOffset: 203; RegionCount: 1),
    (CountryCode: 681; RegionOffset: 204; RegionCount: 1),
    (CountryCode: 682; RegionOffset: 205; RegionCount: 1),
    (CountryCode: 683; RegionOffset: 206; RegionCount: 1),
    (CountryCode: 685; RegionOffset: 207; RegionCount: 1),
    (CountryCode: 686; RegionOffset: 208; RegionCount: 1),
    (CountryCode: 687; RegionOffset: 209; RegionCount: 1),
    (CountryCode: 688; RegionOffset: 210; RegionCount: 1),
    (CountryCode: 689; RegionOffset: 211; RegionCount: 1),
    (CountryCode: 690; RegionOffset: 212; RegionCount: 1),
    (CountryCode: 691; RegionOffset: 213; RegionCount: 1),
    (CountryCode: 692; RegionOffset: 214; RegionCount: 1),
    (CountryCode: 800; RegionOffset: 215; RegionCount: 1),
    (CountryCode: 808; RegionOffset: 216; RegionCount: 1),
    (CountryCode: 850; RegionOffset: 217; RegionCount: 1),
    (CountryCode: 852; RegionOffset: 218; RegionCount: 1),
    (CountryCode: 853; RegionOffset: 219; RegionCount: 1),
    (CountryCode: 855; RegionOffset: 220; RegionCount: 1),
    (CountryCode: 856; RegionOffset: 221; RegionCount: 1),
    (CountryCode: 870; RegionOffset: 222; RegionCount: 1),
    (CountryCode: 878; RegionOffset: 223; RegionCount: 1),
    (CountryCode: 880; RegionOffset: 224; RegionCount: 1),
    (CountryCode: 881; RegionOffset: 225; RegionCount: 1),
    (CountryCode: 882; RegionOffset: 226; RegionCount: 1),
    (CountryCode: 883; RegionOffset: 227; RegionCount: 1),
    (CountryCode: 886; RegionOffset: 228; RegionCount: 1),
    (CountryCode: 888; RegionOffset: 229; RegionCount: 1),
    (CountryCode: 960; RegionOffset: 230; RegionCount: 1),
    (CountryCode: 961; RegionOffset: 231; RegionCount: 1),
    (CountryCode: 962; RegionOffset: 232; RegionCount: 1),
    (CountryCode: 963; RegionOffset: 233; RegionCount: 1),
    (CountryCode: 964; RegionOffset: 234; RegionCount: 1),
    (CountryCode: 965; RegionOffset: 235; RegionCount: 1),
    (CountryCode: 966; RegionOffset: 236; RegionCount: 1),
    (CountryCode: 967; RegionOffset: 237; RegionCount: 1),
    (CountryCode: 968; RegionOffset: 238; RegionCount: 1),
    (CountryCode: 970; RegionOffset: 239; RegionCount: 1),
    (CountryCode: 971; RegionOffset: 240; RegionCount: 1),
    (CountryCode: 972; RegionOffset: 241; RegionCount: 1),
    (CountryCode: 973; RegionOffset: 242; RegionCount: 1),
    (CountryCode: 974; RegionOffset: 243; RegionCount: 1),
    (CountryCode: 975; RegionOffset: 244; RegionCount: 1),
    (CountryCode: 976; RegionOffset: 245; RegionCount: 1),
    (CountryCode: 977; RegionOffset: 246; RegionCount: 1),
    (CountryCode: 979; RegionOffset: 247; RegionCount: 1),
    (CountryCode: 992; RegionOffset: 248; RegionCount: 1),
    (CountryCode: 993; RegionOffset: 249; RegionCount: 1),
    (CountryCode: 994; RegionOffset: 250; RegionCount: 1),
    (CountryCode: 995; RegionOffset: 251; RegionCount: 1),
    (CountryCode: 996; RegionOffset: 252; RegionCount: 1),
    (CountryCode: 998; RegionOffset: 253; RegionCount: 1)
  );

  { Territory indices per calling code group, main country for code first. }
  PhoneMetadataCountryCodeRegions: array[0..253] of SmallInt = (
    227, 4, 5, 10, 17, 26, 31, 36, 58, 59, 76, 89, 108, 116, 120, 124, 145, 148, 177, 206,
    210, 221, 231, 233, 234, 186, 121, 63, 242, 87, 162, 19, 73, 66, 96, 106, 230, 184, 41, 11,
    75, 79, 100, 107, 57, 192, 163, 196, 175, 55, 170, 153, 49, 9, 30, 44, 47, 232, 154, 12,
    37, 52, 97, 173, 167, 193, 213, 110, 118, 235, 46, 220, 101, 174, 3, 126, 142, 104, 203, 133,
    64, 60, 218, 132, 83, 200, 147, 141, 84, 42, 20, 158, 212, 24, 150, 127, 198, 80, 160, 211,
    39, 45, 50, 204, 86, 74, 40, 38, 8, 90, 102, 0, 190, 191, 187, 67, 201, 56, 111, 224,
    226, 23, 155, 243, 138, 183, 241, 244, 156, 152, 128, 33, 208, 115, 194, 209, 65, 13, 72, 82,
    81, 179, 130, 98, 105, 6, 149, 53, 68, 14, 21, 129, 131, 62, 135, 7, 34, 1, 134, 199,
    225, 185, 136, 239, 94, 195, 16, 140, 54, 197, 125, 70, 35, 88, 205, 93, 161, 48, 169, 176,
    95, 85, 25, 137, 28, 91, 61, 78, 181, 146, 202, 228, 51, 29, 216, 159, 27, 165, 172, 219,
    189, 236, 69, 180, 237, 43, 166, 238, 114, 157, 222, 171, 215, 71, 139, 245, 246, 117, 92, 144,
    113, 122, 247, 248, 18, 249, 250, 251, 223, 252, 151, 123, 109, 207, 103, 119, 188, 240, 168, 178,
    2, 99, 22, 182, 32, 143, 164, 253, 214, 217, 15, 77, 112, 229
  );

implementation

end.
