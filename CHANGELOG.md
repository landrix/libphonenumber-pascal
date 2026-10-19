# Changelog

All notable changes to this repository are documented in this file.

## Unreleased

### Features

- The two parse driver steps upstream marks `@VisibleForTesting` are public on
  `TPhoneNumberUtil`:
  `MaybeStripInternationalPrefixAndNormalize(var ANumber, APossibleIddPrefix)`
  (upstream `maybeStripInternationalPrefixAndNormalize`) returns the
  `TCountryCodeSource` and leaves the number normalised, and
  `TryMaybeExtractCountryCode(ANumber, ADefaultRegionMetadata,
  var ANationalNumber, AKeepRawInput, var APhoneNumber, out ACountryCode,
  out AError)` (upstream `maybeExtractCountryCode`) reports upstream's
  `NumberParseException` as a False result plus `TPhoneNumberParseError`. The
  default region metadata is a source bound `PPhoneMetadataRec`, `nil` for
  upstream's `null`. `Parse` and `ParseAndKeepRawInput` run through both;
  with the production metadata their results are unchanged, with the testing
  metadata CO changes as described under Fixes.
- `testMaybeStripInternationalPrefix` and `testMaybeExtractCountryCode` of
  `PhoneNumberUtilTest` are ported, with the Java expected values, into the
  testing metadata fixture `tests/LibPhoneNumber.UpstreamSuite.Tests.pas`.

### Fixes

- `ParsePrefixAsIdd` treats an EMPTY international prefix like upstream: the
  compiled `""` is a zero length match, so the zero digit check alone decides
  (it answered False before). Only territories without an
  `internationalPrefix` attribute are affected - the nine production non
  geographical entities, which `Parse` never uses as the default region, and
  CO of the testing metadata, where a national number that does not start
  with 0 is now read as carrying a calling code (`123456` -> `+1 23456`,
  `6012345678` -> `INVALID_COUNTRY_CODE`), exactly as in Java. Production
  parse results are unchanged.
- `MaybeStripInternationalPrefixAndNormalize` compiles the prefix pattern
  before it normalises the number, as upstream: a malformed pattern raises
  `EArgumentException` and leaves the number unchanged.
- The regex layer validates every caller pattern on its own, unwrapped, before
  it compiles and caches the wrapped spelling. A malformed pattern that closes
  the wrapping group early (`)|(`, `a)|(b`) used to compile as a valid
  alternation; it is now a compile error like any other - the match and
  replace operations raise, `TryCompilePattern` answers False, and
  `FormatByPattern` skips such a user format. Metadata patterns are not
  affected. On FreePascal 3.2.2 (regexpr 0.987) the check uses the same
  counted quantifier rewrite decision as the wrapped compile, so valid
  patterns such as `a{0}`, `(?:a){6553}` and `(?:a{2}){2}` pass it there too,
  and the empty input probe validates the text it actually wraps (with `\A`
  turned into `^`). Known limitation there: `(?x)` comments are not modelled
  (KNOWN_ISSUES.md, permanent item 9).

## 0.1.0 - 2026-10-19

First release of the Pascal port of libphonenumber, built from upstream
metadata release 9.0.41.

The port grew out of a development line of
[LibPhonenumber-for-Delphi](https://github.com/landrix/LibPhonenumber-for-Delphi),
the .NET based wrapper. This repository starts as one fresh tree without that
history; the .NET bridge is not part of it.

### Features

- The port of `PhoneNumberUtil`, in three layers (see
  `docs/ARCHITECTURE.md`). The facade `TPhoneNumberUtil`
  (`LibPhoneNumber.PhoneNumberUtil`): parsing (`Parse`,
  `ParseAndKeepRawInput`, including the RFC3966 `tel:` / `phone-context` /
  `isub` forms, the complete extension pattern, Unicode decimal digits and
  vanity numbers), `IsPossibleNumber` / `IsValidNumber` on a string, every
  format (`E164`, `INTERNATIONAL`, `NATIONAL`, `RFC3966`, out of country,
  carrier code, by pattern, in original format, for mobile dialing, keeping
  alpha characters), the three `IsNumberMatch` overloads, and the accessory
  API (supported types, `IsNumberGeographical`, area code and national
  destination code lengths, mobile token, national significant number, the
  example number family, `TruncateTooLongNumber`, `IsAlphaNumber`). The
  unit functions of `LibPhoneNumber.MetadataCore` take calling code and
  national number: the `IsPossibleNumber*` / `IsValidNumber*` families (with
  reason, for type, for region), `GetNumberType` and the region resolution.
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

- The four central upstream test classes ported against the upstream TEST
  metadata, and production tests whose expected values come from the C#
  oracle `libphonenumber-csharp` 9.0.41.
- Mass differential against the oracle over every example number, metadata
  length compare gate against the upstream XML, FreePascal compile gate and a
  FreePascal runtime gate that compares a Delphi and a FreePascal build of one
  driver byte for byte.
- A console sample in `samples/` for both compilers.

### Tests on Delphi and FreePascal

- The suite runs without DUnitX (which the initial import still used), on a small test layer of its own in
  `tests/framework/`: `TTestCase` with virtual `Setup` / `TearDown`, tests as
  PUBLISHED methods found through the published method table (the Delphi
  layout and the packed / aligned layouts of FreePascal 3.2 / 3.3 are handled
  and cross-checked against `MethodAddress`), explicit `RegisterTest`, an
  `Assert` class source compatible with the DUnitX subset the suite uses, a
  console runner (`--filter`, `--junit`, `--verbose`, `--list`; exit code 0
  only when everything passed) and a minimal JSON reader that replaces
  `System.JSON`.
- One test program, `tests/LibPhoneNumberTests.dpr` (+ `.dproj`), for both
  compilers; it replaces `DUnitXCmdTest` and `DUnitXGuiRunner`. The test units
  were converted mechanically (attributes dropped, tests moved to `published`,
  `Setup` / `TearDown` as overrides). Beyond that: `{$MODE DELPHI}`,
  `{$CODEPAGE UTF8}` and `{$WARN 4105 OFF}` for FreePascal in every test unit;
  `System.IOUtils` / `System.JSON` replaced by the test layer; the data file
  lookup shared (`FindTestDataFile`, which also searches from the current
  directory); `TRegEx` in `LibPhoneNumber.Metadata.Tests` replaced by the
  port's regex layer on FreePascal only; and a handful of test-local lengths
  and offsets (the `CodePoints` helper, two string length preconditions, the
  match region of the upstream matcher helper) measured on the UTF-16 form,
  because on FreePascal `string` is UTF-8.
- `tools/run_fpc_tests.ps1` builds and runs the suite with FreePascal
  (`-Toolchain Wsl | Native | Mac`, `-FpcPath`, `-JUnit`, `-Filter`,
  `-BuildOnly`, `-RequireFpc`); `Native` also works under `pwsh` on Linux and
  macOS. The toolchain helpers it shares with `run_fpc_runtime_check.ps1`
  moved into `tools/fpc_toolchains.ps1`. `tools/run_delphi_tests.ps1` builds
  the new program and takes `-JUnit` and `-Filter`.
- `run_update_workflow.ps1` runs the FreePascal suite as a step of its own
  (`-SkipFpcTests`; `-RequireFpc` applies), and so does
  `run_pr_quick_check.ps1`.
- CI: a second job on Ubuntu 24.04 installs the distribution's FreePascal
  (3.2.2, x86_64) and runs the compile check, the whole suite with its JUnit
  report as an artifact, and the sample.

### Contributing

- `CONTRIBUTING.md` (where data issues go, the rules for changes, the checks
  before a pull request, Apache-2.0 inbound = outbound), issue templates for
  port bugs and feature requests with a contact link that routes metadata
  problems upstream (`.github/ISSUE_TEMPLATE/`), and a pull request template.

### Fixed before the release

- Regex layer on FreePascal 3.2.2: regexpr 0.987 answers "no match" for an
  EMPTY input whatever the pattern, while java.util.regex matches a pattern
  that can match the empty string against `""`. For an engine older than 1.0
  the layer now decides the empty input with a probe at the end of a one
  character input in multi line mode (`EmptyInputMatches`; `\A` rewritten to
  `^`), which keeps anchors inside the pattern exact, in all four operations;
  the two shapes it still answers wrongly on an empty input (a `(?-m)` group,
  a `(?#...)` comment with `[` before `\A`) occur in no metadata pattern
  (KNOWN_ISSUES.md, permanent item 8).
  Found by the FreePascal run of `EmptyInput_MatchesAPatternThatAllowsIt`,
  which now also covers the prefix match with groups, `find()`, both replace
  operations and anchored shapes (`a*$`, `(?:x|$)`, `^$`, `\Aa*`, `\b`,
  `\B`); the runtime gate driver probes the same shapes on Delphi and
  FreePascal. Delphi and regexpr 1.x are unchanged.
- Test runner: `--filter` without a non-empty entry is a usage error; an
  inherited published test runs once, as the concrete fixture's method.
  Relative `-WorkDir` / `-JUnit` paths of the FreePascal scripts (and of
  `run_delphi_tests.ps1`, `run_mass_differential.ps1`, `run_benchmark.ps1`)
  are made absolute first.
