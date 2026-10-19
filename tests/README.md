# Tests

This folder contains the DUnitX test suite of the library (Delphi).

> Test counts, gate counts and metadata baseline sizes are NOT maintained here.
> They live in the "Current State" manifest at the top of `AGENTS.md`; this file
> says what is covered and where the expectations come from.

Projects:

1. `DUnitXCmdTest.dpr` / `.dproj` - the console runner every script uses. It
   links every unit of `src/`, the testing metadata included.
2. `DUnitXGuiRunner.dpr` / `.dproj` - a VCL GUI runner for interactive use.
3. Both projects use the DUnitX that ships with Delphi. To use another DUnitX
   checkout, set the environment variable `DUNITX` to its source folder; the
   projects put `$(DUNITX)` first on the unit search path.

Fixture conventions:

1. Every fixture class carries `[TestFixture]` AND is registered explicitly in
   the unit's `initialization` section with
   `TDUnitX.RegisterTestFixture(TSomeTests)`. The explicit call is what keeps a
   fixture in the run if a linker or RTTI setting ever drops the attribute.
2. A fixture that needs the upstream TESTING metadata switches it in `Setup`
   with `LibPhoneNumber.TestingMetadata.UseTestingMetadata` and back in
   `TearDown` with `RestoreProductionMetadata` from the same unit. Do not call
   `LibPhoneNumber.Metadata.UseProductionMetadata` directly - the pair in
   `TestingMetadata` also drops the compiled pattern cache.
3. Metadata record pointers are source bound: a switch invalidates every
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
   omission - Java methods that test private parse driver steps, a failing
   metadata loader or proto fields the record does not model, single
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

CLI test run:

1. `tools\run_delphi_tests.ps1` builds and executes `DUnitXCmdTest` for
   Win64/Debug. `-BuildOnly` compiles the project and stops; that is the Delphi
   compile gate `run_pr_quick_check.ps1` uses.
2. Optional custom RAD Studio root:
   `tools\run_delphi_tests.ps1 -StudioRoot "C:\Program Files (x86)\Embarcadero\Studio\37.0"`.
3. `DUnitXCmdTest` exits with code `1` when tests fail or error, and only
   pauses when `--exitbehavior:Pause` is passed, so failures propagate to
   `run_delphi_tests.ps1` and `run_update_workflow.ps1`.

The DUnitX suite is Delphi only. FreePascal behaviour is covered by the
FreePascal runtime gate (`tools/run_fpc_runtime_check.ps1`), which runs every
unit of `src/` on FreePascal and compares its output byte for byte with a
Delphi build.
