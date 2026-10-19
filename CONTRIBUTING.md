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
# The quick gate (generator, compare gate, FreePascal checks, Delphi build)
powershell -ExecutionPolicy Bypass -File tools/run_pr_quick_check.ps1
```

If you only have one of the two compilers, say so in the pull request. The
GitHub checks must be green. When a change moves a count or a gate, update the
manifest in [AGENTS.md](AGENTS.md) and [CHANGELOG.md](CHANGELOG.md).

## License

Contributions are accepted under the [Apache License 2.0](LICENSE), the
license of this repository: per its section 5, anything you submit for
inclusion is licensed under the same terms (inbound = outbound). There is no
contributor license agreement to sign.
