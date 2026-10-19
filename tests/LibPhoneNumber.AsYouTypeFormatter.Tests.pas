unit LibPhoneNumber.AsYouTypeFormatter.Tests;

{
  Gate for the AsYouTypeFormatter plus
  formatNumberForMobileDialing and formatOutOfCountryKeepingAlphaChars.

  Where the expectations come from
  --------------------------------
  NOT from AsYouTypeFormatterTest.java or PhoneNumberUtilTest.java. Those
  suites run against PhoneNumberMetadataForTesting.xml, which differs from the
  shipped PhoneNumberMetadata.xml for several territories (see AGENTS.md,
  "Test Expectations"). Only the test IDEAS are taken from upstream; the value
  of every single assertion in the data driven tests below is computed by the
  C# NuGet oracle (libphonenumber-csharp 9.0.41) against the SHIPPED metadata
  and stored in tests/data/aytf_reference_cases.json.

  Regenerate that file with:
    pwsh -NoProfile -ExecutionPolicy Bypass -File tools/generate_aytf_cases.ps1

  The difference is not academic. The upstream US sequence asserts
  "+1 650 253 2222", while the shipped metadata formats the very same input as
  "+1 650-253-2222"; copying the Java expectation would have produced a test
  that is wrong about the library it tests.

  The hand written tests at the end cover the pieces that have no oracle
  counterpart: the ported character scanners, and the one deliberate deviation
  of this port (ASCII digits only).
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{ The test sources are pure ASCII and spell every non ASCII character as a
  numeric constant (#$XXXX). Without a source code page FreePascal converts
  such a constant to an AnsiString `string` at COMPILE time through its
  default code page and turns every character outside it into '?'. UTF-8
  as the source code page makes that conversion lossless and matches the
  UTF-8 string contract of the library on FreePascal. }
{$CODEPAGE UTF8}
{ Implicit UnicodeString <-> AnsiString conversions are the documented
  string contract here: the runner sets the UTF-8 conversion code page, so
  they are lossless, and the warning would bury every other one. }
{$WARN 4105 OFF}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  Classes,
{$ELSE}
  System.Classes,
{$ENDIF}
  LibPhoneNumber.TestFramework;

type
  TAsYouTypeFormatterTests = class(TTestCase)
  private
    function FindReferenceFile: string;
    function LoadDocument: TObject;
    procedure Report(const AMessage: string);
    procedure ReportList(const ACaption: string; AItems: TStringList);
  published
    { Oracle anchored: AsYouTypeFormatter }
    procedure AytfSequences_MatchTheOracleCharacterByCharacter;

    procedure AytfRememberedPosition_MatchesTheOracle;

    procedure AytfClearAndReuse_MatchesTheOracle;

    procedure AytfSmoke_ExampleNumbersOfManyRegions_MatchTheOracle;

    { Oracle anchored: the two remaining PhoneNumberUtil format entry points }
    procedure FormatNumberForMobileDialing_MatchesTheOracle;

    procedure FormatOutOfCountryKeepingAlphaChars_MatchesTheOracle;

    { Ported scanners and helpers }
    procedure IsFormatEligible_AcceptsTheUpstreamGrammarOnly;

    procedure IsFormatEligible_RejectsEveryBaselineFormatItShould;

    procedure NationalPrefixHasSeparator_FindsDashAndSpace;

    procedure FormattingRuleHasFirstGroupOnly_MatchesTheUpstreamPattern;

    procedure MapAlphaCharacterToDigit_IsTheDialPadTable;

    procedure ConvertAlphaCharactersInNumber_KeepsEverythingElse;

    procedure NormalizeAlphaPhoneOrDigits_NeedsThreeLettersToConvert;

    procedure NormalizeAllPlusNumberGroupingSymbols_KeepsGroupingOnly;

    procedure TryFindFirst_ReturnsTheLeftmostUnanchoredMatch;

    procedure IsViablePhoneNumber_GuardsTheExtensionStrip;

    procedure KeepingAlphaChars_DoesNotStripAnExtensionFromAnUnviablePrefix;

    procedure CanBeInternationallyDialled_FollowsNoInternationalDialling;

    { Behaviour of the class itself }
    procedure Clear_ResetsTheFormatterForReuse;

    procedure NonAsciiDigits_AreNormalisedLikeUpstream;

    procedure UnknownRegion_StillFormatsNumbersEnteredWithPlus;

    procedure ConstructorRegion_IsCanonicalised;
  end;

implementation

uses
{$IFDEF FPC}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  LibPhoneNumber.TestJson,
  LibPhoneNumber.Types,
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.Metadata,
  LibPhoneNumber.MetadataCore,
  LibPhoneNumber.MetadataFormat,
  LibPhoneNumber.Regex,
  LibPhoneNumber.AsYouTypeFormatter,
  LibPhoneNumber.PhoneNumberUtil;

const
  ReferenceFileName = 'aytf_reference_cases.json';
  MaxReportedItems = 20;

procedure TAsYouTypeFormatterTests.Report(const AMessage: string);
begin
  LogMessage(AMessage);
end;

procedure TAsYouTypeFormatterTests.ReportList(const ACaption: string;
  AItems: TStringList);
var
  I, Limit: Integer;
begin
  Report(Format('  %s: %d', [ACaption, AItems.Count]));
  Limit := AItems.Count;
  if Limit > MaxReportedItems then
    Limit := MaxReportedItems;
  for I := 0 to Limit - 1 do
    Report('    ' + AItems[I]);
  if AItems.Count > Limit then
    Report(Format('    ... %d more', [AItems.Count - Limit]));
end;

function TAsYouTypeFormatterTests.FindReferenceFile: string;
begin
  { tests/data is searched upwards from the executable and from the
    current directory (LibPhoneNumber.TestJson.FindTestDataFile). }
  Result := FindTestDataFile(ReferenceFileName);
  if Result <> '' then
    Exit;

  Assert.Fail('Reference case file not found: tests/data/' + ReferenceFileName);
  Result := '';
end;

function TAsYouTypeFormatterTests.LoadDocument: TObject;
var
  RawJson: string;
  Value: TJSONValue;
begin
  RawJson := ReadUtf8File(FindReferenceFile);
  Value := TJSONObject.ParseJSONValue(RawJson);
  Assert.IsTrue(Value is TJSONObject,
    'Root JSON value of ' + ReferenceFileName + ' must be an object.');
  Result := Value;
end;

{ Feeds AInput into a fresh formatter and collects the output after every
  character. }
procedure RunSequence(const ARegion, AInput: string; AOutputs: TStringList);
var
  Formatter: TAsYouTypeFormatter;
  I: Integer;
  Wide: UnicodeString;
begin
  AOutputs.Clear;
  Wide := UnicodeString(AInput);
  Formatter := TAsYouTypeFormatter.Create(ARegion);
  try
    for I := 1 to Length(Wide) do
      AOutputs.Add(Formatter.InputDigit(Wide[I]));
  finally
    Formatter.Free;
  end;
end;

function JsonStringArray(AObject: TJSONObject; const AName: string): TJSONArray;
var
  Value: TJSONValue;
begin
  Value := AObject.GetValue(AName);
  Assert.IsTrue(Value is TJSONArray,
    Format('Expected a JSON array for "%s".', [AName]));
  Result := Value as TJSONArray;
end;

{ --------------------------------------------------------------------------
  Oracle anchored: AsYouTypeFormatter
  -------------------------------------------------------------------------- }

procedure TAsYouTypeFormatterTests
  .AytfSequences_MatchTheOracleCharacterByCharacter;
var
  Doc: TJSONObject;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  Expected: TJSONArray;
  Outputs: TStringList;
  Failures: TStringList;
  I, J, Checked: Integer;
  Name, Region, Input: string;
begin
  Outputs := TStringList.Create;
  Failures := TStringList.Create;
  try
    Doc := LoadDocument as TJSONObject;
    try
      Cases := JsonStringArray(Doc, 'aytfSequences');
      Assert.IsTrue(Cases.Count >= 20,
        'Expected the full generated AYTF sequence table.');

      Checked := 0;
      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        Name := CaseObj.GetString('name');
        Region := CaseObj.GetString('region');
        Input := CaseObj.GetString('input');
        Expected := JsonStringArray(CaseObj, 'outputs');

        RunSequence(Region, Input, Outputs);
        Assert.AreEqual(Expected.Count, Outputs.Count,
          Format('%s: the oracle recorded %d outputs but %d characters were fed.',
            [Name, Expected.Count, Outputs.Count]));

        for J := 0 to Expected.Count - 1 do
        begin
          Inc(Checked);
          if Outputs[J] <> Expected.Items[J].Value then
            Failures.Add(Format('%s [%s] after char %d: expected "%s", got "%s"',
              [Name, Region, J + 1, Expected.Items[J].Value, Outputs[J]]));
        end;
      end;
    finally
      Doc.Free;
    end;

    Report(Format('AYTF sequence steps checked: %d', [Checked]));
    if Failures.Count > 0 then
    begin
      ReportList('Divergences', Failures);
      Assert.Fail(Format('%d AYTF step(s) differ from the oracle; first: %s',
        [Failures.Count, Failures[0]]));
    end;
  finally
    Failures.Free;
    Outputs.Free;
  end;
end;

procedure TAsYouTypeFormatterTests.AytfRememberedPosition_MatchesTheOracle;
var
  Doc: TJSONObject;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  ExpectedOutputs, ExpectedPositions, RememberIndices: TJSONArray;
  Failures: TStringList;
  Formatter: TAsYouTypeFormatter;
  I, J, K, Checked, Position: Integer;
  Name, Region, Input, Output: string;
  Wide: UnicodeString;
  Remember: Boolean;
begin
  Failures := TStringList.Create;
  try
    Doc := LoadDocument as TJSONObject;
    try
      Cases := JsonStringArray(Doc, 'aytfRemember');
      Assert.IsTrue(Cases.Count >= 4,
        'Expected the full generated remembered position table.');

      Checked := 0;
      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        Name := CaseObj.GetString('name');
        Region := CaseObj.GetString('region');
        Input := CaseObj.GetString('input');
        RememberIndices := JsonStringArray(CaseObj, 'rememberIndices');
        ExpectedOutputs := JsonStringArray(CaseObj, 'outputs');
        ExpectedPositions := JsonStringArray(CaseObj, 'positions');

        Wide := UnicodeString(Input);
        Formatter := TAsYouTypeFormatter.Create(Region);
        try
          for J := 0 to Length(Wide) - 1 do
          begin
            Remember := False;
            for K := 0 to RememberIndices.Count - 1 do
              if StrToIntDef(RememberIndices.Items[K].Value, -1) = J then
                Remember := True;

            if Remember then
              Output := Formatter.InputDigitAndRememberPosition(Wide[J + 1])
            else
              Output := Formatter.InputDigit(Wide[J + 1]);
            Position := Formatter.GetRememberedPosition;

            Inc(Checked);
            if Output <> ExpectedOutputs.Items[J].Value then
              Failures.Add(Format('%s after char %d: expected "%s", got "%s"',
                [Name, J + 1, ExpectedOutputs.Items[J].Value, Output]));
            if Position <> StrToIntDef(ExpectedPositions.Items[J].Value, -1) then
              Failures.Add(Format('%s position after char %d: expected %s, got %d',
                [Name, J + 1, ExpectedPositions.Items[J].Value, Position]));
          end;
        finally
          Formatter.Free;
        end;
      end;
    finally
      Doc.Free;
    end;

    Report(Format('AYTF remembered position steps checked: %d', [Checked]));
    if Failures.Count > 0 then
    begin
      ReportList('Divergences', Failures);
      Assert.Fail(Format('%d remembered position step(s) differ; first: %s',
        [Failures.Count, Failures[0]]));
    end;
  finally
    Failures.Free;
  end;
end;

procedure TAsYouTypeFormatterTests.AytfClearAndReuse_MatchesTheOracle;
var
  Doc: TJSONObject;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  ExpectedFirst, ExpectedSecond: TJSONArray;
  Failures: TStringList;
  Formatter: TAsYouTypeFormatter;
  I, J, Checked: Integer;
  Name, Region, FirstInput, SecondInput, Output: string;
  Wide: UnicodeString;
begin
  Failures := TStringList.Create;
  try
    Doc := LoadDocument as TJSONObject;
    try
      Cases := JsonStringArray(Doc, 'aytfClear');
      Assert.IsTrue(Cases.Count >= 3, 'Expected the generated clear/reuse table.');

      Checked := 0;
      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        Name := CaseObj.GetString('name');
        Region := CaseObj.GetString('region');
        FirstInput := CaseObj.GetString('firstInput');
        SecondInput := CaseObj.GetString('secondInput');
        ExpectedFirst := JsonStringArray(CaseObj, 'firstOutputs');
        ExpectedSecond := JsonStringArray(CaseObj, 'secondOutputs');

        Formatter := TAsYouTypeFormatter.Create(Region);
        try
          Wide := UnicodeString(FirstInput);
          for J := 0 to Length(Wide) - 1 do
          begin
            Output := Formatter.InputDigit(Wide[J + 1]);
            Inc(Checked);
            if Output <> ExpectedFirst.Items[J].Value then
              Failures.Add(Format('%s first pass char %d: expected "%s", got "%s"',
                [Name, J + 1, ExpectedFirst.Items[J].Value, Output]));
          end;

          Formatter.Clear;

          Wide := UnicodeString(SecondInput);
          for J := 0 to Length(Wide) - 1 do
          begin
            Output := Formatter.InputDigit(Wide[J + 1]);
            Inc(Checked);
            if Output <> ExpectedSecond.Items[J].Value then
              Failures.Add(Format('%s second pass char %d: expected "%s", got "%s"',
                [Name, J + 1, ExpectedSecond.Items[J].Value, Output]));
          end;
        finally
          Formatter.Free;
        end;
      end;
    finally
      Doc.Free;
    end;

    Report(Format('AYTF clear/reuse steps checked: %d', [Checked]));
    if Failures.Count > 0 then
    begin
      ReportList('Divergences', Failures);
      Assert.Fail(Format('%d clear/reuse step(s) differ; first: %s',
        [Failures.Count, Failures[0]]));
    end;
  finally
    Failures.Free;
  end;
end;

procedure TAsYouTypeFormatterTests
  .AytfSmoke_ExampleNumbersOfManyRegions_MatchTheOracle;
var
  Doc: TJSONObject;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  Outputs, Failures: TStringList;
  I: Integer;
  Region, Input, Expected: string;
begin
  { Mass smoke: for each region the E164 spelling of its own example number is
    typed one character at a time and only the FINAL output is compared. The
    table is generated by tools/generate_aytf_cases.ps1 (section aytfSmoke). }
  Outputs := TStringList.Create;
  Failures := TStringList.Create;
  try
    Doc := LoadDocument as TJSONObject;
    try
      Cases := JsonStringArray(Doc, 'aytfSmoke');
      Assert.IsTrue(Cases.Count >= 20,
        'Expected at least twenty smoke regions.');

      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        Region := CaseObj.GetString('region');
        Input := CaseObj.GetString('input');
        Expected := CaseObj.GetString('expected');

        RunSequence(Region, Input, Outputs);
        Assert.IsTrue(Outputs.Count > 0, Region + ': no output at all.');
        if Outputs[Outputs.Count - 1] <> Expected then
          Failures.Add(Format('%s (%s): expected "%s", got "%s"',
            [Region, Input, Expected, Outputs[Outputs.Count - 1]]));
      end;

      Report(Format('AYTF smoke regions checked: %d', [Cases.Count]));
    finally
      Doc.Free;
    end;

    if Failures.Count > 0 then
    begin
      ReportList('Divergences', Failures);
      Assert.Fail(Format('%d smoke region(s) differ from the oracle; first: %s',
        [Failures.Count, Failures[0]]));
    end;
  finally
    Failures.Free;
    Outputs.Free;
  end;
end;

{ --------------------------------------------------------------------------
  Oracle anchored: formatNumberForMobileDialing /
  formatOutOfCountryKeepingAlphaChars
  -------------------------------------------------------------------------- }

procedure TAsYouTypeFormatterTests
  .FormatNumberForMobileDialing_MatchesTheOracle;
var
  Doc: TJSONObject;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  Failures: TStringList;
  I: Integer;
  Name, Input, Region, From, Expected, Actual: string;
  WithFormatting, KeepRaw, Parsed: Boolean;
  Number: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Failures := TStringList.Create;
  try
    Doc := LoadDocument as TJSONObject;
    try
      Cases := JsonStringArray(Doc, 'mobileDialing');
      Assert.IsTrue(Cases.Count >= 15,
        'Expected the generated mobile dialling table.');

      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        Name := CaseObj.GetString('name');
        Input := CaseObj.GetString('input');
        Region := CaseObj.GetString('region');
        From := CaseObj.GetString('regionCallingFrom');
        WithFormatting := CaseObj.GetBoolean('withFormatting');
        KeepRaw := CaseObj.GetBoolean('keepRawInput');
        Expected := CaseObj.GetString('expected');

        if KeepRaw then
          Parsed := TPhoneNumberUtil.ParseAndKeepRawInput(Input, Region,
            Number, ParseError)
        else
          Parsed := TPhoneNumberUtil.Parse(Input, Region, Number, ParseError);

        if not Parsed then
        begin
          Failures.Add(Format('%s: parse of "%s" (%s) failed with error %d',
            [Name, Input, Region, Ord(ParseError)]));
          Continue;
        end;

        Actual := TPhoneNumberUtil.FormatNumberForMobileDialing(Number, From,
          WithFormatting);
        if Actual <> Expected then
          Failures.Add(Format('%s: expected "%s", got "%s"',
            [Name, Expected, Actual]));
      end;

      Report(Format('Mobile dialling cases checked: %d', [Cases.Count]));
    finally
      Doc.Free;
    end;

    if Failures.Count > 0 then
    begin
      ReportList('Divergences', Failures);
      Assert.Fail(Format('%d mobile dialling case(s) differ; first: %s',
        [Failures.Count, Failures[0]]));
    end;
  finally
    Failures.Free;
  end;
end;

procedure TAsYouTypeFormatterTests
  .FormatOutOfCountryKeepingAlphaChars_MatchesTheOracle;
var
  Doc: TJSONObject;
  Cases: TJSONArray;
  CaseObj: TJSONObject;
  Failures: TStringList;
  I: Integer;
  Name, RawInput, Region, From, Expected, Actual: string;
  Number: TPhoneNumber;
  ParseError: TPhoneNumberParseError;
begin
  Failures := TStringList.Create;
  try
    Doc := LoadDocument as TJSONObject;
    try
      Cases := JsonStringArray(Doc, 'keepingAlphaChars');
      Assert.IsTrue(Cases.Count >= 12,
        'Expected the generated alpha character table.');

      for I := 0 to Cases.Count - 1 do
      begin
        CaseObj := Cases.Items[I] as TJSONObject;
        Name := CaseObj.GetString('name');
        RawInput := CaseObj.GetString('rawInput');
        Region := CaseObj.GetString('region');
        From := CaseObj.GetString('regionCallingFrom');
        Expected := CaseObj.GetString('expected');

        if not TPhoneNumberUtil.ParseAndKeepRawInput(RawInput, Region, Number,
          ParseError) then
        begin
          Failures.Add(Format('%s: parse of "%s" (%s) failed with error %d',
            [Name, RawInput, Region, Ord(ParseError)]));
          Continue;
        end;

        Actual := TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number,
          From);
        if Actual <> Expected then
          Failures.Add(Format('%s: expected "%s", got "%s"',
            [Name, Expected, Actual]));
      end;

      Report(Format('Alpha character cases checked: %d', [Cases.Count]));
    finally
      Doc.Free;
    end;

    if Failures.Count > 0 then
    begin
      ReportList('Divergences', Failures);
      Assert.Fail(Format('%d alpha character case(s) differ; first: %s',
        [Failures.Count, Failures[0]]));
    end;
  finally
    Failures.Free;
  end;
end;

{ --------------------------------------------------------------------------
  Ported scanners and helpers
  -------------------------------------------------------------------------- }

procedure TAsYouTypeFormatterTests
  .IsFormatEligible_AcceptsTheUpstreamGrammarOnly;
begin
  { ELIGIBLE_FORMAT_PATTERN, spelled out:
      [punctuation]* \$1 [punctuation]* (\$\d [punctuation]*)* }
  Assert.IsTrue(IsFormatEligible('$1'), 'A bare first group is eligible.');
  Assert.IsTrue(IsFormatEligible('$1 $2'), 'Space separated groups.');
  Assert.IsTrue(IsFormatEligible('($1) $2-$3'), 'Parentheses and dash.');
  Assert.IsTrue(IsFormatEligible('$1-$2-$3-$4'), 'Four groups.');
  Assert.IsTrue(IsFormatEligible('  $1  '), 'Leading and trailing punctuation.');

  Assert.IsFalse(IsFormatEligible(''), 'The empty format is not eligible.');
  Assert.IsFalse(IsFormatEligible('$2 $3'),
    'Upstream requires the FIRST group so no digits are lost.');
  Assert.IsFalse(IsFormatEligible('*$1'),
    'The star of the Israeli star numbers is not valid punctuation.');
  Assert.IsFalse(IsFormatEligible('$1#$2'), 'A hash is not valid punctuation.');
  Assert.IsFalse(IsFormatEligible('$1 $a'), 'A group reference needs a digit.');
  Assert.IsFalse(IsFormatEligible('$1 $'), 'A trailing dollar is incomplete.');
end;

procedure TAsYouTypeFormatterTests
  .IsFormatEligible_RejectsEveryBaselineFormatItShould;
var
  I, J, Territory, Total, Eligible: Integer;
  Metadata: PPhoneMetadataRec;
  NumFormat: PNumberFormatRec;
  Rejected: TStringList;
begin
  { Drift detector, pinned exactly like the baseline counts in the metadata
    tests: the scanner is run over EVERY number format of the pinned baseline
    and the inventory of rejected formats is an exact list, not a budget. A
    vendor bump that introduces a format the AYTF cannot use must show up here
    rather than silently shrink the formatter's coverage. }
  Rejected := TStringList.Create;
  try
    Total := 0;
    Eligible := 0;
    for Territory := 0 to GetTerritoryCount - 1 do
    begin
      Metadata := GetTerritory(Territory);
      for I := 0 to GetNumberFormatCount(Metadata) - 1 do
      begin
        NumFormat := GetNumberFormat(Metadata, I);
        Inc(Total);
        if IsFormatEligible(NumFormat^.Format) then
          Inc(Eligible)
        else if Rejected.IndexOf(NumFormat^.Format) < 0 then
          Rejected.Add(NumFormat^.Format);
      end;
      for J := 0 to GetIntlNumberFormatCount(Metadata) - 1 do
      begin
        NumFormat := GetIntlNumberFormat(Metadata, J);
        Inc(Total);
        if IsFormatEligible(NumFormat^.Format) then
          Inc(Eligible)
        else if Rejected.IndexOf(NumFormat^.Format) < 0 then
          Rejected.Add(NumFormat^.Format);
      end;
    end;

    Report(Format('Baseline formats: %d, eligible for the AYTF: %d',
      [Total, Eligible]));
    ReportList('Distinct rejected formats', Rejected);

    { Baseline 33be5664343676b27761213d8f5500d682568ea7: 761 national plus 205
      international formats. }
    Assert.AreEqual(966, Total,
      'The baseline format inventory changed; re-check the numbers below '
      + 'against the new metadata before touching them.');
    Assert.AreEqual(963, Eligible,
      'The number of formats the AsYouTypeFormatter can use changed.');
    Assert.AreEqual(3, Total - Eligible,
      'The number of rejected format OCCURRENCES changed.');
    Assert.AreEqual(1, Rejected.Count,
      'Exactly one DISTINCT format of the baseline may be rejected.');
    { Argentina. Precisely the case the upstream comment describes: the format
      does not contain the first group, so formatting as you type would lose
      digits. }
    Assert.AreEqual('$2 15-$3-$4', Rejected[0],
      'The rejected format is not the expected Argentinian one.');
  finally
    Rejected.Free;
  end;
end;

procedure TAsYouTypeFormatterTests.NationalPrefixHasSeparator_FindsDashAndSpace;
begin
  Assert.IsFalse(NationalPrefixHasSeparator(''), 'No rule, no separator.');
  Assert.IsFalse(NationalPrefixHasSeparator('$1'), 'Plain first group.');
  Assert.IsFalse(NationalPrefixHasSeparator('0$1'), 'National prefix, no separator.');
  Assert.IsTrue(NationalPrefixHasSeparator('0 $1'), 'A space is a separator.');
  Assert.IsTrue(NationalPrefixHasSeparator('0-$1'), 'A dash is a separator.');
  Assert.IsFalse(NationalPrefixHasSeparator('($1)'),
    'Parentheses are not separators.');
end;

procedure TAsYouTypeFormatterTests
  .FormattingRuleHasFirstGroupOnly_MatchesTheUpstreamPattern;
begin
  { FIRST_GROUP_ONLY_PREFIX_PATTERN is "\(?\$1\)?". }
  Assert.IsTrue(FormattingRuleHasFirstGroupOnly(''), 'No rule counts as first group only.');
  Assert.IsTrue(FormattingRuleHasFirstGroupOnly('$1'), 'Bare first group.');
  Assert.IsTrue(FormattingRuleHasFirstGroupOnly('($1'), 'Opening parenthesis only.');
  Assert.IsTrue(FormattingRuleHasFirstGroupOnly('$1)'), 'Closing parenthesis only.');
  Assert.IsTrue(FormattingRuleHasFirstGroupOnly('($1)'), 'Both parentheses.');
  Assert.IsFalse(FormattingRuleHasFirstGroupOnly('0$1'), 'A national prefix disqualifies.');
  Assert.IsFalse(FormattingRuleHasFirstGroupOnly('0 $1'), 'Prefix plus separator.');
  Assert.IsFalse(FormattingRuleHasFirstGroupOnly('$1 $2'), 'More than the first group.');
end;

procedure TAsYouTypeFormatterTests.MapAlphaCharacterToDigit_IsTheDialPadTable;
begin
  Assert.IsTrue(MapAlphaCharacterToDigit('A') = '2', 'A maps to 2.');
  Assert.IsTrue(MapAlphaCharacterToDigit('c') = '2', 'Lower case c maps to 2.');
  Assert.IsTrue(MapAlphaCharacterToDigit('D') = '3', 'D maps to 3.');
  Assert.IsTrue(MapAlphaCharacterToDigit('I') = '4', 'I maps to 4.');
  Assert.IsTrue(MapAlphaCharacterToDigit('L') = '5', 'L maps to 5.');
  Assert.IsTrue(MapAlphaCharacterToDigit('O') = '6', 'O maps to 6.');
  Assert.IsTrue(MapAlphaCharacterToDigit('S') = '7', 'S maps to 7.');
  Assert.IsTrue(MapAlphaCharacterToDigit('V') = '8', 'V maps to 8.');
  Assert.IsTrue(MapAlphaCharacterToDigit('Z') = '9', 'Z maps to 9.');
  Assert.IsTrue(MapAlphaCharacterToDigit('1') = #0, 'A digit is not a letter.');
  Assert.IsTrue(MapAlphaCharacterToDigit('-') = #0, 'A dash is not a letter.');
end;

procedure TAsYouTypeFormatterTests
  .ConvertAlphaCharactersInNumber_KeepsEverythingElse;
begin
  { normalizeHelper with removeNonMatches = false. }
  Assert.AreEqual('1-800-3569377',
    ConvertAlphaCharactersInNumber('1-800-FLOWERS'));
  Assert.AreEqual('+1 800 738 3733',
    ConvertAlphaCharactersInNumber('+1 800 PET FRED'));
  Assert.AreEqual('0800 123456',
    ConvertAlphaCharactersInNumber('0800 123456'));
end;

procedure TAsYouTypeFormatterTests
  .NormalizeAlphaPhoneOrDigits_NeedsThreeLettersToConvert;
begin
  { VALID_ALPHA_PHONE_PATTERN requires three ASCII letters before upstream
    switches to the alpha mapping; below that the number is digits only. }
  Assert.AreEqual('18003569377',
    NormalizeAlphaPhoneOrDigits('1-800-FLOWERS'));
  Assert.AreEqual('18001234',
    NormalizeAlphaPhoneOrDigits('1-800-1234'));
  Assert.AreEqual('1800123',
    NormalizeAlphaPhoneOrDigits('1-800-AB-123'),
    'Two letters are below the threshold, so they are dropped as non digits.');
  Assert.AreEqual('1800222123',
    NormalizeAlphaPhoneOrDigits('1-800-ABC-123'),
    'Three letters flip the whole number onto the alpha mapping.');
end;

procedure TAsYouTypeFormatterTests
  .NormalizeAllPlusNumberGroupingSymbols_KeepsGroupingOnly;
begin
  Assert.AreEqual('1-800-FLOWERS',
    NormalizeAllPlusNumberGroupingSymbols('1-800-FLOWERS'));
  Assert.AreEqual('1-800-FLOWERS',
    NormalizeAllPlusNumberGroupingSymbols('1-800-flowers'),
    'Letters are upper cased.');
  Assert.AreEqual('020 7031 3000',
    NormalizeAllPlusNumberGroupingSymbols('+(020) 7031 3000'),
    'The plus sign and the parentheses are not in the table.');
  Assert.AreEqual('030/1234567',
    NormalizeAllPlusNumberGroupingSymbols('030/1234567'));
  Assert.AreEqual('1.8002',
    NormalizeAllPlusNumberGroupingSymbols('1.800;2'),
    'A semicolon is dropped, a full stop is kept.');
end;

procedure TAsYouTypeFormatterTests
  .TryFindFirst_ReturnsTheLeftmostUnanchoredMatch;
var
  Value: string;
  Start: Integer;
begin
  Assert.IsTrue(TryFindFirst('\d{3}', 'ab123cd456', Value, Start),
    'The pattern occurs in the input.');
  Assert.AreEqual('123', Value, 'The leftmost match wins.');
  Assert.AreEqual(3, Start, 'Start is the 1 based index of the match.');

  Assert.IsFalse(TryFindFirst('\d{3}', 'abcd', Value, Start),
    'No match must be reported as False.');
  Assert.AreEqual('', Value);
  Assert.AreEqual(0, Start);

  { This is the call shape AsYouTypeFormatter.getFormattingTemplate uses. }
  Assert.IsTrue(TryFindFirst('(\d{3})(\d{4})', '999999999999999', Value, Start));
  Assert.AreEqual('9999999', Value,
    'The template generator keeps only the part the format pattern consumes.');
end;

procedure TAsYouTypeFormatterTests
  .IsViablePhoneNumber_GuardsTheExtensionStrip;
begin
  { This is the FULL port of isViablePhoneNumber in
    LibPhoneNumber.MetadataCore; the restricted predicate this test was
    written for is gone. Every assertion below is unchanged, because all nine
    inputs live in the alphabet the restricted version reasoned about
    (A-Z, 0-9 and the four grouping separators), where the two predicates
    coincide by construction.

    First VALID_PHONE_NUMBER alternative: exactly MIN_LENGTH_FOR_NSN = 2
    digits. }
  Assert.IsTrue(IsViablePhoneNumber('12'),
    'Exactly two digits are viable.');
  Assert.IsFalse(IsViablePhoneNumber('1'),
    'One digit is neither alternative.');
  Assert.IsFalse(IsViablePhoneNumber(''),
    'The empty string is not viable.');
  Assert.IsFalse(IsViablePhoneNumber('1A'),
    'One digit plus a letter is not viable - this is the case that makes the '
    + 'guard load bearing.');

  { Second alternative: three or more digits, each optionally preceded by
    separators, then any mix of separators, letters and digits. }
  Assert.IsTrue(IsViablePhoneNumber('123'),
    'Three digits are viable.');
  Assert.IsTrue(IsViablePhoneNumber('1-2 3'),
    'Separators between the digits are allowed.');
  Assert.IsTrue(IsViablePhoneNumber('800-FLOWERS'),
    'Three leading digits followed by letters are viable.');
  Assert.IsFalse(IsViablePhoneNumber('1-2'),
    'Two digit groups are below the threshold of the second alternative.');
  Assert.IsFalse(IsViablePhoneNumber('1A2B3C'),
    'The three digits must not be separated by letters.');
end;

procedure TAsYouTypeFormatterTests
  .KeepingAlphaChars_DoesNotStripAnExtensionFromAnUnviablePrefix;
var
  Number: TPhoneNumber;
  Actual: string;
begin
  { Regression guard for the isViablePhoneNumber part of maybeStripExtension.

    The number record is built by hand ON PURPOSE and not parsed. "1AEXT234"
    is exactly the shape upstream refuses at parse time - verified against the
    oracle, where ParseAndKeepRawInput("1AEXT234", "US") raises "The string
    supplied did not seem to be a phone number" - so no oracle expectation for
    this string can exist. What can be pinned is the behaviour of the METHOD,
    and there upstream is unambiguous: the extension is stripped only when the
    part in front of it is a viable phone number. "1A" is not, so nothing is
    stripped.

    The parse gate IS upstream's isViablePhoneNumber, so
    "1AEXT234" can no longer arrive here through Parse - the record is built by
    hand for exactly that reason. The guard still cannot be reduced to "the
    match must not start at the first character": that weaker rule would
    truncate the raw input to "1A". }
  Number := Default(TPhoneNumber);
  Number.CountryCode := 1;
  Number.NationalNumberDigits := '8003569377';
  Number.RegionCode := 'US';
  Number.RawInput := '1AEXT234';

  Actual := TPhoneNumberUtil.FormatOutOfCountryKeepingAlphaChars(Number,
    'GB');
  Assert.AreEqual('00 1 1AEXT234', Actual,
    'An unviable prefix must leave the raw input untouched.');
end;

procedure TAsYouTypeFormatterTests
  .CanBeInternationallyDialled_FollowsNoInternationalDialling;
begin
  { A plain US number is diallable from abroad ... }
  Assert.IsTrue(CanBeInternationallyDialled(1, '6502530000'),
    'A regular US number is internationally diallable.');
  { ... and a non geographical entity always is, because it has no region
    metadata at all. }
  Assert.IsTrue(CanBeInternationallyDialled(800, '12345678'),
    'Non geographical entities are always internationally diallable.');
end;

{ --------------------------------------------------------------------------
  Behaviour of the class itself
  -------------------------------------------------------------------------- }

procedure TAsYouTypeFormatterTests.Clear_ResetsTheFormatterForReuse;
var
  Formatter: TAsYouTypeFormatter;
  I: Integer;
  First, Second: string;
  Input: string;
begin
  Input := '6502532222';
  Formatter := TAsYouTypeFormatter.Create('US');
  try
    First := '';
    for I := 1 to Length(Input) do
      First := Formatter.InputDigit(Input[I]);
    Assert.AreEqual('', Formatter.ExtractedNationalPrefix,
      'No national prefix was entered.');

    Formatter.Clear;
    Assert.AreEqual('', Formatter.ExtractedNationalPrefix,
      'Clear must reset the extracted national prefix.');
    Assert.AreEqual(0, Formatter.GetRememberedPosition,
      'Clear must reset the remembered position.');

    Second := '';
    for I := 1 to Length(Input) do
      Second := Formatter.InputDigit(Input[I]);
    Assert.AreEqual(First, Second,
      'A cleared formatter must behave like a fresh one.');
  finally
    Formatter.Free;
  end;
end;

procedure TAsYouTypeFormatterTests
  .NonAsciiDigits_AreNormalisedLikeUpstream;
var
  Formatter: TAsYouTypeFormatter;
  Output: string;
begin
  { A full width digit is a digit, not a formatting character:
    isDigitOrLeadingPlusSign uses
    Character.isDigit like upstream and normalizeAndAccrueDigitsAndPlusSign
    converts the character to ASCII before it is accrued.

    Both expectations are read off the NuGet oracle
    (libphonenumber-csharp 9.0.38) rather than off AsYouTypeFormatterTest.java,
    which runs against the testing metadata. Note what the oracle shows for the
    first two characters: while fewer than three characters have been accrued
    the formatter returns accruedInput, i.e. the RAW characters, so a non ASCII
    digit is still visible there; the normalised form only appears once
    formatting starts. }
  Formatter := TAsYouTypeFormatter.Create('US');
  try
    Formatter.InputDigit('6');
    Formatter.InputDigit('5');
    Output := Formatter.InputDigit(WideChar($FF10));
    Assert.AreEqual('650', Output,
      'A full width digit must be normalised to ASCII, not echoed.');
  finally
    Formatter.Free;
  end;

  { Oracle, full width 6502530000 typed into a US formatter: the first two
    outputs are the raw full width characters, the third is already '650'. }
  Formatter := TAsYouTypeFormatter.Create('US');
  try
    Assert.AreEqual(string(WideChar($FF16)),
      Formatter.InputDigit(WideChar($FF16)),
      'Below three characters the raw input is echoed.');
    Assert.AreEqual(string(WideChar($FF16)) + string(WideChar($FF15)),
      Formatter.InputDigit(WideChar($FF15)));
    Assert.AreEqual('650', Formatter.InputDigit(WideChar($FF10)));
    Assert.AreEqual('650-2', Formatter.InputDigit(WideChar($FF12)));
  finally
    Formatter.Free;
  end;

  { Oracle, Arabic-Indic digits typed into a US formatter. }
  Formatter := TAsYouTypeFormatter.Create('US');
  try
    Assert.AreEqual(string(WideChar($0666)),
      Formatter.InputDigit(WideChar($0666)));
    Assert.AreEqual(string(WideChar($0666)) + string(WideChar($0665)),
      Formatter.InputDigit(WideChar($0665)));
    Assert.AreEqual('650', Formatter.InputDigit(WideChar($0660)));
    Assert.AreEqual('650-2', Formatter.InputDigit(WideChar($0662)));
  finally
    Formatter.Free;
  end;
end;

procedure TAsYouTypeFormatterTests
  .UnknownRegion_StillFormatsNumbersEnteredWithPlus;
var
  Formatter: TAsYouTypeFormatter;
  Output: string;
  I: Integer;
  Input: string;
begin
  { The EMPTY_METADATA fallback of the Java constructor: an unknown region is
    not an error, it only limits formatting to the plus branch. }
  Input := '+493012345';
  Formatter := TAsYouTypeFormatter.Create('ZZ');
  try
    Output := '';
    for I := 1 to Length(Input) do
      Output := Formatter.InputDigit(Input[I]);
    Assert.IsTrue(Output.StartsWith('+49 '),
      'The calling code must still be split off: ' + Output);
  finally
    Formatter.Free;
  end;
end;

procedure TAsYouTypeFormatterTests.ConstructorRegion_IsCanonicalised;

  function TypeAll(const ARegion, AInput: string): string;
  var
    Formatter: TAsYouTypeFormatter;
    I: Integer;
  begin
    Result := '';
    Formatter := TAsYouTypeFormatter.Create(ARegion);
    try
      for I := 1 to Length(AInput) do
        Result := Formatter.InputDigit(AInput[I]);
    finally
      Formatter.Free;
    end;
  end;

var
  Canonical: string;
begin
  { The constructor canonicalises its region argument
    with UpperCase(Trim(...)), the same rule the facade and ShortNumberInfo
    follow. Upstream compares exactly and would fall back to EMPTY_METADATA for
    'us', which formats nothing at all in the national branch.

    The expectation is the CANONICAL region's own output, not a hand written
    string, so this test cannot drift away from the oracle backed sequence
    tests above. }
  Canonical := TypeAll('US', '6502532222');
  Assert.AreEqual(Canonical, TypeAll('us', '6502532222'));
  Assert.AreEqual(Canonical, TypeAll(' Us ', '6502532222'));

  { An unknown region stays unknown however it is spelled - canonicalising is
    not the same as guessing. }
  Assert.AreEqual(TypeAll('ZZ', '6502532222'), TypeAll(' zz ', '6502532222'));
end;

initialization
  { Explicit registration, like every other fixture of this suite: the test
    layer has no attribute scan, the call is what puts the fixture in the
    run. }
  RegisterTest(TAsYouTypeFormatterTests);

end.
