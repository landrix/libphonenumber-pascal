# Changelog

All notable changes to this repository are documented in this file.

## 0.1.0 - unreleased

Initial import of the Pascal port of libphonenumber, built from upstream
metadata release 9.0.41.

The port grew out of a development line of
[LibPhonenumber-for-Delphi](https://github.com/landrix/LibPhonenumber-for-Delphi),
the .NET based wrapper. This repository starts as one fresh tree without that
history; the .NET bridge is not part of it.

### Features

- `TPhoneNumberUtil` (`LibPhoneNumber.PhoneNumberUtil`): the port of
  `PhoneNumberUtil` - parsing (`Parse`, `ParseAndKeepRawInput`, including the
  RFC3966 `tel:` / `phone-context` / `isub` forms, the complete extension
  pattern, Unicode decimal digits and vanity numbers), `IsPossibleNumber*`,
  `IsValidNumber*`, number type and region resolution, every format
  (`E164`, `INTERNATIONAL`, `NATIONAL`, `RFC3966`, out of country, carrier
  code, by pattern, in original format, for mobile dialing, keeping alpha
  characters), the three `IsNumberMatch` overloads, and the accessory API
  (supported types, `IsNumberGeographical`, area code and national
  destination code lengths, mobile token, national significant number, the
  example number family, `TruncateTooLongNumber`, `IsAlphaNumber`).
- `TAsYouTypeFormatter` (`LibPhoneNumber.AsYouTypeFormatter`): the port of
  `AsYouTypeFormatter`, including remembered positions.
- `LibPhoneNumber.ShortNumberInfo`: the port of `ShortNumberInfo` (possible and
  valid short numbers, expected cost, emergency numbers, carrier specific
  numbers, SMS services, example short numbers).
- `FindNumbers` / `TPhoneNumberMatcher` (`LibPhoneNumber.PhoneNumberMatcher`):
  the port of `PhoneNumberMatcher` with all four leniency levels; the grouping
  levels consult the alternate format metadata.
- Metadata generator `tools/generate_metadata.ps1`, a port of upstream
  `BuildMetadataFromXml.java`, producing nine units from four upstream XMLs
  (production, short number, test and alternate format metadata).
- Delphi and FreePascal (3.2.2, 3.2.4, 3.3.1) from the same source.

### Verification

- DUnitX suite with the four central upstream test classes ported against the
  upstream TEST metadata, and production tests whose expected values come from
  the C# oracle `libphonenumber-csharp` 9.0.41.
- Mass differential against the oracle over every example number, metadata
  length compare gate against the upstream XML, FreePascal compile gate and a
  FreePascal runtime gate that compares a Delphi and a FreePascal build of one
  driver byte for byte.
- A console sample in `samples/` for both compilers.
