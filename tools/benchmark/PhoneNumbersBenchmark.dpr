program PhoneNumbersBenchmark;

{
  Performance benchmark of the library.

  Data set: the 1143 example numbers of the generated production metadata, i.e.
  every description of every territory that carries one - the same corpus the
  mass differential runs on, so the numbers below describe real, valid input
  spread over all 254 territories rather than one hot region.

  Measured, each over the whole corpus and N repetitions:

    parse            TPhoneNumberUtil.Parse
    isValid          IsValidNumber on the parsed result
    formatIntl       Format(pnfInternational) on the parsed result
    combined         all three back to back, which is the realistic call
                     sequence and therefore the headline figure

  The three individual phases parse into a pre-built array first so that
  isValid and formatIntl measure only themselves.

  This is DOCUMENTATION, not a gate: no threshold is asserted anywhere. Output
  goes to stdout as text and, with a path argument, additionally as JSON.
}

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  System.Diagnostics,
  LibPhoneNumber.Types in '..\..\src\LibPhoneNumber.Types.pas',
  LibPhoneNumber.Metadata.Types in '..\..\src\LibPhoneNumber.Metadata.Types.pas',
  LibPhoneNumber.Metadata.Data in '..\..\src\LibPhoneNumber.Metadata.Data.pas',
  LibPhoneNumber.Metadata.Descs in '..\..\src\LibPhoneNumber.Metadata.Descs.pas',
  LibPhoneNumber.Metadata.Formats in '..\..\src\LibPhoneNumber.Metadata.Formats.pas',
  LibPhoneNumber.Metadata in '..\..\src\LibPhoneNumber.Metadata.pas',
  LibPhoneNumber.Regex in '..\..\src\LibPhoneNumber.Regex.pas',
  LibPhoneNumber.MetadataCore in '..\..\src\LibPhoneNumber.MetadataCore.pas',
  LibPhoneNumber.MetadataFormat in '..\..\src\LibPhoneNumber.MetadataFormat.pas',
  LibPhoneNumber.PhoneNumberUtil in '..\..\src\LibPhoneNumber.PhoneNumberUtil.pas';

type
  TBenchCase = record
    Input: string;
    Region: string;
  end;

var
  Cases: array of TBenchCase;
  Parsed: array of TPhoneNumber;
  Repetitions: Integer;
  JsonPath: string;

procedure CollectCases;
var
  TerritoryIndex, KindIndex, Count: Integer;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
begin
  Count := 0;
  SetLength(Cases, GetTerritoryCount * PhoneNumberDescKindCount);
  for TerritoryIndex := 0 to GetTerritoryCount - 1 do
  begin
    Territory := GetTerritory(TerritoryIndex);
    if Territory = nil then
      Continue;
    for KindIndex := 0 to PhoneNumberDescKindCount - 1 do
    begin
      Desc := GetDesc(Territory, TPhoneNumberDescKind(KindIndex));
      if (Desc = nil) or (Desc^.ExampleNumber = '') then
        Continue;

      if Territory^.Id = NonGeoRegionCode then
      begin
        Cases[Count].Region := '';
        Cases[Count].Input := '+' + IntToStr(Territory^.CountryCode)
          + Desc^.ExampleNumber;
      end
      else
      begin
        Cases[Count].Region := Territory^.Id;
        Cases[Count].Input := Desc^.ExampleNumber;
      end;
      Inc(Count);
    end;
  end;
  SetLength(Cases, Count);
end;

procedure PrewarmAndParse;
var
  I: Integer;
  Error: TPhoneNumberParseError;
begin
  SetLength(Parsed, Length(Cases));
  for I := 0 to High(Cases) do
    if not TPhoneNumberUtil.Parse(Cases[I].Input, Cases[I].Region,
      Parsed[I], Error) then
      raise Exception.CreateFmt('Example number %s (%s) does not parse.',
        [Cases[I].Input, Cases[I].Region]);
end;

function NationalDigits(const ANumber: TPhoneNumber): string;
begin
  Result := ANumber.NationalNumberDigits;
  if Result = '' then
    Result := UIntToStr(ANumber.NationalNumber);
end;

function MeasureParse: Double;
var
  Watch: TStopwatch;
  R, I: Integer;
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
  Sink: Integer;
begin
  Sink := 0;
  Watch := TStopwatch.StartNew;
  for R := 1 to Repetitions do
    for I := 0 to High(Cases) do
      if TPhoneNumberUtil.Parse(Cases[I].Input, Cases[I].Region, Number,
        Error) then
        Inc(Sink, Number.CountryCode);
  Watch.Stop;
  if Sink = 0 then
    WriteLn('unreachable');
  Result := Watch.Elapsed.TotalSeconds;
end;

function MeasureIsValid: Double;
var
  Watch: TStopwatch;
  R, I, Sink: Integer;
begin
  Sink := 0;
  Watch := TStopwatch.StartNew;
  for R := 1 to Repetitions do
    for I := 0 to High(Parsed) do
      if IsValidNumber(Parsed[I].CountryCode, NationalDigits(Parsed[I])) then
        Inc(Sink);
  Watch.Stop;
  if Sink = 0 then
    WriteLn('unreachable');
  Result := Watch.Elapsed.TotalSeconds;
end;

function MeasureFormat: Double;
var
  Watch: TStopwatch;
  R, I, Sink: Integer;
begin
  Sink := 0;
  Watch := TStopwatch.StartNew;
  for R := 1 to Repetitions do
    for I := 0 to High(Parsed) do
      Inc(Sink, Length(TPhoneNumberUtil.Format(Parsed[I], pnfInternational)));
  Watch.Stop;
  if Sink = 0 then
    WriteLn('unreachable');
  Result := Watch.Elapsed.TotalSeconds;
end;

function MeasureCombined: Double;
var
  Watch: TStopwatch;
  R, I, Sink: Integer;
  Number: TPhoneNumber;
  Error: TPhoneNumberParseError;
begin
  Sink := 0;
  Watch := TStopwatch.StartNew;
  for R := 1 to Repetitions do
    for I := 0 to High(Cases) do
      if TPhoneNumberUtil.Parse(Cases[I].Input, Cases[I].Region, Number,
        Error) then
      begin
        if IsValidNumber(Number.CountryCode, NationalDigits(Number)) then
          Inc(Sink);
        Inc(Sink, Length(TPhoneNumberUtil.Format(Number, pnfInternational)));
      end;
  Watch.Stop;
  if Sink = 0 then
    WriteLn('unreachable');
  Result := Watch.Elapsed.TotalSeconds;
end;

{ Fixed four decimals with an ASCII dot, independent of the machine locale, so
  the JSON stays parseable everywhere. }
function InvariantFloat(AValue: Double): string;
var
  Settings: TFormatSettings;
begin
  Settings := TFormatSettings.Invariant;
  Result := FormatFloat('0.0000', AValue, Settings);
end;

procedure Report(const AName: string; ASeconds: Double; AOperations: Int64);
begin
  WriteLn(Format('  %-12s %8.3f s   %12.0f ops/s   %8.2f us/op',
    [AName, ASeconds, AOperations / ASeconds, ASeconds * 1000000 / AOperations]));
end;

var
  ParseSeconds, ValidSeconds, FormatSeconds, CombinedSeconds: Double;
  Operations: Int64;
  Json: TStringList;

begin
  try
    Repetitions := 10;
    if ParamCount >= 1 then
      Repetitions := StrToInt(ParamStr(1));
    JsonPath := '';
    if ParamCount >= 2 then
      JsonPath := ParamStr(2);

    CollectCases;
    PrewarmAndParse;

    { The regex layer caches compiled patterns, so a cold first pass would
      measure compilation rather than matching. One untimed warm up pass over
      the whole corpus puts every pattern the corpus touches in the cache -
      which is the steady state a long running process is in. }
    MeasureCombined;

    Operations := Int64(Length(Cases)) * Repetitions;

    ParseSeconds := MeasureParse;
    ValidSeconds := MeasureIsValid;
    FormatSeconds := MeasureFormat;
    CombinedSeconds := MeasureCombined;

    WriteLn('libphonenumber-pascal benchmark');
    WriteLn(Format('  metadata     : %s (%s)',
      [MetadataVersion, MetadataUpstreamCommit]));
    WriteLn(Format('  corpus       : %d example numbers over %d territories',
      [Length(Cases), GetTerritoryCount]));
    WriteLn(Format('  repetitions  : %d (%d operations per phase)',
      [Repetitions, Operations]));
    WriteLn(Format('  pattern cache: %d compiled patterns after the run',
      [CachedPatternCount]));
    WriteLn('');
    Report('parse', ParseSeconds, Operations);
    Report('isValid', ValidSeconds, Operations);
    Report('formatIntl', FormatSeconds, Operations);
    Report('combined', CombinedSeconds, Operations);

    if JsonPath <> '' then
    begin
      Json := TStringList.Create;
      try
        Json.Add('{');
        Json.Add(Format('  "metadataVersion": "%s",', [MetadataVersion]));
        Json.Add(Format('  "metadataSourceCommit": "%s",', [MetadataUpstreamCommit]));
        Json.Add(Format('  "corpusSize": %d,', [Length(Cases)]));
        Json.Add(Format('  "repetitions": %d,', [Repetitions]));
        Json.Add(Format('  "operationsPerPhase": %d,', [Operations]));
        Json.Add(Format('  "cachedPatterns": %d,', [CachedPatternCount]));
        Json.Add('  "parseSeconds": ' + InvariantFloat(ParseSeconds) + ',');
        Json.Add('  "isValidSeconds": ' + InvariantFloat(ValidSeconds) + ',');
        Json.Add('  "formatIntlSeconds": ' + InvariantFloat(FormatSeconds) + ',');
        Json.Add('  "combinedSeconds": ' + InvariantFloat(CombinedSeconds));
        Json.Add('}');
        Json.WriteBOM := False;
        Json.SaveToFile(JsonPath, TEncoding.UTF8);
        WriteLn('');
        WriteLn('JSON written to ' + JsonPath);
      finally
        Json.Free;
      end;
    end;
  except
    on E: Exception do
    begin
      WriteLn(ErrOutput, E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
