unit LibPhoneNumber.AlternateFormats.Data;

{
  GENERATED FILE - DO NOT EDIT.

  Alternate number format table plus its own leadingDigits pattern pool, keyed by country calling code.

  Source:    vendor/libphonenumber/resources/PhoneNumberAlternateFormats.xml
  Commit:    33be5664343676b27761213d8f5500d682568ea7
  Generator: tools/generate_metadata.ps1 (alternate-formats-v1)

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
  AlternateFormatsGeneratorVersion = 'alternate-formats-v1';
  AlternateFormatsSourceFile = 'resources/PhoneNumberAlternateFormats.xml';
  AlternateFormatsSourceCommit = '33be5664343676b27761213d8f5500d682568ea7';

  AlternateFormatsGroupCount = 46;
  AlternateFormatsNumberFormatCount = 158;
  AlternateFormatsLeadingDigitsCount = 79;

  { leadingDigits pool of THIS data set. It is indexed by the
    LeadingDigitsOffset of AlternateFormatsNumberFormats only - never by an
    offset out of the phone metadata, and vice versa. }
  AlternateFormatsLeadingDigits: array[0..78] of string = (
    '[3489]|7(?:1(?:[0-356]2|4[29]|7|8[27])|2(?:1[23]|[2-9]2))',
    '[3489]|72(?:6|7[457])|7(?:12|2[49])[35]|7(?:1[13-58]|2[1-38])[3-5]|7(?:1[06]|25)[3-6]',
    '7(?:1|2(?:[1-689]|7[2457]))',
    '[3489]|7(?:[04-9]|1(?:04|[236]3|4[3-5]|5[34])|2(?:13|34|7[39]))',
    '[3489]',
    '86[1-9]',
    '21',
    '1[035]|2[0346]|3[03568]|4[0356]|5[0358]|7|8[4578]|91',
    '1[16-8]|2[259]|3[124]|4[17-9]|5[124679]',
    '[4-7]|80[367]|90[12589]|[89][1-8]',
    '9(?:0[12589]|[1-8])',
    '1',
    '0(?:[13-579][2-46-8]|8[236-8])',
    '5[079]',
    '(?:31|4)6|51|6(?:485|5[0-3579]|[6-9])|7(?:20|32|8)|[89]',
    '2|3(?:1[1-578]|[3-68])|4[2378]|5[2-6]|6(?:[12]|4(?:[135-7]|8[34])|5[468])|7(?:2[1-8]|35|[4-79])',
    '20',
    '1(?:1|[2-69]1)|20|[389]|7(?:[1-57-9]|624)',
    '1(?:[2-69][02-9]|[78])|3|7(?:[1-57-9]|624)',
    '8',
    '3[02]|40|[68]9',
    '2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:0|3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1' +
       '256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-' +
       '489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|' +
       '8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|4[01]|50|6[09]|7(?:0|8[02-5]|9[03-' +
       '7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6]|9)|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1' +
       '468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-7' +
       '9]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9' +
       '[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]',
    '2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]' +
       '|[68][1-8])1',
    '2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[125' +
       '6]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-48' +
       '9]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[' +
       '136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])' +
       '|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|' +
       '3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[' +
       '4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4]' +
       ')[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]',
    '2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[125' +
       '6]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-48' +
       '9]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[' +
       '136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|66[2-9]|7(?:1[2-9]|8[02-5]|9[03-7' +
       '])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-8]0|(?:45|84)[02-6]|3(?:83|9' +
       '9)[1468]|3[68]4[1347]|3(?:47|60)[1356]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[13' +
       '57]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(' +
       '?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]',
    '2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[125' +
       '6]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-48' +
       '9]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[' +
       '136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|7(?:8[02-5]|9[03-7])|8(?:3[02-46-' +
       '9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-7]0|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4' +
       '[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3' +
       '[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9' +
       ']|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]',
    '2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[125' +
       '6]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-48' +
       '9]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|3[1468]|6|7[' +
       '1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]|9[1468]))|4(?:1|5[02-6]|9[2-6]' +
       ')|7(?:8[02-5]|9[03-7])|8(?:3[02-46-9]|4[02-6]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-' +
       '7]0|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79' +
       ']|3[4579]3[1357]|(?:28|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4' +
       '])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]',
    '15[1279]|2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257' +
       '-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6' +
       '(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7' +
       '[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]' +
       '|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|9' +
       '9)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[' +
       '02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|' +
       '82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]',
    '3(?:3(?:0[589]|2[03]|3[369]|4[357]|6[0357]|7[0346]|8[347]|9[236-8])|4(?:4[2469]|6[03579]|9[0257]' +
       ')|5(?:0[235]|2[046]|[49][357]|6[09]|7[2579]|8[2479])|6(?:2[05]|3[37]|6[02459]|7[03468]|8[47]|9[2' +
       '46])|7(?:2[09]|4[236]|60|75)|8(?:2[0239]|3[023579]|7[23589]|8[2457])|9(?:0[03568]|3[24689]|4[025' +
       '8]|60|7[2457]|8[23568]|9[23579]))|3[68]4[2568]|3(?:47|60)[2478]|3[49]2[02469]|3[457]3[2468]',
    '15[1279]',
    '1[67]|800',
    '800',
    '900',
    '180',
    '33|5[56]|81',
    '[24679]|3[0-2457-9]|5[089]|8[02-46-9]',
    '2(?:[23]02|6(?:[25]|4[6-8])|9(?:[02356]|4[02568]|72|8[23]))|3(?:3[28]|4(?:[04-79]|3[5-8]|8[2379]' +
       ')|5(?:[2467]|3[237]|8[2-5])|7[1-578]|8(?:[2469]|3[2578]|5[4-8]|7[36-8]|8[5-8]))|2(?:2[24-9]|3[1-' +
       '59]|47)',
    '9(?:2(?:2[024-9]|3[0-59]|47|6[245]|9[02-8])|3(?:3[28]|4[03-9]|5[2-46-8]|7[1-578]|8[2-9]))',
    '[12467]|3[1-578]|5[13-5]|[89][1-9]',
    '[2378]',
    '2[124]|[36]1',
    '8[1-35-9]',
    '[3467]|9[2-9]',
    '[89]0',
    '2',
    '(?:12|57|99)0',
    '1[26]|6',
    '2[48]',
    '[2-4]|5(?:[02-9]|1[06])',
    '512|[89]',
    '160[01]|6(?:[09]|2(?:[02-7]|8[0-35-9])|4[02-9]|5[02-689]|6[024-9]|7[0235-9]|8[124-9])|7(?:[0247]' +
       '|3[025-9]|6(?:[02-9]|1[0-257-9])|8[0-79]|9(?:[07-9]|31))|8(?:0(?:[01589]|6[67]|7[02-9])|1[0-57-9' +
       ']|2[235-9]|3[03-57-9]|[45]|6[02457-9]|7[1-69]|8(?:[0-25-9]|4[0147-9])|9(?:[02-9]|1[0-27-9]))|9|[' +
       '67]1[013-9]|(?:63|75)[02-46-9]|6(?:29|35)[0-46-9]|(?:6(?:[2-4]1|5[17]|6[13]|7[14]|80)|7(?:12|88)' +
       ')[0189]|(?:612|7(?:3[134]|5[15])|8(?:16|2[014]|3[126]|6[136]|7[078]|83))[017-9]',
    '79(?:[07-9]|31)|80(?:[01589]|6[67]|7[02-9])',
    '7(?:1[013-9]|[247]|3[025-9]|5[02-46-9]|6(?:[02-9]|1[0-257-9])|8[0-79])|8(?:1[0-57-9]|2[235-9]|3[' +
       '03-57-9]|[45]|6[02457-9]|7[1-69]|8(?:[0-25-9]|4[0147-9])|9(?:[02-9]|1[0-27-9]))|7(?:12|88)[0189]' +
       '|(?:7(?:3[134]|5[15])|8(?:16|2[014]|3[126]|6[136]|7[078]|83))[017-9]',
    '7(?:1(?:[013-9]|2[0189])|[247]|3[025-9]|5[02-46-9]|6(?:[02-9]|1[0-257-9]))|80(?:[01589]|6[67]|7[' +
       '02-9])|7(?:3[134]|5[15])[017-9]',
    '[1-689]',
    '7',
    '92',
    '[67]',
    '2[12]',
    '2[12]|9',
    '9',
    '[2568][1-8]|3(?:0[1-9]|[1-9])|9',
    '[12]0[1-9]|4|1[3-9]|29|50|7[15]',
    '8|98',
    '6',
    '[4-79]',
    '22|[367]',
    '[38]9|4[45][0-5]|5(?:0|6(?:3[14-7]|7))|6(?:[12][018]|[36-8])|7|9[1-9]|(?:48|57)[0137-9]',
    '[16]|2[0-24-7]|3[0-8]|(?:2[389]|39)[2-9]',
    '1|2[0-24-7]|3[0-8]|(?:2[389]|39)[2-9]',
    '[2-69]|7[67]',
    '3[289]|4|61|7[1-3]|8[1-36]',
    '2[14-68]|3[26-9]|4[1246-8]|6(?:1|75)|7[1-35]|8[1-36]',
    '2[279]|3[13-5]|4[359]|5[1-5]|6(?:[34]|7[1-46-8])|7[46-8]|85',
    '[5-9]',
    '5',
    '[2-489]',
    '32',
    '[348]'
  );

  { National formats only; the alternate formats data set has no
    international format list, and its consumer
    (PhoneNumberMatcher.checkNumberGroupingIsValid) reads
    getNumberFormatList() alone. IntlFormatKind is therefore
    ifkInheritedFromNational throughout. }
  AlternateFormatsNumberFormats: array[0..157] of TNumberFormatRec = (
    { cc=7 }
    (Pattern: '(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=7 }
    (Pattern: '(\d{5})(\d{5})';
     Format: '$1 $2';
     LeadingDigitsOffset: 1; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=7 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 2; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=7 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 3; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=7 }
    (Pattern: '(\d{3})(\d)(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 3; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=7 }
    (Pattern: '(\d{4})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 4; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=27 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 5; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=30 }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 6; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=31 }
    (Pattern: '(\d{2})(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 7; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=31 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 8; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=34 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 9; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=34 }
    (Pattern: '(\d{2})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 10; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=36 }
    (Pattern: '(\d)(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 11; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=36 }
    (Pattern: '(\d{2})(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=39 }
    (Pattern: '(\d{4})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 12; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=39 }
    (Pattern: '(\d{4})(\d{2})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 12; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d)(\d{3})(\d{2})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 11; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d)(\d{4,6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d)(\d{7,8})';
     Format: '$1 $2';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{2})(\d{6,7})';
     Format: '$1 $2';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d)(\d{9,12})';
     Format: '$1 $2';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2})(\d{2,4})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{2})(\d{5})(\d{4,6})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 13; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{3})(\d{3})(\d{3})(\d{3,4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 14; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 14; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 14; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=43 }
    (Pattern: '(\d{4})(\d{3})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 15; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=44 }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 16; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=44 }
    (Pattern: '(\d{3})(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 17; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=44 }
    (Pattern: '(\d{2})(\d{4})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 16; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=44 }
    (Pattern: '(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 18; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=44 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 19; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{3})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 20; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 21; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{4})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 20; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{3})(\d{2})(\d{1,2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 20; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{3})(\d{3})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 20; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d)(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5 $6';
     LeadingDigitsOffset: 20; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{3})(\d{2,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{4})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{1,2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{2})(\d)';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{3})(\d{3})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 22; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{3})(\d{1,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 23; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 24; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{2})(\d)(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 24; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{2})(\d)(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5 $6';
     LeadingDigitsOffset: 23; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5 $6';
     LeadingDigitsOffset: 25; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{4})(\d{1,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 23; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 26; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{2})(\d{3})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 27; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 23; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{2})(\d{2})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 23; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{5})(\d{3})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 28; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{5})(\d{4})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 28; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{5})(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 28; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 29; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 29; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{8})';
     Format: '$1 $2';
     LeadingDigitsOffset: 29; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{3})(\d{3})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 29; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{3})(\d{3})(\d)';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 30; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{2,3})(\d{3})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 30; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 31; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 31; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d{6})(\d{2})(\d{1,4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 31; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d)(\d{3})(\d{3,4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 32; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d)(\d{4})(\d{3,4})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 32; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{3})(\d)(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 33; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{4,6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 33; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 33; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=49 }
    (Pattern: '(\d{4})(\d{4,10})';
     Format: '$1 $2';
     LeadingDigitsOffset: 32; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=52 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 34; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=52 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 35; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=54 }
    (Pattern: '(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 36; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=54 }
    (Pattern: '(\d)(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 37; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=55 }
    (Pattern: '(\d{2})(\d{8})';
     Format: '$1 $2';
     LeadingDigitsOffset: 38; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=58 }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=61 }
    (Pattern: '(\d{4})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=61 }
    (Pattern: '(\d{4})(\d{6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=61 }
    (Pattern: '(\d)(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=61 }
    (Pattern: '(\d)(\d{8})';
     Format: '$1 $2';
     LeadingDigitsOffset: 39; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=62 }
    (Pattern: '(\d{2})(\d{3,4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 40; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=62 }
    (Pattern: '(\d{2})(\d{3})(\d{5})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 40; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=62 }
    (Pattern: '(\d{2})(\d{2})(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 40; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=62 }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 41; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=62 }
    (Pattern: '(\d{3})(\d{3})(\d{5,6})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 19; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=62 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 19; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=64 }
    (Pattern: '(\d)(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 42; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=64 }
    (Pattern: '(\d{3})(\d{3})(\d{2})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 43; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=66 }
    (Pattern: '(\d{4})(\d{4})';
     Format: '$1 $2';
     LeadingDigitsOffset: 44; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=81 }
    (Pattern: '(\d{3})(\d{2})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 45; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=81 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 45; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=81 }
    (Pattern: '(\d{3})(\d{4})(\d{2})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 45; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=84 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 46; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=84 }
    (Pattern: '(\d{2})(\d{2})(\d{3})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 47; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=84 }
    (Pattern: '(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 11; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=90 }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 48; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=90 }
    (Pattern: '(\d{3})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 49; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=91 }
    (Pattern: '(\d{2})(\d{2})(\d{6})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 50; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=91 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 50; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=91 }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 51; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=91 }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 52; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=91 }
    (Pattern: '(\d{4})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 53; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=94 }
    (Pattern: '(\d{2})(\d)(\d{6})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 54; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=94 }
    (Pattern: '(\d{3})(\d{6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 54; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=94 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 55; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=95 }
    (Pattern: '(\d)(\d{4})(\d{5})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 56; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=255 }
    (Pattern: '(\d{2})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 57; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=255 }
    (Pattern: '(\d{2})(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 57; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=350 }
    (Pattern: '(\d{4})(\d{4})';
     Format: '$1 $2';
     LeadingDigitsOffset: 44; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=351 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 58; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=351 }
    (Pattern: '(\d{2})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 59; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=351 }
    (Pattern: '(\d{2})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 60; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=352 }
    (Pattern: '(\d{2})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 16; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=358 }
    (Pattern: '(\d)(\d{3})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 61; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=358 }
    (Pattern: '(\d{2})(\d{3})(\d{3,4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 62; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=358 }
    (Pattern: '(\d)(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 61; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=359 }
    (Pattern: '(\d)(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 44; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=359 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 63; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=359 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 63; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=372 }
    (Pattern: '(\d)(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 64; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=372 }
    (Pattern: '(\d{2})(\d{2})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 65; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=372 }
    (Pattern: '(\d{2})(\d{3})(\d{2})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 65; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=373 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 66; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=373 }
    (Pattern: '(\d{2})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 57; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=380 }
    (Pattern: '(\d{2})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 67; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=380 }
    (Pattern: '(\d{2})(\d{2})(\d{3})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 67; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=381 }
    (Pattern: '(\d{2})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 68; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=381 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 69; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=381 }
    (Pattern: '(\d{2})(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 64; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=385 }
    (Pattern: '(\d)(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 11; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=385 }
    (Pattern: '(\d)(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 11; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=385 }
    (Pattern: '(\d{2})(\d{2})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 70; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=385 }
    (Pattern: '(\d{2})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 64; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=505 }
    (Pattern: '(\d)(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 44; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=506 }
    (Pattern: '(\d{4})(\d{2})(\d{2})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=595 }
    (Pattern: '(\d{2})(\d{2})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 71; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=595 }
    (Pattern: '(\d{2})(\d{6,7})';
     Format: '$1 $2';
     LeadingDigitsOffset: 72; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=595 }
    (Pattern: '(\d{3})(\d{6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 73; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=675 }
    (Pattern: '(\d{3})(\d{2})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 55; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=676 }
    (Pattern: '(\d{2})(\d{5})';
     Format: '$1 $2';
     LeadingDigitsOffset: 74; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=679 }
    (Pattern: '(\d{2})(\d{3})(\d{2})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 55; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=855 }
    (Pattern: '(\d{2})(\d{2})(\d{2})(\d{2,3})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=856 }
    (Pattern: '(\d{3})(\d{3})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=856 }
    (Pattern: '(\d{2})(\d{4})(\d{4})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=856 }
    (Pattern: '(\d{2})(\d{8})';
     Format: '$1 $2';
     LeadingDigitsOffset: 0; LeadingDigitsCount: 0;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=971 }
    (Pattern: '(\d{2})(\d{4})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 75; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=972 }
    (Pattern: '(\d)(\d{3})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 76; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=995 }
    (Pattern: '(\d{3})(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 77; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=995 }
    (Pattern: '(\d{2})(\d)(\d{2})(\d{2})(\d{2})';
     Format: '$1 $2 $3 $4 $5';
     LeadingDigitsOffset: 77; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=995 }
    (Pattern: '(\d{3})(\d{6})';
     Format: '$1 $2';
     LeadingDigitsOffset: 78; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=995 }
    (Pattern: '(\d{3})(\d{3})(\d{3})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 78; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=995 }
    (Pattern: '(\d{2})(\d{2})(\d{3})(\d{2})';
     Format: '$1 $2 $3 $4';
     LeadingDigitsOffset: 77; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: ''),
    { cc=995 }
    (Pattern: '(\d{5})(\d{2})(\d{2})';
     Format: '$1 $2 $3';
     LeadingDigitsOffset: 77; LeadingDigitsCount: 1;
     NationalPrefixFormattingRule: '';
     NationalPrefixOptionalWhenFormatting: False;
     DomesticCarrierCodeFormattingRule: '';
     IntlFormatKind: ifkInheritedFromNational;
     IntlFormat: '')
  );

  { Country calling code groups, ascending by calling code. }
  AlternateFormatsGroups: array[0..45] of TAlternateFormatGroupRec = (
    (CountryCode: 7; FormatOffset: 0; FormatCount: 6),
    (CountryCode: 27; FormatOffset: 6; FormatCount: 1),
    (CountryCode: 30; FormatOffset: 7; FormatCount: 1),
    (CountryCode: 31; FormatOffset: 8; FormatCount: 2),
    (CountryCode: 34; FormatOffset: 10; FormatCount: 2),
    (CountryCode: 36; FormatOffset: 12; FormatCount: 2),
    (CountryCode: 39; FormatOffset: 14; FormatCount: 2),
    (CountryCode: 43; FormatOffset: 16; FormatCount: 13),
    (CountryCode: 44; FormatOffset: 29; FormatCount: 5),
    (CountryCode: 49; FormatOffset: 34; FormatCount: 41),
    (CountryCode: 52; FormatOffset: 75; FormatCount: 2),
    (CountryCode: 54; FormatOffset: 77; FormatCount: 2),
    (CountryCode: 55; FormatOffset: 79; FormatCount: 1),
    (CountryCode: 58; FormatOffset: 80; FormatCount: 1),
    (CountryCode: 61; FormatOffset: 81; FormatCount: 4),
    (CountryCode: 62; FormatOffset: 85; FormatCount: 6),
    (CountryCode: 64; FormatOffset: 91; FormatCount: 2),
    (CountryCode: 66; FormatOffset: 93; FormatCount: 1),
    (CountryCode: 81; FormatOffset: 94; FormatCount: 3),
    (CountryCode: 84; FormatOffset: 97; FormatCount: 3),
    (CountryCode: 90; FormatOffset: 100; FormatCount: 2),
    (CountryCode: 91; FormatOffset: 102; FormatCount: 5),
    (CountryCode: 94; FormatOffset: 107; FormatCount: 3),
    (CountryCode: 95; FormatOffset: 110; FormatCount: 1),
    (CountryCode: 255; FormatOffset: 111; FormatCount: 2),
    (CountryCode: 350; FormatOffset: 113; FormatCount: 1),
    (CountryCode: 351; FormatOffset: 114; FormatCount: 3),
    (CountryCode: 352; FormatOffset: 117; FormatCount: 1),
    (CountryCode: 358; FormatOffset: 118; FormatCount: 3),
    (CountryCode: 359; FormatOffset: 121; FormatCount: 3),
    (CountryCode: 372; FormatOffset: 124; FormatCount: 3),
    (CountryCode: 373; FormatOffset: 127; FormatCount: 2),
    (CountryCode: 380; FormatOffset: 129; FormatCount: 2),
    (CountryCode: 381; FormatOffset: 131; FormatCount: 3),
    (CountryCode: 385; FormatOffset: 134; FormatCount: 4),
    (CountryCode: 505; FormatOffset: 138; FormatCount: 1),
    (CountryCode: 506; FormatOffset: 139; FormatCount: 1),
    (CountryCode: 595; FormatOffset: 140; FormatCount: 3),
    (CountryCode: 675; FormatOffset: 143; FormatCount: 1),
    (CountryCode: 676; FormatOffset: 144; FormatCount: 1),
    (CountryCode: 679; FormatOffset: 145; FormatCount: 1),
    (CountryCode: 855; FormatOffset: 146; FormatCount: 1),
    (CountryCode: 856; FormatOffset: 147; FormatCount: 3),
    (CountryCode: 971; FormatOffset: 150; FormatCount: 1),
    (CountryCode: 972; FormatOffset: 151; FormatCount: 1),
    (CountryCode: 995; FormatOffset: 152; FormatCount: 6)
  );

implementation

end.
