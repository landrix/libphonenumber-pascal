# Architecture

This document describes how the port is built and why: the layers, the
generated metadata, the regex abstraction and its engine quirks, the string
contract on both compilers, the reference oracle, the test strategy and the
design questions that are closed. Fast moving numbers (test counts, gate
counts, metadata sizes) are not repeated here; they live in the manifest at the
top of [AGENTS.md](../AGENTS.md).

## Source of truth

1. The Java implementation of
   [libphonenumber](https://github.com/google/libphonenumber) is the functional
   source of truth. The port is LITERAL: upstream methods keep their structure
   and are named in the comments, so a change upstream can be followed line by
   line.
2. The C# port [libphonenumber-csharp](https://github.com/twcclegg/libphonenumber-csharp)
   is the implementation-near cross-check and, as a published NuGet package,
   the reference oracle for expected values (see "Reference oracle").
3. Where the two disagree, Java wins and the case is pinned in a test as a
   documented divergence.

## Layers

```
LibPhoneNumber.PhoneNumberUtil      facade TPhoneNumberUtil: parse driver, Format*, IsNumberMatch,
                                     parse based accessory API
LibPhoneNumber.PhoneNumberMatcher   FindNumbers / TPhoneNumberMatcher (uses the facade)
LibPhoneNumber.AsYouTypeFormatter   TAsYouTypeFormatter
LibPhoneNumber.ShortNumberInfo      ShortNumberInfo port
        |
LibPhoneNumber.MetadataFormat       metadata driven format engine
LibPhoneNumber.MetadataCore         validation, typing, region resolution, metadata free parse helpers,
                                     Unicode digit primitives, scanners
LibPhoneNumber.Regex                regex abstraction (Delphi PCRE / FreePascal TRegExpr)
        |
LibPhoneNumber.Metadata             lookup layer over the ACTIVE phone metadata data set
LibPhoneNumber.ShortMetadata        lookup layer over the short number metadata
LibPhoneNumber.AlternateFormats     lookup layer over the alternate format metadata
LibPhoneNumber.TestingMetadata      installs the upstream TEST data set (test builds only)
LibPhoneNumber.Metadata.Types       hand written data model of all generated tables
LibPhoneNumber.Types                public value types (TPhoneNumber, enums)
        |
generated: Metadata.{Data,Descs,Formats}, ShortMetadata.{Data,Descs},
           TestingMetadata.{Data,Descs,Formats}, AlternateFormats.Data
```

Placement rules:

- Everything metadata driven and parse free lives below the facade, in
  `MetadataCore` and `MetadataFormat`. What needs the parse driver (for example
  `FormatInOriginalFormat`, the string overloads of `IsNumberMatch`, the
  example number family) lives on the facade.
- `PhoneNumberUtil` upstream is stateless, so the port is unit level functions
  plus one class of class functions (`TPhoneNumberUtil`). There are exactly two
  classes with state: `TAsYouTypeFormatter` (stateful by contract) and
  `TPhoneNumberMatcher` (an iterator like upstream's
  `Iterator<PhoneNumberMatch>`, with `HasNext` / `Next` / `TryNext`;
  `FindNumbers` materialises the matches into an array).
- `ShortNumberInfo`, the AsYouTypeFormatter and the matcher are separate units
  without a facade wrapper, mirroring upstream, where they are separate classes
  next to `PhoneNumberUtil`. Their units are the documented API.
- Where upstream takes a `PhoneNumber`, the lower layers take
  `(CountryCode, NationalNumberDigits)`; the emergency number methods of
  `ShortNumberInfo` keep the raw string because they must tell `+1 911` from
  `911`.
- `TPhoneNumber.NationalNumberDigits` is canonical; `NationalNumber` is its
  lossy numeric value. `RegionCode` is an addition (see `LibPhoneNumber.Types`).
- `pnfInternationalLegacy` has no upstream counterpart: it is a display variant
  produced by post processing the INTERNATIONAL string
  (`ToLegacyDisplayFormat`).
- Region arguments are canonicalised with `UpperCase(Trim(...))` at every
  public boundary.

### Parse path

`TPhoneNumberUtil.ParseHelper(number, region, keepRawInput, checkRegion)` is
the port of upstream `parseHelper`, in upstream order:
`buildNationalNumberForParsing` (RFC3966 `tel:`, `;phone-context=`, `;isub=`,
`extractPossibleNumber`), `isViablePhoneNumber`, `maybeStripExtension` with the
complete `EXTN_PATTERNS_FOR_PARSING`, `maybeExtractCountryCode`,
`maybeStripNationalPrefixAndCarrierCode` (transform rule and viability
rollback). `checkRegion = False` is the `IsNumberMatch` path.
`maybeExtractCountryCode` is a method of its own because parseHelper calls it
twice: on `INVALID_COUNTRY_CODE` behind a leading plus run, Java strips the run
and retries, which is what makes `+01164 3 331 6005` dialled in the US the New
Zealand number `+6433316005`. `RawInput`, `CountryCodeSource` and
`PreferredDomesticCarrierCode` are filled by `ParseAndKeepRawInput` only, as
upstream. Vanity numbers are normalised through the alpha table, so
`1-800-FLOWERS` parses.

### Format path

`MetadataFormat.FormatNumber` ports `format`, `formatNsn`,
`chooseFormattingPatternForNumber`, `formatNsnUsingPattern`,
`prefixNumberWithCountryCallingCode` and `maybeAppendFormattedExtension`, plus
`formatOutOfCountryCallingNumber`, `formatNationalNumberWithCarrierCode`,
`formatByPattern`, `formatNumberForMobileDialing`,
`formatOutOfCountryKeepingAlphaChars` and the two `getLengthOf*` methods. It
resolves the metadata of the MAIN region of the calling code itself, like
upstream, so the caller's region is not part of the format path. Client
supplied formats for `FormatByPattern` are `TUserNumberFormatRec` values built
with `MakeUserNumberFormat`; they carry their `leadingDigits` locally instead of
as a pool offset.

### Accessory API

The rest of the `PhoneNumberUtil` surface: `GetSupportedTypesForRegion` /
`ForNonGeoEntity` (with `DescHasData` and the set type `TMetadataNumberTypes`),
both `IsNumberGeographical` overloads, `GetCountryMobileToken`, `IsAlphaNumber`
and `TruncateTooLongNumber` in `MetadataCore`; `GetLengthOfNationalDestinationCode`
and `GetLengthOfGeographicalAreaCode` in `MetadataFormat` (they read the
INTERNATIONAL format, and take `RawInput` for the raw input short circuit of the
public `format()`); `GetNationalSignificantNumber`, the record taking wrappers
and the parse based `TryGetExampleNumber`, `TryGetExampleNumberForType`,
`TryGetExampleNumberForNonGeoEntity` and `TryGetInvalidExampleNumber` on the
facade. Port decisions:

- Java's `null` is `False` plus `Default(TPhoneNumber)`; swallowed
  `NumberParseException`s are swallowed the same way.
- `isItalianLeadingZero()` is derived from the digits exactly as the parser sets
  it (at least two digits and a leading `0`).
- `truncateTooLongNumber` works on the digit string: split off the leading
  zeros, drop the last digit of the rest.
- `getNationalSignificantNumber` caps more than ten leading zeros at ten, like
  upstream; only this public method caps.
- `getExampleNumberForType(type)` walks the supported regions in this port's
  order; upstream walks a `HashSet`, so which region answers is unspecified
  there too.
- `getInvalidExampleNumber` has no C# counterpart; its production test checks
  the upstream contract (parses, right calling code, not valid).

## Generated metadata

`tools/generate_metadata.ps1` is a literal port of upstream
`BuildMetadataFromXml.java`, including its size optimisations (possible-length
and intl-format compression) and exactly the whitespace normalisation upstream
applies. It reads four upstream XMLs and writes the following units (counts
and sizes are in the AGENTS.md manifest):

| input | units | consumer |
| --- | --- | --- |
| `PhoneNumberMetadata.xml` | `LibPhoneNumber.Metadata.{Data,Descs,Formats}` | `LibPhoneNumber.Metadata` |
| `ShortNumberMetadata.xml` | `LibPhoneNumber.ShortMetadata.{Data,Descs}` | `LibPhoneNumber.ShortMetadata` |
| `PhoneNumberMetadataForTesting.xml` | `LibPhoneNumber.TestingMetadata.{Data,Descs,Formats}` | `LibPhoneNumber.TestingMetadata` |
| `PhoneNumberAlternateFormats.xml` | `LibPhoneNumber.AlternateFormats.Data` | `LibPhoneNumber.AlternateFormats` |

Data layout: every table is a plain typed constant, which both Delphi and
FreePascal digest without run time construction. Variable length data
(possible lengths, leadingDigits patterns, number formats, descriptions) lives
in flat pools and is addressed through offset/count pairs; the record types are
in `LibPhoneNumber.Metadata.Types` and mirror the upstream protos
(`PhoneMetadata`, `PhoneNumberDesc`, `NumberFormat`).

Properties:

- **Deterministic.** No timestamp; the pinned vendor commit is embedded as
  `MetadataSourceCommit` (and its short number and alternate format
  counterparts). Output is pure ASCII with CRLF; non ASCII would be emitted as
  `#$XXXX` escapes. Files are only rewritten when their content changes.
- **Provenance labels**: `metadata-v1`, `testing-metadata-v1`,
  `short-metadata-v1`, `alternate-formats-v1`. `tools/show_metadata_info.ps1`
  prints label, source file and commit of all four data sets.
- **Regex dialect gate.** Every value upstream passes through `validateRE` is
  compiled with .NET regex as a PCRE proxy, and the upstream `|)` check is
  applied; a failure aborts the run.
- **One builder for both phone data sets.** `Invoke-PhoneMetadataBuild` is
  called twice (production and test), so the two cannot drift apart in shape.
- **Short number branch** (`isShortNumberMetadata = true` upstream): a different
  description set (generalDesc, standardRate, shortCode, carrierSpecific,
  emergency, tollFree, premiumRate, smsServices - `expandedEmergency` is in the
  XML but upstream does not read it), no formats, keyed by region code only, and
  a general description whose possible lengths come from `shortCode` alone.
- **Alternate formats branch** (`isAlternateFormatsMetadata = true` upstream):
  number formats only, keyed by calling code, with their own leadingDigits pool
  (read it with `GetAlternateLeadingDigitsPattern`, never with
  `LibPhoneNumber.Metadata.GetLeadingDigitsPattern`). The generator refuses an
  `<intlFormat>` or more than one `leadingDigits` per format, because the only
  consumer reads `getNumberFormatList()` and `getLeadingDigitsPattern(0)`.

Rules: never edit a generated unit; never add a hand maintained data table next
to the generated ones. If something is missing, it is missing from the
generator.

## Metadata source switching

`LibPhoneNumber.Metadata` reads an ACTIVE data set (`TPhoneMetadataTables`)
instead of naming a generated unit.

1. The initialization section installs `ProductionMetadataTables`; production
   is the default.
2. `UseMetadataTables` swaps the WHOLE record at once (territories,
   descriptions, formats, length pool, indices, provenance). That is all it
   does; there is no other derived state. The regex pattern cache is keyed by
   pattern text and needs no invalidation; the purely hygienic cache drop lives
   in `LibPhoneNumber.TestingMetadata` (`UseTestingMetadata` /
   `RestoreProductionMetadata`).
3. Records and pointers handed out by the metadata layer are SOURCE BOUND: a
   switch invalidates every `PPhoneMetadataRec` / `PPhoneNumberDescRec` /
   `PNumberFormatRec`. Fetch metadata inside the test, never in fixture setup.
4. Switching is not thread safe, deliberately (upstream's
   `TestMetadataTestCase` swaps the singleton the same way). Switch from test
   setup and teardown only.
5. `LibPhoneNumber.TestingMetadata` is the only unit that names the testing
   tables; nothing under `src/` uses it and only test programs link it, so a
   production binary cannot pull the test tables in.
6. The SHORT number metadata is never switched: there is no
   `ShortNumberMetadataForTesting.xml` upstream, and `ShortNumberInfoTest` runs
   the production short number data against the test phone metadata.
7. The ALTERNATE FORMAT metadata is never switched either; upstream reaches it
   through a static singleton that `PhoneNumberUtil.setInstance` does not touch.

## Regex abstraction

Upstream evaluates metadata patterns with four `java.util.regex` operations,
and `LibPhoneNumber.Regex` exposes exactly those plus a compile probe:

| Java | port |
| --- | --- |
| `Matcher.matches()` | `TryMatchFull` |
| `Matcher.lookingAt()` (+ `end()`, groups) | `TryMatchPrefix`, `TryMatchPrefixEx` |
| `Matcher.replaceAll()` / `replaceFirst()` | `ReplaceAll`, `ReplaceFirst` |
| `Matcher.find()` + `group()` | `TryFindFirst` |

Engines: Delphi uses `System.RegularExpressions` (PCRE); FreePascal uses the
`regexpr` unit of its distribution (`TRegExpr`). No engine type leaks out of the
unit.

- **Replacement templates** are expanded by the unit itself
  (`ExpandJavaReplacement`, a port of `Matcher.appendReplacement`), so no engine
  replacement dialect is involved; the engines only FIND matches. The template
  contract is deliberately lenient (no exception on a malformed user template
  of `FormatByPattern`); an empty pattern is a no-op.
- **Anchoring.** Patterns are wrapped in a non capturing group, so a top level
  alternation is anchored as a whole: `\A(?:p)\z` on PCRE, `\A(?:p)$` on
  TRegExpr. regexpr 0.987 (FreePascal 3.2.2) does not know `\z` and reads it as
  a literal `z`; `$` with `ModifierM = False` is end of input without trailing
  newline tolerance in every TRegExpr version, which is exactly `\z`.
- **Empty input.** regexpr 0.987 answers "no match" for an EMPTY input before
  it looks at the pattern; java.util.regex (and PCRE, and regexpr 1.x) match a
  pattern that can match the empty string against `""` in all four
  operations. On an empty input the only possible match is the zero length
  one at offset 0, so for an engine older than 1.0 the layer asks whether the
  pattern can match the empty string (`EmptyInputMatches`): at the END of the
  one character input `#10` (`ExecPos(2)`), compiled in multi line mode as
  `^(?:p)$`, with every `\A` of `p` outside a class rewritten to `^`. There
  `^`, `$`, `\b` and `\B` answer exactly as at offset 0 of an empty input,
  and 0.987 has no lookaround that could see the line break; its `\Z` is an
  end anchor like `$`, its `\z` the letter `z` on every input (see
  Anchoring). An earlier sentinel AFTER the pattern got anchors inside it
  wrong (`a*$`, `(?:x|$)`); the suite and the runtime gate's regex probes pin
  anchored shapes on the empty input. Found by the FreePascal run of the test
  suite on FPC 3.2.2. Known limitation, deliberately not rewritten for this
  legacy engine (KNOWN_ISSUES.md, permanent item 8): a `(?-m)` group
  (`(?-m)^$`, `(?-m)\A`) and a `(?#...)` comment containing `[` before a
  `\A` answer False instead of True on an empty input. No metadata pattern
  has either shape.
- **Counted quantifier rewrite.** regexpr 0.987 evaluates counted quantifiers
  wrongly in shapes the metadata uses everywhere (`(\d{3})(\d{3})` on `712345`
  reports group 1 = `712345`). For an engine older than 1.0 every `A{n}`,
  `A{n,}` and `A{n,m}` (greedy and reluctant) is rewritten into copies plus
  nested optional copies before compiling (`ExpandCountedQuantifiers`). Atoms
  are scanned whole (escapes, classes, groups). A rewrite larger than
  `ExpansionBudget` characters is not applied; the original pattern is compiled
  instead. The cache stays keyed by the original pattern. regexpr 1.x
  (FreePascal 3.2.4 and later) compiles the patterns unchanged. The rewrite is
  exported and exercised on every compiler by the runtime gate, which matches
  every metadata pattern both as given and rewritten.
- **Group count** comes from the pattern (`CountCapturingGroups`), not from the
  engine, because PCRE reports only the highest participating group.
- **Cache and threading.** Compiled patterns live in a process wide hash table.
  Neither engine is safe for concurrent matching, so one critical section
  guards lookup and match together - coarse on purpose.

### Scanners

Some upstream patterns are not compiled at all but implemented as hand written
scanners: `VALID_PHONE_NUMBER`, `EXTN_PATTERNS_FOR_PARSING` /
`EXTN_PATTERNS_FOR_MATCHING`, the two RFC3966 phone-context patterns,
`SINGLE_INTERNATIONAL_PREFIX`, `VALID_PUNCTUATION` (`IsValidPunctuation`), the
plus characters, the AsYouTypeFormatter's `ELIGIBLE_FORMAT_PATTERN` and
`NATIONAL_PREFIX_SEPARATORS_PATTERN`, and the matcher's `PATTERN`, `LEAD_CLASS`,
six `INNER_MATCHES` and both `trimAfterFirstMatch` patterns. The reason is the
same everywhere: they need non ASCII code points, the Unicode digit class and
case insensitive matching with `UNICODE_CASE`, and the three engines the port
runs on (PCRE, regexpr 0.987, regexpr 1.x) disagree about all three - and on
FreePascal `TRegExpr` matches bytes of a UTF-8 string. The scanners walk CODE
POINTS like `java.util.regex` does. The matcher's `MATCHING_BRACKETS`,
`PUB_PAGES`, `SLASH_SEPARATED_DATES` and the two `TIME_STAMPS` patterns do go
through the regex layer, written in pure ASCII (`\d` / `\s` spelled out as their
ASCII Java meaning; `MATCHING_BRACKETS` runs over a candidate folded onto one
ASCII representative per bracket class).

Unicode decimal digits: `UnicodeDigitZeros` in `MetadataCore` lists the DIGIT
ZERO of every `Nd` run in the BMP; it ports `\p{Nd}` and
`Character.digit(c, 10)`. `NormalizeDigits` works on code units, because it
ports `Character.digit(char, 10)`. See `tools/README.md` for how the table was
enumerated.

## Strings on both compilers

- **Delphi**: `string` is UnicodeString (UTF-16), like Java's String. All
  lengths and offsets are UTF-16 code units, as upstream.
- **FreePascal** (`{$MODE DELPHI}`): `string` is an AnsiString, and the library
  treats it as UTF-8. The program sets `SetMultiByteConversionCodePage(CP_UTF8)`
  and, on Unix, links `cwstring`. Every length, index and character test that
  upstream performs on a Java String is performed on the UnicodeString form of
  the argument, so results - including `TPhoneNumberMatch.Start` /
  `EndIndex` - are UTF-16 based on both compilers. Byte indices never leave a
  unit. Code that must see individual UTF-16 units (the AsYouTypeFormatter's
  template with the U+2008 placeholder, the code point primitives) works on
  `UnicodeString` directly. A lone surrogate cannot be carried by a UTF-8
  `string`.
- No unit builds a non ASCII `string` in an INITIALIZATION section: it would be
  converted before the program can set the code page.
- The open Unicode categories L and N behind `UNWANTED_END_CHARS` come from each
  compiler's RTL (like upstream takes them from its JDK); the RTLs ship
  different Unicode versions. See KNOWN_ISSUES.md, permanent item 7.

## Reference oracle

`tools/generate_reference_cases.ps1`, `tools/generate_aytf_cases.ps1` and
`tools/run_mass_differential.ps1` load the published NuGet package
`libphonenumber-csharp`, pinned to the metadata release of the Java baseline.
The pin, cache resolution, restore, assembly load and version gate live once,
in `tools/oracle_helpers.ps1` (`Get-OraclePin` is the canonical pin). The
package is restored into the git-ignored cache `tools/.nuget-oracle/` through a
generated `net8.0` host project; the vendor C# source is never built. The
scripts therefore need PowerShell 7.

Known places where the oracle is NOT the reference:

1. **Code points versus code units.** .NET regex matches UTF-16 code units,
   java.util.regex code points. The scanners follow Java; two supplementary
   character cases and the three extra case foldings of the extension labels
   (U+017F, U+0131, U+0130) are pinned as Java-versus-oracle divergences.
2. **The C# `PhoneNumberMatcher` is not a current translation of the Java one.**
   It differs in five places (an older `extractInnerMatch`, `PUB_PAGES` tested in
   `extractMatch`, a different `MATCHING_BRACKETS`, a different `PATTERN`,
   hand written `TIME_STAMPS_SUFFIX` / `trimAfterFirstMatch` /
   `UNWANTED_END_CHARS`); see the header of
   `tests/LibPhoneNumber.PhoneNumberMatcher.Tests.pas`. Matcher tests use the
   oracle where it agrees with Java and pin the rest with the Java derivation;
   the mass differential leaves the matcher out.
3. **`getInvalidExampleNumber`** has no C# counterpart.

## Test strategy

### Test Expectations

Never copy an expected value out of `PhoneNumberUtilTest.java` or its C#
counterpart into a production test. Those suites run against
`PhoneNumberMetadataForTesting.xml`, which differs from the shipped
`PhoneNumberMetadata.xml` for several territories (AR, AU, MX and UZ among
them). Take the test IDEA from upstream and recompute the value with the oracle
or read it off the production XML, and record in the test where it came from.

The one exception: the four ported upstream suites
(`tests/LibPhoneNumber.UpstreamSuite.*.Tests.pas`) switch the metadata to the
generated TEST tables in `Setup` (`UseTestingMetadata`) and back in `TearDown`
(`RestoreProductionMetadata`). They read the same data the Java suite reads, so
there the Java value is copied verbatim and must NOT be recomputed with the
oracle (which ships production metadata). A new test unit that wants Java values
has to switch the metadata the same way and say so in its header.

### Gates

| gate | what it proves |
| --- | --- |
| test suite on Delphi (`tools/run_delphi_tests.ps1`) | ported upstream suites, oracle based production tests, parser gates over the reference corpus and every example number |
| test suite on FreePascal (`tools/run_fpc_tests.ps1`) | the same program and the same expectations, built with FreePascal |
| generated unit check (`run_update_workflow.ps1 -FailOnDiff`) | the committed generated units are the exact output of the generator plus the pinned XMLs |
| length compare gate | the possible-length model of the generated units equals the upstream XML, per territory, in both directions |
| mass differential (`-RunMassDifferential`) | every example number agrees with the oracle on parse, four formats, possible, valid, type and region |
| FreePascal compile check | every hand written unit of `src/` compiles with FreePascal; any warning fails |
| FreePascal runtime check | a Delphi and a FreePascal build of `tools/fpcruntime/PhoneNumbersFpcRuntime.dpr` write byte identical observation files |

The test suite is ONE program (`tests/LibPhoneNumberTests.dpr`) on a test
layer of its own (`tests/framework/`): fixtures derive from `TTestCase`, their
tests are their published methods (found through the published method table,
whose layout the layer handles per compiler), and the `Assert` class is source
compatible with the DUnitX subset the suite was written against. No
attributes, no RTTI unit and no external framework, which is what lets the
same source run on FreePascal 3.2. Two FreePascal specific rules of the test
sources follow from the string contract: `{$CODEPAGE UTF8}` in every test
unit, so a `#$XXXX` constant reaches a UTF-8 `string` intact, and Java String
lengths and offsets measured on the `UnicodeString` form. The GitHub workflow
runs the FreePascal suite on Ubuntu with the distribution's FreePascal
(x86_64) and publishes its JUnit report.

The runtime gate's mandatory toolchain is FreePascal 3.2.4 in WSL;
`-Toolchain Native` (Windows FPC) and `-Toolchain Mac` are extra runs. It
checks identity rather than expectations, over a far larger input space than
the suite. It refuses to pass vacuously: every section counter must be
positive and the exception, pattern failure, rewrite mismatch and expansion
probe counters must be zero.

## Closed questions

These are decisions, not backlog.

1. **Some `PhoneNumberUtilTest` methods are not ported** (the count is in the
   AGENTS.md manifest):
   `testMaybeStripInternationalPrefix` and `testMaybeExtractCountryCode` call
   private steps of the parse driver on their own (porting them would mean
   exporting parse internals as public API); the two `...ForMissingMetadata`
   tests need a metadata loader that can fail (the generated tables are
   linked); `testIsNumberMatchAcceptsProtoDefaultsAsMatch` and
   `testIsNumberMatchMatchesDiffLeadingZerosIfItalianLeadingZeroFalse` assert
   the `italianLeadingZero` / `numberOfLeadingZeros` proto pair `TPhoneNumber`
   does not model. Reasons are in the header of
   `tests/LibPhoneNumber.UpstreamSuite.Tests.pas`.
2. Inside ported tests, the assertions on `italianLeadingZero` /
   `numberOfLeadingZeros` are omitted, and `testRemovalNotSupported` has no
   counterpart (`Iterator.remove()` does not exist here).
3. **Deferred: possible-length slices.** `GetPossibleLengths` and friends
   materialise a dynamic array per call. A slice view would avoid the
   allocation but would change the shape of the whole metadata read API for a
   throughput gain nothing currently needs.
4. **Deferred: source bound handles.** A handle type that makes a
   `UseMetadataTables` switch invalidate outstanding metadata pointers
   detectably. Today the rule is documentation in the headers of
   `LibPhoneNumber.Metadata` and `LibPhoneNumber.TestingMetadata`.
5. Geocoder, carrier mapper and time zone mapper are not ported; that would
   need a concrete use case.

## Performance

Documentation, not a gate. Win64, Delphi compiler 37.0, the upstream example
number corpus x 50 repetitions, warm pattern cache
(`tools/run_benchmark.ps1`):

| operation | ops/s | per call |
| --- | --- | --- |
| `Parse` | ~217000 | 4.6 us |
| `IsValidNumber` | ~381000 | 2.6 us |
| `Format(INTERNATIONAL)` | ~271000 | 3.7 us |
| all three back to back | ~85000 | 11.7 us |
