param(
  [string]$MetadataXmlPath = "",
  [string]$ShortMetadataXmlPath = "",
  [string]$TestingMetadataXmlPath = "",
  [string]$AlternateFormatsXmlPath = "",
  [string]$VendorRepoPath = "",
  [string]$OutputDir = "",
  [string]$SourceCommit = "",
  [switch]$ForceWrite,
  [switch]$SkipFpcCheck,
  [switch]$Quiet
)

<#
  Generates the Delphi/FreePascal metadata tables from the pinned upstream
  libphonenumber XML.

  The conversion follows
  vendor/libphonenumber/tools/java/common/src/com/google/i18n/phonenumbers/BuildMetadataFromXml.java
  literally, including the size optimisations upstream applies (redundant
  possible length lists dropped, intl format list cleared when no numberFormat
  declares an explicit <intlFormat>). That way the runtime can port the
  Java interpreter code path one to one.

  The script reads a THIRD input,
  vendor/libphonenumber/resources/PhoneNumberMetadataForTesting.xml, and emits
  three more units (LibPhoneNumber.TestingMetadata.Data / .Descs /
  .Formats) from it. That is the very same phone metadata branch, run a second
  time over the upstream TEST data set: the file the Java test suite runs
  against. Both runs go through one and the same function, so the production
  output cannot drift from the testing output by construction, and only the
  test project links the testing units.

  The script reads a FOURTH input,
  vendor/libphonenumber/resources/PhoneNumberAlternateFormats.xml, and emits
  one more unit (LibPhoneNumber.AlternateFormats.Data) from it. That is
  the isAlternateFormatsMetadata = true branch of the same Java builder:
  loadTerritoryTagMetadata plus loadAvailableFormats and NOTHING else - no
  description elements are read at all (BuildMetadataFromXml.loadCountryMetadata
  skips setRelevantDescPatterns for this input), the territories carry no id,
  and the only key is the country calling code, exactly like upstream
  FormattingMetadataSource.getFormattingMetadataForCountryCallingCode.

  The script reads a SECOND input,
  vendor/libphonenumber/resources/ShortNumberMetadata.xml, and emits two more
  units (LibPhoneNumber.ShortMetadata.Data / .Descs) from it. That is the
  isShortNumberMetadata = true branch of the same Java builder: a different,
  smaller description set, no number formats, no territory attributes beyond
  the id - and a general description whose possible lengths are copied from the
  shortCode element only instead of being aggregated over all typed children
  (setPossibleLengthsGeneralDesc). Both inputs run through the very same helper
  functions, so the phone metadata output is unaffected by construction.

  Output is deterministic: no timestamps, no hash table iteration order, fixed
  CRLF line endings, ASCII only. The pinned vendor commit is embedded instead
  of a generation time.
#>

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($VendorRepoPath)) {
  $VendorRepoPath = Join-Path $repoRoot "vendor\libphonenumber"
}
if ([string]::IsNullOrWhiteSpace($MetadataXmlPath)) {
  $MetadataXmlPath = Join-Path $VendorRepoPath "resources\PhoneNumberMetadata.xml"
}
if ([string]::IsNullOrWhiteSpace($ShortMetadataXmlPath)) {
  $ShortMetadataXmlPath = Join-Path $VendorRepoPath "resources\ShortNumberMetadata.xml"
}
if ([string]::IsNullOrWhiteSpace($TestingMetadataXmlPath)) {
  $TestingMetadataXmlPath = Join-Path $VendorRepoPath "resources\PhoneNumberMetadataForTesting.xml"
}
if ([string]::IsNullOrWhiteSpace($AlternateFormatsXmlPath)) {
  $AlternateFormatsXmlPath = Join-Path $VendorRepoPath "resources\PhoneNumberAlternateFormats.xml"
}
if ([string]::IsNullOrWhiteSpace($OutputDir)) {
  $OutputDir = Join-Path $repoRoot "src"
}

if (-not (Test-Path -LiteralPath $MetadataXmlPath)) {
  throw "Upstream metadata XML not found: $MetadataXmlPath"
}
if (-not (Test-Path -LiteralPath $ShortMetadataXmlPath)) {
  throw "Upstream short number metadata XML not found: $ShortMetadataXmlPath"
}
if (-not (Test-Path -LiteralPath $TestingMetadataXmlPath)) {
  throw "Upstream testing metadata XML not found: $TestingMetadataXmlPath"
}
if (-not (Test-Path -LiteralPath $AlternateFormatsXmlPath)) {
  throw "Upstream alternate formats XML not found: $AlternateFormatsXmlPath"
}
if (-not (Test-Path -LiteralPath $OutputDir)) {
  throw "Output directory not found: $OutputDir"
}

$generatorVersion = "metadata-v1"
$testingGeneratorVersion = "testing-metadata-v1"

# Label used in the generated headers and in ShortMetadataSourceFile. Derived
# from the actual input so an overridden -ShortMetadataXmlPath cannot claim the
# wrong source. The phone metadata builder derives its own label the same way.
$shortSourceFileName = Split-Path -Leaf $ShortMetadataXmlPath
$shortSourceLabel = "resources/" + $shortSourceFileName

# Same reasoning for the alternate formats input.
$alternateSourceLabel = "resources/" + (Split-Path -Leaf $AlternateFormatsXmlPath)

function Write-Info {
  param([string]$Message)
  if (-not $Quiet) {
    Write-Host $Message
  }
}

function Get-SourceCommitId {
  param([string]$RepoPath, [string]$Explicit)

  if (-not [string]::IsNullOrWhiteSpace($Explicit)) {
    return $Explicit.Trim()
  }
  if (-not (Test-Path -LiteralPath $RepoPath)) {
    throw "Vendor repository not found: $RepoPath. Pass -SourceCommit to generate without it."
  }

  $commit = & git -C $RepoPath rev-parse HEAD 2>$null
  if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($commit)) {
    throw "Unable to determine the vendor commit via 'git -C $RepoPath rev-parse HEAD'. Pass -SourceCommit explicitly."
  }
  return $commit.Trim()
}

# ---------------------------------------------------------------------------
# Upstream helpers (ports of BuildMetadataFromXml)
# ---------------------------------------------------------------------------

$script:PatternGateCount = 0

function Invoke-ValidateRE {
  <#
    Port of BuildMetadataFromXml.validateRE. Strips every whitespace character
    when requested (upstream does this instead of using an "extended" regex
    flag so the patterns stay portable across languages), compiles the result
    as the regex dialect gate and rejects the "|)" anti pattern.
  #>
  param(
    [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Regex,
    [switch]$RemoveWhitespace,
    [Parameter(Mandatory = $true)][string]$Context
  )

  $compressed = $Regex
  if ($RemoveWhitespace) {
    $compressed = [regex]::Replace($Regex, "\s", "")
  }

  try {
    [void][regex]::new($compressed)
  } catch {
    throw "Regex dialect gate failed for $Context : '$compressed' -> $($_.Exception.Message)"
  }
  $script:PatternGateCount++

  if ($compressed.Contains("|)")) {
    throw "Invalid upstream pattern for $Context : '|' must not be followed directly by ')' ('$compressed')."
  }
  return $compressed
}

function ConvertTo-PossibleLengthSet {
  <# Port of BuildMetadataFromXml.parsePossibleLengthStringToSet. #>
  param(
    [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Value,
    [Parameter(Mandatory = $true)][string]$Context
  )

  if ($Value.Length -eq 0) {
    throw "Empty possibleLength string found for $Context."
  }

  $result = New-Object 'System.Collections.Generic.SortedSet[int]'
  foreach ($part in $Value.Split(",")) {
    if ($part.Length -eq 0) {
      throw "Leading, trailing or adjacent commas in possible length string '$Value' ($Context)."
    }
    if ($part[0] -eq "[") {
      if ($part[$part.Length - 1] -ne "]") {
        throw "Missing end of range character in possible length string '$Value' ($Context)."
      }
      $minMax = $part.Substring(1, $part.Length - 2).Split("-")
      if ($minMax.Length -ne 2) {
        throw "Ranges must have exactly one '-' character: '$Value' ($Context)."
      }
      $min = [int]$minMax[0]
      $max = [int]$minMax[1]
      if (($max - $min) -lt 2) {
        throw "Range '$part' in '$Value' ($Context) must span at least three lengths."
      }
      for ($j = $min; $j -le $max; $j++) {
        if (-not $result.Add($j)) {
          throw "Duplicate length element $j in possible length string '$Value' ($Context)."
        }
      }
    } else {
      $length = [int]$part
      if (-not $result.Add($length)) {
        throw "Duplicate length element $length in possible length string '$Value' ($Context)."
      }
    }
  }
  return ,$result
}

function Add-PossibleLengthSets {
  <# Port of BuildMetadataFromXml.populatePossibleLengthSets. #>
  param(
    [Parameter(Mandatory = $true)][System.Xml.XmlElement]$Element,
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.SortedSet[int]]$Lengths,
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.SortedSet[int]]$LocalOnlyLengths,
    [Parameter(Mandatory = $true)][string]$Context
  )

  $nodes = $Element.GetElementsByTagName("possibleLengths")
  for ($i = 0; $i -lt $nodes.Count; $i++) {
    $node = $nodes.Item($i)
    $elementLengths = ConvertTo-PossibleLengthSet -Value $node.GetAttribute("national") -Context $Context
    if ($node.HasAttribute("localOnly")) {
      $elementLocalOnly = ConvertTo-PossibleLengthSet -Value $node.GetAttribute("localOnly") -Context $Context
      foreach ($length in $elementLocalOnly) {
        if ($elementLengths.Contains($length)) {
          throw "Length $length is specified as normal and local-only at the same time ($Context)."
        }
        [void]$LocalOnlyLengths.Add($length)
      }
    }
    foreach ($length in $elementLengths) {
      [void]$Lengths.Add($length)
    }
  }
}

function Set-DescPossibleLengths {
  <# Port of BuildMetadataFromXml.setPossibleLengths. #>
  param(
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.SortedSet[int]]$Lengths,
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.SortedSet[int]]$LocalOnlyLengths,
    $ParentDesc,
    [Parameter(Mandatory = $true)]$Desc,
    [Parameter(Mandatory = $true)][string]$Context
  )

  $Desc.Lengths = New-Object 'System.Collections.Generic.List[int]'
  $Desc.LocalOnlyLengths = New-Object 'System.Collections.Generic.List[int]'

  $sameAsParent = $false
  if ($null -ne $ParentDesc) {
    if ($Lengths.Count -eq $ParentDesc.Lengths.Count) {
      $sameAsParent = $true
      $i = 0
      foreach ($length in $Lengths) {
        if ($length -ne $ParentDesc.Lengths[$i]) {
          $sameAsParent = $false
          break
        }
        $i++
      }
    }
  }

  if (-not $sameAsParent) {
    foreach ($length in $Lengths) {
      if ($null -eq $ParentDesc -or $ParentDesc.Lengths.Contains($length)) {
        $Desc.Lengths.Add($length)
      } else {
        throw "Out-of-range possible length found ($length) for $Context."
      }
    }
  }

  foreach ($length in $LocalOnlyLengths) {
    if (-not $Lengths.Contains($length)) {
      if ($null -eq $ParentDesc -or $ParentDesc.LocalOnlyLengths.Contains($length) -or $ParentDesc.Lengths.Contains($length)) {
        $Desc.LocalOnlyLengths.Add($length)
      } else {
        throw "Out-of-range local-only possible length found ($length) for $Context."
      }
    }
  }
}

function New-DescModel {
  return [pscustomobject]@{
    HasData               = $false
    NationalNumberPattern = ""
    ExampleNumber         = ""
    Lengths               = New-Object 'System.Collections.Generic.List[int]'
    LocalOnlyLengths      = New-Object 'System.Collections.Generic.List[int]'
  }
}

function Read-PhoneNumberDescElement {
  <# Port of BuildMetadataFromXml.processPhoneNumberDescElement. #>
  param(
    $ParentDesc,
    [Parameter(Mandatory = $true)][System.Xml.XmlElement]$CountryElement,
    [Parameter(Mandatory = $true)][string]$NumberType,
    [Parameter(Mandatory = $true)][string]$RegionId
  )

  $context = "$RegionId/$NumberType"
  $desc = New-DescModel
  $nodes = $CountryElement.GetElementsByTagName($NumberType)
  if ($nodes.Count -eq 0) {
    # Upstream uses a single possible length of -1 which never matches a real
    # number. The empty list is reserved for "inherit from generalDesc".
    $desc.Lengths.Add(-1)
    return $desc
  }
  if ($nodes.Count -gt 1) {
    throw "Multiple elements with type $NumberType found for $RegionId."
  }

  $desc.HasData = $true
  $element = $nodes.Item(0)

  if ($null -ne $ParentDesc) {
    $lengths = New-Object 'System.Collections.Generic.SortedSet[int]'
    $localOnly = New-Object 'System.Collections.Generic.SortedSet[int]'
    Add-PossibleLengthSets -Element $element -Lengths $lengths -LocalOnlyLengths $localOnly -Context $context
    Set-DescPossibleLengths -Lengths $lengths -LocalOnlyLengths $localOnly -ParentDesc $ParentDesc -Desc $desc -Context $context
  }

  $patternNodes = $element.GetElementsByTagName("nationalNumberPattern")
  if ($patternNodes.Count -gt 0) {
    $desc.NationalNumberPattern = Invoke-ValidateRE -Regex $patternNodes.Item(0).InnerText -RemoveWhitespace -Context "$context/nationalNumberPattern"
  }

  $exampleNodes = $element.GetElementsByTagName("exampleNumber")
  if ($exampleNodes.Count -gt 0) {
    $desc.ExampleNumber = $exampleNodes.Item(0).InnerText
  }

  return $desc
}

function Set-GeneralDescPossibleLengths {
  <# Port of BuildMetadataFromXml.setPossibleLengthsGeneralDesc. #>
  param(
    [Parameter(Mandatory = $true)]$GeneralDesc,
    [Parameter(Mandatory = $true)][System.Xml.XmlElement]$Element,
    [Parameter(Mandatory = $true)][string]$RegionId,
    [switch]$IsShortNumberMetadata
  )

  $lengths = New-Object 'System.Collections.Generic.SortedSet[int]'
  $localOnly = New-Object 'System.Collections.Generic.SortedSet[int]'

  $generalNodes = $Element.GetElementsByTagName("generalDesc")
  if ($generalNodes.Count -gt 0) {
    Add-PossibleLengthSets -Element $generalNodes.Item(0) -Lengths $lengths -LocalOnlyLengths $localOnly -Context "$RegionId/generalDesc"
    if ($lengths.Count -gt 0 -or $localOnly.Count -gt 0) {
      throw "Found possible lengths specified at general desc for $RegionId; these must be derived from child elements."
    }
  }

  if (-not $IsShortNumberMetadata) {
    # The general description aggregates the lengths of all typed children
    # except noInternationalDialling, which is not a real number type.
    $clone = $Element.CloneNode($true)
    $toRemove = $clone.GetElementsByTagName("noInternationalDialling")
    if ($toRemove.Count -gt 0) {
      $node = $toRemove.Item(0)
      [void]$node.ParentNode.RemoveChild($node)
    }
    Add-PossibleLengthSets -Element $clone -Lengths $lengths -LocalOnlyLengths $localOnly -Context "$RegionId/allDescs"
  } else {
    # Short number metadata copies the lengths of the shortCode element only:
    # it is the more detailed validation pattern and not a sub-type of short
    # codes. The other descriptions are checked against these lengths when they
    # are read, which is what makes them a proven subset.
    $shortCodeNodes = $Element.GetElementsByTagName("shortCode")
    if ($shortCodeNodes.Count -gt 0) {
      Add-PossibleLengthSets -Element $shortCodeNodes.Item(0) -Lengths $lengths -LocalOnlyLengths $localOnly -Context "$RegionId/shortCode"
    }
    if ($localOnly.Count -gt 0) {
      throw "Found local-only lengths in short-number metadata for $RegionId."
    }
  }

  Set-DescPossibleLengths -Lengths $lengths -LocalOnlyLengths $localOnly -ParentDesc $null -Desc $GeneralDesc -Context "$RegionId/generalDesc"
}

function Get-FirstLiteralReplacement {
  param([string]$Value, [string]$Search, [string]$Replacement)

  $index = $Value.IndexOf($Search, [System.StringComparison]::Ordinal)
  if ($index -lt 0) {
    return $Value
  }
  return $Value.Substring(0, $index) + $Replacement + $Value.Substring($index + $Search.Length)
}

function Get-PrefixFormattingRule {
  <#
    Port of getNationalPrefixFormattingRuleFromElement: replace the first $NP
    with the national prefix and the first $FG with $1.
  #>
  param([System.Xml.XmlElement]$Element, [string]$NationalPrefix)

  $rule = $Element.GetAttribute("nationalPrefixFormattingRule")
  $rule = Get-FirstLiteralReplacement -Value $rule -Search '$NP' -Replacement $NationalPrefix
  $rule = Get-FirstLiteralReplacement -Value $rule -Search '$FG' -Replacement '$1'
  return $rule
}

function Get-CarrierCodeFormattingRule {
  <#
    Port of getDomesticCarrierCodeFormattingRuleFromElement: replace the first
    $FG with $1 and the first $NP with the national prefix (note the reversed
    order compared to the national prefix formatting rule).
  #>
  param([System.Xml.XmlElement]$Element, [string]$NationalPrefix)

  $rule = $Element.GetAttribute("carrierCodeFormattingRule")
  $rule = Get-FirstLiteralReplacement -Value $rule -Search '$FG' -Replacement '$1'
  $rule = Get-FirstLiteralReplacement -Value $rule -Search '$NP' -Replacement $NationalPrefix
  return $rule
}

# ---------------------------------------------------------------------------
# Flat pools
#
# Both the phone metadata and the short number metadata store their variable
# length data (possible lengths, leadingDigits patterns) in flat pools that are
# addressed through offset/count pairs, and identical runs are shared. The pool
# and its index are passed in, so one helper serves every data set instead of
# one copy per set.
# ---------------------------------------------------------------------------

function Add-LengthRun {
  param(
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.List[int]]$Pool,
    [Parameter(Mandatory = $true)][System.Collections.Generic.Dictionary[string,int]]$Index,
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.List[int]]$Values
  )

  if ($Values.Count -eq 0) {
    return 0
  }
  $key = ($Values -join ",")
  $existing = 0
  if ($Index.TryGetValue($key, [ref]$existing)) {
    return $existing
  }
  $offset = $Pool.Count
  foreach ($value in $Values) {
    $Pool.Add($value)
  }
  $Index[$key] = $offset
  return $offset
}

function Add-LeadingDigitsRun {
  param(
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.List[string]]$Pool,
    [Parameter(Mandatory = $true)][System.Collections.Generic.Dictionary[string,int]]$Index,
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.Generic.List[string]]$Values
  )

  if ($Values.Count -eq 0) {
    return 0
  }
  # Chr(1) never occurs in a pattern, so it is a safe key separator.
  $key = ($Values -join [string][char]1)
  $existing = 0
  if ($Index.TryGetValue($key, [ref]$existing)) {
    return $existing
  }
  $offset = $Pool.Count
  foreach ($value in $Values) {
    $Pool.Add($value)
  }
  $Index[$key] = $offset
  return $offset
}

# ---------------------------------------------------------------------------
# Model building
# ---------------------------------------------------------------------------

$descKindTags = @(
  @{ Kind = "pdkGeneralDesc";             Tag = "generalDesc" },
  @{ Kind = "pdkFixedLine";               Tag = "fixedLine" },
  @{ Kind = "pdkMobile";                  Tag = "mobile" },
  @{ Kind = "pdkTollFree";                Tag = "tollFree" },
  @{ Kind = "pdkPremiumRate";             Tag = "premiumRate" },
  @{ Kind = "pdkSharedCost";              Tag = "sharedCost" },
  @{ Kind = "pdkPersonalNumber";          Tag = "personalNumber" },
  @{ Kind = "pdkVoip";                    Tag = "voip" },
  @{ Kind = "pdkPager";                   Tag = "pager" },
  @{ Kind = "pdkUan";                     Tag = "uan" },
  @{ Kind = "pdkVoicemail";               Tag = "voicemail" },
  @{ Kind = "pdkNoInternationalDialling"; Tag = "noInternationalDialling" }
)


# ---------------------------------------------------------------------------
# Emitters
# ---------------------------------------------------------------------------

$script:NonAsciiCount = 0

function ConvertTo-PascalLiteral {
  <#
    Emits a Pascal string expression. Long values are split into chunks that
    are concatenated across several source lines: Delphi rejects overly long
    source lines, and short chunks keep the generated diff readable.
    Characters outside printable ASCII are emitted as #$XXXX escapes so the
    generated units stay pure ASCII.
  #>
  param(
    [AllowEmptyString()][string]$Value,
    [int]$MaxChunk = 96,
    [string]$ContinuationIndent = "       "
  )

  if ([string]::IsNullOrEmpty($Value)) {
    return "''"
  }

  $parts = New-Object 'System.Collections.Generic.List[string]'
  $sb = New-Object System.Text.StringBuilder
  $chunk = 0

  foreach ($ch in $Value.ToCharArray()) {
    $code = [int]$ch
    if ($code -ge 32 -and $code -le 126) {
      if ($sb.Length -eq 0) { [void]$sb.Append("'") }
      if ($ch -eq "'") { [void]$sb.Append("''") } else { [void]$sb.Append($ch) }
      $chunk++
      if ($chunk -ge $MaxChunk) {
        [void]$sb.Append("'")
        $parts.Add($sb.ToString())
        [void]$sb.Clear()
        $chunk = 0
      }
    } else {
      $script:NonAsciiCount++
      if ($sb.Length -gt 0) {
        [void]$sb.Append("'")
        $parts.Add($sb.ToString())
        [void]$sb.Clear()
        $chunk = 0
      }
      $parts.Add(('#$' + $code.ToString("X4")))
    }
  }
  if ($sb.Length -gt 0) {
    [void]$sb.Append("'")
    $parts.Add($sb.ToString())
  }
  if ($parts.Count -eq 1) {
    return $parts[0]
  }
  return ($parts -join (" +`r`n" + $ContinuationIndent))
}

function ConvertTo-PascalBoolean {
  param([bool]$Value)
  if ($Value) { return "True" }
  return "False"
}

function New-GeneratedHeader {
  param([string]$UnitName, [string]$Purpose, [string]$SourceLabel, [string]$GeneratorLabel)

  $lines = New-Object 'System.Collections.Generic.List[string]'
  $lines.Add("unit $UnitName;")
  $lines.Add("")
  $lines.Add("{")
  $lines.Add("  GENERATED FILE - DO NOT EDIT.")
  $lines.Add("")
  $lines.Add("  $Purpose")
  $lines.Add("")
  $lines.Add("  Source:    vendor/libphonenumber/$SourceLabel")
  $lines.Add("  Commit:    $sourceCommitId")
  $lines.Add("  Generator: tools/generate_metadata.ps1 ($GeneratorLabel)")
  $lines.Add("")
  $lines.Add("  Regenerate with:")
  $lines.Add("    pwsh -NoProfile -ExecutionPolicy Bypass -File tools/generate_metadata.ps1")
  $lines.Add("")
  $lines.Add("  No generation timestamp is embedded on purpose: the output must stay")
  $lines.Add("  byte identical for an unchanged input.")
  $lines.Add("}")
  $lines.Add("")
  $lines.Add("{`$IFDEF FPC}")
  $lines.Add("{`$MODE DELPHI}")
  $lines.Add("{`$ENDIF}")
  $lines.Add("")
  return ,$lines
}

function Format-IntegerTable {
  param(
    [string]$Name,
    [string]$ElementType,
    [AllowEmptyCollection()][System.Collections.Generic.List[int]]$Values,
    [int]$PerLine = 20
  )

  $lines = New-Object 'System.Collections.Generic.List[string]'
  if ($Values.Count -eq 0) {
    $lines.Add("  ${Name}: array[0..0] of ${ElementType} = (0);")
    return ,$lines
  }
  $lines.Add("  ${Name}: array[0..$($Values.Count - 1)] of ${ElementType} = (")
  $buffer = New-Object 'System.Collections.Generic.List[string]'
  for ($i = 0; $i -lt $Values.Count; $i++) {
    $suffix = ","
    if ($i -eq ($Values.Count - 1)) { $suffix = "" }
    $buffer.Add(("{0}{1}" -f $Values[$i], $suffix))
    if ($buffer.Count -ge $PerLine -or $i -eq ($Values.Count - 1)) {
      $lines.Add("    " + ($buffer -join " "))
      $buffer.Clear()
    }
  }
  $lines.Add("  );")
  return ,$lines
}


# --- Formats unit ----------------------------------------------------------

function Add-FormatTable {
  param(
    [AllowEmptyCollection()][System.Collections.Generic.List[string]]$Lines,
    [string]$Name,
    [AllowEmptyCollection()][System.Collections.Generic.List[object]]$Rows
  )

  if ($Rows.Count -eq 0) {
    $Lines.Add("  ${Name}: array[0..0] of TNumberFormatRec = (")
    $Lines.Add("    (Pattern: ''; Format: ''; LeadingDigitsOffset: 0; LeadingDigitsCount: 0;")
    $Lines.Add("     NationalPrefixFormattingRule: ''; NationalPrefixOptionalWhenFormatting: False;")
    $Lines.Add("     DomesticCarrierCodeFormattingRule: ''; IntlFormatKind: ifkInheritedFromNational;")
    $Lines.Add("     IntlFormat: '')")
    $Lines.Add("  );")
    return
  }

  $Lines.Add("  ${Name}: array[0..$($Rows.Count - 1)] of TNumberFormatRec = (")
  for ($i = 0; $i -lt $Rows.Count; $i++) {
    $row = $Rows[$i]
    $suffix = ","
    if ($i -eq ($Rows.Count - 1)) { $suffix = "" }
    $Lines.Add("    { $($row.Owner) }")
    $Lines.Add("    (Pattern: $(ConvertTo-PascalLiteral $row.Pattern);")
    $Lines.Add("     Format: $(ConvertTo-PascalLiteral $row.Format);")
    $Lines.Add("     LeadingDigitsOffset: $($row.LeadingDigitsOffset); LeadingDigitsCount: $($row.LeadingDigitsCount);")
    $Lines.Add("     NationalPrefixFormattingRule: $(ConvertTo-PascalLiteral $row.PrefixRule);")
    $Lines.Add("     NationalPrefixOptionalWhenFormatting: $(ConvertTo-PascalBoolean $row.PrefixOptional);")
    $Lines.Add("     DomesticCarrierCodeFormattingRule: $(ConvertTo-PascalLiteral $row.CarrierRule);")
    $Lines.Add("     IntlFormatKind: $($row.IntlKind);")
    $Lines.Add("     IntlFormat: $(ConvertTo-PascalLiteral $row.IntlValue))$suffix")
  }
  $Lines.Add("  );")
}



# ---------------------------------------------------------------------------
# Output helper
# ---------------------------------------------------------------------------

function Write-GeneratedUnit {
  param(
    [string]$UnitName,
    [AllowEmptyCollection()][System.Collections.Generic.List[string]]$Lines
  )

  $path = Join-Path $OutputDir ($UnitName + ".pas")
  $content = ($Lines -join "`r`n") + "`r`n"

  $changed = $true
  if ((Test-Path -LiteralPath $path) -and -not $ForceWrite) {
    $existing = [System.IO.File]::ReadAllText($path)
    if ($existing -ceq $content) {
      $changed = $false
    }
  }

  # Long string literals are emitted as multi line expressions, so count the
  # physical lines instead of the number of emitted chunks.
  $physicalLines = ([regex]::Matches($content, "`r`n")).Count

  if ($changed) {
    $encoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($path, $content, $encoding)
    Write-Info ("  wrote   {0} ({1} lines, {2} bytes)" -f (Split-Path -Leaf $path), $physicalLines, $content.Length)
  } else {
    Write-Info ("  current {0} ({1} lines)" -f (Split-Path -Leaf $path), $physicalLines)
  }
  return $path
}

# ---------------------------------------------------------------------------
# Phone metadata builder
# ---------------------------------------------------------------------------

$sourceCommitId = Get-SourceCommitId -RepoPath $VendorRepoPath -Explicit $SourceCommit

function Invoke-PhoneMetadataBuild {
  <#
    Builds the three phone metadata units from ONE PhoneNumberMetadata XML
    file and returns them together with the numbers of the run.

    Called twice: once for the shipped
    resources/PhoneNumberMetadata.xml, which produces the production units
    LibPhoneNumber.Metadata.*, and once for
    resources/PhoneNumberMetadataForTesting.xml, which produces
    LibPhoneNumber.TestingMetadata.*. Everything the two runs differ in
    is in the parameters - the input file, the unit namespace and the
    generator label that lands in the provenance constants - so the two data
    sets cannot drift apart in shape.

    The testing input is a much smaller and partly DIFFERENT data set (36
    territories against 254, and several territories carry other attributes
    than their production namesakes). It needs no special case: the builder
    is a port of BuildMetadataFromXml, which reads both files with the very
    same code upstream as well.

    NOTHING is written here. The caller writes the units only after every
    input has been read and validated.
  #>
  param(
    [Parameter(Mandatory = $true)][string]$XmlPath,
    [Parameter(Mandatory = $true)][string]$UnitNamespace,
    [Parameter(Mandatory = $true)][string]$GeneratorLabel
  )

  # Label used in the generated headers and in MetadataSourceFile. Derived
  # from the actual input so an overridden path cannot claim the wrong source.
  $sourceLabel = "resources/" + (Split-Path -Leaf $XmlPath)

  $patternGateBefore = $script:PatternGateCount
  $nonAsciiBefore = $script:NonAsciiCount

  Write-Info "Reading upstream metadata: $XmlPath"
  $document = New-Object System.Xml.XmlDocument
  $document.PreserveWhitespace = $false
  $readerSettings = New-Object System.Xml.XmlReaderSettings
  $readerSettings.DtdProcessing = [System.Xml.DtdProcessing]::Parse
  $readerSettings.XmlResolver = $null
  $reader = [System.Xml.XmlReader]::Create($XmlPath, $readerSettings)
  try {
    $document.Load($reader)
  } finally {
    $reader.Dispose()
  }
  $document.DocumentElement.Normalize()

  $territoryNodes = $document.DocumentElement.GetElementsByTagName("territory")

  $territories = New-Object 'System.Collections.Generic.List[object]'

  for ($t = 0; $t -lt $territoryNodes.Count; $t++) {
    $element = $territoryNodes.Item($t)

    $regionId = ""
    if ($element.HasAttribute("id")) {
      $regionId = $element.GetAttribute("id")
    }

    $nationalPrefix = ""
    if ($element.HasAttribute("nationalPrefix")) {
      $nationalPrefix = $element.GetAttribute("nationalPrefix")
    }

    $territory = [pscustomobject]@{
      Id                           = $regionId
      CountryCode                  = 0
      LeadingDigits                = ""
      InternationalPrefix          = ""
      PreferredInternationalPrefix = ""
      NationalPrefix               = ""
      NationalPrefixForParsing     = ""
      NationalPrefixTransformRule  = ""
      PreferredExtnPrefix          = ""
      MainCountryForCode           = $false
      MobileNumberPortableRegion   = $false
      SameMobileAndFixedLinePattern = $false
      Descs                        = New-Object 'System.Collections.Generic.List[object]'
      Formats                      = New-Object 'System.Collections.Generic.List[object]'
      IntlFormats                  = New-Object 'System.Collections.Generic.List[object]'
    }

    # --- loadTerritoryTagMetadata -------------------------------------------
    if ($element.HasAttribute("countryCode")) {
      $territory.CountryCode = [int]$element.GetAttribute("countryCode")
    }
    if ($element.HasAttribute("leadingDigits")) {
      $territory.LeadingDigits = Invoke-ValidateRE -Regex $element.GetAttribute("leadingDigits") -Context "$regionId/leadingDigits"
    }
    if ($element.HasAttribute("internationalPrefix")) {
      $territory.InternationalPrefix = Invoke-ValidateRE -Regex $element.GetAttribute("internationalPrefix") -Context "$regionId/internationalPrefix"
    }
    if ($element.HasAttribute("preferredInternationalPrefix")) {
      $territory.PreferredInternationalPrefix = $element.GetAttribute("preferredInternationalPrefix")
    }
    $hasNationalPrefixForParsing = $false
    if ($element.HasAttribute("nationalPrefixForParsing")) {
      $territory.NationalPrefixForParsing = Invoke-ValidateRE -Regex $element.GetAttribute("nationalPrefixForParsing") -RemoveWhitespace -Context "$regionId/nationalPrefixForParsing"
      $hasNationalPrefixForParsing = $true
      if ($element.HasAttribute("nationalPrefixTransformRule")) {
        # Upstream applies validateRE without whitespace removal here
        # (BuildMetadataFromXml.loadTerritoryTagMetadata), unlike
        # nationalPrefixForParsing right above.
        $territory.NationalPrefixTransformRule = Invoke-ValidateRE -Regex $element.GetAttribute("nationalPrefixTransformRule") -Context "$regionId/nationalPrefixTransformRule"
      }
    }
    if ($nationalPrefix.Length -gt 0) {
      $territory.NationalPrefix = $nationalPrefix
      if (-not $hasNationalPrefixForParsing) {
        $territory.NationalPrefixForParsing = $nationalPrefix
      }
    }
    if ($element.HasAttribute("preferredExtnPrefix")) {
      $territory.PreferredExtnPrefix = $element.GetAttribute("preferredExtnPrefix")
    }
    if ($element.HasAttribute("mainCountryForCode")) {
      $territory.MainCountryForCode = $true
    }
    if ($element.HasAttribute("mobileNumberPortableRegion")) {
      $territory.MobileNumberPortableRegion = $true
    }

    # --- loadAvailableFormats ------------------------------------------------
    $territoryPrefixRule = Get-PrefixFormattingRule -Element $element -NationalPrefix $nationalPrefix
    $territoryPrefixOptional = $element.HasAttribute("nationalPrefixOptionalWhenFormatting")
    $territoryCarrierRule = ""
    if ($element.HasAttribute("carrierCodeFormattingRule")) {
      $territoryCarrierRule = Invoke-ValidateRE -Regex (Get-CarrierCodeFormattingRule -Element $element -NationalPrefix $nationalPrefix) -Context "$regionId/carrierCodeFormattingRule"
    }

    $formatNodes = $element.GetElementsByTagName("numberFormat")
    $hasExplicitIntlFormat = $false

    for ($f = 0; $f -lt $formatNodes.Count; $f++) {
      $formatElement = $formatNodes.Item($f)
      $context = "$regionId/numberFormat[$f]"

      $prefixRule = ""
      if ($formatElement.HasAttribute("nationalPrefixFormattingRule")) {
        $prefixRule = Get-PrefixFormattingRule -Element $formatElement -NationalPrefix $nationalPrefix
      } elseif ($territoryPrefixRule -ne "") {
        $prefixRule = $territoryPrefixRule
      }

      if ($formatElement.HasAttribute("nationalPrefixOptionalWhenFormatting")) {
        $prefixOptional = ($formatElement.GetAttribute("nationalPrefixOptionalWhenFormatting") -eq "true")
      } else {
        $prefixOptional = $territoryPrefixOptional
      }

      $carrierRule = ""
      if ($formatElement.HasAttribute("carrierCodeFormattingRule")) {
        $carrierRule = Invoke-ValidateRE -Regex (Get-CarrierCodeFormattingRule -Element $formatElement -NationalPrefix $nationalPrefix) -Context "$context/carrierCodeFormattingRule"
      } elseif ($territoryCarrierRule -ne "") {
        $carrierRule = $territoryCarrierRule
      }

      $leadingDigits = New-Object 'System.Collections.Generic.List[string]'
      $leadingNodes = $formatElement.GetElementsByTagName("leadingDigits")
      for ($l = 0; $l -lt $leadingNodes.Count; $l++) {
        $leadingDigits.Add((Invoke-ValidateRE -Regex $leadingNodes.Item($l).InnerText -RemoveWhitespace -Context "$context/leadingDigits[$l]"))
      }

      $pattern = Invoke-ValidateRE -Regex $formatElement.GetAttribute("pattern") -Context "$context/pattern"

      $formatValueNodes = $formatElement.GetElementsByTagName("format")
      if ($formatValueNodes.Count -ne 1) {
        throw "Exactly one <format> element expected for $context, found $($formatValueNodes.Count)."
      }
      $formatValue = $formatValueNodes.Item(0).InnerText

      $intlNodes = $formatElement.GetElementsByTagName("intlFormat")
      if ($intlNodes.Count -gt 1) {
        throw "A maximum of one <intlFormat> element is allowed for $context."
      }

      $intlKind = "ifkInheritedFromNational"
      $intlValue = ""
      if ($intlNodes.Count -eq 1) {
        $hasExplicitIntlFormat = $true
        $rawIntl = $intlNodes.Item(0).InnerText
        if ($rawIntl -eq "NA") {
          $intlKind = "ifkNotAvailable"
        } else {
          $intlKind = "ifkExplicit"
          $intlValue = $rawIntl
        }
      }

      $nationalFormat = [pscustomobject]@{
        Pattern        = $pattern
        Format         = $formatValue
        LeadingDigits  = $leadingDigits
        PrefixRule     = $prefixRule
        PrefixOptional = $prefixOptional
        CarrierRule    = $carrierRule
        IntlKind       = $intlKind
        IntlValue      = $intlValue
      }
      $territory.Formats.Add($nationalFormat)

      # loadInternationalFormat: no <intlFormat> child means the national format
      # is reused (mergeFrom); an explicit one only carries pattern, leading
      # digits and format; "NA" drops the entry entirely.
      if ($intlKind -eq "ifkInheritedFromNational") {
        $territory.IntlFormats.Add([pscustomobject]@{
          Pattern        = $pattern
          Format         = $formatValue
          LeadingDigits  = $leadingDigits
          PrefixRule     = $prefixRule
          PrefixOptional = $prefixOptional
          CarrierRule    = $carrierRule
          IntlKind       = $intlKind
          IntlValue      = ""
        })
      } elseif ($intlKind -eq "ifkExplicit") {
        $territory.IntlFormats.Add([pscustomobject]@{
          Pattern        = $formatElement.GetAttribute("pattern")
          Format         = $intlValue
          LeadingDigits  = $leadingDigits
          PrefixRule     = ""
          PrefixOptional = $false
          CarrierRule    = ""
          IntlKind       = $intlKind
          IntlValue      = ""
        })
      }
    }

    if (-not $hasExplicitIntlFormat) {
      # Upstream clears the intl list when it is an exact copy of the national
      # one; the runtime then falls back to the national formats.
      $territory.IntlFormats.Clear()
    }

    # --- setRelevantDescPatterns --------------------------------------------
    $generalDesc = Read-PhoneNumberDescElement -ParentDesc $null -CountryElement $element -NumberType "generalDesc" -RegionId $regionId
    Set-GeneralDescPossibleLengths -GeneralDesc $generalDesc -Element $element -RegionId $regionId

    foreach ($kindInfo in $descKindTags) {
      if ($kindInfo.Tag -eq "generalDesc") {
        $territory.Descs.Add($generalDesc)
      } else {
        $territory.Descs.Add((Read-PhoneNumberDescElement -ParentDesc $generalDesc -CountryElement $element -NumberType $kindInfo.Tag -RegionId $regionId))
      }
    }

    $fixedLine = $territory.Descs[1]
    $mobile = $territory.Descs[2]
    $territory.SameMobileAndFixedLinePattern = ($mobile.NationalNumberPattern -eq $fixedLine.NationalNumberPattern)

    $territories.Add($territory)
  }

  Write-Info ("Parsed territories: {0}" -f $territories.Count)

  # ---------------------------------------------------------------------------
  # Pools and indices
  # ---------------------------------------------------------------------------

  $lengthPool = New-Object 'System.Collections.Generic.List[int]'
  $lengthPoolIndex = New-Object 'System.Collections.Generic.Dictionary[string,int]'
  $leadingDigitsPool = New-Object 'System.Collections.Generic.List[string]'
  $leadingDigitsPoolIndex = New-Object 'System.Collections.Generic.Dictionary[string,int]'
  $descRows = New-Object 'System.Collections.Generic.List[object]'
  $formatRows = New-Object 'System.Collections.Generic.List[object]'
  $intlFormatRows = New-Object 'System.Collections.Generic.List[object]'

  foreach ($territory in $territories) {
    $territory | Add-Member -NotePropertyName DescOffset -NotePropertyValue $descRows.Count -Force

    for ($k = 0; $k -lt $descKindTags.Count; $k++) {
      $desc = $territory.Descs[$k]
      $descRows.Add([pscustomobject]@{
        Owner           = $territory.Id
        Kind            = $descKindTags[$k].Tag
        HasData         = $desc.HasData
        Pattern         = $desc.NationalNumberPattern
        ExampleNumber   = $desc.ExampleNumber
        LengthOffset    = (Add-LengthRun -Pool $lengthPool -Index $lengthPoolIndex -Values $desc.Lengths)
        LengthCount     = $desc.Lengths.Count
        LocalOnlyOffset = (Add-LengthRun -Pool $lengthPool -Index $lengthPoolIndex -Values $desc.LocalOnlyLengths)
        LocalOnlyCount  = $desc.LocalOnlyLengths.Count
      })
    }

    $territory | Add-Member -NotePropertyName FormatOffset -NotePropertyValue $formatRows.Count -Force
    foreach ($format in $territory.Formats) {
      $formatRows.Add([pscustomobject]@{
        Owner               = $territory.Id
        Pattern             = $format.Pattern
        Format              = $format.Format
        LeadingDigitsOffset = (Add-LeadingDigitsRun -Pool $leadingDigitsPool -Index $leadingDigitsPoolIndex -Values $format.LeadingDigits)
        LeadingDigitsCount  = $format.LeadingDigits.Count
        PrefixRule          = $format.PrefixRule
        PrefixOptional      = $format.PrefixOptional
        CarrierRule         = $format.CarrierRule
        IntlKind            = $format.IntlKind
        IntlValue           = $format.IntlValue
      })
    }
    $territory | Add-Member -NotePropertyName FormatCount -NotePropertyValue $territory.Formats.Count -Force

    $territory | Add-Member -NotePropertyName IntlFormatOffset -NotePropertyValue $intlFormatRows.Count -Force
    foreach ($format in $territory.IntlFormats) {
      $intlFormatRows.Add([pscustomobject]@{
        Owner               = $territory.Id
        Pattern             = $format.Pattern
        Format              = $format.Format
        LeadingDigitsOffset = (Add-LeadingDigitsRun -Pool $leadingDigitsPool -Index $leadingDigitsPoolIndex -Values $format.LeadingDigits)
        LeadingDigitsCount  = $format.LeadingDigits.Count
        PrefixRule          = $format.PrefixRule
        PrefixOptional      = $format.PrefixOptional
        CarrierRule         = $format.CarrierRule
        IntlKind            = $format.IntlKind
        IntlValue           = $format.IntlValue
      })
    }
    $territory | Add-Member -NotePropertyName IntlFormatCount -NotePropertyValue $territory.IntlFormats.Count -Force
  }

  # Region index: geographical territories sorted by ordinal region code.
  $regionEntries = New-Object 'System.Collections.Generic.List[object]'
  $nonGeoEntries = New-Object 'System.Collections.Generic.List[object]'
  for ($i = 0; $i -lt $territories.Count; $i++) {
    if ($territories[$i].Id -eq "001") {
      $nonGeoEntries.Add([pscustomobject]@{ Index = $i; Key = $territories[$i].CountryCode })
    } else {
      $regionEntries.Add([pscustomobject]@{ Index = $i; Key = $territories[$i].Id })
    }
  }

  # Ordinal ordering, independent of the current culture.
  $regionKeys = New-Object 'System.Collections.Generic.List[string]'
  foreach ($entry in $regionEntries) { $regionKeys.Add($entry.Key) }
  $regionKeyArray = $regionKeys.ToArray()
  $regionIndexArray = New-Object 'int[]' $regionEntries.Count
  for ($i = 0; $i -lt $regionEntries.Count; $i++) { $regionIndexArray[$i] = $regionEntries[$i].Index }
  [Array]::Sort($regionKeyArray, $regionIndexArray, [System.StringComparer]::Ordinal)

  $nonGeoKeyArray = New-Object 'int[]' $nonGeoEntries.Count
  $nonGeoIndexArray = New-Object 'int[]' $nonGeoEntries.Count
  for ($i = 0; $i -lt $nonGeoEntries.Count; $i++) {
    $nonGeoKeyArray[$i] = $nonGeoEntries[$i].Key
    $nonGeoIndexArray[$i] = $nonGeoEntries[$i].Index
  }
  [Array]::Sort($nonGeoKeyArray, $nonGeoIndexArray)

  # Country calling code -> territory indices (main country first), mirroring
  # BuildMetadataFromXml.buildCountryCodeToRegionCodeMap.
  $countryCodeMap = New-Object 'System.Collections.Generic.Dictionary[int,object]'
  for ($i = 0; $i -lt $territories.Count; $i++) {
    $code = $territories[$i].CountryCode
    if (-not $countryCodeMap.ContainsKey($code)) {
      $countryCodeMap[$code] = New-Object 'System.Collections.Generic.List[int]'
    }
    if ($territories[$i].MainCountryForCode) {
      $countryCodeMap[$code].Insert(0, $i)
    } else {
      $countryCodeMap[$code].Add($i)
    }
  }
  $countryCodes = New-Object 'int[]' $countryCodeMap.Count
  $countryCodeMap.Keys.CopyTo($countryCodes, 0)
  [Array]::Sort($countryCodes)

  $countryCodeRegions = New-Object 'System.Collections.Generic.List[int]'
  $countryCodeGroups = New-Object 'System.Collections.Generic.List[object]'
  foreach ($code in $countryCodes) {
    $list = $countryCodeMap[$code]
    $countryCodeGroups.Add([pscustomobject]@{
      CountryCode  = $code
      RegionOffset = $countryCodeRegions.Count
      RegionCount  = $list.Count
    })
    foreach ($index in $list) {
      $countryCodeRegions.Add($index)
    }
  }

  # --- Descs unit ------------------------------------------------------------

  $descsUnitName = "$UnitNamespace.Descs"
  $descLines = New-GeneratedHeader -UnitName $descsUnitName -SourceLabel $sourceLabel -GeneratorLabel $GeneratorLabel -Purpose "Phone number descriptions (patterns, example numbers, possible length slices) for every territory and number type."
  $descLines.Add("interface")
  $descLines.Add("")
  $descLines.Add("uses")
  $descLines.Add("  LibPhoneNumber.Metadata.Types;")
  $descLines.Add("")
  $descLines.Add("const")
  $descLines.Add("  PhoneMetadataDescCount = $($descRows.Count);")
  $descLines.Add("")
  $descLines.Add("  PhoneMetadataDescs: array[0..$($descRows.Count - 1)] of TPhoneNumberDescRec = (")
  for ($i = 0; $i -lt $descRows.Count; $i++) {
    $row = $descRows[$i]
    $suffix = ","
    if ($i -eq ($descRows.Count - 1)) { $suffix = "" }
    $descLines.Add("    { $($row.Owner) $($row.Kind) }")
    $descLines.Add("    (HasData: $(ConvertTo-PascalBoolean $row.HasData);")
    $descLines.Add("     NationalNumberPattern: $(ConvertTo-PascalLiteral $row.Pattern);")
    $descLines.Add("     ExampleNumber: $(ConvertTo-PascalLiteral $row.ExampleNumber);")
    $descLines.Add("     LengthOffset: $($row.LengthOffset); LengthCount: $($row.LengthCount);")
    $descLines.Add("     LocalOnlyOffset: $($row.LocalOnlyOffset); LocalOnlyCount: $($row.LocalOnlyCount))$suffix")
  }
  $descLines.Add("  );")
  $descLines.Add("")
  $descLines.Add("implementation")
  $descLines.Add("")
  $descLines.Add("end.")

  $formatsUnitName = "$UnitNamespace.Formats"
  $formatLines = New-GeneratedHeader -UnitName $formatsUnitName -SourceLabel $sourceLabel -GeneratorLabel $GeneratorLabel -Purpose "Number format tables (national and international) plus the shared leadingDigits pattern pool."
  $formatLines.Add("interface")
  $formatLines.Add("")
  $formatLines.Add("uses")
  $formatLines.Add("  LibPhoneNumber.Metadata.Types;")
  $formatLines.Add("")
  $formatLines.Add("const")
  $formatLines.Add("  PhoneMetadataNumberFormatCount = $($formatRows.Count);")
  $formatLines.Add("  PhoneMetadataIntlNumberFormatCount = $($intlFormatRows.Count);")
  $formatLines.Add("  PhoneMetadataLeadingDigitsCount = $($leadingDigitsPool.Count);")
  $formatLines.Add("")
  if ($leadingDigitsPool.Count -eq 0) {
    # Pascal has no empty array type; the count constant above is what callers
    # read, exactly like Add-FormatTable does for an empty format table.
    $formatLines.Add("  PhoneMetadataLeadingDigits: array[0..0] of string = (")
    $formatLines.Add("    ''")
    $formatLines.Add("  );")
  } else {
    $formatLines.Add("  PhoneMetadataLeadingDigits: array[0..$($leadingDigitsPool.Count - 1)] of string = (")
    for ($i = 0; $i -lt $leadingDigitsPool.Count; $i++) {
      $suffix = ","
      if ($i -eq ($leadingDigitsPool.Count - 1)) { $suffix = "" }
      $formatLines.Add("    $(ConvertTo-PascalLiteral $leadingDigitsPool[$i])$suffix")
    }
    $formatLines.Add("  );")
  }
  $formatLines.Add("")
  Add-FormatTable -Lines $formatLines -Name "PhoneMetadataNumberFormats" -Rows $formatRows
  $formatLines.Add("")
  Add-FormatTable -Lines $formatLines -Name "PhoneMetadataIntlNumberFormats" -Rows $intlFormatRows
  $formatLines.Add("")
  $formatLines.Add("implementation")
  $formatLines.Add("")
  $formatLines.Add("end.")

  # --- Data unit -------------------------------------------------------------

  $dataUnitName = "$UnitNamespace.Data"
  $dataLines = New-GeneratedHeader -UnitName $dataUnitName -SourceLabel $sourceLabel -GeneratorLabel $GeneratorLabel -Purpose "Territory table, possible length pool and the region / country calling code indices."
  $dataLines.Add("interface")
  $dataLines.Add("")
  $dataLines.Add("uses")
  $dataLines.Add("  LibPhoneNumber.Metadata.Types;")
  $dataLines.Add("")
  $dataLines.Add("const")
  $dataLines.Add("  MetadataGeneratorVersion = $(ConvertTo-PascalLiteral $GeneratorLabel);")
  $dataLines.Add("  MetadataSourceFile = $(ConvertTo-PascalLiteral $sourceLabel);")
  $dataLines.Add("  MetadataSourceCommit = $(ConvertTo-PascalLiteral $sourceCommitId);")
  $dataLines.Add("")
  $dataLines.Add("  PhoneMetadataTerritoryCount = $($territories.Count);")
  $dataLines.Add("  PhoneMetadataRegionCount = $($regionEntries.Count);")
  $dataLines.Add("  PhoneMetadataNonGeoCount = $($nonGeoEntries.Count);")
  $dataLines.Add("  PhoneMetadataCountryCodeCount = $($countryCodeGroups.Count);")
  $dataLines.Add("  PhoneMetadataPossibleLengthCount = $($lengthPool.Count);")
  $dataLines.Add("")

  foreach ($line in (Format-IntegerTable -Name "PhoneMetadataPossibleLengths" -ElementType "SmallInt" -Values $lengthPool -PerLine 24)) {
    $dataLines.Add($line)
  }
  $dataLines.Add("")

  $dataLines.Add("  PhoneMetadataTerritories: array[0..$($territories.Count - 1)] of TPhoneMetadataRec = (")
  for ($i = 0; $i -lt $territories.Count; $i++) {
    $territory = $territories[$i]
    $suffix = ","
    if ($i -eq ($territories.Count - 1)) { $suffix = "" }
    $dataLines.Add("    { $($territory.Id) cc=$($territory.CountryCode) }")
    $dataLines.Add("    (Id: $(ConvertTo-PascalLiteral $territory.Id);")
    $dataLines.Add("     CountryCode: $($territory.CountryCode);")
    $dataLines.Add("     LeadingDigits: $(ConvertTo-PascalLiteral $territory.LeadingDigits);")
    $dataLines.Add("     InternationalPrefix: $(ConvertTo-PascalLiteral $territory.InternationalPrefix);")
    $dataLines.Add("     PreferredInternationalPrefix: $(ConvertTo-PascalLiteral $territory.PreferredInternationalPrefix);")
    $dataLines.Add("     NationalPrefix: $(ConvertTo-PascalLiteral $territory.NationalPrefix);")
    $dataLines.Add("     NationalPrefixForParsing: $(ConvertTo-PascalLiteral $territory.NationalPrefixForParsing);")
    $dataLines.Add("     NationalPrefixTransformRule: $(ConvertTo-PascalLiteral $territory.NationalPrefixTransformRule);")
    $dataLines.Add("     PreferredExtnPrefix: $(ConvertTo-PascalLiteral $territory.PreferredExtnPrefix);")
    $dataLines.Add("     MainCountryForCode: $(ConvertTo-PascalBoolean $territory.MainCountryForCode);")
    $dataLines.Add("     MobileNumberPortableRegion: $(ConvertTo-PascalBoolean $territory.MobileNumberPortableRegion);")
    $dataLines.Add("     SameMobileAndFixedLinePattern: $(ConvertTo-PascalBoolean $territory.SameMobileAndFixedLinePattern);")
    $dataLines.Add("     DescOffset: $($territory.DescOffset);")
    $dataLines.Add("     FormatOffset: $($territory.FormatOffset); FormatCount: $($territory.FormatCount);")
    $dataLines.Add("     IntlFormatOffset: $($territory.IntlFormatOffset); IntlFormatCount: $($territory.IntlFormatCount))$suffix")
  }
  $dataLines.Add("  );")
  $dataLines.Add("")

  $regionOrderList = New-Object 'System.Collections.Generic.List[int]'
  foreach ($value in $regionIndexArray) { $regionOrderList.Add($value) }
  $dataLines.Add("  { Territory indices of the geographical regions, sorted by ordinal region code. }")
  foreach ($line in (Format-IntegerTable -Name "PhoneMetadataRegionOrder" -ElementType "SmallInt" -Values $regionOrderList -PerLine 20)) {
    $dataLines.Add($line)
  }
  $dataLines.Add("")

  $dataLines.Add("  { Region codes of the geographical regions, sorted by ordinal region code. }")
  $dataLines.Add("  PhoneMetadataRegionCodes: array[0..$($regionKeyArray.Length - 1)] of string = (")
  $buffer = New-Object 'System.Collections.Generic.List[string]'
  for ($i = 0; $i -lt $regionKeyArray.Length; $i++) {
    $suffix = ","
    if ($i -eq ($regionKeyArray.Length - 1)) { $suffix = "" }
    $buffer.Add("$(ConvertTo-PascalLiteral $regionKeyArray[$i])$suffix")
    if ($buffer.Count -ge 10 -or $i -eq ($regionKeyArray.Length - 1)) {
      $dataLines.Add("    " + ($buffer -join " "))
      $buffer.Clear()
    }
  }
  $dataLines.Add("  );")
  $dataLines.Add("")

  $nonGeoOrderList = New-Object 'System.Collections.Generic.List[int]'
  foreach ($value in $nonGeoIndexArray) { $nonGeoOrderList.Add($value) }
  $dataLines.Add("  { Territory indices of the non geographical entities, sorted by country calling code. }")
  foreach ($line in (Format-IntegerTable -Name "PhoneMetadataNonGeoOrder" -ElementType "SmallInt" -Values $nonGeoOrderList -PerLine 20)) {
    $dataLines.Add($line)
  }
  $dataLines.Add("")

  $nonGeoCodeList = New-Object 'System.Collections.Generic.List[int]'
  foreach ($value in $nonGeoKeyArray) { $nonGeoCodeList.Add($value) }
  $dataLines.Add("  { Country calling codes of the non geographical entities, ascending. }")
  foreach ($line in (Format-IntegerTable -Name "PhoneMetadataNonGeoCallingCodes" -ElementType "Integer" -Values $nonGeoCodeList -PerLine 20)) {
    $dataLines.Add($line)
  }
  $dataLines.Add("")

  $dataLines.Add("  { Country calling code groups, ascending by calling code. }")
  $dataLines.Add("  PhoneMetadataCountryCodeGroups: array[0..$($countryCodeGroups.Count - 1)] of TCountryCodeGroupRec = (")
  for ($i = 0; $i -lt $countryCodeGroups.Count; $i++) {
    $group = $countryCodeGroups[$i]
    $suffix = ","
    if ($i -eq ($countryCodeGroups.Count - 1)) { $suffix = "" }
    $dataLines.Add("    (CountryCode: $($group.CountryCode); RegionOffset: $($group.RegionOffset); RegionCount: $($group.RegionCount))$suffix")
  }
  $dataLines.Add("  );")
  $dataLines.Add("")

  $dataLines.Add("  { Territory indices per calling code group, main country for code first. }")
  foreach ($line in (Format-IntegerTable -Name "PhoneMetadataCountryCodeRegions" -ElementType "SmallInt" -Values $countryCodeRegions -PerLine 20)) {
    $dataLines.Add($line)
  }
  $dataLines.Add("")
  $dataLines.Add("implementation")
  $dataLines.Add("")
  $dataLines.Add("end.")

  $exampleCount = 0
  foreach ($row in $descRows) {
    if ($row.ExampleNumber -ne "") { $exampleCount++ }
  }

  return [pscustomobject]@{
    SourceLabel    = $sourceLabel
    GeneratorLabel = $GeneratorLabel
    Units          = @(
      [pscustomobject]@{ Name = $dataUnitName;    Lines = $dataLines },
      [pscustomobject]@{ Name = $descsUnitName;   Lines = $descLines },
      [pscustomobject]@{ Name = $formatsUnitName; Lines = $formatLines }
    )
    Territories       = $territories.Count
    Regions           = $regionEntries.Count
    NonGeo            = $nonGeoEntries.Count
    CountryCodes      = $countryCodeGroups.Count
    Descs             = $descRows.Count
    Examples          = $exampleCount
    NationalFormats   = $formatRows.Count
    IntlFormats       = $intlFormatRows.Count
    LeadingDigits     = $leadingDigitsPool.Count
    PossibleLengths   = $lengthPool.Count
    PatternGate       = $script:PatternGateCount - $patternGateBefore
    NonAscii          = $script:NonAsciiCount - $nonAsciiBefore
  }
}

$phoneMetadata = Invoke-PhoneMetadataBuild -XmlPath $MetadataXmlPath -UnitNamespace "LibPhoneNumber.Metadata" -GeneratorLabel $generatorVersion

# The upstream TEST data set. Only the test programs
# link these units; no unit under src/ references them, so a production
# binary never pulls them in.
$testingMetadata = Invoke-PhoneMetadataBuild -XmlPath $TestingMetadataXmlPath -UnitNamespace "LibPhoneNumber.TestingMetadata" -GeneratorLabel $testingGeneratorVersion

# ---------------------------------------------------------------------------
# Short number metadata
#
# The isShortNumberMetadata = true path of BuildMetadataFromXml. Everything the
# phone metadata needs and the short number metadata does not - territory
# attributes, number formats, the intl format list, the country calling code
# index, the non geographical entities - is simply absent here: the XML carries
# a single attribute per territory (id) and no <numberFormat> at all, and
# ShortNumberInfo looks its metadata up by REGION CODE only.
# ---------------------------------------------------------------------------

$shortGeneratorVersion = "short-metadata-v1"

# Upstream setRelevantDescPatterns, short branch, with generalDesc first (it is
# the parent description). expandedEmergency exists in the XML but upstream
# does not read it, so it is not in this list either.
$shortDescKindTags = @(
  @{ Kind = "sdkGeneralDesc";     Tag = "generalDesc" },
  @{ Kind = "sdkStandardRate";    Tag = "standardRate" },
  @{ Kind = "sdkShortCode";       Tag = "shortCode" },
  @{ Kind = "sdkCarrierSpecific"; Tag = "carrierSpecific" },
  @{ Kind = "sdkEmergency";       Tag = "emergency" },
  @{ Kind = "sdkTollFree";        Tag = "tollFree" },
  @{ Kind = "sdkPremiumRate";     Tag = "premiumRate" },
  @{ Kind = "sdkSmsServices";     Tag = "smsServices" }
)

$shortPatternGateBefore = $script:PatternGateCount
$shortNonAsciiBefore = $script:NonAsciiCount

Write-Info ""
Write-Info "Reading upstream short number metadata: $ShortMetadataXmlPath"

$shortDocument = New-Object System.Xml.XmlDocument
$shortDocument.PreserveWhitespace = $false
$shortReaderSettings = New-Object System.Xml.XmlReaderSettings
$shortReaderSettings.DtdProcessing = [System.Xml.DtdProcessing]::Parse
$shortReaderSettings.XmlResolver = $null
$shortReader = [System.Xml.XmlReader]::Create($ShortMetadataXmlPath, $shortReaderSettings)
try {
  $shortDocument.Load($shortReader)
} finally {
  $shortReader.Dispose()
}
$shortDocument.DocumentElement.Normalize()

$shortTerritoryNodes = $shortDocument.DocumentElement.GetElementsByTagName("territory")
$shortTerritories = New-Object 'System.Collections.Generic.List[object]'

for ($t = 0; $t -lt $shortTerritoryNodes.Count; $t++) {
  $element = $shortTerritoryNodes.Item($t)

  $regionId = ""
  if ($element.HasAttribute("id")) {
    $regionId = $element.GetAttribute("id")
  }
  if ($regionId -eq "") {
    throw "Short number territory without an id attribute at index $t."
  }
  if ($regionId -eq "001") {
    throw "Short number metadata is not expected to carry non geographical entities, found '001'."
  }

  $shortTerritory = [pscustomobject]@{
    Id    = $regionId
    Descs = New-Object 'System.Collections.Generic.List[object]'
  }

  $shortGeneralDesc = Read-PhoneNumberDescElement -ParentDesc $null -CountryElement $element -NumberType "generalDesc" -RegionId $regionId
  Set-GeneralDescPossibleLengths -GeneralDesc $shortGeneralDesc -Element $element -RegionId $regionId -IsShortNumberMetadata

  foreach ($kindInfo in $shortDescKindTags) {
    if ($kindInfo.Tag -eq "generalDesc") {
      $shortTerritory.Descs.Add($shortGeneralDesc)
    } else {
      $shortTerritory.Descs.Add((Read-PhoneNumberDescElement -ParentDesc $shortGeneralDesc -CountryElement $element -NumberType $kindInfo.Tag -RegionId $regionId))
    }
  }

  $shortTerritories.Add($shortTerritory)
}

Write-Info ("Parsed short number territories: {0}" -f $shortTerritories.Count)

$shortLengthPool = New-Object 'System.Collections.Generic.List[int]'
$shortLengthPoolIndex = New-Object 'System.Collections.Generic.Dictionary[string,int]'

$shortDescRows = New-Object 'System.Collections.Generic.List[object]'

foreach ($shortTerritory in $shortTerritories) {
  $shortTerritory | Add-Member -NotePropertyName DescOffset -NotePropertyValue $shortDescRows.Count -Force

  for ($k = 0; $k -lt $shortDescKindTags.Count; $k++) {
    $desc = $shortTerritory.Descs[$k]
    if ($desc.LocalOnlyLengths.Count -ne 0) {
      throw "Short number description $($shortTerritory.Id)/$($shortDescKindTags[$k].Tag) carries local-only lengths."
    }
    $shortDescRows.Add([pscustomobject]@{
      Owner         = $shortTerritory.Id
      Kind          = $shortDescKindTags[$k].Tag
      HasData       = $desc.HasData
      Pattern       = $desc.NationalNumberPattern
      ExampleNumber = $desc.ExampleNumber
      LengthOffset  = (Add-LengthRun -Pool $shortLengthPool -Index $shortLengthPoolIndex -Values $desc.Lengths)
      LengthCount   = $desc.Lengths.Count
    })
  }
}

# Region index, ordinal ordering, exactly like the phone metadata one.
$shortRegionKeyArray = New-Object 'string[]' $shortTerritories.Count
$shortRegionIndexArray = New-Object 'int[]' $shortTerritories.Count
for ($i = 0; $i -lt $shortTerritories.Count; $i++) {
  $shortRegionKeyArray[$i] = $shortTerritories[$i].Id
  $shortRegionIndexArray[$i] = $i
}
[Array]::Sort($shortRegionKeyArray, $shortRegionIndexArray, [System.StringComparer]::Ordinal)

for ($i = 1; $i -lt $shortRegionKeyArray.Length; $i++) {
  if ($shortRegionKeyArray[$i] -ceq $shortRegionKeyArray[$i - 1]) {
    throw "Duplicate short number territory id '$($shortRegionKeyArray[$i])'."
  }
}

# --- Short descs unit ------------------------------------------------------

$shortDescsUnitName = "LibPhoneNumber.ShortMetadata.Descs"
$shortDescLines = New-GeneratedHeader -UnitName $shortDescsUnitName -SourceLabel $shortSourceLabel -GeneratorLabel $shortGeneratorVersion -Purpose "Short number descriptions (patterns, example numbers, possible length slices) for every territory and short number desc kind."
$shortDescLines.Add("interface")
$shortDescLines.Add("")
$shortDescLines.Add("uses")
$shortDescLines.Add("  LibPhoneNumber.Metadata.Types;")
$shortDescLines.Add("")
$shortDescLines.Add("const")
$shortDescLines.Add("  ShortMetadataDescCount = $($shortDescRows.Count);")
$shortDescLines.Add("")
$shortDescLines.Add("  { Short number metadata never carries local-only lengths (upstream")
$shortDescLines.Add("    setPossibleLengthsGeneralDesc throws if it finds any), so")
$shortDescLines.Add("    LocalOnlyOffset / LocalOnlyCount are zero throughout. The record type is")
$shortDescLines.Add("    shared with the phone metadata because upstream builds both through the")
$shortDescLines.Add("    same processPhoneNumberDescElement. }")
$shortDescLines.Add("  ShortMetadataDescs: array[0..$($shortDescRows.Count - 1)] of TPhoneNumberDescRec = (")
for ($i = 0; $i -lt $shortDescRows.Count; $i++) {
  $row = $shortDescRows[$i]
  $suffix = ","
  if ($i -eq ($shortDescRows.Count - 1)) { $suffix = "" }
  $shortDescLines.Add("    { $($row.Owner) $($row.Kind) }")
  $shortDescLines.Add("    (HasData: $(ConvertTo-PascalBoolean $row.HasData);")
  $shortDescLines.Add("     NationalNumberPattern: $(ConvertTo-PascalLiteral $row.Pattern);")
  $shortDescLines.Add("     ExampleNumber: $(ConvertTo-PascalLiteral $row.ExampleNumber);")
  $shortDescLines.Add("     LengthOffset: $($row.LengthOffset); LengthCount: $($row.LengthCount);")
  $shortDescLines.Add("     LocalOnlyOffset: 0; LocalOnlyCount: 0)$suffix")
}
$shortDescLines.Add("  );")
$shortDescLines.Add("")
$shortDescLines.Add("implementation")
$shortDescLines.Add("")
$shortDescLines.Add("end.")

# --- Short data unit -------------------------------------------------------

$shortDataUnitName = "LibPhoneNumber.ShortMetadata.Data"
$shortDataLines = New-GeneratedHeader -UnitName $shortDataUnitName -SourceLabel $shortSourceLabel -GeneratorLabel $shortGeneratorVersion -Purpose "Short number territory table, possible length pool and the region index."
$shortDataLines.Add("interface")
$shortDataLines.Add("")
$shortDataLines.Add("uses")
$shortDataLines.Add("  LibPhoneNumber.Metadata.Types;")
$shortDataLines.Add("")
$shortDataLines.Add("const")
$shortDataLines.Add("  ShortMetadataGeneratorVersion = $(ConvertTo-PascalLiteral $shortGeneratorVersion);")
$shortDataLines.Add("  ShortMetadataSourceFile = $(ConvertTo-PascalLiteral $shortSourceLabel);")
$shortDataLines.Add("  ShortMetadataSourceCommit = $(ConvertTo-PascalLiteral $sourceCommitId);")
$shortDataLines.Add("")
$shortDataLines.Add("  ShortMetadataTerritoryCount = $($shortTerritories.Count);")
$shortDataLines.Add("  ShortMetadataPossibleLengthCount = $($shortLengthPool.Count);")
$shortDataLines.Add("")

foreach ($line in (Format-IntegerTable -Name "ShortMetadataPossibleLengths" -ElementType "SmallInt" -Values $shortLengthPool -PerLine 24)) {
  $shortDataLines.Add($line)
}
$shortDataLines.Add("")

$shortDataLines.Add("  ShortMetadataTerritories: array[0..$($shortTerritories.Count - 1)] of TShortMetadataRec = (")
for ($i = 0; $i -lt $shortTerritories.Count; $i++) {
  $shortTerritory = $shortTerritories[$i]
  $suffix = ","
  if ($i -eq ($shortTerritories.Count - 1)) { $suffix = "" }
  $shortDataLines.Add("    (Id: $(ConvertTo-PascalLiteral $shortTerritory.Id); DescOffset: $($shortTerritory.DescOffset))$suffix")
}
$shortDataLines.Add("  );")
$shortDataLines.Add("")

$shortRegionOrderList = New-Object 'System.Collections.Generic.List[int]'
foreach ($value in $shortRegionIndexArray) { $shortRegionOrderList.Add($value) }
$shortDataLines.Add("  { Territory indices, sorted by ordinal region code. }")
foreach ($line in (Format-IntegerTable -Name "ShortMetadataRegionOrder" -ElementType "SmallInt" -Values $shortRegionOrderList -PerLine 20)) {
  $shortDataLines.Add($line)
}
$shortDataLines.Add("")

$shortDataLines.Add("  { Region codes, sorted by ordinal region code. }")
$shortDataLines.Add("  ShortMetadataRegionCodes: array[0..$($shortRegionKeyArray.Length - 1)] of string = (")
$buffer = New-Object 'System.Collections.Generic.List[string]'
for ($i = 0; $i -lt $shortRegionKeyArray.Length; $i++) {
  $suffix = ","
  if ($i -eq ($shortRegionKeyArray.Length - 1)) { $suffix = "" }
  $buffer.Add("$(ConvertTo-PascalLiteral $shortRegionKeyArray[$i])$suffix")
  if ($buffer.Count -ge 10 -or $i -eq ($shortRegionKeyArray.Length - 1)) {
    $shortDataLines.Add("    " + ($buffer -join " "))
    $buffer.Clear()
  }
}
$shortDataLines.Add("  );")
$shortDataLines.Add("")
$shortDataLines.Add("implementation")
$shortDataLines.Add("")
$shortDataLines.Add("end.")

# The short number run is complete here, so its counters are frozen BEFORE the
# next input starts adding to the two shared, script wide totals.
$shortPatternGateCount = $script:PatternGateCount - $shortPatternGateBefore
$shortNonAsciiCount = $script:NonAsciiCount - $shortNonAsciiBefore

# ---------------------------------------------------------------------------
# Alternate formats metadata
#
# The isAlternateFormatsMetadata = true path of BuildMetadataFromXml. Upstream
# loadCountryMetadata runs loadTerritoryTagMetadata and loadAvailableFormats and
# then SKIPS setRelevantDescPatterns entirely ("the alternate formats metadata
# does not need most of the patterns to be set"), so this data set is number
# formats and nothing else.
#
# The territories carry no id - buildCountryCodeToRegionCodeMap has an explicit
# "for alternate formats, there are no region codes at all" branch - so the only
# key is the country calling code, exactly like the consumer
# FormattingMetadataSource.getFormattingMetadataForCountryCallingCode, which
# PhoneNumberMatcher.checkNumberGroupingIsValid calls.
#
# Only the NATIONAL format list is emitted. That is the whole consumer surface
# (getNumberFormatList()); the input declares no <intlFormat> at all, and the
# generator refuses one so the omission can never go unnoticed.
# ---------------------------------------------------------------------------

$alternateGeneratorVersion = "alternate-formats-v1"

$alternatePatternGateBefore = $script:PatternGateCount
$alternateNonAsciiBefore = $script:NonAsciiCount

Write-Info ""
Write-Info "Reading upstream alternate formats metadata: $AlternateFormatsXmlPath"

$alternateDocument = New-Object System.Xml.XmlDocument
$alternateDocument.PreserveWhitespace = $false
$alternateReaderSettings = New-Object System.Xml.XmlReaderSettings
$alternateReaderSettings.DtdProcessing = [System.Xml.DtdProcessing]::Parse
$alternateReaderSettings.XmlResolver = $null
$alternateReader = [System.Xml.XmlReader]::Create($AlternateFormatsXmlPath, $alternateReaderSettings)
try {
  $alternateDocument.Load($alternateReader)
} finally {
  $alternateReader.Dispose()
}
$alternateDocument.DocumentElement.Normalize()

$alternateTerritoryNodes = $alternateDocument.DocumentElement.GetElementsByTagName("territory")
$alternateTerritories = New-Object 'System.Collections.Generic.List[object]'
$alternateSeenCodes = New-Object 'System.Collections.Generic.HashSet[int]'

for ($t = 0; $t -lt $alternateTerritoryNodes.Count; $t++) {
  $element = $alternateTerritoryNodes.Item($t)

  if (-not $element.HasAttribute("countryCode")) {
    throw "Alternate formats territory without a countryCode attribute at index $t."
  }
  $countryCode = [int]$element.GetAttribute("countryCode")
  if (-not $alternateSeenCodes.Add($countryCode)) {
    throw "Duplicate alternate formats country calling code $countryCode."
  }
  $context0 = "alt/$countryCode"

  # getNationalPrefix(element). The shipped file declares none, but the DTD
  # allows it and the formatting rules below are derived from it upstream.
  $nationalPrefix = ""
  if ($element.HasAttribute("nationalPrefix")) {
    $nationalPrefix = $element.GetAttribute("nationalPrefix")
  }

  $alternateTerritory = [pscustomobject]@{
    CountryCode = $countryCode
    Formats     = New-Object 'System.Collections.Generic.List[object]'
  }

  # --- loadAvailableFormats ------------------------------------------------
  $territoryPrefixRule = Get-PrefixFormattingRule -Element $element -NationalPrefix $nationalPrefix
  $territoryPrefixOptional = $element.HasAttribute("nationalPrefixOptionalWhenFormatting")
  $territoryCarrierRule = ""
  if ($element.HasAttribute("carrierCodeFormattingRule")) {
    $territoryCarrierRule = Invoke-ValidateRE -Regex (Get-CarrierCodeFormattingRule -Element $element -NationalPrefix $nationalPrefix) -Context "$context0/carrierCodeFormattingRule"
  }

  $formatNodes = $element.GetElementsByTagName("numberFormat")
  if ($formatNodes.Count -eq 0) {
    throw "Alternate formats territory $countryCode declares no numberFormat."
  }

  for ($f = 0; $f -lt $formatNodes.Count; $f++) {
    $formatElement = $formatNodes.Item($f)
    $context = "$context0/numberFormat[$f]"

    $prefixRule = ""
    if ($formatElement.HasAttribute("nationalPrefixFormattingRule")) {
      $prefixRule = Get-PrefixFormattingRule -Element $formatElement -NationalPrefix $nationalPrefix
    } elseif ($territoryPrefixRule -ne "") {
      $prefixRule = $territoryPrefixRule
    }

    if ($formatElement.HasAttribute("nationalPrefixOptionalWhenFormatting")) {
      $prefixOptional = ($formatElement.GetAttribute("nationalPrefixOptionalWhenFormatting") -eq "true")
    } else {
      $prefixOptional = $territoryPrefixOptional
    }

    $carrierRule = ""
    if ($formatElement.HasAttribute("carrierCodeFormattingRule")) {
      $carrierRule = Invoke-ValidateRE -Regex (Get-CarrierCodeFormattingRule -Element $formatElement -NationalPrefix $nationalPrefix) -Context "$context/carrierCodeFormattingRule"
    } elseif ($territoryCarrierRule -ne "") {
      $carrierRule = $territoryCarrierRule
    }

    $leadingDigits = New-Object 'System.Collections.Generic.List[string]'
    $leadingNodes = $formatElement.GetElementsByTagName("leadingDigits")
    for ($l = 0; $l -lt $leadingNodes.Count; $l++) {
      $leadingDigits.Add((Invoke-ValidateRE -Regex $leadingNodes.Item($l).InnerText -RemoveWhitespace -Context "$context/leadingDigits[$l]"))
    }
    # The consumer reads getLeadingDigitsPattern(0) with the comment "there is
    # only one leading digits pattern for alternate formats"; pin that.
    if ($leadingDigits.Count -gt 1) {
      throw "Alternate format $context declares $($leadingDigits.Count) leadingDigits patterns; upstream PhoneNumberMatcher reads only the first."
    }

    $pattern = Invoke-ValidateRE -Regex $formatElement.GetAttribute("pattern") -Context "$context/pattern"

    $formatValueNodes = $formatElement.GetElementsByTagName("format")
    if ($formatValueNodes.Count -ne 1) {
      throw "Exactly one <format> element expected for $context, found $($formatValueNodes.Count)."
    }
    $formatValue = $formatValueNodes.Item(0).InnerText

    # No consumer of this data set reads an international format, so an
    # <intlFormat> would be silently dropped. Refuse instead.
    $intlNodes = $formatElement.GetElementsByTagName("intlFormat")
    if ($intlNodes.Count -gt 0) {
      throw "Alternate format $context declares an <intlFormat>; the alternate formats data set carries national formats only."
    }

    $alternateTerritory.Formats.Add([pscustomobject]@{
      Pattern        = $pattern
      Format         = $formatValue
      LeadingDigits  = $leadingDigits
      PrefixRule     = $prefixRule
      PrefixOptional = $prefixOptional
      CarrierRule    = $carrierRule
    })
  }

  $alternateTerritories.Add($alternateTerritory)
}

Write-Info ("Parsed alternate formats territories: {0}" -f $alternateTerritories.Count)

# Ascending by calling code, so the lookup layer can binary search.
$alternateSorted = @($alternateTerritories | Sort-Object CountryCode)

$alternateLeadingDigitsPool = New-Object 'System.Collections.Generic.List[string]'
$alternateLeadingDigitsPoolIndex = New-Object 'System.Collections.Generic.Dictionary[string,int]'
$alternateFormatRows = New-Object 'System.Collections.Generic.List[object]'
$alternateGroups = New-Object 'System.Collections.Generic.List[object]'

foreach ($alternateTerritory in $alternateSorted) {
  $groupOffset = $alternateFormatRows.Count
  foreach ($format in $alternateTerritory.Formats) {
    $alternateFormatRows.Add([pscustomobject]@{
      Owner               = "cc=$($alternateTerritory.CountryCode)"
      Pattern             = $format.Pattern
      Format              = $format.Format
      LeadingDigitsOffset = (Add-LeadingDigitsRun -Pool $alternateLeadingDigitsPool -Index $alternateLeadingDigitsPoolIndex -Values $format.LeadingDigits)
      LeadingDigitsCount  = $format.LeadingDigits.Count
      PrefixRule          = $format.PrefixRule
      PrefixOptional      = $format.PrefixOptional
      CarrierRule         = $format.CarrierRule
      IntlKind            = "ifkInheritedFromNational"
      IntlValue           = ""
    })
  }
  $alternateGroups.Add([pscustomobject]@{
    CountryCode  = $alternateTerritory.CountryCode
    FormatOffset = $groupOffset
    FormatCount  = $alternateTerritory.Formats.Count
  })
}

# --- Alternate formats data unit -------------------------------------------

$alternateDataUnitName = "LibPhoneNumber.AlternateFormats.Data"
$alternateDataLines = New-GeneratedHeader -UnitName $alternateDataUnitName -SourceLabel $alternateSourceLabel -GeneratorLabel $alternateGeneratorVersion -Purpose "Alternate number format table plus its own leadingDigits pattern pool, keyed by country calling code."
$alternateDataLines.Add("interface")
$alternateDataLines.Add("")
$alternateDataLines.Add("uses")
$alternateDataLines.Add("  LibPhoneNumber.Metadata.Types;")
$alternateDataLines.Add("")
$alternateDataLines.Add("const")
$alternateDataLines.Add("  AlternateFormatsGeneratorVersion = $(ConvertTo-PascalLiteral $alternateGeneratorVersion);")
$alternateDataLines.Add("  AlternateFormatsSourceFile = $(ConvertTo-PascalLiteral $alternateSourceLabel);")
$alternateDataLines.Add("  AlternateFormatsSourceCommit = $(ConvertTo-PascalLiteral $sourceCommitId);")
$alternateDataLines.Add("")
$alternateDataLines.Add("  AlternateFormatsGroupCount = $($alternateGroups.Count);")
$alternateDataLines.Add("  AlternateFormatsNumberFormatCount = $($alternateFormatRows.Count);")
$alternateDataLines.Add("  AlternateFormatsLeadingDigitsCount = $($alternateLeadingDigitsPool.Count);")
$alternateDataLines.Add("")
$alternateDataLines.Add("  { leadingDigits pool of THIS data set. It is indexed by the")
$alternateDataLines.Add("    LeadingDigitsOffset of AlternateFormatsNumberFormats only - never by an")
$alternateDataLines.Add("    offset out of the phone metadata, and vice versa. }")
if ($alternateLeadingDigitsPool.Count -eq 0) {
  $alternateDataLines.Add("  AlternateFormatsLeadingDigits: array[0..0] of string = (")
  $alternateDataLines.Add("    ''")
  $alternateDataLines.Add("  );")
} else {
  $alternateDataLines.Add("  AlternateFormatsLeadingDigits: array[0..$($alternateLeadingDigitsPool.Count - 1)] of string = (")
  for ($i = 0; $i -lt $alternateLeadingDigitsPool.Count; $i++) {
    $suffix = ","
    if ($i -eq ($alternateLeadingDigitsPool.Count - 1)) { $suffix = "" }
    $alternateDataLines.Add("    $(ConvertTo-PascalLiteral $alternateLeadingDigitsPool[$i])$suffix")
  }
  $alternateDataLines.Add("  );")
}
$alternateDataLines.Add("")
$alternateDataLines.Add("  { National formats only; the alternate formats data set has no")
$alternateDataLines.Add("    international format list, and its consumer")
$alternateDataLines.Add("    (PhoneNumberMatcher.checkNumberGroupingIsValid) reads")
$alternateDataLines.Add("    getNumberFormatList() alone. IntlFormatKind is therefore")
$alternateDataLines.Add("    ifkInheritedFromNational throughout. }")
Add-FormatTable -Lines $alternateDataLines -Name "AlternateFormatsNumberFormats" -Rows $alternateFormatRows
$alternateDataLines.Add("")
$alternateDataLines.Add("  { Country calling code groups, ascending by calling code. }")
$alternateDataLines.Add("  AlternateFormatsGroups: array[0..$($alternateGroups.Count - 1)] of TAlternateFormatGroupRec = (")
for ($i = 0; $i -lt $alternateGroups.Count; $i++) {
  $group = $alternateGroups[$i]
  $suffix = ","
  if ($i -eq ($alternateGroups.Count - 1)) { $suffix = "" }
  $alternateDataLines.Add("    (CountryCode: $($group.CountryCode); FormatOffset: $($group.FormatOffset); FormatCount: $($group.FormatCount))$suffix")
}
$alternateDataLines.Add("  );")
$alternateDataLines.Add("")
$alternateDataLines.Add("implementation")
$alternateDataLines.Add("")
$alternateDataLines.Add("end.")

# ---------------------------------------------------------------------------
# Write output
#
# NOTHING is written before ALL FOUR models - production phone, testing phone,
# short number and alternate formats - are fully built and validated. The
# generator throws on a malformed input - a bad regex, an out-of-range possible
# length, a duplicate territory id, an alternate format with an <intlFormat> -
# and if the phone units were written first, a failure in one of the other
# inputs would leave freshly written phone units next to stale ones, i.e. a half
# updated src/ tree. All NINE units are therefore emitted here, after the last
# validation.
# ---------------------------------------------------------------------------

Write-Info ""
Write-Info "Writing generated units to: $OutputDir"
foreach ($unit in $phoneMetadata.Units) {
  [void](Write-GeneratedUnit -UnitName $unit.Name -Lines $unit.Lines)
}
[void](Write-GeneratedUnit -UnitName $shortDataUnitName -Lines $shortDataLines)
[void](Write-GeneratedUnit -UnitName $shortDescsUnitName -Lines $shortDescLines)
foreach ($unit in $testingMetadata.Units) {
  [void](Write-GeneratedUnit -UnitName $unit.Name -Lines $unit.Lines)
}
[void](Write-GeneratedUnit -UnitName $alternateDataUnitName -Lines $alternateDataLines)

$shortExampleCount = 0
foreach ($row in $shortDescRows) {
  if ($row.ExampleNumber -ne "") { $shortExampleCount++ }
}

function Write-PhoneMetadataSummary {
  param([Parameter(Mandatory = $true)]$Result, [Parameter(Mandatory = $true)][string]$Title)

  Write-Info ""
  Write-Info $Title
  Write-Info ("  source file            : {0}" -f $Result.SourceLabel)
  Write-Info ("  source commit          : {0}" -f $sourceCommitId)
  Write-Info ("  generator version      : {0}" -f $Result.GeneratorLabel)
  Write-Info ("  territories            : {0} ({1} regions, {2} non-geo)" -f $Result.Territories, $Result.Regions, $Result.NonGeo)
  Write-Info ("  country calling codes  : {0}" -f $Result.CountryCodes)
  Write-Info ("  descriptions           : {0} ({1} with example numbers)" -f $Result.Descs, $Result.Examples)
  Write-Info ("  number formats         : {0} national, {1} international" -f $Result.NationalFormats, $Result.IntlFormats)
  Write-Info ("  leadingDigits patterns : {0}" -f $Result.LeadingDigits)
  Write-Info ("  possible length values : {0}" -f $Result.PossibleLengths)
  Write-Info ("  regex gate             : {0} patterns compiled, 0 rejected" -f $Result.PatternGate)
  Write-Info ("  non-ASCII characters   : {0}" -f $Result.NonAscii)
}

Write-PhoneMetadataSummary -Result $phoneMetadata -Title "Metadata generation summary"
Write-PhoneMetadataSummary -Result $testingMetadata -Title "Testing metadata generation summary"
Write-Info ""
Write-Info "Short number metadata generation summary"
Write-Info ("  source file            : {0}" -f $shortSourceLabel)
Write-Info ("  generator version      : {0}" -f $shortGeneratorVersion)
Write-Info ("  territories            : {0}" -f $shortTerritories.Count)
Write-Info ("  descriptions           : {0} ({1} with example numbers)" -f $shortDescRows.Count, $shortExampleCount)
Write-Info ("  possible length values : {0}" -f $shortLengthPool.Count)
Write-Info ("  regex gate             : {0} patterns compiled, 0 rejected" -f $shortPatternGateCount)
Write-Info ("  non-ASCII characters   : {0}" -f $shortNonAsciiCount)

$alternatePatternGateCount = $script:PatternGateCount - $alternatePatternGateBefore
$alternateNonAsciiCount = $script:NonAsciiCount - $alternateNonAsciiBefore
Write-Info ""
Write-Info "Alternate formats metadata generation summary"
Write-Info ("  source file            : {0}" -f $alternateSourceLabel)
Write-Info ("  generator version      : {0}" -f $alternateGeneratorVersion)
Write-Info ("  country calling codes  : {0}" -f $alternateGroups.Count)
Write-Info ("  number formats         : {0} national, 0 international" -f $alternateFormatRows.Count)
Write-Info ("  leadingDigits patterns : {0}" -f $alternateLeadingDigitsPool.Count)
Write-Info ("  regex gate             : {0} patterns compiled, 0 rejected" -f $alternatePatternGateCount)
Write-Info ("  non-ASCII characters   : {0}" -f $alternateNonAsciiCount)

if (-not $SkipFpcCheck) {
  $fpcScript = Join-Path $PSScriptRoot "check_fpc_compile.ps1"
  if (Test-Path -LiteralPath $fpcScript) {
    Write-Info ""
    & $fpcScript -Quiet:$Quiet
  }
}
