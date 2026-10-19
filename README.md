# libphonenumber-pascal

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

The current metadata is built from upstream **libphonenumber 9.0.41**
(`google/libphonenumber` commit `33be566`); the exact pins are in
[`vendor/versions.md`](vendor/versions.md).

## Status

| upstream class | status | Pascal entry point |
| --- | --- | --- |
| `PhoneNumberUtil` | Ported: parsing (including RFC3966, extensions, Unicode digits, vanity numbers), `isPossibleNumber*`, `isValidNumber*`, `getNumberType`, region and calling code lookup, every `format*` method, `isNumberMatch`, example numbers, supported types, `isNumberGeographical`, area code and national destination code lengths, `truncateTooLongNumber`. A few upstream test methods are not ported because they test private parse steps or proto fields the record does not model; see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md). | `TPhoneNumberUtil` in `LibPhoneNumber.PhoneNumberUtil` |
| `AsYouTypeFormatter` | Complete. | `TAsYouTypeFormatter` in `LibPhoneNumber.AsYouTypeFormatter` |
| `ShortNumberInfo` | Complete: possible and valid short numbers, expected cost, emergency numbers, carrier specific numbers, SMS services, example short numbers. | unit functions in `LibPhoneNumber.ShortNumberInfo` |
| `PhoneNumberMatcher` / `findNumbers` | Complete, all four leniency levels including the alternate format metadata for the grouping levels. | `FindNumbers` and `TPhoneNumberMatcher` in `LibPhoneNumber.PhoneNumberMatcher` |
| geocoder, carrier mapper, time zone mapper | Not ported. | - |

Deliberate API differences from upstream, all documented in the unit headers:

- Parsing reports failure through a `Boolean` result plus a
  `TPhoneNumberParseError` instead of an exception.
- `TPhoneNumber` is a record. `NationalNumberDigits` is the canonical national
  significant number (a significant leading zero survives there);
  `NationalNumber` is its numeric value and therefore lossy. It replaces the
  `italianLeadingZero` / `numberOfLeadingZeros` proto fields.
- `TPhoneNumber.RegionCode` is an addition: the region the port reports for the
  number.
- Region arguments are canonicalised with `UpperCase(Trim(...))` at every public
  entry point.
- `pnfInternationalLegacy` is an extra display variant of the INTERNATIONAL
  format.
- Where upstream returns `null`, the port has a `TryGet...` function that
  returns `False`.

## Usage

Add `src/` to the unit search path. The units you use directly are
`LibPhoneNumber.Types`, `LibPhoneNumber.PhoneNumberUtil`,
`LibPhoneNumber.AsYouTypeFormatter`, `LibPhoneNumber.ShortNumberInfo` and
`LibPhoneNumber.PhoneNumberMatcher`; `LibPhoneNumber.MetadataCore` exports the
number type and region functions that take a calling code and national
number. Everything else is metadata or an internal layer.

### Delphi

```pascal
uses
  System.SysUtils,
  LibPhoneNumber.Types,
  LibPhoneNumber.PhoneNumberUtil,
  LibPhoneNumber.AsYouTypeFormatter,
  LibPhoneNumber.PhoneNumberMatcher;

var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Formatter: TAsYouTypeFormatter;
  Matches: TPhoneNumberMatchArray;
  Digit: Char;
begin
  if TPhoneNumberUtil.Parse('044 668 18 00', 'CH', Number, Error) then
  begin
    Writeln(TPhoneNumberUtil.Format(Number, pnfE164));           // +41446681800
    Writeln(TPhoneNumberUtil.Format(Number, pnfInternational));  // +41 44 668 18 00
    Writeln(TPhoneNumberUtil.FormatOutOfCountryCallingNumber(Number, 'US'));
                                                                  // 011 41 44 668 18 00
  end;
  Writeln(BoolToStr(TPhoneNumberUtil.IsValidNumber('044 668 18 00', 'CH'), True));

  Formatter := TAsYouTypeFormatter.Create('US');
  try
    for Digit in '6502530000' do
      Writeln(Formatter.InputDigit(Digit));                      // ... (650) 253-0000
  finally
    Formatter.Free;
  end;

  Matches := FindNumbers('Call 044 668 18 00 or +1 650-253-0000.', 'CH');
  // Matches[0].Start = 5, Matches[0].RawString = '044 668 18 00'
end;
```

### FreePascal

The same code compiles with FreePascal in Delphi mode. On FreePascal `string`
is an AnsiString, and the library treats it as **UTF-8**: lengths and offsets
are still computed on the UTF-16 form, exactly like Java and like the Delphi
build. The program has to make the conversion lossless:

```pascal
program Demo;

{$MODE DELPHI}{$H+}

uses
  {$IFDEF UNIX}
  cwstring,       // widestring manager; without it every non ASCII character becomes '?'
  {$ENDIF}
  SysUtils,
  LibPhoneNumber.Types,
  LibPhoneNumber.PhoneNumberUtil;

var
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  SetMultiByteConversionCodePage(CP_UTF8);   // before the first library call
  if TPhoneNumberUtil.Parse('+41 44 668 18 00', 'ZZ', Number, Error) then
    WriteLn(TPhoneNumberUtil.Format(Number, pnfNational));       // 044 668 18 00
end.
```

ASCII input works without either step; non ASCII input (full width digits,
Unicode punctuation, vanity text) needs both. Match offsets reported by
`FindNumbers` are UTF-16 code unit offsets on both compilers.

[`samples/`](samples/) contains a small console program that builds unchanged
with both compilers.

## Requirements

- **Delphi**: developed and tested with Delphi 13 (compiler 37.0), Win64. The
  units use only the RTL (`System.SysUtils`, `System.RegularExpressions`,
  `System.Character`, `System.SyncObjs`).
- **FreePascal**: 3.2.2, 3.2.4 and 3.3.1 are tested (Linux, Windows and macOS on
  aarch64; 3.2.2 also on Linux x86_64 in CI), in `{$MODE DELPHI}`. The units
  use the `regexpr` unit of the FreePascal distribution.
- **Tests**: nothing beyond the compiler. The test suite brings its own small
  test layer (`tests/framework/`) and runs unchanged on Delphi and on
  FreePascal; no DUnitX or FPCUnit is needed.
- **Tooling** (only for gates and metadata updates): PowerShell 7 and
  Windows PowerShell, `git`, the .NET 8 SDK for the reference oracle, and
  optionally WSL with FreePascal for the FreePascal gates.

## Tests and gates

```powershell
# The test suite on Delphi
powershell -ExecutionPolicy Bypass -File tools/run_delphi_tests.ps1

# The same test suite on FreePascal (WSL by default; -Toolchain Native for the
# fpc on PATH, -Toolchain Mac for the shared Mac toolchain)
pwsh -NoProfile -File tools/run_fpc_tests.ps1

# Quick gate: metadata regeneration check, length compare against the upstream
# XML, FreePascal compile and runtime checks, the FreePascal test suite and the
# Delphi compile of the test program
powershell -ExecutionPolicy Bypass -File tools/run_pr_quick_check.ps1

# Full gate, including the test run and the differential against the C# oracle
pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -FailOnDiff -RunMassDifferential
```

The upstream clones under `vendor/` are not part of the repository; clone
`google/libphonenumber` into `vendor/libphonenumber` (and
`twcclegg/libphonenumber-csharp` into `vendor/libphonenumber-csharp`) at the
commits in [`vendor/versions.md`](vendor/versions.md) before running the gates.

Which toolchain each entry point needs:

| entry point | Delphi missing | FreePascal missing |
| --- | --- | --- |
| `run_delphi_tests.ps1` | fails | not used |
| `run_fpc_tests.ps1` | not used | skipped with a warning; `-RequireFpc` makes it a failure |
| `run_pr_quick_check.ps1` | the compile-only build of the test program and the FreePascal runtime check (it needs a Delphi reference build) are skipped with a warning; `-RequireDelphi` makes the build a failure | the compile and runtime checks and the FreePascal test suite are skipped with a warning; `-RequireFpc` makes them a failure |
| `run_update_workflow.ps1` | the Delphi test run fails, and so does `-RunMassDifferential` (it builds the probe with Delphi); with `-SkipTests` and without `-RunMassDifferential` only the runtime check is skipped, with a warning | as for the quick check (`-RequireFpc`) |

The GitHub workflow (`.github/workflows/quick-check.yml`) has two jobs: the
quick check on a hosted Windows runner (no compiler there, so it covers the
generator and the compare gates), and a FreePascal job on Ubuntu that installs
the distribution's FreePascal and runs the compile check, the whole test suite
(JUnit report as an artifact) and the sample.

`run_update_workflow.ps1` also refreshes the reference cases from the oracle
unless `-SkipReference` is passed, which needs PowerShell 7 and the .NET 8 SDK;
the quick check skips that refresh by default. Every script is described in
[`tools/README.md`](tools/README.md), the test suite in
[`tests/README.md`](tests/README.md).

## Updating the metadata

1. Fast-forward the upstream clones and rewrite `vendor/versions.md`:
   `powershell -ExecutionPolicy Bypass -File tools/refresh_vendor_versions.ps1`
2. Set `Get-OraclePin` in `tools/oracle_helpers.ps1` to the
   `libphonenumber-csharp` NuGet release that matches the new metadata release,
   then record it: `powershell -ExecutionPolicy Bypass -File tools/refresh_vendor_versions.ps1 -SkipPull`
3. Regenerate and check, WITHOUT `-FailOnDiff` (the regenerated units are not
   committed yet, and the generated-unit check compares against the committed
   state): `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -RunMassDifferential`.
   This regenerates the metadata units, restores the new oracle and refreshes
   the reference cases, runs the FreePascal checks, the length compare, the
   Delphi tests and the mass differential. If the example number corpus
   changed size, the mass differential stops and asks for the new
   `-ExpectedCaseCount` default in `tools/run_mass_differential.ps1`.
4. Review the regenerated units, the compare summary
   (`tools/snapshots/generated_vs_upstream_diff.json`, all counters zero) and
   `tests/data/mass_differential_findings.json` (empty), update the manifest in
   `AGENTS.md` and `CHANGELOG.md`, and commit.
5. Verify the committed state:
   `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -FailOnDiff -RunMassDifferential`

Never edit a generated unit - change `tools/generate_metadata.ps1` instead.

## How correctness is established

- **Ported upstream test suites.** `PhoneNumberUtilTest`, `ShortNumberInfoTest`,
  `PhoneNumberMatcherTest` and `AsYouTypeFormatterTest` are ported and run
  against the upstream TEST metadata, which the generator produces as a
  separate data set, with the Java expected values verbatim.
- **One suite, both compilers.** The whole test suite is one program on a test
  layer of its own; it runs on Delphi and on FreePascal 3.2.2, 3.2.4 and 3.3.1
  with the same expectations.
- **Production tests against an oracle.** Everywhere else expected values are
  computed with the published C# port
  ([libphonenumber-csharp](https://github.com/twcclegg/libphonenumber-csharp))
  pinned to the same metadata release, never copied from the Java tests (they
  run on different metadata). Where Java and the C# port disagree, Java wins
  and the case is pinned as a documented divergence.
- **Mass differential.** Every example number of the metadata runs through
  parsing, the formats, validation, typing and region lookup in this port and
  in the C# oracle; the versioned findings file
  `tests/data/mass_differential_findings.json` must stay empty.
- **Metadata compare gate.** The possible-length model of the generated units is
  compared per territory against the upstream XML.
- **FreePascal runtime gate.** One driver program is built with Delphi and with
  FreePascal, runs over every example number, short number, parse input,
  formatter, as-you-type sequence and matcher text, and the two outputs must be
  byte identical.

Design notes, engine quirks and the closed design questions are in
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md); open items in
[KNOWN_ISSUES.md](KNOWN_ISSUES.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Wrong number DATA is almost always an
upstream metadata issue and goes to Google's libphonenumber; bugs of the port
go to this repository's issue tracker.

## License

Apache License 2.0, see [LICENSE](LICENSE) and [NOTICE](NOTICE). This is a
derivative work of Google's libphonenumber, which is licensed under the same
terms.
