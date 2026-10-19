# Samples

`PhoneNumberDemo.dpr` is a small console program: it parses, validates,
classifies and formats a few numbers, feeds digits into the
AsYouTypeFormatter and finds numbers in a sentence. It builds unchanged with
Delphi and FreePascal and prints the same output with both.

Build from this folder; the output goes to `bin/` (git-ignored).

Delphi (Win64 command line compiler; run `rsvars.bat` of your installation
first or call `dcc64.exe` with its full path):

```bat
mkdir bin\dcu
dcc64 -B -U..\src -NUbin\dcu -Ebin PhoneNumberDemo.dpr
bin\PhoneNumberDemo.exe
```

FreePascal (3.2.2 or later; Windows, Linux or macOS):

```sh
mkdir -p bin/units
fpc -Mdelphi -Fu../src -FUbin/units -FEbin PhoneNumberDemo.dpr
bin/PhoneNumberDemo
```

On FreePascal the program sets `SetMultiByteConversionCodePage(CP_UTF8)` and
links `cwstring` on Unix; every program that hands non ASCII text to the
library has to do the same (see the README of the repository).
