program PhoneNumbersDifferential;

{
  Mass differential probe, Pascal side.

  Walks EVERY description of EVERY territory of the generated metadata that
  carries an example number - 1143 of the 3048 descriptions - and records what
  the port answers for each of them:

    Parse -> E164, INTERNATIONAL, NATIONAL, RFC3966,
    IsPossibleNumber, IsValidNumber, GetNumberType, GetRegionCodeForNumber.

  The result is written as JSON to the path given as the first argument
  (default: differential_port.json next to the executable).
  tools/run_mass_differential.ps1 then asks the C# NuGet oracle the same
  questions about the same inputs and diffs the two answer sets.

  A separate console program rather than a test fixture on purpose: this is
  not a test - it has no expected values of its own - and a fixture that
  writes a data file and always passes would be a test in name only. The
  program links the very same units under src/ that the library ships, so the
  answers are the shipped ones.

  Deliberately NOT linked: LibPhoneNumber.TestingMetadata. The differential
  runs against the PRODUCTION metadata, which is the only data set the C#
  oracle has.
}

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
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

const
  { The desc kinds in table order; the label is the upstream PhoneNumberType
    name where one exists, so the JSON reads like the oracle's. }
  DescKindNames: array[TPhoneNumberDescKind] of string = (
    'generalDesc',
    'FIXED_LINE',
    'MOBILE',
    'TOLL_FREE',
    'PREMIUM_RATE',
    'SHARED_COST',
    'PERSONAL_NUMBER',
    'VOIP',
    'PAGER',
    'UAN',
    'VOICEMAIL',
    'noInternationalDialling'
  );

  { TMetadataNumberType in upstream declaration order; identical to the C#
    PhoneNumberType enum, which is what makes the answers comparable. }
  NumberTypeNames: array[TMetadataNumberType] of string = (
    'FIXED_LINE',
    'MOBILE',
    'FIXED_LINE_OR_MOBILE',
    'TOLL_FREE',
    'PREMIUM_RATE',
    'SHARED_COST',
    'VOIP',
    'PERSONAL_NUMBER',
    'PAGER',
    'UAN',
    'VOICEMAIL',
    'UNKNOWN'
  );

  ParseErrorNames: array[TPhoneNumberParseError] of string = (
    'NONE',
    'NOT_A_NUMBER',
    'INVALID_COUNTRY_CODE',
    'TOO_SHORT_AFTER_IDD',
    'TOO_SHORT_NSN',
    'TOO_LONG_NSN'
  );

function JsonEscape(const AValue: string): string;
var
  I: Integer;
  Ch: Char;
begin
  Result := '';
  for I := 1 to Length(AValue) do
  begin
    Ch := AValue[I];
    case Ch of
      '"': Result := Result + '\"';
      '\': Result := Result + '\\';
      #8: Result := Result + '\b';
      #9: Result := Result + '\t';
      #10: Result := Result + '\n';
      #12: Result := Result + '\f';
      #13: Result := Result + '\r';
    else
      if (Ch < #32) or (Ch > #126) then
        { Non-ASCII is escaped so the file is pure ASCII regardless of how the
          consumer opens it. }
        Result := Result + '\u' + LowerCase(IntToHex(Ord(Ch), 4))
      else
        Result := Result + Ch;
    end;
  end;
end;

function JsonString(const AName, AValue: string): string;
begin
  Result := '"' + AName + '": "' + JsonEscape(AValue) + '"';
end;

function JsonBool(const AName: string; AValue: Boolean): string;
begin
  if AValue then
    Result := '"' + AName + '": true'
  else
    Result := '"' + AName + '": false';
end;

function JsonInt(const AName: string; AValue: Integer): string;
begin
  Result := '"' + AName + '": ' + IntToStr(AValue);
end;

var
  Output: TStringList;
  OutputPath: string;
  TerritoryIndex, KindIndex, CaseCount: Integer;
  Territory: PPhoneMetadataRec;
  Desc: PPhoneNumberDescRec;
  Kind: TPhoneNumberDescKind;
  Example, ParseRegion, ParseInput, Nsn: string;
  Parsed: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
  ParseOk: Boolean;
  Line: string;

begin
  try
    if ParamCount >= 1 then
      OutputPath := ParamStr(1)
    else
      OutputPath := ExtractFilePath(ParamStr(0)) + 'differential_port.json';

    Output := TStringList.Create;
    try
      Output.Add('{');
      Output.Add('  ' + JsonString('generator', 'tools/differential/PhoneNumbersDifferential.dpr') + ',');
      Output.Add('  ' + JsonString('metadataVersion', MetadataVersion) + ',');
      Output.Add('  ' + JsonString('metadataSourceFile', MetadataSourceName) + ',');
      Output.Add('  ' + JsonString('metadataSourceCommit', MetadataUpstreamCommit) + ',');
      Output.Add('  "cases": [');

      CaseCount := 0;
      for TerritoryIndex := 0 to GetTerritoryCount - 1 do
      begin
        Territory := GetTerritory(TerritoryIndex);
        if Territory = nil then
          Continue;

        for KindIndex := 0 to PhoneNumberDescKindCount - 1 do
        begin
          Kind := TPhoneNumberDescKind(KindIndex);
          Desc := GetDesc(Territory, Kind);
          if (Desc = nil) or (Desc^.ExampleNumber = '') then
            Continue;

          Example := Desc^.ExampleNumber;

          { The non geographical entities have no region to parse in, exactly
            like upstream getExampleNumberForNonGeoEntity; their example is
            dialled internationally. Everything else is parsed as the national
            number of its own region. }
          if Territory^.Id = NonGeoRegionCode then
          begin
            ParseRegion := '';
            ParseInput := '+' + IntToStr(Territory^.CountryCode) + Example;
          end
          else
          begin
            ParseRegion := Territory^.Id;
            ParseInput := Example;
          end;

          ParseOk := TPhoneNumberUtil.Parse(ParseInput, ParseRegion, Parsed,
            ParseError);

          if CaseCount > 0 then
            Output[Output.Count - 1] := Output[Output.Count - 1] + ',';

          Line := '    {'
            + JsonString('region', Territory^.Id) + ', '
            + JsonInt('countryCode', Territory^.CountryCode) + ', '
            + JsonString('descKind', DescKindNames[Kind]) + ', '
            + JsonString('example', Example) + ', '
            + JsonString('parseInput', ParseInput) + ', '
            + JsonString('parseRegion', ParseRegion) + ', '
            + JsonBool('parseOk', ParseOk) + ', '
            + JsonString('parseError', ParseErrorNames[ParseError]);

          if ParseOk then
          begin
            { The parse driver always fills NationalNumberDigits, so the
              string form is authoritative here (the numeric field would drop a
              significant leading zero). }
            Nsn := Parsed.NationalNumberDigits;
            if Nsn = '' then
              Nsn := UIntToStr(Parsed.NationalNumber);
            Line := Line + ', '
              + JsonString('e164', TPhoneNumberUtil.Format(Parsed, pnfE164)) + ', '
              + JsonString('international', TPhoneNumberUtil.Format(Parsed, pnfInternational)) + ', '
              + JsonString('national', TPhoneNumberUtil.Format(Parsed, pnfNational)) + ', '
              + JsonString('rfc3966', TPhoneNumberUtil.Format(Parsed, pnfRfc3966)) + ', '
              + JsonBool('isPossible', IsPossibleNumber(Parsed.CountryCode, Nsn)) + ', '
              + JsonBool('isValid', IsValidNumber(Parsed.CountryCode, Nsn)) + ', '
              + JsonString('numberType',
                  NumberTypeNames[GetNumberType(Parsed.CountryCode, Nsn)]) + ', '
              + JsonString('regionCode',
                  GetRegionCodeForNumber(Parsed.CountryCode, Nsn));
          end;

          Line := Line + '}';
          Output.Add(Line);
          Inc(CaseCount);
        end;
      end;

      Output.Add('  ],');
      Output.Add('  ' + JsonInt('caseCount', CaseCount));
      Output.Add('}');

      Output.WriteBOM := False;
      Output.SaveToFile(OutputPath, TEncoding.UTF8);
      WriteLn(Format('Pascal differential probe: %d cases -> %s',
        [CaseCount, OutputPath]));
    finally
      Output.Free;
    end;
  except
    on E: Exception do
    begin
      WriteLn(ErrOutput, E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
