unit LibPhoneNumber.TestingMetadata.Formats;

{
  GENERATED FILE - DO NOT EDIT.

  Number format tables (national and international) plus the shared leadingDigits pattern pool.

  Source:    vendor/libphonenumber/resources/PhoneNumberMetadataForTesting.xml
  Commit:    33be5664343676b27761213d8f5500d682568ea7
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
  PhoneMetadataNumberFormatCount = 69;
  PhoneMetadataIntlNumberFormatCount = 12;
  PhoneMetadataLeadingDigitsCount = 71;

  PhoneMetadataLeadingDigits: array[0..70] of string = (
    '11',
    '1[02-9]|[23]',
    '911',
    '9(?:1[02-9]|[23])',
    '[68]',
    '1',
    '[2-478]',
    '[1-8]',
    '[3-9]',
    '[3-9]\d{2}[19]',
    '[3-9]\d{2}(?:10|95)',
    '6',
    '3',
    '2|3[3-9]|906|[4-9][1-9]1',
    '[34]0|[68]9',
    '[4-9]',
    '[4-6]|[7-9](?:\d[1-9]|[1-9]\d)',
    '800',
    '900',
    '[1-59]|[78]0',
    '7[1-57-9]',
    '8[47]',
    '0[26]',
    '0[13-57-9]',
    '8',
    '[57-9]0',
    '111|222|333',
    '(?:111|222|333)1',
    '(?:111|222|333)11',
    '222|333',
    '2221|3332',
    '22212|3332',
    '222120|3332',
    '[23]',
    '077',
    '1(?:0|1[19]|[69]9|5[458])|[57]0',
    '1(?:0|1[19]|[69]9|5(?:44|59|8))|[57]0',
    '1(?:[169][2-8]|[78]|5[1-4])|[68]0|[3-6][1-9][2-9]',
    '1(?:[169][2-8]|[78]|5(?:[1-3]|4[56]))|[68]0|[3-6][1-9][2-9]',
    '131',
    '1312',
    '131',
    '131[13-9]',
    '13[2-9]',
    '30',
    '2(?:[26]|3[0-467])',
    '2(?:[26]|3(?:01|1[45]|2[17-9]|39|4|6[67]|7[078]))',
    '2(?:3[0-35-9]|[457-9])',
    '2(?:3(?:0[02-9]|1[0-36-9]|2[02-6]|3[0-8]|6[0-589]|7[1-69]|[589])|[457-9])',
    '21[0-46-9]',
    '21(?:[0-247-9]|3[124]|6[1269])',
    '21[36]',
    '21(?:3[035-9]|6[03-578])',
    '[3-6][1-9]1',
    '[3-6][1-9]1(?:[0-46-9])',
    '[3-6][1-9]1(?:[0-247-9]|3[124]|6[1269])',
    '[3-6][1-9]1',
    '[3-6][1-9]1[36]',
    '[3-6][1-9]1(?:3[035-9]|6[03-578])',
    '[89]00',
    '901',
    '33|55|81',
    '[2467]|3[0-24-9]|5[0-46-9]|8[2-9]|9[1-9]',
    '1(?:33|55|81)',
    '1(?:[124579]|3[0-24-9]|5[0-46-9]|8[02-9])',
    '24|[34679]',
    '2[179]',
    '[89]',
    '[369]|8[1-9]',
    '1[89]',
    '[679]'
  );

  PhoneMetadataNumberFormats: array[0..68] of TNumberFormatRec = (
    { AO }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { AR }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2-$3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { AR }
    (Pattern: '(\d{4})(\d{2})(\d{4})';
     Format: '$1 $2-$3';
     LeadingDigitsOffset: 1; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { AR }
    (Pattern: '(\d)(\d{2})(\d{4})(\d{4})';
     Format: '$2 15 $3-$4';
     LeadingDigitsOffset: 2; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: '$1 $2 $3 $4'),
    { AR }
    (Pattern: '(\d)(\d{4})(\d{2})(\d{4})';
     Format: '$2 $3-$4';
     LeadingDigitsOffset: 3; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '0$1 $CC';
     IntlFormatKind: ifkExplicit;
     IntlFormat: '$1 $2 $3 $4'),
    { AR }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 4; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { AU }
    (Pattern: '(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 5; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { AU }
    (Pattern: '(\d)(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 6; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { BY }
    (Pattern: '(\d{4})';
     Format: '$1';
     LeadingDigitsOffset: 7; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '8 $1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { BY }
    (Pattern: '(\d{2})(\d{3})';
     Format: '$1 $2';
     LeadingDigitsOffset: 7; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '8$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { BY }
    (Pattern: '(\d{3})(\d{3})';
     Format: '$1 $2';
     LeadingDigitsOffset: 7; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '8 $1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { CN }
    (Pattern: '(\d{3})(\d{5,6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 8; LeadingDigitsCount: 3;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '$CC $1';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { CN }
    (Pattern: '(\d{3})(\d{8})';
     Format: '$1 $2';
     LeadingDigitsOffset: 5; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { CO }
    (Pattern: '(\d{3})(\d{7})';
     Format: '$1 $2';
     LeadingDigitsOffset: 11; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '($1)';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '0$CC $1';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { CO }
    (Pattern: '(\d{3})(\d{7})';
     Format: '$1 $2';
     LeadingDigitsOffset: 12; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '0$CC $1';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { DE }
    (Pattern: '(\d{3})(\d{3,8})';
     Format: '$1 $2';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { DE }
    (Pattern: '(\d{2})(\d{4,11})';
     Format: '$1/$2';
     LeadingDigitsOffset: 14; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { DE }
    (Pattern: '(\d{2})(\d{2})';
     Format: '$1 $2';
     LeadingDigitsOffset: 15; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { DE }
    (Pattern: '(\d{4})(\d{2,7})';
     Format: '$1 $2';
     LeadingDigitsOffset: 15; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { DE }
    (Pattern: '(\d{3})(\d{1})(\d{6})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 17; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { DE }
    (Pattern: '(\d{3})(\d{3,4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 18; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { FR }
    (Pattern: '(\d)(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 12; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { GB }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 19; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '(0$1)';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { GB }
    (Pattern: '(\d)(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 11; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '(0$1)';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { GB }
    (Pattern: '(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 20; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '(0$1)';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { GB }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 21; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '(0$1)';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { IT }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { IT }
    (Pattern: '(\d{3})(\d{4})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 23; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { IT }
    (Pattern: '(\d{3})(\d{3})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 12; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { IT }
    (Pattern: '(\d{3})(\d{3,6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 24; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { JP }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 25; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { JP }
    (Pattern: '(\d{2})(\d{2})(\d{3})(\d{4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 25; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { JP }
    (Pattern: '(\d{2})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 26; LeadingDigitsCount: 3;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { JP }
    (Pattern: '(\d{4})(\d)(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 29; LeadingDigitsCount: 4;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { JP }
    (Pattern: '(\d{3})(\d{2})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 33; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { JP }
    (Pattern: '(\d{3})(\d{4})';
     Format: '$1-$2';
     LeadingDigitsOffset: 34; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { JP }
    (Pattern: '(\d{4})';
     Format: '*$1';
     LeadingDigitsOffset: 33; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 35; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{2})(\d{3})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 37; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{3})(\d)(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 39; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{3})(\d{2})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 41; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 43; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{2})(\d{2})(\d{3})(\d{4})';
     Format: '$1-$2-$3-$4';
     LeadingDigitsOffset: 44; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d)(\d{4})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 45; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d)(\d{3})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 47; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d)(\d{3})';
     Format: '$1-$2';
     LeadingDigitsOffset: 49; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d)(\d{4})';
     Format: '$1-$2';
     LeadingDigitsOffset: 51; LeadingDigitsCount: 2;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{2})(\d{3})';
     Format: '$1-$2';
     LeadingDigitsOffset: 53; LeadingDigitsCount: 3;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { KR }
    (Pattern: '(\d{2})(\d{4})';
     Format: '$1-$2';
     LeadingDigitsOffset: 56; LeadingDigitsCount: 3;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 59; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '01 $1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d{3})(\d{2})(\d{5})';
     Format: '$2 $3';
     LeadingDigitsOffset: 60; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '01 $1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: '$2 $3'),
    { MX }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 61; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '01 $1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 62; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '01 $1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d)(\d{2})(\d{4})(\d{4})';
     Format: '045 $2 $3 $4';
     LeadingDigitsOffset: 63; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '$1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: '$1 $2 $3 $4'),
    { MX }
    (Pattern: '(\d)(\d{3})(\d{3})(\d{4})';
     Format: '045 $2 $3 $4';
     LeadingDigitsOffset: 64; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '$1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: '$1 $2 $3 $4'),
    { NZ }
    (Pattern: '(\d)(\d{3})(\d{4})';
     Format: '$1-$2 $3';
     LeadingDigitsOffset: 65; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { NZ }
    (Pattern: '(\d)(\d{3})(\d{3,5})';
     Format: '$1-$2 $3';
     LeadingDigitsOffset: 66; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { NZ }
    (Pattern: '(\d{3})(\d{3})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 67; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { PL }
    (Pattern: '(\d{2})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { RE }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { SG }
    (Pattern: '(\d{4})(\d{4})';
     Format: '$1 $2';
     LeadingDigitsOffset: 68; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { SG }
    (Pattern: '(\d{4})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 69; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { SG }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 17; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { US }
    (Pattern: '(\d{3})(\d{4})';
     Format: '$1 $2';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkNotAvailable;
     IntlFormat: ''),
    { US }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { UZ }
    (Pattern: '(\d{2})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 70; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '8 $1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { 001 }
    (Pattern: '(\d{4})(\d{4})';
     Format: '$1 $2';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { 001 }
    (Pattern: '(\d)(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { 001 }
    (Pattern: '(\d)(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: '')
  );

  PhoneMetadataIntlNumberFormats: array[0..11] of TNumberFormatRec = (
    { AR }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2-$3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { AR }
    (Pattern: '(\d{4})(\d{2})(\d{4})';
     Format: '$1 $2-$3';
     LeadingDigitsOffset: 1; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { AR }
    (Pattern: '(\d)(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 2; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: ''),
    { AR }
    (Pattern: '(\d)(\d{4})(\d{2})(\d{4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 3; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: ''),
    { AR }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1-$2-$3';
     LeadingDigitsOffset: 4; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '0$1';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 59; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '01 $1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d{3})(\d{2})(\d{5})';
     Format: '$2 $3';
     LeadingDigitsOffset: 60; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 61; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '01 $1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 62; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '01 $1';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d)(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 63; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: ''),
    { MX }
    (Pattern: '(\d)(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 64; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkExplicit;
     IntlFormat: ''),
    { US }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: True;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: '')
  );

implementation

end.
