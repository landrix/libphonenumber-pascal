# libphonenumber-pascal

[![Quick Check](https://github.com/landrix/libphonenumber-pascal/actions/workflows/quick-check.yml/badge.svg?branch=main)](https://github.com/landrix/libphonenumber-pascal/actions/workflows/quick-check.yml)
[![Release](https://img.shields.io/github/v/release/landrix/libphonenumber-pascal)](https://github.com/landrix/libphonenumber-pascal/releases)
[![License](https://img.shields.io/github/license/landrix/libphonenumber-pascal)](LICENSE)

A pure Object Pascal port of Google's
[libphonenumber](https://github.com/google/libphonenumber): parse, validate,
classify and format international phone numbers, format them as the user
types, and find them in free text.

- **Delphi and FreePascal** from the same source. No DLL, no .NET, no external
  runtime - the upstream metadata is compiled into the units.
- **A literal port** of the Java reference implementation. Method by method,
  the code follows `PhoneNumberUtil.java` and its companions, so upstream
  documentation and upstream behaviour apply.
- **Metadata generated from upstream**: the tables under `src/` are produced
  from the upstream XML resources by a generator that ports upstream's own
  `BuildMetadataFromXml.java`. A metadata update is a regeneration, not a hand
  edit.

The current metadata is built from upstream **libphonenumber 9.0.42**
(`google/libphonenumber` commit `8d8d752`); the exact pins are in
[`vendor/versions.md`](vendor/versions.md). The version number follows that
release: `X.Y.Z.0` is the first release on upstream metadata X.Y.Z,
`X.Y.Z.1` and later are releases of the port with the same metadata
([versioning](CHANGELOG.md#versioning)).

## Installation

Add the `src/` folder of this repository to the unit search path of your
project. There is nothing else to install: no package, no DLL, no resource
files.

- **Delphi**: Project > Options > Building > Delphi Compiler > Search path, or
  `dcc64 -U<path>\src` on the command line.
- **Lazarus**: Project > Project Options > Compiler Options > Paths > Other
  unit files, or `fpc -Mdelphi -Fu<path>/src` on the command line.

Never add `LibPhoneNumber.TestingMetadata` to an application; it is the
upstream test data set of the test suite. Details, including what to know on
FreePascal, are in the [user guide](docs/GUIDE.md#1-installation).

## Quick start

This program is [`samples/QuickStart.dpr`](samples/QuickStart.dpr); it
compiles unchanged with Delphi and with FreePascal, and the comments show
what it prints.

```pascal
program QuickStart;

{
  The quick start of README.md: parse, validate, classify and format one
  number, format digits as they are typed and find numbers in a sentence.
  README.md shows this program verbatim; change both together.

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
  cwstring, // FreePascal on Unix: the widestring manager
  {$ENDIF}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.Types,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.PhoneNumberUtil,
  LibPhoneNumber.AsYouTypeFormatter,
  LibPhoneNumber.PhoneNumberMatcher;

var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Formatter: TAsYouTypeFormatter;
  Digits, Typed: UnicodeString;
  Matches: TPhoneNumberMatchArray;
  I: Integer;
begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8); // FreePascal: string is UTF-8
{$ENDIF}
  try
    // Parsing reports failure through its result, never through an exception.
    if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Number, Error) then
    begin
      WriteLn(TPhoneNumberUtil.Format(Number, pnfE164));          // +41446681800
      WriteLn(TPhoneNumberUtil.Format(Number, pnfInternational)); // +41 44 668 18 00
      WriteLn(TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, 'US'));
                                                                  // 011 41 44 668 18 00
      WriteLn(BoolToStr(TPhoneNumberUtil.IsValidNumber(Number), True)); // True
      WriteLn(NumberTypeToString(TPhoneNumberUtil.GetNumberType(Number)));
                                                                  // FIXED_LINE
    end
    else
      WriteLn('Not a phone number, error ', Ord(Error));

    // One formatter per input field; feed it one character at a time.
    Formatter := TAsYouTypeFormatter.Create('US');
    try
      Digits := '6502530000';
      for I := 1 to Length(Digits) do
        Typed := Formatter.InputDigit(Digits[I]);
      WriteLn(string(Typed));                                     // (650) 253-0000
    finally
      Formatter.Free;
    end;

    // Offsets are zero based, in UTF-16 code units, on both compilers.
    Matches := FindNumbers('Call 044 668 18 00 or +1 650-253-0000.', 'CH');
    for I := 0 to High(Matches) do
      WriteLn(Matches[I].Start, ': ', Matches[I].RawString);    // 5: 044 668 18 00
                                                                  // 22: +1 650-253-0000
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
```

`TPhoneNumberUtil` (unit `LibPhoneNumber.PhoneNumberUtil`) parses, validates,
types, formats and compares numbers; the other units are listed in the
[user guide](docs/GUIDE.md#2-the-units-you-use).

## FreePascal and Lazarus

On FreePascal `string` is an AnsiString, which the library treats as UTF-8.
For non ASCII input a program calls `SetMultiByteConversionCodePage(CP_UTF8)`
before the first library call and, on Unix, links `cwstring`, as the quick
start does; a Lazarus LCL application has both already. Offsets the matcher
reports are UTF-16 code units on both compilers. See
[Lazarus and FreePascal](docs/GUIDE.md#lazarus-and-freepascal) in the guide.

## Documentation

- [User guide](docs/GUIDE.md): installation, the units, parsing, validation,
  formatting, as-you-type formatting, short numbers, finding numbers in text,
  a Java/C# to Pascal mapping, FAQ.
- [Samples](samples/): one small program per task, with their checked output.
- [Known issues](KNOWN_ISSUES.md) and the [changelog](CHANGELOG.md).
- For contributors: [CONTRIBUTING.md](CONTRIBUTING.md),
  [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [AGENTS.md](AGENTS.md).

## Status

| upstream class | status | Pascal entry point |
| --- | --- | --- |
| `PhoneNumberUtil` | Ported: parsing (including RFC3966, extensions, Unicode digits, vanity numbers), `isPossibleNumber*`, `isValidNumber*`, `getNumberType`, `canBeInternationallyDialled`, region and calling code lookup, every `format*` method, `isNumberMatch`, example numbers, supported types, `isNumberGeographical`, area code and national destination code lengths, `truncateTooLongNumber`, and the two parse steps `maybeStripInternationalPrefixAndNormalize` and `maybeExtractCountryCode`. `isMobileNumberPortableRegion` is a metadata field, not a function. | `TPhoneNumberUtil` in `LibPhoneNumber.PhoneNumberUtil`; region and calling code lookup in `LibPhoneNumber.Metadata` and `LibPhoneNumber.MetadataCore` |
| `AsYouTypeFormatter` | Complete. | `TAsYouTypeFormatter` in `LibPhoneNumber.AsYouTypeFormatter` |
| `ShortNumberInfo` | Complete: possible and valid short numbers, expected cost, emergency numbers, carrier specific numbers, SMS services, example short numbers. | unit functions in `LibPhoneNumber.ShortNumberInfo` |
| `PhoneNumberMatcher` / `findNumbers` | Complete, all four leniency levels including the alternate format metadata for the grouping levels. | `FindNumbers` and `TPhoneNumberMatcher` in `LibPhoneNumber.PhoneNumberMatcher` |
| geocoder, carrier mapper, time zone mapper | Not ported. | - |

A few upstream test methods are not ported because they need a metadata loader
that can fail or proto fields the record does not model; see
[KNOWN_ISSUES.md](KNOWN_ISSUES.md).

Deliberate differences from upstream, all documented in the unit headers and
in the [guide](docs/GUIDE.md#17-differences-from-upstream-and-what-is-not-ported):

- No exceptions: `Parse` returns a `Boolean` plus a `TPhoneNumberParseError`;
  where upstream returns `null` there is a `TryGet...` function that returns
  `False`, or the empty string.
- `TPhoneNumber` is a record. `NationalNumberDigits` is the canonical national
  significant number (a significant leading zero survives there);
  `NationalNumber` is its lossy numeric value. `RegionCode` is an addition.
- Region arguments are canonicalised with `UpperCase(Trim(...))` by
  `TPhoneNumberUtil`, the `TAsYouTypeFormatter` constructor, `ShortNumberInfo`
  and the matcher. The low level unit functions (`LibPhoneNumber.Metadata`,
  `LibPhoneNumber.MetadataCore`, ...) take region codes exactly, like
  upstream.
- `pnfInternationalLegacy` is an extra display variant of the INTERNATIONAL
  format; `FindNumbers` returns an array.

## Requirements

- **Delphi**: developed and tested with Delphi 13 (compiler 37.0), Win64.
  Other targets and older versions are untested - reports are welcome. Only
  the RTL is used.
- **FreePascal**: 3.2.2, 3.2.4 and 3.3.1 in `{$MODE DELPHI}` (the units set it
  themselves); the tested version and platform combinations - Linux, Windows
  and macOS - are listed in the
  [manifest](AGENTS.md#current-state). The units use the `regexpr` unit of
  the FreePascal distribution.

## Why you can trust the results

- **Ported upstream test suites**: `PhoneNumberUtilTest`,
  `ShortNumberInfoTest`, `PhoneNumberMatcherTest` and `AsYouTypeFormatterTest`
  run against the upstream test metadata with the Java expected values.
- **One test suite, both compilers**: the same test program runs on Delphi and
  on every supported FreePascal version.
- **Differential against the C# port**: every example number of the metadata
  goes through parsing, formatting, validation and typing here and in
  [libphonenumber-csharp](https://github.com/twcclegg/libphonenumber-csharp)
  pinned to the same metadata release; no differences are allowed.
- **Byte identical on Delphi and FreePascal**: a runtime gate runs every
  example number, short number, parse input, as-you-type sequence and matcher
  text through a Delphi and a FreePascal build and compares the outputs.

How this is set up is described in
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md#test-strategy); how to run the
tests and gates in [CONTRIBUTING.md](CONTRIBUTING.md#running-the-tests-and-gates).
Metadata updates follow the
[vendor update workflow](AGENTS.md#vendor-update-workflow).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Wrong number DATA is almost always an
upstream metadata issue and goes to Google's libphonenumber; bugs of the port
go to this repository's issue tracker.

## License

Apache License 2.0, see [LICENSE](LICENSE) and [NOTICE](NOTICE). This is a
derivative work of Google's libphonenumber, which is licensed under the same
terms.
