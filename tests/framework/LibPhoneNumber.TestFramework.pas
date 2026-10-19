unit LibPhoneNumber.TestFramework;

{
  The test layer of the repository: fixtures, assertions and the fixture
  registry. One source for Delphi and FreePascal (3.2.2 and later, Delphi
  mode). It replaces DUnitX, which needs custom attributes and therefore never
  ran on FreePascal 3.2.

  Fixtures
  --------
  A fixture is a class derived from TTestCase. Its tests are its PUBLISHED
  parameterless procedures, discovered through the published method table of
  the class (see EnumerateTests), in declaration order. Setup and TearDown are
  virtual and run around every test. As in DUnitX, ONE instance of the fixture
  serves all of its tests, so fixture fields keep their values between tests;
  Setup is where per-test state is reset. Every test unit registers its
  fixtures in its initialization section with RegisterTest.

  Assertions
  ----------
  The class Assert is source compatible with the subset of the DUnitX Assert
  class the suite uses: same names, expected before actual, optional message.
  A failed assertion raises ETestFailure; the runner reports it as a failure,
  every other exception as an error. Overload set of AreEqual / AreNotEqual:

  1. string, Integer, Int64, Boolean - the types the suite compares; integer
     arguments of mixed width resolve to the Int64 overload. On FreePascal
     `string` is the UTF-8 AnsiString, and a second overload for UnicodeString
     keeps a comparison of two UnicodeString values in UTF-16, where a lone
     surrogate is still distinguishable.
  2. A generic AreEqual<T> / AreNotEqual<T> for an explicit type argument, as
     in `Assert.AreEqual<UInt64>(...)`. FreePascal 3.2 has no implicit
     specialization of generic routines, so a generic call must always spell
     its type argument (enumerations are compared through Ord in the suite,
     or with an explicit <TEnum>). The generic compares the raw bytes of the
     two values, is meant for ordinal types only, and names enumeration
     values in its failure message.

  Log
  ---
  LogMessage collects informational lines of the running test (the
  replacement for TDUnitX.CurrentRunner.Log). The runner prints them in
  verbose mode or when the test does not pass, and writes them into the JUnit
  report.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  SysUtils,
  Classes;
{$ELSE}
  System.SysUtils,
  System.Classes;
{$ENDIF}

type
  { Raised by every failed assertion. }
  ETestFailure = class(Exception);

  {$M+}
  TTestCase = class
  public
    constructor Create; virtual;
    procedure Setup; virtual;
    procedure TearDown; virtual;
  end;
  {$M-}

  TTestCaseClass = class of TTestCase;

  TTestMethod = procedure of object;

  TTestEntry = record
    Name: string;
    Code: Pointer;
  end;
  TTestEntryArray = array of TTestEntry;

  Assert = class
  private
    class procedure FailNotEqual(const AExpected, AActual, AMessage: string); static;
    class procedure FailEqual(const AValue, AMessage: string); static;
  public
    class procedure Fail(const AMessage: string = ''); static;
    class procedure IsTrue(ACondition: Boolean; const AMessage: string = ''); static;
    class procedure IsFalse(ACondition: Boolean; const AMessage: string = ''); static;
    class procedure IsNull(AValue: TObject; const AMessage: string = ''); overload; static;
    class procedure IsNull(AValue: Pointer; const AMessage: string = ''); overload; static;
    class procedure IsNotNull(AValue: TObject; const AMessage: string = ''); overload; static;
    class procedure IsNotNull(AValue: Pointer; const AMessage: string = ''); overload; static;

    class procedure AreEqual(const AExpected, AActual: string; const AMessage: string = ''); overload; static;
{$IFDEF FPC}
    class procedure AreEqual(const AExpected, AActual: UnicodeString; const AMessage: string = ''); overload; static;
{$ENDIF}
    class procedure AreEqual(AExpected, AActual: Integer; const AMessage: string = ''); overload; static;
    class procedure AreEqual(AExpected, AActual: Int64; const AMessage: string = ''); overload; static;
    class procedure AreEqual(AExpected, AActual: Boolean; const AMessage: string = ''); overload; static;
    class procedure AreEqual<T>(const AExpected, AActual: T; const AMessage: string = ''); overload; static;

    class procedure AreNotEqual(const AExpected, AActual: string; const AMessage: string = ''); overload; static;
    class procedure AreNotEqual(AExpected, AActual: Integer; const AMessage: string = ''); overload; static;
    class procedure AreNotEqual(AExpected, AActual: Int64; const AMessage: string = ''); overload; static;
    class procedure AreNotEqual<T>(const AExpected, AActual: T; const AMessage: string = ''); overload; static;
  end;

{ Registers a fixture class. Called from the initialization section of every
  test unit. Registering the same class twice is an error. }
procedure RegisterTest(AFixture: TTestCaseClass);

{ The registered fixtures, in registration order. }
function RegisteredFixtureCount: Integer;
function RegisteredFixture(AIndex: Integer): TTestCaseClass;

{ The tests of a fixture: its published methods, in declaration order,
  ancestors first, each name once and resolved against AFixture itself.
  Raises when the method table does not look like the one
  this unit expects (see the implementation). }
function EnumerateTests(AFixture: TTestCaseClass): TTestEntryArray;

{ Adds a line to the log of the running test. }
procedure LogMessage(const AMessage: string);

{ Used by the runner: starts a new test log and hands out the collected
  lines. }
procedure ClearTestLog;
function TakeTestLog: TStringList;

{ Formats a value of a generic assertion for a failure message. }
function FormatOrdinalValue(ATypeInfo: Pointer; const AValue; ASize: Integer): string;

implementation

uses
{$IFDEF FPC}
  TypInfo;
{$ELSE}
  System.TypInfo;
{$ENDIF}

var
  Fixtures: array of TTestCaseClass;
  TestLog: TStringList;

{ ---------------------------------------------------------------------------
  TTestCase
  --------------------------------------------------------------------------- }

constructor TTestCase.Create;
begin
  inherited Create;
end;

procedure TTestCase.Setup;
begin
end;

procedure TTestCase.TearDown;
begin
end;

{ ---------------------------------------------------------------------------
  Registry
  --------------------------------------------------------------------------- }

procedure RegisterTest(AFixture: TTestCaseClass);
var
  I: Integer;
begin
  for I := 0 to High(Fixtures) do
    if Fixtures[I] = AFixture then
      raise Exception.CreateFmt('Fixture %s is registered twice.', [AFixture.ClassName]);
  SetLength(Fixtures, Length(Fixtures) + 1);
  Fixtures[High(Fixtures)] := AFixture;
end;

function RegisteredFixtureCount: Integer;
begin
  Result := Length(Fixtures);
end;

function RegisteredFixture(AIndex: Integer): TTestCaseClass;
begin
  Result := Fixtures[AIndex];
end;

{ ---------------------------------------------------------------------------
  Published method discovery

  Both compilers keep the published methods of a class in the "method table"
  the VMT points to (the table TObject.MethodAddress searches), but the two
  layouts differ:

  Delphi   Word count, then per method a variable length entry
           (Word entry size, Pointer code address, ShortString name, possibly
           followed by extended data the entry size skips). Only the legacy
           part is read; it lists exactly the published methods.
  FPC      DWord count, then per method (PShortString name, CodePointer
           address). FPC 3.2 lays the table out PACKED on every platform
           (the pointers start at offset 4). FPC 3.3.1 since Jan 2024 aligns
           it naturally on platforms that define FPC_REQUIRES_PROPER_ALIGNMENT
           (aarch64 among them), exactly like the RTL declaration in
           rtl/inc/objpas.inc of the respective version.

  Every entry is cross-checked against TObject.MethodAddress, which reads the
  same table through the RTL's own declaration. A layout mismatch therefore
  fails loudly instead of running the wrong code.
  --------------------------------------------------------------------------- }

{$IFDEF FPC}
type
  {$PUSH}
  {$PACKRECORDS NORMAL}
  {$IF FPC_FULLVERSION >= 30301}
    {$IFDEF FPC_REQUIRES_PROPER_ALIGNMENT}
      {$DEFINE LPN_ALIGNED_METHOD_TABLE}
    {$ENDIF}
  {$IFEND}
  PMethodNameRec = ^TMethodNameRec;
  TMethodNameRec = {$IFNDEF LPN_ALIGNED_METHOD_TABLE}packed{$ENDIF} record
    Name: PShortString;
    Addr: CodePointer;
  end;
  PMethodNameTable = ^TMethodNameTable;
  TMethodNameTable = {$IFNDEF LPN_ALIGNED_METHOD_TABLE}packed{$ENDIF} record
    Count: DWord;
    Entries: packed array[0..0] of TMethodNameRec;
  end;
  {$POP}

procedure AppendOwnMethods(AClass: TClass; var AList: TTestEntryArray);
var
  Table: PMethodNameTable;
  Entry: PMethodNameRec;
  I, Base: Integer;
  Name: string;
begin
  Table := PMethodNameTable(PVmt(AClass)^.vMethodTable);
  if Table = nil then
    Exit;
  Base := Length(AList);
  SetLength(AList, Base + Integer(Table^.Count));
  Entry := @Table^.Entries[0];
  for I := 0 to Integer(Table^.Count) - 1 do
  begin
    Name := string(Entry^.Name^);
    if AClass.MethodAddress(Entry^.Name^) <> Entry^.Addr then
      raise Exception.CreateFmt('Unexpected published method table layout in %s ' +
        '(entry %d, "%s"); see LibPhoneNumber.TestFramework.', [AClass.ClassName, I, Name]);
    AList[Base + I].Name := Name;
    AList[Base + I].Code := Entry^.Addr;
    Inc(Entry);
  end;
end;
{$ELSE}
procedure AppendOwnMethods(AClass: TClass; var AList: TTestEntryArray);
var
  P: PByte;
  Count, I, Base: Integer;
  Code: Pointer;
  Name: string;
begin
  P := PPointer(PByte(AClass) + vmtMethodTable)^;
  if P = nil then
    Exit;
  Count := PWord(P)^;
  Inc(P, SizeOf(Word));
  Base := Length(AList);
  SetLength(AList, Base + Count);
  for I := 0 to Count - 1 do
  begin
    Code := PPointer(P + SizeOf(Word))^;
    Name := string(PShortString(P + SizeOf(Word) + SizeOf(Pointer))^);
    if AClass.MethodAddress(Name) <> Code then
      raise Exception.CreateFmt('Unexpected published method table layout in %s ' +
        '(entry %d, "%s"); see LibPhoneNumber.TestFramework.', [AClass.ClassName, I, Name]);
    AList[Base + I].Name := Name;
    AList[Base + I].Code := Code;
    Inc(P, PWord(P)^);
  end;
end;
{$ENDIF}

function EnumerateTests(AFixture: TTestCaseClass): TTestEntryArray;
var
  All: TTestEntryArray;
  I, J, Count: Integer;
  Seen: Boolean;

  procedure Collect(AClass: TClass);
  begin
    if (AClass = nil) or (AClass = TTestCase) or (AClass = TObject) then
      Exit;
    Collect(AClass.ClassParent);
    AppendOwnMethods(AClass, All);
  end;

begin
  All := nil;
  Collect(AFixture);
  { One test per NAME, resolved against the concrete fixture: a descendant
    that redeclares (or overrides) a published test of an ancestor must run
    its own implementation once, not both. The position is the one of the
    first declaration, so the order stays ancestors first. Names compare
    case insensitively, like Pascal identifiers and MethodAddress. }
  Result := nil;
  SetLength(Result, Length(All));
  Count := 0;
  for I := 0 to High(All) do
  begin
    Seen := False;
    for J := 0 to Count - 1 do
      if SameText(Result[J].Name, All[I].Name) then
      begin
        Seen := True;
        Break;
      end;
    if Seen then
      Continue;
    Result[Count].Name := All[I].Name;
    Result[Count].Code := TClass(AFixture).MethodAddress(All[I].Name);
    Inc(Count);
  end;
  SetLength(Result, Count);
end;

{ ---------------------------------------------------------------------------
  Log
  --------------------------------------------------------------------------- }

procedure LogMessage(const AMessage: string);
begin
  if TestLog = nil then
    TestLog := TStringList.Create;
  TestLog.Add(AMessage);
end;

procedure ClearTestLog;
begin
  FreeAndNil(TestLog);
end;

function TakeTestLog: TStringList;
begin
  Result := TestLog;
  TestLog := nil;
end;

{ ---------------------------------------------------------------------------
  Value formatting
  --------------------------------------------------------------------------- }

function OrdinalOf(const AValue; ASize: Integer; ASigned: Boolean): Int64;
begin
  case ASize of
    1:
      if ASigned then
        Result := ShortInt(AValue)
      else
        Result := Byte(AValue);
    2:
      if ASigned then
        Result := SmallInt(AValue)
      else
        Result := Word(AValue);
    4:
      if ASigned then
        Result := Integer(AValue)
      else
        Result := Cardinal(AValue);
  else
    Result := Int64(AValue);
  end;
end;

function FormatOrdinalValue(ATypeInfo: Pointer; const AValue; ASize: Integer): string;
var
  Info: PTypeInfo;
  Ordinal: Int64;
begin
  Info := PTypeInfo(ATypeInfo);
  if Info <> nil then
    case Info^.Kind of
      tkEnumeration:
        begin
          Ordinal := OrdinalOf(AValue, ASize, False);
          Exit(Format('%s(%d)', [GetEnumName(Info, Integer(Ordinal)), Ordinal]));
        end;
      tkInteger, tkChar, tkWChar:
        Exit(IntToStr(OrdinalOf(AValue, ASize, True)));
      tkInt64:
        if ASize = SizeOf(Int64) then
        begin
          { Delphi reports UInt64 as tkInt64 with MinValue > MaxValue. }
          if GetTypeData(Info)^.MinInt64Value > GetTypeData(Info)^.MaxInt64Value then
            Exit(UIntToStr(UInt64(AValue)));
          Exit(IntToStr(Int64(AValue)));
        end;
{$IFDEF FPC}
      tkQWord:
        if ASize = SizeOf(UInt64) then
          Exit(UIntToStr(UInt64(AValue)));
{$ENDIF}
    else
      { Any other kind falls through to the raw ordinal below. }
    end;
  if ASize <= SizeOf(Int64) then
    Result := IntToStr(OrdinalOf(AValue, ASize, False))
  else
    Result := Format('<%d bytes>', [ASize]);
end;

{ ---------------------------------------------------------------------------
  Assert
  --------------------------------------------------------------------------- }

class procedure Assert.FailNotEqual(const AExpected, AActual, AMessage: string);
var
  Text: string;
begin
  Text := Format('Expected %s but got %s', [AExpected, AActual]);
  if AMessage <> '' then
    Text := Text + ' - ' + AMessage;
  raise ETestFailure.Create(Text);
end;

class procedure Assert.FailEqual(const AValue, AMessage: string);
var
  Text: string;
begin
  Text := Format('Expected a value different from %s', [AValue]);
  if AMessage <> '' then
    Text := Text + ' - ' + AMessage;
  raise ETestFailure.Create(Text);
end;

class procedure Assert.Fail(const AMessage: string);
begin
  raise ETestFailure.Create(AMessage);
end;

class procedure Assert.IsTrue(ACondition: Boolean; const AMessage: string);
begin
  if not ACondition then
  begin
    if AMessage = '' then
      raise ETestFailure.Create('Condition is False, expected True')
    else
      raise ETestFailure.Create('Condition is False, expected True - ' + AMessage);
  end;
end;

class procedure Assert.IsFalse(ACondition: Boolean; const AMessage: string);
begin
  if ACondition then
  begin
    if AMessage = '' then
      raise ETestFailure.Create('Condition is True, expected False')
    else
      raise ETestFailure.Create('Condition is True, expected False - ' + AMessage);
  end;
end;

class procedure Assert.IsNull(AValue: TObject; const AMessage: string);
begin
  if AValue <> nil then
    FailNotEqual('nil', 'an instance of ' + AValue.ClassName, AMessage);
end;

class procedure Assert.IsNull(AValue: Pointer; const AMessage: string);
begin
  if AValue <> nil then
    FailNotEqual('nil', 'a non nil pointer', AMessage);
end;

class procedure Assert.IsNotNull(AValue: TObject; const AMessage: string);
begin
  if AValue = nil then
    FailNotEqual('an instance', 'nil', AMessage);
end;

class procedure Assert.IsNotNull(AValue: Pointer; const AMessage: string);
begin
  if AValue = nil then
    FailNotEqual('a non nil pointer', 'nil', AMessage);
end;

class procedure Assert.AreEqual(const AExpected, AActual, AMessage: string);
begin
  if AExpected <> AActual then
    FailNotEqual('"' + AExpected + '"', '"' + AActual + '"', AMessage);
end;

{$IFDEF FPC}
class procedure Assert.AreEqual(const AExpected, AActual: UnicodeString;
  const AMessage: string);
begin
  if AExpected <> AActual then
    FailNotEqual('"' + string(AExpected) + '"', '"' + string(AActual) + '"', AMessage);
end;
{$ENDIF}

class procedure Assert.AreEqual(AExpected, AActual: Integer; const AMessage: string);
begin
  if AExpected <> AActual then
    FailNotEqual(IntToStr(AExpected), IntToStr(AActual), AMessage);
end;

class procedure Assert.AreEqual(AExpected, AActual: Int64; const AMessage: string);
begin
  if AExpected <> AActual then
    FailNotEqual(IntToStr(AExpected), IntToStr(AActual), AMessage);
end;

class procedure Assert.AreEqual(AExpected, AActual: Boolean; const AMessage: string);
begin
  if AExpected <> AActual then
    FailNotEqual(BoolToStr(AExpected, True), BoolToStr(AActual, True), AMessage);
end;







class procedure Assert.AreEqual<T>(const AExpected, AActual: T; const AMessage: string);
begin
  if not CompareMem(@AExpected, @AActual, SizeOf(T)) then
    FailNotEqual(FormatOrdinalValue(TypeInfo(T), AExpected, SizeOf(T)),
      FormatOrdinalValue(TypeInfo(T), AActual, SizeOf(T)), AMessage);
end;

class procedure Assert.AreNotEqual(const AExpected, AActual, AMessage: string);
begin
  if AExpected = AActual then
    FailEqual('"' + AExpected + '"', AMessage);
end;

class procedure Assert.AreNotEqual(AExpected, AActual: Integer; const AMessage: string);
begin
  if AExpected = AActual then
    FailEqual(IntToStr(AExpected), AMessage);
end;

class procedure Assert.AreNotEqual(AExpected, AActual: Int64; const AMessage: string);
begin
  if AExpected = AActual then
    FailEqual(IntToStr(AExpected), AMessage);
end;

class procedure Assert.AreNotEqual<T>(const AExpected, AActual: T; const AMessage: string);
begin
  if CompareMem(@AExpected, @AActual, SizeOf(T)) then
    FailEqual(FormatOrdinalValue(TypeInfo(T), AExpected, SizeOf(T)), AMessage);
end;

initialization

finalization
  FreeAndNil(TestLog);

end.
