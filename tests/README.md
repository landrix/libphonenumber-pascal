# Tests

This folder contains the test suite of the library. ONE test program,
`LibPhoneNumberTests.dpr`, runs every test on Delphi AND on FreePascal, on a
small test layer of its own in `framework/` - no DUnitX, no FPCUnit, nothing
outside the repository. The compiler versions it is run with are in the
`AGENTS.md` manifest.

> Test counts, gate counts and metadata baseline sizes are NOT maintained here.
> They live in the "Current State" manifest at the top of `AGENTS.md`; this file
> says what is covered and where the expectations come from.

Program and test layer:

1. `LibPhoneNumberTests.dpr` - the console test program, one source for both
   compilers; `LibPhoneNumberTests.dproj` builds it with Delphi (Win32/Win64,
   range and overflow checking on). It links every unit of `src/`, the
   testing metadata included. On FreePascal it sets
   `SetMultiByteConversionCodePage(CP_UTF8)` and links `cwstring` on Unix, the
   string contract of the library (KNOWN_ISSUES.md, permanent item 6).
2. `framework/LibPhoneNumber.TestFramework.pas` - `TTestCase` (virtual `Setup`
   / `TearDown`), the `Assert` class and the fixture registry. The tests of a
   fixture are its PUBLISHED methods, found through the published method
   table; the layouts of Delphi and of FreePascal 3.2 / 3.3 are handled in the
   unit and every entry is cross-checked against `MethodAddress`. As in
   DUnitX, one fixture instance serves all of its tests. `Assert` is source
   compatible with the DUnitX subset the suite uses: `AreEqual` /
   `AreNotEqual` for strings, Integer, Int64 and Boolean plus a generic
   `AreEqual<T>` for an explicit type argument (`Assert.AreEqual<UInt64>`),
   `IsTrue`, `IsFalse`, `Fail`, `IsNull`, `IsNotNull` - expected before actual,
   optional message. A failure shows expected and actual. FreePascal 3.2 has
   no implicit specialization, so a generic call always names its type
   argument.
3. `framework/LibPhoneNumber.TestRunner.pas` - the console runner:
   `--filter <Fixture>[.<Test>]` (repeatable, comma separated, case
   insensitive; a filter that matches nothing is an error), `--junit <file>`
   (JUnit XML, UTF-8), `--verbose` (every test and its log lines), `--list`.
   A failed assertion is a FAIL, any other exception an ERROR; the run always
   continues. Exit code 0 only when every selected test passed, 1 for a
   failure or an error, 2 for a usage error or a run without tests.
4. `framework/LibPhoneNumber.TestJson.pas` - a minimal JSON reader with the
   System.JSON class names (`TJSONObject.ParseJSONValue`, `GetValue`,
   `GetString`, `GetBoolean`, `TryGetString`, `TJSONArray.Items`), the UTF-8
   file reader and `FindTestDataFile`, which finds `tests/data` upwards from
   the executable and from the current directory.

Fixture conventions:

1. A fixture derives from `TTestCase`; its tests are `published`, everything
   else (helpers, the `Setup` / `TearDown` overrides) is `private` or
   `public`. Every fixture is registered in its unit's `initialization`
   section with `RegisterTest(TSomeTests)`; there is no attribute scan.
2. Every test unit starts with the same FreePascal block: `{$MODE DELPHI}`,
   `{$CODEPAGE UTF8}` (the sources are pure ASCII and spell non ASCII
   characters as `#$XXXX`; without a source code page FreePascal converts such
   a constant to `string` at compile time and loses every character outside
   its default code page) and `{$WARN 4105 OFF}` (the implicit
   UnicodeString / `string` conversions are the documented contract). A
   length, index or offset that upstream measures on a Java String is measured
   on the `UnicodeString` form in the tests too, because on FreePascal
   `string` is UTF-8.
3. A fixture that needs the upstream TESTING metadata switches it in `Setup`
   with `LibPhoneNumber.TestingMetadata.UseTestingMetadata` and back in
   `TearDown` with `RestoreProductionMetadata` from the same unit. Do not call
   `LibPhoneNumber.Metadata.UseProductionMetadata` directly - the pair in
   `TestingMetadata` also drops the compiled pattern cache.
4. Metadata record pointers are source bound: a switch invalidates every
   `PPhoneMetadataRec` handed out before it. Fetch metadata inside the test,
   never in `Setup`, and never store such a pointer in a fixture field.

Where expected values come from: see "Test Expectations" in `AGENTS.md`. In
short, production tests take the test IDEA from upstream and the VALUE from the
NuGet oracle or the production XML; only the four `UpstreamSuite` units, which
run on the testing metadata, copy Java values verbatim.

Test units:

1. `LibPhoneNumber.PhoneNumberUtil.Tests.pas` - the facade: parsing (including
   the complete upstream extension pattern, RFC3966, Unicode digits, IDD
   prefixes), formatting, the extended formatters, `IsNumberMatch`, the
   accessory API, the reference corpus differentials and table consistency of
   the generated data sets.
2. `LibPhoneNumber.Metadata.Tests.pas` - the generated tables and the lookup
   layer.
3. `LibPhoneNumber.MetadataCore.Tests.pas` - validation and typing, the regex
   layer, the format engine, the parse helpers, the Unicode digit table, and
   two oracle anchored parser gates: `ReferenceCases_E164MatchesTheOracle`
   (every reference case parses to the recorded C# E164) and
   `ExampleNumbers_RoundTripThroughTheParser` (every example number survives an
   E164 round trip in its own region and stays valid). Their divergence
   inventories are empty; keep them empty.
4. `LibPhoneNumber.AsYouTypeFormatter.Tests.pas` - the AsYouTypeFormatter,
   `FormatNumberForMobileDialing` and `FormatOutOfCountryKeepingAlphaChars`,
   driven by `data/aytf_reference_cases.json`.
5. `LibPhoneNumber.ShortNumberInfo.Tests.pas` - the short number metadata and
   `ShortNumberInfo`. Its mass gate runs the `shortCode` example number of every
   short number territory through `IsPossibleShortNumberForRegion` and
   `IsValidShortNumberForRegion`. No value comes from `ShortNumberInfoTest.java`:
   there is no `ShortNumberMetadataForTesting.xml` upstream, so that suite reads
   the production short number data, but through a PhoneNumberUtil built on the
   TEST phone metadata, so `getRegionCodesForCountryCode` answers differently
   there.
6. `LibPhoneNumber.PhoneNumberMatcher.Tests.pas` - `FindNumbers` and the four
   leniency levels; its mass gate builds "Call me at <international> or
   <national>." from the FIXED_LINE example number of a fixed set of regions. READ ITS
   HEADER BEFORE CHANGING AN EXPECTATION: the C# `PhoneNumberMatcher` is not a
   current translation of the Java one, so the oracle is only a partial
   reference there and the disagreeing cases are pinned as Java-versus-oracle
   divergences.
7. The four ported upstream suites - `LibPhoneNumber.UpstreamSuite.Tests.pas`
   (`PhoneNumberUtilTest`), `.ShortNumber.Tests.pas` (`ShortNumberInfoTest`),
   `.Matcher.Tests.pas` (`PhoneNumberMatcherTest`) and
   `.AsYouTypeFormatter.Tests.pas` (`AsYouTypeFormatterTest`). Their `Setup`
   switches to the generated TESTING tables, so they read the same data the
   Java suite reads. Do not "verify" a value there with the oracle. Every
   omission - Java methods that need a failing metadata loader or proto
   fields the record does not model, single
   assertions marked UPSTREAM ONLY, `testRemovalNotSupported` - is listed with
   its reason in the header of its unit. `Test_MaybeStripNationalPrefix`
   installs a complete synthetic one-territory data set for the duration of the
   test, which is how the Java case builds its `PhoneMetadata` by hand.

Data files:

1. `data/core_golden_cases.json`: parser-focused baseline cases.
2. `data/reference_cases_java_csharp.json`: the reference corpus (Java/C#
   expectations per input) for the differential tests. Refresh with
   `pwsh -NoProfile -ExecutionPolicy Bypass -File tools\generate_reference_cases.ps1`.
3. `data/aytf_reference_cases.json`: GENERATED oracle expectations for the
   AsYouTypeFormatter, `formatNumberForMobileDialing` and
   `formatOutOfCountryKeepingAlphaChars`. Refresh with
   `pwsh -NoProfile -ExecutionPolicy Bypass -File tools\generate_aytf_cases.ps1`;
   never edit it by hand and never copy a value out of
   `AsYouTypeFormatterTest.java`, which runs against the TESTING metadata.
4. `data/mass_differential_findings.json`: written by
   `tools\run_mass_differential.ps1`; versioned and meant to stay empty.

Reference generation:

1. The reference oracle is the NuGet package `libphonenumber-csharp`, pinned to
   the metadata release of the Java baseline by `Get-OraclePin` in
   `tools/oracle_helpers.ps1` and restored into the git-ignored cache
   `tools/.nuget-oracle/`. The scripts require PowerShell 7 (`pwsh`).
2. Optionally pass a custom file path:
   `tools\generate_reference_cases.ps1 -ReferenceFile <path>`.
3. For curated cases the `java*` values are preserved when already present; for
   auto-generated `* auto example` cases they are always refreshed from the
   oracle.
4. The generator ABORTS WITHOUT WRITING when a case cannot be recomputed.
   `-AllowPartial` overrides this for a deliberate, documented exception.

Running the suite:

1. Delphi: `tools\run_delphi_tests.ps1` builds `LibPhoneNumberTests.dproj`
   with msbuild for Win64/Debug and runs it. `-BuildOnly` compiles and stops
   (the Delphi compile gate of `run_pr_quick_check.ps1`); `-Filter` and
   `-JUnit <file>` are handed to the runner; `-StudioRoot` selects another
   RAD Studio, e.g.
   `tools\run_delphi_tests.ps1 -StudioRoot "C:\Program Files (x86)\Embarcadero\Studio\37.0"`.
2. FreePascal: `tools\run_fpc_tests.ps1` builds the same program with
   FreePascal and runs it: `-Toolchain Wsl` (the default, FPC 3.2.4 in WSL),
   `Native` (the `fpc` on PATH - Windows, or Linux / macOS under `pwsh`, which
   is what CI uses) or `Mac` (the shared Mac toolchain), plus `-FpcPath`,
   `-Filter`, `-JUnit`, `-BuildOnly` and `-RequireFpc`.
3. By hand, from this folder:
   `fpc -Mdelphi -Sh -Cr -Co -Fu../src -Fuframework -FUbin/units -FEbin LibPhoneNumberTests.dpr`,
   then `bin/LibPhoneNumberTests`; with Delphi open `LibPhoneNumberTests.dproj`.
4. Both scripts throw on a non zero exit code of the runner, so failures
   propagate to `run_update_workflow.ps1` and `run_pr_quick_check.ps1`. The
   GitHub workflow runs the FreePascal suite on Ubuntu (the distribution's
   FreePascal, x86_64) and uploads the JUnit report.

The FreePascal runtime gate (`tools/run_fpc_runtime_check.ps1`) stays a gate
of its own: the suite checks expectations, the runtime gate checks that a
Delphi and a FreePascal build agree byte for byte over a far larger input
space.
