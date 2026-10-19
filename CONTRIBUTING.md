# Contributing

Thanks for helping. This page is the short version; the details live in
[AGENTS.md](AGENTS.md) (rules, gates, current state),
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) (design),
[tests/README.md](tests/README.md) (the test suite) and
[tools/README.md](tools/README.md) (generator and gates).

## Wrong number data? Report it upstream

If a number of some country is rejected, misclassified or formatted wrongly,
the cause is almost always the upstream METADATA, not this port: the tables in
`src/` are generated from Google's libphonenumber XML files. Check first:

1. Try the same number and region in Google's
   [libphonenumber demo](https://libphonenumber.appspot.com/) (or with the Java
   library). The demo may run a slightly different metadata release; the one
   this repository uses is in [vendor/versions.md](vendor/versions.md).
2. Same wrong result there: it is an upstream data issue. Report it the way
   upstream asks for in
   [its CONTRIBUTING.md, "Filing a metadata issue"](https://github.com/google/libphonenumber/blob/master/CONTRIBUTING.md#filing-a-metadata-issue),
   i.e. on Google's
   [Issue Tracker](http://issuetracker.google.com/issues/new?component=192347),
   with authoritative evidence. This repository picks the fix up with the next
   metadata refresh.
3. Correct result there, wrong result here: that is a bug of the port - please
   open an issue here with the bug report template.

## Rules for changes

- **Never edit a generated unit** (`src/*.Data.pas`, `*.Descs.pas`,
  `*.Formats.pas`). Change `tools/generate_metadata.ps1` and regenerate.
- **The port is literal.** Behaviour changes are ported from the Java
  original; name the upstream method you ported (e.g.
  `PhoneNumberUtil.maybeStripExtension`). Do not invent behaviour.
- **Test expectations** are computed with the C# oracle or read off the
  production XML - never copied from the upstream Java tests, which run on
  different metadata. The one exception are the four testing-metadata fixtures
  (`tests/LibPhoneNumber.UpstreamSuite.*.Tests.pas`), which copy Java values
  verbatim. See "Test Expectations" in [AGENTS.md](AGENTS.md).
- **FreePascal compatibility is mandatory.** Every unit of `src/` and the
  whole test suite must work with Delphi and with FreePascal (Delphi mode).
- **Style:** match the surrounding code; comments explain constraints and
  reasons, not the obvious; everything in English.

## Before you open a pull request

```powershell
# The test suite on Delphi
powershell -ExecutionPolicy Bypass -File tools/run_delphi_tests.ps1
# The same suite on FreePascal (WSL by default; -Toolchain Native for the fpc on PATH)
pwsh -NoProfile -File tools/run_fpc_tests.ps1
# The quick gate (generator, compare gate, FreePascal checks, samples, Delphi build)
powershell -ExecutionPolicy Bypass -File tools/run_pr_quick_check.ps1
```

If you only have one of the two compilers, say so in the pull request. The
GitHub checks must be green. When a change moves a count or a gate, update the
manifest in [AGENTS.md](AGENTS.md) and [CHANGELOG.md](CHANGELOG.md).

## Running the tests and gates

What you need: the compilers (Delphi and/or FreePascal), and for the tooling
PowerShell 7 and Windows PowerShell, `git`, the .NET 8 SDK for the reference
oracle and, for the FreePascal gates, WSL with FreePascal. The test suite
itself needs nothing beyond the compiler: it brings its own small test layer
(`tests/framework/`), no DUnitX or FPCUnit.

```powershell
# The test suite on Delphi
powershell -ExecutionPolicy Bypass -File tools/run_delphi_tests.ps1

# The same test suite on FreePascal (WSL by default; -Toolchain Native for the
# fpc on PATH, -Toolchain Mac for the shared Mac toolchain)
pwsh -NoProfile -File tools/run_fpc_tests.ps1

# The samples: build, run and compare with samples/expected (Delphi by
# default; -Compiler Fpc with -Toolchain Wsl/Native/Mac for FreePascal)
pwsh -NoProfile -File tools/run_samples.ps1

# Quick gate: metadata regeneration check, length compare against the upstream
# XML, FreePascal compile and runtime checks, the FreePascal test suite, the
# samples (runtime check, suite and samples on WSL FreePascal 3.2.4 and 3.2.2;
# -FpcToolchains restricts) and the Delphi compile of the test program
powershell -ExecutionPolicy Bypass -File tools/run_pr_quick_check.ps1

# Full gate, including the Delphi test run and the differential against the C# oracle
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
| `run_samples.ps1` | `-Compiler Delphi`: skipped with a warning; `-RequireDelphi` makes it a failure | `-Compiler Fpc`: skipped with a warning; `-RequireFpc` makes it a failure |
| `run_pr_quick_check.ps1` | the compile-only build of the test program, the FreePascal runtime check (it needs a Delphi reference build) and the samples on Delphi are skipped with a warning; `-RequireDelphi` makes the build a failure | the compile and runtime checks, the FreePascal test suite and the samples on FreePascal are skipped with a warning, per toolchain of `-FpcToolchains` (default WSL 3.2.4 and 3.2.2); `-RequireFpc` makes any missing one a failure |
| `run_update_workflow.ps1` | the Delphi test run fails, and so does `-RunMassDifferential` (it builds the probe with Delphi); with `-SkipTests` and without `-RunMassDifferential` only the runtime check and the samples on Delphi are skipped, with a warning | as for the quick check (`-RequireFpc`) |

The GitHub workflow (`.github/workflows/quick-check.yml`) has two jobs: the
quick check on a hosted Windows runner (no compiler there, so it covers the
generator and the compare gates), and a FreePascal job on Ubuntu that installs
the distribution's FreePascal and runs the compile check, the whole test suite
(JUnit report as an artifact) and the samples.

`run_update_workflow.ps1` also refreshes the reference cases from the oracle
unless `-SkipReference` is passed, which needs PowerShell 7 and the .NET 8 SDK;
the quick check skips that refresh by default. Every script is described in
[`tools/README.md`](tools/README.md), the test suite in
[`tests/README.md`](tests/README.md). Updating the metadata is a procedure of
its own: [AGENTS.md, "Vendor Update Workflow"](AGENTS.md#vendor-update-workflow).

## License

Contributions are accepted under the [Apache License 2.0](LICENSE), the
license of this repository: per its section 5, anything you submit for
inclusion is licensed under the same terms (inbound = outbound). There is no
contributor license agreement to sign.
