# AGENTS.md

Working notes for anyone - person or tool - who changes this repository. Read
this first; `docs/ARCHITECTURE.md` has the design, `KNOWN_ISSUES.md` the open
items.

## Project scope

libphonenumber-pascal is a literal Object Pascal port of Google's
libphonenumber for Delphi AND FreePascal: `src/` holds the library (hand
written units plus generated metadata units), `tests/` the test suite (one
program on a test layer of its own in `tests/framework/`, for Delphi and
FreePascal), `tools/` the generator and the gates, `samples/` a console
sample.

## Current State

**THIS SECTION IS THE MANIFEST.** Every fast moving number of this repository -
gate counts, unit counts, test counts, baseline sizes - is maintained HERE and
nowhere else. `README.md`, `docs/ARCHITECTURE.md`, `tools/README.md` and
`tests/README.md` describe what things are and point at this section for how
many there are; a number repeated in one of them is a bug in that file. Update
this block, with its date, in the same change that moves a number.

As of 2026-10-19 (the facade takes a parsed `TPhoneNumber` for every validation, typing and region method upstream offers on a `PhoneNumber`, four tests more; the parse driver steps `maybeStripInternationalPrefixAndNormalize` and `maybeExtractCountryCode` are public, their two upstream tests are ported, and an empty international prefix is a zero length IDD match as upstream - CO of the testing metadata parses differently, production does not; the regex layer validates every pattern unwrapped as well; the workflow and the quick check run the FreePascal runtime gate and test suite on WSL FreePascal 3.2.4 AND 3.2.2 by default):

| item | value |
| --- | --- |
| Test suite (Delphi + FreePascal) | 567 tests in 10 fixtures, one program `tests/LibPhoneNumberTests.dpr`, all green on Delphi 13 Win64 (`tools/run_delphi_tests.ps1`) and on FreePascal 3.2.4 aarch64-linux (WSL, the default), 3.2.2 aarch64-linux (WSL distribution package), 3.3.1 aarch64-linux (WSL), 3.3.1 aarch64-win64 and 3.2.4 aarch64-darwin (Mac), plus 3.2.2 x86_64-linux (Ubuntu 24.04 distribution package, verified in an emulated container; CI) |
| FreePascal test suite gate | `tools/run_fpc_tests.ps1`: build + run about 25-30 s on WSL, 8 s Native, 7 s on the Mac; a step of `run_update_workflow.ps1` (`-SkipFpcTests`) and of `run_pr_quick_check.ps1`, run once per `-FpcToolchains` entry - by default WSL 3.2.4 AND WSL 3.2.2 (`/usr/bin/fpc`); the whole quick check about 110 s with both toolchains on an otherwise idle machine |
| CI | `.github/workflows/quick-check.yml`: job `quick-check` (windows-latest; generator, generated unit check, compare gate - no compiler) and job `freepascal` (ubuntu-24.04, distribution FPC 3.2.2 x86_64: compile check, the whole suite with a JUnit artifact, the sample). `.github/workflows/upstream-release-check.yml` (ubuntu-latest, weekly and manual): `tools/check_upstream_release.ps1` opens an issue when google/libphonenumber has a release newer than `Get-OraclePin` |
| Generator inputs | 4 upstream XMLs |
| Generated units | 9 (`Metadata.{Data,Descs,Formats}`, `ShortMetadata.{Data,Descs}`, `TestingMetadata.{Data,Descs,Formats}`, `AlternateFormats.Data`) |
| Hand written `src/` units | 13 |
| FreePascal compile gate | 12 units listed = every hand written unit of `src/` (`LibPhoneNumber.Metadata.Types` is compiled through `LibPhoneNumber.Metadata`), the facade and the matcher included |
| FreePascal runtime gate | `tools/run_fpc_runtime_check.ps1`, the same 12 units: 74468 observation lines (18923618 bytes). Core sections: 1144 production + 93 testing phone examples, 961 short number examples, 137 tricky inputs, 2784 AYTF sequences, 5548 compiled patterns each also compiled and matched in its counted quantifier rewrite - longest rewrite 1439 chars against a budget of 32768, 0 over budget - 71 targeted regex/rewrite/budget probes (19 of them on the empty input), 471 BMP class ranges. Facade and matcher sections (production and testing metadata): 1144 + 93 examples parsed back and found in sentences, 6938 parse inputs (6233 parse), 290 example number lookups (regions + non geo entities), 247 reference corpus cases, 17 mobileDialing + 12 keepingAlphaChars cases, 16196 matcher texts = 80980 `FindNumbers` calls with 63058 matches. The summary must show 0 exceptions, pattern failures, rewrite mismatches and expansion probe failures and a positive count in every section. Byte identical between Delphi and FPC 3.2.4 aarch64-linux (WSL, mandatory), 3.2.2 aarch64-linux (WSL, mandatory: `run_update_workflow.ps1` and `run_pr_quick_check.ps1` run the gate once per `-FpcToolchains` entry, by default these two, against ONE Delphi reference build), 3.3.1 aarch64-win64 (Windows) and 3.2.4 aarch64-darwin (Mac); before the import also 3.3.1 aarch64-linux (WSL). FPC build + run about 18-21 s per WSL toolchain, Delphi build + run about 9-11 s (once per workflow run). RTL Unicode category sweep (reported, not gated): identical on 3.3.1, differs on 3.2.x (KNOWN_ISSUES.md, permanent item 7) |
| Length compare gate | 254/254 territories, all four counters zero |
| Mass differential | 1144 cases x 9 APIs = 10296 compared fields, 0 findings |
| Reference corpus | 247 cases in `tests/data/reference_cases_java_csharp.json` |
| Ported upstream suites | `PhoneNumberUtilTest` 117/121, `ShortNumberInfoTest` 28/28, `PhoneNumberMatcherTest` 45/46, `AsYouTypeFormatterTest` 33/33 |
| Phone metadata baseline | 254 territories (245 regions + 9 non geo), 215 calling codes, 3048 descriptions (1144 with an example number), 761 national + 205 international formats |
| Short number baseline | 241 territories, 1928 descriptions (961 with an example number), 149 pooled possible lengths, 1202 patterns |
| Testing metadata baseline | 36 territories (33 regions + 3 non geo), 29 calling codes, 432 descriptions (93 with an example number), 69 national + 12 international formats, 71 leadingDigits patterns, 66 pooled possible lengths |
| Alternate formats baseline | 46 calling codes, 158 national formats, 79 leadingDigits patterns |
| Upstream baseline | libphonenumber metadata release 9.0.41: Java `33be5664343676b27761213d8f5500d682568ea7`, C# `e7bba34432f7f4cee7c8f34b9912a1f9369fc0d8` (`vendor/versions.md`) |
| Reference oracle | NuGet `libphonenumber-csharp` 9.0.41 on `net8.0`; the canonical pin is `Get-OraclePin` in `tools/oracle_helpers.ps1` |
| Generator labels | `metadata-v1`, `testing-metadata-v1`, `short-metadata-v1`, `alternate-formats-v1` (`tools/show_metadata_info.ps1`) |
| Classes in the library | 2 with state: `TAsYouTypeFormatter` and `TPhoneNumberMatcher`; plus the stateless facade `TPhoneNumberUtil` (class functions only). Everything else is unit level functions. |

## Core Status

What is ported, and where it lives (details in `docs/ARCHITECTURE.md`):

1. `src/LibPhoneNumber.PhoneNumberUtil.pas` - facade `TPhoneNumberUtil`: the
   parse driver (`Parse`, `ParseAndKeepRawInput`; private `ParseHelper`;
   public steps `MaybeStripInternationalPrefixAndNormalize`,
   `TryMaybeExtractCountryCode`), `IsPossibleNumber`, `IsValidNumber` (string
   and record overloads), the record taking `IsValidNumberForRegion`,
   `GetNumberType`, `GetRegionCodeForNumber`, `IsPossibleNumber*WithReason`,
   `IsPossibleNumberForType` and `CanBeInternationallyDialled`, `Format`
   and every extended formatter, `FormatInOriginalFormat`, the three
   `IsNumberMatch` overloads, and the parse based half of the accessory API
   (`GetNationalSignificantNumber`, the example number family, record taking
   wrappers).
2. `src/LibPhoneNumber.MetadataCore.pas` - validation, typing, region
   resolution, `testNumberLength`, the metadata free entry path of
   `parseHelper` (`ExtractPossibleNumber`, `IsViablePhoneNumber`,
   `MaybeStripExtension`, `TryBuildNationalNumberForParsing`), the parse
   helpers (`maybeStripNationalPrefixAndCarrierCode`, `extractCountryCode`,
   `parsePrefixAsIdd`), the `normalizeHelper` tables, the Unicode digit
   primitives, the scanners, and the parse free accessory API.
3. `src/LibPhoneNumber.MetadataFormat.pas` - the format engine and the
   extended formatters, `GetLengthOfNationalDestinationCode`,
   `GetLengthOfGeographicalAreaCode`.
4. `src/LibPhoneNumber.Regex.pas` - the regex abstraction (PCRE on Delphi,
   TRegExpr on FreePascal), Java replacement semantics, the regexpr 0.987
   workarounds, the pattern cache.
5. `src/LibPhoneNumber.AsYouTypeFormatter.pas` - `TAsYouTypeFormatter`.
6. `src/LibPhoneNumber.ShortNumberInfo.pas` - the `ShortNumberInfo` port (no
   facade wrapper, by design).
7. `src/LibPhoneNumber.PhoneNumberMatcher.pas` - `FindNumbers`,
   `TPhoneNumberMatcher`, the four leniency levels; `checkNumberGroupingIsValid`
   consults the alternate format metadata.
8. Lookup layers: `LibPhoneNumber.Metadata` (phone metadata, switchable),
   `LibPhoneNumber.ShortMetadata`, `LibPhoneNumber.AlternateFormats`,
   `LibPhoneNumber.TestingMetadata` (test builds only); data model
   `LibPhoneNumber.Metadata.Types`; public value types `LibPhoneNumber.Types`.

Not ported: geocoder, carrier mapper, time zone mapper.

## Operative rules

1. **Never edit a generated unit.** The nine `*.Data` / `*.Descs` /
   `*.Formats` units are the output of `tools/generate_metadata.ps1`; change the
   generator and regenerate. Never add a hand maintained data table next to
   them.
2. **Keep the port literal.** New behaviour is ported from the Java upstream,
   with the C# oracle as a cross-check where it is a current translation. Java
   is the functional source of truth.
3. **FreePascal compatibility is mandatory.** Every hand written unit of `src/`
   compiles with Delphi and with FreePascal (`{$MODE DELPHI}`) and is in both
   FreePascal gates. On FreePascal `string` is UTF-8; every length, index and
   character test upstream performs on a Java String is performed on the
   UTF-16 (UnicodeString) form. No non ASCII `string` constant may be built in
   an initialization section. A change that only compiles on Delphi is not
   done. The same holds for the test suite: it runs on both compilers, and a
   test that fails on FreePascal is a finding to root-cause, never a test to
   skip.
4. **Add tests first** when a behaviour change touches already ported code,
   then change the port.
5. Keep changes focused; do not reformat unrelated code.
6. Substantial changes get a second, independent code review (Codex CLI).

## Test Expectations

Never copy an expected value out of `PhoneNumberUtilTest.java` or its C#
counterpart. Those suites run against `PhoneNumberMetadataForTesting.xml`,
which differs from the shipped `PhoneNumberMetadata.xml` for several
territories (AR, AU, MX and UZ among them). Take the test IDEA from upstream
and recompute the value with the NuGet oracle (see Reference Oracle) or read it
off the production XML, then record in the test where the value came from.

**The ONE exception: the testing-metadata fixtures.** Values from the Java test
suite are correct ONLY in a fixture that actually runs against the testing
metadata, i.e. one whose `Setup` calls
`LibPhoneNumber.TestingMetadata.UseTestingMetadata` and whose `TearDown` calls
`LibPhoneNumber.TestingMetadata.RestoreProductionMetadata`. Exactly four units
do that:

1. `tests/LibPhoneNumber.UpstreamSuite.Tests.pas` (`PhoneNumberUtilTest`)
2. `tests/LibPhoneNumber.UpstreamSuite.ShortNumber.Tests.pas` (`ShortNumberInfoTest`)
3. `tests/LibPhoneNumber.UpstreamSuite.Matcher.Tests.pas` (`PhoneNumberMatcherTest`)
4. `tests/LibPhoneNumber.UpstreamSuite.AsYouTypeFormatter.Tests.pas` (`AsYouTypeFormatterTest`)

Inside those four, copy the Java value verbatim and do NOT recompute it with
the oracle - the oracle ships the PRODUCTION metadata and would give a
different, equally correct answer for a different data set. A new test file
that wants Java values has to switch the metadata the same way and say so in
its header.

The matcher is the one place where the oracle is only a partial reference: the
C# `PhoneNumberMatcher` deviates from the Java one in five documented places
(header of `tests/LibPhoneNumber.PhoneNumberMatcher.Tests.pas`).

## Metadata Source Switching

`src/LibPhoneNumber.Metadata.pas` reads an ACTIVE data set
(`TPhoneMetadataTables`, declared in `LibPhoneNumber.Metadata.Types`).

1. The initialization section installs `ProductionMetadataTables`.
2. `UseMetadataTables` swaps the whole record at once and does nothing else.
   The hygienic pattern cache drop lives in `LibPhoneNumber.TestingMetadata`
   (`UseTestingMetadata` / `RestoreProductionMetadata`); fixtures use that pair.
3. Records and pointers from the metadata layer are SOURCE BOUND: a switch
   invalidates every `PPhoneMetadataRec` / `PPhoneNumberDescRec` /
   `PNumberFormatRec`. Fetch metadata inside the test, never in fixture setup.
4. Not thread safe, deliberately. Switch from test setup/teardown only.
5. `LibPhoneNumber.TestingMetadata` is the only unit that names the testing
   tables; nothing under `src/` uses it; only test programs link it.
6. The SHORT number metadata and the ALTERNATE FORMAT metadata are never
   switched, as upstream.

## Source of Truth

1. Java upstream is the primary functional source of truth.
2. C# upstream is the implementation-near cross-check.
3. Behaviour is validated differentially against Java/C# wherever the port
   claims support.

## Vendor Update Workflow

The upstream clones `vendor/libphonenumber` and `vendor/libphonenumber-csharp`
are git-ignored; `vendor/versions.md` records the pinned commits and the oracle
package. To set them up from scratch, clone both repositories there and check
out the pinned commits. To refresh upstream:

1. `powershell -ExecutionPolicy Bypass -File tools/refresh_vendor_versions.ps1`
   (fast-forwards both clones and rewrites `vendor/versions.md`).
2. Set `Get-OraclePin` in `tools/oracle_helpers.ps1` to the
   `libphonenumber-csharp` release matching the new metadata release, then
   `powershell -ExecutionPolicy Bypass -File tools/refresh_vendor_versions.ps1 -SkipPull`
   to record the new pin in `vendor/versions.md`.
3. `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -RunMassDifferential`
   WITHOUT `-FailOnDiff`: the regenerated units are not committed yet, and the
   generated-unit check compares against the committed state. This run
   regenerates the units, restores the new oracle and refreshes the reference
   cases, and runs the FreePascal checks, the length compare, the Delphi tests
   and the mass differential. Without `-FailOnDiff` a non-zero compare or a
   finding does not stop the run, so read the compare summary and
   `tests/data/mass_differential_findings.json`. If the example number corpus
   changed size, the mass differential throws: update the `-ExpectedCaseCount`
   default of `tools/run_mass_differential.ps1`. Regenerating
   `tests/data/aytf_reference_cases.json` (`tools/generate_aytf_cases.ps1`) is
   a separate, conscious step.
4. Review the diffs, update the manifest above and `CHANGELOG.md`, commit.
5. `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -FailOnDiff -RunMassDifferential`
   verifies the committed state; `tools/run_pr_quick_check.ps1` is the cheap
   variant.

What the workflow does, in order: refresh the reference cases (child `pwsh`;
`-SkipReference` opts out), regenerate the metadata units (`-SkipMetadataGen`),
with `-FailOnDiff` verify with `git status --porcelain` that the nine generated
units equal the committed state, the FreePascal compile check
(`-SkipFpcCheck`), the FreePascal runtime check (`-SkipFpcRuntime`), the
FreePascal test suite (`tools/run_fpc_tests.ps1`; `-SkipFpcTests`), the
length compare gate (export snapshot, extract upstream rules, compare; with
`-FailOnDiff` a non-zero counter fails), the Delphi test suite (`-SkipTests`,
which skips the Delphi run only) and, with `-RunMassDifferential`, the mass
differential (a hard gate with `-FailOnDiff`). The runtime check and the
FreePascal test suite run once per entry of `-FpcToolchains` (`<Toolchain>` or
`<Toolchain>=<compiler path>`; default `Wsl`, `Wsl=/usr/bin/fpc`, i.e. the WSL
FreePascal 3.2.4 and the 3.2.2 of the distribution package, whose regexpr
0.987 takes code paths of its own in the regex layer); every runtime run is
compared against the same Delphi reference, which is built once. Pass one
entry to restrict both steps (`-FpcToolchains Wsl`). `-RequireFpc` turns a
missing FreePascal into a failure in all three FreePascal steps, for EVERY
configured toolchain; without it an unreachable toolchain is skipped with a
warning and the others still run. The workflow needs
Delphi for the Delphi test run and for the mass
differential (`run_delphi_tests.ps1` throws without it); a missing Delphi only
skips the FreePascal runtime check with a warning, and the workflow has no
`-RequireDelphi`. The `-FailOnDiff` check compares against the committed state:
a generated unit that is not committed yet (for example before the first
commit) counts as differing.

`run_pr_quick_check.ps1` is the workflow with `-FailOnDiff -SkipTests
-SkipReference` - so the FreePascal test suite DOES run (`-SkipFpcTests` opts
out) - plus a compile-only build of the Delphi test program
(`run_delphi_tests.ps1 -BuildOnly`); missing Delphi or FreePascal are warnings
(`-RequireDelphi`, `-RequireFpc`). The GitHub workflow
`.github/workflows/quick-check.yml` has two jobs: `quick-check` runs the quick
check on a hosted Windows runner, which has neither compiler (it fetches the
pinned upstream commit first); `freepascal` installs the FreePascal of the
Ubuntu distribution and runs `check_fpc_compile.ps1 -RequireFpc`,
`run_fpc_tests.ps1 -Toolchain Native -RequireFpc` with the JUnit report
uploaded as an artifact, and the FreePascal build and run of the sample.
Neither runner has WSL, so the WSL toolchains of `-FpcToolchains` are skipped
there with a warning.

`.github/workflows/upstream-release-check.yml` runs
`tools/check_upstream_release.ps1` weekly (and on demand): when
google/libphonenumber has a `vX.Y.Z` tag newer than `Get-OraclePin`, it opens
the issue "Upstream libphonenumber vX.Y.Z released" with the NuGet status of
the matching `libphonenumber-csharp` and the steps above - that issue is the
trigger for a refresh. An open issue for the same version (matched by title) is never
duplicated; an open issue for an older version is commented on and closed as
superseded, but only when it carries the script's hidden body marker
`<!-- upstream-release-check -->` - issues opened by a person are left alone.

Interpretation:

1. Compare summary all zeros AND every generated unit reported `current`:
   nothing has drifted.
2. A non-zero compare means the generator, the emitted tables or the pinned
   XML disagree about possible lengths. Fix the generator, never the generated
   unit.

## Reference Oracle

`tools/generate_reference_cases.ps1`, `tools/generate_aytf_cases.ps1` and
`tools/run_mass_differential.ps1` load the NuGet package
`libphonenumber-csharp` (restored through a generated `net8.0` host project into
the git-ignored cache `tools/.nuget-oracle/`); the vendor C# source is never
built.

1. `Get-OraclePin` in `tools/oracle_helpers.ps1` is THE pin. Change it there
   and nowhere else; the generators and `refresh_vendor_versions.ps1` read it.
2. The pin is the metadata release of the Java baseline (exact NuGet range) and
   is gated at run time against the loaded assembly version.
3. The scripts need PowerShell 7 (`pwsh`). `run_update_workflow.ps1` starts
   them as child processes, so the workflow itself also runs from Windows
   PowerShell.
4. `generate_aytf_cases.ps1` does not restore (`-NoRestore`); run
   `generate_reference_cases.ps1` first when the cache is missing. It is not
   part of the workflow: `tests/data/aytf_reference_cases.json` is a curated
   case list.
5. For `* auto example` reference cases the `java*` fields are always
   refreshed from the oracle; curated cases keep their hand maintained values.
6. Calling `generate_reference_cases.ps1` repeatedly inside one long lived
   `pwsh` session can hit the `Add-Type` "already loaded" error; use a fresh
   session or the workflow. A stale `pwsh` can keep the cached `PhoneNumbers.dll`
   locked and block `-RefreshOracle`.

## Repository Conventions

1. Do not commit `tools/snapshots/*.json`; they are local artefacts.
   `tests/data/mass_differential_findings.json` IS versioned and stays empty.
2. Update `CHANGELOG.md` and this manifest when the baseline or the workflow
   semantics change.
3. Documentation and code comments are in English.

## Files That Matter Most

1. `src/LibPhoneNumber.PhoneNumberUtil.pas` (facade)
2. `src/LibPhoneNumber.MetadataCore.pas`, `src/LibPhoneNumber.MetadataFormat.pas`
3. `src/LibPhoneNumber.Regex.pas`
4. `src/LibPhoneNumber.AsYouTypeFormatter.pas`, `src/LibPhoneNumber.ShortNumberInfo.pas`, `src/LibPhoneNumber.PhoneNumberMatcher.pas`
5. `src/LibPhoneNumber.Metadata.Types.pas`, `src/LibPhoneNumber.Metadata.pas`, `src/LibPhoneNumber.ShortMetadata.pas`, `src/LibPhoneNumber.AlternateFormats.pas`, `src/LibPhoneNumber.TestingMetadata.pas`
6. GENERATED - never edit: `src/LibPhoneNumber.Metadata.{Data,Descs,Formats}.pas`, `src/LibPhoneNumber.ShortMetadata.{Data,Descs}.pas`, `src/LibPhoneNumber.TestingMetadata.{Data,Descs,Formats}.pas`, `src/LibPhoneNumber.AlternateFormats.Data.pas`
7. `tests/LibPhoneNumber.*.Tests.pas`; the four `tests/LibPhoneNumber.UpstreamSuite.*.Tests.pas` are the ONLY place for Java expected values
7a. `tests/LibPhoneNumberTests.dpr` (+ `.dproj`), the test program of both compilers, and its test layer `tests/framework/LibPhoneNumber.TestFramework.pas` (fixtures, `Assert`, published method discovery), `LibPhoneNumber.TestRunner.pas` (command line, console report, JUnit) and `LibPhoneNumber.TestJson.pas` (JSON reader, test data lookup)
8. `tests/data/reference_cases_java_csharp.json`, `tests/data/aytf_reference_cases.json` (generated by `tools/generate_aytf_cases.ps1`), `tests/data/mass_differential_findings.json`
9. `tools/generate_metadata.ps1`, `tools/oracle_helpers.ps1`
10. `tools/run_update_workflow.ps1`, `tools/run_pr_quick_check.ps1`, `tools/run_delphi_tests.ps1`, `tools/run_fpc_tests.ps1`
11. `tools/check_fpc_compile.ps1`, `tools/run_fpc_runtime_check.ps1` + `tools/fpcruntime/PhoneNumbersFpcRuntime.dpr`, `tools/fpc_toolchains.ps1` (the FreePascal toolchain helpers both FreePascal scripts dot-source)
11a. `.github/workflows/quick-check.yml` (the Windows quick check job and the Ubuntu FreePascal job)
12. `tools/run_mass_differential.ps1` + `tools/differential/PhoneNumbersDifferential.dpr`
13. `tools/export_generated_metadata_snapshot.ps1`, `tools/extract_upstream_length_rules.ps1`, `tools/compare_generated_metadata_with_upstream.ps1`
14. `vendor/versions.md`, `docs/ARCHITECTURE.md`, `KNOWN_ISSUES.md`, `CHANGELOG.md`
15. `CONTRIBUTING.md`, `.github/ISSUE_TEMPLATE/` (bug report, feature request, `config.yml` routing data issues upstream), `.github/pull_request_template.md`

## Next Steps

What is really left, and nothing else is known to be:

1. Optional: the geocoder, carrier mapper and time zone mapper - only with a
   concrete use case.
2. Deferred consciously (`docs/ARCHITECTURE.md`, "Closed questions"): a slice
   view for the possible-length pools, and a source bound handle type for
   metadata records.
3. Routine: metadata refreshes through the vendor update workflow.

When resuming after a break: read `vendor/versions.md`, run
`tools/show_metadata_info.ps1`, read the newest `CHANGELOG.md` entry, and run
`tools/run_pr_quick_check.ps1` before changing code.
