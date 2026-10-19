unit LibPhoneNumber.Regex;

{
  Regular expression abstraction for the metadata driven core.

  Upstream libphonenumber evaluates its metadata patterns with two java.util
  .regex operations only:

    * Matcher.matches()   - the pattern must consume the whole input
                            (PhoneNumberDesc.nationalNumberPattern, and every
                            RegexBasedMatcher.matchNationalNumber call with
                            allowPrefixMatch = false)
    * Matcher.lookingAt() - the pattern must match a prefix of the input
                            (PhoneMetadata.leadingDigits in
                            getRegionCodeForNumberFromRegionList)

  The third operation is the one the format path needs:

    * Matcher.replaceAll() / Matcher.replaceFirst()
                          - every (respectively the first) non overlapping
                            match of an UNANCHORED pattern is replaced by a
                            template with $1..$n group references
                            (PhoneNumberUtil.formatNsnUsingPattern)

  The fourth and last one is needed by the AsYouTypeFormatter:

    * Matcher.find() / group()
                          - the leftmost match of an UNANCHORED pattern
                            anywhere in the input (TryFindFirst)

  This unit exposes exactly those operations plus a compile probe, so the
  interpreter in LibPhoneNumber.MetadataCore and the format engine in
  LibPhoneNumber.MetadataFormat never touch an engine type directly.

  Replacement semantics
  ---------------------
  The engines disagree about replacement templates: .NET understands $1, the
  braced group form, $&, $_ and $$ and silently keeps an unrecognised $ as a
  literal, TRegExpr brings a third dialect again, and java.util.regex throws on
  a $ that is not followed by a group number. Rather than hoping that all three
  agree on the metadata templates, the template is expanded HERE by
  ExpandJavaReplacement, a literal port of
  java.util.regex.Matcher.appendReplacement:

    \x   -> the literal character x
    $n   -> group n; digits are consumed greedily while the accumulated group
            number stays <= groupCount, so "$10" is group 1 followed by '0'
            when the pattern has fewer than ten groups
    a group that did not participate contributes the empty string

  The engines are therefore only used to FIND matches, never to build the
  result, which takes the replacement dialect off the risk list completely.

  Template contract (deliberately more lenient than java.util.regex)
  -----------------------------------------------------------------
  java.util.regex REJECTS a malformed replacement template at run time:
  Matcher.appendReplacement throws IndexOutOfBoundsException for a group
  reference the pattern has no group for, and IllegalArgumentException for a
  '$' that is not followed by a digit or for a trailing '\'. This unit throws
  in none of those cases and degrades instead:

    $n with n > groupCount   -> expands to nothing
    '$' not followed by a digit, including a trailing '$'
                             -> kept as a literal '$'
    trailing '\'             -> kept as a literal backslash

  That is a conscious contract, not an oversight. Every template the metadata
  path feeds in comes from the generated tables and is well formed by
  construction, and the one public API that accepts a caller written template -
  FormatByPattern - is documented as non throwing like the rest of
  this port. A malformed user template therefore produces a visibly odd string
  instead of an exception in the middle of formatting. The three cases are
  pinned by ReplaceAll_IsLenientAboutMalformedTemplates.

  Empty pattern
  -------------
  An empty PATTERN is a no-op by contract: ReplaceAll and ReplaceFirst return
  the input unchanged. java.util.regex disagrees - an empty pattern matches
  zero width at every position there, so replaceAll would sprinkle the template
  between all characters. No pattern of the pinned baseline is empty and the
  format engine never builds one, so the shortcut is kept and pinned by
  ReplaceAll_TreatsAnEmptyPatternAsANoOp rather than made Java exact.

  Engines
  -------
  Delphi : System.RegularExpressions (TRegEx, PCRE).
  FPC    : the regexpr unit of the FreePascal distribution (TRegExpr).

  Both engines understand \A (start of input). The end of input anchor differs:
  PCRE has \z, the TRegExpr of FreePascal 3.2.2 (regexpr 0.987) does not - it
  reads \z as a literal 'z' - while '$' of every TRegExpr version matches at
  the very end of the input only, with no trailing newline tolerance, as long
  as ModifierM is off. So the wrapping is:

    matches()   ->  \A(?:<pattern>)\z     (Delphi)
                    \A(?:<pattern>)$      (FreePascal, ModifierM = False)
    lookingAt() ->  \A(?:<pattern>)

  An EMPTY input is decided by a probe on regexpr 0.987 (EmptyInputMatches,
  which also lists the two pattern shapes that probe answers wrongly: a
  '(?-m)' group and a '(?#...)' comment containing '[' before '\A' - neither
  occurs in any metadata pattern; KNOWN_ISSUES.md, permanent item 8).

  Wrapping in a non capturing group is required: without it an alternation at
  the top level of an upstream pattern - which is the most common shape of a
  nationalNumberPattern - would bind the anchors to the first respectively the
  last branch only.

  RISK - FPC regex dialect
  ------------------------
  The generator side dialect gate (tools/generate_metadata.ps1) and the Delphi
  run of the dialect test only prove that every upstream pattern compiles for
  .NET regex and for the Delphi engine. TRegExpr is a different implementation with a
  smaller feature set; upstream metadata patterns currently use only literals,
  character classes, bounded quantifiers, alternation and non capturing groups,
  all of which TRegExpr supports. The FreePascal RUNTIME gate
  (tools/run_fpc_runtime_check.ps1) enforces that: it compiles every pattern
  of the four data sets through TryCompilePattern and runs the whole metadata
  path - validation, typing, every formatter, the national prefix stripping,
  the AsYouTypeFormatter - on a FreePascal build, comparing the result byte
  for byte with the Delphi build. It is what found the \z gap above and the
  counted quantifier defect of regexpr 0.987 (see ExpandCountedQuantifiers).
  Only that engine sees rewritten patterns; regexpr 1.x compiles the metadata
  patterns as they are.

  Threading
  ---------
  Compiled patterns are cached in a process wide open addressing hash table.
  Neither TRegEx (which keeps its subject and match state inside the shared
  TPerlRegEx instance) nor TRegExpr is safe for concurrent matching, so one
  critical section guards cache lookup and match execution together. That is
  deliberately coarse: the pattern cache is the optimisation this layer needs,
  per match parallelism is not a requirement of the core.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

type
  { Result of a prefix match that also reports the match end and the capturing
    groups, i.e. everything the parsing helpers of PhoneNumberUtil read off a
    java.util.regex Matcher after lookingAt():

      MatchEnd     -> Matcher.end()   (1 based index of the first character
                                       AFTER the match, Delphi string indexing)
      GroupCount   -> Matcher.groupCount()
      GroupMatched -> Matcher.group(i) != null
      GroupValue   -> Matcher.group(i)

    Index 0 is the whole match and is always "matched", exactly like Java's
    group(0).

    GroupCount is counted from the PATTERN, not from the engine result, because
    neither engine reports the static group count of a pattern reliably: PCRE
    (and therefore TRegEx) reports only the highest group that actually
    participated, so a trailing non participating group would silently lower
    the count and change the meaning of Java's group(groupCount()) test.

    Group participation is derived from the group LENGTH being greater than
    zero. PCRE maps the "not set" offset pair (-1/-1) onto index 1/length 0,
    which is indistinguishable from a group that matched the empty string at
    the start of the input; no capturing group of an upstream
    nationalPrefixForParsing pattern can match empty, which is what makes the
    equivalence safe (asserted by the metadata test suite).

    There is deliberately no Success field: whether the prefix matched is the
    RESULT of TryMatchPrefixEx, and the record is only meaningful when that
    result is True. A second field would only be a redundant source of the
    same truth. }
  TRegexPrefixMatch = record
    MatchEnd: Integer;
    GroupCount: Integer;
    GroupMatched: array of Boolean;
    GroupValue: array of string;
  end;

{ Java Matcher.matches(): APattern must match AInput completely. }
function TryMatchFull(const APattern, AInput: string): Boolean;

{ Java Matcher.lookingAt(): APattern must match a prefix of AInput. }
function TryMatchPrefix(const APattern, AInput: string): Boolean;

{ Java Matcher.lookingAt() plus the match end and the capturing groups. }
function TryMatchPrefixEx(const APattern, AInput: string;
  out AMatch: TRegexPrefixMatch): Boolean;

{ Java Matcher.find() followed by Matcher.group(): the leftmost match of the
  UNANCHORED APattern anywhere in AInput.

  For a caller that cannot use the anchored operations
  above: AsYouTypeFormatter.getFormattingTemplate runs a numberFormat pattern
  against the constant "999999999999999" and keeps the matched RUN, which is
  shorter than the input by construction.

  AMatchStart is the 1 based index of the first character of the match and is
  0 when there is none, so the caller can reproduce Java's Matcher.start(). }
function TryFindFirst(const APattern, AInput: string; out AMatchValue: string;
  out AMatchStart: Integer): Boolean;

{ Java Matcher.replaceAll(): every non overlapping match of APattern in AInput
  is replaced by ATemplate, which is expanded with Java replacement semantics
  (see the header). APattern is used UNANCHORED, exactly like the Matcher.find()
  loop behind Java's replaceAll.

  Contract limits, both documented in the unit header: a malformed ATemplate
  degrades instead of raising, and an EMPTY APattern is a no-op that returns
  AInput unchanged (java.util.regex would match zero width everywhere). }
function ReplaceAll(const APattern, AInput, ATemplate: string): string;

{ Java Matcher.replaceFirst(): as ReplaceAll, but only the first match is
  replaced. }
function ReplaceFirst(const APattern, AInput, ATemplate: string): string;

{ Number of capturing groups in APattern, i.e. java.util.regex
  Matcher.groupCount(). Counts '(' that does not start with '(?', ignores
  escaped parentheses and everything inside a character class. }
function CountCapturingGroups(const APattern: string): Integer;

{ Java Matcher.appendReplacement's template handling, applied to a match that
  the caller already has: AGroupValue[0] is the whole match, AGroupValue[i] the
  i-th capturing group, and a group that did not participate must be passed as
  an empty string (which is what Java appends for a null group).

  Exported because ReplaceAll/ReplaceFirst are not the only places a Java
  replacement template has to be expanded: the national prefix step of the
  parser (MaybeStripNationalPrefixAndCarrierCode) expands the
  nationalPrefixTransformRule against a prefix match it already ran, which is
  the replacement half of the Matcher.replaceFirst upstream calls there. Having
  ONE implementation of the template grammar is the point - a second one would
  be a second dialect to keep in step.

  The template contract is the deliberately lenient one documented in the unit
  header: no exception on a malformed template. }
function ExpandJavaReplacement(const ATemplate: string;
  const AGroupValue: array of string; AGroupCount: Integer): string;

const
  { Upper bound, in characters, of a rewritten pattern; see
    ExpandCountedQuantifiers. }
  ExpansionBudget = 32768;

{ The counted quantifier rewrite the FreePascal engine applies for a regexpr
  older than 1.0 (FreePascal 3.2.2), see the block comment in the
  implementation. AExpanded receives the equivalent pattern without counted
  quantifiers; False means the rewrite would exceed ExpansionBudget, and
  AExpanded is then APattern unchanged, which is what gets compiled.

  Exported, and compiled on every compiler, for the FreePascal runtime gate
  only: it matches every metadata pattern both as given and rewritten, so the
  rewrite is verified on every engine and not just on the one that needs it.
  Nothing in the port calls it outside the regexpr 0.987 path. }
function ExpandCountedQuantifiers(const APattern: string;
  out AExpanded: string): Boolean;

{ Compiles APattern through the cache and reports a compile failure instead of
  raising. Like every operation of this unit it also rejects a pattern that is
  only valid inside the wrapping (see ValidateUnwrapped). Used by the dialect
  gates of the test suite and by the compile-first step of
  TPhoneNumberUtil.MaybeStripInternationalPrefixAndNormalize. }
function TryCompilePattern(const APattern: string; out AError: string): Boolean;

{ Diagnostics. }
function CachedPatternCount: Integer;
procedure ClearPatternCache;

implementation

uses
{$IFDEF FPC}
  SysUtils,
  SyncObjs,
  RegExpr;
{$ELSE}
  System.SysUtils,
  System.SyncObjs,
  System.RegularExpressions;
{$ENDIF}

type
  TPatternCacheEntry = record
    Key: string;
    Used: Boolean;
  {$IFDEF FPC}
    Expr: TRegExpr;
  {$ELSE}
    Expr: TRegEx;
  {$ENDIF}
  end;

  TPatternCacheEntries = array of TPatternCacheEntry;

const
  InitialCapacity = 512;

var
  GEntries: TPatternCacheEntries;
  GCount: Integer;
  GLock: TCriticalSection;

function WrapFull(const APattern: string): string;
begin
{$IFDEF FPC}
  { '$', not '\z': the TRegExpr of FreePascal 3.2.2 (regexpr 0.987) does not
    know \z and matches it as a literal 'z', so every full match failed there.
    With ModifierM = False (see AcquireIndex) '$' of every TRegExpr version
    matches at the very end of the input only - no trailing line break is
    tolerated - which is exactly the \z semantics Java's matches() needs.
    Found by the FreePascal runtime gate (tools/run_fpc_runtime_check.ps1). }
  Result := '\A(?:' + APattern + ')$';
{$ELSE}
  Result := '\A(?:' + APattern + ')\z';
{$ENDIF}
end;

function WrapPrefix(const APattern: string): string;
begin
  Result := '\A(?:' + APattern + ')';
end;

{ Unanchored wrapping for the replace operations. The non capturing group is
  semantically neutral for a find() loop - it changes neither the matches nor
  the capturing group numbering - but it keeps the cache key of a raw pattern
  distinct from the anchored spellings of the very same pattern. }
function WrapRaw(const APattern: string): string;
begin
  Result := '(?:' + APattern + ')';
end;

{ FNV-1a. Implemented locally so Delphi and FreePascal agree bit for bit.

  This is the ONLY routine of the unit that relies on wrapping arithmetic: the
  FNV prime multiplication overflows 32 bits by design. Overflow and range
  checking are therefore switched off around this function alone and restored
  to whatever the project had afterwards, so both checks stay armed for the
  cache bookkeeping and the match routines. The IFOPT directive is the
  portable way to read the current setting; Delphi has no PUSH/POP pair for
  switches. }
{$IFOPT Q+}{$DEFINE PN_REGEX_OVERFLOW_WAS_ON}{$ENDIF}
{$IFOPT R+}{$DEFINE PN_REGEX_RANGE_WAS_ON}{$ENDIF}
{$Q-}
{$R-}
function HashKey(const AKey: string): Cardinal;
var
  I: Integer;
begin
  Result := Cardinal(2166136261);
  for I := 1 to Length(AKey) do
  begin
    Result := Result xor Cardinal(Ord(AKey[I]));
    Result := Result * Cardinal(16777619);
  end;
end;
{$IFDEF PN_REGEX_OVERFLOW_WAS_ON}{$Q+}{$UNDEF PN_REGEX_OVERFLOW_WAS_ON}{$ENDIF}
{$IFDEF PN_REGEX_RANGE_WAS_ON}{$R+}{$UNDEF PN_REGEX_RANGE_WAS_ON}{$ENDIF}

{ Returns the slot holding AKey, or the free slot where it belongs. The table
  is never allowed to fill up completely, so the probe loop always terminates. }
function FindSlot(const AKey: string): Integer;
var
  Mask: Integer;
  Index: Integer;
begin
  Mask := Length(GEntries) - 1;
  Index := Integer(HashKey(AKey) and Cardinal(Mask));
  while GEntries[Index].Used do
  begin
    if GEntries[Index].Key = AKey then
    begin
      Result := Index;
      Exit;
    end;
    Index := (Index + 1) and Mask;
  end;
  Result := Index;
end;

procedure GrowTable;
var
  Old: TPatternCacheEntries;
  I, Slot: Integer;
begin
  Old := GEntries;
  GEntries := nil;
  if Length(Old) = 0 then
    SetLength(GEntries, InitialCapacity)
  else
    SetLength(GEntries, Length(Old) * 2);
  for I := 0 to Length(Old) - 1 do
  begin
    if not Old[I].Used then
      Continue;
    Slot := FindSlot(Old[I].Key);
    GEntries[Slot] := Old[I];
  end;
end;

(* ------------------------------------------------------------------
  Counted quantifier expansion for regexpr 0.987 (FreePascal 3.2.2).

  The TRegExpr that ships with FreePascal 3.2.2 evaluates COUNTED quantifiers
  wrongly in several shapes the metadata uses all the time, e.g.

    (\d{3})(\d{3})              on 712345 -> group 1 = 712345, group 2 = ''
    (?:0[1-9]|[1589]\d)\d{4}    on 542011 -> matches '54' only

  while the same expressions with the repetition written out are answered
  correctly. The regexpr of FreePascal 3.2.4 (1.182) and later has no such
  defect. Found by the FreePascal runtime gate
  (tools/run_fpc_runtime_check.ps1), whose 3.2.2 run failed on more than half
  of the example numbers before this rewrite.

  For an engine older than 1.0 every counted quantifier is therefore rewritten
  into the equivalent plain form before the expression is compiled:

    A{n}      ->  A A ... A                          (n copies)
    A{n,}     ->  A ... A A*                         (n copies, then A starred)
    A{n,m}    ->  A ... A (?:A(?:A ...)?)?           (n copies, then m - n
                                                       nested optional copies)

  and a trailing '?' (reluctant) turns every optional part reluctant as well.
  Nested optional copies are what a backtracking engine does with A{n,m}
  anyway - the greedy form tries the longest run first and gives one copy back
  at a time - so the rewrite does not change which match is found.

  A is one ATOM, scanned completely before a quantifier is looked for:

    an escape     \x{...}, \xHH, \uHHHH, \cX, \p{...} / \P{...}, \pL / \PL,
                  \0 plus up to three octal digits, and otherwise a backslash
                  plus ONE character (which covers \d, \s, the single digit
                  back references \1..\9 regexpr 0.987 knows, and every
                  escaped literal). regexpr 0.987 itself understands \x{...},
                  \xHH, \cX and the single digit back references; the other
                  forms are scanned whole anyway so that a quantifier behind
                  them is never split off the middle of an escape.
    a class       '[' with an optional '^', an optional literal ']' right
                  after that, then everything up to the closing ']', escapes
                  inside it scanned as above. Nested classes and the Java
                  intersection syntax are not supported by TRegExpr at all.
    a group       '(' up to its matching ')', with the same class and escape
                  scanner inside, so a ')' in a class or an escaped ')' does
                  not close it; the body is expanded recursively.
    otherwise     a single character.

  Two shapes are deliberately left alone, because copying them would change
  the meaning: an atom that contains a CAPTURING group (a copy would add
  groups and shift the numbering $1..$n refers to) and a possessive '+'
  suffix. Neither occurs in the pinned metadata.

  Size budget. The expansion is capped at ExpansionBudget characters for the
  whole pattern, nested repetition included (every intermediate result is
  checked BEFORE it is built, so a pattern such as a ten thousand fold
  repetition of a ten thousand fold one never allocates more than the
  budget). Over budget the function answers False and the caller compiles the
  ORIGINAL pattern. Not failing the compile is deliberate: such a pattern is
  valid for java.util.regex and for every other engine of this port, and
  turning it into a compile error on exactly one engine would be a new
  failure mode; compiling it unrewritten degrades no further than having no
  workaround at all. Metadata patterns stay far below the budget, which the
  runtime gate asserts (its summary carries the longest expansion and the
  number of metadata patterns over budget, which must be zero).

  The function is plain string processing and compiles on every compiler, so
  the runtime gate exercises it on Delphi and on every FreePascal - matching
  both the original and the rewritten pattern - and not only on the one
  engine that needs it.
  ------------------------------------------------------------------ *)

{ Index of the first character AFTER the escape whose backslash is at
  AIndex. }
function ScanEscapeEnd(const APattern: string; AIndex: Integer): Integer;
var
  Len, J, Digits: Integer;

  function IsHex(ACh: Char): Boolean;
  begin
    Result := ((ACh >= '0') and (ACh <= '9')) or ((ACh >= 'a') and (ACh <= 'f'))
      or ((ACh >= 'A') and (ACh <= 'F'));
  end;

  function SkipBraces(AFrom: Integer): Integer;
  begin
    (* AFrom is the index of the opening brace; answers the index after the
       closing one, or the end of the pattern when there is none. *)
    Result := AFrom;
    while (Result <= Len) and (APattern[Result] <> '}') do
      Inc(Result);
    if Result <= Len then
      Inc(Result);
  end;

begin
  Len := Length(APattern);
  J := AIndex + 1;
  if J > Len then
  begin
    Result := J;
    Exit;
  end;
  case APattern[J] of
    'x':
      if (J + 1 <= Len) and (APattern[J + 1] = '{') then
        Result := SkipBraces(J + 1)
      else
      begin
        Result := J + 1;
        Digits := 0;
        while (Result <= Len) and (Digits < 2) and IsHex(APattern[Result]) do
        begin
          Inc(Result);
          Inc(Digits);
        end;
      end;
    'u':
      begin
        Result := J + 1;
        Digits := 0;
        while (Result <= Len) and (Digits < 4) and IsHex(APattern[Result]) do
        begin
          Inc(Result);
          Inc(Digits);
        end;
      end;
    'p', 'P':
      if (J + 1 <= Len) and (APattern[J + 1] = '{') then
        Result := SkipBraces(J + 1)
      else
        Result := J + 2;
    'c':
      Result := J + 2;
    '0':
      begin
        Result := J + 1;
        Digits := 0;
        while (Result <= Len) and (Digits < 3) and (APattern[Result] >= '0')
          and (APattern[Result] <= '7') do
        begin
          Inc(Result);
          Inc(Digits);
        end;
      end;
  else
    Result := J + 1;
  end;
  if Result > Len + 1 then
    Result := Len + 1;
end;

{ Index of the first character AFTER the class whose '[' is at AIndex. }
function ScanClassEnd(const APattern: string; AIndex: Integer): Integer;
var
  Len, J: Integer;
begin
  Len := Length(APattern);
  J := AIndex + 1;
  if (J <= Len) and (APattern[J] = '^') then
    Inc(J);
  if (J <= Len) and (APattern[J] = ']') then
    Inc(J);
  while (J <= Len) and (APattern[J] <> ']') do
    if APattern[J] = '\' then
      J := ScanEscapeEnd(APattern, J)
    else
      Inc(J);
  Result := J + 1;
  if Result > Len + 1 then
    Result := Len + 1;
end;

{ Index of the first character AFTER the atom that starts at AIndex. }
function FindAtomEnd(const APattern: string; AIndex: Integer): Integer;
var
  Len, J, Depth: Integer;
begin
  Len := Length(APattern);
  case APattern[AIndex] of
    '\':
      Result := ScanEscapeEnd(APattern, AIndex);
    '[':
      Result := ScanClassEnd(APattern, AIndex);
    '(':
      begin
        Depth := 0;
        J := AIndex;
        Result := Len + 1;
        while J <= Len do
          case APattern[J] of
            '\':
              J := ScanEscapeEnd(APattern, J);
            '[':
              J := ScanClassEnd(APattern, J);
            '(':
              begin
                Inc(Depth);
                Inc(J);
              end;
            ')':
              begin
                Dec(Depth);
                Inc(J);
                if Depth = 0 then
                begin
                  Result := J;
                  Break;
                end;
              end;
          else
            Inc(J);
          end;
      end;
  else
    Result := AIndex + 1;
  end;
  if Result > Len + 1 then
    Result := Len + 1;
end;

{ Parses a counted quantifier at AIndex. AMax = -1 means "no upper bound".
  A bound above ExpansionBudget is clamped to ExpansionBudget + 1, which is
  over budget for any atom, so a huge number can neither overflow the
  conversion nor be expanded. }
function TryParseCountedQuantifier(const APattern: string; AIndex: Integer;
  out AMin, AMax, AEnd: Integer): Boolean;

  function ReadNumber(var AJ: Integer; out AValue: Integer): Boolean;
  var
    Start: Integer;
  begin
    Start := AJ;
    AValue := 0;
    while (AJ <= Length(APattern)) and (APattern[AJ] >= '0')
      and (APattern[AJ] <= '9') do
    begin
      if AValue <= ExpansionBudget then
        AValue := AValue * 10 + (Ord(APattern[AJ]) - Ord('0'));
      Inc(AJ);
    end;
    if AValue > ExpansionBudget then
      AValue := ExpansionBudget + 1;
    Result := AJ > Start;
  end;

var
  Len, J: Integer;
begin
  Result := False;
  AMin := 0;
  AMax := 0;
  AEnd := AIndex;
  Len := Length(APattern);
  if (AIndex > Len) or (APattern[AIndex] <> '{') then
    Exit;
  J := AIndex + 1;
  if not ReadNumber(J, AMin) then
    Exit;
  if (J <= Len) and (APattern[J] = '}') then
  begin
    AMax := AMin;
    AEnd := J + 1;
    Result := True;
    Exit;
  end;
  if (J > Len) or (APattern[J] <> ',') then
    Exit;
  Inc(J);
  if not ReadNumber(J, AMax) then
    AMax := -1;
  if (J > Len) or (APattern[J] <> '}') then
    Exit;
  AEnd := J + 1;
  Result := (AMax = -1) or (AMax >= AMin);
end;

{ The recursive worker. False as soon as the result would exceed ABudget
  characters; nothing larger than the budget is ever built. }
function ExpandWithin(const APattern: string; ABudget: Integer;
  out AResult: string): Boolean;
var
  I, AtomEnd, PrefixLen, MinCount, MaxCount, QuantEnd, K: Integer;
  Atom, Original, Body, Optional, Lazy: string;
  Size: Int64;
begin
  AResult := '';
  Result := False;
  I := 1;
  while I <= Length(APattern) do
  begin
    AtomEnd := FindAtomEnd(APattern, I);
    Original := Copy(APattern, I, AtomEnd - I);
    Atom := Original;
    if (APattern[I] = '(') and (AtomEnd - I >= 2)
      and (APattern[AtomEnd - 1] = ')') then
    begin
      { Keep the group opener - '(', '(?:', '(?=', '(?!', '(?<=', '(?<!' - and
        expand the body. }
      PrefixLen := 1;
      if (I + 1 <= Length(APattern)) and (APattern[I + 1] = '?') then
      begin
        PrefixLen := 3;
        if (I + 2 <= Length(APattern)) and (APattern[I + 2] = '<') then
          PrefixLen := 4;
      end;
      if not ExpandWithin(Copy(APattern, I + PrefixLen,
        AtomEnd - 1 - (I + PrefixLen)), ABudget, Body) then
        Exit;
      Atom := Copy(APattern, I, PrefixLen) + Body + ')';
    end;

    { Alternation and anchors are never repeated. }
    if (Original = '|') or (Original = '^') or (Original = '$')
      or not TryParseCountedQuantifier(APattern, AtomEnd, MinCount, MaxCount,
        QuantEnd) then
    begin
      if Length(AResult) + Length(Atom) > ABudget then
        Exit;
      AResult := AResult + Atom;
      I := AtomEnd;
      Continue;
    end;

    Lazy := '';
    if (QuantEnd <= Length(APattern)) and (APattern[QuantEnd] = '?') then
    begin
      Lazy := '?';
      Inc(QuantEnd);
    end;

    if ((QuantEnd <= Length(APattern)) and (APattern[QuantEnd] = '+'))
      or (CountCapturingGroups(Original) > 0) then
    begin
      { See the block comment: copying would change the meaning. }
      Body := Atom + Copy(APattern, AtomEnd, QuantEnd - AtomEnd);
      if Length(AResult) + Length(Body) > ABudget then
        Exit;
      AResult := AResult + Body;
      I := QuantEnd;
      Continue;
    end;

    { Size of what this quantifier produces, computed before it is built. }
    if MaxCount = -1 then
      Size := Int64(MinCount + 1) * Length(Atom) + 1 + Length(Lazy)
    else
      Size := Int64(MinCount) * Length(Atom)
        + Int64(MaxCount - MinCount) * (Length(Atom) + 5 + Length(Lazy));
    if Length(AResult) + Size > ABudget then
      Exit;

    for K := 1 to MinCount do
      AResult := AResult + Atom;
    if MaxCount = -1 then
      AResult := AResult + Atom + '*' + Lazy
    else
    begin
      Optional := '';
      for K := 1 to MaxCount - MinCount do
        Optional := '(?:' + Atom + Optional + ')?' + Lazy;
      AResult := AResult + Optional;
    end;
    I := QuantEnd;
  end;
  Result := True;
end;

function ExpandCountedQuantifiers(const APattern: string;
  out AExpanded: string): Boolean;
begin
  Result := ExpandWithin(APattern, ExpansionBudget, AExpanded);
  if not Result then
    AExpanded := APattern;
end;

(* Compiles the caller's pattern ON ITS OWN, unwrapped, and discards the
  result; raises the engine's compile error exactly like AcquireIndex does
  for the wrapped spelling. The wrapping ('\A(?:' + p + ')...') is not
  neutral for a malformed pattern: one that closes the wrapping group early
  and opens a new one, e.g. ')|(' or 'a)|(b', is rejected by
  java.util.regex.Pattern.compile but becomes the VALID '\A(?:)|()\z'. Every
  first compile of a cache entry runs this check, so every operation and
  TryCompilePattern reject such a pattern like any other compile error.
  Never called with an empty pattern: every operation and TryCompilePattern
  handle '' before they compile anything.

  Below regexpr 1.0 (FreePascal 3.2.2) the check follows the counted
  quantifier rewrite decision of the WRAPPED compile it guards
  (AExpandLikeWrapped = the wrapped spelling was rewritten), because both
  simpler rules are wrong on that engine:

  1. Compiling the pattern as written crashes regexpr 0.987 for a nested
     counted quantifier: '(?:a{2}){2}' raises an access violation inside
     TRegExpr.Compile. The wrapped spelling of such a pattern is rewritten
     and never reaches the engine in that form.
  2. Rewriting the unwrapped pattern independently disagrees with the
     wrapped compile. The budget decision can differ - '(?:a){6553}' fits
     ExpansionBudget unwrapped but not in any wrapping, and its rewrite has
     6553 groups, over the NSUBEXP limit (90) of the engine - and 'a{0}'
     rewrites to the empty expression, which TRegExpr refuses
     (reeNoExpression).

  So: when the wrapped spelling was compiled as written, the pattern is
  compiled as written, and it has one group fewer than that spelling. When
  the wrapped spelling was rewritten, the pattern is rewritten too.

  What makes the two decisions agree: APattern is the text the wrapper puts
  between '(?:' and ')' VERBATIM - the caller's pattern for WrapFull,
  WrapPrefix and WrapRaw, and the \A -> ^ rewritten pattern for the empty
  input probe, which therefore passes that rewritten text here. When the
  group scan of the rewrite finds the wrapper's own ')' as the partner of
  its '(?:' - true for every well formed pattern built from the atoms the
  rewrite scans (escapes, classes, groups; see the block comment above
  ExpandCountedQuantifiers) - the body is rewritten by the same function with the same
  budget, so the rewritten wrapped spelling is exactly prefix + rewrite of
  APattern + suffix: the rewrite of APattern then fits the budget whenever
  the wrapped one does, and it has no more groups. Only a pattern on which
  that scan pairs differently can rewrite differently: a malformed one (a
  breakout, an unterminated class, a trailing backslash), which is then
  rejected, and a construct the scan does not model, such as a '(' inside
  an '(?x)' comment - a known limitation, see KNOWN_ISSUES.md, permanent
  item 9. An EMPTY rewrite is accepted without a compile: it
  means every atom carries a zero count quantifier, and a breakout pattern
  cannot rewrite to nothing, because the unmatched '(' it needs to rebalance
  the wrapping scans as one atom up to the end of the pattern, with no
  quantifier behind it, and is copied. *)
procedure ValidateUnwrapped(const APattern: string;
  AExpandLikeWrapped: Boolean);
{$IFDEF FPC}
var
  Expr: TRegExpr;
  Text: string;
begin
  Text := APattern;
  if (TRegExpr.VersionMajor < 1) and AExpandLikeWrapped then
  begin
    if not ExpandWithin(APattern, ExpansionBudget, Text) then
      Text := APattern
    else if Text = '' then
      Exit;
  end;
  Expr := TRegExpr.Create;
  try
    Expr.ModifierM := False;
    Expr.Expression := RegExprString(Text);
    Expr.Compile;
  finally
    Expr.Free;
  end;
end;
{$ELSE}
var
  Expr: TRegEx;
begin
  Expr := TRegEx.Create(APattern, []);
  { TRegEx compiles lazily; see AcquireIndex. }
  Expr.IsMatch('');
end;
{$ENDIF}

{ Caller must hold GLock. AMultiLine is for the empty input probe of
  regexpr 0.987 only (EmptyInputMatches); every other caller compiles with
  java.util.regex defaults.

  AWrapped is the cache key and the expression that is compiled; ARaw is the
  caller's pattern it was built from, validated on its own on a cache miss
  (ValidateUnwrapped). }
function AcquireIndex(const AWrapped, ARaw: string;
  AMultiLine: Boolean = False): Integer;
{$IFDEF FPC}
var
  Expr: TRegExpr;
  Expanded: string;
  Rewritten: Boolean;
{$ELSE}
var
  Expr: TRegEx;
{$ENDIF}
begin
  { Keep the load factor at 3/4 so linear probing stays cheap. }
  if (GCount + 1) * 4 >= Length(GEntries) * 3 then
    GrowTable;

  Result := FindSlot(AWrapped);
  if GEntries[Result].Used then
    Exit;

  { Before anything is stored: a failure leaves the table untouched. }
{$IFDEF FPC}
  { The rewrite decision of the wrapped spelling (see ValidateUnwrapped);
    over budget, ExpandCountedQuantifiers hands back AWrapped itself. }
  Rewritten := (TRegExpr.VersionMajor < 1)
    and ExpandCountedQuantifiers(AWrapped, Expanded);
  ValidateUnwrapped(ARaw, Rewritten);
{$ELSE}
  ValidateUnwrapped(ARaw, False);
{$ENDIF}

  { Store the key BEFORE compiling. Assigning a string is the only other step
    here that can raise (out of memory), and the FreePascal cleanup pass only
    frees slots marked Used; a compiled expression parked in a slot whose key
    assignment then failed would leak. With this order a failure can leave at
    most a stale key in an unused slot, which the next insert overwrites. }
  GEntries[Result].Key := AWrapped;

{$IFDEF FPC}
  Expr := TRegExpr.Create;
  try
    { Upstream compiles with java.util.regex defaults: no multiline, no case
      folding. ModifierM = False is LOAD BEARING here: WrapFull ends a full
      match with '$' on FreePascal (see there), and only without multiline
      mode does '$' mean "end of input" rather than "end of any line". }
    Expr.ModifierM := AMultiLine;
    { RegExprString is AnsiString or UnicodeString depending on how the FPC
      distribution compiled the regexpr unit; the explicit cast keeps both
      configurations warning free. Metadata patterns are pure ASCII.
      The cache stays keyed by the pattern as given; only the engine sees the
      expanded form of a pre 1.0 regexpr (see ExpandCountedQuantifiers). }
    { Expanded was computed above: the rewritten spelling, or AWrapped
      itself over budget. }
    if TRegExpr.VersionMajor < 1 then
      Expr.Expression := RegExprString(Expanded)
    else
      Expr.Expression := RegExprString(AWrapped);
    Expr.Compile;
  except
    Expr.Free;
    raise;
  end;
{$ELSE}
  { Empty option set on purpose: java.util.regex compiles with no flags, and in
    particular an input that the pattern can match as the empty string must
    match (Matcher.matches() accepts it). Relying on the single argument
    constructor would leave the engine defaults - roNotEmpty among them - in
    charge, which deviates from Java for such patterns. }
  Expr := TRegEx.Create(AWrapped, []);
  { TRegEx compiles lazily; force it now so a bad pattern fails here and not
    on some later match. }
  Expr.IsMatch('');
{$ENDIF}

  GEntries[Result].Expr := Expr;
  GEntries[Result].Used := True;
  Inc(GCount);
end;

{$IFDEF FPC}
{ The empty input on regexpr 0.987 (the TRegExpr of FreePascal 3.2.2).

  That engine answers False for an EMPTY input before it looks at the pattern
  (TRegExpr.ExecPrim: "if fInputString = '' then Exit"). java.util.regex -
  like PCRE and regexpr 1.x - matches a pattern that can match the empty
  string against "": Matcher.matches(), lookingAt() and find() all succeed
  with the zero length match at offset 0. On an empty input that is the only
  possible match for every operation of this unit, so the question is only
  whether the pattern can match the empty string.

  It is asked at the END of the one character input #10, with the match
  started there (ExecPos(2), which 0.987 allows: "for matching empty string
  after last char") and the pattern compiled in multi line mode as
  ^(?:<pattern>)$. At that position the rest of the input is empty, '^' and
  '$' both match (after a line break, at the end), '\b' fails and '\B'
  succeeds - exactly as at offset 0 of an empty input. The one anchor that
  cannot match there is '\A', so every '\A' of the pattern outside a
  character class is rewritten to '^' for the probe (RewriteStartAnchors).
  regexpr 0.987 has no lookahead or lookbehind, so no other construct can
  see the line break. Its '\Z' is an end anchor (OP_EOL, like '$') and
  answers at the probe position as on an empty input; its '\z' is not an
  anchor at all but the literal letter (see WrapFull), on an empty input as
  everywhere else. An earlier probe that put a sentinel character AFTER the
  pattern got every end anchor inside the pattern wrong ('a*$', '(?:x|$)').

  Known limitation, deliberately not rewritten for this legacy engine: two
  shapes still answer differently on an EMPTY input. (1) An inline modifier
  group that switches multi line mode OFF, e.g. '(?-m)^$' or '(?-m)\A',
  answers False instead of True, because the probe relies on multi line '^'.
  (2) A '(?#...)' comment containing '[' in front of a '\A' leaves
  RewriteStartAnchors in its character class state, so that '\A' is not
  rewritten and the probe answers False. '(?#...)' is not java.util.regex
  syntax, so (2) is outside the contract of a port of Java patterns anyway.
  No metadata pattern contains either shape; only a caller supplied pattern,
  on FreePascal 3.2.2 (regexpr below 1.0), with an empty input can hit them.

  Found by the FreePascal run of the test suite (MetadataCore
  EmptyInput_MatchesAPatternThatAllowsIt) on FPC 3.2.2; regexpr 1.x needs no
  detour and does not take it. }
function NeedsEmptyInputProbe(const AInput: string): Boolean;
begin
  Result := (AInput = '') and (TRegExpr.VersionMajor < 1);
end;

{ '\A' outside a character class becomes '^'; everything else, escapes and
  classes included, is copied unchanged. A ']' right after '[' or '[^' is a
  literal member of the class, as in every regex dialect. }
function RewriteStartAnchors(const APattern: string): string;
var
  I, Len: Integer;
  InClass: Boolean;
begin
  Result := '';
  I := 1;
  Len := Length(APattern);
  InClass := False;
  while I <= Len do
  begin
    if APattern[I] = '\' then
    begin
      if (not InClass) and (I < Len) and (APattern[I + 1] = 'A') then
        Result := Result + '^'
      else
        Result := Result + Copy(APattern, I, 2);
      Inc(I, 2);
      Continue;
    end;
    if InClass then
    begin
      if APattern[I] = ']' then
        InClass := False;
    end
    else if APattern[I] = '[' then
    begin
      InClass := True;
      Result := Result + APattern[I];
      Inc(I);
      if (I <= Len) and (APattern[I] = '^') then
      begin
        Result := Result + APattern[I];
        Inc(I);
      end;
      if (I <= Len) and (APattern[I] = ']') then
      begin
        Result := Result + APattern[I];
        Inc(I);
      end;
      Continue;
    end;
    Result := Result + APattern[I];
    Inc(I);
  end;
end;

{ Caller must hold GLock. The cache key starts with '^(?:', which none of the
  regular wrappings (WrapFull, WrapPrefix, WrapRaw) produce, so the multi line
  probe never shares an entry with a regular compile of the same text. }
function EmptyInputMatches(const APattern: string): Boolean;
var
  Index: Integer;
  Expr: TRegExpr;
  Probed: string;
begin
  { The unwrapped validation checks the text the probe actually wraps (see
    ValidateUnwrapped): its rewrite decision has to match the one of the
    probe spelling, and \A -> ^ changes the length of the rewrite. }
  Probed := RewriteStartAnchors(APattern);
  Index := AcquireIndex('^(?:' + Probed + ')$', Probed, True);
  Expr := GEntries[Index].Expr;
  Expr.InputString := RegExprString(#10);
  Result := Expr.ExecPos(2);
end;

function LockedEmptyInputMatches(const APattern: string): Boolean;
begin
  GLock.Enter;
  try
    Result := EmptyInputMatches(APattern);
  finally
    GLock.Leave;
  end;
end;
{$ENDIF}

function ExecuteMatch(const AWrapped, ARaw, AInput: string): Boolean;
var
  Index: Integer;
begin
  GLock.Enter;
  try
    Index := AcquireIndex(AWrapped, ARaw);
  {$IFDEF FPC}
    Result := GEntries[Index].Expr.Exec(RegExprString(AInput));
  {$ELSE}
    Result := GEntries[Index].Expr.IsMatch(AInput);
  {$ENDIF}
  finally
    GLock.Leave;
  end;
end;

function TryMatchFull(const APattern, AInput: string): Boolean;
begin
  { Upstream RegexBasedMatcher.matchNationalNumber refuses to match anything
    against an empty pattern; mirror that here so callers do not have to. }
  if APattern = '' then
  begin
    Result := False;
    Exit;
  end;
{$IFDEF FPC}
  if NeedsEmptyInputProbe(AInput) then
    Exit(LockedEmptyInputMatches(APattern));
{$ENDIF}
  Result := ExecuteMatch(WrapFull(APattern), APattern, AInput);
end;

function TryMatchPrefix(const APattern, AInput: string): Boolean;
begin
  if APattern = '' then
  begin
    Result := False;
    Exit;
  end;
{$IFDEF FPC}
  if NeedsEmptyInputProbe(AInput) then
    Exit(LockedEmptyInputMatches(APattern));
{$ENDIF}
  Result := ExecuteMatch(WrapPrefix(APattern), APattern, AInput);
end;

function CountCapturingGroups(const APattern: string): Integer;
var
  I, Len: Integer;
  InClass: Boolean;
begin
  Result := 0;
  InClass := False;
  I := 1;
  Len := Length(APattern);
  while I <= Len do
  begin
    case APattern[I] of
      '\':
        Inc(I);
      '[':
        if not InClass then
          InClass := True;
      ']':
        if InClass then
          InClass := False;
      '(':
        if not InClass then
        begin
          if (I = Len) or (APattern[I + 1] <> '?') then
            Inc(Result);
        end;
    end;
    Inc(I);
  end;
end;

function TryMatchPrefixEx(const APattern, AInput: string;
  out AMatch: TRegexPrefixMatch): Boolean;
var
  Index, I, Groups: Integer;
{$IFDEF FPC}
  Expr: TRegExpr;
{$ELSE}
  M: TMatch;
  G: TGroup;
{$ENDIF}
begin
  AMatch.MatchEnd := 0;
  AMatch.GroupCount := 0;
  AMatch.GroupMatched := nil;
  AMatch.GroupValue := nil;

  if APattern = '' then
  begin
    Result := False;
    Exit;
  end;

  Groups := CountCapturingGroups(APattern);
  SetLength(AMatch.GroupMatched, Groups + 1);
  SetLength(AMatch.GroupValue, Groups + 1);
  AMatch.GroupCount := Groups;

  GLock.Enter;
  try
    Index := AcquireIndex(WrapPrefix(APattern), APattern);
  {$IFDEF FPC}
    Expr := GEntries[Index].Expr;
    if NeedsEmptyInputProbe(AInput) then
    begin
      { The zero length match at offset 0: every group is empty or unset,
        and neither counts as matched (see the participation rule above). }
      if not EmptyInputMatches(APattern) then
      begin
        Result := False;
        Exit;
      end;
      AMatch.MatchEnd := 1;
      AMatch.GroupMatched[0] := True;
      AMatch.GroupValue[0] := '';
    end
    else
    begin
      if not Expr.Exec(RegExprString(AInput)) then
      begin
        Result := False;
        Exit;
      end;
      AMatch.MatchEnd := Expr.MatchPos[0] + Expr.MatchLen[0];
      AMatch.GroupMatched[0] := True;
      AMatch.GroupValue[0] := string(Expr.Match[0]);
      for I := 1 to Groups do
        if (I <= Expr.SubExprMatchCount) and (Expr.MatchLen[I] > 0) then
        begin
          AMatch.GroupMatched[I] := True;
          AMatch.GroupValue[I] := string(Expr.Match[I]);
        end;
    end;
  {$ELSE}
    M := GEntries[Index].Expr.Match(AInput);
    if not M.Success then
    begin
      Result := False;
      Exit;
    end;
    AMatch.MatchEnd := M.Index + M.Length;
    AMatch.GroupMatched[0] := True;
    AMatch.GroupValue[0] := M.Value;
    for I := 1 to Groups do
      if I < M.Groups.Count then
      begin
        G := M.Groups[I];
        if G.Length > 0 then
        begin
          AMatch.GroupMatched[I] := True;
          AMatch.GroupValue[I] := G.Value;
        end;
      end;
  {$ENDIF}
  finally
    GLock.Leave;
  end;

  Result := True;
end;

function TryFindFirst(const APattern, AInput: string; out AMatchValue: string;
  out AMatchStart: Integer): Boolean;
var
  Index: Integer;
{$IFDEF FPC}
  Expr: TRegExpr;
{$ELSE}
  M: TMatch;
{$ENDIF}
begin
  AMatchValue := '';
  AMatchStart := 0;
  if APattern = '' then
  begin
    Result := False;
    Exit;
  end;

  GLock.Enter;
  try
    Index := AcquireIndex(WrapRaw(APattern), APattern);
  {$IFDEF FPC}
    Expr := GEntries[Index].Expr;
    if NeedsEmptyInputProbe(AInput) then
    begin
      Result := EmptyInputMatches(APattern);
      if Result then
        AMatchStart := 1;
    end
    else
    begin
      Result := Expr.Exec(RegExprString(AInput));
      if Result then
      begin
        AMatchStart := Expr.MatchPos[0];
        AMatchValue := string(Expr.Match[0]);
      end;
    end;
  {$ELSE}
    M := GEntries[Index].Expr.Match(AInput);
    Result := M.Success;
    if Result then
    begin
      AMatchStart := M.Index;
      AMatchValue := M.Value;
    end;
  {$ENDIF}
  finally
    GLock.Leave;
  end;
end;

{ Literal port of java.util.regex.Matcher.appendReplacement's template
  handling. AGroupValue[0] is the whole match, AGroupValue[i] the i-th
  capturing group; a group that did not participate must be passed as an empty
  string, which is what Java appends for a null group.

  Deliberate differences, all of them the same trade: Java rejects a malformed
  template with an exception, this port degrades. See "Template contract" in the
  unit header for the full list and the reasoning.

    $n with n > AGroupCount  -> nothing is appended
                                (Java: IndexOutOfBoundsException)
    '$' not followed by a digit, including a trailing '$'
                             -> the '$' is appended literally
                                (Java: IllegalArgumentException)
    trailing '\'             -> the backslash is appended literally
                                (Java: IllegalArgumentException) }
function ExpandJavaReplacement(const ATemplate: string;
  const AGroupValue: array of string; AGroupCount: Integer): string;
var
  I, Len, Digit, Group, NextGroup: Integer;
begin
  Result := '';
  I := 1;
  Len := Length(ATemplate);
  while I <= Len do
  begin
    if (ATemplate[I] = '\') and (I < Len) then
    begin
      Result := Result + ATemplate[I + 1];
      Inc(I, 2);
      Continue;
    end;

    if (ATemplate[I] = '$') and (I < Len)
      and (ATemplate[I + 1] >= '0') and (ATemplate[I + 1] <= '9') then
    begin
      Inc(I);
      Group := Ord(ATemplate[I]) - Ord('0');
      Inc(I);
      { Java consumes further digits as long as the accumulated group number
        stays a valid group of the pattern. }
      while I <= Len do
      begin
        if (ATemplate[I] < '0') or (ATemplate[I] > '9') then
          Break;
        Digit := Ord(ATemplate[I]) - Ord('0');
        NextGroup := Group * 10 + Digit;
        if NextGroup > AGroupCount then
          Break;
        Group := NextGroup;
        Inc(I);
      end;
      if (Group >= 0) and (Group <= AGroupCount)
        and (Group < Length(AGroupValue)) then
        Result := Result + AGroupValue[Group];
      Continue;
    end;

    Result := Result + ATemplate[I];
    Inc(I);
  end;
end;

{ Shared body of ReplaceAll and ReplaceFirst. Mirrors the Matcher.find() loop
  Java runs behind both: leftmost non overlapping matches, and a zero length
  match advances the scan position by one so the loop always terminates. }
function ReplaceInternal(const APattern, AInput, ATemplate: string;
  AReplaceAll: Boolean): string;
var
  Index, I, Groups, Position, MatchStart, MatchLength: Integer;
  Values: array of string;
  Found: Boolean;
{$IFDEF FPC}
  Expr: TRegExpr;
  EmptyProbe: Boolean;
{$ELSE}
  M: TMatch;
  G: TGroup;
{$ENDIF}
begin
  Result := '';
  { An empty pattern is a no-op BY CONTRACT, not by accident. java.util.regex
    would match zero width at every position and interleave the template
    between all characters; nothing in this port can produce an empty pattern
    (the metadata never stores one and the format engine never builds one), so
    the shortcut stays and is pinned by a test instead. }
  if APattern = '' then
  begin
    Result := AInput;
    Exit;
  end;

  Groups := CountCapturingGroups(APattern);
  SetLength(Values, Groups + 1);
  Position := 1;

  GLock.Enter;
  try
    Index := AcquireIndex(WrapRaw(APattern), APattern);
  {$IFDEF FPC}
    Expr := GEntries[Index].Expr;
    EmptyProbe := NeedsEmptyInputProbe(AInput);
    if EmptyProbe then
      Found := EmptyInputMatches(APattern)
    else
      Found := Expr.Exec(RegExprString(AInput));
  {$ELSE}
    M := GEntries[Index].Expr.Match(AInput);
    Found := M.Success;
  {$ENDIF}
    while Found do
    begin
    {$IFDEF FPC}
      if EmptyProbe then
      begin
        { The one zero length match of an empty input. }
        MatchStart := 1;
        MatchLength := 0;
        for I := 0 to Groups do
          Values[I] := '';
      end
      else
      begin
        MatchStart := Expr.MatchPos[0];
        MatchLength := Expr.MatchLen[0];
        for I := 0 to Groups do
          if I <= Expr.SubExprMatchCount then
            Values[I] := string(Expr.Match[I])
          else
            Values[I] := '';
      end;
    {$ELSE}
      MatchStart := M.Index;
      MatchLength := M.Length;
      { Same participation rule as TryMatchPrefixEx: PCRE cannot distinguish a
        group that did not participate from one that matched empty, and both
        contribute the empty string to a Java replacement, so the length test
        is enough here. }
      for I := 0 to Groups do
        if I < M.Groups.Count then
        begin
          G := M.Groups[I];
          if G.Length > 0 then
            Values[I] := G.Value
          else
            Values[I] := '';
        end
        else
          Values[I] := '';
    {$ENDIF}

      Result := Result + Copy(AInput, Position, MatchStart - Position);
      Result := Result + ExpandJavaReplacement(ATemplate, Values, Groups);
      Position := MatchStart + MatchLength;

      if not AReplaceAll then
        Break;

    {$IFDEF FPC}
      if EmptyProbe then
        Found := False
      else
        Found := Expr.ExecNext;
    {$ELSE}
      M := M.NextMatch;
      Found := M.Success;
    {$ENDIF}
    end;
  finally
    GLock.Leave;
  end;

  Result := Result + Copy(AInput, Position, Length(AInput) - Position + 1);
end;

function ReplaceAll(const APattern, AInput, ATemplate: string): string;
begin
  Result := ReplaceInternal(APattern, AInput, ATemplate, True);
end;

function ReplaceFirst(const APattern, AInput, ATemplate: string): string;
begin
  Result := ReplaceInternal(APattern, AInput, ATemplate, False);
end;

function TryCompilePattern(const APattern: string; out AError: string): Boolean;
begin
  AError := '';
  if APattern = '' then
  begin
    AError := 'empty pattern';
    Result := False;
    Exit;
  end;
  try
    GLock.Enter;
    try
      AcquireIndex(WrapFull(APattern), APattern);
    finally
      GLock.Leave;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      AError := E.ClassName + ': ' + E.Message;
      Result := False;
    end;
  end;
end;

function CachedPatternCount: Integer;
begin
  GLock.Enter;
  try
    Result := GCount;
  finally
    GLock.Leave;
  end;
end;

procedure ClearPatternCache;
{$IFDEF FPC}
var
  I: Integer;
{$ENDIF}
begin
  GLock.Enter;
  try
  {$IFDEF FPC}
    for I := 0 to Length(GEntries) - 1 do
      if GEntries[I].Used then
        GEntries[I].Expr.Free;
  {$ENDIF}
    GEntries := nil;
    GCount := 0;
    SetLength(GEntries, InitialCapacity);
  finally
    GLock.Leave;
  end;
end;

initialization
  GLock := TCriticalSection.Create;
  GCount := 0;
  SetLength(GEntries, InitialCapacity);

finalization
{$IFDEF FPC}
  ClearPatternCache;
{$ENDIF}
  GEntries := nil;
  GLock.Free;

end.
