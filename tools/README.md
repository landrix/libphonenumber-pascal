# Tooling

This folder contains the metadata generator, the gates and the reference oracle tooling of the library.

> Counts and baseline sizes are NOT maintained here. They live in the
> "Current State" manifest at the top of `AGENTS.md`; this file says what the
> scripts do.

Metadata pipeline:

1. `generate_metadata.ps1` reads FOUR inputs: `vendor/libphonenumber/resources/PhoneNumberMetadata.xml`, `vendor/libphonenumber/resources/ShortNumberMetadata.xml`, `vendor/libphonenumber/resources/PhoneNumberMetadataForTesting.xml` and `vendor/libphonenumber/resources/PhoneNumberAlternateFormats.xml`.
2. It converts the XML with a literal port of upstream `BuildMetadataFromXml.java`, including which fields get normalised. Whitespace is stripped only where upstream's `validateRE(..., removeWhitespace = true)` does it: `nationalNumberPattern`, the `leadingDigits` elements of a `numberFormat`, and the `nationalPrefixForParsing` attribute. Everything else keeps its literal value - the `pattern` attribute, the territory level `leadingDigits`, `internationalPrefix`, `nationalPrefixTransformRule`, the carrier code rule and the `format`/`intlFormat` strings. The upstream size optimisations (possible-length and intl-format compression) are preserved as well.
3. It emits the generated units into `src/` (their count is in the `AGENTS.md` manifest):
	- `LibPhoneNumber.Metadata.Data.pas` - provenance constants, territory table, possible length pool, region / calling code indices.
	- `LibPhoneNumber.Metadata.Descs.pas` - one phone number description per territory and number type.
	- `LibPhoneNumber.Metadata.Formats.pas` - national and international number formats plus the shared `leadingDigits` pool.
	- `LibPhoneNumber.ShortMetadata.Data.pas` - short number provenance constants, territory table, possible length pool and the region index.
	- `LibPhoneNumber.ShortMetadata.Descs.pas` - one short number description per territory and short number desc kind.
	- `LibPhoneNumber.TestingMetadata.Data.pas`, `.Descs.pas` and `.Formats.pas` - the same three tables again, built from the upstream TEST XML. Only test programs link them.
	- `LibPhoneNumber.AlternateFormats.Data.pas` - the alternate number formats, keyed by country calling code, with their own leadingDigits pool.
4. The hand written `src/LibPhoneNumber.Metadata.Types.pas` (data model for all of them), `src/LibPhoneNumber.Metadata.pas` (phone metadata lookup API), `src/LibPhoneNumber.ShortMetadata.pas` (short number lookup API) and `src/LibPhoneNumber.TestingMetadata.pas` (installs the testing tables in the lookup API) consume them.
5. The short number path is the `isShortNumberMetadata = true` branch of the same `BuildMetadataFromXml.java`: a different description set (generalDesc, standardRate, shortCode, carrierSpecific, emergency, tollFree, premiumRate, smsServices - `expandedEmergency` exists in the XML but upstream does not read it), no number formats, no territory attributes other than `id`, and a general description whose possible lengths are copied from the `shortCode` element ALONE instead of being aggregated over all typed children. Short number metadata is keyed by region code only; it has no calling code and no non geographical entities.

Generator properties:

1. Deterministic: no timestamp is embedded, the pinned vendor commit is (`git -C vendor/libphonenumber rev-parse HEAD`, override with `-SourceCommit`). Repeated runs and runs under Windows PowerShell 5.1 versus PowerShell 7 produce byte identical files.
2. Output is pure ASCII with CRLF line endings; non-ASCII would be emitted as `#$XXXX` escapes (the pinned baseline needs none).
3. Files are only rewritten when their content changes; `-ForceWrite` rewrites unconditionally.
4. Regex dialect gate: every value that upstream passes through `validateRE` is compiled with .NET regex as a PCRE proxy, and the upstream `|)` check is applied to it. That covers `nationalNumberPattern`, the `numberFormat` `pattern` attribute, the `leadingDigits` elements, and the territory attributes `leadingDigits`, `internationalPrefix`, `nationalPrefixForParsing`, `nationalPrefixTransformRule` and `carrierCodeFormattingRule`, in all four data sets. The plain replacement strings `format`, `intlFormat`, `nationalPrefix`, `preferredInternationalPrefix` and `preferredExtnPrefix` are not regexes and are not gated, matching upstream. A failure aborts the run naming the value and its origin.
5. Parameters: `-MetadataXmlPath`, `-ShortMetadataXmlPath`, `-TestingMetadataXmlPath`, `-AlternateFormatsXmlPath`, `-VendorRepoPath`, `-OutputDir`, `-SourceCommit`, `-ForceWrite`, `-SkipFpcCheck`, `-Quiet`. The source label in the generated headers and in `MetadataSourceFile` / `ShortMetadataSourceFile` / `AlternateFormatsSourceFile` is derived from the actual input file name, so an overridden path is reflected in the output. The four outputs carry separate generator versions (`metadata-v1`, `short-metadata-v1`, `testing-metadata-v1`, `alternate-formats-v1`) and share the vendor commit. The two PHONE metadata data sets go through ONE function, `Invoke-PhoneMetadataBuild`, called twice - they cannot drift apart in shape.
5a. The FOURTH input is `PhoneNumberAlternateFormats.xml`, which produces `src/LibPhoneNumber.AlternateFormats.Data.pas`. It is the `isAlternateFormatsMetadata = true` branch of the Java builder - number formats only, no descriptions, no territory id, keyed by calling code. The generator throws when the input declares an `<intlFormat>` or more than one `leadingDigits` per format, because the only consumer reads `getNumberFormatList()` and `getLeadingDigitsPattern(0)`.
6. After generating, the script runs `check_fpc_compile.ps1` unless `-SkipFpcCheck` is passed. `run_update_workflow.ps1` always passes it, because the FPC check is a step of the workflow itself there - otherwise `-SkipMetadataGen` would silently skip the FreePascal gate as well.

FreePascal compile check:

1. `check_fpc_compile.ps1` compiles every hand written unit of `src/` with `fpc -Mdelphi` - since the facade became FreePascal clean that includes `LibPhoneNumber.PhoneNumberUtil.pas` and `LibPhoneNumber.PhoneNumberMatcher.pas`. Every generated unit is covered, each through the hand written lookup unit above it: `LibPhoneNumber.Metadata.pas` pulls in the three production ones, `LibPhoneNumber.ShortMetadata.pas` the two short number ones, `LibPhoneNumber.TestingMetadata.pas` the three testing ones and `LibPhoneNumber.AlternateFormats.pas` the alternate format one; `LibPhoneNumber.ShortNumberInfo.pas` is the short number port on top. Any error or warning fails the check.
2. Without an `fpc` on `PATH` the script warns and succeeds, so it is safe in environments without FreePascal. `-RequireFpc` turns that into a failure.
3. Parameters: `-FpcPath`, `-SourceDir`, `-Units`, `-WorkDir`, `-RequireFpc`, `-KeepWorkDir`, `-Quiet`. `-WorkDir` names the PARENT directory for the compiler output; the script creates and removes only its own `libphonenumber-fpccheck-<pid>` subdirectory below it, so a caller supplied path is never deleted and concurrent runs do not collide.
4. The check is about source level compatibility, so the target architecture of the installed FPC does not matter.
5. No unit is excluded, the facade `LibPhoneNumber.PhoneNumberUtil.pas` and `LibPhoneNumber.PhoneNumberMatcher.pas` included; the facade's unit header documents the FreePascal `string` contract (UTF-8, lengths and character tests on the UTF-16 form).
6. The check is a COMPILE gate only. That the compiled units also BEHAVE like the Delphi build is what the runtime check below proves.

FreePascal runtime check:

1. `run_fpc_runtime_check.ps1` builds `fpcruntime/PhoneNumbersFpcRuntime.dpr` twice from the same source - with `dcc64` (the reference) and with FreePascal - runs both and compares their observation files byte for byte. Any differing line fails the check and is printed with its predecessor as context; both files are then kept in the scratch directory for inspection. A recorded exception, a pattern that does not compile, a metadata pattern whose rewrite exceeds the budget, or a summary in which a section observed nothing (every example, parse, reference, formatter corpus and matcher counter must be positive) fails it as well, even when both builds agree.
2. The driver uses exactly the units of the compile gate (the count is in the `AGENTS.md` manifest) and derives most inputs from the data the units carry: every phone example number of the production AND the testing metadata through validation, typing, the possible-length checks, all four formats with and without extension, the out of country, carrier code, mobile dialing and keeping-alpha formatters, `FormatByPattern`, the accessory API, the national prefix stripping, the IDD and calling code extraction, the format and alternate format regex flags and the AsYouTypeFormatter; the territory attributes plus a compile probe of every pattern of all four data sets, short number patterns without an example included (`TryCompilePattern`, i.e. the `TRegExpr` dialect gate), each pattern also in its counted quantifier rewrite (`ExpandCountedQuantifiers`, which only regexpr 0.987 needs, but which the driver matches on every engine), and targeted regex probes of that rewrite and of its size budget; every short number example through `ShortNumberInfo`; a fixed list of tricky strings (extension labels, RFC3966, full width and other Unicode digits, vanity letters, non ASCII punctuation, surrogate pairs and lone surrogates) through the metadata free parse helpers; a BMP sweep over the character classes the port spells out itself; and the AYTF corpus. Since the facade and the matcher are FreePascal clean the driver also covers them, on the production AND the testing metadata: every example number parsed back in its region, from its national and international format and with its national prefix (`Parse` and `ParseAndKeepRawInput`, every record field), and every parsed number through the five public formats, `FormatByPattern`, `FormatInOriginalFormat`, the out of country / keeping-alpha / mobile dialing / carrier code formatters, the record based accessory API, `TruncateTooLongNumber` and the three `IsNumberMatch` overloads; the tricky strings (plus parse driver inputs: the `+01164` plus run retry, IDD and RFC3966 forms, alpha numbers, full width forms, inputs every parse rejects, and inputs around `MAX_INPUT_STRING_LENGTH` in ASCII and non ASCII) through the parse driver in eight default regions; the `getExampleNumber` family per region, per non geographical entity and per type; and `FindNumbers` under all four leniencies (plus `VALID` with a try budget of three) over every literal text of the two matcher test units, the context numbers inside every context of those units, and sentences built from every example number (national, international, E164 with extension, full width digits).
2a. Inputs that do not come from the units arrive through ONE plain text file the script generates into the scratch directory on every run, so neither RTL needs a JSON reader: the AYTF corpus plus the `mobileDialing` and `keepingAlphaChars` sections of `tests/data/aytf_reference_cases.json`, and the inputs (country, input, name) of `tests/data/reference_cases_java_csharp.json`. Only inputs are taken over; no expected value of either JSON reaches the driver - the Delphi build is the reference.
2b. The driver keeps both observation files in memory and writes each once at the end: written line by line, the WSL build spent most of its run time in single writes to the Windows file system behind `/mnt`.
3. Output is ASCII with LF line ends; every non printable or non ASCII code unit is escaped as `\uXXXX`. On FreePascal the driver sets the multi byte conversion code page to UTF-8 and links `cwstring` on Unix - without a widestring manager the FPC RTL on Unix maps every non ASCII character onto `?` (see KNOWN_ISSUES.md). A lone surrogate cannot be carried by a UTF-8 `string` at all, so the driver substitutes `?` for it in BOTH builds before calling the `string` API and hands the raw surrogate to the UnicodeString entry points only.
4. The open Unicode categories L and N behind `UNWANTED_END_CHARS` come from each compiler's RTL, and the RTLs ship different Unicode versions. That sweep goes to a SECOND file; the script compares it and prints every differing range as a warning on every run, without failing. It is the RTL's Unicode version, not the port (see KNOWN_ISSUES.md).
5. Toolchains (`-Toolchain`): `Wsl` (the default and the mandatory gate; FreePascal 3.2.4 at `~/fpc-3.2.4/bin/fpc` of the WSL user unless `-FpcPath` names another compiler inside WSL), `Native` (the Windows `fpc` on `PATH` or `-FpcPath`) and `Mac` (ssh alias `-MacHost`, default `macos-tests`, a host alias of the maintainer's `~/.ssh/config`; a fresh run directory `~/remote-toolchains/macos-fpc/runs/libphonenumber-<utc>-<id>/`, built with the shared `~/remote-toolchains/macos-fpc/bin/fpc.sh` wrapper, which discovers Xcode and the SDK itself; remote runs are kept for review). The Wsl and the Mac mode build through a small POSIX shell script the script writes at run time with LF line ends, so no `$`-carrying one liner has to survive PowerShell, `wsl.exe` or ssh quoting.
6. Both builds compile with range and overflow checking on (`-$R+ -$Q+` for dcc64, `-Cr -Co` for FreePascal). Any compiler error or warning of the FreePascal build fails the check, like in the compile check.
7. A toolchain that is not reachable is a warning and a no-op; `-RequireFpc` turns it into a failure. A missing Delphi (`-StudioRoot`) is handled the same way with `-RequireDelphi`, because without the reference there is nothing to compare. The FreePascal toolchain is checked first, so `-RequireFpc` fails on an unreachable one even when Delphi is missing as well.
8. Parameters: `-Toolchain`, `-FpcPath`, `-StudioRoot`, `-MacHost`, `-WorkDir`, `-ReferenceDir`, `-MaxDiffLines`, `-RequireFpc`, `-RequireDelphi`, `-KeepWorkDir`, `-Quiet`. `-WorkDir` names the PARENT directory; the script creates and removes only its own `libphonenumber-fpcruntime-<pid>` subdirectory below it (and keeps it on a failure). The Delphi build output goes there too, never into the repository.
8a. `-ReferenceDir` names a directory, owned by the caller, for a reusable Delphi reference: the observation file, the RTL sweep, the compiler line and a fingerprint (SHA-256 over the generated driver input, the driver source, every unit of `src/`, the `dcc64` identity - path, file version, size, time stamp - and the Delphi build options). When the stored fingerprint matches, the Delphi build is skipped and the log says `reference reused from <dir>`; otherwise the reference is built and stored there. The script never deletes that directory. `run_update_workflow.ps1` uses it so that the runs on several toolchains share one Delphi build.
9. The compiler versions and targets of both builds are printed in the log, never written into the compared file.
10. The toolchain resolution (`Resolve-FpcToolchain` and the three resolvers), `Invoke-Native`, the build output rule (`Get-FpcProblems`), the LF script writer and the Mac transport (`New-MacRunDirectory`, `Send-MacStage`, `Receive-MacFile`) live in `fpc_toolchains.ps1`, which this script, `run_fpc_tests.ps1` and `run_samples.ps1` dot-source.

FreePascal test suite:

1. `run_fpc_tests.ps1` builds `tests/LibPhoneNumberTests.dpr` - the whole test suite, the same program `run_delphi_tests.ps1` builds with Delphi - with FreePascal and runs it from the `tests` directory. The build options are those of the runtime check (`-Mdelphi -Sh -Cr -Co -gl`); any compiler error or warning fails it. The runner's exit code decides: 0 only when every test passed; the runner output (a line per fixture, every failure, the summary) is printed.
2. Toolchains (`-Toolchain`, shared with the runtime check through `fpc_toolchains.ps1`): `Wsl` (the default; FreePascal 3.2.4 at `~/fpc-3.2.4/bin/fpc` of the WSL user unless `-FpcPath` names another compiler inside WSL), `Native` (the `fpc` on `PATH` or `-FpcPath` of the machine the script runs on - Windows, or Linux / macOS under `pwsh`; the GitHub Ubuntu job uses this mode) and `Mac` (ssh alias `-MacHost`; `src/`, the test units, the framework and `tests/data` are staged into a fresh `~/remote-toolchains/macos-fpc/runs/libphonenumber-tests-<utc>-<id>/`, which is kept for review).
3. `-JUnit <file>` copies the JUnit XML report of the run there, `-Filter` hands a `--filter` to the runner, `-BuildOnly` compiles and stops.
4. A toolchain that is not reachable is a warning and a no-op; `-RequireFpc` turns it into a failure.
5. Parameters: `-Toolchain`, `-FpcPath`, `-MacHost`, `-WorkDir`, `-JUnit`, `-Filter`, `-BuildOnly`, `-RequireFpc`, `-KeepWorkDir`, `-Quiet`. `-WorkDir` names the PARENT directory; the script creates and removes only its own `libphonenumber-fpctests-<pid>` subdirectory below it (and keeps it on a failure).

Samples:

1. `run_samples.ps1` builds every program of `samples/` with ONE compiler, runs it and compares its standard output with `samples/expected/<name>.txt`. `-Compiler Delphi` (the default) uses `dcc64` of `-StudioRoot` (`-Q -$R+ -$Q+`); `-Compiler Fpc` uses the FreePascal of `-Toolchain` (`Wsl`, `Native`, `Mac`, `-FpcPath`, `-MacHost` as for the test suite; options `-Mdelphi -Sh -Cr -Co`). Units and programs go to a scratch directory, never into the repository.
2. A sample fails when it does not build, when the build reports a warning or an error (FreePascal: `Get-FpcProblems`; Delphi: a `W`/`E`/`F` message code, because `dcc64` localises the message words), when it exits with a non zero exit code or writes to standard error, when its output is not printable ASCII (TAB, LF and CR are allowed), or when the output differs from the golden file. The first differing lines are printed; the work directory is kept on a failure.
3. The golden files are ASCII with LF line ends (`.gitattributes` pins `samples/expected/*.txt` to LF). The comparison turns CRLF into LF on both sides first - a Delphi program on Windows writes CRLF - and is byte exact otherwise, the final line end included. The same golden files hold for every compiler.
4. `-UpdateExpected` writes the output of the run as the new golden files instead of comparing (and reports which changed); review the diff. `-Sample <name>[,<name>]` restricts the run. Without `-Sample` a golden file without a program fails the run.
5. A compiler that is not reachable is a warning and a no-op; `-RequireDelphi` / `-RequireFpc` turn it into a failure.
6. Parameters: `-Compiler`, `-Toolchain`, `-FpcPath`, `-MacHost`, `-StudioRoot`, `-Sample`, `-UpdateExpected`, `-WorkDir`, `-MaxDiffLines`, `-RequireFpc`, `-RequireDelphi`, `-KeepWorkDir`, `-Quiet`. `-WorkDir` names the PARENT directory; the script creates and removes only its own `libphonenumber-samples-<pid>` subdirectory below it.

Upstream release check:

1. `check_upstream_release.ps1` compares the pinned release with the newest upstream release. The pin is `Get-OraclePin` in `oracle_helpers.ps1` - the canonical pin, whose version by rule IS the metadata release of the pinned Java baseline (`vendor/versions.md` records only commits plus that same pin); `-PinnedVersion` overrides it for testing. Upstream is the highest `vX.Y.Z` tag of `google/libphonenumber` (`git ls-remote`, compared as `[version]`, never as strings).
2. It also looks up whether NuGet `libphonenumber-csharp` already has that version (`api.nuget.org` flat container index), because the oracle pin needs it. The answer (`available`, `not published yet`, or `unknown` when the lookup fails) goes into the issue text and never fails the check.
3. When upstream is newer it opens the issue `Upstream libphonenumber vX.Y.Z released` (label `upstream-release`, created on first use) in `-Repository` (default `$env:GITHUB_REPOSITORY`, else the repository of the checkout) with the release links, the NuGet status and the refresh steps in short, pointing to `AGENTS.md`. The open issues come from a title search (`gh issue list --search`), not a capped listing of all open issues. The issues the script opens carry the hidden body marker `<!-- upstream-release-check -->`. An open issue for the same version - matched by title, so also one a person opened - means no new issue. Then, in either case (so a failed cleanup is retried on the next run), open issues for OLDER versions that carry the marker get a comment pointing to the latest one and are closed as not planned; issues without the marker are only reported, never touched. When the pin is up to date nothing is written; an open issue for a version the pin already reached is reported for a person to close.
4. `-IssuesJson <file>` (testing) reads the open issues from a JSON array of `{number, title, body, url}` instead of GitHub. `-DryRun` changes nothing (the open issues are still read) and prints the result, the title, the label, what would happen to older issues and the full issue body. Needs `git`, and `gh` authenticated for the issue part (`GH_TOKEN` on the runner); runs under `pwsh` on Windows and Linux.
5. `.github/workflows/upstream-release-check.yml` runs it on `ubuntu-latest` every Monday and on `workflow_dispatch` (input `dry_run`), with `contents: read` and `issues: write` and the default `GITHUB_TOKEN`.

Reference oracle helper:

`oracle_helpers.ps1` is dot-sourced by `generate_reference_cases.ps1`,
`generate_aytf_cases.ps1`, `run_mass_differential.ps1` and
`refresh_vendor_versions.ps1`. It carries the four things all of them need, once:

1. `Get-OraclePin` - THE canonical package id, version and target framework.
   Change the oracle pin THERE, nowhere else. The three generators declare their
   `-PackageId`/`-PackageVersion`/`-TargetFramework` as empty strings and resolve
   them through `Resolve-OraclePinValue`, and `refresh_vendor_versions.ps1` reads
   the same function, so `vendor/versions.md` cannot record a version the
   generators do not load.
2. `Get-OracleCacheRoot` - the git-ignored cache `tools/.nuget-oracle/`.
3. `Get-OracleAssemblyPath` - cache layout `<root>/<id>.<version>.<tfm>/publish`
   with an `.oracle-complete` marker, plus the `dotnet publish` restore.
   `-Refresh` re-restores from scratch, `-NoRestore` turns a missing cache into
   an error instead (that is what the AYTF generator uses).
4. `Import-OracleAssembly` - dependency preload, `Add-Type`, and the version
   gate that aborts when the loaded assembly is not the pinned version.

Current utility:

1. `generate_reference_cases.ps1` refreshes `tests/data/reference_cases_java_csharp.json` using the C# port implementation.
2. The script does not build the vendor source; it uses the oracle helper above. Because the oracle assembly targets `net8.0`, the script requires `pwsh` and aborts under Windows PowerShell 5.1; `run_update_workflow.ps1` therefore starts it as a child `pwsh` process.
2a. It ABORTS WITHOUT WRITING when any case cannot be recomputed - a missing input or country, a region with no example number under `-IncludeAllRegions`, or an exception from the oracle. Writing anyway would refresh every other case while the failed one kept its previous, possibly stale expectation, which is a gate that can never fail again. `-AllowPartial` writes anyway, for a deliberate, documented exception, and says so loudly.
3. `show_metadata_info.ps1` prints generator label, source file and pinned vendor commit of all four generated data sets.
4. `export_generated_metadata_snapshot.ps1` parses the possible-length model out of the GENERATED units `src/LibPhoneNumber.Metadata.Data.pas` and `.Descs.pas` into `tools/snapshots/generated_metadata_snapshot.json`.
5. `extract_upstream_length_rules.ps1` extracts possible national lengths from upstream metadata into `tools/snapshots/upstream_length_rules.json`, per region and per calling code. Its token parser is a literal port of `BuildMetadataFromXml.parsePossibleLengthStringToSet` and THROWS on every deviation (only `\d+` or a bracketed, ascending range spanning at least three values; no empty, duplicate or non numeric token).
6. `compare_generated_metadata_with_upstream.ps1` diffs the two and writes `tools/snapshots/generated_vs_upstream_diff.json`. It compares per TERRITORY, over the whole length SET and in both directions. Clean state: all four counters zero.
6a. `run_mass_differential.ps1` builds and runs `differential/PhoneNumbersDifferential.dpr` and compares its answers against the C# oracle over the example number corpus and the API set listed in its header (sizes in the `AGENTS.md` manifest); findings go to the versioned `tests/data/mass_differential_findings.json`. Needs `pwsh` and the oracle package. `-FailOnFindings` turns a finding into a failure. Three corpus guards run BEFORE the result is accepted, because "zero findings" is meaningless if nothing was compared: the probe's self reported case count must match what it emitted, the corpus must have exactly `-ExpectedCaseCount` entries (bump it with the metadata baseline), and the compared field count must match what the per case outcomes imply. Each throws, and none of them is covered by `-FailOnFindings`.
6b. `run_benchmark.ps1` builds and runs `benchmark/PhoneNumbersBenchmark.dpr`: parse, `IsValidNumber` and `Format(INTERNATIONAL)` over the same corpus. Documentation, not a gate; it is not part of the workflow.
6c. `-WorkDir` of both scripts, like the one of `check_fpc_compile.ps1`, names the PARENT directory of the scratch space. Each script creates and removes only its own `libphonenumber-<tool>-<pid>` subdirectory below it and never deletes the directory it was given; `-KeepWorkDir` retains it and prints the path (which is what `-SkipBuild` then reuses).
7. `run_update_workflow.ps1` runs the standard chain in one command:
	- regenerate reference cases (optional skip)
	- regenerate the metadata units (`-SkipMetadataGen`); runs in-process, so no `pwsh` is required for this step
	- with `-FailOnDiff`: verify with `git status --porcelain` that the generated units match the repository state, i.e. that the committed units really are the output of the current generator plus the pinned XMLs
	- the FreePascal compile check as a STEP OF ITS OWN (`-SkipFpcCheck` to skip it, `-RequireFpc` to make a missing compiler a failure). It does not depend on the generator step, so `-SkipMetadataGen` does not skip it.
	- the FreePascal RUNTIME check (`run_fpc_runtime_check.ps1`) right after it, as a step of its own as well (`-SkipFpcRuntime` to skip it; `-RequireFpc` applies to it too), once per `-FpcToolchains` entry. Every run is compared against the SAME Delphi reference: the first run builds it into a scratch directory of the workflow (`-ReferenceDir`), the later runs reuse it
	- the FreePascal TEST SUITE (`run_fpc_tests.ps1`), a step of its own (`-SkipFpcTests` to skip it; `-RequireFpc` applies; `-SkipTests` does NOT skip it), once per `-FpcToolchains` entry as well
	- the SAMPLES (`run_samples.ps1`), a step of its own after the test suite (`-SkipSamples` to skip it): once with Delphi (a missing Delphi is a warning) and once per `-FpcToolchains` entry (`-RequireFpc` applies). A metadata refresh can change an example value in a sample: review the diff, rewrite the golden files with `run_samples.ps1 -UpdateExpected` and check the values `docs/GUIDE.md` quotes
	- `-FpcToolchains` lists the toolchains of those three steps, in order; an entry is `<Toolchain>` or `<Toolchain>=<compiler path>` (the path becomes `-FpcPath`), several entries may also come comma separated in one string (`powershell -File` passes them that way). Default: `Wsl`, `Wsl=/usr/bin/fpc` - the WSL FreePascal 3.2.4 and the 3.2.2 of the WSL distribution package. 3.2.2 is in by default because it ships regexpr 0.987, for which the regex layer has code paths of its own (the counted quantifier rewrite, the empty input probe); a regexpr 0.987 crash once passed the 3.2.4 suite and workflow unnoticed. The test suite runs on both as well: it reaches regex paths the runtime driver does not, and a run costs about half a minute. `-FpcToolchains Wsl` restricts the three steps to 3.2.4; an unknown toolchain name fails before any step runs
	- `-RequireFpc` holds for every configured toolchain: without it an unreachable one (no WSL, no compiler at the path) is skipped with a warning and the others still run; with it the step fails
	- export the generated metadata snapshot
	- extract upstream length rules
	- compare generated metadata vs upstream
	- the Delphi test suite (`run_delphi_tests.ps1`; `-SkipTests` skips it)
	- run the mass differential (`-RunMassDifferential`, off by default; with `-FailOnDiff` it is a hard gate)
	- the reference refresh and the mass differential run as child `pwsh` processes, so the workflow can be started from Windows PowerShell as well
	- every step aborts the workflow on failure, including failing Delphi tests
8. `run_pr_quick_check.ps1` runs a CI-friendly quick gate:
	- the full workflow with `-FailOnDiff -SkipTests`, i.e. compare gate, generated-unit verification, the FPC compile and runtime checks, the FreePascal TEST SUITE and the SAMPLES (Delphi and FreePascal; `-SkipSamples` opts out), but no Delphi test RUN
	- skip reference refresh by default (enable via `-RefreshReference`)
	- then BUILD the Delphi test program without running it (`run_delphi_tests.ps1 -BuildOnly`). That is the only artefact that links every unit of the port together with the tests, so it proves the Delphi side compiles; the FreePascal side is covered by the FPC compile and runtime checks and the FreePascal test suite. It is skipped with a warning when no Delphi is found at `-StudioRoot` (the public CI runner has none); `-RequireDelphi` makes that a failure and `-SkipDelphiCompile` opts out.
	- `-RequireFpc` is forwarded to every FreePascal step (the samples included); the runtime check and the FreePascal test suite are part of the quick check because each run takes well under a minute on a WSL toolchain (timings in the `AGENTS.md` manifest) (`-SkipFpcRuntime`, `-SkipFpcTests` opt out). `-FpcToolchains` is forwarded when given; otherwise the workflow default (WSL 3.2.4 and 3.2.2) applies
9. JSON snapshots are only rewritten when semantic content changes; volatile timestamps are ignored where configured.
10. Individual scripts support `-ForceWrite` to intentionally rewrite output files even when content is unchanged.
11. `generate_reference_cases.ps1` supports `-IncludeAllRegions` to auto-add one example case per supported upstream region.
12. `refresh_vendor_versions.ps1` fast-forwards both vendor repos (`libphonenumber`, `libphonenumber-csharp`) and updates `vendor/versions.md` to current commit links plus the pinned reference oracle package. The pin comes from `Get-OraclePin` in `oracle_helpers.ps1` (override via `-OraclePackageId`/`-OraclePackageVersion`); if it cannot be resolved the script aborts instead of writing an incomplete file.
13. `run_delphi_tests.ps1` builds `tests/LibPhoneNumberTests.dproj` with msbuild and runs it; it fails when the runner reports a failing or raising test (exit code `1`) or a usage error / empty run (exit code `2`). `-BuildOnly` builds the program and stops there, which is what the quick check uses as a compile gate for the whole port; `-Filter` and `-JUnit` are handed to the runner (see `tests/README.md`).
14. `generate_aytf_cases.ps1` writes `tests/data/aytf_reference_cases.json`, the expectation set of the AsYouTypeFormatter tests (AsYouTypeFormatter sequences, remembered positions, clear/reuse, the mass smoke table, `formatNumberForMobileDialing` and `formatOutOfCountryKeepingAlphaChars`). It reuses the SAME NuGet oracle cache as `generate_reference_cases.ps1` and therefore also requires `pwsh`; it does not restore the package itself (`-NoRestore`), so run `generate_reference_cases.ps1` first when the cache is missing. It is deliberately NOT part of `run_update_workflow.ps1`: the file is a hand curated case list, not a derived artefact of the metadata baseline, and regenerating it must be a conscious act.

Usage examples:

1. Full workflow:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1`
2. Fast local check without reference regeneration:
	- `powershell -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -SkipReference`
3. Fail CI-style when compare is not clean:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -FailOnDiff`
4. PR quick check (no Delphi required):
	- `powershell -ExecutionPolicy Bypass -File tools/run_pr_quick_check.ps1`
5. Force refresh a snapshot file:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/export_generated_metadata_snapshot.ps1 -ForceWrite`
5a. Full gate including the mass differential:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_update_workflow.ps1 -FailOnDiff -RunMassDifferential`
5b. Mass differential alone:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_mass_differential.ps1`
5c. Benchmark:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_benchmark.ps1`
6. Expand reference cases to all supported regions:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/generate_reference_cases.ps1 -IncludeAllRegions`
7. Pull both vendor repos and refresh commit references:
	- `powershell -ExecutionPolicy Bypass -File tools/refresh_vendor_versions.ps1`
8. Refresh `vendor/versions.md` only (no pull):
	- `powershell -ExecutionPolicy Bypass -File tools/refresh_vendor_versions.ps1 -SkipPull`
9. Regenerate the metadata units only:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/generate_metadata.ps1`
10. FreePascal compile check only:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/check_fpc_compile.ps1`
11. FreePascal runtime check only (WSL 3.2.4 and 3.2.2, the two mandatory toolchains), and the two optional extra runs:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_runtime_check.ps1`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_runtime_check.ps1 -FpcPath /usr/bin/fpc`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_runtime_check.ps1 -Toolchain Native`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_runtime_check.ps1 -Toolchain Mac`
12. The test suite on FreePascal (WSL 3.2.4 by default; other WSL compilers through `-FpcPath`) and on the other toolchains:
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_tests.ps1`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_tests.ps1 -FpcPath /usr/bin/fpc`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_tests.ps1 -Toolchain Native`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_tests.ps1 -Toolchain Mac`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_fpc_tests.ps1 -Filter TMetadataTests -JUnit junit.xml`
13. The test suite on Delphi:
	- `powershell -ExecutionPolicy Bypass -File tools/run_delphi_tests.ps1`
13a. The samples on Delphi, on the WSL FreePascal 3.2.4 and 3.2.2, and new golden files after a reviewed change:
	- `pwsh -NoProfile -File tools/run_samples.ps1`
	- `pwsh -NoProfile -File tools/run_samples.ps1 -Compiler Fpc`
	- `pwsh -NoProfile -File tools/run_samples.ps1 -Compiler Fpc -FpcPath /usr/bin/fpc`
	- `pwsh -NoProfile -File tools/run_samples.ps1 -UpdateExpected`
14. The quick check with the FreePascal steps on 3.2.4 only, or on another set of toolchains:
	- `powershell -ExecutionPolicy Bypass -File tools/run_pr_quick_check.ps1 -FpcToolchains Wsl`
	- `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/run_pr_quick_check.ps1 -FpcToolchains Wsl,Wsl=/usr/bin/fpc,Native` (one comma separated string, no spaces)
15. Is there a newer upstream release? (read only; without `-DryRun` it opens the issue)
	- `pwsh -NoProfile -File tools/check_upstream_release.ps1 -DryRun`
	- `pwsh -NoProfile -File tools/check_upstream_release.ps1 -DryRun -PinnedVersion 9.0.40`

Note:

Do not edit generated metadata manually. The units
`src/LibPhoneNumber.Metadata.Data.pas`, `.Descs.pas`, `.Formats.pas`, the
two `ShortMetadata` units, the three `TestingMetadata` units and
`src/LibPhoneNumber.AlternateFormats.Data.pas` all carry a "GENERATED FILE
- DO NOT EDIT" header; change `generate_metadata.ps1` and regenerate instead.
Snapshot JSON files under `tools/snapshots/` are generated artifacts and are
not versioned. `tests/data/mass_differential_findings.json` IS versioned - it is
the inventory of known divergences and is meant to stay empty.

## Unicode decimal digit table

`src/LibPhoneNumber.MetadataCore.pas` carries `UnicodeDigitZeros`, the code point of the DIGIT ZERO of every Unicode `Nd` run inside the BMP (37 entries). It is the port of the class `DIGITS` (`\p{Nd}`) and of Java's `Character.digit(c, 10)`.

There is no generator for it, because the table only changes when the Unicode standard adds an `Nd` block. It was enumerated from the same Unicode data the reference oracle runs on, and the invariants it relies on were verified there:

```powershell
$zeros = @()
for ($i = 0; $i -le 0xFFFF; $i++) {
  $c = [char]$i
  if ([System.Char]::IsDigit($c) -and [System.Char]::GetNumericValue($c) -eq 0) { $zeros += $i }
}
"runs=$($zeros.Count)"
($zeros | ForEach-Object { '$' + $_.ToString('X4') }) -join ', '
```

Two properties make the compact table exact, and both are asserted by `UnicodeDecimalDigits_CoverTheBmpNdRuns` in `tests/LibPhoneNumber.MetadataCore.Tests.pas`: every entry starts a run of ten consecutive code points with the numeric values 0..9, and the 37 runs together are all 370 BMP characters the oracle reports as decimal digits.
