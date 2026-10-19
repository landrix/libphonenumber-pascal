unit LibPhoneNumber.TestRunner;

{
  The console runner of the test layer (LibPhoneNumber.TestFramework): runs
  the registered fixtures, prints every failure and a summary, optionally
  writes a JUnit XML report, and answers the process exit code.

  Command line (tests/LibPhoneNumberTests.dpr hands it over unchanged):

    --filter <Fixture>[.<Test>]   run only matching tests; may be repeated and
                                  may hold several comma separated entries.
                                  Names compare case insensitively. A filter
                                  that matches nothing is an error.
    --junit <file>                write a JUnit XML report (UTF-8)
    --verbose                     print every test and its log lines
    --list                        list the tests instead of running them
    --help                        usage

  Exit code: 0 when every selected test passed, 1 when a test failed or
  raised, 2 for a usage error, a filter without a match or a run without any
  test.

  Output contract (tools/run_delphi_tests.ps1 and tools/run_fpc_tests.ps1
  rely on it): every test that does not pass prints a line starting with
  "FAIL  " or "ERROR " followed by Fixture.Test, then its message indented;
  the last line of a run is the summary
    "Tests: <n>  passed: <p>  failed: <f>  errors: <e>  time: <s> s".
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

{ Parses the command line, runs and reports. Returns the exit code. }
function RunTestsFromCommandLine: Integer;

{ The compiler and target the program was built with, e.g.
  "Delphi 37.0 (Win64)" or "FreePascal 3.2.4 (aarch64-linux)". }
function CompilerDescription: string;

implementation

uses
{$IFDEF FPC}
  SysUtils,
  Classes,
{$ELSE}
  System.SysUtils,
  System.Classes,
{$ENDIF}
  LibPhoneNumber.TestFramework;

type
  TTestOutcome = (toPassed, toFailed, toError);

  TTestResult = record
    Fixture: string;
    Name: string;
    Outcome: TTestOutcome;
    Message: string;
    Seconds: Double;
    Log: string;
  end;

  TRunOptions = record
    Filters: array of string;
    FilterHits: array of Integer;
    JUnitFile: string;
    Verbose: Boolean;
    ListOnly: Boolean;
  end;

function CompilerDescription: string;
begin
{$IFDEF FPC}
  Result := 'FreePascal ' + {$I %FPCVERSION%} + ' (' + {$I %FPCTARGETCPU%} + '-' +
    {$I %FPCTARGETOS%} + ')';
{$ELSE}
  Result := Format('Delphi %.1f', [CompilerVersion], TFormatSettings.Invariant);
  {$IF Defined(WIN64)}
  Result := Result + ' (Win64)';
  {$ELSEIF Defined(WIN32)}
  Result := Result + ' (Win32)';
  {$ELSE}
  Result := Result + ' (other)';
  {$IFEND}
{$ENDIF}
end;

function TickMilliseconds: Int64;
begin
{$IFDEF FPC}
  Result := Int64(GetTickCount64);
{$ELSE}
  Result := Int64(TThread.GetTickCount64);
{$ENDIF}
end;

procedure PrintUsage;
begin
  WriteLn('Usage: LibPhoneNumberTests [--filter <Fixture>[.<Test>]] [--junit <file>] [--verbose] [--list]');
  WriteLn('  --filter  run only matching tests; repeatable, comma separated, case insensitive');
  WriteLn('  --junit   write a JUnit XML report');
  WriteLn('  --verbose print every test and its log lines');
  WriteLn('  --list    list the tests instead of running them');
end;

procedure AddFilters(var AOptions: TRunOptions; const AValue: string);
var
  Parts: TStringList;
  I: Integer;
  Entry: string;
begin
  Parts := TStringList.Create;
  try
    Parts.StrictDelimiter := True;
    Parts.Delimiter := ',';
    Parts.DelimitedText := AValue;
    for I := 0 to Parts.Count - 1 do
    begin
      Entry := Trim(Parts[I]);
      if Entry = '' then
        Continue;
      SetLength(AOptions.Filters, Length(AOptions.Filters) + 1);
      AOptions.Filters[High(AOptions.Filters)] := Entry;
    end;
  finally
    Parts.Free;
  end;
  SetLength(AOptions.FilterHits, Length(AOptions.Filters));
end;

function ParseOptions(out AOptions: TRunOptions; out AError: string): Boolean;
var
  I, Before: Integer;
  Arg: string;
begin
  AOptions.Filters := nil;
  AOptions.FilterHits := nil;
  AOptions.JUnitFile := '';
  AOptions.Verbose := False;
  AOptions.ListOnly := False;
  AError := '';
  I := 1;
  while I <= ParamCount do
  begin
    Arg := ParamStr(I);
    if (Arg = '--filter') or (Arg = '--junit') then
    begin
      if I = ParamCount then
      begin
        AError := Arg + ' needs a value.';
        Exit(False);
      end;
      Inc(I);
      if Arg = '--filter' then
      begin
        Before := Length(AOptions.Filters);
        AddFilters(AOptions, ParamStr(I));
        { "--filter ,," must not silently select the whole suite. }
        if Length(AOptions.Filters) = Before then
        begin
          AError := '--filter needs at least one non-empty <Fixture>[.<Test>] entry.';
          Exit(False);
        end;
      end
      else
        AOptions.JUnitFile := ParamStr(I);
    end
    else if Arg = '--verbose' then
      AOptions.Verbose := True
    else if Arg = '--list' then
      AOptions.ListOnly := True
    else if (Arg = '--help') or (Arg = '-h') or (Arg = '/?') then
    begin
      AError := '';
      Exit(False);
    end
    else
    begin
      AError := 'Unknown argument: ' + Arg;
      Exit(False);
    end;
    Inc(I);
  end;
  Result := True;
end;

function IsSelected(var AOptions: TRunOptions; const AFixture, ATest: string): Boolean;
var
  I, Dot: Integer;
  Filter: string;
begin
  if Length(AOptions.Filters) = 0 then
    Exit(True);
  Result := False;
  for I := 0 to High(AOptions.Filters) do
  begin
    Filter := AOptions.Filters[I];
    Dot := Pos('.', Filter);
    if Dot = 0 then
    begin
      if not SameText(Filter, AFixture) then
        Continue;
    end
    else if not (SameText(Copy(Filter, 1, Dot - 1), AFixture) and
      SameText(Copy(Filter, Dot + 1, MaxInt), ATest)) then
      Continue;
    Inc(AOptions.FilterHits[I]);
    Result := True;
  end;
end;

function Indent(const AText: string): string;
begin
  Result := '      ' + StringReplace(StringReplace(AText, #13#10, #10, [rfReplaceAll]),
    #10, sLineBreak + '      ', [rfReplaceAll]);
end;

{ ---------------------------------------------------------------------------
  JUnit XML
  --------------------------------------------------------------------------- }

function XmlEscape(const AText: string): string;
var
  I: Integer;
  Ch: Char;
begin
  Result := '';
  for I := 1 to Length(AText) do
  begin
    Ch := AText[I];
    case Ch of
      '&': Result := Result + '&amp;';
      '<': Result := Result + '&lt;';
      '>': Result := Result + '&gt;';
      '"': Result := Result + '&quot;';
      #9, #10, #13: Result := Result + Ch;
    else
      { XML 1.0 has no representation for the other C0 controls. }
      if Ord(Ch) < $20 then
        Result := Result + '?'
      else
        Result := Result + Ch;
    end;
  end;
end;

function SecondsText(ASeconds: Double): string;
var
  Settings: TFormatSettings;
begin
{$IFDEF FPC}
  Settings := DefaultFormatSettings;
{$ELSE}
  Settings := TFormatSettings.Invariant;
{$ENDIF}
  Settings.DecimalSeparator := '.';
  Result := FormatFloat('0.000', ASeconds, Settings);
end;

procedure WriteJUnit(const AFileName: string; const AResults: array of TTestResult;
  ATotalSeconds: Double);
var
  Lines: TStringList;
  I, J, Tests, Failures, Errors: Integer;
  Fixture: string;
  Seconds: Double;
  Stream: TFileStream;
  Bytes: TBytes;
{$IFDEF FPC}
  Raw: RawByteString;
{$ENDIF}

  procedure CountFixture(AFirst: Integer; out ALast: Integer);
  begin
    ALast := AFirst;
    Tests := 0;
    Failures := 0;
    Errors := 0;
    Seconds := 0;
    while (ALast <= High(AResults)) and (AResults[ALast].Fixture = AResults[AFirst].Fixture) do
    begin
      Inc(Tests);
      case AResults[ALast].Outcome of
        toPassed: ;
        toFailed: Inc(Failures);
        toError: Inc(Errors);
      end;
      Seconds := Seconds + AResults[ALast].Seconds;
      Inc(ALast);
    end;
    Dec(ALast);
  end;

var
  Last, AllFailures, AllErrors: Integer;
begin
  AllFailures := 0;
  AllErrors := 0;
  for I := 0 to High(AResults) do
    case AResults[I].Outcome of
      toPassed: ;
      toFailed: Inc(AllFailures);
      toError: Inc(AllErrors);
    end;
  Lines := TStringList.Create;
  try
    Lines.Add('<?xml version="1.0" encoding="UTF-8"?>');
    Lines.Add(Format('<testsuites name="LibPhoneNumberTests" tests="%d" failures="%d" errors="%d" time="%s">',
      [Length(AResults), AllFailures, AllErrors, SecondsText(ATotalSeconds)]));
    I := 0;
    while I <= High(AResults) do
    begin
      Fixture := AResults[I].Fixture;
      CountFixture(I, Last);
      Lines.Add(Format('  <testsuite name="%s" tests="%d" failures="%d" errors="%d" skipped="0" time="%s">',
        [XmlEscape(Fixture), Tests, Failures, Errors, SecondsText(Seconds)]));
      Lines.Add(Format('    <properties><property name="compiler" value="%s"/></properties>',
        [XmlEscape(CompilerDescription)]));
      for J := I to Last do
      begin
        Lines.Add(Format('    <testcase classname="%s" name="%s" time="%s">',
          [XmlEscape(Fixture), XmlEscape(AResults[J].Name), SecondsText(AResults[J].Seconds)]));
        case AResults[J].Outcome of
          toPassed: ;
          toFailed:
            Lines.Add(Format('      <failure message="%s" type="ETestFailure">%s</failure>',
              [XmlEscape(AResults[J].Message), XmlEscape(AResults[J].Message)]));
          toError:
            Lines.Add(Format('      <error message="%s" type="Exception">%s</error>',
              [XmlEscape(AResults[J].Message), XmlEscape(AResults[J].Message)]));
        end;
        if AResults[J].Log <> '' then
          Lines.Add('      <system-out>' + XmlEscape(AResults[J].Log) + '</system-out>');
        Lines.Add('    </testcase>');
      end;
      Lines.Add('  </testsuite>');
      I := Last + 1;
    end;
    Lines.Add('</testsuites>');
{$IFDEF FPC}
    { `string` is UTF-8 here (see the runner program). }
    Raw := Lines.Text;
    SetLength(Bytes, Length(Raw));
    if Length(Raw) > 0 then
      Move(Raw[1], Bytes[0], Length(Raw));
{$ELSE}
    Bytes := TEncoding.UTF8.GetBytes(Lines.Text);
{$ENDIF}
    Stream := TFileStream.Create(AFileName, fmCreate);
    try
      if Length(Bytes) > 0 then
        Stream.WriteBuffer(Bytes[0], Length(Bytes));
    finally
      Stream.Free;
    end;
  finally
    Lines.Free;
  end;
end;

{ ---------------------------------------------------------------------------
  Running
  --------------------------------------------------------------------------- }

function ExceptionText(E: Exception): string;
begin
  if E is ETestFailure then
    Result := E.Message
  else
    Result := E.ClassName + ': ' + E.Message;
end;

procedure RunOneTest(AInstance: TTestCase; const AEntry: TTestEntry;
  var AResult: TTestResult);
var
  Method: TMethod;
  Started: Int64;
  Log: TStringList;
  SetupDone: Boolean;

  procedure Record_(E: Exception);
  begin
    { The first problem of a test is the one that counts. }
    if AResult.Outcome <> toPassed then
      Exit;
    if E is ETestFailure then
      AResult.Outcome := toFailed
    else
      AResult.Outcome := toError;
    AResult.Message := ExceptionText(E);
  end;

begin
  AResult.Outcome := toPassed;
  AResult.Message := '';
  AResult.Log := '';
  ClearTestLog;
  Started := TickMilliseconds;
  SetupDone := False;
  try
    AInstance.Setup;
    SetupDone := True;
    Method.Code := AEntry.Code;
    Method.Data := AInstance;
    TTestMethod(Method)();
  except
    on E: Exception do
    begin
      Record_(E);
      if not SetupDone then
        AResult.Message := 'Setup: ' + AResult.Message;
    end;
  end;
  if SetupDone then
    try
      AInstance.TearDown;
    except
      on E: Exception do
      begin
        if AResult.Outcome = toPassed then
        begin
          AResult.Outcome := toError;
          AResult.Message := 'TearDown: ' + ExceptionText(E);
        end;
      end;
    end;
  AResult.Seconds := (TickMilliseconds - Started) / 1000;
  Log := TakeTestLog;
  if Log <> nil then
    try
      AResult.Log := TrimRight(Log.Text);
    finally
      Log.Free;
    end;
end;

function RunTestsFromCommandLine: Integer;
var
  Options: TRunOptions;
  Error: string;
  Results: array of TTestResult;
  FixtureIndex, I, Count, Failed, Errors, FixtureFailed: Integer;
  Fixture: TTestCaseClass;
  Instance: TTestCase;
  Tests: TTestEntryArray;
  Selected: array of Boolean;
  Started, FixtureStarted: Int64;
  TotalSeconds: Double;
  Item: TTestResult;
  CreateError: string;
begin
  if not ParseOptions(Options, Error) then
  begin
    if Error <> '' then
      WriteLn(Error);
    PrintUsage;
    if Error = '' then
      Exit(0);
    Exit(2);
  end;

  if not Options.ListOnly then
    WriteLn('LibPhoneNumber test suite - ', CompilerDescription);
  Results := nil;
  Failed := 0;
  Errors := 0;
  Started := TickMilliseconds;
  for FixtureIndex := 0 to RegisteredFixtureCount - 1 do
  begin
    Fixture := RegisteredFixture(FixtureIndex);
    Tests := EnumerateTests(Fixture);
    SetLength(Selected, Length(Tests));
    Count := 0;
    for I := 0 to High(Tests) do
    begin
      Selected[I] := IsSelected(Options, Fixture.ClassName, Tests[I].Name);
      if Selected[I] then
        Inc(Count);
    end;
    if Count = 0 then
      Continue;

    if Options.ListOnly then
    begin
      for I := 0 to High(Tests) do
        if Selected[I] then
          WriteLn(Fixture.ClassName, '.', Tests[I].Name);
      Continue;
    end;

    FixtureStarted := TickMilliseconds;
    FixtureFailed := 0;
    CreateError := '';
    Instance := nil;
    try
      Instance := Fixture.Create;
    except
      on E: Exception do
        CreateError := 'Creating the fixture: ' + ExceptionText(E);
    end;
    try
      for I := 0 to High(Tests) do
      begin
        if not Selected[I] then
          Continue;
        Item.Fixture := Fixture.ClassName;
        Item.Name := Tests[I].Name;
        if Instance = nil then
        begin
          Item.Outcome := toError;
          Item.Message := CreateError;
          Item.Seconds := 0;
          Item.Log := '';
        end
        else
          RunOneTest(Instance, Tests[I], Item);
        SetLength(Results, Length(Results) + 1);
        Results[High(Results)] := Item;
        case Item.Outcome of
          toPassed:
            if Options.Verbose then
              WriteLn('  ok    ', Item.Fixture, '.', Item.Name);
          toFailed:
            begin
              Inc(Failed);
              Inc(FixtureFailed);
              WriteLn('FAIL  ', Item.Fixture, '.', Item.Name);
              WriteLn(Indent(Item.Message));
            end;
          toError:
            begin
              Inc(Errors);
              Inc(FixtureFailed);
              WriteLn('ERROR ', Item.Fixture, '.', Item.Name);
              WriteLn(Indent(Item.Message));
            end;
        end;
        if (Item.Log <> '') and (Options.Verbose or (Item.Outcome <> toPassed)) then
          WriteLn(Indent(Item.Log));
      end;
    finally
      Instance.Free;
    end;
    WriteLn(Format('  %-40s %4d tests %4d not passed %8s s',
      [Fixture.ClassName, Count, FixtureFailed,
       SecondsText((TickMilliseconds - FixtureStarted) / 1000)]));
  end;
  TotalSeconds := (TickMilliseconds - Started) / 1000;

  Result := 0;
  for I := 0 to High(Options.Filters) do
    if Options.FilterHits[I] = 0 then
    begin
      WriteLn('Filter matched no test: ', Options.Filters[I]);
      Result := 2;
    end;
  if Options.ListOnly then
    Exit;

  if Options.JUnitFile <> '' then
    WriteJUnit(Options.JUnitFile, Results, TotalSeconds);

  WriteLn(Format('Tests: %d  passed: %d  failed: %d  errors: %d  time: %s s',
    [Length(Results), Length(Results) - Failed - Errors, Failed, Errors,
     SecondsText(TotalSeconds)]));
  if Result <> 0 then
    Exit;
  if Length(Results) = 0 then
  begin
    WriteLn('No test was run.');
    Exit(2);
  end;
  if (Failed > 0) or (Errors > 0) then
    Result := 1;
end;

end.
