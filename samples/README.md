# Samples

Small console programs, one task each. Every program builds unchanged with
Delphi and with FreePascal and prints exactly the same output with both; the
expected output of each is in [`expected/`](expected/). Each program is self
contained, so you can copy one into a project of your own.

| program | what it shows |
| --- | --- |
| [`QuickStart.dpr`](QuickStart.dpr) | The quick start of the README: parse, validate, classify, format, format as you type, find numbers in text. |
| [`PhoneNumberDemo.dpr`](PhoneNumberDemo.dpr) | A short tour: several numbers through parsing, validation, typing and every format, an as-you-type sequence, numbers in a sentence. |
| [`ParseAndValidate.dpr`](ParseAndValidate.dpr) | The fields of a parsed `TPhoneNumber`, every parse error, possible versus valid, validation for a region and a type, number types, `IsNumberMatch`. |
| [`FormatNumbers.dpr`](FormatNumbers.dpr) | Every `TPhoneNumberFormat`, dialling from abroad, `FormatInOriginalFormat`, mobile dialling, vanity numbers, carrier codes, `FormatByPattern`, area code lengths. |
| [`AsYouType.dpr`](AsYouType.dpr) | `TAsYouTypeFormatter`: one formatter per field, `Clear`, punctuation typed by the user, an unknown region, the remembered cursor position. |
| [`FindNumbersInText.dpr`](FindNumbersInText.dpr) | `FindNumbers`, the four leniency levels on one text, `TPhoneNumberMatcher`, UTF-16 offsets in non ASCII text, the `maxTries` budget. |
| [`ShortNumbers.dpr`](ShortNumbers.dpr) | `LibPhoneNumber.ShortNumberInfo`: short and emergency numbers, expected cost, carrier specific and SMS numbers, example short numbers. |
| [`RegionsAndExamples.dpr`](RegionsAndExamples.dpr) | Region and calling code lookup, exact versus canonicalised region codes, supported number types, example numbers, the metadata version. |

The [user guide](../docs/GUIDE.md) explains what the programs show.

## Building

Build from this folder; the output goes to `bin/` (git-ignored). The only
dependency is the `src/` folder of this repository on the unit search path.

Delphi (Win64 command line compiler; run `rsvars.bat` of your installation
first or call `dcc64.exe` with its full path):

```bat
mkdir bin\dcu
dcc64 -B -U..\src -NUbin\dcu -Ebin ParseAndValidate.dpr
bin\ParseAndValidate.exe
```

In the IDE, open the `.dpr` file and add `..\src` to the search path of the
project (Project > Options > Building > Delphi Compiler > Search path).

FreePascal (3.2.2 or later; Windows, Linux or macOS):

```sh
mkdir -p bin/units
fpc -Mdelphi -Fu../src -FUbin/units -FEbin ParseAndValidate.dpr
bin/ParseAndValidate
```

Lazarus: Project > New Project from File (or open the `.dpr` as a program),
then add `../src` under Project > Project Options > Compiler Options > Paths >
Other unit files.

On FreePascal every program sets `SetMultiByteConversionCodePage(CP_UTF8)`
and links `cwstring` on Unix; every program that hands non ASCII text to the
library has to do the same (see "FreePascal and Lazarus" in the
[user guide](../docs/GUIDE.md#lazarus-and-freepascal)).

## Rules for the samples

The expected outputs are checked: `tools/run_samples.ps1` builds every
program, runs it and compares its output with `expected/<name>.txt`, with
Delphi and with FreePascal; the quick check, the update workflow and the
FreePascal job of the GitHub workflow run it (see
[`tools/README.md`](../tools/README.md)). So that one expected file holds for
every compiler:

1. **ASCII output only.** The Delphi console maps non ASCII text through the
   ANSI code page, FreePascal writes UTF-8, so the bytes would differ. Build
   non ASCII input from code points (`#$FF10`) in a `UnicodeString` and print
   an ASCII description of it, never the text itself. The script rejects
   output that is not ASCII.
2. **Typed constant arrays, no `for S in ['...', '...']`.** FreePascal 3.2.2
   truncates the elements of such a literal to the length of the first one.
3. **Stable data only.** Use the numbers upstream itself documents (CH
   `044 668 18 00`, US `650 253 0000`, DE `030 123456`); never print a count
   or anything else that moves with a metadata refresh.
4. **`try ... except` around the program**, printing the exception and
   setting `ExitCode := 1`, so that a raise fails the check.
5. **Same source for both compilers**: the `{$IFDEF FPC}` header and the uses
   clause of the existing programs.

The expected files are ASCII with LF line ends (`.gitattributes` keeps them
LF on every checkout); the comparison turns CRLF into LF on both sides first,
because a Delphi program on Windows writes CRLF. A new sample or a changed
output: run `tools/run_samples.ps1 -UpdateExpected`, review the diff of
`expected/`, then run the script on every compiler you have.
