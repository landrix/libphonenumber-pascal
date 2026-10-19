program LibPhoneNumberTests;

{
  The test program of libphonenumber-pascal. One source for Delphi and
  FreePascal (3.2.2 and later):

    Delphi      tools/run_delphi_tests.ps1 (msbuild LibPhoneNumberTests.dproj)
    FreePascal  tools/run_fpc_tests.ps1, or by hand from this folder:
                  fpc -Mdelphi -Sh -Fu../src -Fuframework -FUbin/units -FEbin LibPhoneNumberTests.dpr

  Command line: see LibPhoneNumber.TestRunner (--filter, --junit, --verbose,
  --list). Exit code 0 only when every selected test passed.

  String contract on FreePascal: `string` is an AnsiString there, and the
  library and the tests treat it as UTF-8. The program therefore makes the
  AnsiString <-> UnicodeString conversion lossless before any test runs:
  SetMultiByteConversionCodePage(CP_UTF8) and, on Unix, the cwstring
  widestring manager (KNOWN_ISSUES.md). On Delphi `string` is UnicodeString
  and neither step applies.

  Every unit of src/ is listed, the generated ones included, so this program
  is the one artefact that compiles the whole library together with the
  tests. The TESTING metadata units are linked here and nowhere else.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}
{$APPTYPE CONSOLE}

uses
{$IFDEF FPC}
  {$IFDEF UNIX}
  cwstring,
  {$ENDIF}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.TestFramework in 'framework\LibPhoneNumber.TestFramework.pas',
  LibPhoneNumber.TestJson in 'framework\LibPhoneNumber.TestJson.pas',
  LibPhoneNumber.TestRunner in 'framework\LibPhoneNumber.TestRunner.pas',
  LibPhoneNumber.PhoneNumberUtil.Tests in 'LibPhoneNumber.PhoneNumberUtil.Tests.pas',
  LibPhoneNumber.Metadata.Tests in 'LibPhoneNumber.Metadata.Tests.pas',
  LibPhoneNumber.MetadataCore.Tests in 'LibPhoneNumber.MetadataCore.Tests.pas',
  LibPhoneNumber.AsYouTypeFormatter.Tests in 'LibPhoneNumber.AsYouTypeFormatter.Tests.pas',
  LibPhoneNumber.ShortNumberInfo.Tests in 'LibPhoneNumber.ShortNumberInfo.Tests.pas',
  LibPhoneNumber.PhoneNumberMatcher.Tests in 'LibPhoneNumber.PhoneNumberMatcher.Tests.pas',
  LibPhoneNumber.UpstreamSuite.Tests in 'LibPhoneNumber.UpstreamSuite.Tests.pas',
  LibPhoneNumber.UpstreamSuite.ShortNumber.Tests in 'LibPhoneNumber.UpstreamSuite.ShortNumber.Tests.pas',
  LibPhoneNumber.UpstreamSuite.Matcher.Tests in 'LibPhoneNumber.UpstreamSuite.Matcher.Tests.pas',
  LibPhoneNumber.UpstreamSuite.AsYouTypeFormatter.Tests in 'LibPhoneNumber.UpstreamSuite.AsYouTypeFormatter.Tests.pas',
  LibPhoneNumber.PhoneNumberUtil in '..\src\LibPhoneNumber.PhoneNumberUtil.pas',
  LibPhoneNumber.Types in '..\src\LibPhoneNumber.Types.pas',
  LibPhoneNumber.Metadata.Types in '..\src\LibPhoneNumber.Metadata.Types.pas',
  LibPhoneNumber.Metadata.Data in '..\src\LibPhoneNumber.Metadata.Data.pas',
  LibPhoneNumber.Metadata.Descs in '..\src\LibPhoneNumber.Metadata.Descs.pas',
  LibPhoneNumber.Metadata.Formats in '..\src\LibPhoneNumber.Metadata.Formats.pas',
  LibPhoneNumber.Metadata in '..\src\LibPhoneNumber.Metadata.pas',
  LibPhoneNumber.Regex in '..\src\LibPhoneNumber.Regex.pas',
  LibPhoneNumber.MetadataCore in '..\src\LibPhoneNumber.MetadataCore.pas',
  LibPhoneNumber.MetadataFormat in '..\src\LibPhoneNumber.MetadataFormat.pas',
  LibPhoneNumber.AsYouTypeFormatter in '..\src\LibPhoneNumber.AsYouTypeFormatter.pas',
  LibPhoneNumber.ShortMetadata.Data in '..\src\LibPhoneNumber.ShortMetadata.Data.pas',
  LibPhoneNumber.ShortMetadata.Descs in '..\src\LibPhoneNumber.ShortMetadata.Descs.pas',
  LibPhoneNumber.ShortMetadata in '..\src\LibPhoneNumber.ShortMetadata.pas',
  LibPhoneNumber.ShortNumberInfo in '..\src\LibPhoneNumber.ShortNumberInfo.pas',
  LibPhoneNumber.AlternateFormats.Data in '..\src\LibPhoneNumber.AlternateFormats.Data.pas',
  LibPhoneNumber.AlternateFormats in '..\src\LibPhoneNumber.AlternateFormats.pas',
  LibPhoneNumber.PhoneNumberMatcher in '..\src\LibPhoneNumber.PhoneNumberMatcher.pas',
  LibPhoneNumber.TestingMetadata.Data in '..\src\LibPhoneNumber.TestingMetadata.Data.pas',
  LibPhoneNumber.TestingMetadata.Descs in '..\src\LibPhoneNumber.TestingMetadata.Descs.pas',
  LibPhoneNumber.TestingMetadata.Formats in '..\src\LibPhoneNumber.TestingMetadata.Formats.pas',
  LibPhoneNumber.TestingMetadata in '..\src\LibPhoneNumber.TestingMetadata.pas';

begin
{$IFDEF FPC}
  SetMultiByteConversionCodePage(CP_UTF8);
{$ENDIF}
  try
    ExitCode := RunTestsFromCommandLine;
  except
    on E: Exception do
    begin
      WriteLn('ERROR (runner) ', E.ClassName, ': ', E.Message);
      ExitCode := 2;
    end;
  end;
end.
