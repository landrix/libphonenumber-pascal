program PhoneNumbersFpcRuntime;

{
  FreePascal RUNTIME gate driver (tools/run_fpc_runtime_check.ps1).

  The FreePascal compile check proves that the FPC clean units of src/ COMPILE
  with FreePascal; it never executes them, and the DUnitX suite is Delphi only.
  This program closes that gap without a second test framework: ONE source,
  compiled by Delphi and by FreePascal, walks the same deterministic inputs
  through the same library calls and writes one canonical line per
  observation. The gate script runs both builds and compares the two output
  files byte for byte. The Delphi build is the reference - it is the build the
  DUnitX suite and the mass differential vouch for - so every line that
  differs is a FreePascal behaviour difference of the port.

  Nothing in here is an expectation. Every input is derived from data the units
  themselves carry (the example numbers of the generated metadata, the short
  number examples, the territory attributes) or is a fixed list of strings
  taken from the test suite (the tricky inputs, the matcher texts and
  contexts). The rest comes from one plain text input file the gate script
  generates on every run: the AsYouTypeFormatter corpus and the mobileDialing /
  keepingAlphaChars sections of tests/data/aytf_reference_cases.json, and the
  inputs of the reference corpus tests/data/reference_cases_java_csharp.json.

  Scope: exactly the units of the FPC compile gate (the list in
  tools/check_fpc_compile.ps1; the count is in the AGENTS.md manifest). Since
  the facade (LibPhoneNumber.PhoneNumberUtil.pas) and the matcher are FreePascal clean,
  that includes the parse driver, isNumberMatch, the record based formatters,
  the getExampleNumber family and findNumbers: every example number is parsed
  back (Parse and ParseAndKeepRawInput, every record field) and found in
  sentences, the tricky inputs and the reference corpus go through the parse
  driver in several regions, and the matcher texts run under all four
  leniencies - on the production AND on the testing metadata.

  Output encoding
  ---------------
  ASCII only, LF line ends, written through a byte stream rather than a text
  file, so neither a console code page nor the RTL's text file encoding can
  make the two builds differ. The streams are memory streams saved to disk
  once at the end (also after an exception, so a partial file can be
  inspected): written line by line, the WSL build spent most of its run time
  in single writes to the Windows file system behind /mnt. Every field is escaped: a code unit outside
  U+0020..U+007E, the backslash and the field separator '|' are written as
  \uXXXX (UTF-16 code units, so a surrogate pair is two escapes). Library
  results of type `string` are widened to UnicodeString before they are
  escaped; on Delphi that is the identity, on FreePascal it decodes the UTF-8
  AnsiString.

  String code page on FreePascal
  ------------------------------
  On FreePascal in Delphi mode `string` is an AnsiString, and every non ASCII
  input reaches the library through it. The units widen such a parameter to
  UnicodeString before they look at it, which is only lossless when the
  conversion between the two is: the program therefore sets the multi byte
  conversion code page to UTF-8 (the Lazarus convention) and, on Unix, links
  cwstring. Without cwstring the RTL's default widestring manager maps every
  non ASCII character onto '?' - that is a property of the FreePascal RTL on
  Unix that every Unicode aware FPC program has to deal with, not of the port,
  and it is documented as a usage requirement in KNOWN_ISSUES.md.

  RTL character data
  ------------------
  UNWANTED_END_CHARS is defined by the OPEN Unicode general categories L and
  N, and the port deliberately asks the RTL for them (see IsUnicodeLetterAt in
  LibPhoneNumber.MetadataCore) - exactly like upstream, which inherits
  them from whatever Unicode version its JDK implements. Delphi and
  FreePascal ship different Unicode versions, so the two builds legitimately
  disagree about code points assigned in between. That sweep is therefore
  written to a SECOND file, which the gate script compares and REPORTS on
  every run (the differing ranges are printed) without failing over it. The
  character classes the port spells out itself - Nd, VALID_PUNCTUATION, the
  plus characters, the vanity dial pad - stay in the compared file.

  Usage: PhoneNumbersFpcRuntime <input-file> <output-file> <rtl-output-file>
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
  Classes,
{$ELSE}
  System.SysUtils,
  System.Classes,
{$ENDIF}
  { The data model only; listed so every unit of the FPC compile gate list is part of the build. }
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.Regex,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.MetadataFormat,
  LibPhoneNumber.AsYouTypeFormatter,
  LibPhoneNumber.ShortMetadata,
  LibPhoneNumber.ShortNumberInfo,
  LibPhoneNumber.TestingMetadata,
  LibPhoneNumber.AlternateFormats,
  LibPhoneNumber.PhoneNumberUtil,
  LibPhoneNumber.PhoneNumberMatcher;

const
  DescKindNames: array[TPhoneNumberDescKind] of string = (
    'generalDesc', 'fixedLine', 'mobile', 'tollFree', 'premiumRate',
    'sharedCost', 'personalNumber', 'voip', 'pager', 'uan', 'voicemail',
    'noInternationalDialling');

  ShortKindNames: array[TShortNumberDescKind] of string = (
    'generalDesc', 'standardRate', 'shortCode', 'carrierSpecific',
    'emergency', 'tollFree', 'premiumRate', 'smsServices');

  FormatNames: array[TMetadataPhoneNumberFormat] of string = (
    'E164', 'INTERNATIONAL', 'NATIONAL', 'RFC3966');

  HexDigits: array[0..15] of AnsiChar = '0123456789ABCDEF';

  { Regions the out of country formatters are called from: one with a single
    IDD (US), two with a national prefix and different IDDs (DE, GB), one with
    a two digit national destination code habit (JP), one with a preferred
    international prefix (AU) and one with a waiting tone in its preferred
    prefix data set elsewhere (SG). }
  CallingFromRegions: array[0..5] of string = ('US', 'DE', 'GB', 'JP', 'AU', 'SG');

  { Tricky inputs of the metadata free parse helpers, mostly taken from
    tests/LibPhoneNumber.MetadataCore.Tests.pas. Every non ASCII code
    unit - and the backslash - is spelled <U+XXXX> and decoded at run time
    (see Decode), so this source stays pure ASCII and its encoding is never
    load bearing on either compiler. }
  TrickyInputs: array[0..136] of string = (
    'Tel: 650 253 0000',
    '*1234',
    'abc-def',
    '650 253 0000...',
    '650 253 0000)',
    '650 253 0000#',
    '650 253 0000 x',
    '(530) 583-6985 x302/x2303',
    '(530) 583-6985 x302<U+005C>x2303',
    '(530) 583-6985 x302/ x2303',
    '530 583 6985/X2303',
    '12',
    '1',
    '',
    '1-2',
    '<U+FF11><U+FF12>',
    '123',
    '1-2 3',
    '+1 650 253 0000',
    '++1 650 253 0000',
    '800-FLOWERS',
    '1-800-FLOWERS',
    '1 800 MY APPLE',
    '1*2*3',
    '1A2B3C',
    '+1+1-650-253-0000',
    '+49 351 8338916#',
    '123;ext=45',
    '12;ext=34',
    '+1 650 253 0000;ext=123456789012345678901',
    '+1 650 253 0000;ext=1234',
    '+1 650 253 0000 ext. 1234',
    '+1 650 253 0000 extension: 1234',
    '+1 650 253 0000 xtn 1234',
    '+1 650 253 0000 anexo 1234',
    '+1 650 253 0000 EXT. 1234',
    '+1 650 253 0000 <U+0434><U+043E><U+0431> 1234',
    '+1 650 253 0000 <U+FF45><U+FF58><U+FF54><U+FF4E> 1234',
    '+1 650 253 0000 extensio<U+0301>n 1234',
    '+1 650 253 0000 extensi<U+00F3>n 1234',
    '+1 650 253 0000 x123456789',
    '+1 650 253 0000 x1234567890',
    '+1 650 253 0000#1234',
    '+1 650 253 0000<U+FF03>1234',
    '+1 650 253 0000~1234',
    '+1 650 253 0000<U+FF5E>1234',
    '+1 650 253 0000 int 1234',
    '+1 650 253 0000 <U+FF49><U+FF4E><U+FF54> 1234',
    '+1 650 253 0000 <U+0131>nt 1234',
    '+1 650 253 0000 <U+0130>nt 1234',
    '+1 650 253 0000 e<U+017F>t 1234',
    '+1 650 253 0000 - 503#',
    '+1 650 253 0000,,1234',
    '+1 650 253 0000;1234',
    '+1 650 253 0000,1234',
    '+1 650 253 0000 ext. <U+FF11><U+FF12>',
    '1AEXT234',
    'tel:253-0000;phone-context=+1-650',
    'tel:253-0000;phone-context=+1-650;isub=12345',
    'tel:253-0000;phone-context=',
    'tel:253-0000;phone-context=www.google.com',
    'tel:253-0000;phone-context=google.com.',
    'tel:253-0000;phone-context=1-650',
    'tel:253-0000;phone-context=example-',
    '253-0000;phone-context=+1-650',
    'tel:253-0000;isub=12345;phone-context=+1-650',
    '+1 650 253 0000;isub=12345',
    'tel:+1-650-253-0000;ext=1234',
    'Tel:+1 650 253 0000 ext 1234',
    '<U+FF0B>1 650 253 0000',
    '<U+FF0B><U+FF0B>1 650 253 0000',
    '<U+0666><U+0665><U+0660> <U+0662><U+0665><U+0663> <U+0660><U+0660><U+0660><U+0660>',
    '<U+06F0><U+06F6><U+06F5><U+06F0>',
    '<U+096C><U+096B><U+0966>',
    '<U+FF10><U+FF13>-<U+FF11><U+FF12><U+FF13><U+FF14>-<U+FF15><U+FF16><U+FF17><U+FF18>',
    '+44 (0) 20 7031 3000',
    '020<U+2013>7031<U+2014>3000',
    '650<U+2010>253<U+2011>0000',
    '650<U+3000>253<U+3000>0000',
    '650<U+00AD>253<U+00AD>0000',
    '650<U+30FC>253<U+FF0E>0000',
    '(<U+FF10><U+FF13>) 1234/5678',
    '+800 1234 5678',
    '0011 54 9 11 1234 5678',
    '8~10 123 4567',
    '8<U+301C>10',
    '<U+D835><U+DFCE><U+D835><U+DFCF><U+D835><U+DFD0> 1234',
    '650 253 0000 <U+D83D><U+DE00>',
    '650 253 0000<U+D800>',
    '<U+D800>650 253 0000',
    'ext 1234',
    '<U+00A0>+1 650 253 0000<U+00A0>',
    '+1 (650) 253-0000 x 1234 ',
    '1-650-MY-APPLE ext. 12',
    '+49 (0)30 1234-5678 Durchwahl 9',
    { Parse driver inputs (the facade is part of the gate since it became
      FreePascal clean): the plus run retry, IDD forms, RFC3966 forms, alpha
      numbers, full width forms and inputs every parse must reject. }
    '+01164 3 331 6005',
    '01164 3 331 6005',
    '0064 3 331 6005',
    '+64 3 331 6005',
    '64(0)64123456',
    '03-331 6005 ext 3456',
    'tel:+64-3-331-6005;ext=1234',
    'tel:03-331-6005;phone-context=+64',
    'tel:331-6005;phone-context=+64-3',
    'tel:+64-3-331-6005;isub=12345',
    'tel:03-331-6005;phone-context=+64;a=%A1',
    'tel:03-331-6005;phone-context=abc.nz',
    'tel:03-331-6005;phone-context=;a=1',
    'My number is tel:03-331-6005;phone-context=+64',
    'This is not a phone number',
    '+---',
    '+***',
    '+*******91',
    '+49 0',
    '+0 1234',
    '+210 3456 56789',
    '123456789012345678',
    '+44 2034567890123456789',
    '0044------',
    '0044 1',
    '011',
    '1 800 FLOWERS',
    '+1 800 SIX-FLAG',
    '0800 REPAIR',
    '<U+FF0B><U+FF14><U+FF19> <U+FF13><U+FF10> <U+FF11><U+FF12><U+FF13><U+FF14><U+FF15><U+FF16>',
    '<U+FF10><U+FF13>-<U+FF13><U+FF13><U+FF11> <U+FF16><U+FF10><U+FF10><U+FF15>',
    '(0xx11) 2345-6789',
    '0xx 11 2345-6789',
    '012 3121286979',
    '+52 1 33 1234-5678',
    '044 (33) 1234-5678',
    '+39 02-36618 300',
    '+54 9 343 555 1212',
    '0343 15 555 1212',
    '8 (812) 123-45-67',
    '+7 (812) 123-45-67',
    '0011 61 2 9876 5432'
  );

  { Matcher inputs: every literal text the two matcher test units pass to
    FindNumbers (directly or through their helpers), as KIND|REGION|TEXT. KIND
    C marks a number the upstream suite also searches in context; those are
    run inside every entry of MatcherContexts as well. Spelled like
    TrickyInputs: every non ASCII code unit, the apostrophe and the backslash
    as <U+XXXX>. Inputs only - no expectation is taken over. The last few
    entries are the driver's own (see there). }
  MatcherTexts: array[0..257] of string = (
    'T|US|Call me at 510-748-8230 if it<U+0027>s before 9:30, or on 703-4800500 after 10am.',
    'T|DE|Bitte rufen Sie 030 12345678 oder +49 30 901820 an.',
    'T|US|My number is 650-253-0000 and my fax is 650-253-0001.',
    'T|DE|Rufen Sie mich unter 089 12345678 an oder schreiben Sie.',
    'T|US|My number-415-666-7777',
    'T|US|415-666-7777.Nice day.',
    'T|US|Tel:415-666-7777.',
    'T|US|Tel: 415-666-7777 on Saturdays.',
    'T|US|',
    'T|US|no numbers here at all',
    'T|ZZ|+1 650 253 0000',
    'T|ZZ|650 253 0000',
    'T||+1 650 253 0000',
    'T|US|(650) 253-0000',
    'T|US|(650 253-0000',
    'T|US|650) 253-0000',
    'T|DE|Hotline: +49 (0)30 901820',
    'T|US|(650) 253) 0000',
    'T|US|(650) 2)53-0000',
    'T|US|80.585 [79.964, 81.191]',
    'T|US|80.585 [79.964]',
    'T|US|80.585 ((79.964)',
    'T|US|(80).(585) (79).(9)64',
    'T|US|The date 03/10/2011 is not a number.',
    'T|CA|3/10/1984',
    'T|DE|10/12/82',
    'T|US|2012-01-02 08:00',
    'T|US|2012-01-02 08:00:23',
    'T|US|2012-01-02 08',
    'T|US|Chen Li. VLDB J. 12(3): 211-227 (2003).',
    'T|US|abc8005001234',
    'T|US|8005001234def',
    'T|US|abc415-666-7777def',
    'T|US|x (650) 253-0000',
    'T|US|The number is 650 253 0000$',
    'T|US|The number is 650 253 0000%',
    'T|US|x650-253-0000',
    'T|US|Call 1234567890 now',
    'T|US|Call 650253 0000 now',
    'T|US|Call 650 2530000 now',
    'T|US|Call 650 253 0000 now',
    'T|US|Call 6502530000 now',
    'T|US|Call 65 02 53 00 00 now',
    'T|US|6502530000x12',
    'T|US|6502530000xx12',
    'T|BR|(0xx11) 2345-6789',
    'T|GB|0121/234 5678',
    'T|GB|+44/121/234 5678',
    'T|GB|+44/121/234/5678',
    'T|DE|30 123456',
    'T|DE|89 12345678',
    'T|DE|030 123456',
    'T|DE|089 12345678',
    'T|GB|121/234/5678',
    'T|DE|+49 30 123456',
    'T|US|650 253 0000 ext. 1234',
    'T|US|6502530000 ext. 1234',
    'T|US|650 2530000 ext. 1234',
    'T|US|+1 1 650 253 0000',
    'T|DE|+49 4921 12345',
    'T|DE|+4949211 2345',
    'T|US|Call 650-253-4561 x 1234',
    'T|US|Tel: 650-253-0000 ext. 1234',
    'T|NZ|03 331 6005 ext 3456',
    'T|US|650-253-0000;ext=1234',
    'T|US|(800) 901-3355 ,x 7246433',
    'T|US|(800) 901-3355 , ext 7246433',
    'T|US|12345 - 650-253-0000 is my number.',
    'T|US|12345. 650-253-0000 is my number.',
    'T|US|3324451234 8002341234',
    'T|US|Call 650-253-4561 -- 415-666-7777',
    'T|US|12345 - 650-253-0000',
    'T|US|12345 -  650-253-0000',
    'T|US|12345 99999 650-253-0000',
    'T|US|Call 650-253-4561--415-666-7777',
    'T|US|Call 650-253-4561--455-234-3451',
    'T|US|Call me at 510-748-8230.',
    'T|US|651-234-2345/332-445-1234',
    'T|US|(650) 223 3345 (754) 223 3321',
    'T|US|((650) 253-0000',
    'T|US|650-253-0000//415-666-7777',
    'T|DE|+49 49 21 12345',
    'C|US|12345',
    'C|US|23456789',
    'C|US|234567890112',
    'C|US|650+253+1234',
    'C|US|03/27/2011',
    'C|US|31/8/2011',
    'C|US|1/12/2011',
    'C|US|650x2531234',
    'C|US|2012/01/02 08:00',
    'C|US|20120102 08:00',
    'C|US|2014-04-12 04:04 PM',
    'C|US|2014-04-12 &nbsp;04:04 PM',
    'C|US|2014-04-12  04:04 PM',
    'C|US|7121115678',
    'C|US|1650 x 253 - 1234',
    'C|US|650 x 253 - 1234',
    'C|US|6502531x234',
    'C|GB|(20) 3346 1234',
    'C|US|65 02 53 00 00',
    'C|US|6502 538365',
    'C|US|650//253-1234',
    'C|US|650/253/1234',
    'C|US|9002309. 158',
    'C|US|12 7/8 - 14 12/34 - 5',
    'C|US|12.1 - 23.71 - 23.45',
    'C|US|800 234 1 111x1111',
    'C|US|1979-2011 100',
    'C|DE|+494949-4-94',
    'C|US|<U+FF14><U+FF11><U+FF15><U+FF16><U+FF16><U+FF16><U+FF16>-<U+FF17><U+FF17><U+FF17>',
    'C|US|2012-0102 08',
    'C|AU|1800-1-0-10 22',
    'C|DE|030-3-2 23 12 34',
    'C|DE|03 0 -3 2 23 12 34',
    'C|DE|(0)3 0 -3 2 23 12 34',
    'C|DE|0 3 0 -3 2 23 12 34',
    'C|MX|+52 332 123 23 23',
    'C|US|(415) 6667777',
    'C|US|415-6667777',
    'C|DE|0800-2491234',
    'C|DE|0900-1 123123',
    'C|DE|(0)900-1 123123',
    'C|DE|0 900-1 123123',
    'C|FR|+33 3 34 2312',
    'C|US|<U+FF14><U+FF11><U+FF15><U+FF16><U+FF16><U+FF16><U+FF17><U+FF17><U+FF17><U+FF17>',
    'C|US|<U+FF14><U+FF11><U+FF15>-<U+FF16><U+FF16><U+FF16>-<U+FF17><U+FF17><U+FF17><U+FF17>',
    'C|US|4156667777',
    'C|US|4156667777 x 123',
    'C|US|415-666-7777',
    'C|US|415/666-7777',
    'C|US|415-666-7777 ext. 503',
    'C|US|1 415 666 7777 x 123',
    'C|US|+1 415-666-7777',
    'C|DE|+494949 49',
    'C|DE|+49-49-34',
    'C|DE|+49-4931-49',
    'C|DE|04931-49',
    'C|DE|+49-494949',
    'C|DE|+49-494949 ext. 49',
    'C|DE|+49494949 ext. 49',
    'C|DE|0494949',
    'C|DE|0494949 ext. 49',
    'C|MX|01 (33) 3461 2234',
    'C|MX|(33) 3461 2234',
    'C|AU|1800-10-10 22',
    'C|DE|0900-1 123 123',
    'C|DE|(0)900-1 123 123',
    'C|DE|0 900-1 123 123',
    'C|FR|+33 3 34 23 12',
    'C|NZ|033316005',
    'C|NZ|03-331 6005',
    'C|NZ|03 331 6005',
    'C|NZ|0064 3 331 6005',
    'C|US|01164 3 331 6005',
    'C|US|+64 3 331 6005',
    'C|NZ|64(0)64123456',
    'C|PL|0123/456789',
    'C|US|123-456-7890',
    'C|NZ|+1 (650) 333-6000',
    'C|US|1-650-333-6000',
    'C|SG|0011-650-333-6000',
    'C|SG|0081-650-333-6000',
    'C|SG|0191-650-333-6000',
    'C|PL|0~01-650-333-6000',
    'C|PL|++1 (650) 333-6000',
    'C|SG|<U+FF0B>1 (650) 333-6000',
    'C|SG|<U+FF0B><U+FF11><U+3000><U+FF08><U+FF16><U+FF15><U+FF10><U+FF09><U+3000><U+FF13><U+FF13><U+FF13><U+FF0D><U+FF16><U+FF10><U+FF10><U+FF10>',
    'C|NZ|+39 02-36618 300',
    'C|IT|02-36618 300',
    'C|IT|312 345 678',
    'C|AR|+54 9 343 555 1212',
    'C|AR|0343 15 555 1212',
    'C|AR|+54 9 3715 65 4320',
    'C|AR|03715 15 65 4320',
    'C|AR|+54 11 3797 0000',
    'C|AR|011 3797 0000',
    'C|AR|+54 3715 65 4321',
    'C|AR|03715 65 4321',
    'C|AR|+54 23 1234 0000',
    'C|AR|023 1234 0000',
    'C|AR|(0xx) 123456789',
    'C|AR|(0xx) 123456789 x 1234',
    'C|US|011xx5481429712',
    'C|MX|+52 (449)978-0001',
    'C|MX|01 (449)978-0001',
    'C|MX|(449)978-0001',
    'C|MX|+52 1 33 1234-5678',
    'C|MX|044 (33) 1234-5678',
    'C|MX|045 33 1234-5678',
    'C|ZZ|+64 3 331 6005',
    'C||+64 3 331 6005',
    'C|NZ|03-3316005x3456',
    'C|NZ|03-3316005 int.3456',
    'C|NZ|03 3316005 #3456',
    'C|PL|0~0 1800 7493 524',
    'C|US|(1800) 7493.524',
    'C|PL|0~0 1800 7493 524 ~1234',
    'C|NZ|+44 2034567890x456',
    'C|GB|+44 2034567890x456',
    'C|GB|+44 2034567890 x456',
    'C|GB|+44 2034567890 X456',
    'C|GB|+44 2034567890 X 456',
    'C|GB|+44 2034567890 X  456',
    'C|GB|+44 2034567890  X 456',
    'C|US|(800) 901-3355 x 7246433',
    'C|US|(800) 901-3355 ,extension 7246433',
    'C|US|(800) 901-3355 ext: 7246433',
    'C|NZ|0 3   3 3 1   6 0 0 5',
    'T||Random text body - number is 0331 6005, see you there',
    'T|US|  ',
    'T|US|Random text body - number is foobar, see you there',
    'T||',
    'T|US|<U+D835><U+DC00>650-253-0000',
    'T|US|650-253-0000<U+D835><U+DC00>',
    'T|US|x<U+D835><U+DC00>650-253-0000',
    'T|US|415-666-7777 - 800-443-1223 - 212-443-1223 - 650-443-1223',
    'T|US|(415) 666-7777 (800) 443-1223',
    'T|US|My address is CA 34215 - 415-666-7777 is my number.',
    'T|US|My number is 415 666 7777. 34215 is my zip-code.',
    'T|US|650-253-0000<U+2012>415-666-7777',
    'T|US|650-253-0000<U+2013>415-666-7777',
    'T|US|650-253-0000<U+2015>415-666-7777',
    'T|US|650-253-0000<U+FF0D>415-666-7777',
    'T|US|650-253-0000<U+2028>415-666-7777',
    'T|US|650-253-0000<U+2029>415-666-7777',
    'T|US|650-253-0000<U+0085>415-666-7777',
    'T|US|650-253-0000<U+00A0>415-666-7777',
    'T|US|650-253-0000<U+3000>415-666-7777',
    'T|US|650-253-0000<U+200B>415-666-7777',
    'T|US|Call me at +1 201-555-0123 or (201) 555-0123.',
    'T|DE|Call me at +49 30 123456 or 030 123456.',
    'T|GB|Call me at +44 121 234 5678 or 0121 234 5678.',
    'T|FR|Call me at +33 1 23 45 67 89 or 01 23 45 67 89.',
    'T|IT|Call me at +39 02 1234 5678 or 02 1234 5678.',
    'T|ES|Call me at +34 810 12 34 56 or 810 12 34 56.',
    'T|NL|Call me at +31 10 123 4567 or 010 123 4567.',
    'T|CH|Call me at +41 21 234 56 78 or 021 234 56 78.',
    'T|AT|Call me at +43 1 234567890 or 01 234567890.',
    'T|SE|Call me at +46 8 12 34 56 or 08-12 34 56.',
    'T|PL|Call me at +48 12 345 67 89 or 12 345 67 89.',
    'T|BR|Call me at +55 11 2345-6789 or (11) 2345-6789.',
    'T|AU|Call me at +61 2 1234 5678 or (02) 1234 5678.',
    'T|JP|Call me at +81 3-1234-5678 or 03-1234-5678.',
    'T|CA|Call me at +1 506-234-5678 or (506) 234-5678.',
    'T|MX|Call me at +52 200 123 4567 or 200 123 4567.',
    'T|IN|Call me at +91 74104 10123 or 074104 10123.',
    'T|ZA|Call me at +27 10 123 4567 or 010 123 4567.',
    'T|NZ|Call me at +64 3 234 5678 or 03 234 5678.',
    'T|BE|Call me at +32 12 34 56 78 or 012 34 56 78.',
    'T|DK|Call me at +45 32 12 34 56 or 32 12 34 56.',
    'T|NO|Call me at +47 21 23 45 67 or 21 23 45 67.',
    'T|FI|Call me at +358 13 1234567 or 013 1234567.',
    'T|PT|Call me at +351 21 234 5678 or 21 234 5678.',
    'T|IE|Call me at +353 22 12345 or (022) 12345.',
    { Not from the tests: time stamp candidates behind a NON ASCII lead
      character, so the TIME_STAMPS_SUFFIX lookup behind the candidate is
      only right when the candidate length is counted in UTF-16 code units. }
    'T|US|<U+FF0B>2012-01-02 08:00',
    'T|US|<U+FF08>2012-01-02 08:00:23',
    'T|DE|Am <U+FF0B>2012-01-02 08:00 Uhr'
  );

  { The leading|trailing context pairs of the two matcher test units. }
  MatcherContexts: array[0..44] of string = (
    '|',
    '   |<U+0009>',
    'Hello |',
    '| to call me!',
    'Hi there, call | to reach me!',
    'Hi there, call |, or don<U+0027>t',
    'Hi call|',
    '|forme',
    'Hi call|forme',
    'It<U+0027>s cheap! Call | before 6:30',
    'Call | or +1800-123-4567!',
    'Call me on June 2 at|',
    'As quoted by Alfonso 12-15 (2009), you may call me at |',
    'As quoted by Alfonso et al. 12-15 (2009), you may call me at |',
    'As I said on 03/10/2011, you may call me at |',
    '|, 45 days a year',
    '|;x 7246433',
    'Call |/x12 more',
    'It<U+0027>s only 9.99! Call | to buy',
    'Call me on 21.6.1984 at |',
    'Call me on 06/21 at |',
    'Call me on 21.6. at |',
    'Call me on 06/21/84 at |',
    'abc|def',
    'abc|',
    '|def',
    '<U+00C9>|',
    'e<U+0301>|',
    '$|',
    '|$',
    '<U+00A3>|',
    '<U+00A5>|',
    '|%',
    '$20 |',
    '| 100$',
    '|<U+00C9>',
    '<U+00C9>|.',
    '<U+00C9>| def',
    '<U+6211><U+7684><U+7535><U+8BDD><U+53F7><U+7801><U+662F>|',
    '|<U+662F><U+6211><U+7684><U+7535><U+8BDD><U+53F7><U+7801>',
    '<U+8BF7><U+62E8><U+6253>|<U+6211><U+5728><U+660E><U+5929>',
    'My number-|',
    '|.Nice day.',
    'Tel:|.',
    'Tel: | on Saturdays.'
  );

  { User defined formats for FormatByPattern, applied to every example
    number: one with $NP/$FG, one with a carrier rule, one that matches
    nothing. }
  UserPatternCount = 3;

var
  { The compared observation file, and the RTL character data file (see
    "RTL character data" in the header). }
  GOut: TMemoryStream;
  GRtl: TMemoryStream;
  GLines: Integer;
  GPhoneExamples: array[0..1] of Integer;
  GShortExamples: Integer;
  GAytfSequences: Integer;
  GTrickyInputs: Integer;
  GSweepRanges: Integer;
  GExceptions: Integer;
  GPatternsCompiled: Integer;
  GPatternFailures: Integer;
  GMetadataOverBudget: Integer;
  GMaxExpandedLength: Integer;
  GRegexProbes: Integer;
  GRewriteMismatches: Integer;
  GExpansionProbeFailures: Integer;
  { The facade and matcher sections. }
  GFacadeExamples: array[0..1] of Integer;
  GFacadeTerritories: Integer;
  GParseInputs: Integer;
  GParseSuccesses: Integer;
  GReferenceCases: Integer;
  GMobileDialingCases: Integer;
  GKeepingAlphaCases: Integer;
  GMatcherTexts: Integer;
  GMatcherCalls: Integer;
  GMatchesFound: Integer;

{ ------------------------------------------------------------------
  Output
  ------------------------------------------------------------------ }

function EscapeField(const AValue: UnicodeString): AnsiString;
var
  I, N, C: Integer;
begin
  SetLength(Result, Length(AValue) * 6);
  N := 0;
  for I := 1 to Length(AValue) do
  begin
    C := Ord(AValue[I]);
    if (C >= $20) and (C <= $7E) and (C <> Ord('\')) and (C <> Ord('|')) then
    begin
      Inc(N);
      Result[N] := AnsiChar(C);
    end
    else
    begin
      Result[N + 1] := '\';
      Result[N + 2] := 'u';
      Result[N + 3] := HexDigits[(C shr 12) and $F];
      Result[N + 4] := HexDigits[(C shr 8) and $F];
      Result[N + 5] := HexDigits[(C shr 4) and $F];
      Result[N + 6] := HexDigits[C and $F];
      Inc(N, 6);
    end;
  end;
  SetLength(Result, N);
end;

procedure EmitTo(AStream: TStream; const AFields: array of UnicodeString);
var
  Line: AnsiString;
  I: Integer;
begin
  Line := '';
  for I := 0 to High(AFields) do
  begin
    if I > 0 then
      Line := Line + '|';
    Line := Line + EscapeField(AFields[I]);
  end;
  Line := Line + #10;
  AStream.WriteBuffer(Line[1], Length(Line));
  if AStream = GOut then
    Inc(GLines);
end;

procedure Emit(const AFields: array of UnicodeString);
begin
  EmitTo(GOut, AFields);
end;

{ ------------------------------------------------------------------
  Conversions. Every library result goes through U so the escaping sees
  UTF-16 on both compilers.
  ------------------------------------------------------------------ }

function U(const AValue: string): UnicodeString;
begin
  Result := UnicodeString(AValue);
end;

function I2S(AValue: Integer): UnicodeString;
begin
  Result := UnicodeString(IntToStr(AValue));
end;

function B2S(AValue: Boolean): UnicodeString;
begin
  if AValue then
    Result := 'T'
  else
    Result := 'F';
end;

{ Decodes an ASCII string into UTF-16. Two escape spellings are understood:
  the \uXXXX form of the output format, which the gate script also uses for
  the generated AYTF input file, and the <U+XXXX> form of the inputs in this
  source (a form no editor or tool chain mistakes for an escape it should
  resolve itself). }
function Decode(const AEscaped: string): UnicodeString;
var
  I: Integer;
begin
  Result := '';
  I := 1;
  while I <= Length(AEscaped) do
  begin
    if (AEscaped[I] = '\') and (I + 5 <= Length(AEscaped))
      and (AEscaped[I + 1] = 'u') then
    begin
      Result := Result + WideChar(StrToInt('$' + Copy(AEscaped, I + 2, 4)));
      Inc(I, 6);
    end
    else if (AEscaped[I] = '<') and (I + 7 <= Length(AEscaped))
      and (Copy(AEscaped, I, 3) = '<U+') and (AEscaped[I + 7] = '>') then
    begin
      Result := Result + WideChar(StrToInt('$' + Copy(AEscaped, I + 3, 4)));
      Inc(I, 8);
    end
    else
    begin
      Result := Result + WideChar(Ord(AEscaped[I]));
      Inc(I);
    end;
  end;
end;

function TypesToString(const ATypes: TMetadataNumberTypes): UnicodeString;
var
  T: TMetadataNumberType;
begin
  Result := '';
  for T := Low(TMetadataNumberType) to High(TMetadataNumberType) do
    if T in ATypes then
    begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + U(NumberTypeToString(T));
    end;
end;

function JoinStrings(const AValues: TMetadataStringArray): UnicodeString;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(AValues) do
  begin
    if I > 0 then
      Result := Result + ',';
    Result := Result + U(AValues[I]);
  end;
end;

{ The counted quantifier rewrite of LibPhoneNumber.Regex (the form
  regexpr 0.987 compiles), or APattern itself when it is over budget. }
function Rewritten(const APattern: string): string;
begin
  ExpandCountedQuantifiers(APattern, Result);
end;

{ Counts a disagreement between a result computed with the pattern as given
  and the same result computed with its rewrite. The rewrite must not change
  any answer, so every mismatch is a rewriter defect - and one the
  Delphi-versus-FreePascal comparison alone could not see, because the
  rewriter is the same code in both builds. }
procedure CheckRewrite(const AOriginal, ARewritten: UnicodeString);
begin
  if AOriginal <> ARewritten then
    Inc(GRewriteMismatches);
end;

procedure EmitException(const ASection, AContext: UnicodeString; E: Exception);
begin
  { The class only: messages are RTL specific and would differ for the very
    same failure. }
  Emit(['EXCEPTION', ASection, AContext, U(E.ClassName)]);
  Inc(GExceptions);
end;

{ ------------------------------------------------------------------
  Phone metadata examples (production and testing data set)
  ------------------------------------------------------------------ }

function UserFormats: TUserNumberFormatArray;
begin
  Result := nil;
  SetLength(Result, UserPatternCount);
  Result[0] := MakeUserNumberFormat('(\d{2})(\d{2,3})(\d+)', '$1 $2-$3', [],
    '$NP ($FG)', '');
  Result[1] := MakeUserNumberFormat('(\d{3})(\d+)', '$1/$2', ['[1-9]'],
    '$NP$FG', '$CC $FG');
  Result[2] := MakeUserNumberFormat('(\d)(\d{40})', '$1 $2', [], '', '');
end;

function FormatMatchFlags(AMetadata: PPhoneMetadataRec; AIntl: Boolean;
  const ANumber: string): UnicodeString;
var
  I, Count, LeadingCount: Integer;
  Format: PNumberFormatRec;
  Flags: Integer;
begin
  { Per number format, as one hex digit: bit 0 = the last leadingDigits
    pattern matches a prefix (or there is none), bit 1 = the format pattern
    matches the whole number; bits 2 and 3 are the same two tests with the
    counted quantifier REWRITE of each pattern (see Rewritten), so the rewrite
    regexpr 0.987 needs is verified against every engine. This is the regex
    work chooseFormattingPatternForNumber does, for every format instead of
    only up to the first hit. }
  Result := '';
  if AIntl then
    Count := GetIntlNumberFormatCount(AMetadata)
  else
    Count := GetNumberFormatCount(AMetadata);
  for I := 0 to Count - 1 do
  begin
    if AIntl then
      Format := GetIntlNumberFormat(AMetadata, I)
    else
      Format := GetNumberFormat(AMetadata, I);
    Flags := 0;
    LeadingCount := Format^.LeadingDigitsCount;
    if (LeadingCount = 0) or TryMatchPrefix(
      GetLeadingDigitsPattern(Format, LeadingCount - 1), ANumber) then
      Flags := Flags or 1;
    if TryMatchFull(Format^.Pattern, ANumber) then
      Flags := Flags or 2;
    if (LeadingCount = 0) or TryMatchPrefix(Rewritten(
      GetLeadingDigitsPattern(Format, LeadingCount - 1)), ANumber) then
      Flags := Flags or 4;
    if TryMatchFull(Rewritten(Format^.Pattern), ANumber) then
      Flags := Flags or 8;
    { The rewrite must answer exactly like the pattern as given. }
    CheckRewrite(I2S(Flags and 3), I2S(Flags shr 2));
    Result := Result + WideChar(Ord(HexDigits[Flags]));
  end;
end;

function AlternateFormatFlags(ACountryCode: Integer;
  const ANumber: string): UnicodeString;
var
  I: Integer;
  Format: PNumberFormatRec;
  Leading: string;
begin
  Result := '';
  for I := 0 to GetAlternateFormatCount(ACountryCode) - 1 do
  begin
    Format := GetAlternateFormat(ACountryCode, I);
    Leading := GetAlternateLeadingDigitsPattern(Format, 0);
    if ((Leading = '') or TryMatchPrefix(Leading, ANumber))
      and TryMatchFull(Format^.Pattern, ANumber) then
      Result := Result + '[' + U(FormatNsnUsingPattern(ANumber, Format,
        mpnfNational, '')) + ']'
    else
      Result := Result + '-';
  end;
end;

procedure EmitAytfSequence(const ASection, AContext, ARegion: UnicodeString;
  const AInput: UnicodeString);
var
  Formatter: TAsYouTypeFormatter;
  Fields: array of UnicodeString;
  I: Integer;
begin
  Formatter := TAsYouTypeFormatter.Create(string(ARegion));
  try
    SetLength(Fields, Length(AInput) + 5);
    Fields[0] := ASection;
    Fields[1] := AContext;
    Fields[2] := ARegion;
    Fields[3] := AInput;
    for I := 1 to Length(AInput) do
      Fields[3 + I] := Formatter.InputDigit(AInput[I]);
    Fields[High(Fields)] := 'ndd=' + U(Formatter.ExtractedNationalPrefix);
    Emit(Fields);
  finally
    Formatter.Free;
  end;
  Inc(GAytfSequences);
end;

procedure RunPhoneExample(ASetIndex: Integer; const ASet: string;
  ATerritory: PPhoneMetadataRec; AKind: TPhoneNumberDescKind;
  const ANumber: string);
var
  Region: string;
  CC: Integer;
  N, Work, Carrier, Rest, Idd, Nat: string;
  Ctx: UnicodeString;
  T: TMetadataNumberType;
  F: TMetadataPhoneNumberFormat;
  Fields: array of UnicodeString;
  I: Integer;
  Ok: Boolean;
  Formats: TUserNumberFormatArray;
  Chosen: PNumberFormatRec;
begin
  Region := ATerritory^.Id;
  CC := ATerritory^.CountryCode;
  N := ANumber;
  Ctx := U(ASet) + ':' + U(Region) + ':' + I2S(CC) + ':'
    + U(DescKindNames[AKind]) + ':' + U(N);
  Inc(GPhoneExamples[ASetIndex]);

  try
    { The two description patterns as given versus rewritten. }
    CheckRewrite(
      B2S(TryMatchFull(GetDesc(ATerritory, AKind)^.NationalNumberPattern, N)),
      B2S(TryMatchFull(Rewritten(GetDesc(ATerritory, AKind)^.NationalNumberPattern), N)));
    CheckRewrite(
      B2S(TryMatchFull(GetDesc(ATerritory, pdkGeneralDesc)^.NationalNumberPattern, N)),
      B2S(TryMatchFull(Rewritten(GetDesc(ATerritory, pdkGeneralDesc)^.NationalNumberPattern), N)));
    Emit(['core', Ctx,
      B2S(IsPossibleNumber(CC, N)),
      U(ValidationResultToString(IsPossibleNumberWithReason(CC, N))),
      U(ValidationResultToString(TestNumberLength(N, ATerritory))),
      B2S(IsValidNumber(CC, N)),
      B2S(IsValidNumberForRegion(CC, N, Region)),
      U(NumberTypeToString(GetNumberType(CC, N))),
      U(NumberTypeToString(GetNumberTypeHelper(N, ATerritory))),
      U(GetRegionCodeForNumber(CC, N)),
      B2S(IsNumberGeographical(CC, N)),
      B2S(CanBeInternationallyDialled(CC, N)),
      B2S(IsNumberMatchingDesc(N, GetDesc(ATerritory, AKind))),
      B2S(MatchesNationalNumberPattern(N, GetDesc(ATerritory, AKind))),
      B2S(TryMatchFull(Rewritten(GetDesc(ATerritory, AKind)^.NationalNumberPattern), N)),
      B2S(TryMatchFull(Rewritten(GetDesc(ATerritory, pdkGeneralDesc)^.NationalNumberPattern), N))]);

    SetLength(Fields, 2);
    Fields[0] := 'types';
    Fields[1] := Ctx;
    for T := Low(TMetadataNumberType) to High(TMetadataNumberType) do
    begin
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := U(NumberTypeToString(T)) + '='
        + U(ValidationResultToString(IsPossibleNumberForTypeWithReason(CC, N, T)))
        + '/' + U(ValidationResultToString(TestNumberLengthForType(N, ATerritory, T)))
        + '/' + B2S(IsPossibleNumberForType(CC, N, T))
        + '/' + B2S(IsNumberGeographical(T, CC));
    end;
    Emit(Fields);

    SetLength(Fields, 2);
    Fields[0] := 'format';
    Fields[1] := Ctx;
    for F := Low(TMetadataPhoneNumberFormat) to High(TMetadataPhoneNumberFormat) do
    begin
      SetLength(Fields, Length(Fields) + 2);
      Fields[High(Fields) - 1] := U(FormatNames[F]) + '=' + U(FormatNumber(CC, N, '', F));
      Fields[High(Fields)] := U(FormatNames[F]) + '+ext=' + U(FormatNumber(CC, N, '1234', F));
    end;
    for F := Low(TMetadataPhoneNumberFormat) to High(TMetadataPhoneNumberFormat) do
    begin
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := U(FormatNames[F]) + '/nsn=' + U(FormatNsn(N, ATerritory, F, ''));
    end;
    Emit(Fields);

    SetLength(Fields, 2);
    Fields[0] := 'outOfCountry';
    Fields[1] := Ctx;
    for I := 0 to High(CallingFromRegions) do
    begin
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := U(CallingFromRegions[I]) + '='
        + U(FormatOutOfCountryCallingNumber(CC, N, '', CallingFromRegions[I]));
    end;
    SetLength(Fields, Length(Fields) + 2);
    Fields[High(Fields) - 1] := 'own=' + U(FormatOutOfCountryCallingNumber(CC, N, '', Region));
    Fields[High(Fields)] := 'DE+ext=' + U(FormatOutOfCountryCallingNumber(CC, N, '987', 'DE'));
    Emit(Fields);

    Nat := FormatNumber(CC, N, '', mpnfNational);
    Formats := UserFormats;
    Emit(['carrier', Ctx,
      U(FormatNationalNumberWithCarrierCode(CC, N, '', '15')),
      U(FormatNationalNumberWithCarrierCode(CC, N, '', '')),
      U(FormatNationalNumberWithCarrierCode(CC, N, '12', '321')),
      U(FormatByPattern(CC, N, '', mpnfNational, Formats)),
      U(FormatByPattern(CC, N, '55', mpnfInternational, Formats)),
      I2S(ChooseFormattingPatternForUserFormats(Formats, N))]);

    Emit(['mobile', Ctx,
      U(FormatNumberForMobileDialing(CC, N, '', '', Region, True)),
      U(FormatNumberForMobileDialing(CC, N, '', '', Region, False)),
      U(FormatNumberForMobileDialing(CC, N, '', '', 'US', True)),
      U(FormatNumberForMobileDialing(CC, N, '', '', 'DE', False)),
      U(FormatNumberForMobileDialing(CC, N, Nat, '14', Region, True)),
      U(FormatOutOfCountryKeepingAlphaChars(CC, N, '', Nat, 'US')),
      U(FormatOutOfCountryKeepingAlphaChars(CC, N, '12', Nat, Region)),
      U(FormatOutOfCountryKeepingAlphaChars(CC, N, '', '', 'GB'))]);

    Work := N + '1234567';
    Ok := TruncateTooLongNumber(CC, Work);
    Emit(['accessory', Ctx,
      I2S(GetLengthOfNationalDestinationCode(CC, N, '')),
      I2S(GetLengthOfGeographicalAreaCode(CC, N, '')),
      B2S(Ok), U(Work),
      I2S(ExtractCountryCode(IntToStr(CC) + N, Rest)), U(Rest)]);

    if Region <> NonGeoRegionCode then
    begin
      Work := ATerritory^.NationalPrefix + N;
      Ok := MaybeStripNationalPrefixAndCarrierCode(Work, ATerritory, Carrier);
      SetLength(Fields, 5);
      Fields[0] := 'strip';
      Fields[1] := Ctx;
      Fields[2] := B2S(Ok);
      Fields[3] := U(Work);
      Fields[4] := U(Carrier);
      Work := N;
      Ok := MaybeStripNationalPrefixAndCarrierCode(Work, ATerritory, Carrier);
      SetLength(Fields, 8);
      Fields[5] := B2S(Ok);
      Fields[6] := U(Work);
      Fields[7] := U(Carrier);
      Emit(Fields);
    end;

    Idd := NormalizeDigitsOnly(ATerritory^.PreferredInternationalPrefix);
    if Idd = '' then
      Idd := NormalizeDigitsOnly(ATerritory^.InternationalPrefix);
    Work := Idd + IntToStr(CC) + N;
    Ok := ParsePrefixAsIdd(ATerritory^.InternationalPrefix, Work);
    Emit(['idd', Ctx, U(Idd), B2S(Ok), U(Work)]);

    Chosen := ChooseFormattingPatternForCallingCode(CC, N);
    if Chosen = nil then
      Emit(['choose', Ctx, '-'])
    else
      Emit(['choose', Ctx, U(Chosen^.Pattern), U(Chosen^.Format),
        U(Chosen^.NationalPrefixFormattingRule),
        U(FormatNsnUsingPattern(N, Chosen, mpnfInternational, '')),
        U(FormatNsnUsingPattern(N, Chosen, mpnfNational, '77'))]);

    Emit(['regex', Ctx, FormatMatchFlags(ATerritory, False, N),
      FormatMatchFlags(ATerritory, True, N), AlternateFormatFlags(CC, N)]);

    if Region = NonGeoRegionCode then
      EmitAytfSequence('aytfExample', Ctx, 'ZZ',
        '+' + I2S(CC) + U(N))
    else
    begin
      EmitAytfSequence('aytfExample', Ctx, U(Region),
        U(ATerritory^.NationalPrefix) + U(N));
      EmitAytfSequence('aytfExample', Ctx, U(Region),
        '+' + I2S(CC) + U(N));
    end;
  except
    on E: Exception do
      EmitException('phone', Ctx, E);
  end;
end;

procedure RunPhoneExamples(ASetIndex: Integer; const ASet: string);
var
  TerritoryIndex: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
begin
  Emit(['section', 'phoneExamples', U(ASet), U(MetadataSourceName),
    I2S(GetTerritoryCount)]);
  for TerritoryIndex := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(TerritoryIndex);
    for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
    begin
      Desc := GetDesc(Territory, Kind);
      if (Desc = nil) or (Desc^.ExampleNumber = '') then
        Continue;
      RunPhoneExample(ASetIndex, ASet, Territory, Kind, Desc^.ExampleNumber);
    end;
  end;
end;

{ ------------------------------------------------------------------
  Territory attributes and the compile sweep
  ------------------------------------------------------------------ }

procedure CompileProbe(const APattern: string; var ATotal: Integer;
  var AFailures: UnicodeString; const ALabel: string);
var
  Error, Expanded: string;
begin
  if APattern = '' then
    Exit;
  Inc(ATotal);
  Inc(GPatternsCompiled);
  if not TryCompilePattern(APattern, Error) then
  begin
    { The engine message is engine specific; the failing pattern is not. }
    AFailures := AFailures + '[' + U(ALabel) + ':' + U(APattern) + ']';
    Inc(GPatternFailures);
  end;
  { The counted quantifier rewrite of regexpr 0.987 must fit the budget for
    every metadata pattern by a wide margin, and the rewritten form must
    compile as well. }
  if not ExpandCountedQuantifiers(APattern, Expanded) then
  begin
    AFailures := AFailures + '[overBudget:' + U(ALabel) + ':' + U(APattern) + ']';
    Inc(GMetadataOverBudget);
  end
  else
  begin
    if Length(Expanded) > GMaxExpandedLength then
      GMaxExpandedLength := Length(Expanded);
    if not TryCompilePattern(Expanded, Error) then
    begin
      AFailures := AFailures + '[rewritten:' + U(ALabel) + ':' + U(APattern) + ']';
      Inc(GPatternFailures);
    end;
  end;
end;

procedure RunTerritories(const ASet: string);
var
  TerritoryIndex, I, J, Total: Integer;
  Territory: PPhoneMetadataRec;
  Kind: TPhoneNumberDescKind;
  Desc: PPhoneNumberDescRec;
  Format: PNumberFormatRec;
  Failures: UnicodeString;
  Id: string;
begin
  Emit(['section', 'territories', U(ASet), I2S(GetTerritoryCount),
    I2S(Length(GetSupportedRegions)), I2S(Length(GetSupportedCallingCodes)),
    I2S(Length(GetSupportedGlobalNetworkCallingCodes))]);
  for TerritoryIndex := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(TerritoryIndex);
    Id := Territory^.Id;
    try
      Emit(['territory', U(ASet), U(Id), I2S(Territory^.CountryCode),
        TypesToString(GetSupportedTypesForRegion(Id)),
        TypesToString(GetSupportedTypesForNonGeoEntity(Territory^.CountryCode)),
        B2S(IsNanpaCountry(Id)),
        U(GetNddPrefixForRegion(Id, True)),
        U(GetNddPrefixForRegion(Id, False)),
        U(GetCountryMobileToken(Territory^.CountryCode)),
        U(GetRegionCodeForCountryCode(Territory^.CountryCode)),
        JoinStrings(GetRegionCodesForCountryCode(Territory^.CountryCode)),
        I2S(GetCountryCodeForRegion(Id)),
        B2S(IsSupportedRegion(Id)),
        B2S(IsSupportedCallingCode(Territory^.CountryCode)),
        B2S(IsSupportedGlobalNetworkCallingCode(Territory^.CountryCode)),
        B2S(IsGeoMobileCountryWithoutMobileAreaCodes(Territory^.CountryCode)),
        B2S(IsCountryWithoutNationalPrefixWithAreaCodes(Territory^.CountryCode))]);

      Total := 0;
      Failures := '';
      for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
      begin
        Desc := GetDesc(Territory, Kind);
        if Desc <> nil then
          CompileProbe(Desc^.NationalNumberPattern, Total, Failures,
            DescKindNames[Kind]);
      end;
      for I := 0 to GetNumberFormatCount(Territory) - 1 do
      begin
        Format := GetNumberFormat(Territory, I);
        CompileProbe(Format^.Pattern, Total, Failures, 'format');
        for J := 0 to Format^.LeadingDigitsCount - 1 do
          CompileProbe(GetLeadingDigitsPattern(Format, J), Total, Failures,
            'leadingDigits');
      end;
      for I := 0 to GetIntlNumberFormatCount(Territory) - 1 do
      begin
        Format := GetIntlNumberFormat(Territory, I);
        CompileProbe(Format^.Pattern, Total, Failures, 'intlFormat');
      end;
      CompileProbe(Territory^.NationalPrefixForParsing, Total, Failures,
        'nationalPrefixForParsing');
      CompileProbe(Territory^.InternationalPrefix, Total, Failures,
        'internationalPrefix');
      CompileProbe(Territory^.LeadingDigits, Total, Failures, 'leadingDigits');
      Emit(['compile', U(ASet), U(Id), I2S(Total), Failures]);
    except
      on E: Exception do
        EmitException('territory', U(ASet) + ':' + U(Id), E);
    end;
  end;
end;

procedure RunAlternateFormats;
var
  I, J, Total: Integer;
  Group: PAlternateFormatGroupRec;
  Format: PNumberFormatRec;
  Failures: UnicodeString;
begin
  Emit(['section', 'alternateFormats', I2S(GetAlternateFormatsGroupCount),
    I2S(GetAlternateFormatsTotalFormatCount),
    I2S(GetAlternateFormatsLeadingDigitsCount)]);
  for I := 0 to GetAlternateFormatsGroupCount - 1 do
  begin
    Group := GetAlternateFormatsGroup(I);
    Total := 0;
    Failures := '';
    for J := 0 to GetAlternateFormatCount(Group^.CountryCode) - 1 do
    begin
      Format := GetAlternateFormat(Group^.CountryCode, J);
      CompileProbe(Format^.Pattern, Total, Failures, 'format');
      CompileProbe(GetAlternateLeadingDigitsPattern(Format, 0), Total,
        Failures, 'leadingDigits');
    end;
    Emit(['alternate', I2S(Group^.CountryCode),
      I2S(GetAlternateFormatCount(Group^.CountryCode)), I2S(Total), Failures]);
  end;
end;

{ Every nonempty short number pattern, whether or not its description has an
  example number - the example walk in RunShortNumbers only reaches the ones
  that do. }
procedure RunShortCompileSweep;
var
  TerritoryIndex, Total: Integer;
  Territory: PShortMetadataRec;
  Kind: TShortNumberDescKind;
  Desc: PPhoneNumberDescRec;
  Failures: UnicodeString;
begin
  Emit(['section', 'shortNumberPatterns', I2S(GetShortTerritoryCount)]);
  for TerritoryIndex := 0 to GetShortTerritoryCount - 1 do
  begin
    Territory := GetShortTerritory(TerritoryIndex);
    Total := 0;
    Failures := '';
    for Kind := Low(TShortNumberDescKind) to High(TShortNumberDescKind) do
    begin
      Desc := GetShortDesc(Territory, Kind);
      if Desc <> nil then
        CompileProbe(Desc^.NationalNumberPattern, Total, Failures,
          ShortKindNames[Kind]);
    end;
    Emit(['shortCompile', U(Territory^.Id), I2S(Total), Failures]);
  end;
end;

{ ------------------------------------------------------------------
  Targeted probes of the regex layer, in particular of the counted
  quantifier rewrite (ExpandCountedQuantifiers): full escape atoms, a class
  with a literal leading ']', nested and reluctant repetition, a capturing
  group under a quantifier, and the size budget. Every probe matches the
  pattern as given AND rewritten, so the rewrite is checked against PCRE and
  regexpr 1.x as well, not only on the regexpr 0.987 that needs it.
  ------------------------------------------------------------------ }

{ AExpectedRewrite, when not empty, is the exact rewrite the probe expects;
  a different rewrite counts as an expansion probe failure. }
procedure RegexProbeExpect(const APattern, AInput, AExpectedRewrite: string);
var
  Expanded, Value, ValueRewritten: string;
  Ok, FullOriginal, FullRewritten, PrefixOriginal, PrefixRewritten: Boolean;
  Start, StartRewritten: Integer;
  Shown, AllOriginal, AllRewritten, FirstOriginal, FirstRewritten: UnicodeString;
begin
  Inc(GRegexProbes);
  try
    Ok := ExpandCountedQuantifiers(APattern, Expanded);
    if (AExpectedRewrite <> '') and (Expanded <> AExpectedRewrite) then
      Inc(GExpansionProbeFailures);
    if Length(Expanded) <= 200 then
      Shown := U(Expanded)
    else
      Shown := '<' + I2S(Length(Expanded)) + ' chars>';
    if not TryFindFirst(APattern, AInput, Value, Start) then
    begin
      Value := '-';
      Start := 0;
    end;
    if not TryFindFirst(Expanded, AInput, ValueRewritten, StartRewritten) then
    begin
      ValueRewritten := '-';
      StartRewritten := 0;
    end;
    FullOriginal := TryMatchFull(APattern, AInput);
    FullRewritten := TryMatchFull(Expanded, AInput);
    PrefixOriginal := TryMatchPrefix(APattern, AInput);
    PrefixRewritten := TryMatchPrefix(Expanded, AInput);
    AllOriginal := U(ReplaceAll(APattern, AInput, '<$0|$1>'));
    AllRewritten := U(ReplaceAll(Expanded, AInput, '<$0|$1>'));
    FirstOriginal := U(ReplaceFirst(APattern, AInput, '[$0|$1]'));
    FirstRewritten := U(ReplaceFirst(Expanded, AInput, '[$0|$1]'));

    CheckRewrite(B2S(FullOriginal), B2S(FullRewritten));
    CheckRewrite(B2S(PrefixOriginal), B2S(PrefixRewritten));
    CheckRewrite(U(Value) + '@' + I2S(Start),
      U(ValueRewritten) + '@' + I2S(StartRewritten));
    CheckRewrite(AllOriginal, AllRewritten);
    CheckRewrite(FirstOriginal, FirstRewritten);
    CheckRewrite(I2S(CountCapturingGroups(APattern)),
      I2S(CountCapturingGroups(Expanded)));

    Emit(['regexProbe', U(APattern), U(AInput), B2S(Ok), Shown,
      B2S(FullOriginal), B2S(FullRewritten),
      B2S(PrefixOriginal), B2S(PrefixRewritten),
      U(Value), I2S(Start), U(ValueRewritten), I2S(StartRewritten),
      AllOriginal, AllRewritten, FirstOriginal, FirstRewritten,
      I2S(CountCapturingGroups(APattern))]);
  except
    on E: Exception do
      EmitException('regexProbe', U(APattern), E);
  end;
end;

procedure RegexProbe(const APattern, AInput: string);
begin
  RegexProbeExpect(APattern, AInput, '');
end;

{ AExpectAccepted: whether the rewrite must fit the budget. AExpectedLength:
  the length the result must have (-1: not checked). Over budget the result
  must be the pattern itself, unchanged - that is the fallback the engine
  compiles. }
procedure ExpansionProbe(const APattern: string; AExpectAccepted: Boolean;
  AExpectedLength: Integer);
var
  Expanded: string;
  Ok, Passed: Boolean;
begin
  Inc(GRegexProbes);
  Ok := ExpandCountedQuantifiers(APattern, Expanded);
  Passed := Ok = AExpectAccepted;
  if not Ok then
    Passed := Passed and (Expanded = APattern)
  else
    Passed := Passed and (Length(Expanded) <= ExpansionBudget);
  if AExpectedLength >= 0 then
    Passed := Passed and (Length(Expanded) = AExpectedLength);
  if not Passed then
    Inc(GExpansionProbeFailures);
  Emit(['expansionProbe', U(APattern), B2S(Ok), I2S(Length(Expanded)),
    B2S(Expanded = APattern), B2S(Passed)]);
end;

{ Asserts the exact rewrite of APattern without matching it. }
procedure RewriteProbe(const APattern, AExpectedRewrite: string);
var
  Expanded: string;
  Ok: Boolean;
begin
  Inc(GRegexProbes);
  Ok := ExpandCountedQuantifiers(APattern, Expanded);
  if not Ok or (Expanded <> AExpectedRewrite) then
    Inc(GExpansionProbeFailures);
  Emit(['rewriteProbe', U(APattern), B2S(Ok), U(Expanded),
    B2S(Ok and (Expanded = AExpectedRewrite))]);
end;

procedure RunRegexProbes;
var
  Huge: string;
begin
  Emit(['section', 'regexProbes', I2S(ExpansionBudget)]);
  { Escape atoms are rewritten whole. }
  RegexProbeExpect('\x41{2}', 'AA', '\x41\x41');
  RegexProbe('\x41{2}', 'A1');
  RegexProbe('\x41{2}', 'A11');
  RegexProbeExpect('\x{41}{2}', 'AA', '\x{41}\x{41}');
  RegexProbeExpect('\x{41}{2,3}', 'AAAA', '\x{41}\x{41}(?:\x{41})?');
  { Escape forms TRegExpr 0.987 does not understand itself (\u, \p, octal) or
    that differ between engines are checked as REWRITES only, not matched:
    what matters is that the quantifier stays outside the escape. }
  RewriteProbe('\u0041{2}', '\u0041\u0041');
  RewriteProbe('\p{L}{2}', '\p{L}\p{L}');
  RewriteProbe('\pL{2}', '\pL\pL');
  RewriteProbe('\cJ{2}', '\cJ\cJ');
  RewriteProbe('\012{2}', '\012\012');
  RewriteProbe('\x{263A}{3}', '\x{263A}\x{263A}\x{263A}');
  RegexProbe('\d{3}\x2D\d{2}', '123-45');
  RegexProbe('\.{2}\d', '..5');
  RegexProbe('\({2}', '((');
  { A class with a literal leading ']', and an escaped ']' inside one. }
  RegexProbeExpect('[])]{2}', '])', '[])][])]');
  RegexProbe('[])]{2}', ')]');
  RegexProbe('[])]{2}', ']');
  RegexProbeExpect('[^]a]{2}', 'bc', '[^]a][^]a]');
  RegexProbe('[^]a]{2}', ']c');
  RegexProbeExpect('[\]x]{2}', ']x', '[\]x][\]x]');
  RegexProbeExpect('(?:[)]{2})', '))', '(?:[)][)])');
  RegexProbeExpect('(?:[])]{2})', '])', '(?:[])][])])');
  RegexProbe('(?:a[)(]{2}b)', 'a()b');
  { Nested, open ended and reluctant repetition. }
  RegexProbeExpect('(?:a{2}){2,3}', 'aaaa', '(?:aa)(?:aa)(?:(?:aa))?');
  RegexProbe('(?:a{2}){2,3}', 'aaaaaa');
  RegexProbe('(?:a{2}){2,3}', 'aaaaaaaa');
  RegexProbe('(?:a{2}){2,3}', 'aaa');
  RegexProbeExpect('a{2,}', 'aaaaa', 'aaa*');
  RegexProbe('a{2,}', 'a');
  RegexProbeExpect('a{2,4}?', 'aaaa', 'aa(?:a(?:a)??)??');
  RegexProbe('a{2,4}?b', 'aaaab');
  RegexProbe('\d{2,3}?', '12345');
  RegexProbe('(?:\d{2}|x{3})\d{1,2}', 'xxx12');
  RegexProbe('(\d{3})(\d{3})', '712345');
  RegexProbe('(?:0[1-9]|[1589]\d)\d{4}', '542011');
  RegexProbeExpect('a{0}b', 'b', 'b');
  RegexProbe('a{0,0}b', 'b');
  (* Escaped braces are literals, not a quantifier. (An UNESCAPED brace that
    does not start a quantifier, such as a{x}, is a PatternSyntaxException
    for java.util.regex; PCRE reads it as a literal and TRegExpr rejects it,
    so it is outside the contract and not probed.) *)
  RegexProbeExpect('a\{,2\}', 'a{,2}', 'a\{,2\}');
  RegexProbeExpect('a\{2\}', 'a{2}', 'a\{2\}');
  RegexProbe('a\{2}', 'a{2}');
  { A capturing group under a counted quantifier is NOT copied (it would
    shift the group numbering), so here the rewrite leaves the quantifier. }
  RegexProbeExpect('(\d){3}', '123', '(\d){3}');
  RegexProbe('(?:(\d)x){2}', '1x2x');
  { The budget: a nested repetition far beyond it, a single one just over it,
    one exactly at it and a quantifier number too large for any integer. Over
    budget the ORIGINAL pattern is what gets compiled; these patterns are not
    matched, because whether an engine accepts such a repetition count at all
    is engine specific (PCRE caps it at 65535) and not what is probed here. }
  ExpansionProbe('(?:\d{10000}){10000}', False, -1);
  ExpansionProbe('\d{' + IntToStr(ExpansionBudget) + '}', False, -1);
  ExpansionProbe('\d{' + IntToStr(ExpansionBudget div 2) + '}', True,
    ExpansionBudget);
  ExpansionProbe('\d{' + IntToStr(ExpansionBudget div 2 + 1) + '}', False, -1);
  ExpansionProbe('\d{99999999999999999999}', False, -1);
  ExpansionProbe('(?:\d{100}){327}', False, -1);
  ExpansionProbe('(?:\d{100}){100}', True, 100 * (4 + 200) + 0);
  ExpansionProbe('\d{2}', True, 4);
  Huge := StringOfChar('7', 40);
  RegexProbe('\d{40}', Huge);
  RegexProbe('(?:\d{4}){10}', Huge);
end;

{ ------------------------------------------------------------------
  Metadata free parse helpers over the tricky inputs
  ------------------------------------------------------------------ }

{ The `string` a caller can actually hand in for AWide.

  On FreePascal `string` is a UTF-8 AnsiString here, and UTF-8 cannot carry a
  LONE surrogate: the RTL's UnicodeString to UTF-8 conversion replaces it with
  '?'. That is a property of the string type, not of the port - no FreePascal
  caller can pass such a value through a `string` parameter at all. The driver
  therefore applies the same substitution in BOTH builds before it calls the
  `string` API, so the two builds see the same argument; the raw surrogate
  still reaches every UnicodeString entry point (the code point primitives and
  the AsYouTypeFormatter), which is where it is representable on both. The
  'input' line records the substitution. }
function ToCallerString(const AWide: UnicodeString): string;
var
  Copyable: UnicodeString;
  I: Integer;
begin
  Copyable := AWide;
  for I := 1 to Length(Copyable) do
    if (CodePointLengthAt(Copyable, I) = 1)
      and (CodePointLengthBefore(Copyable, I) = 1)
      and (Ord(Copyable[I]) >= $D800) and (Ord(Copyable[I]) <= $DFFF) then
      Copyable[I] := '?';
  Result := string(Copyable);
end;

procedure RunTrickyInput(const AEscaped: string);
var
  Wide: UnicodeString;
  Value, Work, Ext, Built, Context: string;
  Ok, HasContext: Boolean;
  I, MatchEnd: Integer;
  Starts, Chars: UnicodeString;
begin
  Wide := Decode(AEscaped);
  Value := ToCallerString(Wide);
  Inc(GTrickyInputs);
  try
    Emit(['input', Wide, I2S(Length(Wide)), U(Value), I2S(Length(U(Value)))]);

    Work := Value;
    Ext := MaybeStripExtension(Work);
    Ok := TryBuildNationalNumberForParsing(Value, Built);
    HasContext := TryExtractPhoneContext(Value, Context);
    Emit(['parse', Wide,
      U(ExtractPossibleNumber(Value)),
      B2S(IsViablePhoneNumber(Value)),
      U(Ext), U(Work),
      B2S(Ok), U(Built),
      B2S(HasContext), U(Context),
      B2S(HasContext and IsPhoneContextValid(Context)),
      B2S(IsAlphaNumber(Value)),
      B2S(IsSingleInternationalPrefix(Value)),
      B2S(FormattingRuleHasFirstGroupOnly(Value)),
      B2S(IsFormatEligible(Value)),
      B2S(NationalPrefixHasSeparator(Value))]);

    Emit(['normalize', Wide,
      U(NormalizeDigits(Value, True)),
      U(NormalizeDigits(Value, False)),
      U(NormalizeDigitsOnly(Value)),
      U(NormalizeDiallableCharsOnly(Value)),
      U(ConvertAlphaCharactersInNumber(Value)),
      B2S(IsValidAlphaPhone(Value)),
      U(NormalizeAlphaPhoneOrDigits(Value)),
      U(NormalizeAllPlusNumberGroupingSymbols(Value))]);

    { The code point primitives the matcher shares, at every index. }
    Starts := '';
    Chars := '';
    for I := 1 to Length(Wide) do
    begin
      Chars := Chars + I2S(CodePointLengthAt(Wide, I))
        + I2S(CodePointLengthBefore(Wide, I))
        + B2S(IsUnicodeDecimalDigitAt(Wide, I))
        + B2S(IsUnwantedEndCharBefore(Wide, I)) + ' ';
      if TryMatchExtensionForMatchingAt(Wide, I, Length(Wide), MatchEnd) then
        Starts := Starts + I2S(I) + '>' + I2S(MatchEnd) + ' ';
    end;
    Emit(['codepoints', Wide, Chars, Starts]);

    EmitAytfSequence('aytfTricky', '', 'US', Wide);
    EmitAytfSequence('aytfTricky', '', 'DE', Wide);
  except
    on E: Exception do
      EmitException('tricky', Wide, E);
  end;
end;

procedure RunTrickyInputs;
var
  I: Integer;
begin
  Emit(['section', 'trickyInputs', I2S(Length(TrickyInputs))]);
  for I := 0 to High(TrickyInputs) do
    RunTrickyInput(TrickyInputs[I]);
end;

{ ------------------------------------------------------------------
  Character predicate sweep over the BMP
  ------------------------------------------------------------------ }

type
  TCharFlagsFunc = function(ACode: Integer): UnicodeString;

{ The closed character classes the port spells out itself: the Nd table, the
  punctuation class, the plus characters and the vanity dial pad. These are
  the predicates the Char = AnsiChar trap of FreePascal would break, which is
  why every one of them takes a WideChar. }
function PortCharFlags(ACode: Integer): UnicodeString;
var
  Ch: WideChar;
  Wide: UnicodeString;
begin
  Ch := WideChar(ACode);
  Wide := Ch;
  Result := I2S(UnicodeDecimalDigitValue(Ch)) + ','
    + B2S(IsUnicodeDecimalDigit(Ch))
    + B2S(IsValidPunctuation(Ch))
    + B2S(IsPlusChar(Ch))
    + B2S(IsUnicodeDecimalDigitAt(Wide, 1)) + ','
    + I2S(Ord(MapAlphaCharacterToDigit(Ch)));
end;

{ The open categories L and N behind UNWANTED_END_CHARS, which the port asks
  the RTL for (see IsUnicodeLetterAt in LibPhoneNumber.MetadataCore). A
  lone surrogate is a code point of its own for java.util.regex and for the
  code point helpers, so it is classified like any other. }
function RtlCharFlags(ACode: Integer): UnicodeString;
var
  Wide: UnicodeString;
begin
  Wide := WideChar(ACode);
  Result := B2S(IsUnwantedEndCharBefore(Wide, 1));
end;

{ Walks the BMP and writes one line per run of code points with identical
  flags, so a difference shows up as a moved or split range. }
procedure SweepBmp(AStream: TStream; const ATag: UnicodeString;
  AFlags: TCharFlagsFunc);
var
  Code, RangeStart: Integer;
  Current, Previous: UnicodeString;
begin
  RangeStart := 0;
  Previous := AFlags(0);
  for Code := 1 to $10000 do
  begin
    if Code <= $FFFF then
      Current := AFlags(Code)
    else
      Current := '';
    if Current <> Previous then
    begin
      EmitTo(AStream, [ATag, U(IntToHex(RangeStart, 4)),
        U(IntToHex(Code - 1, 4)), Previous]);
      if AStream = GOut then
        Inc(GSweepRanges);
      RangeStart := Code;
      Previous := Current;
    end;
  end;
end;

procedure RunCharacterSweep;
var
  Supplementary: array[0..7] of Integer;
  I, Cp: Integer;
  Wide: UnicodeString;
begin
  Emit(['section', 'characterSweep']);
  SweepBmp(GOut, 'chars', PortCharFlags);

  EmitTo(GRtl, ['section', 'rtlCharacterCategories']);
  SweepBmp(GRtl, 'rtlChars', RtlCharFlags);

  { A few supplementary code points, as surrogate pairs: a mathematical digit,
    an Osmanya digit, a Deseret letter, an emoji, a musical symbol, a CJK
    extension B ideograph, a tag character and the last code point. The
    surrogate pair arithmetic and the BMP only digit normalisation are the
    port's; whether such a code point is a digit, a letter or a number is the
    RTL's, so that half goes to the RTL file. }
  Supplementary[0] := $1D7CE;
  Supplementary[1] := $104A0;
  Supplementary[2] := $10400;
  Supplementary[3] := $1F600;
  Supplementary[4] := $1D11E;
  Supplementary[5] := $20000;
  Supplementary[6] := $E0041;
  Supplementary[7] := $10FFFF;
  for I := 0 to High(Supplementary) do
  begin
    Cp := Supplementary[I] - $10000;
    Wide := WideChar($D800 + (Cp shr 10)) + WideChar($DC00 + (Cp and $3FF));
    Emit(['supplementary', U(IntToHex(Supplementary[I], 6)),
      I2S(CodePointLengthAt(Wide, 1)), I2S(CodePointLengthBefore(Wide, 2)),
      U(NormalizeDigits(string(Wide), True))]);
    EmitTo(GRtl, ['rtlSupplementary', U(IntToHex(Supplementary[I], 6)),
      B2S(IsUnicodeDecimalDigitAt(Wide, 1)),
      B2S(IsUnwantedEndCharBefore(Wide, 2))]);
  end;
end;

{ ------------------------------------------------------------------
  Short number examples
  ------------------------------------------------------------------ }

procedure RunShortNumbers;
var
  TerritoryIndex: Integer;
  Territory: PShortMetadataRec;
  Kind: TShortNumberDescKind;
  Desc: PPhoneNumberDescRec;
  Region, N: string;
  CC: Integer;
  Cost: TShortNumberCost;
  Fields: array of UnicodeString;
  Ctx: UnicodeString;
begin
  Emit(['section', 'shortNumbers', U(ShortMetadataSourceFileName),
    I2S(GetShortTerritoryCount), I2S(Length(GetShortMetadataRegions))]);
  for TerritoryIndex := 0 to GetShortTerritoryCount - 1 do
  begin
    Territory := GetShortTerritory(TerritoryIndex);
    Region := Territory^.Id;
    CC := GetCountryCodeForRegion(Region);
    try
      SetLength(Fields, 4);
      Fields[0] := 'shortRegion';
      Fields[1] := U(Region);
      Fields[2] := I2S(CC);
      Fields[3] := U(GetExampleShortNumber(Region));
      for Cost := Low(TShortNumberCost) to High(TShortNumberCost) do
      begin
        SetLength(Fields, Length(Fields) + 1);
        Fields[High(Fields)] := U(ShortNumberCostToString(Cost)) + '='
          + U(GetExampleShortNumberForCost(Region, Cost));
      end;
      Emit(Fields);

      for Kind := Low(TShortNumberDescKind) to High(TShortNumberDescKind) do
      begin
        Desc := GetShortDesc(Territory, Kind);
        if (Desc = nil) or (Desc^.ExampleNumber = '') then
          Continue;
        N := Desc^.ExampleNumber;
        Ctx := U(Region) + ':' + I2S(CC) + ':' + U(ShortKindNames[Kind]) + ':' + U(N);
        Inc(GShortExamples);
        Emit(['short', Ctx,
          B2S(IsPossibleShortNumberForRegion(CC, N, Region)),
          B2S(IsPossibleShortNumber(CC, N)),
          B2S(IsValidShortNumberForRegion(CC, N, Region)),
          B2S(IsValidShortNumber(CC, N)),
          U(ShortNumberCostToString(GetExpectedCostForRegion(CC, N, Region))),
          U(ShortNumberCostToString(GetExpectedCost(CC, N))),
          B2S(IsEmergencyNumber(N, Region)),
          B2S(ConnectsToEmergencyNumber(N, Region)),
          B2S(ConnectsToEmergencyNumber(N + '1', Region)),
          B2S(IsEmergencyNumber('+' + IntToStr(CC) + ' ' + N, Region)),
          B2S(IsCarrierSpecific(CC, N)),
          B2S(IsCarrierSpecificForRegion(CC, N, Region)),
          B2S(IsSmsServiceForRegion(CC, N, Region)),
          B2S(IsValidShortNumberForRegion(CC, N, 'US'))]);
      end;
    except
      on E: Exception do
        EmitException('short', U(Region), E);
    end;
  end;
end;

{ ------------------------------------------------------------------
  The facade: parse driver, isNumberMatch, the record based formatters and
  the parse based accessory API (LibPhoneNumber.PhoneNumberUtil)
  ------------------------------------------------------------------ }

const
  ParseErrorNames: array[TPhoneNumberParseError] of string = (
    'NONE', 'NOT_A_NUMBER', 'INVALID_COUNTRY_CODE', 'TOO_SHORT_AFTER_IDD',
    'TOO_SHORT_NSN', 'TOO_LONG');

  CountryCodeSourceNames: array[TCountryCodeSource] of string = (
    'UNSPECIFIED', 'FROM_NUMBER_WITH_PLUS_SIGN', 'FROM_NUMBER_WITH_IDD',
    'FROM_NUMBER_WITHOUT_PLUS_SIGN', 'FROM_DEFAULT_COUNTRY');

  PublicFormatNames: array[TPhoneNumberFormat] of string = (
    'E164', 'INTERNATIONAL', 'INTERNATIONAL_LEGACY', 'NATIONAL', 'RFC3966');

  MatchTypeNames: array[TPhoneNumberMatchType] of string = (
    'NOT_A_NUMBER', 'NO_MATCH', 'SHORT_NSN_MATCH', 'NSN_MATCH', 'EXACT_MATCH');

  LeniencyNames: array[TPhoneNumberLeniency] of string = (
    'POSSIBLE', 'VALID', 'STRICT_GROUPING', 'EXACT_GROUPING');

  { Default regions every tricky input is parsed with: a NANPA region, two
    European regions with a national prefix, NZ (the "+01164" retry case), BR
    (carrier codes), the unknown region, the empty region and a region that
    needs canonicalisation. }
  TrickyParseRegions: array[0..7] of string = (
    'US', 'DE', 'GB', 'NZ', 'BR', 'ZZ', '', ' nz ');

  { Strings every tricky input is compared with through the string overloads
    of isNumberMatch. }
  MatchPartners: array[0..2] of string = (
    '+1 650 253 0000', '650 253 0000', '+64 3 331 6005');

function PhoneFields(const ANumber: TPhoneNumber): UnicodeString;
begin
  Result := I2S(ANumber.CountryCode) + '/' + U(UIntToStr(ANumber.NationalNumber))
    + '/' + U(ANumber.NationalNumberDigits) + '/' + U(ANumber.Extension)
    + '/' + U(ANumber.RawInput) + '/' + U(ANumber.RegionCode)
    + '/' + U(CountryCodeSourceNames[ANumber.CountryCodeSource])
    + '/' + U(ANumber.PreferredDomesticCarrierCode);
end;

{ Everything the facade answers for one parsed number. ARegion is the region
  the number was parsed in; AInput the string it was parsed from. }
procedure EmitParsedNumber(const ASection, ACtx: UnicodeString;
  const ANumber: TPhoneNumber; const AInput, ARegion: string);
var
  Fields: array of UnicodeString;
  F: TPhoneNumberFormat;
  Work: TPhoneNumber;
  Ok: Boolean;
  I: Integer;
begin
  SetLength(Fields, 3);
  Fields[0] := ASection + 'Format';
  Fields[1] := ACtx;
  Fields[2] := U(AInput) + '@' + U(ARegion);
  for F := Low(TPhoneNumberFormat) to High(TPhoneNumberFormat) do
  begin
    SetLength(Fields, Length(Fields) + 1);
    Fields[High(Fields)] := U(PublicFormatNames[F]) + '='
      + U(TPhoneNumberUtil.Format(ANumber, F));
  end;
  SetLength(Fields, Length(Fields) + 2);
  Fields[High(Fields) - 1] := 'byPatternNat=' + U(TPhoneNumberUtil.FormatByPattern(
    ANumber, pnfNational, UserFormats));
  Fields[High(Fields)] := 'byPatternLegacy=' + U(TPhoneNumberUtil.FormatByPattern(
    ANumber, pnfInternationalLegacy, UserFormats));
  Emit(Fields);

  SetLength(Fields, 3);
  Fields[0] := ASection + 'Dial';
  Fields[1] := ACtx;
  Fields[2] := U(AInput) + '@' + U(ARegion);
  for I := 0 to 2 do
  begin
    SetLength(Fields, Length(Fields) + 5);
    Fields[High(Fields) - 4] := 'orig/' + U(CallingFromRegions[I]) + '='
      + U(TPhoneNumberUtil.FormatInOriginalFormat(ANumber, CallingFromRegions[I]));
    Fields[High(Fields) - 3] := 'ooc/' + U(CallingFromRegions[I]) + '='
      + U(TPhoneNumberUtil.FormatOutOfCountryCallingNumber(ANumber, CallingFromRegions[I]));
    Fields[High(Fields) - 2] := 'alpha/' + U(CallingFromRegions[I]) + '='
      + U(TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(ANumber, CallingFromRegions[I]));
    Fields[High(Fields) - 1] := 'mobile/' + U(CallingFromRegions[I]) + '='
      + U(TPhoneNumberUtil.FormatNumberForMobileDialing(ANumber, CallingFromRegions[I], True));
    Fields[High(Fields)] := 'mobileRaw/' + U(CallingFromRegions[I]) + '='
      + U(TPhoneNumberUtil.FormatNumberForMobileDialing(ANumber, CallingFromRegions[I], False));
  end;
  SetLength(Fields, Length(Fields) + 6);
  Fields[High(Fields) - 5] := 'orig/own=' + U(TPhoneNumberUtil.FormatInOriginalFormat(ANumber, ARegion));
  Fields[High(Fields) - 4] := 'alpha/own=' + U(TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(ANumber, ARegion));
  Fields[High(Fields) - 3] := 'mobile/own=' + U(TPhoneNumberUtil.FormatNumberForMobileDialing(ANumber, ARegion, True));
  Fields[High(Fields) - 2] := 'mobileRaw/own=' + U(TPhoneNumberUtil.FormatNumberForMobileDialing(ANumber, ARegion, False));
  Fields[High(Fields) - 1] := 'carrier=' + U(TPhoneNumberUtil.FormatNationalNumberWithCarrierCode(ANumber, '15'));
  Fields[High(Fields)] := 'preferredCarrier=' + U(TPhoneNumberUtil.FormatNationalNumberWithPreferredCarrierCode(ANumber, '15'));
  Emit(Fields);

  Work := ANumber;
  Work.NationalNumberDigits := Work.NationalNumberDigits + '98765';
  Work.NationalNumber := 0;
  Ok := TPhoneNumberUtil.TruncateTooLongNumber(Work);
  Emit([ASection + 'Accessory', ACtx, U(AInput) + '@' + U(ARegion),
    U(TPhoneNumberUtil.GetNationalSignificantNumber(ANumber)),
    B2S(TPhoneNumberUtil.IsNumberGeographical(ANumber)),
    I2S(TPhoneNumberUtil.GetLengthOfGeographicalAreaCode(ANumber)),
    I2S(TPhoneNumberUtil.GetLengthOfNationalDestinationCode(ANumber)),
    B2S(Ok), PhoneFields(Work),
    B2S(TPhoneNumberUtil.IsValidNumber(AInput, ARegion)),
    B2S(TPhoneNumberUtil.IsPossibleNumber(AInput, ARegion)),
    B2S(TPhoneNumberUtil.IsAlphaNumber(AInput))]);

  Emit([ASection + 'Match', ACtx, U(AInput) + '@' + U(ARegion),
    U(MatchTypeNames[TPhoneNumberUtil.IsNumberMatch(ANumber, ANumber)]),
    U(MatchTypeNames[TPhoneNumberUtil.IsNumberMatch(ANumber,
      TPhoneNumberUtil.Format(ANumber, pnfE164))]),
    U(MatchTypeNames[TPhoneNumberUtil.IsNumberMatch(ANumber,
      TPhoneNumberUtil.Format(ANumber, pnfNational))]),
    U(MatchTypeNames[TPhoneNumberUtil.IsNumberMatch(ANumber, AInput)]),
    U(MatchTypeNames[TPhoneNumberUtil.IsNumberMatch(AInput,
      TPhoneNumberUtil.Format(ANumber, pnfInternational))]),
    U(MatchTypeNames[TPhoneNumberUtil.IsNumberMatch(
      TPhoneNumberUtil.Format(ANumber, pnfNational), AInput)])]);
end;

{ Parse and ParseAndKeepRawInput of AInput in ARegion, every record field of
  both, and - when the number parses - everything EmitParsedNumber answers. }
procedure EmitParse(const ASection, ACtx: UnicodeString;
  const AInput, ARegion: string);
var
  Plain, Kept: TPhoneNumber;
  PlainError, KeptError: TPhoneNumberParseError;
  PlainOk, KeptOk: Boolean;
begin
  Inc(GParseInputs);
  try
    PlainOk := TPhoneNumberUtil.Parse(AInput, ARegion, Plain, PlainError);
    KeptOk := TPhoneNumberUtil.ParseAndKeepRawInput(AInput, ARegion, Kept,
      KeptError);
    Emit([ASection, ACtx, U(AInput), U(ARegion),
      B2S(PlainOk), U(ParseErrorNames[PlainError]), PhoneFields(Plain),
      B2S(KeptOk), U(ParseErrorNames[KeptError]), PhoneFields(Kept)]);
    if PlainOk then
      Inc(GParseSuccesses);
    if KeptOk then
      EmitParsedNumber(ASection, ACtx, Kept, AInput, ARegion);
    { The plain record degrades FormatInOriginalFormat to NATIONAL and has no
      raw input for the alpha formatter; that path is observed as well. }
    if PlainOk then
      Emit([ASection + 'Plain', ACtx, U(AInput) + '@' + U(ARegion),
        U(TPhoneNumberUtil.FormatInOriginalFormat(Plain, ARegion)),
        U(TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Plain, 'US')),
        U(TPhoneNumberUtil.FormatNumberForMobileDialing(Plain, ARegion, True))]);
  except
    on E: Exception do
      EmitException(ASection, ACtx + ':' + U(AInput) + '@' + U(ARegion), E);
  end;
end;

{ Digits '0'..'9' replaced by their full width forms U+FF10..U+FF19. }
function FullWidthDigits(const AValue: UnicodeString): UnicodeString;
var
  I: Integer;
begin
  Result := AValue;
  for I := 1 to Length(Result) do
    if (Result[I] >= '0') and (Result[I] <= '9') then
      Result[I] := WideChar($FF10 + Ord(Result[I]) - Ord('0'));
end;

{ ------------------------------------------------------------------
  The matcher (LibPhoneNumber.PhoneNumberMatcher)
  ------------------------------------------------------------------ }

function MatchFields(const AMatch: TPhoneNumberMatch): UnicodeString;
begin
  Result := I2S(AMatch.Start) + '-' + I2S(AMatch.EndIndex) + ':'
    + U(AMatch.RawString) + ':' + PhoneFields(AMatch.Number);
end;

{ FindNumbers over all four leniencies (unlimited tries), plus VALID with a
  try budget of three. AText goes through ToCallerString like every other
  string argument (see there). }
procedure EmitFind(const ASection, ACtx: UnicodeString;
  const AText: UnicodeString; const ARegion: string);
var
  Text: string;
  L: TPhoneNumberLeniency;
  Matches: TPhoneNumberMatchArray;
  Fields: array of UnicodeString;

  procedure AddMatches(const ALabel: UnicodeString);
  var
    J: Integer;
  begin
    SetLength(Fields, Length(Fields) + 1);
    Fields[High(Fields)] := ALabel + '=' + I2S(Length(Matches));
    for J := 0 to High(Matches) do
    begin
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := MatchFields(Matches[J]);
      Inc(GMatchesFound);
    end;
  end;

begin
  Inc(GMatcherTexts);
  Text := ToCallerString(AText);
  try
    SetLength(Fields, 4);
    Fields[0] := ASection;
    Fields[1] := ACtx;
    Fields[2] := U(ARegion);
    Fields[3] := U(Text);
    for L := Low(TPhoneNumberLeniency) to High(TPhoneNumberLeniency) do
    begin
      Matches := FindNumbers(Text, ARegion, L, UnlimitedTries);
      Inc(GMatcherCalls);
      AddMatches(U(LeniencyNames[L]));
    end;
    Matches := FindNumbers(Text, ARegion, pnlValid, 3);
    Inc(GMatcherCalls);
    AddMatches('VALID/3');
    Emit(Fields);
  except
    on E: Exception do
      EmitException(ASection, ACtx + ':' + AText, E);
  end;
end;

{ Splits 'a|b|c' at the first two separators (the text itself may not
  contain one, but nothing relies on that beyond the third field). }
procedure SplitMatcherEntry(const AEntry: string; out AKind, ARegion: string;
  out AText: UnicodeString);
var
  P1, P2: Integer;
begin
  P1 := Pos('|', AEntry);
  P2 := P1 + 1;
  while (P2 <= Length(AEntry)) and (AEntry[P2] <> '|') do
    Inc(P2);
  AKind := Copy(AEntry, 1, P1 - 1);
  ARegion := Copy(AEntry, P1 + 1, P2 - P1 - 1);
  AText := Decode(Copy(AEntry, P2 + 1, MaxInt));
end;

procedure RunMatcherTexts(const ASet: string);
var
  I, J, P: Integer;
  Kind, Region: string;
  Text, Leading, Trailing: UnicodeString;
  Context: string;
  Repeated: UnicodeString;
begin
  Emit(['section', 'matcherTexts', U(ASet), I2S(Length(MatcherTexts)),
    I2S(Length(MatcherContexts))]);
  for I := 0 to High(MatcherTexts) do
  begin
    SplitMatcherEntry(MatcherTexts[I], Kind, Region, Text);
    EmitFind('find', U(ASet) + ':text', Text, Region);
    if Kind = 'C' then
      for J := 0 to High(MatcherContexts) do
      begin
        Context := MatcherContexts[J];
        P := Pos('|', Context);
        Leading := Decode(Copy(Context, 1, P - 1));
        Trailing := Decode(Copy(Context, P + 1, MaxInt));
        EmitFind('findInContext', U(ASet) + ':' + I2S(J), Leading + Text + Trailing,
          Region);
      end;
  end;

  { The try budget texts of the upstream suite (testMaxMatches*): long inputs
    built by repetition. }
  Repeated := '';
  for I := 1 to 100 do
    Repeated := Repeated + 'My info: 415-666-7777,';
  EmitFind('findRepeated', U(ASet) + ':maxMatches', Repeated, 'US');
  Repeated := '';
  for I := 1 to 10 do
    Repeated := Repeated + 'My address 949-8945-0';
  for I := 1 to 100 do
    Repeated := Repeated + 'My info: 415-666-7777,';
  EmitFind('findRepeated', U(ASet) + ':maxMatchesInvalid', Repeated, 'US');
  Repeated := '';
  for I := 1 to 100 do
    Repeated := Repeated + 'My info: 415-666-7777 123 fake street';
  EmitFind('findRepeated', U(ASet) + ':maxMatchesMixed', Repeated, 'US');
end;

{ ------------------------------------------------------------------
  Per example number: parse it back, and find it in sentences
  ------------------------------------------------------------------ }

procedure RunFacadeExample(ASetIndex: Integer; const ASet: string;
  ATerritory: PPhoneMetadataRec; AKind: TPhoneNumberDescKind;
  const ANumber: string);
var
  Region, Intl, Nat, E164: string;
  CC: Integer;
  Ctx: UnicodeString;
begin
  Region := ATerritory^.Id;
  CC := ATerritory^.CountryCode;
  Ctx := U(ASet) + ':' + U(Region) + ':' + I2S(CC) + ':'
    + U(DescKindNames[AKind]) + ':' + U(ANumber);
  Inc(GFacadeExamples[ASetIndex]);
  try
    E164 := '+' + IntToStr(CC) + ANumber;
    Intl := FormatNumber(CC, ANumber, '', mpnfInternational);
    Nat := FormatNumber(CC, ANumber, '', mpnfNational);
    if Region = NonGeoRegionCode then
    begin
      EmitParse('parseExample', Ctx, E164, 'ZZ');
      EmitParse('parseExample', Ctx, Intl, 'US');
      EmitFind('findExample', Ctx, 'Call ' + U(Intl) + ' now.', 'ZZ');
      EmitFind('findExample', Ctx, U(E164) + U(', fax ') + FullWidthDigits(U(Intl)), 'DE');
    end
    else
    begin
      EmitParse('parseExample', Ctx, ANumber, Region);
      EmitParse('parseExample', Ctx, Nat, Region);
      EmitParse('parseExample', Ctx, Intl, 'ZZ');
      if ATerritory^.NationalPrefix <> '' then
        EmitParse('parseExample', Ctx, ATerritory^.NationalPrefix + ANumber,
          Region);
      EmitFind('findExample', Ctx, 'Call ' + U(Nat) + ' now.', Region);
      EmitFind('findExample', Ctx, 'Tel: ' + U(Intl) + ', fax ' + U(E164) + ' x12',
        'ZZ');
      EmitFind('findExample', Ctx, 'Nr. ' + FullWidthDigits(U(Nat)) + '.', Region);
    end;
  except
    on E: Exception do
      EmitException('facadeExample', Ctx, E);
  end;
end;

procedure RunFacadeExamples(ASetIndex: Integer; const ASet: string);
var
  TerritoryIndex: Integer;
  Kind: TPhoneNumberDescKind;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
begin
  Emit(['section', 'facadeExamples', U(ASet), U(MetadataSourceName)]);
  for TerritoryIndex := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(TerritoryIndex);
    for Kind := Low(TPhoneNumberDescKind) to High(TPhoneNumberDescKind) do
    begin
      Desc := GetDesc(Territory, Kind);
      if (Desc = nil) or (Desc^.ExampleNumber = '') then
        Continue;
      RunFacadeExample(ASetIndex, ASet, Territory, Kind, Desc^.ExampleNumber);
    end;
  end;
end;

{ The getExampleNumber family per region, per non geographical entity and per
  type. }
procedure RunFacadeTerritories(const ASet: string);
var
  Regions: TMetadataStringArray;
  CallingCodes: TMetadataIntegerArray;
  I: Integer;
  T: TMetadataNumberType;
  Number: TPhoneNumber;
  Ok: Boolean;
  Fields: array of UnicodeString;
begin
  Regions := GetSupportedRegions;
  CallingCodes := GetSupportedGlobalNetworkCallingCodes;
  Emit(['section', 'facadeTerritories', U(ASet), I2S(Length(Regions)),
    I2S(Length(CallingCodes))]);
  for I := 0 to High(Regions) do
  begin
    Inc(GFacadeTerritories);
    try
      SetLength(Fields, 3);
      Fields[0] := 'exampleNumbers';
      Fields[1] := U(ASet);
      Fields[2] := U(Regions[I]);
      Ok := TPhoneNumberUtil.TryGetExampleNumber(LowerCase(Regions[I]), Number);
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := 'example=' + B2S(Ok) + PhoneFields(Number);
      for T := Low(TMetadataNumberType) to High(TMetadataNumberType) do
      begin
        Ok := TPhoneNumberUtil.TryGetExampleNumberForType(Regions[I], T, Number);
        SetLength(Fields, Length(Fields) + 1);
        Fields[High(Fields)] := U(NumberTypeToString(T)) + '=' + B2S(Ok)
          + PhoneFields(Number);
      end;
      Ok := TPhoneNumberUtil.TryGetInvalidExampleNumber(Regions[I], Number);
      SetLength(Fields, Length(Fields) + 2);
      Fields[High(Fields) - 1] := 'invalid=' + B2S(Ok) + PhoneFields(Number);
      Fields[High(Fields)] := 'types='
        + TypesToString(TPhoneNumberUtil.GetSupportedTypesForRegion(' ' + Regions[I]));
      Emit(Fields);
    except
      on E: Exception do
        EmitException('facadeTerritory', U(ASet) + ':' + U(Regions[I]), E);
    end;
  end;
  for I := 0 to High(CallingCodes) do
  begin
    Inc(GFacadeTerritories);
    try
      Ok := TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(CallingCodes[I],
        Number);
      Emit(['nonGeoExample', U(ASet), I2S(CallingCodes[I]), B2S(Ok),
        PhoneFields(Number),
        TypesToString(TPhoneNumberUtil.GetSupportedTypesForNonGeoEntity(
          CallingCodes[I])),
        U(TPhoneNumberUtil.GetCountryMobileToken(CallingCodes[I]))]);
    except
      on E: Exception do
        EmitException('facadeNonGeo', U(ASet) + ':' + I2S(CallingCodes[I]), E);
    end;
  end;
  SetLength(Fields, 2);
  Fields[0] := 'exampleForType';
  Fields[1] := U(ASet);
  for T := Low(TMetadataNumberType) to High(TMetadataNumberType) do
  begin
    Ok := TPhoneNumberUtil.TryGetExampleNumberForType(T, Number);
    SetLength(Fields, Length(Fields) + 1);
    Fields[High(Fields)] := U(NumberTypeToString(T)) + '=' + B2S(Ok)
      + PhoneFields(Number);
  end;
  Emit(Fields);
  Ok := TPhoneNumberUtil.TryGetExampleNumberForNonGeoEntity(1, Number);
  Emit(['nonGeoExample', U(ASet), '1', B2S(Ok), PhoneFields(Number)]);
  Ok := TPhoneNumberUtil.TryGetExampleNumber('001', Number);
  Emit(['exampleNumbers', U(ASet), '001', B2S(Ok), PhoneFields(Number)]);
  Ok := TPhoneNumberUtil.TryGetInvalidExampleNumber('XX', Number);
  Emit(['exampleNumbers', U(ASet), 'XX', B2S(Ok), PhoneFields(Number)]);
end;

{ The tricky inputs through the parse driver, in every region of
  TrickyParseRegions, plus the string overloads of isNumberMatch. }
procedure RunParseTricky(const ASet: string);
var
  I, J: Integer;
  Wide, Long: UnicodeString;
  Value: string;
  Fields: array of UnicodeString;
begin
  Emit(['section', 'parseTricky', U(ASet), I2S(Length(TrickyInputs)),
    I2S(Length(TrickyParseRegions))]);
  for I := 0 to High(TrickyInputs) do
  begin
    Wide := Decode(TrickyInputs[I]);
    Value := ToCallerString(Wide);
    for J := 0 to High(TrickyParseRegions) do
      EmitParse('parseTricky', U(ASet), Value, TrickyParseRegions[J]);
    try
      SetLength(Fields, 3);
      Fields[0] := 'matchTricky';
      Fields[1] := U(ASet);
      Fields[2] := U(Value);
      for J := 0 to High(MatchPartners) do
      begin
        SetLength(Fields, Length(Fields) + 2);
        Fields[High(Fields) - 1] := U(MatchTypeNames[
          TPhoneNumberUtil.IsNumberMatch(Value, MatchPartners[J])]);
        Fields[High(Fields)] := U(MatchTypeNames[
          TPhoneNumberUtil.IsNumberMatch(MatchPartners[J], Value)]);
      end;
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := U(MatchTypeNames[
        TPhoneNumberUtil.IsNumberMatch(Value, Value)]);
      Emit(Fields);
    except
      on E: Exception do
        EmitException('matchTricky', U(Value), E);
    end;
    EmitFind('findTricky', U(ASet), U(Value), 'US');
    EmitFind('findTricky', U(ASet), 'Ruf an: ' + U(Value) + ' bitte', 'DE');
  end;

  { MAX_INPUT_STRING_LENGTH is counted in UTF-16 code units. Inputs just
    below and just above it, ASCII and non ASCII; a non ASCII input of 100
    code units is 300 bytes of UTF-8 on FreePascal and must still be parsed. }
  Long := '+1 650 253 0000';
  while Length(Long) < 250 do
    Long := Long + ' ';
  EmitParse('parseLong', U(ASet), ToCallerString(Long), 'US');
  EmitParse('parseLong', U(ASet), ToCallerString(Long + ' '), 'US');
  Long := '+1 650 253 0000';
  while Length(Long) < 100 do
    Long := Long + WideChar($3000);
  EmitParse('parseLong', U(ASet), ToCallerString(Long), 'US');
  Long := FullWidthDigits('+1 650 253 0000');
  while Length(Long) < 250 do
    Long := Long + WideChar($3000);
  EmitParse('parseLong', U(ASet), ToCallerString(Long), 'US');
  EmitParse('parseLong', U(ASet), ToCallerString(Long + WideChar($3000)), 'US');
  Long := '';
  for I := 1 to 40 do
    Long := Long + WideChar($FF0B);
  EmitParse('parseLong', U(ASet), ToCallerString(Long + '64 3 331 6005'), 'NZ');
end;

{ ------------------------------------------------------------------
  Records of the input file beyond the AYTF corpus: the reference corpus and
  the two oracle anchored formatter sections of the AYTF JSON.
  ------------------------------------------------------------------ }

procedure RunReferenceRecord(const AFields: TMetadataStringArray);
begin
  { ref|<country>|<input>|<name> }
  Inc(GReferenceCases);
  EmitParse('reference', Decode(AFields[3]), ToCallerString(Decode(AFields[2])),
    AFields[1]);
end;

procedure RunMobileDialingRecord(const AFields: TMetadataStringArray);
var
  Input: string;
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Ok: Boolean;
begin
  { mobile|<region>|<regionCallingFrom>|<withFormatting T/F>|<keepRawInput T/F>|<input> }
  Inc(GMobileDialingCases);
  Input := ToCallerString(Decode(AFields[5]));
  if AFields[4] = 'T' then
    Ok := TPhoneNumberUtil.ParseAndKeepRawInput(Input, AFields[1], Number, Error)
  else
    Ok := TPhoneNumberUtil.Parse(Input, AFields[1], Number, Error);
  Emit(['mobileDialing', U(AFields[1]), U(AFields[2]), U(AFields[3]),
    U(AFields[4]), U(Input), B2S(Ok), U(ParseErrorNames[Error]),
    PhoneFields(Number),
    U(TPhoneNumberUtil.FormatNumberForMobileDialing(Number, AFields[2],
      AFields[3] = 'T'))]);
end;

procedure RunKeepingAlphaRecord(const AFields: TMetadataStringArray);
var
  Input: string;
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Ok: Boolean;
begin
  { alpha|<region>|<regionCallingFrom>|<rawInput> }
  Inc(GKeepingAlphaCases);
  Input := ToCallerString(Decode(AFields[3]));
  Ok := TPhoneNumberUtil.ParseAndKeepRawInput(Input, AFields[1], Number, Error);
  Emit(['keepingAlphaChars', U(AFields[1]), U(AFields[2]), U(Input), B2S(Ok),
    U(ParseErrorNames[Error]), PhoneFields(Number),
    U(TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number,
      AFields[2])),
    U(TPhoneNumberUtil.FormatInOriginalFormat(Number, AFields[2]))]);
end;

{ ------------------------------------------------------------------
  AsYouTypeFormatter corpus (generated from aytf_reference_cases.json)
  ------------------------------------------------------------------ }

function SplitFields(const ALine: string): TMetadataStringArray;
var
  I, Start: Integer;
begin
  Result := nil;
  Start := 1;
  for I := 1 to Length(ALine) + 1 do
    if (I > Length(ALine)) or (ALine[I] = '|') then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := Copy(ALine, Start, I - Start);
      Start := I + 1;
    end;
end;

function IndexInList(AIndex: Integer; const AList: string): Boolean;
var
  Items: TMetadataStringArray;
  I: Integer;
  Copyable: string;
begin
  Result := False;
  Copyable := AList;
  for I := 1 to Length(Copyable) do
    if Copyable[I] = ',' then
      Copyable[I] := '|';
  Items := SplitFields(Copyable);
  for I := 0 to High(Items) do
    if (Items[I] <> '') and (StrToInt(Items[I]) = AIndex) then
    begin
      Result := True;
      Exit;
    end;
end;

procedure RunAytfRemember(const ARegion: string; const AInput: UnicodeString;
  const AIndices: string);
var
  Formatter: TAsYouTypeFormatter;
  Fields: array of UnicodeString;
  I: Integer;
  Output: UnicodeString;
begin
  Formatter := TAsYouTypeFormatter.Create(ARegion);
  try
    SetLength(Fields, 4);
    Fields[0] := 'aytfRemember';
    Fields[1] := U(ARegion);
    Fields[2] := AInput;
    Fields[3] := U(AIndices);
    for I := 1 to Length(AInput) do
    begin
      if IndexInList(I - 1, AIndices) then
        Output := Formatter.InputDigitAndRememberPosition(AInput[I])
      else
        Output := Formatter.InputDigit(AInput[I]);
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := Output + ' @' + I2S(Formatter.GetRememberedPosition);
    end;
    Emit(Fields);
  finally
    Formatter.Free;
  end;
  Inc(GAytfSequences);
end;

procedure RunAytfClear(const ARegion: string; const AFirst,
  ASecond: UnicodeString);
var
  Formatter: TAsYouTypeFormatter;
  Fields: array of UnicodeString;
  I: Integer;
begin
  Formatter := TAsYouTypeFormatter.Create(ARegion);
  try
    SetLength(Fields, 4);
    Fields[0] := 'aytfClear';
    Fields[1] := U(ARegion);
    Fields[2] := AFirst;
    Fields[3] := ASecond;
    for I := 1 to Length(AFirst) do
    begin
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := Formatter.InputDigit(AFirst[I]);
    end;
    Formatter.Clear;
    SetLength(Fields, Length(Fields) + 1);
    Fields[High(Fields)] := '<clear>';
    for I := 1 to Length(ASecond) do
    begin
      SetLength(Fields, Length(Fields) + 1);
      Fields[High(Fields)] := Formatter.InputDigit(ASecond[I]);
    end;
    Emit(Fields);
  finally
    Formatter.Free;
  end;
  Inc(GAytfSequences);
end;

var
  { The records of the input file, read once (see RunInputFile). }
  GInputLines: TMetadataStringArray;

procedure ReadInputFile(const APath: string);
var
  Input: TextFile;
  Line: string;
begin
  GInputLines := nil;
  AssignFile(Input, APath);
  Reset(Input);
  try
    while not Eof(Input) do
    begin
      ReadLn(Input, Line);
      if (Line = '') or (Line[1] = '#') then
        Continue;
      SetLength(GInputLines, Length(GInputLines) + 1);
      GInputLines[High(GInputLines)] := Line;
    end;
  finally
    CloseFile(Input);
  end;
end;

{ AFacade = False runs the AsYouTypeFormatter records (seq, remember, clear,
  smoke), True the records that start from a parsed number (ref, mobile,
  alpha). A record kind outside both groups is an error of the gate script. }
procedure RunInputFile(AFacade: Boolean);
var
  I, Count: Integer;
  Line: string;
  Fields: TMetadataStringArray;
  IsFacadeRecord: Boolean;
begin
  Count := 0;
  if AFacade then
    Emit(['section', 'facadeCorpus'])
  else
    Emit(['section', 'aytfCorpus']);
  for I := 0 to High(GInputLines) do
  begin
    Line := GInputLines[I];
    Fields := SplitFields(Line);
    IsFacadeRecord := (Fields[0] = 'ref') or (Fields[0] = 'mobile')
      or (Fields[0] = 'alpha');
    if IsFacadeRecord <> AFacade then
      Continue;
    Inc(Count);
    try
      if (Fields[0] = 'seq') or (Fields[0] = 'smoke') then
        EmitAytfSequence(U(Fields[0]), '', U(Fields[1]), Decode(Fields[2]))
      else if Fields[0] = 'remember' then
        RunAytfRemember(Fields[1], Decode(Fields[2]), Fields[3])
      else if Fields[0] = 'clear' then
        RunAytfClear(Fields[1], Decode(Fields[2]), Decode(Fields[3]))
      else if Fields[0] = 'ref' then
        RunReferenceRecord(Fields)
      else if Fields[0] = 'mobile' then
        RunMobileDialingRecord(Fields)
      else if Fields[0] = 'alpha' then
        RunKeepingAlphaRecord(Fields)
      else
        raise Exception.Create('Unknown input record: ' + Line);
    except
      on E: Exception do
        EmitException('input', U(Line), E);
    end;
  end;
  if AFacade then
    Emit(['facadeCorpusRecords', I2S(Count)])
  else
    Emit(['aytfCorpusRecords', I2S(Count)]);
end;

{ ------------------------------------------------------------------
  Main
  ------------------------------------------------------------------ }

begin
  try
{$IFDEF FPC}
    { See "String code page on FreePascal" in the header. }
    SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
    if ParamCount <> 3 then
      raise Exception.Create('Usage: PhoneNumbersFpcRuntime <input-file> <output-file> <rtl-output-file>');

    GOut := TMemoryStream.Create;
    GRtl := TMemoryStream.Create;
    try
      Emit(['libphonenumber-pascal runtime observations']);
      Emit(['provenance', U(MetadataVersion), U(MetadataUpstreamCommit),
        U(ShortMetadataVersion), U(AlternateFormatsVersion),
        U(TestingMetadataVersion)]);

      RunPhoneExamples(0, 'production');
      RunTerritories('production');
      RunAlternateFormats;
      RunRegexProbes;
      RunTrickyInputs;
      RunCharacterSweep;
      RunShortNumbers;
      RunShortCompileSweep;
      ReadInputFile(ParamStr(1));
      RunInputFile(False);

      { The facade and the matcher (production metadata). }
      RunFacadeExamples(0, 'production');
      RunFacadeTerritories('production');
      RunParseTricky('production');
      RunInputFile(True);
      RunMatcherTexts('production');

      UseTestingMetadata;
      try
        RunPhoneExamples(1, 'testing');
        RunTerritories('testing');
        { The parse and matcher sections again, on the data set the upstream
          PhoneNumberUtilTest and PhoneNumberMatcherTest run against. The
          alternate formats stay on production, like upstream. }
        RunFacadeExamples(1, 'testing');
        RunFacadeTerritories('testing');
        RunParseTricky('testing');
        RunMatcherTexts('testing');
      finally
        RestoreProductionMetadata;
      end;

      Emit(['summary',
        'productionExamples=' + I2S(GPhoneExamples[0]),
        'testingExamples=' + I2S(GPhoneExamples[1]),
        'shortExamples=' + I2S(GShortExamples),
        'trickyInputs=' + I2S(GTrickyInputs),
        'aytfSequences=' + I2S(GAytfSequences),
        'sweepRanges=' + I2S(GSweepRanges),
        'patternsCompiled=' + I2S(GPatternsCompiled),
        'patternFailures=' + I2S(GPatternFailures),
        'metadataPatternsOverBudget=' + I2S(GMetadataOverBudget),
        'maxRewrittenLength=' + I2S(GMaxExpandedLength),
        'regexProbes=' + I2S(GRegexProbes),
        'rewriteMismatches=' + I2S(GRewriteMismatches),
        'expansionProbeFailures=' + I2S(GExpansionProbeFailures),
        'facadeProductionExamples=' + I2S(GFacadeExamples[0]),
        'facadeTestingExamples=' + I2S(GFacadeExamples[1]),
        'facadeTerritories=' + I2S(GFacadeTerritories),
        'parseInputs=' + I2S(GParseInputs),
        'parseSuccesses=' + I2S(GParseSuccesses),
        'referenceCases=' + I2S(GReferenceCases),
        'mobileDialingCases=' + I2S(GMobileDialingCases),
        'keepingAlphaCases=' + I2S(GKeepingAlphaCases),
        'matcherTexts=' + I2S(GMatcherTexts),
        'matcherCalls=' + I2S(GMatcherCalls),
        'matchesFound=' + I2S(GMatchesFound),
        'exceptions=' + I2S(GExceptions),
        'lines=' + I2S(GLines + 1)]);
    finally
      GOut.SaveToFile(ParamStr(2));
      GRtl.SaveToFile(ParamStr(3));
      GRtl.Free;
      GOut.Free;
    end;
    WriteLn('Observations written: ', GLines);
  except
    on E: Exception do
    begin
      WriteLn(ErrOutput, E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
