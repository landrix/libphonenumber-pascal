program DUnitXCmdTest;

{$APPTYPE CONSOLE}

{$STRONGLINKTYPES ON}

uses
  SysUtils,
  Forms,
  DUnitX.ConsoleWriter.Base,
  DUnitX.DUnitCompatibility,
  DUnitX.Generics,
  DUnitX.InternalInterfaces,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Text,
  DUnitX.Loggers.XML.NUnit,
  DUnitX.Loggers.XML.xUnit,
  DUnitX.Test,
  DUnitX.TestFixture,
  DUnitX.TestFramework,
  DUnitX.TestResult,
  DUnitX.RunResults,
  DUnitX.TestRunner,
  DUnitX.Utils,
  DUnitX.Utils.XML,
  DUnitX.WeakReference,
  DUnitX.Windows.Console,
  DUnitX.StackTrace.EurekaLog7,
  DUnitX.FixtureResult,
  DUnitX.Loggers.Null,
  DUnitX.MemoryLeakMonitor.Default,
  DUnitX.Extensibility,
  DUnitX.CommandLine.OptionDef,
  DUnitX.CommandLine.Options,
  DUnitX.CommandLine.Parser,
  DUnitX.Timeout,
  DUnitX.Attributes,
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
  { The upstream TEST metadata. Linked HERE and nowhere else: no
    unit under src\ references these four, so only this test binary carries
    them. }
  LibPhoneNumber.TestingMetadata.Data in '..\src\LibPhoneNumber.TestingMetadata.Data.pas',
  LibPhoneNumber.TestingMetadata.Descs in '..\src\LibPhoneNumber.TestingMetadata.Descs.pas',
  LibPhoneNumber.TestingMetadata.Formats in '..\src\LibPhoneNumber.TestingMetadata.Formats.pas',
  LibPhoneNumber.TestingMetadata in '..\src\LibPhoneNumber.TestingMetadata.pas'
  ;

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
  try
    //Create the runner
    runner := TDUnitX.CreateRunner;
    runner.UseRTTI := True;

    //tell the runner how we will log things

    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;

    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;

    //Report failing/errored tests to the caller (CI, tools\run_delphi_tests.ps1).
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    //Only pause when explicitly requested via the DUnitX command line
    //(--exitbehavior:Pause); the default is Continue so CI does not hang.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
  except
    on E: Exception do
    begin
      System.Writeln(E.ClassName, ': ', E.Message);
      System.ExitCode := EXIT_ERRORS;
    end;
  end;
end.
