# Known Issues

This file lists what is OPEN and actionable, followed by the behaviour that is
permanent by design. Item numbers are referenced from the source code; keep
them stable.

## Critical

1. None known.

## Open

1. **A few `PhoneNumberUtilTest` methods stay unported, none for missing API**
   (count in the AGENTS.md manifest).
   They test private parse driver steps on their own
   (`maybeStripInternationalPrefixAndNormalize`, `maybeExtractCountryCode`), a
   failing metadata loader the port does not have, or the
   `italianLeadingZero` / `numberOfLeadingZeros` proto pair `TPhoneNumber` does
   not model. Each is listed with its reason in the header of
   `tests/LibPhoneNumber.UpstreamSuite.Tests.pas`.
2. **Curated reference cases can go stale.** The `java*` fields of a curated case
   in `tests/data/reference_cases_java_csharp.json` are preserved once set, so a
   change in the oracle does not update them and has to be reviewed by hand.
   Auto-generated `* auto example` cases are not affected - their `java*` fields
   are always refreshed. The generator refuses to write the corpus at all when a
   case cannot be recomputed, so a failing run cannot leave a stale case behind.

## Permanent by design

These are closed questions, not backlog. They are listed so that nobody
reopens them.

1. **`TPhoneNumber` does not model the proto fields `italianLeadingZero` and
   `numberOfLeadingZeros`.** It carries `NationalNumberDigits` instead, which
   preserves the same information as a string. Three assertion level omissions
   inside the ported upstream tests follow from this, and
   `testRemovalNotSupported` has no counterpart because `Iterator.remove()` has
   none.
2. **For a shared calling code (NANPA +1) the caller supplied region is kept**
   when it owns the code; otherwise the calling-code-to-region map resolves the
   single main region. That map is the generated metadata
   (`mainCountryForCode` order). Upstream carries no region on the number at
   all, so this is an addition, and `TPhoneNumber.RegionCode` documents its
   exact contract.
3. **Region arguments are canonicalised** with `UpperCase(Trim(...))` at every
   public entry point (facade, `TAsYouTypeFormatter` constructor,
   `ShortNumberInfo`). Upstream compares CLDR codes exactly; the canonical
   spellings are a strict superset of what it accepts, so this changes no answer
   for a caller that passes canonical codes.
4. **The alternate format metadata is NOT switched** when the phone metadata is
   switched to the upstream TEST data set. Upstream reaches it through the static
   `DefaultMetadataDependenciesProvider.getInstance()` singleton, which
   `PhoneNumberUtil.setInstance` does not touch; the port reproduces that
   asymmetry deliberately.
5. **The reference oracle needs PowerShell 7.** The assembly targets `net8.0`, so
   `generate_reference_cases.ps1`, `generate_aytf_cases.ps1` and
   `run_mass_differential.ps1` abort under Windows PowerShell 5.1.
   `run_update_workflow.ps1` starts them as child `pwsh` processes, so the
   workflow itself can still be launched from Windows PowerShell.
6. **FreePascal callers must give `string` a lossless code page.** On
   FreePascal in Delphi mode `string` is an AnsiString, and every unit widens a
   `string` argument to UnicodeString before it looks at a non ASCII
   character. That is only lossless when the conversion is: set
   `SetMultiByteConversionCodePage(CP_UTF8)` (the Lazarus convention) and, on
   Unix, put `cwstring` into the program's uses clause - without a widestring
   manager the FPC RTL on Unix turns every non ASCII character into `?`. A
   LONE surrogate cannot be carried by a UTF-8 `string` at all; only the
   UnicodeString entry points (the code point primitives, the
   AsYouTypeFormatter) can receive one. The runtime gate driver
   `tools/fpcruntime/PhoneNumbersFpcRuntime.dpr`, the test program
   `tests/LibPhoneNumberTests.dpr` and the sample in `samples/` do exactly
   this. A unit that spells non ASCII text as a numeric constant (`#$FF11`) in
   a `string` context additionally needs a source code page: without
   `{$CODEPAGE UTF8}` FreePascal converts such a constant at COMPILE time
   through its default code page and turns every character outside it into
   `?` (the test units carry the directive for exactly that reason). ASCII
   input - which is what the metadata path works on - is unaffected. Inside the port the rule is: a `string` is UTF-8 on
   FreePascal, and every length, index and character test that upstream
   performs on a Java String is performed on its UnicodeString form - the
   facade (`LibPhoneNumber.PhoneNumberUtil`, whose unit header states the
   contract) and the matcher report and consume UTF-16 lengths and offsets on
   both compilers. A pattern or other `string` built from non ASCII code points
   in a unit INITIALIZATION section would be converted before the program can
   set the UTF-8 code page; no unit does that.
7. **The open Unicode categories come from the RTL, and the RTLs differ.**
   `UNWANTED_END_CHARS` (which trailing characters `ExtractPossibleNumber`
   strips) is defined by the general categories L and N, and the port asks the
   RTL for them, like upstream inherits them from its JDK. Delphi 13 and
   FreePascal 3.3.1 agree completely; FreePascal 3.2.4 ships an older Unicode
   version, so letters added since (for example U+088F, U+0C5C, U+0CDC,
   U+1C89, U+1C8A and the Latin Extended-D additions around U+A7CB..U+A7DC) are
   unwanted end characters there, and FreePascal 3.2.2 is older still.
   `tools/run_fpc_runtime_check.ps1` sweeps the BMP into a separate file and
   prints every differing range as a warning on each run; it does not fail
   over it, because pinning a Unicode version would be a decision upstream
   does not make either. Every character class the port spells out itself
   (Nd, `VALID_PUNCTUATION`, the plus characters, the vanity dial pad) is
   compared strictly and identical on all compilers. No test of the suite
   depends on a character in the differing ranges, so the suite passes
   unchanged on FreePascal 3.2.x; a test that did would need a version
   conditional expectation with the reason next to it, never a skip.
8. **Two pattern shapes the empty input probe of regexpr < 1.0 answers
   wrongly.** regexpr 0.987 (FreePascal 3.2.2) never matches an empty input,
   so the regex layer decides an empty input with a multi line probe
   (`EmptyInputMatches` in `src/LibPhoneNumber.Regex.pas`). On an EMPTY input
   two shapes answer False where java.util.regex answers True: an inline
   modifier group that switches multi line mode off (`(?-m)^$`,
   `(?-m)\A`), and a `(?#...)` comment containing `[` in front of a `\A` (the
   anchor rewrite of the probe then misreads the class state). `(?#...)` is
   not java.util.regex syntax and thus outside the contract of a port of Java
   patterns. No metadata pattern contains either shape (none of the generated
   units nor the four upstream XMLs has a `(?-` or `(?#` group); only a
   caller supplied pattern, on FreePascal 3.2.2, with an empty input can hit
   them. Deliberately not rewritten for this legacy engine; FreePascal 3.2.4
   and later (regexpr 1.x) and Delphi do not use the probe.

## Deferred

Consciously not done (see `docs/ARCHITECTURE.md`):

1. Hot path allocation of the possible-length slices - every
   `GetPossibleLengths` call materialises a dynamic array. A slice view would
   avoid it but would change the shape of the whole metadata read API for a
   throughput gain nothing currently needs.
2. A source bound HANDLE type for metadata records, so that a
   `UseMetadataTables` switch would invalidate outstanding pointers detectably.
   Today this is DOCUMENTATION, in the headers of
   `src/LibPhoneNumber.Metadata.pas` and
   `src/LibPhoneNumber.TestingMetadata.pas`.
