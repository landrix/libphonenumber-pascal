unit LibPhoneNumber.TestJson;

{
  A minimal JSON reader for the test data files under tests/data, plus the
  file helpers the data driven tests need (ReadUtf8File, FindTestDataFile). One source for Delphi
  and FreePascal: System.JSON does not exist on FreePascal and fpjson does not
  exist on Delphi, and a reader of its own decodes every document identically
  on both.

  The class names follow System.JSON (TJSONValue, TJSONObject, TJSONArray,
  TJSONString, ...) so the tests read as before. Differences to System.JSON:

  1. Typed member access is spelled GetString / GetBoolean / TryGetString
     instead of the generic GetValue<string> / GetValue<Boolean> /
     TryGetValue<string>: FreePascal 3.2 has no implicit specialization, and a
     plain method keeps both compilers on one code path.
  2. GetValue(name) answers nil for a missing member, as in System.JSON;
     GetString / GetBoolean raise EJSONError for a missing member or a member
     of another kind.
  3. ParseJSONValue answers nil for text that is not exactly one JSON value
     (System.JSON does the same).
  4. A document is a tree of objects owned by its root; free the root only.

  Strings are decoded completely (all escapes, \uXXXX as UTF-16 code units,
  so a surrogate pair escape becomes the character it encodes) into a
  UnicodeString and handed out as `string` - UTF-8 on FreePascal, which
  relies on the UTF-8 conversion code page the test runner sets. Numbers keep
  their source text; Value returns it (StrToInt reads it back).
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
  EJSONError = class(Exception);

  TJSONValue = class
  public
    { The text of a scalar: the decoded string, the number as written,
      'true' / 'false', 'null'. Empty for an object or an array. }
    function Value: string; virtual;
  end;

  TJSONString = class(TJSONValue)
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
    function Value: string; override;
  end;

  TJSONNumber = class(TJSONValue)
  private
    FText: string;
  public
    constructor Create(const AText: string);
    function Value: string; override;
  end;

  TJSONBool = class(TJSONValue)
  private
    FValue: Boolean;
  public
    constructor Create(AValue: Boolean);
    function Value: string; override;
    property AsBoolean: Boolean read FValue;
  end;

  TJSONNull = class(TJSONValue)
  public
    function Value: string; override;
  end;

  TJSONArray = class(TJSONValue)
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TJSONValue;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(AValue: TJSONValue);
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TJSONValue read GetItem;
  end;

  TJSONObject = class(TJSONValue)
  private
    FNames: TStringList;
    FValues: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddPair(const AName: string; AValue: TJSONValue);
    { The member AName, or nil. }
    function GetValue(const AName: string): TJSONValue;
    function GetString(const AName: string): string;
    function GetBoolean(const AName: string): Boolean;
    function TryGetString(const AName: string; out AValue: string): Boolean;
    { Parses a complete JSON text; nil when it is not exactly one value. }
    class function ParseJSONValue(const AText: string): TJSONValue;
  end;

{ Reads a UTF-8 text file (a leading byte order mark is skipped). }
function ReadUtf8File(const AFileName: string): string;

{ The path of tests/data/AFileName, or '' when it cannot be found. The
  directory of the executable and the current directory are searched, each
  with up to six parent directories, for data/AFileName and
  tests/data/AFileName, so the program finds its data wherever it was built
  (tests/bin, a scratch directory of a gate script, a CI work directory) as
  long as it is started from inside the repository or lives inside it. }
function FindTestDataFile(const AFileName: string): string;

implementation

{ ---------------------------------------------------------------------------
  Values
  --------------------------------------------------------------------------- }

function TJSONValue.Value: string;
begin
  Result := '';
end;

constructor TJSONString.Create(const AValue: string);
begin
  inherited Create;
  FValue := AValue;
end;

function TJSONString.Value: string;
begin
  Result := FValue;
end;

constructor TJSONNumber.Create(const AText: string);
begin
  inherited Create;
  FText := AText;
end;

function TJSONNumber.Value: string;
begin
  Result := FText;
end;

constructor TJSONBool.Create(AValue: Boolean);
begin
  inherited Create;
  FValue := AValue;
end;

function TJSONBool.Value: string;
begin
  if FValue then
    Result := 'true'
  else
    Result := 'false';
end;

function TJSONNull.Value: string;
begin
  Result := 'null';
end;

constructor TJSONArray.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TJSONArray.Destroy;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TObject(FItems[I]).Free;
  FItems.Free;
  inherited Destroy;
end;

procedure TJSONArray.Add(AValue: TJSONValue);
begin
  FItems.Add(AValue);
end;

function TJSONArray.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TJSONArray.GetItem(AIndex: Integer): TJSONValue;
begin
  Result := TJSONValue(FItems[AIndex]);
end;

constructor TJSONObject.Create;
begin
  inherited Create;
  FNames := TStringList.Create;
  FValues := TList.Create;
end;

destructor TJSONObject.Destroy;
var
  I: Integer;
begin
  for I := 0 to FValues.Count - 1 do
    TObject(FValues[I]).Free;
  FValues.Free;
  FNames.Free;
  inherited Destroy;
end;

procedure TJSONObject.AddPair(const AName: string; AValue: TJSONValue);
begin
  FNames.Add(AName);
  FValues.Add(AValue);
end;

function TJSONObject.GetValue(const AName: string): TJSONValue;
var
  I: Integer;
begin
  { Member names are compared exactly; the first occurrence wins. }
  for I := 0 to FNames.Count - 1 do
    if FNames[I] = AName then
      Exit(TJSONValue(FValues[I]));
  Result := nil;
end;

function TJSONObject.GetString(const AName: string): string;
var
  Member: TJSONValue;
begin
  Member := GetValue(AName);
  if Member = nil then
    raise EJSONError.CreateFmt('JSON member "%s" not found.', [AName]);
  if not (Member is TJSONString) then
    raise EJSONError.CreateFmt('JSON member "%s" is not a string.', [AName]);
  Result := Member.Value;
end;

function TJSONObject.GetBoolean(const AName: string): Boolean;
var
  Member: TJSONValue;
begin
  Member := GetValue(AName);
  if Member = nil then
    raise EJSONError.CreateFmt('JSON member "%s" not found.', [AName]);
  if not (Member is TJSONBool) then
    raise EJSONError.CreateFmt('JSON member "%s" is not a boolean.', [AName]);
  Result := TJSONBool(Member).AsBoolean;
end;

function TJSONObject.TryGetString(const AName: string; out AValue: string): Boolean;
var
  Member: TJSONValue;
begin
  Member := GetValue(AName);
  Result := (Member <> nil) and (Member is TJSONString);
  if Result then
    AValue := Member.Value
  else
    AValue := '';
end;

{ ---------------------------------------------------------------------------
  Parser. Works on the UTF-16 form of the text; strict RFC 8259 grammar
  apart from accepting any whitespace the RFC allows between tokens.
  --------------------------------------------------------------------------- }

type
  TJsonParser = class
  private
    FText: UnicodeString;
    FPos: Integer;
    procedure Error(const AWhat: string);
    procedure SkipWhitespace;
    function Peek: WideChar;
    procedure Expect(ACh: WideChar);
    function ParseValue: TJSONValue;
    function ParseObject: TJSONObject;
    function ParseArray: TJSONArray;
    function ParseString: UnicodeString;
    function ParseNumber: TJSONNumber;
    function ParseLiteral: TJSONValue;
  public
    constructor Create(const AText: UnicodeString);
    function ParseDocument: TJSONValue;
  end;

constructor TJsonParser.Create(const AText: UnicodeString);
begin
  inherited Create;
  FText := AText;
  FPos := 1;
  { A byte order mark that survived the file decoding. }
  if (Length(FText) > 0) and (FText[1] = WideChar($FEFF)) then
    FPos := 2;
end;

procedure TJsonParser.Error(const AWhat: string);
begin
  raise EJSONError.CreateFmt('JSON syntax error at offset %d: %s', [FPos, AWhat]);
end;

procedure TJsonParser.SkipWhitespace;
begin
  while (FPos <= Length(FText)) and ((FText[FPos] = ' ') or (FText[FPos] = #9) or
    (FText[FPos] = #10) or (FText[FPos] = #13)) do
    Inc(FPos);
end;

function TJsonParser.Peek: WideChar;
begin
  if FPos > Length(FText) then
    Result := #0
  else
    Result := FText[FPos];
end;

procedure TJsonParser.Expect(ACh: WideChar);
begin
  if Peek <> ACh then
    Error('expected "' + string(UnicodeString(ACh)) + '"');
  Inc(FPos);
end;

function TJsonParser.ParseDocument: TJSONValue;
begin
  SkipWhitespace;
  Result := ParseValue;
  try
    SkipWhitespace;
    if FPos <= Length(FText) then
      Error('trailing text after the value');
  except
    Result.Free;
    raise;
  end;
end;

function TJsonParser.ParseValue: TJSONValue;
var
  Ch: WideChar;
begin
  SkipWhitespace;
  Ch := Peek;
  case Ch of
    '{': Result := ParseObject;
    '[': Result := ParseArray;
    '"': Result := TJSONString.Create(string(ParseString));
    '-', '0'..'9': Result := ParseNumber;
    't', 'f', 'n': Result := ParseLiteral;
  else
    Error('unexpected character');
    Result := nil;
  end;
end;

function TJsonParser.ParseObject: TJSONObject;
var
  Name: UnicodeString;
begin
  Expect('{');
  Result := TJSONObject.Create;
  try
    SkipWhitespace;
    if Peek = '}' then
    begin
      Inc(FPos);
      Exit;
    end;
    repeat
      SkipWhitespace;
      if Peek <> '"' then
        Error('expected a member name');
      Name := ParseString;
      SkipWhitespace;
      Expect(':');
      Result.AddPair(string(Name), ParseValue);
      SkipWhitespace;
      if Peek = ',' then
      begin
        Inc(FPos);
        Continue;
      end;
      Expect('}');
      Break;
    until False;
  except
    Result.Free;
    raise;
  end;
end;

function TJsonParser.ParseArray: TJSONArray;
begin
  Expect('[');
  Result := TJSONArray.Create;
  try
    SkipWhitespace;
    if Peek = ']' then
    begin
      Inc(FPos);
      Exit;
    end;
    repeat
      Result.Add(ParseValue);
      SkipWhitespace;
      if Peek = ',' then
      begin
        Inc(FPos);
        Continue;
      end;
      Expect(']');
      Break;
    until False;
  except
    Result.Free;
    raise;
  end;
end;

function HexValue(ACh: WideChar): Integer;
begin
  case ACh of
    '0'..'9': Result := Ord(ACh) - Ord('0');
    'a'..'f': Result := Ord(ACh) - Ord('a') + 10;
    'A'..'F': Result := Ord(ACh) - Ord('A') + 10;
  else
    Result := -1;
  end;
end;

function TJsonParser.ParseString: UnicodeString;
var
  Ch: WideChar;
  Code, I, Digit: Integer;
begin
  Expect('"');
  Result := '';
  repeat
    if FPos > Length(FText) then
      Error('unterminated string');
    Ch := FText[FPos];
    Inc(FPos);
    if Ch = '"' then
      Break;
    if Ord(Ch) < $20 then
      Error('control character in a string');
    if Ch <> '\' then
    begin
      Result := Result + Ch;
      Continue;
    end;
    if FPos > Length(FText) then
      Error('unterminated escape');
    Ch := FText[FPos];
    Inc(FPos);
    case Ch of
      '"', '\', '/': Result := Result + Ch;
      'b': Result := Result + WideChar(8);
      'f': Result := Result + WideChar(12);
      'n': Result := Result + WideChar(10);
      'r': Result := Result + WideChar(13);
      't': Result := Result + WideChar(9);
      'u':
        begin
          Code := 0;
          for I := 1 to 4 do
          begin
            if FPos > Length(FText) then
              Error('unterminated \u escape');
            Digit := HexValue(FText[FPos]);
            if Digit < 0 then
              Error('invalid \u escape');
            Code := Code * 16 + Digit;
            Inc(FPos);
          end;
          Result := Result + WideChar(Code);
        end;
    else
      Error('invalid escape');
    end;
  until False;
end;

function TJsonParser.ParseNumber: TJSONNumber;
var
  Start: Integer;

  procedure Digits;
  begin
    if not ((Peek >= '0') and (Peek <= '9')) then
      Error('digit expected');
    while (Peek >= '0') and (Peek <= '9') do
      Inc(FPos);
  end;

begin
  Start := FPos;
  if Peek = '-' then
    Inc(FPos);
  if Peek = '0' then
    Inc(FPos)
  else
    Digits;
  if Peek = '.' then
  begin
    Inc(FPos);
    Digits;
  end;
  if (Peek = 'e') or (Peek = 'E') then
  begin
    Inc(FPos);
    if (Peek = '+') or (Peek = '-') then
      Inc(FPos);
    Digits;
  end;
  Result := TJSONNumber.Create(string(Copy(FText, Start, FPos - Start)));
end;

function TJsonParser.ParseLiteral: TJSONValue;

  function Take(const AWord: UnicodeString): Boolean;
  begin
    Result := Copy(FText, FPos, Length(AWord)) = AWord;
    if Result then
      Inc(FPos, Length(AWord));
  end;

begin
  if Take('true') then
    Result := TJSONBool.Create(True)
  else if Take('false') then
    Result := TJSONBool.Create(False)
  else if Take('null') then
    Result := TJSONNull.Create
  else
  begin
    Error('unknown literal');
    Result := nil;
  end;
end;

class function TJSONObject.ParseJSONValue(const AText: string): TJSONValue;
var
  Parser: TJsonParser;
begin
  Parser := TJsonParser.Create(UnicodeString(AText));
  try
    try
      Result := Parser.ParseDocument;
    except
      on EJSONError do
        Result := nil;
    end;
  finally
    Parser.Free;
  end;
end;

{ ---------------------------------------------------------------------------
  Files and paths
  --------------------------------------------------------------------------- }

function ReadUtf8File(const AFileName: string): string;
var
  Stream: TFileStream;
  Bytes: TBytes;
  Start: Integer;
{$IFDEF FPC}
  Raw: RawByteString;
{$ENDIF}
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(Bytes, Stream.Size);
    if Length(Bytes) > 0 then
      Stream.ReadBuffer(Bytes[0], Length(Bytes));
  finally
    Stream.Free;
  end;
  Start := 0;
  if (Length(Bytes) >= 3) and (Bytes[0] = $EF) and (Bytes[1] = $BB) and (Bytes[2] = $BF) then
    Start := 3;
{$IFDEF FPC}
  SetLength(Raw, Length(Bytes) - Start);
  if Length(Raw) > 0 then
    Move(Bytes[Start], Raw[1], Length(Raw));
  SetCodePage(Raw, CP_UTF8, False);
  { The string contract of the test program is UTF-8 (see the runner). }
  Result := string(UTF8Decode(Raw));
{$ELSE}
  Result := TEncoding.UTF8.GetString(Bytes, Start, Length(Bytes) - Start);
{$ENDIF}
end;

function CombinePath(const ADirectory, AName: string): string;
begin
  Result := IncludeTrailingPathDelimiter(ADirectory) + AName;
end;

function ParentDirectory(const APath: string): string;
begin
  Result := ExtractFileDir(ExcludeTrailingPathDelimiter(APath));
  if Result = APath then
    Result := '';
end;

function FindTestDataFile(const AFileName: string): string;

  function SearchUpwards(const AStart: string): string;
  var
    BaseDir: string;
    I: Integer;
  begin
    BaseDir := ExcludeTrailingPathDelimiter(AStart);
    for I := 0 to 6 do
    begin
      Result := CombinePath(CombinePath(BaseDir, 'data'), AFileName);
      if FileExists(Result) then
        Exit;
      Result := CombinePath(CombinePath(CombinePath(BaseDir, 'tests'), 'data'), AFileName);
      if FileExists(Result) then
        Exit;
      BaseDir := ExcludeTrailingPathDelimiter(ParentDirectory(BaseDir));
      if BaseDir = '' then
        Break;
    end;
    Result := '';
  end;

begin
  Result := SearchUpwards(ExtractFilePath(ParamStr(0)));
  if Result = '' then
    Result := SearchUpwards(GetCurrentDir);
end;

end.
