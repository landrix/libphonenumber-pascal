# User guide

This guide is for Delphi and Lazarus/FreePascal developers who want to use
libphonenumber-pascal. It is organised by task. Every code fragment is taken
from one of the [sample programs](../samples/), and every output shown here is
the checked output of that program (`samples/expected/`), so it is what the
library really prints with the metadata of this repository.

The example numbers are the ones upstream documents (a Swiss number
`044 668 18 00`, the US number `650 253 0000`, the German `030 123456`). Real
world answers can change with a metadata refresh; which upstream release a
version of this library carries is in [`vendor/versions.md`](../vendor/versions.md)
and in the release notes.

If you know the Java or C# library, start with
[Coming from Java or C#](#16-coming-from-java-or-c).

Contents:

1. [Installation](#1-installation)
2. [The units you use](#2-the-units-you-use)
3. [Core concepts](#3-core-concepts)
4. [Parsing](#4-parsing)
5. [Validation](#5-validation)
6. [Number types](#6-number-types)
7. [Formatting](#7-formatting)
8. [Regions and calling codes](#8-regions-and-calling-codes)
9. [Example numbers](#9-example-numbers)
10. [Formatting as you type](#10-formatting-as-you-type)
11. [Short and emergency numbers](#11-short-and-emergency-numbers)
12. [Finding numbers in text](#12-finding-numbers-in-text)
13. [Comparing numbers](#13-comparing-numbers)
14. [Strings and Unicode on both compilers](#14-strings-and-unicode-on-both-compilers)
15. [Thread safety and performance](#15-thread-safety-and-performance)
16. [Coming from Java or C#](#16-coming-from-java-or-c)
17. [Differences from upstream and what is not ported](#17-differences-from-upstream-and-what-is-not-ported)
18. [FAQ and pitfalls](#18-faq-and-pitfalls)
19. [Metadata version and updates](#19-metadata-version-and-updates)

## 1. Installation

The library is a set of plain `.pas` units in [`src/`](../src/). There is no
package to install, no DLL, no resource file and no runtime dependency beyond
the compiler's RTL: the upstream metadata is compiled into the units. Put
`src/` on the unit search path of your project and add the units you need to
your uses clause.

### Delphi

- IDE: Project > Options > Building > Delphi Compiler > Search path, add the
  `src` folder of this repository.
- Command line: `dcc64 -U<path>\src ...` (or `dcc32`).

The units use only the RTL (`System.SysUtils`, `System.RegularExpressions`,
`System.Character`, `System.SyncObjs`).

### Lazarus and FreePascal

- Lazarus: Project > Project Options > Compiler Options > Paths > Other unit
  files, add the `src` folder.
- Command line: `fpc -Mdelphi -Fu<path>/src ...`.

Every unit of the library switches itself to `{$MODE DELPHI}`; your own
units can use any mode. The units use the `regexpr` unit of the FreePascal
distribution.

On FreePascal `string` is an AnsiString, and the library treats it as UTF-8.
A program that hands non ASCII text to the library (full width digits,
typographic dashes, letters next to a number) therefore needs two things
before its first library call:

```pascal
program MyProgram;

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

uses
{$IFDEF FPC}
  {$IFDEF UNIX}
  cwstring, // the widestring manager; without it every non ASCII character becomes '?'
  {$ENDIF}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.Types,
  LibPhoneNumber.PhoneNumberUtil;

begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8); // before the first library call
{$ENDIF}
  // ...
end.
```

ASCII input works without either step. A Lazarus LCL application already has
both: the LazUtils unit `LazUTF8`, which the LCL uses, links `cwstring` on Unix,
and its `FPCAdds` sets the UTF-8 code page in its initialization (unless the
project defines `DisableUTF8RTL`). The explicit call does no harm there.

If your own source code contains non ASCII string literals, compile it with
`{$CODEPAGE UTF8}` (or `-FcUTF8`), otherwise FreePascal converts them at
compile time through its default code page. See
[section 14](#14-strings-and-unicode-on-both-compilers) for offsets and
`UnicodeString`.

### Supported compilers and platforms

- Delphi 13 (compiler 37.0), Win64: the test suite, the samples and every gate
  run there. Other targets (Win32 among them) and older Delphi versions are
  not tested; reports are welcome.
- FreePascal 3.2.2, 3.2.4 and 3.3.1 in Delphi mode, on Linux, Windows and
  macOS. The exact list of tested compiler and platform combinations is in
  the manifest of [`AGENTS.md`](../AGENTS.md#current-state).

### What gets linked

A program that uses the library links the production phone metadata, the
short number metadata and the alternate format metadata. Never add
`LibPhoneNumber.TestingMetadata` (or its `*.Data`, `*.Descs`, `*.Formats`
units) to a project of your own: it is the upstream TEST data set, which only
the test suite of this repository uses.

## 2. The units you use

| unit | what it holds |
| --- | --- |
| `LibPhoneNumber.Types` | `TPhoneNumber` (the parsed number), `TPhoneNumberFormat` (`pnf*`), `TPhoneNumberParseError` (`pnpe*`), `TPhoneNumberMatchType` (`pnmt*`), `TCountryCodeSource` |
| `LibPhoneNumber.PhoneNumberUtil` | `TPhoneNumberUtil`: parsing, validation, typing, formatting, comparing, example numbers. Start here. |
| `LibPhoneNumber.MetadataCore` | `TMetadataNumberType` (`mnt*`) and `TMetadataValidationResult` (`mvr*`), which `TPhoneNumberUtil` answers with, and `NumberTypeToString` / `ValidationResultToString`. Also the low level functions on (calling code, national number): `GetRegionCodeForCountryCode`, `IsNanpaCountry`, `GetNddPrefixForRegion`, `NormalizeDigitsOnly`, ... |
| `LibPhoneNumber.Metadata` | Region and calling code lookup: `GetSupportedRegions`, `GetSupportedCallingCodes`, `GetRegionCodesForCountryCode`, `GetCountryCodeForRegion`, `IsSupportedRegion`, `IsSupportedCallingCode`, `TryGetMetadataForRegion`, `MetadataVersion` |
| `LibPhoneNumber.Metadata.Types` | `TMetadataStringArray` (what `GetRegionCodesForCountryCode` returns) and the metadata records (`PPhoneMetadataRec`) |
| `LibPhoneNumber.MetadataFormat` | `TUserNumberFormatArray` and `MakeUserNumberFormat` for `TPhoneNumberUtil.FormatByPattern` |
| `LibPhoneNumber.AsYouTypeFormatter` | `TAsYouTypeFormatter` |
| `LibPhoneNumber.ShortNumberInfo` | Short and emergency numbers: `IsValidShortNumberForRegion`, `GetExpectedCostForRegion`, `IsEmergencyNumber`, ... and `TShortNumberCost` (`snc*`) |
| `LibPhoneNumber.PhoneNumberMatcher` | `FindNumbers`, `TPhoneNumberMatcher`, `TPhoneNumberMatch`, `TPhoneNumberLeniency` (`pnl*`) |

The other units of `src/` are internal layers (regex abstraction, format
engine, generated tables).

`TPhoneNumberUtil` has class methods only; there is no instance to create or
free. `TAsYouTypeFormatter` and `TPhoneNumberMatcher` are classes you create
and free.

## 3. Core concepts

### The parsed number: `TPhoneNumber`

`TPhoneNumberUtil.Parse` fills a `TPhoneNumber` record
([`ParseAndValidate.dpr`](../samples/ParseAndValidate.dpr)):

```text
"044 668 18 00" in "CH": OK +41 digits 446681800 number 446681800 region CH
"+39 02 1234 5678" in "ZZ": OK +39 digits 0212345678 number 212345678 region IT
"030 123456 ext. 42" in "DE": OK +49 digits 30123456 number 30123456 ext 42 region DE
```

| field | meaning |
| --- | --- |
| `CountryCode` | The country calling code, `41`. |
| `NationalNumberDigits` | The national significant number as digits. This is the canonical field: a significant leading zero survives (`0212345678` for the Italian number). |
| `NationalNumber` | The numeric value of the same digits (`UInt64`). It loses leading zeros (`212345678`); never rebuild or compare a number from it alone. |
| `Extension` | The extension, `42`, or empty. |
| `RegionCode` | Not upstream: the region this port reports for the number - the default region when it owns the calling code, otherwise the main region of the calling code, `ZZ` for an unsupported code. It is not validated: an invalid `+1` number still reports `US` (see [section 5](#5-validation)). Use `TPhoneNumberUtil.GetRegionCodeForNumber` for the region of a valid number. |
| `RawInput`, `CountryCodeSource`, `PreferredDomesticCarrierCode` | Only `ParseAndKeepRawInput` fills these; `Parse` leaves them empty. |

### Region codes

- Regions are two letter CLDR codes (`CH`, `US`, `DE`). `ZZ` is the unknown
  region; `001` stands for the non geographical entities (`+800`, `+808`,
  ...).
- `TPhoneNumberUtil`, the `TAsYouTypeFormatter` constructor, the
  `ShortNumberInfo` functions and the matcher canonicalise a region argument
  with `UpperCase(Trim(...))`: `' ch '` works like `'CH'`.
- The low level unit functions of `LibPhoneNumber.Metadata`,
  `LibPhoneNumber.MetadataCore` and `LibPhoneNumber.MetadataFormat` take the
  code exactly, like upstream: `'de'` is not a region there. Pass upper case
  codes, or canonicalise them yourself
  ([`RegionsAndExamples.dpr`](../samples/RegionsAndExamples.dpr)):

  ```text
  GetCountryCodeForRegion('DE')                 : 49
  GetCountryCodeForRegion('de')                 : 0
  GetCountryCodeForRegion(CanonicalRegion('de')): 49
  ```

### Possible and valid

- **Possible** means the length fits the region (`IsPossibleNumber*`). It is a
  cheap check and the only one that tells *why* a number is wrong
  (`TOO_SHORT`, `TOO_LONG`, ...).
- **Valid** means the number matches a number range of the metadata
  (`IsValidNumber*`). It does not mean the number is in service.
- A successful parse is neither: `Parse` only checks that the input looks like
  a phone number. Always validate a parsed number when it matters.

### No exceptions

The library does not raise for bad input:

- `Parse` returns `False` and reports a `TPhoneNumberParseError`.
- Where upstream returns `null`, the port has a `TryGet...` function that
  returns `False` (`TryGetExampleNumber`, `TryGetMetadataForRegion`, ...), or
  answers the empty string (`GetRegionCodeForNumber`,
  `GetNddPrefixForRegion`, `GetExampleShortNumber`). Like upstream,
  `GetRegionCodeForCountryCode` answers `'ZZ'` and `GetCountryCodeForRegion`
  answers `0` for unknown input.
- Exceptions are reserved for programming errors, as upstream:
  `EPhoneNumberMatcher` from `TPhoneNumberMatcher.Next` when there is no
  further match (Java's `NoSuchElementException`) and from its constructor
  for a negative `maxTries`; `EArgumentException` from
  `MaybeStripInternationalPrefixAndNormalize` (and `TryMaybeExtractCountryCode`)
  for a malformed international prefix pattern you pass in yourself. Parsing,
  validation and formatting never raise for bad input.

## 4. Parsing

```pascal
var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Number, Error) then
    // use Number
  else
    // Error says why
end;
```

The second argument is the default region: the region assumed for a number
written without its calling code. A number written with `+` (or with the
international prefix of the default region, `0049` from `DE`) carries its
own calling code and parses whatever the default region is. With an empty or
unknown default region only numbers with a leading `+` parse.

What `Parse` accepts ([`ParseAndValidate.dpr`](../samples/ParseAndValidate.dpr)):

```text
"044 668 18 00" in " ch ": OK +41 digits 446681800 number 446681800 region CH
"1-800-FLOWERS" in "US": OK +1 digits 8003569377 number 8003569377 region US
"tel:+41-44-668-18-00" in "": OK +41 digits 446681800 number 446681800 region CH
"0049 30 123456" in "DE": OK +49 digits 30123456 number 30123456 region DE
030123456 in full width digits in "DE": OK +49 digits 30123456 number 30123456 region DE
```

Formatting characters, vanity letters (`1-800-FLOWERS`), RFC3966 (`tel:`),
international prefixes, extensions (`ext. 42`, `x42`, `;ext=42`, ...) and
the decimal digits of every Unicode script in the Basic Multilingual Plane
(full width, Arabic-Indic, ...) are all understood, like in Java.

### Parse errors

There is no name function for `TPhoneNumberParseError`; the samples keep a
small local one (`ParseErrorName` in
[`ParseAndValidate.dpr`](../samples/ParseAndValidate.dpr)).

| value | Java `ErrorType` | typical input (sample output) |
| --- | --- | --- |
| `pnpeNotANumber` | `NOT_A_NUMBER` | `"abc" in "DE": FAIL NOT_A_NUMBER` |
| `pnpeInvalidCountryCode` | `INVALID_COUNTRY_CODE` | `"030 123456" in "": FAIL INVALID_COUNTRY_CODE` - a national number and no usable default region |
| `pnpeTooShortAfterIdd` | `TOO_SHORT_AFTER_IDD` | `"011" in "US": FAIL TOO_SHORT_AFTER_IDD` |
| `pnpeTooShortNsn` | `TOO_SHORT_NSN` | `"+49 1" in "DE": FAIL TOO_SHORT_NSN` |
| `pnpeTooLongNsn` | `TOO_LONG` | `"+49 123456789012345678" in "DE": FAIL TOO_LONG` |

`pnpeNone` is the value after a successful parse.

### Keeping the raw input

`TPhoneNumberUtil.ParseAndKeepRawInput` parses like `Parse` and also fills
`RawInput` (the input as given), `CountryCodeSource` (how the calling code
was found) and `PreferredDomesticCarrierCode`. `FormatInOriginalFormat`,
`FormatOutOfCountryKeepingAlphaChars` and the carrier code branch of
`FormatNumberForMobileDialing` need them ([section 7](#7-formatting)).

## 5. Validation

`TPhoneNumberUtil` validates a parsed number
([`ParseAndValidate.dpr`](../samples/ParseAndValidate.dpr)):

```pascal
if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Number, Error) then
begin
  TPhoneNumberUtil.IsValidNumber(Number);                     // True
  TPhoneNumberUtil.IsValidNumberForRegion(Number, 'CH');      // True
  TPhoneNumberUtil.IsValidNumberForRegion(Number, 'DE');      // False
  TPhoneNumberUtil.IsPossibleNumberForType(Number, mntMobile);
  TPhoneNumberUtil.CanBeInternationallyDialled(Number);
end;
```

```text
044 668 18 00 (CH)
  IsValidNumber           : True
  IsValidNumberForRegion CH: True
  IsValidNumberForRegion ch: True
  IsValidNumberForRegion DE: False
  IsPossibleNumberForType MOBILE: True
  CanBeInternationallyDialled: True
```

| method | answers |
| --- | --- |
| `IsValidNumber(N)` | Valid for the region its calling code resolves to. |
| `IsValidNumberForRegion(N, Region)` | Valid AND from `Region`. |
| `IsPossibleNumber(N)` | The length is possible. |
| `IsPossibleNumberWithReason(N)` | `TMetadataValidationResult`: `mvrIsPossible`, `mvrIsPossibleLocalOnly` (only diallable within the local area), `mvrInvalidCountryCode`, `mvrTooShort`, `mvrInvalidLength`, `mvrTooLong`. |
| `IsPossibleNumberForType(N, Type)`, `IsPossibleNumberForTypeWithReason(N, Type)` | The same against the lengths of one number type. |
| `CanBeInternationallyDialled(N)` | False for numbers that can only be dialled within their country. |

A number can parse and still be wrong:

```text
+1 650 253 000 parses     : True
  IsPossibleNumberWithReason: TOO_SHORT
  IsValidNumber           : False
  GetRegionCodeForNumber  : ""
  RegionCode field        : "US"
```

### The string helpers

`TPhoneNumberUtil.IsValidNumber(Input, Region)` and
`IsPossibleNumber(Input, Region)` parse and check in one call; they answer
`False` when the input does not parse. The region is only the DEFAULT region
of the parse, so they do not mean "valid in this region": a number with its
own calling code is checked for that code.

```text
IsValidNumber('+49 30 123456', 'CH'): True
```

Use `IsValidNumberForRegion` on the parsed number for the region check.

### The low level functions

`LibPhoneNumber.MetadataCore` has the same functions on (calling code,
national significant number): `IsValidNumber(N.CountryCode,
N.NationalNumberDigits)`, `GetNumberType`, `IsPossibleNumberWithReason`, ...
They are what the `TPhoneNumberUtil` methods call. They take region codes
exactly, so prefer the `TPhoneNumberUtil` methods:

```text
  MetadataCore.IsValidNumberForRegion(cc, nsn, 'ch'): False
```

## 6. Number types

`TPhoneNumberUtil.GetNumberType(N)` returns a `TMetadataNumberType`;
`NumberTypeToString` (unit `LibPhoneNumber.MetadataCore`) gives the upstream
name ([`ParseAndValidate.dpr`](../samples/ParseAndValidate.dpr)):

```text
+41 44 668 18 00: FIXED_LINE, region CH
+41 79 123 45 67: MOBILE, region CH
+41 800 123 456: TOLL_FREE, region CH
+41 900 123 456: PREMIUM_RATE, region CH
+1 650-253-0000: FIXED_LINE_OR_MOBILE, region US
+800 1234 5678: TOLL_FREE, region 001
```

- `mntFixedLineOrMobile`: the region does not tell fixed line and mobile
  numbers apart by their digits; the US and the other NANPA regions are the
  typical case.
- `mntUnknown`: the number is not valid.
- `TPhoneNumberUtil.GetSupportedTypesForRegion` and
  `GetSupportedTypesForNonGeoEntity` return the set of types a region has
  ([`RegionsAndExamples.dpr`](../samples/RegionsAndExamples.dpr)):

  ```text
  DE : FIXED_LINE MOBILE TOLL_FREE PREMIUM_RATE SHARED_COST PERSONAL_NUMBER PAGER UAN VOICEMAIL
  800: TOLL_FREE
  ```

- `TPhoneNumberUtil.IsNumberGeographical(N)` tells whether a number is tied
  to a place (fixed line numbers, and mobile numbers in a few countries).

## 7. Formatting

`TPhoneNumberUtil.Format(N, Format)` ([`FormatNumbers.dpr`](../samples/FormatNumbers.dpr)):

```text
044 668 18 00 (CH)
  pnfE164                : +41446681800
  pnfInternational       : +41 44 668 18 00
  pnfInternationalLegacy : +41 (44) 668 18 00
  pnfNational            : 044 668 18 00
  pnfRfc3966             : tel:+41-44-668-18-00
030 123456 ext. 42 (DE)
  pnfE164                : +4930123456
  pnfInternational       : +49 30 123456 ext. 42
  pnfInternationalLegacy : +49 (30) 123456 ext. 42
  pnfNational            : 030 123456 ext. 42
  pnfRfc3966             : tel:+49-30-123456;ext=42
```

`pnfInternationalLegacy` is not upstream: INTERNATIONAL with the space
separated group after the calling code in parentheses; a number without such
a group stays as it is (`+1 650-253-0000` in
[`FormatNumbers.dpr`](../samples/FormatNumbers.dpr)). E164 never carries the
extension.

### Dialling from another country

`FormatOutOfCountryCallingNumber(N, RegionCallingFrom)` adds the international
prefix of the calling region, or formats nationally within the same region or
the same calling code:

```text
CH number from US: 011 41 44 668 18 00
CH number from DE: 00 41 44 668 18 00
CH number from CH: 044 668 18 00
US number from US: 1 (650) 253-0000
US number from CA: 1 (650) 253-0000
US number from GB: 00 1 650-253-0000
```

### Formats that need `ParseAndKeepRawInput`

```text
RawInput                        : 0446681800
FormatInOriginalFormat (CH)     : 044 668 18 00
FormatNumberForMobileDialing CH : 044 668 18 00
FormatNumberForMobileDialing US : +41446681800
FormatInOriginalFormat of +41 44 668 18 00 (CH): +41 44 668 18 00
1-800-FLOWERS NATIONAL          : (800) 356-9377
1-800-FLOWERS from DE keeping alpha characters: 00 1 800-FLOWERS
```

- `FormatInOriginalFormat(N, Region)` formats the number the way the user
  typed it. For a number from plain `Parse` it falls back to NATIONAL.
- `FormatNumberForMobileDialing(N, RegionCallingFrom, WithFormatting)`
  formats for dialling from a mobile phone in that region; `False` returns
  only the diallable characters. It returns `''` when the number cannot be
  dialled from there (see the Brazilian example below).
- `FormatOutOfCountryKeepingAlphaChars(N, RegionCallingFrom)` keeps vanity
  letters.

### Carrier codes

Some countries need a carrier selection code for national calls. Brazil:

```text
NATIONAL                           : (11) 2345-6789
FormatNationalNumberWithCarrierCode 15: 0 15 (11) 2345-6789
FormatNumberForMobileDialing BR    : ""
PreferredDomesticCarrierCode       : 15
FormatNationalNumberWithPreferredCarrierCode, fallback 21: 0 15 (11) 2345-6789
FormatNumberForMobileDialing BR    : "0 15 (11) 2345-6789"
```

The last three lines are the number parsed with `ParseAndKeepRawInput('0 15
11 2345 6789', 'BR', ...)`, which remembers the carrier code the user dialled.

### Your own patterns

`FormatByPattern` takes user defined formats, built with
`MakeUserNumberFormat` from `LibPhoneNumber.MetadataFormat`:

```pascal
SetLength(Formats, 1);
Formats[0] := MakeUserNumberFormat('(\d{3})(\d{3})(\d{4})', '$1.$2.$3', [], '', '');
TPhoneNumberUtil.FormatByPattern(Number, pnfNational, Formats);
```

```text
NATIONAL     : 650.253.0000
INTERNATIONAL: +1 650.253.0000
```

### Parts of a number

```text
GetNationalSignificantNumber      : 446681800
GetLengthOfNationalDestinationCode: 2
GetLengthOfGeographicalAreaCode   : 2
```

### What `Format` does not do

- It does not validate: an invalid number is formatted as well as it can be.
- A record whose national number is zero or absent is not formatted: like
  upstream, `Format` then returns its `RawInput` when it carries one or has
  no calling code, so `Default(TPhoneNumber)` formats to the empty string.

```text
invalid +1 650 253 000 as E164: +1650253000, valid: False
Format(Default(TPhoneNumber), pnfE164): ""
```

## 8. Regions and calling codes

The lookup functions live in `LibPhoneNumber.Metadata` and
`LibPhoneNumber.MetadataCore` and take region codes exactly
([`RegionsAndExamples.dpr`](../samples/RegionsAndExamples.dpr)):

```text
GetRegionCodeForCountryCode(1)                : US
GetRegionCodeForCountryCode(999)              : ZZ
GetRegionCodesForCountryCode(44)              : GB GG IM JE
IsSupportedRegion('CH')                       : True
IsSupportedRegion('ZZ')                       : False
IsSupportedCallingCode(800)                   : True
IsNanpaCountry('CA')                          : True
GetNddPrefixForRegion('DE', True)             : "0"
GetNddPrefixForRegion('US', True)             : "1"
GetNddPrefixForRegion('IT', True)             : ""
mobile number portable region DE              : True
```

- `GetRegionCodesForCountryCode` returns a `TMetadataStringArray` (unit
  `LibPhoneNumber.Metadata.Types`); the main region comes first.
- `GetSupportedRegions`, `GetSupportedCallingCodes` and
  `GetSupportedGlobalNetworkCallingCodes` list everything the metadata has.
- Upstream's `isMobileNumberPortableRegion` is a field of the region's
  metadata here: `TryGetMetadataForRegion('DE', Metadata)` and then
  `Metadata^.MobileNumberPortableRegion`.
- `GetRegionCodeForNumber` (on `TPhoneNumberUtil` for a parsed number)
  answers the region a number belongs to; for numbers that share a calling
  code (`+1`, `+44`, `+7`, ...) it looks at the number itself. It is only
  reliable for valid numbers and does not validate: a calling code with a
  single region answers that region for any number.

## 9. Example numbers

```text
TryGetExampleNumber(DE)               : +49 30 123456
TryGetExampleNumberForType(DE, MOBILE): +49 1512 3456789
TryGetExampleNumberForNonGeoEntity(800): +800 1234 5678, region 001
TryGetInvalidExampleNumber(DE)        : +493012, valid False
TryGetExampleNumber(ZZ) succeeds      : False
```

All of them are `TPhoneNumberUtil` methods and return a parsed
`TPhoneNumber`. `TryGetInvalidExampleNumber` is useful for tests.
`TryGetExampleNumberForType(Type, N)` without a region returns some number of
that type from any region.

## 10. Formatting as you type

`TAsYouTypeFormatter` formats a number while the user types it
([`AsYouType.dpr`](../samples/AsYouType.dpr)). Create one per input field,
feed it one character at a time and display what `InputDigit` returns:

```pascal
Formatter := TAsYouTypeFormatter.Create('US');
try
  for I := 1 to Length(Keys) do
    Display := Formatter.InputDigit(Keys[I]);
finally
  Formatter.Free;
end;
```

```text
== US, digits only
  6 -> "6"
  5 -> "65"
  0 -> "650"
  2 -> "650-2"
  5 -> "650-25"
  3 -> "650-253"
  0 -> "650-2530"
  0 -> "(650) 253-00"
  0 -> "(650) 253-000"
  0 -> "(650) 253-0000"
```

- `InputDigit` takes a `WideChar` and returns a `UnicodeString`; keep the keys
  in a `UnicodeString`. That is also what lets a FreePascal program pass a
  full width digit.
- `Clear` starts a new number with the same formatter.
- A number typed with `+` is formatted for its own calling code, whatever the
  region of the formatter; an unknown region (`ZZ`) formats such numbers too.
- As soon as the user types a formatting character, the input is echoed as
  typed and no longer formatted:

  ```text
  == US, the user types a dash
    6 -> "6"
    5 -> "65"
    0 -> "650"
    - -> "650-"
    2 -> "650-2"
  ```

- `InputDigitAndRememberPosition` marks a key; `GetRememberedPosition` then
  tells where it is in the formatted text (the cursor position right behind
  it), also after formatting moved it:

  ```text
    2 -> "650-2", remembered position 5
    ...
    0 -> "650-2530", remembered position 5
    0 -> "(650) 253-00", remembered position 7
  ```

## 11. Short and emergency numbers

The unit `LibPhoneNumber.ShortNumberInfo` answers questions about short codes
([`ShortNumbers.dpr`](../samples/ShortNumbers.dpr)). Its functions take the
calling code and the national significant number of a parsed number and the
region it is dialled from:

```pascal
TPhoneNumberUtil.Parse('116000', 'DE', Number, Error);
IsValidShortNumberForRegion(Number.CountryCode, Number.NationalNumberDigits, 'DE');
GetExpectedCostForRegion(Number.CountryCode, Number.NationalNumberDigits, 'DE');
```

```text
116000 dialled in DE
  possible short number : yes
  valid short number    : yes
  expected cost         : TOLL_FREE
  emergency number      : no
  connects to emergency : no
  carrier specific      : no
  SMS service           : no
  TPhoneNumberUtil.IsValidNumber: no
1120 dialled in DE
  possible short number : yes
  valid short number    : no
  expected cost         : UNKNOWN_COST
  emergency number      : no
  connects to emergency : yes
```

- A short number is never a valid number for `TPhoneNumberUtil.IsValidNumber`;
  ask `ShortNumberInfo`.
- `GetExpectedCostForRegion` returns a `TShortNumberCost` (`sncTollFree`,
  `sncStandardRate`, `sncPremiumRate`, `sncUnknownCost`);
  `ShortNumberCostToString` gives the upstream name.
- `IsEmergencyNumber` and `ConnectsToEmergencyNumber` take the number exactly
  as dialled, not a parsed number, because `+1 911` is not an emergency
  number while `911` is. `ConnectsToEmergencyNumber` also accepts digits
  appended to an emergency number (`1120` connects to `112` in Germany).

  ```text
  IsEmergencyNumber('911', 'US')   : yes
  IsEmergencyNumber('+1 911', 'US'): no
  ```

- `GetExampleShortNumber` and `GetExampleShortNumberForCost` return example
  short codes (`''` when there is none).

## 12. Finding numbers in text

`FindNumbers(Text, DefaultRegion)` returns every phone number in a text as an
array of `TPhoneNumberMatch`
([`FindNumbersInText.dpr`](../samples/FindNumbersInText.dpr)):

```pascal
Matches := FindNumbers('Call 044 668 18 00 or +1 650-253-0000 before 6 pm.', 'CH');
for I := 0 to High(Matches) do
  WriteLn(Matches[I].Start, '..', Matches[I].EndIndex, ' ', Matches[I].RawString);
```

```text
  [5..18) "044 668 18 00" -> +41446681800
  [22..37) "+1 650-253-0000" -> +16502530000
```

`Start` is the zero based offset of the match, `EndIndex` the offset behind
it, `RawString` the matched text and `Number` the parsed number.

### Leniency

`FindNumbers(Text, Region, Leniency, MaxTries)` chooses how strict the
matcher is. The same text with the four levels:

```text
  Call 650 253 0000, 650 2530000, 65 02 53 00 00 or 253 0000.
pnlPossible      :
  [5..17) "650 253 0000" -> +16502530000
  [19..30) "650 2530000" -> +16502530000
  [32..46) "65 02 53 00 00" -> +16502530000
  [50..58) "253 0000" -> +12530000
pnlValid         :
  [5..17) "650 253 0000" -> +16502530000
  [19..30) "650 2530000" -> +16502530000
  [32..46) "65 02 53 00 00" -> +16502530000
pnlStrictGrouping:
  [5..17) "650 253 0000" -> +16502530000
  [19..30) "650 2530000" -> +16502530000
pnlExactGrouping :
  [5..17) "650 253 0000" -> +16502530000
```

| leniency | accepts |
| --- | --- |
| `pnlPossible` | Possible numbers, valid or not. |
| `pnlValid` | Valid numbers (the default of the two argument `FindNumbers`). |
| `pnlStrictGrouping` | Valid, and the digits are grouped in a way the region uses. |
| `pnlExactGrouping` | Valid, and grouped exactly like the library formats it, or written as one block. |

### Iterating

`TPhoneNumberMatcher` finds one match after the other, for large texts or when
only the first match is needed. An empty region or `ZZ` finds only numbers
with a calling code:

```pascal
Matcher := TPhoneNumberMatcher.Create(Text, 'ZZ', pnlValid, UnlimitedTries);
try
  while Matcher.TryNext(Match) do
    WriteLn(Match.Start, ': ', Match.RawString);
finally
  Matcher.Free;
end;
```

```text
  Call +41 44 668 18 00 or 044 668 18 00, or +1 650-253-0000.
  5: +41 44 668 18 00
  43: +1 650-253-0000
  Next after the last match raises EPhoneNumberMatcher
```

`HasNext` / `Next` is the upstream iterator pair; `Next` raises
`EPhoneNumberMatcher` when there is no further match.

### The `maxTries` budget

`maxTries` limits how many candidates that turn out not to be numbers the
matcher examines before it gives up on the text; `UnlimitedTries` has no
limit:

```text
  Codes: 11-22, 33-44, 55-66, 77-88. Call 044 668 18 00.
  maxTries 3: nothing found
  maxTries 4: nothing found
  maxTries 5: found "044 668 18 00"
```

### Offsets

Offsets are UTF-16 code units on both compilers, like Java. On Delphi that is
the index into `string` minus one. On FreePascal `string` is UTF-8, so slice
the `UnicodeString` form of the text:

```pascal
Text := UnicodeString('Tel. ') + UnicodeString(#$00FC#$00E4) + ' 044 668 18 00';
Matches := FindNumbers(string(Text), 'CH');
Slice := Copy(Text, Matches[0].Start + 1, Matches[0].EndIndex - Matches[0].Start);
```

```text
  text: "Tel. <U+00FC><U+00E4> 044 668 18 00", 21 UTF-16 code units
  Start = 8, EndIndex = 21
  slice: "044 668 18 00"
```

## 13. Comparing numbers

`TPhoneNumberUtil.IsNumberMatch` compares two numbers, as records, as strings
or mixed, and returns a `TPhoneNumberMatchType`
([`ParseAndValidate.dpr`](../samples/ParseAndValidate.dpr)):

```text
+41 44 668 18 00 vs +41446681800    : EXACT_MATCH
+41 44 668 18 00 vs 044 668 18 00   : NSN_MATCH
+41 44 668 18 00 vs +41 44 668 18 01: NO_MATCH
abc vs +41 44 668 18 00             : NOT_A_NUMBER
records 044 668 18 00 (CH) vs +41 44 668 18 00 (DE): EXACT_MATCH
record 044 668 18 00 (CH) vs string 446681800: NSN_MATCH
```

| value | meaning |
| --- | --- |
| `pnmtExactMatch` | Same calling code, national number and extension. |
| `pnmtNsnMatch` | One side has no calling code (a national string), and the national numbers and extensions are the same. |
| `pnmtShortNsnMatch` | One national number could be a shorter form of the other, or only one has an extension. |
| `pnmtNoMatch` | Different numbers. |
| `pnmtNotANumber` | A string that does not parse at all. |

A string is parsed without a default region, so `044 668 18 00` has no
calling code there and can at best be an `NSN_MATCH`. Parse it with its region
first for an exact comparison.

## 14. Strings and Unicode on both compilers

- On Delphi `string` is `UnicodeString` (UTF-16). Nothing to do.
- On FreePascal `string` is an AnsiString that the library treats as UTF-8:
  set `SetMultiByteConversionCodePage(CP_UTF8)` and link `cwstring` on Unix
  ([section 1](#lazarus-and-freepascal)). Every result string is UTF-8 too.
- Lengths and offsets are UTF-16 code units on both compilers, exactly like
  Java: the input length limit of the parser and the offsets of the matcher.
  On FreePascal convert to `UnicodeString` before you index with them.
- `TAsYouTypeFormatter.InputDigit` takes a `WideChar` and returns a
  `UnicodeString` on both compilers.
- A lone surrogate cannot be passed in a FreePascal UTF-8 `string` at all.
- Console output: a Delphi console program writes `string` through the ANSI
  code page of the console, which maps characters it does not have to
  similar ones or `?`. This affects only what you print, not what the
  library computes.

The details, and the rules the units follow internally, are in
[`KNOWN_ISSUES.md`](../KNOWN_ISSUES.md) (permanent item 6) and
[`docs/ARCHITECTURE.md`](ARCHITECTURE.md#strings-on-both-compilers).

## 15. Thread safety and performance

- `TPhoneNumberUtil`, `ShortNumberInfo`, `FindNumbers` and the lookup
  functions keep no state of their own and read the metadata from read only
  tables: call them from any thread.
- Compiled regular expressions are cached process wide. The cache and the
  matching are guarded by one critical section, so heavy use from many
  threads at once serialises on pattern matching.
- `TAsYouTypeFormatter` and `TPhoneNumberMatcher` hold state: one instance per
  thread (and per input field or text).
- `UseMetadataTables` / `UseProductionMetadata` switch the metadata of the
  whole process and are not thread safe; they exist for the test suite.
  Applications never call them.
- The first calls compile the patterns they need; later calls hit the cache.
  Measured throughput is in
  [`docs/ARCHITECTURE.md`](ARCHITECTURE.md#performance).
- `FindNumbers` collects every match of the text into an array; for very
  large texts use `TPhoneNumberMatcher` and stop when you have what you need,
  or limit `maxTries`.
- The metadata is compiled into the executable, which makes it noticeably
  larger than the code alone.

## 16. Coming from Java or C#

| Java | Pascal (unit) |
| --- | --- |
| `PhoneNumberUtil.getInstance()` | none: `TPhoneNumberUtil` has class methods only |
| `parse(s, region)` throws `NumberParseException` | `TPhoneNumberUtil.Parse(s, region, N, Error): Boolean` |
| `ErrorType.NOT_A_NUMBER / INVALID_COUNTRY_CODE / TOO_SHORT_AFTER_IDD / TOO_SHORT_NSN / TOO_LONG` | `pnpeNotANumber / pnpeInvalidCountryCode / pnpeTooShortAfterIdd / pnpeTooShortNsn / pnpeTooLongNsn` |
| `parseAndKeepRawInput` | `TPhoneNumberUtil.ParseAndKeepRawInput` |
| `isValidNumber(n)`, `isValidNumberForRegion(n, r)` | `TPhoneNumberUtil.IsValidNumber(N)`, `IsValidNumberForRegion(N, r)` |
| `isPossibleNumber(n)`, `...WithReason`, `...ForType`, `...ForTypeWithReason` | `TPhoneNumberUtil.IsPossibleNumber(N)`, `IsPossibleNumberWithReason`, `IsPossibleNumberForType`, `IsPossibleNumberForTypeWithReason` |
| `isPossibleNumber(String, region)` | `TPhoneNumberUtil.IsPossibleNumber(s, region)` |
| `getNumberType(n)`, `PhoneNumberType.*` | `TPhoneNumberUtil.GetNumberType(N)`, `TMetadataNumberType` (`mnt*`, `LibPhoneNumber.MetadataCore`) |
| `ValidationResult.*` | `TMetadataValidationResult` (`mvr*`, `LibPhoneNumber.MetadataCore`) |
| `getRegionCodeForNumber(n)` | `TPhoneNumberUtil.GetRegionCodeForNumber(N)`; `''` for null |
| `canBeInternationallyDialled(n)` | `TPhoneNumberUtil.CanBeInternationallyDialled(N)` |
| `getRegionCodeForCountryCode(cc)` | `GetRegionCodeForCountryCode(cc)` (`LibPhoneNumber.MetadataCore`); `'ZZ'` for unknown |
| `getCountryCodeForRegion(r)` | `GetCountryCodeForRegion(r)` (`LibPhoneNumber.Metadata`); `0` for unknown, exact region code |
| `getRegionCodesForCountryCode(cc)` | `GetRegionCodesForCountryCode(cc)` (`LibPhoneNumber.Metadata`), a `TMetadataStringArray` |
| `getSupportedRegions / getSupportedCallingCodes / getSupportedGlobalNetworkCallingCodes` | same names in `LibPhoneNumber.Metadata` |
| `getNddPrefixForRegion(r, strip)`, `isNANPACountry(r)` | `GetNddPrefixForRegion`, `IsNanpaCountry` (`LibPhoneNumber.MetadataCore`) |
| `isMobileNumberPortableRegion(r)` | `TryGetMetadataForRegion(r, M)` then `M^.MobileNumberPortableRegion` |
| `format(n, fmt)`, `PhoneNumberFormat.*` | `TPhoneNumberUtil.Format(N, fmt)`, `TPhoneNumberFormat` (`pnf*`) |
| `formatOutOfCountryCallingNumber`, `formatInOriginalFormat`, `formatNumberForMobileDialing`, `formatNationalNumberWithCarrierCode`, `formatNationalNumberWithPreferredCarrierCode`, `formatOutOfCountryKeepingAlphaChars` | same names on `TPhoneNumberUtil` |
| `formatByPattern(n, fmt, formats)` | `TPhoneNumberUtil.FormatByPattern(N, fmt, Formats)`, formats from `MakeUserNumberFormat` (`LibPhoneNumber.MetadataFormat`) |
| `getNationalSignificantNumber(n)` | `TPhoneNumberUtil.GetNationalSignificantNumber(N)` (for a parsed number the same digits as `N.NationalNumberDigits`, except that more than ten leading zeros are capped at ten, as upstream does; for a hand built record it follows upstream, `'0'` for `Default(TPhoneNumber)`) |
| `getExampleNumber`, `getExampleNumberForType` (2), `getExampleNumberForNonGeoEntity`, `getInvalidExampleNumber` | `TPhoneNumberUtil.TryGetExampleNumber`, `TryGetExampleNumberForType` (2), `TryGetExampleNumberForNonGeoEntity`, `TryGetInvalidExampleNumber` |
| `getSupportedTypesForRegion / ...ForNonGeoEntity` | same names on `TPhoneNumberUtil`, a `TMetadataNumberTypes` set |
| `isNumberGeographical`, `getLengthOfGeographicalAreaCode`, `getLengthOfNationalDestinationCode`, `getCountryMobileToken`, `isAlphaNumber`, `truncateTooLongNumber` | same names on `TPhoneNumberUtil` |
| `isNumberMatch` (3 overloads), `MatchType.*` | `TPhoneNumberUtil.IsNumberMatch` (3 overloads), `TPhoneNumberMatchType` (`pnmt*`) |
| `normalizeDigitsOnly`, `normalizeDiallableCharsOnly`, `convertAlphaCharactersInNumber` | same names in `LibPhoneNumber.MetadataCore` |
| `getAsYouTypeFormatter(r)` | `TAsYouTypeFormatter.Create(r)`; the caller frees it |
| `findNumbers(text, r[, leniency, maxTries])` | `FindNumbers(...)` (an array); `TPhoneNumberMatcher.Create(text, r, leniency, maxTries)` with `HasNext` / `Next` / `TryNext` |
| `Leniency.POSSIBLE / VALID / STRICT_GROUPING / EXACT_GROUPING` | `pnlPossible / pnlValid / pnlStrictGrouping / pnlExactGrouping` |
| `PhoneNumberMatch.start() / end() / rawString() / number()` | `.Start` / `.EndIndex` / `.RawString` / `.Number` |
| `ShortNumberInfo.getInstance().xxx(n, r)` | `xxx(N.CountryCode, N.NationalNumberDigits, r)` in `LibPhoneNumber.ShortNumberInfo`; `IsEmergencyNumber` / `ConnectsToEmergencyNumber` take the dialled string |
| `PhoneNumber.getCountryCode()`, `getNationalNumber()`, `getExtension()` | `N.CountryCode`, `N.NationalNumberDigits` (or the lossy `N.NationalNumber`), `N.Extension` |
| `hasExtension()` | `N.Extension <> ''` |
| geocoder, carrier mapper, time zone mapper | not ported |

The C# port (`PhoneNumbers` on NuGet) uses the same names in PascalCase; the
table applies to it as well.

## 17. Differences from upstream and what is not ported

Deliberate differences, all documented in the unit headers:

- No exceptions: Boolean results with an error value, `TryGet...` functions
  and the empty string for upstream's `null` ([section 3](#no-exceptions)).
- `TPhoneNumber` is a record. `NationalNumberDigits` replaces the
  `italianLeadingZero` / `numberOfLeadingZeros` proto fields; `RegionCode` is
  an addition.
- Region arguments of the public entry points are canonicalised
  ([section 3](#region-codes)).
- `pnfInternationalLegacy` is an extra display format.
- `FindNumbers` returns an array instead of an `Iterable`.
- `TAsYouTypeFormatter.InputDigit` takes a `WideChar`.

Not ported:

- the geocoder, the carrier mapper and the time zone mapper;
- `isMobileNumberPortableRegion` as a function (the data is a metadata field,
  see [section 8](#8-regions-and-calling-codes));
- loading other metadata at run time ("metadata lite", custom metadata
  sources); the metadata is compiled in.

## 18. FAQ and pitfalls

**`Parse` returned True, but the number is wrong.** Parsing does not
validate. Call `TPhoneNumberUtil.IsValidNumber(Number)`
([section 5](#5-validation)).

**`IsValidNumber('+49 30 123456', 'CH')` is True.** The region of the string
helper is only the default region of the parse. Use
`IsValidNumberForRegion(Number, 'CH')`.

**A lower case region works in one place and not in another.**
`TPhoneNumberUtil`, the formatter, `ShortNumberInfo` and the matcher
canonicalise regions; the functions of `LibPhoneNumber.Metadata` and
`LibPhoneNumber.MetadataCore` do not ([section 3](#region-codes)).

**`NationalNumber` lost a zero.** Use `NationalNumberDigits`; `NationalNumber`
is numeric.

**`RegionCode` says `US`, but `GetRegionCodeForNumber` says `''`.** The field
is filled during parsing and not validated. `GetRegionCodeForNumber` resolves
a shared calling code like `+1` through the number ranges of its regions and
answers `''` when none matches. Neither replaces `IsValidNumber`.

**`Format` returned an empty string.** The record has no calling code, for
example `Default(TPhoneNumber)` or a record you built yourself.

**`FormatNumberForMobileDialing` returned an empty string.** The number cannot
be dialled from that region in that form; Brazil without a carrier code is
the typical case ([section 7](#carrier-codes)).

**`FormatInOriginalFormat` does not keep my input.** It needs a number from
`ParseAndKeepRawInput`.

**`112` is not a valid number.** Short codes are not phone numbers for
`TPhoneNumberUtil`; use `LibPhoneNumber.ShortNumberInfo`
([section 11](#11-short-and-emergency-numbers)).

**`IsEmergencyNumber('+1 911', 'US')` is False.** Emergency numbers are
checked on the number as dialled; nobody dials `+1 911`.

**Matcher offsets point into the middle of a character on FreePascal.** They
are UTF-16 offsets; index the `UnicodeString` form of the text
([section 12](#offsets)).

**Non ASCII text turns into `?` on FreePascal.** Set the UTF-8 code page and
link `cwstring` on Unix ([section 1](#lazarus-and-freepascal)).

**A number of some country is rejected, misclassified or formatted wrongly.**
Almost always a matter of the upstream metadata, not of this port. Check it in
Google's [libphonenumber demo](https://libphonenumber.appspot.com/) and see
[CONTRIBUTING.md](../CONTRIBUTING.md#wrong-number-data-report-it-upstream) for
where to report it. Upstream's
[FAQ](https://github.com/google/libphonenumber/blob/master/FAQ.md) answers
many data questions ("why is this number not mobile").

## 19. Metadata version and updates

- `MetadataVersion` (unit `LibPhoneNumber.Metadata`) returns the label of the
  generator that wrote the tables, `MetadataUpstreamCommit` the upstream
  libphonenumber commit and `MetadataSourceName` the upstream file
  ([`RegionsAndExamples.dpr`](../samples/RegionsAndExamples.dpr)):

  ```text
  MetadataVersion   : metadata-v1
  MetadataSourceName: resources/PhoneNumberMetadata.xml
  ```

- [`vendor/versions.md`](../vendor/versions.md) maps the commit to the
  upstream release; [`CHANGELOG.md`](../CHANGELOG.md) and the release notes
  say which release a version of this library carries.
- New metadata comes with a new version of this library: update your copy of
  `src/`. The tables are generated from the upstream XML, never edited by
  hand; the procedure is in [`AGENTS.md`](../AGENTS.md#vendor-update-workflow).
