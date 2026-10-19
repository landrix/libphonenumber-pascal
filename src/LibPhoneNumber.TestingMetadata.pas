unit LibPhoneNumber.TestingMetadata;

{
  The upstream TEST metadata data set.

  What this is
  ------------
  Upstream ships a second, much smaller phone metadata file,
  resources/PhoneNumberMetadataForTesting.xml, and its Java test suite runs
  against THAT file rather than against the shipped one
  (TestMetadataTestCase builds a PhoneNumberUtil over
  PhoneNumberMetadataProtoForTesting_* and installs it as the singleton). The
  file declares 36 territories instead of 254, and several of them - AR, AU,
  MX, UZ among others - deliberately describe number plans that differ from
  the production ones. It is a fixture, not a data update.

  tools/generate_metadata.ps1 runs the very same builder over that file and
  emits LibPhoneNumber.TestingMetadata.Data / .Descs / .Formats; this unit is
  the hand written half that hands the three generated tables to the lookup
  layer.

  Who links it
  ------------
  ONLY the DUnitX test project. No unit under src/ uses this unit, and this
  unit is the only one that names the three generated testing units, so a
  production binary cannot pull the test tables in - not even indirectly. That
  is the whole reason the switch works through a registration call instead of
  through a compile time switch inside
  LibPhoneNumber.Metadata: that unit must not know that a second data set
  exists.

  How to use it
  -------------
  Call UseTestingMetadata in the setup of a fixture and
  RestoreProductionMetadata in its teardown. Neither is thread safe (upstream's
  own setInstance is not either); switch while nothing else runs.

  Both drop the compiled pattern cache of LibPhoneNumber.Regex on the way.
  That is HYGIENE, not correctness: the cache is keyed by the pattern text, so
  an entry of the other data set is either unreachable or exactly the right
  one. It lives here rather than in LibPhoneNumber.UseMetadataTables so
  that the lookup layer does not have to depend on the regex layer above it -
  this unit is test-only anyway and may know both.

  Switching invalidates every metadata pointer
  --------------------------------------------
  PPhoneMetadataRec, PPhoneNumberDescRec and PNumberFormatRec values point into
  the tables of whichever data set was active when they were fetched, and the
  offsets they carry index that data set's pools. A switch in either direction
  therefore invalidates all of them at once - the same pointer then addresses a
  different territory. Fetch metadata inside the test, never in the fixture
  setup, and never keep such a pointer in a fixture field across a switch.

  What is NOT switched
  --------------------
  The SHORT number metadata. Upstream ShortNumberInfoTest extends
  TestMetadataTestCase, so its PhoneNumberUtil singleton reads the test phone
  metadata, but ShortNumberInfo.getInstance() still reads the PRODUCTION short
  number metadata - there is no ShortNumberMetadataForTesting.xml in the
  upstream resources at the pinned baseline. LibPhoneNumber.ShortMetadata
  is therefore untouched by this unit, which reproduces that split exactly.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
  LibPhoneNumber.Metadata.Types,
  LibPhoneNumber.TestingMetadata.Data,
  LibPhoneNumber.TestingMetadata.Descs,
  LibPhoneNumber.TestingMetadata.Formats;

{ The testing data set, ready to be handed to
  LibPhoneNumber.Metadata.UseMetadataTables. }
function TestingMetadataTables: TPhoneMetadataTables;

{ Installs the testing data set as the active metadata source and drops the
  compiled pattern cache. }
procedure UseTestingMetadata;

{ The counterpart for a fixture teardown: reinstalls the production data set
  and drops the compiled pattern cache the same way UseTestingMetadata does.
  LibPhoneNumber.Metadata.UseProductionMetadata alone would do the switch
  but not the (hygienic) cache drop. }
procedure RestoreProductionMetadata;

{ True while the testing data set is the active one. }
function IsTestingMetadataActive: Boolean;

{ Provenance of the GENERATED testing units, independent of what is active. }
function TestingMetadataVersion: string;
function TestingMetadataSourceName: string;
function TestingMetadataUpstreamCommit: string;

implementation

uses
  LibPhoneNumber.Metadata,
  LibPhoneNumber.Regex;

{ Deliberately a copy of LibPhoneNumber.Metadata.ProductionMetadataTables
  rather than a shared helper: the two generated data sets declare the very
  same CONSTANT names in different units, so the only thing that can tell them
  apart is the uses clause of the unit that reads them. A shared helper would
  have to see both units at once, which is exactly what must not happen. }
function TestingMetadataTables: TPhoneMetadataTables;
begin
  Result.GeneratorVersion := MetadataGeneratorVersion;
  Result.SourceFile := MetadataSourceFile;
  Result.SourceCommit := MetadataSourceCommit;

  Result.Territories := @PhoneMetadataTerritories;
  Result.TerritoryCount := PhoneMetadataTerritoryCount;

  Result.Descs := @PhoneMetadataDescs;
  Result.DescCount := PhoneMetadataDescCount;

  Result.NumberFormats := @PhoneMetadataNumberFormats;
  Result.NumberFormatCount := PhoneMetadataNumberFormatCount;
  Result.IntlNumberFormats := @PhoneMetadataIntlNumberFormats;
  Result.IntlNumberFormatCount := PhoneMetadataIntlNumberFormatCount;
  Result.LeadingDigits := @PhoneMetadataLeadingDigits;
  Result.LeadingDigitsCount := PhoneMetadataLeadingDigitsCount;

  Result.PossibleLengths := @PhoneMetadataPossibleLengths;
  Result.PossibleLengthCount := PhoneMetadataPossibleLengthCount;

  Result.RegionOrder := @PhoneMetadataRegionOrder;
  Result.RegionCodes := @PhoneMetadataRegionCodes;
  Result.RegionCount := PhoneMetadataRegionCount;

  Result.NonGeoOrder := @PhoneMetadataNonGeoOrder;
  Result.NonGeoCallingCodes := @PhoneMetadataNonGeoCallingCodes;
  Result.NonGeoCount := PhoneMetadataNonGeoCount;

  Result.CountryCodeGroups := @PhoneMetadataCountryCodeGroups;
  Result.CountryCodeRegions := @PhoneMetadataCountryCodeRegions;
  Result.CountryCodeCount := PhoneMetadataCountryCodeCount;
end;

procedure UseTestingMetadata;
begin
  UseMetadataTables(TestingMetadataTables);
  ClearPatternCache;
end;

procedure RestoreProductionMetadata;
begin
  UseProductionMetadata;
  ClearPatternCache;
end;

function IsTestingMetadataActive: Boolean;
begin
  Result := ActiveMetadataTables.Territories =
    PPhoneMetadataRecArray(@PhoneMetadataTerritories);
end;

function TestingMetadataVersion: string;
begin
  Result := MetadataGeneratorVersion;
end;

function TestingMetadataSourceName: string;
begin
  Result := MetadataSourceFile;
end;

function TestingMetadataUpstreamCommit: string;
begin
  Result := MetadataSourceCommit;
end;

end.
