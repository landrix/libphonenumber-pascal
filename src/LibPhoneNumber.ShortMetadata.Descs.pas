unit LibPhoneNumber.ShortMetadata.Descs;

{
  GENERATED FILE - DO NOT EDIT.

  Short number descriptions (patterns, example numbers, possible length slices) for every territory and short number desc kind.

  Source:    vendor/libphonenumber/resources/ShortNumberMetadata.xml
  Commit:    8d8d75272c351b60b87163db5328e439c53a6b56
  Generator: tools/generate_metadata.ps1 (short-metadata-v1)

  Regenerate with:
    pwsh -NoProfile -ExecutionPolicy Bypass -File tools/generate_metadata.ps1

  No generation timestamp is embedded on purpose: the output must stay
  byte identical for an unchanged input.
}

{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}

interface

uses
  LibPhoneNumber.Metadata.Types;

const
  ShortMetadataDescCount = 1928;

  { Short number metadata never carries local-only lengths (upstream
    setPossibleLengthsGeneralDesc throws if it finds any), so
    LocalOnlyOffset / LocalOnlyCount are zero throughout. The record type is
    shared with the phone metadata because upstream builds both through the
    same processPhoneNumberDescElement. }
  ShortMetadataDescs: array[0..1927] of TPhoneNumberDescRec = (
    { AC generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD shortCode }
    (HasData: True;
     NationalNumberPattern: '11[0268]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD emergency }
    (HasData: True;
     NationalNumberPattern: '11[0268]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD tollFree }
    (HasData: True;
     NationalNumberPattern: '11[0268]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[149]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE shortCode }
    (HasData: True;
     NationalNumberPattern: '112|445[16]|99[7-9]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE emergency }
    (HasData: True;
     NationalNumberPattern: '112|99[7-9]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE tollFree }
    (HasData: True;
     NationalNumberPattern: '112|99[7-9]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE smsServices }
    (HasData: True;
     NationalNumberPattern: '445\d';
     ExampleNumber: '4450';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[02]|19)|40404';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[02]|19)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[02]|19)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG shortCode }
    (HasData: True;
     NationalNumberPattern: '176|9(?:11|88|99)';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI shortCode }
    (HasData: True;
     NationalNumberPattern: '176|9(?:11|88)';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[15]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:6(?:000|1(?:06|11|23))|8\d\d)|65\d|89[12])|5\d{4}|1(?:[1349]\d|2[2-9])';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '123';
     ExampleNumber: '123';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|2[7-9])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6[01]\d\d)|2[7-9]|3[15]|41)';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL premiumRate }
    (HasData: True;
     NationalNumberPattern: '5\d{4}';
     ExampleNumber: '50000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL smsServices }
    (HasData: True;
     NationalNumberPattern: '131|5\d{4}';
     ExampleNumber: '131';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[148]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM shortCode }
    (HasData: True;
     NationalNumberPattern: '(?:1|8[1-7])\d\d|40404';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM emergency }
    (HasData: True;
     NationalNumberPattern: '10[1-3]';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM tollFree }
    (HasData: True;
     NationalNumberPattern: '10[1-3]';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO shortCode }
    (HasData: True;
     NationalNumberPattern: '11[235]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO emergency }
    (HasData: True;
     NationalNumberPattern: '11[235]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO tollFree }
    (HasData: True;
     NationalNumberPattern: '11[235]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01389]\d{1,4}';
     ExampleNumber: '';
     LengthOffset: 17; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR shortCode }
    (HasData: True;
     NationalNumberPattern: '000|1(?:0[0-35-7]|1[02-5]|2[015]|3[47]|4[478]|9)|3372|89338|911';
     ExampleNumber: '19';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '893\d\d';
     ExampleNumber: '89300';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR emergency }
    (HasData: True;
     NationalNumberPattern: '10[017]|911';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR tollFree }
    (HasData: True;
     NationalNumberPattern: '000|1(?:0[0-35-7]|1[0245]|2[015]|3[47]|4[478]|9)|911';
     ExampleNumber: '19';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:337|893\d)\d';
     ExampleNumber: '3370';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS generalDesc }
    (HasData: True;
     NationalNumberPattern: '[49]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS shortCode }
    (HasData: True;
     NationalNumberPattern: '40404|9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1268]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6(?:00[06]|1(?:17|23)))|2[0238]|3[03]|4(?:[0-247]|5[05]|84))|(?:2(?:066|20)|61|8108[1-' +
       '3])0';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '220\d|610|(?:206|810\d)\d\d';
     ExampleNumber: '610';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:[12]2|33|44)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|2[0238]|3[03]|4[0-247])|1(?:16\d\d|4[58])\d';
     ExampleNumber: '112';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT smsServices }
    (HasData: True;
     NationalNumberPattern: '206\d\d';
     ExampleNumber: '20600';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[0-27]\d{2,7}';
     ExampleNumber: '';
     LengthOffset: 28; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU standardRate }
    (HasData: True;
     NationalNumberPattern: '1(?:1[09]\d|24733)|225|767';
     ExampleNumber: '225';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU shortCode }
    (HasData: True;
     NationalNumberPattern: '000|1(?:06|1(?:00|2|9[46])|2(?:014[1-3]|[23]\d|(?:4|5\d)\d{2,3}|68[689]|72(?:20|3\d\d)|8(?:[013-' +
       '9]\d|2))|555|9\d{4,6})|225|7(?:33|67)';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:258885|55\d)';
     ExampleNumber: '1550';
     LengthOffset: 34; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU emergency }
    (HasData: True;
     NationalNumberPattern: '000|1(?:06|12)';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU tollFree }
    (HasData: True;
     NationalNumberPattern: '000|1(?:06|12|258885|55\d)|733';
     ExampleNumber: '000';
     LengthOffset: 36; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU premiumRate }
    (HasData: True;
     NationalNumberPattern: '1(?:2(?:34|456)|9\d{4,6})';
     ExampleNumber: '1234';
     LengthOffset: 39; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU smsServices }
    (HasData: True;
     NationalNumberPattern: '19\d{4,6}';
     ExampleNumber: '190000';
     LengthOffset: 44; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:00|18|76)|91[13]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW emergency }
    (HasData: True;
     NationalNumberPattern: '100|911';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW tollFree }
    (HasData: True;
     NationalNumberPattern: '100|911';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX generalDesc }
    (HasData: True;
     NationalNumberPattern: '[17]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX shortCode }
    (HasData: True;
     NationalNumberPattern: '112|75[12]\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX tollFree }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[148]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)|(?:404|880)0';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:404|880)\d';
     ExampleNumber: '4040';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:404|880)\d';
     ExampleNumber: '4040';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:16(?:00[06]|1(?:1[17]|23))|2(?:0[0-7]|[2-5]|6[0-26])|(?:[3-5]|7\d)\d\d)|1(?:18|2[78])\d\d?';
     ExampleNumber: '122';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA emergency }
    (HasData: True;
     NationalNumberPattern: '12[2-4]';
     ExampleNumber: '122';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:16\d{3}|2[2-4])';
     ExampleNumber: '122';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-689]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB shortCode }
    (HasData: True;
     NationalNumberPattern: '988|[2-689]11';
     ExampleNumber: '211';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '[468]11';
     ExampleNumber: '411';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB emergency }
    (HasData: True;
     NationalNumberPattern: '[2359]11';
     ExampleNumber: '211';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB tollFree }
    (HasData: True;
     NationalNumberPattern: '988|[2359]11';
     ExampleNumber: '211';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1579]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:[0-369]|5[1-4]|7[0-4]|8[0-29])|1[16-9]|2(?:[134]|2[0-5])|3(?:1\d?|6[3-6])|5[2-9])|5012|7' +
       '86|9594|[19]99|1(?:0(?:50|6\d)|33|4(?:0|1\d))\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:11|2[13])|(?:501|959)\d|786';
     ExampleNumber: '111';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD emergency }
    (HasData: True;
     NationalNumberPattern: '10[0-2]|[19]99';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD tollFree }
    (HasData: True;
     NationalNumberPattern: '10[0-26]|[19]99';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD smsServices }
    (HasData: True;
     NationalNumberPattern: '959\d';
     ExampleNumber: '9590';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-8]|16117|2(?:12|3[0-24])|313|414|5(?:1[05]|5[15]|66|95)|6(?:1[167]|36|6[16])|7(?:[07][01' +
       '7]|1[27-9]|22|33|65)|81[39])|[2-9]\d{3}|11[02679]|1(?:1600|45)0|1(?:[2-4]9|78)9|1[2-4]0[47]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[01]|12)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-35-8]|1[0269]|7(?:12|77)|813)|(?:116|8)\d{3}';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE premiumRate }
    (HasData: True;
     NationalNumberPattern: '1(?:2[03]|40)4|(?:1(?:[24]1|3[01])|[2-79]\d\d)\d';
     ExampleNumber: '1204';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE smsServices }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{3}';
     ExampleNumber: '2000';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF shortCode }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF emergency }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF tollFree }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d{3})?';
     ExampleNumber: '';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6(?:000|111))|50|6[06])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|50|6[06])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6\d{3})|50|6[06])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[0189]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[02]\d|12|4[01]|51|8[18]|9[169])|99[02489]|(?:0[167]|8[158]|9[148])\d{3}';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '0[67]\d{3}|88000|98555';
     ExampleNumber: '06000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH emergency }
    (HasData: True;
     NationalNumberPattern: '[19]99';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:0[167]|81)\d{3}|[19]99';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH premiumRate }
    (HasData: True;
     NationalNumberPattern: '9[148]\d{3}';
     ExampleNumber: '91000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH smsServices }
    (HasData: True;
     NationalNumberPattern: '88000|98555';
     ExampleNumber: '88000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[16-9]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1\d|5[2-9]|6[0-256])|611|7(?:10|77|979)|8[28]8|900';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '611|7(?:10|77)|888|900';
     ExampleNumber: '611';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI emergency }
    (HasData: True;
     NationalNumberPattern: '11[237]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI tollFree }
    (HasData: True;
     NationalNumberPattern: '11[237]|611';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:71|90)0';
     ExampleNumber: '710';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[17]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:05|1[24-8]|2[02-5]|3[126-8]|5[05]|6[06]|89)|7[0-5]\d\d';
     ExampleNumber: '105';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '12[02-5]';
     ExampleNumber: '120';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ emergency }
    (HasData: True;
     NationalNumberPattern: '11[246-8]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[246-8]|3[68]|6[06])|7[3-5]\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d(?:\d\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 48; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL shortCode }
    (HasData: True;
     NationalNumberPattern: '18|3(?:00[0-79]|1[0-689]\d)|(?:118[02-9]|3[2469])\d\d';
     ExampleNumber: '18';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL emergency }
    (HasData: True;
     NationalNumberPattern: '18';
     ExampleNumber: '18';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL tollFree }
    (HasData: True;
     NationalNumberPattern: '18|3(?:00|1[0-689])\d';
     ExampleNumber: '18';
     LengthOffset: 51; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL premiumRate }
    (HasData: True;
     NationalNumberPattern: '3[2469]\d\d';
     ExampleNumber: '3200';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM shortCode }
    (HasData: True;
     NationalNumberPattern: '176|9(?:11|88)';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN shortCode }
    (HasData: True;
     NationalNumberPattern: '99[135]';
     ExampleNumber: '991';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN emergency }
    (HasData: True;
     NationalNumberPattern: '99[135]';
     ExampleNumber: '991';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN tollFree }
    (HasData: True;
     NationalNumberPattern: '99[135]';
     ExampleNumber: '991';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO shortCode }
    (HasData: True;
     NationalNumberPattern: '11[089]|40404';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO emergency }
    (HasData: True;
     NationalNumberPattern: '11[089]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO tollFree }
    (HasData: True;
     NationalNumberPattern: '11[089]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|76)|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ emergency }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ tollFree }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-69]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR standardRate }
    (HasData: True;
     NationalNumberPattern: '102|273\d\d|321';
     ExampleNumber: '102';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:[02]|3(?:1[2-579]|2[13-9]|3[124-9]|4[1-3578]|5[1-468]|6[139]|8[149]|9[168])|5[0-35-9]|6(' +
       '?:0|1[0-35-8]?|2[0145]|3[0137]?|4[37-9]?|5[0-35]|6[016]?|7[137]?|8[5-8]|9[1359]))|1[25-8]|2[357-' +
       '9]|3[024-68]|4[12568]|5\d|6[0-8]|8[015]|9[0-47-9])|2(?:7(?:330|878)|85959?)|(?:32|91)1|4(?:0404?' +
       '|57|828)|55555|6(?:0\d{4}|10000)|(?:133|411)[12]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '151|(?:278|555)\d\d|4(?:04\d\d?|11\d|57)';
     ExampleNumber: '151';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|28|9[023])|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:00|12|28|8[015]|9[0-47-9])|4(?:57|82\d)|911';
     ExampleNumber: '100';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR smsServices }
    (HasData: True;
     NationalNumberPattern: '285\d{2,3}|321|40404|(?:27[38]\d|482)\d|6(?:0\d|10)\d{3}';
     ExampleNumber: '321';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:1[19]|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS emergency }
    (HasData: True;
     NationalNumberPattern: '91[19]';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:1[19]|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT shortCode }
    (HasData: True;
     NationalNumberPattern: '11[0-6]|40404';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT emergency }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT tollFree }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:[02]|[6-9]\d\d)\d|1[0-2469]|3123)|9(?:1[0-4]|2[02-69]|9\d)|1[0-28]\d\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:[0-2]|31)\d\d|9(?:1[02-4]|2[02-69]|9[0-3])|1(?:[02]\d|1[49])';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW emergency }
    (HasData: True;
     NationalNumberPattern: '11[12]|9(?:11|9[7-9])';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW tollFree }
    (HasData: True;
     NationalNumberPattern: '11[0-246]|9(?:1[0-4]|2[02-69]|9[06-9])';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW smsServices }
    (HasData: True;
     NationalNumberPattern: '131\d\d';
     ExampleNumber: '13100';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-79]|1[246]|35|5[1-35]|6[89]|7[5-7]|8[58]|9[1-7])';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:0|11|22|66|77|9[09])';
     ExampleNumber: '90';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:0|11|90)';
     ExampleNumber: '90';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:0|11|22|66|77|9[09])';
     ExampleNumber: '90';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA shortCode }
    (HasData: True;
     NationalNumberPattern: '[1-35-9]\d{4,5}|112|[2-8]11|9(?:11|88)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '[235-7]11';
     ExampleNumber: '211';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA emergency }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA tollFree }
    (HasData: True;
     NationalNumberPattern: '112|988|[29]11';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA smsServices }
    (HasData: True;
     NationalNumberPattern: '[1-35-9]\d{4,5}';
     ExampleNumber: '10000';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC shortCode }
    (HasData: True;
     NationalNumberPattern: '000|112';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC emergency }
    (HasData: True;
     NationalNumberPattern: '000|112';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC tollFree }
    (HasData: True;
     NationalNumberPattern: '000|112';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[348]|23|77|88)|40404';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[348]|77|88)';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[348]|77|88)';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[478]|220)';
     ExampleNumber: '114';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[78]|220)';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[78]|22\d)';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG shortCode }
    (HasData: True;
     NationalNumberPattern: '11[126-8]';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG emergency }
    (HasData: True;
     NationalNumberPattern: '11[78]';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG tollFree }
    (HasData: True;
     NationalNumberPattern: '11[178]';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH standardRate }
    (HasData: True;
     NationalNumberPattern: '1(?:4[035]|6[1-46])|1(?:41|60)\d';
     ExampleNumber: '140';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[78]\d\d|1(?:[278]|45|6(?:000|111))|4(?:[02-57]|1[0145])|6(?:00|[1-46])|8(?:02|1[189]|[25]0' +
       '|7|8[08]|99))|[2-9]\d{2,4}';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '5(?:200|35)';
     ExampleNumber: '535';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[278]|44)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[278]|6\d{3})|4[247])|5200';
     ExampleNumber: '112';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH premiumRate }
    (HasData: True;
     NationalNumberPattern: '1(?:14|8[0-2589])\d|543|83111';
     ExampleNumber: '543';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH smsServices }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{2,4}';
     ExampleNumber: '200';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[01]|[78]0)|4443';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '444\d';
     ExampleNumber: '4440';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[01]|[78]0)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[01]|[78]0)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI smsServices }
    (HasData: True;
     NationalNumberPattern: '444\d';
     ExampleNumber: '4440';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK shortCode }
    (HasData: True;
     NationalNumberPattern: '99[689]';
     ExampleNumber: '996';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK emergency }
    (HasData: True;
     NationalNumberPattern: '99[689]';
     ExampleNumber: '996';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK tollFree }
    (HasData: True;
     NationalNumberPattern: '99[689]';
     ExampleNumber: '996';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL standardRate }
    (HasData: True;
     NationalNumberPattern: '(?:200|333)\d';
     ExampleNumber: '2000';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:00|21[13]|3(?:13|[348]0|5[01])|4(?:0[02-6]|17|[379])|818|919)|2(?:0(?:01|122)|22[47]|323|777' +
       '|882)|3(?:0(?:51|99)|132|3(?:29|[37]7)|665)|43656|5(?:(?:00|415)4|5(?:66|77)|995)|6(?:131|222|36' +
       '6|699)|7878|8(?:011|11[28]|482|889)|9(?:01|1)1|13\d|4(?:[13]42|243|4(?:02|15|77)|554)|(?:1(?:[05' +
       ']6|98)|339|6(?:07|[35])0|9(?:[12]0|33))0';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL emergency }
    (HasData: True;
     NationalNumberPattern: '13[1-3]|911';
     ExampleNumber: '131';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:213|3[1-3])|434\d|911';
     ExampleNumber: '131';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL premiumRate }
    (HasData: True;
     NationalNumberPattern: '1(?:211|3(?:13|[348]0|5[01]))|(?:1(?:[05]6|[48]1|9[18])|2(?:01\d|[23]2|77|88)|3(?:0[59]|13|3[279' +
       ']|66)|4(?:[12]4|36\d|4[017]|55)|5(?:00|41\d|5[67]|99)|6(?:07\d|13|22|3[06]|50|69)|787|8(?:[01]1|' +
       '[48]8)|9(?:01|[12]0|33))\d';
     ExampleNumber: '1060';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL smsServices }
    (HasData: True;
     NationalNumberPattern: '13(?:13|[348]0|5[01])|(?:1(?:[05]6|[28]1|4[01]|9[18])|2(?:0(?:0|1\d)|[23]2|77|88)|3(?:0[59]|13|3' +
       '[2379]|66)|436\d|5(?:00|41\d|5[67]|99)|6(?:07\d|13|22|3[06]|50|69)|787|8(?:[01]1|[48]8)|9(?:01|[' +
       '12]0|33))\d|4(?:[1-3]4|4[017]|55)\d';
     ExampleNumber: '1060';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[18]\d{1,3}';
     ExampleNumber: '';
     LengthOffset: 58; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[37]|[37])|8711';
     ExampleNumber: '13';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '871\d';
     ExampleNumber: '8710';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[37]|[37])';
     ExampleNumber: '13';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[37]|[37])';
     ExampleNumber: '13';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM smsServices }
    (HasData: True;
     NationalNumberPattern: '871\d';
     ExampleNumber: '8710';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d(?:\d(?:\d(?:\d(?:\d\d(?:\d{3,4})?)?)?)?)?';
     ExampleNumber: '';
     LengthOffset: 61; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN standardRate }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:(?:[0-2]\d|8)\d|6[3589]\d(?:\d{3}(?:\d{3,4})?)?)|1[24]|23(?:[0-8]\d|9[0-46-9])?|6[08])|9' +
       '[56]\d{3,4}|100';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:0(?:[0-2]\d|6(?:(?:[268]\d|[39](?:[0-49]|[5-8]\d{4}))\d\d|5)|8)|2[13]\d)\d|1[0249]|6[08])' +
       '|9[56]\d{3,4}|1(?:0(?:0|690\d{6})|2[023])';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[09]|20)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[09]|2(?:[02]|1\d\d|395))';
     ExampleNumber: '110';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN premiumRate }
    (HasData: True;
     NationalNumberPattern: '106[26]\d{4}';
     ExampleNumber: '10620000';
     LengthOffset: 68; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN smsServices }
    (HasData: True;
     NationalNumberPattern: '1(?:06\d\d(?:\d{3}(?:\d{3,4})?)?|2110)';
     ExampleNumber: '10600';
     LengthOffset: 69; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-589]\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:06|1[2-9]|2[35-7]|3[27]|4[467]|5[36]|6[4-7]|95)|(?:29002|39003)9|40404|5930\d\d|89\d{4}|[235' +
       '89][57]\d{3}';
     ExampleNumber: '106';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d|8(?:[57]|9\d)\d{3}';
     ExampleNumber: '40400';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[29]|23|32|56)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[29]|23|32|56)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d|8(?:[57]|9\d)\d{3}';
     ExampleNumber: '40400';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1359]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:00|15|2[2-4679])|1(?:1[0-35-9]|2|37|[46]6|7[57]|8[79]|9[0-379])|2(?:00|[12]2|34|55)|3(?:' +
       '21|33)|4(?:0[06]|1[4-6])|5(?:15|5[15])|693|7(?:00|1[7-9]|2[02]|[67]7)|975)|3855|5(?:0(?:30|49)|5' +
       '10)|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR emergency }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR tollFree }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:385|5(?:0[34]|51))\d';
     ExampleNumber: '3850';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12]\d\d(?:\d{3,4})?';
     ExampleNumber: '';
     LengthOffset: 73; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[4-7]|1(?:6111|8)|40)|2045252';
     ExampleNumber: '104';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU emergency }
    (HasData: True;
     NationalNumberPattern: '10[4-6]';
     ExampleNumber: '104';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU tollFree }
    (HasData: True;
     NationalNumberPattern: '10[4-7]|(?:116|204\d)\d{3}';
     ExampleNumber: '104';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV shortCode }
    (HasData: True;
     NationalNumberPattern: '13[0-2]';
     ExampleNumber: '130';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV emergency }
    (HasData: True;
     NationalNumberPattern: '13[0-2]';
     ExampleNumber: '130';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV tollFree }
    (HasData: True;
     NationalNumberPattern: '13[0-2]';
     ExampleNumber: '130';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|76)|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW emergency }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW tollFree }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX shortCode }
    (HasData: True;
     NationalNumberPattern: '000|112';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX emergency }
    (HasData: True;
     NationalNumberPattern: '000|112';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX tollFree }
    (HasData: True;
     NationalNumberPattern: '000|112';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d{3})?';
     ExampleNumber: '';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6(?:000|111))|99)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|99)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6\d{3})|99)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|8\d)|(?:2|3\d)\d{2,3}|5\d|99)|1(?:16|4)\d{3}';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|5\d)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6(?:00[06]|1(?:11|23)))|5\d)';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-46-8]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE shortCode }
    (HasData: True;
     NationalNumberPattern: '11(?:[025]|6(?:00[06]|1(?:1[167]|23))|800\d)|22(?:044|5(?:43|80)|7700|922)|33(?:11|3[34])|44844|' +
       '600\d\d|7(?:0\d{3}|464)|80808|118\d\d';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:33[13]|746)\d|(?:22(?:[059]|7\d)|(?:44|80)8|600|70\d)\d\d';
     ExampleNumber: '3310';
     LengthOffset: 76; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE emergency }
    (HasData: True;
     NationalNumberPattern: '11[02]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:[02]|6\d{3})';
     ExampleNumber: '110';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:333|746)\d|(?:22(?:[059]|7\d)|(?:44|80)8|600|70\d)\d\d';
     ExampleNumber: '3330';
     LengthOffset: 76; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ shortCode }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ emergency }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ tollFree }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[248]|6(?:00[06]|111))|619[0-2]|8(?:01|1[0238]|28|30|5[13]|8[18]))';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK emergency }
    (HasData: True;
     NationalNumberPattern: '11[24]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:[24]|6\d{3})';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[39]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM shortCode }
    (HasData: True;
     NationalNumberPattern: '333|9(?:11|88|99)';
     ExampleNumber: '333';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM emergency }
    (HasData: True;
     NationalNumberPattern: '333|9(?:11|99)';
     ExampleNumber: '333';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM tollFree }
    (HasData: True;
     NationalNumberPattern: '333|9(?:11|88|99)';
     ExampleNumber: '333';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO shortCode }
    (HasData: True;
     NationalNumberPattern: '112|9(?:11|88)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO emergency }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO tollFree }
    (HasData: True;
     NationalNumberPattern: '112|9(?:11|88)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[17]\d{1,3}';
     ExampleNumber: '';
     LengthOffset: 58; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:055|12|[47]|548)|730';
     ExampleNumber: '14';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '730';
     ExampleNumber: '730';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[47])';
     ExampleNumber: '14';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[47]|54\d)';
     ExampleNumber: '14';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ smsServices }
    (HasData: True;
     NationalNumberPattern: '730';
     ExampleNumber: '730';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[12]|12)|911';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[12]|12)|911';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[12]|12)|911';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[02-579]|6(?:000|111)|8(?:[09]\d|[1-8]))|2[36-9]|3[7-9]|4[05-7]|5[6-8]|6[05]|7[3-6]|8[02' +
       '-7]|9[3-9])|1(?:2[0-245]|3[0-6]|4[1-489]|5[0-59]|6[1-46-9]|7[0-27-9]|8[189]|9[0-2])\d\d?';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE emergency }
    (HasData: True;
     NationalNumberPattern: '11[02]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[02]|6\d{3})|2(?:05|28)|3(?:014|3(?:21|5\d?)|660)|492|5(?:1[03]|410|501)|6(?:112|333|644' +
       ')|7(?:012|127|89)|8(?:10|8[57])|9(?:0[134]|14))';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE premiumRate }
    (HasData: True;
     NationalNumberPattern: '1(?:18(?:00|[12458]\d?)|2(?:0(?:[02-46-8]\d?|1[0-36])|1(?:[0-4]\d?|6[06])|2(?:[0-4]\d?|5[25])|[3' +
       '67]|4(?:0[04]|[12]\d?|4[24]|54)|55[12457])|3(?:0(?:[02]\d?|1[13578]|3[356])|1[1347]|2[02-5]|3(?:' +
       '[01347]\d?|2[023]|88)|4(?:[35]\d?|4[34])|5(?:3[134]|5[035])|666)|4(?:2(?:00|4\d?)|4(?:0[01358]|1' +
       '[024]|50|7\d?)|900)|5(?:0[0-35]|1(?:[1267]\d?|5[0-7]|82)|2(?:[014-6]\d?|22)|330|4(?:[35]\d?|44)|' +
       '5(?:00|[1-69]\d?)|9(?:[159]\d?|[38]0|77))|6(?:1(?:00|1[19]|[35-9]\d?)|2(?:2[26]|[68]\d?)|3(?:22|' +
       '36|6[36])|5|6(?:[0-359]\d?|6[0-26])|7(?:00|55|7\d?|8[89])|9(?:00|1\d?|69))|7(?:0(?:[023]\d?|1[05' +
       '78])|1(?:00|2[034]|[4-9]\d?)|2(?:[07]\d?|20|44)|7(?:[0-57]\d?|9[79])|8(?:0[08]|2\d?|8[0178])|9(?' +
       ':00|97))|8(?:1[127]|8[1268]|9[269])|9(?:0(?:[02]\d?|69|9[0269])|1[1-3689]|21))';
     ExampleNumber: '123';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE smsServices }
    (HasData: True;
     NationalNumberPattern: '1(?:18[1258]|2(?:0(?:1[036]|[46]\d?)|166|21|4(?:0[04]|1\d?|5[47])|[67])|3(?:0(?:1[13-578]|2\d?|3' +
       '[56])|1[15]|2[045]|3(?:[13]\d?|2[13])|43|5(?:00|3[34]|53))|44(?:0[0135]|14|50|7\d?)|5(?:05|1(?:[' +
       '12]\d?|5[1246]|8[12])|2(?:[01]\d?|22)|3(?:00|3[03])|4(?:15|5\d?)|500|9(?:5\d?|77|80))|6(?:1[35-8' +
       ']|226|3(?:22|3[36]|66)|644|7(?:00|7\d?|89)|9(?:00|69))|7(?:01[258]|1(?:00|[15]\d?)|2(?:44|7\d?)|' +
       '8(?:00|87|9\d?))|8(?:1[128]|8[56]|9(?:[26]\d?|77))|90(?:2\d?|69|92))';
     ExampleNumber: '126';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:2[23]|[679]\d{3}|80)|34400';
     ExampleNumber: '122';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '344\d\d';
     ExampleNumber: '34400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:2[23]|80)';
     ExampleNumber: '122';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:2[23]|80)';
     ExampleNumber: '122';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG smsServices }
    (HasData: True;
     NationalNumberPattern: '344\d\d';
     ExampleNumber: '34400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[59]|77)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:[59]|77)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:[59]|77)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12]\d\d(?:\d{3})?';
     ExampleNumber: '';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[2-6]|24422)|20(?:1(?:606|917)|2914)|(?:1277|2020)99';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[2-46]|24422)|20(?:1(?:606|917)|2914)|(?:1277|2020)99';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER tollFree }
    (HasData: True;
     NationalNumberPattern: '11[2-46]|(?:12[47]|20[12])\d{3}';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES generalDesc }
    (HasData: True;
     NationalNumberPattern: '[0-379]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES standardRate }
    (HasData: True;
     NationalNumberPattern: '0(?:1[0-27]|2[148]|6[0-2]|80|9[12])|21\d{4}';
     ExampleNumber: '010';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES shortCode }
    (HasData: True;
     NationalNumberPattern: '0(?:1[0-267]|2[0148]|6[0-257]|8[058]|9[12])|1(?:0[03-57]\d{1,3}|1(?:2|6(?:000|111)|8\d\d)|2\d{1,' +
       '4}|[3-9]\d\d)|(?:2[0-2]\d|3[357]|[79]9[57])\d{3}|1(?:3[34]|77)|2(?:[2357]\d|80)\d\d|90(?:5[12457' +
       '8]|7)|2(?:2\d\d?|373)';
     ExampleNumber: '010';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:3[34]|77)|[12]2\d{1,4}';
     ExampleNumber: '120';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES emergency }
    (HasData: True;
     NationalNumberPattern: '08[58]|112';
     ExampleNumber: '085';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES tollFree }
    (HasData: True;
     NationalNumberPattern: '0(?:16|20|6[57]|8[58])|1(?:006|12|[3-7]\d\d)|2373|(?:116|20\d)\d{3}';
     ExampleNumber: '016';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES premiumRate }
    (HasData: True;
     NationalNumberPattern: '[12]2\d{1,4}|90(?:5\d|7)|(?:118|2(?:[357]\d|80)|3[357]\d)\d\d|[79]9[57]\d{3}';
     ExampleNumber: '120';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:2[0-2]\d|3[357]|[79]9[57])\d{3}|2(?:[2357]\d|80)\d\d';
     ExampleNumber: '22000';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:07|11?|2|39?|45|9[17])';
     ExampleNumber: '91';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11?|2|39?|9[17])';
     ExampleNumber: '91';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:07|11?|2|39?|9[17])';
     ExampleNumber: '91';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[17]\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI standardRate }
    (HasData: True;
     NationalNumberPattern: '1[2-8]\d{3}';
     ExampleNumber: '12000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI shortCode }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6(?:00[06]|1(?:1[17]|23)))|(?:1[2-8]\d|75[12])\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6\d{3})';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[0-579]\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 79; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ shortCode }
    (HasData: True;
     NationalNumberPattern: '0(?:1[34]|8[1-4])|1(?:0[1-3]|[25]9)|2[289]|30|40404|91[137]|[45]4|75';
     ExampleNumber: '22';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ emergency }
    (HasData: True;
     NationalNumberPattern: '91[17]';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ tollFree }
    (HasData: True;
     NationalNumberPattern: '91[17]';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK shortCode }
    (HasData: True;
     NationalNumberPattern: '1\d\d|999';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[39]\d\d(?:\d{3})?';
     ExampleNumber: '';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM shortCode }
    (HasData: True;
     NationalNumberPattern: '(?:32022|91)1';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM emergency }
    (HasData: True;
     NationalNumberPattern: '(?:32022|91)1';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM tollFree }
    (HasData: True;
     NationalNumberPattern: '320\d{3}|911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO shortCode }
    (HasData: True;
     NationalNumberPattern: '11[248]|1(?:4[124]|71|8[17-9]|9\d)\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO emergency }
    (HasData: True;
     NationalNumberPattern: '11[24]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[24]|81\d)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO smsServices }
    (HasData: True;
     NationalNumberPattern: '19\d\d';
     ExampleNumber: '1900';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-8]\d{1,5}';
     ExampleNumber: '';
     LengthOffset: 82; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR standardRate }
    (HasData: True;
     NationalNumberPattern: '202\d|6(?:1[14]|34)|70[06]';
     ExampleNumber: '611';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0\d\d|1(?:[02459]|6(?:00[06]|11[17])|8\d{3})|[578]|9[167])|2(?:0(?:00|2)0|24)|[3-8]\d{4}|3\d' +
       '{3}|6(?:1[14]|34)|7(?:0[06]|22|40)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '118777|224|6(?:1[14]|34)|7(?:0[06]|22|40)|20(?:0\d|2)\d';
     ExampleNumber: '224';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])';
     ExampleNumber: '15';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[02459]|[578]|9[167])|224|(?:3370|74)0|(?:116\d|3[01])\d\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:0|18\d)|366|[4-8]\d\d)\d\d|3[2-9]\d\d';
     ExampleNumber: '1000';
     LengthOffset: 76; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR smsServices }
    (HasData: True;
     NationalNumberPattern: '114|[3-8]\d{4}';
     ExampleNumber: '114';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 51; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:3\d\d|730|8)';
     ExampleNumber: '18';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:3\d\d|730|8)';
     ExampleNumber: '18';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA tollFree }
    (HasData: True;
     NationalNumberPattern: '18|1(?:3\d|73)\d';
     ExampleNumber: '18';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-46-9]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[015]|1(?:[129]|6(?:000|1(?:11|23))|8\d{3})|2(?:[1-3]|50)|33|4(?:1|7\d)|571|7(?:0\d|[56]0)|' +
       '800\d|9[15])|2(?:0202|1300|2(?:02|11)|3(?:02|336|45)|4(?:25|8))|3[13]3|4(?:0[02]|35[01]|44[45]|5' +
       '\d)|(?:[68]\d|7[089])\d{3}|15\d|2[02]2|650|789|9(?:01|99)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:25|7[56])\d|571)|2(?:02(?:\d{2})?|[13]3\d\d|48)|4444|901';
     ExampleNumber: '202';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB emergency }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:05|1(?:[29]|6\d{3})|7[56]\d|8000)|2(?:20\d|48)|4444|999';
     ExampleNumber: '105';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:125|2(?:020|13\d)|(?:7[089]|8[01])\d\d)\d';
     ExampleNumber: '1250';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD shortCode }
    (HasData: True;
     NationalNumberPattern: '176|9(?:11|88)';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[014]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE shortCode }
    (HasData: True;
     NationalNumberPattern: '0(?:11|33)|11[1-3]|40404|[01]22';
     ExampleNumber: '011';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE emergency }
    (HasData: True;
     NationalNumberPattern: '0(?:11|33)|11[1-3]|[01]22';
     ExampleNumber: '011';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE tollFree }
    (HasData: True;
     NationalNumberPattern: '0(?:11|33)|11[1-3]|[01]22';
     ExampleNumber: '011';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d(?:\d\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 48; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF shortCode }
    (HasData: True;
     NationalNumberPattern: '1[578]|300[0-79]|(?:118[02-9]\d|3(?:0[1-9]|1[0-689]|[2469]\d))\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF emergency }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF tollFree }
    (HasData: True;
     NationalNumberPattern: '1[578]|3(?:0\d|1[0-689])\d';
     ExampleNumber: '15';
     LengthOffset: 51; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF premiumRate }
    (HasData: True;
     NationalNumberPattern: '3[2469]\d\d';
     ExampleNumber: '3200';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[01]|1[12]|23|41|55|9[05])|999|1(?:1[68]\d\d|47|800)\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG emergency }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG tollFree }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14589]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH shortCode }
    (HasData: True;
     NationalNumberPattern: '19[1-3]|40404|(?:54|83)00|999';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d|(?:54|83)0\d';
     ExampleNumber: '5400';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH emergency }
    (HasData: True;
     NationalNumberPattern: '19[1-3]|999';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH tollFree }
    (HasData: True;
     NationalNumberPattern: '19[1-3]|999';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d|(?:54|83)0\d';
     ExampleNumber: '5400';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[158]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI standardRate }
    (HasData: True;
     NationalNumberPattern: '150|87\d\d';
     ExampleNumber: '150';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:00|1(?:[25]|6(?:00[06]|1(?:1[17]|23))|8\d\d)|23|4(?:1|7[014])|5[015]|9[02-49])|555|8[0-79]\d' +
       '\d|8(?:00|4[0-2]|8[0-589])';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:00|1(?:5|8\d\d)|23|51|9[2-4])|555|8(?:00|4[0-2]|8[0-589])';
     ExampleNumber: '100';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[09])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:00|1[25]|23|4(?:1|7\d)|5[15]|9[02-49])|555|(?:116\d|80)\d\d';
     ExampleNumber: '100';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI premiumRate }
    (HasData: True;
     NationalNumberPattern: '8[1-69]\d\d';
     ExampleNumber: '8100';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL shortCode }
    (HasData: True;
     NationalNumberPattern: '1[1-8]\d';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL tollFree }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[6-8]|[6-8])';
     ExampleNumber: '16';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[6-8]|[6-8])';
     ExampleNumber: '16';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[6-8]|[6-8])';
     ExampleNumber: '16';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN shortCode }
    (HasData: True;
     NationalNumberPattern: '12\d|40404';
     ExampleNumber: '120';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN emergency }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d(?:\d\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 48; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP shortCode }
    (HasData: True;
     NationalNumberPattern: '1[578]|3(?:00[0-79]|1[0-689]\d)|(?:118[02-9]|3[2469])\d\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP emergency }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP tollFree }
    (HasData: True;
     NationalNumberPattern: '1[578]|3(?:00|1[0-689])\d';
     ExampleNumber: '15';
     LengthOffset: 51; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP premiumRate }
    (HasData: True;
     NationalNumberPattern: '3[2469]\d\d';
     ExampleNumber: '3200';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR standardRate }
    (HasData: True;
     NationalNumberPattern: '113\d\d';
     ExampleNumber: '11300';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[089]|1(?:2|320|6(?:000|1(?:1[17]|23)))|(?:389|9)9|66)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:00|12|66|99)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[089]|1(?:2|6\d{3})|66|99)';
     ExampleNumber: '100';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT shortCode }
    (HasData: True;
     NationalNumberPattern: '110|40404|1(?:2|[57]\d)\d';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:10|2[03])';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:10|2[03])';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW shortCode }
    (HasData: True;
     NationalNumberPattern: '11[378]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW emergency }
    (HasData: True;
     NationalNumberPattern: '11[378]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW tollFree }
    (HasData: True;
     NationalNumberPattern: '11[378]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[019]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY shortCode }
    (HasData: True;
     NationalNumberPattern: '0(?:02|(?:17|80)1|444|7(?:[67]7|9)|9(?:0[78]|[2-47]))|1(?:443|5[568])|91[1-4]';
     ExampleNumber: '002';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '144\d';
     ExampleNumber: '1440';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY emergency }
    (HasData: True;
     NationalNumberPattern: '91[1-3]';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY tollFree }
    (HasData: True;
     NationalNumberPattern: '91[1-4]';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY smsServices }
    (HasData: True;
     NationalNumberPattern: '144\d';
     ExampleNumber: '1440';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,6}';
     ExampleNumber: '';
     LengthOffset: 87; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:(?:[0136]\d|2[14])\d{0,3}|8[138])|12|2(?:[0-3]\d{0,4}|(?:58|8[13])\d{0,3})|7(?:[135-9]\d' +
       '{0,4}|219\d{0,2})|8(?:0(?:(?:[13]|60\d)\d|8)|1(?:0\d|[2-8])|2(?:0[5-9]|(?:18|2)2|3|8[128])|(?:(?' +
       ':3[0-689]\d|7(?:2[1-389]|8[0235-9]|93))\d|8)\d|50[138]|6(?:1(?:11|86)|8)))|99[29]|10[0139]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '109|1(?:08|85\d)\d';
     ExampleNumber: '109';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK emergency }
    (HasData: True;
     NationalNumberPattern: '112|99[29]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK tollFree }
    (HasData: True;
     NationalNumberPattern: '112|99[29]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK smsServices }
    (HasData: True;
     NationalNumberPattern: '992';
     ExampleNumber: '992';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN shortCode }
    (HasData: True;
     NationalNumberPattern: '199|40404';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN emergency }
    (HasData: True;
     NationalNumberPattern: '199';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN tollFree }
    (HasData: True;
     NationalNumberPattern: '199';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[016-9]\d{1,5}';
     ExampleNumber: '';
     LengthOffset: 82; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR shortCode }
    (HasData: True;
     NationalNumberPattern: '(?:06|[6-8]\d{4})\d|1(?:1(?:2|6(?:00[06]|1(?:1[17]|23))|8\d\d)|3977|9(?:[2-5]|87))|9[34]';
     ExampleNumber: '93';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '139\d\d';
     ExampleNumber: '13900';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[2-4])|9[34]';
     ExampleNumber: '93';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[2-4])|9[34]|1(?:16\d|39)\d\d';
     ExampleNumber: '93';
     LengthOffset: 92; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR premiumRate }
    (HasData: True;
     NationalNumberPattern: '06\d|(?:118|[6-8]\d{3})\d\d';
     ExampleNumber: '060';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR smsServices }
    (HasData: True;
     NationalNumberPattern: '139\d\d';
     ExampleNumber: '13900';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT shortCode }
    (HasData: True;
     NationalNumberPattern: '11[48]|40404';
     ExampleNumber: '114';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT emergency }
    (HasData: True;
     NationalNumberPattern: '11[48]';
     ExampleNumber: '114';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT tollFree }
    (HasData: True;
     NationalNumberPattern: '11[48]';
     ExampleNumber: '114';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[457]|1(?:2|6(?:000|1(?:11|23))|800)|2(?:0[0-4]|1[013489]|2[0-5]|3[0-46]|4[0-24-68]|5[0-256' +
       '8]|6[06]|7[0-25-7]|8[028]|9[08])|37(?:00|37|7[07])|4(?:0[0-5]|1[013-8]|2[034]|3[23]|4[02-9]|5(?:' +
       '00|41|67))|777|8(?:1[27-9]|2[04]|40|[589]))';
     ExampleNumber: '104';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:4[0-4]|77)\d|1(?:18|2|45)\d\d';
     ExampleNumber: '1200';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[457]|12)';
     ExampleNumber: '104';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[457]|12|4[0-4]\d)|1(?:16\d|37|45)\d\d';
     ExampleNumber: '104';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU smsServices }
    (HasData: True;
     NationalNumberPattern: '184\d';
     ExampleNumber: '1840';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID generalDesc }
    (HasData: True;
     NationalNumberPattern: '[178]\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[02389]|40\d\d|50264)|71400|89887';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:714|898)\d\d';
     ExampleNumber: '71400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID emergency }
    (HasData: True;
     NationalNumberPattern: '11[02389]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID tollFree }
    (HasData: True;
     NationalNumberPattern: '11[02389]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID smsServices }
    (HasData: True;
     NationalNumberPattern: '714\d\d';
     ExampleNumber: '71400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[159]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE standardRate }
    (HasData: True;
     NationalNumberPattern: '51\d{3}';
     ExampleNumber: '51000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE shortCode }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6(?:00[06]|1(?:1[17]|23)))|999|(?:1(?:18|9)|5[0137]\d)\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '51210';
     ExampleNumber: '51210';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE emergency }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6\d{3})|999';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE premiumRate }
    (HasData: True;
     NationalNumberPattern: '5[37]\d{3}';
     ExampleNumber: '53000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE smsServices }
    (HasData: True;
     NationalNumberPattern: '51210|(?:118|5[037]\d)\d\d';
     ExampleNumber: '11800';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-2]|1(?:[013-9]\d|2)|[2-9]\d\d)|2407|(?:104|27)00';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '104\d\d';
     ExampleNumber: '10400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-2]|12)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-2]|12)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL smsServices }
    (HasData: True;
     NationalNumberPattern: '104\d\d';
     ExampleNumber: '10400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[189]\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM shortCode }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d{3})?|8(?:6444|9887)|999';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM smsServices }
    (HasData: True;
     NationalNumberPattern: '8(?:64|98)\d\d';
     ExampleNumber: '86400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12578]\d{2,8}';
     ExampleNumber: '';
     LengthOffset: 96; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN standardRate }
    (HasData: True;
     NationalNumberPattern: '5(?:14(?:2[5-9]|[34]\d)|757555)';
     ExampleNumber: '51425';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:[0-248]|3[39]|5(?:010|6)|6[3468]|7(?:[01357]|[28]0?|4[01])|9[0135-9])|1(?:00|[289])|2(?:' +
       '1|98)|3(?:11|2[0-2]|63|[89])|4[01]|5(?:1(?:0[0-36]|[127])|54)|6(?:1|6[01]?)|7000|8[12]|9(?:0[013' +
       '-59]|12|25|4[4-9]\d?|50|6[1347]|[89]))|2611|5(?:0(?:0(?:0\d|1|20?)|325|5[2-79]\d{3,5})|1(?:234|5' +
       '55|717|818|96[49])|2(?:0(?:0[01]|[14]0)|151|555|666|888|9(?:06|99\d?))|3(?:0[01]0|131|553|(?:66|' +
       '77)6)|(?:464|55[05])\d{1,3}|6(?:070|3[68]|43)|717\d)|777|800|5(?:05(?:0|1\d)|221|3(?:03|3[23]))\' +
       'd{1,4}|5(?:(?:04|88)0|2(?:2[0267]|3[16])|4(?:1[04]|20|3[02])|5(?:3[16]|67)|6(?:06|[67]\d)|787|9(' +
       '?:64|90))\d\d?|(?:1(?:05[79]|(?:1[67][0-2]|802)\d|55[23])\d|5(?:(?:00(?:0\d|1)|(?:304|616)\d\d)\' +
       'd|1(?:0[12]|4[2-4])|2(?:2[3589]|3(?:1\d{3}|2)|4[04]|7[78])|4(?:[02]4|32\d{4}|4[04]|99)|5(?:1[25]' +
       '|[36]5|4[45]|93)|7(?:(?:17\d|57)\d\d|[27]7|88)|8(?:3[4-69]|4[01]|5[58]|88(?:8\d\d|9)|99)|9(?:0(?' +
       ':0|2\d{3})|55|6[67]|77|88)))\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:1[67]\d\d|70)\d\d|55330|909)|5(?:300\d|6161(?:17[89]|561))|1(?:[19][89]|21|4[01])';
     ExampleNumber: '118';
     LengthOffset: 28; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-28]|12|298)|2611';
     ExampleNumber: '100';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-248]|1[289]|21|[39][89]|4[01]|6(?:1|6\d?)|8[12])|777|800|1[05]5\d|1(?:07|51|94)\d\d?|(?:' +
       '1(?:[05]5\d|70)\d|261)\d|1(?:0[369]|10|29|3[126]|9[0-256])\d';
     ExampleNumber: '100';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN premiumRate }
    (HasData: True;
     NationalNumberPattern: '11[67]\d{4}|56161561';
     ExampleNumber: '1160000';
     LengthOffset: 105; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN smsServices }
    (HasData: True;
     NationalNumberPattern: '1(?:39|90[019])|5(?:14(?:2[5-9]|[34]\d)|6161(?:17[89]|561)|757555)';
     ExampleNumber: '139';
     LengthOffset: 107; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1479]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[04]|15|22)|4432|71117|9988';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:443|711\d|998)\d';
     ExampleNumber: '4430';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[04]|15|22)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[04]|15|22)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:443|711\d|998)\d';
     ExampleNumber: '4430';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[129]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR standardRate }
    (HasData: True;
     NationalNumberPattern: '1(?:5[0-469]|8[0-489])\d';
     ExampleNumber: '1500';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[0-68]|2[0-59]|3[346-8]|4(?:[0147]|[289]0)|5(?:0[14]|1[02479]|2[0-3]|39|[49]0|65)|6(?:[16]6' +
       '|[27]|90)|8(?:03|1[18]|22|3[37]|4[28]|88|99)|9[0-579])|20(?:[09]0|1(?:[038]|1[079]|26|9[69])|2[0' +
       '1])|9(?:11|9(?:0009|90))';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:5[0-469]|8[0-489])|99(?:0\d\d|9))\d';
     ExampleNumber: '1500';
     LengthOffset: 112; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[025]|25)|911';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[0-68]|2[0-59]|9[0-579])|911';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR smsServices }
    (HasData: True;
     NationalNumberPattern: '990\d{3}';
     ExampleNumber: '990000';
     LengthOffset: 114; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[28]|61(?:16|23))|4(?:00|1[145]|4[0146])|55|7(?:00|17|7[07-9])|8(?:[02]0|1[16-9]|88)|900' +
       ')';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '14(?:0\d|41)';
     ExampleNumber: '1400';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|71\d)';
     ExampleNumber: '112';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS smsServices }
    (HasData: True;
     NationalNumberPattern: '1(?:415|90\d)';
     ExampleNumber: '1415';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d{2,6}';
     ExampleNumber: '';
     LengthOffset: 87; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0\d{2,3}|1(?:[2-57-9]|6(?:000|111))|3[39]|4(?:82|9\d{1,3})|5(?:00|1[58]|2[25]|3[03]|44|[59])' +
       '|60|8[67]|9(?:[01]|2[2-9]|4\d|696))|4(?:2323|5045)|14\d|(?:1(?:2|92[01])|4(?:3(?:[01]|[45]\d\d)|' +
       '[478](?:[0-4]|[5-9]\d\d)|55))\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT emergency }
    (HasData: True;
     NationalNumberPattern: '11[2358]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[2358]|6\d{3})|46|87)';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:12|4(?:[478](?:[0-4]|[5-9]\d\d)|55))\d\d';
     ExampleNumber: '1200';
     LengthOffset: 115; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT smsServices }
    (HasData: True;
     NationalNumberPattern: '4(?:3(?:[01]|[45]\d\d)|[478](?:[0-4]|[5-9]\d\d)|5[05])\d\d';
     ExampleNumber: '43000';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[129]\d\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:00|1(?:2|8\d{3})|23|4(?:[14]|28|7\d)|5\d|7(?:0[12]|[128]|35?)|808|9[0135])|23[2-4]|999';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE emergency }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE tollFree }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[029]|76)|9(?:11|88)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM emergency }
    (HasData: True;
     NationalNumberPattern: '11[029]|911';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM tollFree }
    (HasData: True;
     NationalNumberPattern: '11[029]|9(?:11|88)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM smsServices }
    (HasData: True;
     NationalNumberPattern: '176';
     ExampleNumber: '176';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[2359]|1[0-68]|9[0-24-79])|9[0-4689]\d{3}|911';
     ExampleNumber: '102';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '9[0-4689]\d{3}';
     ExampleNumber: '90000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[127])|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[235]|1[2-6]|9[127])|911';
     ExampleNumber: '102';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO premiumRate }
    (HasData: True;
     NationalNumberPattern: '9[0-4689]\d{3}';
     ExampleNumber: '90000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO smsServices }
    (HasData: True;
     NationalNumberPattern: '9[0-4689]\d{3}';
     ExampleNumber: '90000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d\d(?:\d{5,7})?';
     ExampleNumber: '';
     LengthOffset: 118; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP shortCode }
    (HasData: True;
     NationalNumberPattern: '000[2569]\d{4,6}|1(?:0[24]|1[089]|44|89)';
     ExampleNumber: '102';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP emergency }
    (HasData: True;
     NationalNumberPattern: '11[09]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP tollFree }
    (HasData: True;
     NationalNumberPattern: '11[089]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP smsServices }
    (HasData: True;
     NationalNumberPattern: '000[2569]\d{4,6}';
     ExampleNumber: '00020000';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:[07-9]|1[0-25]|400)|1(?:[024-6]|9[0-579])|2[1-3]|3[01]|4[14]|5(?:[01][01]|2[0-24-79]|33|' +
       '4[05]|5[59]|6(?:00|29|6[67]))|(?:6[035]\d|[78])\d|9(?:[02-9]\d\d|19))|(?:(?:2[0-79]|[37][0-29]|4' +
       '[0-4]|6[2357]|8\d)\d|5(?:[0-7]\d|99))\d\d|9(?:09\d\d|99)|8988';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:04|6[35])\d\d|3[01]|4[14]|5(?:1\d|2[25]))|(?:(?:2[0-79]|[37][0-29]|4[0-4]|6[2357]|8\d)\d|' +
       '5(?:[0-7]\d|99)|909)\d\d|898\d';
     ExampleNumber: '130';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE emergency }
    (HasData: True;
     NationalNumberPattern: '11[24]|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[246]|9\d)|5(?:01|2[127]|6[26]\d))|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE premiumRate }
    (HasData: True;
     NationalNumberPattern: '909\d\d';
     ExampleNumber: '90900';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE smsServices }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:04|6[035])\d\d|4[14]|5(?:01|55|6[26]\d))|40404|8988|909\d\d';
     ExampleNumber: '141';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG shortCode }
    (HasData: True;
     NationalNumberPattern: '10[1-3]|4040';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d';
     ExampleNumber: '4040';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG emergency }
    (HasData: True;
     NationalNumberPattern: '10[1-3]';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG tollFree }
    (HasData: True;
     NationalNumberPattern: '10[1-3]';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d';
     ExampleNumber: '4040';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[146]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH shortCode }
    (HasData: True;
     NationalNumberPattern: '11[7-9]|40404|666';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH emergency }
    (HasData: True;
     NationalNumberPattern: '11[7-9]|666';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH tollFree }
    (HasData: True;
     NationalNumberPattern: '11[7-9]|666';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[179]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI standardRate }
    (HasData: True;
     NationalNumberPattern: '103';
     ExampleNumber: '103';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:05[0-259]|88|9[2-5])|777|99[2-4]|10[0-8]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI emergency }
    (HasData: True;
     NationalNumberPattern: '19[2-5]|99[2-4]';
     ExampleNumber: '192';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI tollFree }
    (HasData: True;
     NationalNumberPattern: '19[2-5]|99[2-4]';
     ExampleNumber: '192';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM shortCode }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM emergency }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM tollFree }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[39]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN shortCode }
    (HasData: True;
     NationalNumberPattern: '333|9(?:11|88|99)';
     ExampleNumber: '333';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN emergency }
    (HasData: True;
     NationalNumberPattern: '333|9(?:11|99)';
     ExampleNumber: '333';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN tollFree }
    (HasData: True;
     NationalNumberPattern: '333|9(?:11|88|99)';
     ExampleNumber: '333';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP generalDesc }
    (HasData: True;
     NationalNumberPattern: '[18]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP shortCode }
    (HasData: True;
     NationalNumberPattern: '11[29]|819';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP emergency }
    (HasData: True;
     NationalNumberPattern: '11[29]|819';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP tollFree }
    (HasData: True;
     NationalNumberPattern: '11[29]|819';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d(?:\d(?:\d{3})?)?)?';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[01679]114|3(?:0[01]|2|3[0-35-9]|45?|5[057]|6[569]|7[79]|8[2589]|9[0189])|55[15]\d{4}|8(?:(?' +
       ':11|44|66)\d{4}|[28]))|1(?:0[015]|1\d|2[01357-9]|41|8114)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:0[01]|1[4-6]|41|8114)|1(?:[0679]1\d|111)\d';
     ExampleNumber: '100';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR emergency }
    (HasData: True;
     NationalNumberPattern: '11[29]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[27-9]|28|330|82)';
     ExampleNumber: '112';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR smsServices }
    (HasData: True;
     NationalNumberPattern: '1(?:55|8[146])\d{5}';
     ExampleNumber: '15500000';
     LengthOffset: 68; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[18]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW shortCode }
    (HasData: True;
     NationalNumberPattern: '1[0-7]\d|89887';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '898\d\d';
     ExampleNumber: '89800';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW tollFree }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-4]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-4]|12)|2121|(?:3040|404)0';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:304\d|404)\d';
     ExampleNumber: '4040';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)|212\d';
     ExampleNumber: '101';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:304\d|404)\d';
     ExampleNumber: '4040';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA shortCode }
    (HasData: True;
     NationalNumberPattern: '19[015]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA emergency }
    (HasData: True;
     NationalNumberPattern: '19[015]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA tollFree }
    (HasData: True;
     NationalNumberPattern: '19[015]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|40|75)|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|40|75)|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|40|75)|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[278]|45)|4[3-57]|50|75|81[18])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[278]|44)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[278]|44)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[024-9]|3(?:00|1[2-49]|2[23]|3[1-3]|44|5[07]|[67]9|88|9[039])|9(?:0[0-2589]|1[0-357-9]|2[0-' +
       '25689]|3[0389]|4[0489]|5[014-69]|6[0-2689]|7[03579]|8[02457-9]|9[0-2569]))';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK emergency }
    (HasData: True;
     NationalNumberPattern: '11[02689]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK tollFree }
    (HasData: True;
     NationalNumberPattern: '11[02689]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[3489]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR shortCode }
    (HasData: True;
     NationalNumberPattern: '355|4040|8(?:400|933)|911';
     ExampleNumber: '355';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:404|8(?:40|93))\d';
     ExampleNumber: '4040';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR emergency }
    (HasData: True;
     NationalNumberPattern: '355|911';
     ExampleNumber: '355';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR tollFree }
    (HasData: True;
     NationalNumberPattern: '355|911';
     ExampleNumber: '355';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:404|8(?:40|93))\d';
     ExampleNumber: '4040';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS shortCode }
    (HasData: True;
     NationalNumberPattern: '11[257]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS emergency }
    (HasData: True;
     NationalNumberPattern: '11[257]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS tollFree }
    (HasData: True;
     NationalNumberPattern: '11[257]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d(?:\d(?:\d{3})?)?';
     ExampleNumber: '';
     LengthOffset: 129; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT shortCode }
    (HasData: True;
     NationalNumberPattern: '0(?:11?|22?|33?)|1(?:0[1-3]|1(?:[27-9]|6(?:000|1(?:1[17]|23))))';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT emergency }
    (HasData: True;
     NationalNumberPattern: '0(?:11?|22?|33?)|1(?:0[1-3]|12)';
     ExampleNumber: '01';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT tollFree }
    (HasData: True;
     NationalNumberPattern: '0(?:11?|22?|33?)|1(?:0[1-3]|1(?:2|6111))|116(?:0\d|12)\d';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU shortCode }
    (HasData: True;
     NationalNumberPattern: '11(?:[23]|6(?:000|111))|1(?:18|[25]\d|3)\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU emergency }
    (HasData: True;
     NationalNumberPattern: '11[23]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:[23]|6\d{3})';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV generalDesc }
    (HasData: True;
     NationalNumberPattern: '[018]\d{1,5}';
     ExampleNumber: '';
     LengthOffset: 82; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV standardRate }
    (HasData: True;
     NationalNumberPattern: '1181';
     ExampleNumber: '1181';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV shortCode }
    (HasData: True;
     NationalNumberPattern: '0[1-4]|1(?:1(?:[02-4]|6(?:000|111)|8[0189])|(?:5|65)5|77)|821[57]4';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '165\d';
     ExampleNumber: '1650';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV emergency }
    (HasData: True;
     NationalNumberPattern: '0[1-3]|11[023]';
     ExampleNumber: '01';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV tollFree }
    (HasData: True;
     NationalNumberPattern: '0[1-3]|11(?:[023]|6\d{3})';
     ExampleNumber: '01';
     LengthOffset: 129; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV premiumRate }
    (HasData: True;
     NationalNumberPattern: '1180|821\d\d';
     ExampleNumber: '1180';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY shortCode }
    (HasData: True;
     NationalNumberPattern: '19[013]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY emergency }
    (HasData: True;
     NationalNumberPattern: '19[013]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY tollFree }
    (HasData: True;
     NationalNumberPattern: '19[013]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[59]|77)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:[59]|77)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:[59]|77)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|41|[578])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6(?:00[06]|1(?:1[17]|23))|8\d\d?|99)|90[04-9])|90[1-3]|1(?:4\d\d|6[0-389]|9[1-4])\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD emergency }
    (HasData: True;
     NationalNumberPattern: '112|90[1-3]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6(?:000|1(?:11|2\d)))|90[1-3]';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:(?:[013-57-9]|6\d\d)\d|2)|[249]\d{3}|5999|8(?:0[089]|1[0-8]|888))|1(?:[02-5]\d\d|60[06]|' +
       '700)|12\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|2[2-4])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|2[2-4])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d(?:\d\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 48; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF shortCode }
    (HasData: True;
     NationalNumberPattern: '1[578]|3(?:00[0-79]|1[0-689]\d)|(?:118[02-9]|3[2469])\d\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF emergency }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF tollFree }
    (HasData: True;
     NationalNumberPattern: '1[578]|3(?:00|1[0-689])\d';
     ExampleNumber: '15';
     LengthOffset: 51; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF premiumRate }
    (HasData: True;
     NationalNumberPattern: '3[2469]\d\d';
     ExampleNumber: '3200';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[78]|[78])';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[78]|[78])';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[78]|[78])';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH shortCode }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH tollFree }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|8\d)|3\d|9[2-4])|1(?:16|2\d)\d{3}';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[2-4])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6\d{3})|9[2-4])';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML generalDesc }
    (HasData: True;
     NationalNumberPattern: '[136-8]\d{1,4}';
     ExampleNumber: '';
     LengthOffset: 17; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML standardRate }
    (HasData: True;
     NationalNumberPattern: '37(?:433|575)|7400|8001\d';
     ExampleNumber: '7400';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[013-9]\d|2)|2(?:1[02-469]|2[13])|[578])|350(?:35|57)|67(?:0[09]|[59]9|77|8[89])|74(?:0[' +
       '02]|44|55)|800[0-2][12]|3(?:52|[67]\d)\d\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '3503\d|(?:3[67]\d|800)\d\d';
     ExampleNumber: '35030';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML emergency }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML tollFree }
    (HasData: True;
     NationalNumberPattern: '1[578]|(?:352|67)00|7402|(?:677|744|8000)\d';
     ExampleNumber: '15';
     LengthOffset: 132; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:12|800)2\d|3(?:52(?:11|2[02]|3[04-6]|99)|7574)';
     ExampleNumber: '1220';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML smsServices }
    (HasData: True;
     NationalNumberPattern: '374(?:0[24-9]|[1-9]\d)|7400|3(?:6\d|75)\d\d';
     ExampleNumber: '7400';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM shortCode }
    (HasData: True;
     NationalNumberPattern: '199';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM emergency }
    (HasData: True;
     NationalNumberPattern: '199';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM tollFree }
    (HasData: True;
     NationalNumberPattern: '199';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN shortCode }
    (HasData: True;
     NationalNumberPattern: '10[0-35]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN emergency }
    (HasData: True;
     NationalNumberPattern: '10[0-35]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN tollFree }
    (HasData: True;
     NationalNumberPattern: '10[0-35]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO shortCode }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d(?:\d(?:\d(?:\d{2})?)?)?';
     ExampleNumber: '';
     LengthOffset: 135; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ standardRate }
    (HasData: True;
     NationalNumberPattern: '118\d{3}';
     ExampleNumber: '118000';
     LengthOffset: 114; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])|(?:118[02-9]|3[0-2469])\d\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])';
     ExampleNumber: '15';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])|3[01]\d\d';
     ExampleNumber: '15';
     LengthOffset: 58; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ premiumRate }
    (HasData: True;
     NationalNumberPattern: '3[2469]\d\d';
     ExampleNumber: '3200';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR shortCode }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR emergency }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR tollFree }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS generalDesc }
    (HasData: True;
     NationalNumberPattern: '[29]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS shortCode }
    (HasData: True;
     NationalNumberPattern: '211|9(?:11|88|99)';
     ExampleNumber: '211';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d{3})?';
     ExampleNumber: '';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT shortCode }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6(?:000|1(?:11|23)))';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6\d{3})';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[189]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU shortCode }
    (HasData: True;
     NationalNumberPattern: '1\d{2,4}|(?:8\d\d|99)\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU emergency }
    (HasData: True;
     NationalNumberPattern: '11[45]|99[59]';
     ExampleNumber: '114';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU tollFree }
    (HasData: True;
     NationalNumberPattern: '11[45]|99[59]';
     ExampleNumber: '114';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[0-37-9]|[4-6]\d)\d|4040|1[45]1';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1[45]1';
     ExampleNumber: '141';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:02|1[89])';
     ExampleNumber: '102';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:02|1[89])';
     ExampleNumber: '102';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[189]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW shortCode }
    (HasData: True;
     NationalNumberPattern: '199|80400|99[7-9]';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '804\d\d';
     ExampleNumber: '80400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW emergency }
    (HasData: True;
     NationalNumberPattern: '199|99[7-9]';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW tollFree }
    (HasData: True;
     NationalNumberPattern: '199|99[7-9]';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW smsServices }
    (HasData: True;
     NationalNumberPattern: '804\d\d';
     ExampleNumber: '80400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX generalDesc }
    (HasData: True;
     NationalNumberPattern: '[0579]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX shortCode }
    (HasData: True;
     NationalNumberPattern: '0[1-9]\d|53053|7766|911';
     ExampleNumber: '010';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '0(?:[249]0|[35][01])';
     ExampleNumber: '020';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX emergency }
    (HasData: True;
     NationalNumberPattern: '0(?:6[0568]|80)|911';
     ExampleNumber: '060';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX tollFree }
    (HasData: True;
     NationalNumberPattern: '0(?:6[0568]|80)|911';
     ExampleNumber: '060';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:530\d|776)\d';
     ExampleNumber: '7760';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1369]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY standardRate }
    (HasData: True;
     NationalNumberPattern: '666\d\d';
     ExampleNumber: '66600';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[01348]|1(?:[02]|1[128]|311)|2(?:0[125]|[13-6]|2\d{0,2})|(?:3[1-35-79]|7[45])\d\d?|5(?:454|' +
       '5\d\d?|77|888|999?)|8(?:18?|2|8[18])|9(?:[124]\d?|68|71|9[0679]))|66628|99[1-469]|13[5-7]|(?:1(?' +
       ':0[569]|309|5[12]|7[136-9]|9[03])|3[23679]\d\d)\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY emergency }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY tollFree }
    (HasData: True;
     NationalNumberPattern: '112|999';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY smsServices }
    (HasData: True;
     NationalNumberPattern: '(?:3[23679]\d|666)\d\d';
     ExampleNumber: '32000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[02-5]\d\d|1[79]|9[78])';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[79]|9[78])';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[79]|9[78])';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA shortCode }
    (HasData: True;
     NationalNumberPattern: '(?:10|93)111|(?:1\d|9)\d\d';
     ExampleNumber: '900';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA emergency }
    (HasData: True;
     NationalNumberPattern: '10111';
     ExampleNumber: '10111';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA tollFree }
    (HasData: True;
     NationalNumberPattern: '10111';
     ExampleNumber: '10111';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC generalDesc }
    (HasData: True;
     NationalNumberPattern: '[135]\d{1,3}';
     ExampleNumber: '';
     LengthOffset: 58; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC standardRate }
    (HasData: True;
     NationalNumberPattern: '5(?:67|88)';
     ExampleNumber: '567';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:0[06]|1[02-46]|20|3[0-25]|42|5[058]|77|88)|[5-8])|3631|5[6-8]\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC emergency }
    (HasData: True;
     NationalNumberPattern: '1[5-8]';
     ExampleNumber: '15';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:00|1[23]|3[0-2]|8\d)|[5-8])|363\d|577';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-3578]\d(?:\d(?:\d{3})?)?';
     ExampleNumber: '';
     LengthOffset: 129; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[01]|1[128]|2[034]|3[013]|[46]0|55?|[78])|222|333|555|723141|888';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:0[01]|1[12]|2[034]|3[013]|[46]0|55)|222|333|555|888';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:18|[578])|723141';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:18|[578])|723\d{3}';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|55|77)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|55|77)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|55|77)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG shortCode }
    (HasData: True;
     NationalNumberPattern: '199|40700';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '407\d\d';
     ExampleNumber: '40700';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG emergency }
    (HasData: True;
     NationalNumberPattern: '199';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG tollFree }
    (HasData: True;
     NationalNumberPattern: '199';
     ExampleNumber: '199';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG smsServices }
    (HasData: True;
     NationalNumberPattern: '407\d\d';
     ExampleNumber: '40700';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12467]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[58]|200)|4878|7(?:010|373)|12[0158]|(?:19|[267]1)00';
     ExampleNumber: '115';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[58]|2[08])';
     ExampleNumber: '115';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[58]|2[08])|737\d';
     ExampleNumber: '115';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1349]\d\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6(?:00[06]|1(?:11|23)))|2(?:0[0-4]|3[34]|44)|3[03-9]\d|400|8(?:[02-9]\d|1[0-79]))|[34]' +
       '000|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '120\d';
     ExampleNumber: '1200';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL emergency }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6\d{3})|911';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL smsServices }
    (HasData: True;
     NationalNumberPattern: '[34]00\d';
     ExampleNumber: '3000';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO shortCode }
    (HasData: True;
     NationalNumberPattern: '04\d{3}|1(?:1(?:[0239]|61(?:1[17]|23))|2[048]|4(?:12|[59])|7[57]|8\d\d|90)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO emergency }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:[023]|6\d{3})';
     ExampleNumber: '110';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO smsServices }
    (HasData: True;
     NationalNumberPattern: '04\d{3}';
     ExampleNumber: '04000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:[0-36]|98)|1(?:1[1-4]|2))';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-3]|12)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-36]|12)|1(?:09|11)\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[0-2]|23|92)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR emergency }
    (HasData: True;
     NationalNumberPattern: '11[0-2]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR tollFree }
    (HasData: True;
     NationalNumberPattern: '11[0-2]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[019]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU shortCode }
    (HasData: True;
     NationalNumberPattern: '01[05]|101|999';
     ExampleNumber: '010';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '010';
     ExampleNumber: '010';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{3,4}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ shortCode }
    (HasData: True;
     NationalNumberPattern: '018|1(?:(?:1|37)1|(?:23|94)4|7[03]7)|[2-57-9]\d{2,3}|6(?:161|26[0-3]|742)';
     ExampleNumber: '018';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ emergency }
    (HasData: True;
     NationalNumberPattern: '111';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ tollFree }
    (HasData: True;
     NationalNumberPattern: '111';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '018';
     ExampleNumber: '018';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ smsServices }
    (HasData: True;
     NationalNumberPattern: '018|(?:1(?:23|37|7[03]|94)|6(?:[12]6|74))\d|[2-57-9]\d{2,3}';
     ExampleNumber: '018';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{3}';
     ExampleNumber: '';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:111|222|4(?:4[0-5]|50|66|7[7-9])|51[0-8])|9999|1(?:2[3-5]|3[0-2]|50)\d';
     ExampleNumber: '1111';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM emergency }
    (HasData: True;
     NationalNumberPattern: '1444|9999';
     ExampleNumber: '1444';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM tollFree }
    (HasData: True;
     NationalNumberPattern: '1444|999\d';
     ExampleNumber: '1444';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA shortCode }
    (HasData: True;
     NationalNumberPattern: '10[2-4]|911';
     ExampleNumber: '102';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA tollFree }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:05|1[67])';
     ExampleNumber: '105';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:05|1[67])';
     ExampleNumber: '105';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:05|1[67])';
     ExampleNumber: '105';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF shortCode }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF emergency }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF tollFree }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d{2,6}';
     ExampleNumber: '';
     LengthOffset: 87; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG shortCode }
    (HasData: True;
     NationalNumberPattern: '000|1(?:1[01]|5\d\d|6\d{2,5})';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG emergency }
    (HasData: True;
     NationalNumberPattern: '000|11[01]';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG tollFree }
    (HasData: True;
     NationalNumberPattern: '000|11[01]';
     ExampleNumber: '000';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG smsServices }
    (HasData: True;
     NationalNumberPattern: '16\d{2,5}';
     ExampleNumber: '1600';
     LengthOffset: 139; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH shortCode }
    (HasData: True;
     NationalNumberPattern: '11[27]|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH emergency }
    (HasData: True;
     NationalNumberPattern: '11[27]|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH tollFree }
    (HasData: True;
     NationalNumberPattern: '11[27]|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{1,3}';
     ExampleNumber: '';
     LengthOffset: 58; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:122|3[014]|[56])|11[2457-9]';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:22?|5)|[56])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2\d?|5)|[56])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|61(?:11|23)|891[23])|9\d{3})|9(?:8[4-7]|9[1-9])|11[68]000';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL emergency }
    (HasData: True;
     NationalNumberPattern: '112|99[7-9]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6\d{3})|99[7-9]';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d(?:\d\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 48; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM standardRate }
    (HasData: True;
     NationalNumberPattern: '118\d{3}';
     ExampleNumber: '118000';
     LengthOffset: 114; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM shortCode }
    (HasData: True;
     NationalNumberPattern: '1[578]|31(?:0[0-5]|[1-689]\d)|(?:118[02-9]|3[02469])\d\d';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '3103';
     ExampleNumber: '3103';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM emergency }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM tollFree }
    (HasData: True;
     NationalNumberPattern: '1[578]|310[0-245]|3(?:0\d|1[1-689])\d';
     ExampleNumber: '15';
     LengthOffset: 51; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM premiumRate }
    (HasData: True;
     NationalNumberPattern: '3[2469]\d\d';
     ExampleNumber: '3200';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-2]|122|44|66|99)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '112\d';
     ExampleNumber: '1120';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS emergency }
    (HasData: True;
     NationalNumberPattern: '10[0-2]';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-2]|66)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 25; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:45|5[01])|1(?:[2578]|600[06])|4(?:1[45]|4)|583|6(?:1[0236]|3[02]|9[169]))|1(?:1611|59)1|' +
       '1[068]78|1[08]9[16]|1(?:0[1-38]|40|5[15]|6[258]|82)0';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT emergency }
    (HasData: True;
     NationalNumberPattern: '11[25]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT tollFree }
    (HasData: True;
     NationalNumberPattern: '11[257]|1(?:16\d\d|5[1589]|8[279])\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW shortCode }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW tollFree }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12459]\d\d(?:\d{3,4})?';
     ExampleNumber: '';
     LengthOffset: 73; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY shortCode }
    (HasData: True;
     NationalNumberPattern: '[1245][01]\d{5}|(?:1[1-9]|[245]0\d{3})\d|911';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '[1245][01]\d{5}|[245]0\d{4}';
     ExampleNumber: '200000';
     LengthOffset: 143; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY emergency }
    (HasData: True;
     NationalNumberPattern: '128|911';
     ExampleNumber: '128';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY tollFree }
    (HasData: True;
     NationalNumberPattern: '128|911';
     ExampleNumber: '128';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY smsServices }
    (HasData: True;
     NationalNumberPattern: '[1245][01]\d{5}|[245]0\d{4}';
     ExampleNumber: '200000';
     LengthOffset: 143; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[129]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:00|[19]\d)|(?:1|20|9[27]\d)\d\d';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA tollFree }
    (HasData: True;
     NationalNumberPattern: '99\d';
     ExampleNumber: '990';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA premiumRate }
    (HasData: True;
     NationalNumberPattern: '900';
     ExampleNumber: '900';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|[578])';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[18]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[23]|6(?:000|1(?:11|23))|8(?:(?:01|8[18])1|119|[23]00|932))|[24]\d\d|9(?:0(?:00|19)|1[19' +
       ']|21|3[02]|5[178]))|8[48]\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:[23]|6\d{3})';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:18[39]|[24])|8[48])\d\d';
     ExampleNumber: '1200';
     LengthOffset: 112; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO smsServices }
    (HasData: True;
     NationalNumberPattern: '113|(?:1[24]|8[48])\d\d';
     ExampleNumber: '113';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{1,5}';
     ExampleNumber: '';
     LengthOffset: 82; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS shortCode }
    (HasData: True;
     NationalNumberPattern: '1[189]\d{1,4}|9[2-4]';
     ExampleNumber: '92';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS emergency }
    (HasData: True;
     NationalNumberPattern: '112|9[2-4]';
     ExampleNumber: '92';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS tollFree }
    (HasData: True;
     NationalNumberPattern: '112|9[2-4]';
     ExampleNumber: '92';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU shortCode }
    (HasData: True;
     NationalNumberPattern: '112|(?:0|10)[1-4]';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU emergency }
    (HasData: True;
     NationalNumberPattern: '112|(?:0|10)[1-3]';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU tollFree }
    (HasData: True;
     NationalNumberPattern: '112|(?:0|10)[1-3]';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[14]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-2]|1[0-24-6]|2[13]|70|99)|456';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW emergency }
    (HasData: True;
     NationalNumberPattern: '11[12]';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW tollFree }
    (HasData: True;
     NationalNumberPattern: '11[1245]';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA standardRate }
    (HasData: True;
     NationalNumberPattern: '141\d';
     ExampleNumber: '1410';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:00|2|6111)|410|9(?:00|1[89]|9(?:099|22|9[0-3])))|9(?:0[24-79]|11|3[379]|40|66|8[5-9]|9[0' +
       '2-9])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1(?:10|41)\d|90[24679]';
     ExampleNumber: '902';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA emergency }
    (HasData: True;
     NationalNumberPattern: '112|9(?:11|9[79])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|6\d{3})|9(?:11|37|9[7-9])';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB generalDesc }
    (HasData: True;
     NationalNumberPattern: '[127-9]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[02]\d|1[12]|[35][01]|[49][1-9]|6[2-9]|7[7-9]|8[0-8])|269|777|835|9(?:[01]1|22|33|55|77|88|9' +
       '9)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:[06]\d|1[0-246-8]|2[0-8]|3[13]|4[0-2]|5[15]|7[124-6]|8[158]|9[015])|9(?:6\d\d|99)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[1468]|60)|999';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD shortCode }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-37-9]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE shortCode }
    (HasData: True;
     NationalNumberPattern: '11(?:[25]|313|6(?:00[06]|1(?:1[17]|23))|7[0-8])|2(?:2[02358]|33|4[01]|50|6[1-4])|32[13]|8(?:22|8' +
       '8)|9(?:0(?:00|51)0|12)|(?:11(?:4|8[02-46-9])|7\d\d|90[2-4])\d\d|(?:118|90)1(?:[02-9]\d|1[013-9])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '2(?:2[02358]|33|4[01]|50|6[1-4])|32[13]|8(?:22|88)|912';
     ExampleNumber: '220';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE emergency }
    (HasData: True;
     NationalNumberPattern: '112|90000';
     ExampleNumber: '112';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:2|(?:3|6\d)\d\d|414|77)|900\d\d';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE premiumRate }
    (HasData: True;
     NationalNumberPattern: '11811[89]|72\d{3}';
     ExampleNumber: '72000';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE smsServices }
    (HasData: True;
     NationalNumberPattern: '7\d{4}';
     ExampleNumber: '70000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[179]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:[01368]\d|44)\d|[57]\d{2,3}|9(?:0[1-9]|[1-9]\d))|77222|99[02-9]|100';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG emergency }
    (HasData: True;
     NationalNumberPattern: '99[359]';
     ExampleNumber: '993';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG tollFree }
    (HasData: True;
     NationalNumberPattern: '99[359]';
     ExampleNumber: '993';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG smsServices }
    (HasData: True;
     NationalNumberPattern: '772\d\d';
     ExampleNumber: '77200';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[129]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH shortCode }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}|26[01]\d\d|9(?:11|99)';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:00[146]|[23]|6(?:000|1(?:11|23))|8(?:[08]|99))|9(?:059|1(?:0[12]|16)|5|70|87|9(?:00|[149' +
       '])))|19(?:08|81)[09]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI emergency }
    (HasData: True;
     NationalNumberPattern: '11[23]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI tollFree }
    (HasData: True;
     NationalNumberPattern: '11(?:(?:0|6\d)\d\d|[23]|8\d\d?)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[01]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ shortCode }
    (HasData: True;
     NationalNumberPattern: '04\d{3}|11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ emergency }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ tollFree }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ smsServices }
    (HasData: True;
     NationalNumberPattern: '04\d{3}';
     ExampleNumber: '04000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6(?:000|111)|8[0-8])|[248]\d{3}|5[0589])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|5[058])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6\d{3})|5[058])';
     ExampleNumber: '112';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[069]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL shortCode }
    (HasData: True;
     NationalNumberPattern: '(?:01|99)9|60400';
     ExampleNumber: '019';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '604\d\d';
     ExampleNumber: '60400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL emergency }
    (HasData: True;
     NationalNumberPattern: '(?:01|99)9';
     ExampleNumber: '019';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:01|99)9';
     ExampleNumber: '019';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL smsServices }
    (HasData: True;
     NationalNumberPattern: '604\d\d';
     ExampleNumber: '60400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM shortCode }
    (HasData: True;
     NationalNumberPattern: '11[358]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM emergency }
    (HasData: True;
     NationalNumberPattern: '11[358]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM tollFree }
    (HasData: True;
     NationalNumberPattern: '11[358]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12]\d{1,5}';
     ExampleNumber: '';
     LengthOffset: 82; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN standardRate }
    (HasData: True;
     NationalNumberPattern: '2(?:01|2)\d{3}';
     ExampleNumber: '22000';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[69]|(?:[246]\d|51)\d)|2(?:0[0-246]|[12468])\d{3}|1[278]';
     ExampleNumber: '12';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '1[46]\d\d';
     ExampleNumber: '1400';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN emergency }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:515|[78])|2(?:00|1)\d{3}';
     ExampleNumber: '17';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN premiumRate }
    (HasData: True;
     NationalNumberPattern: '2(?:0[246]|[468])\d{3}';
     ExampleNumber: '24000';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN smsServices }
    (HasData: True;
     NationalNumberPattern: '2[468]\d{3}';
     ExampleNumber: '24000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[57-9]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO shortCode }
    (HasData: True;
     NationalNumberPattern: '555|777|888|999';
     ExampleNumber: '555';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO emergency }
    (HasData: True;
     NationalNumberPattern: '555|888|999';
     ExampleNumber: '555';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO tollFree }
    (HasData: True;
     NationalNumberPattern: '555|888|999';
     ExampleNumber: '555';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR shortCode }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR emergency }
    (HasData: True;
     NationalNumberPattern: '115';
     ExampleNumber: '115';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR tollFree }
    (HasData: True;
     NationalNumberPattern: '115';
     ExampleNumber: '115';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS shortCode }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST shortCode }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST tollFree }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV generalDesc }
    (HasData: True;
     NationalNumberPattern: '[149]\d\d(?:\d{2,3})?';
     ExampleNumber: '';
     LengthOffset: 53; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:2|6111)|2[136-8]|3[0-6]|9[05])|40404|9(?:1\d|29)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV emergency }
    (HasData: True;
     NationalNumberPattern: '91[13]';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV tollFree }
    (HasData: True;
     NationalNumberPattern: '116\d{3}|911';
     ExampleNumber: '911';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV smsServices }
    (HasData: True;
     NationalNumberPattern: '404\d\d';
     ExampleNumber: '40400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:19|88)';
     ExampleNumber: '919';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX emergency }
    (HasData: True;
     NationalNumberPattern: '919';
     ExampleNumber: '919';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:19|88)';
     ExampleNumber: '919';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY shortCode }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY emergency }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY tollFree }
    (HasData: True;
     NationalNumberPattern: '11[023]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ shortCode }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD shortCode }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD emergency }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD tollFree }
    (HasData: True;
     NationalNumberPattern: '1[78]';
     ExampleNumber: '17';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:011|1[078]|7[127])';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[78]|7[127])';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[78]|7[127])';
     ExampleNumber: '117';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH standardRate }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:03|1[15]|2[58]|3[056]|4[02-49]|5[046-9]|7[03-589]|9[57-9])|5(?:0[0-8]|4[0-378]|5[1-478]|' +
       '7[156])|6(?:20|4[356]|6[1-68]|7[057-9]|8[015]|9[0457-9]))|1(?:1[68]|26|3[1-35]|5[689]|60|7[17])\' +
       'd';
     ExampleNumber: '1103';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[0-2]|1(?:0[03]|1[1-35]|2[0358]|3[03-79]|4[02-489]|5[04-9]|6[04-79]|7[03-9]|8[027-9]|9[02-9' +
       '])|2(?:22|3[89]|66)|3(?:18|2[23]|3[013]|5[56]|6[45]|73)|477|5(?:0\d|4[0-37-9]|5[1-8]|6[01679]|7[' +
       '12568]|8[0-24589]|9[013589])|6(?:0[0-29]|2[03]|4[3-6]|6[1-9]|7[0257-9]|8[0158]|9[014-9])|7(?:[14' +
       ']9|7[27]|90)|888|9[19])';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '114[89]';
     ExampleNumber: '1148';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:669|9[19])';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:00|2[03]|3[3479]|7[67]|9[0246])|578|6(?:44|6[79]|88|9[16])|88\d|9[19])|1[15]55';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH premiumRate }
    (HasData: True;
     NationalNumberPattern: '1(?:113|2[23]\d|5(?:09|56))';
     ExampleNumber: '1113';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[02]|1[25]|2[0138]|72|9[07])';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL emergency }
    (HasData: True;
     NationalNumberPattern: '11[25]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL tollFree }
    (HasData: True;
     NationalNumberPattern: '11[25]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM generalDesc }
    (HasData: True;
     NationalNumberPattern: '0\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM shortCode }
    (HasData: True;
     NationalNumberPattern: '0[1-49]';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM emergency }
    (HasData: True;
     NationalNumberPattern: '0[1-3]';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM tollFree }
    (HasData: True;
     NationalNumberPattern: '0[1-49]';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN shortCode }
    (HasData: True;
     NationalNumberPattern: '19[078]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN emergency }
    (HasData: True;
     NationalNumberPattern: '19[078]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN tollFree }
    (HasData: True;
     NationalNumberPattern: '19[078]';
     ExampleNumber: '190';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|22|33|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|22|33|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|22|33|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR standardRate }
    (HasData: True;
     NationalNumberPattern: '(?:285|542)0';
     ExampleNumber: '2850';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1(?:[02-79]|8(?:1[018]|2[0245]|3[2-4]|42|5[058]|6[06]|7[07]|8[01389]|9[089]))|3(?:37|[58]6|6' +
       '5)|471|5(?:07|78)|6(?:[02]6|99)|8(?:63|95))|2(?:077|268|4(?:17|23)|5(?:7[26]|82)|6[14]4|8\d\d|9(' +
       '?:30|89))|3(?:0(?:05|72)|353|4(?:06|30|64)|502|674|747|851|9(?:1[29]|60))|4(?:0(?:25|3[12]|[47]2' +
       ')|3(?:3[13]|[89]1)|439|5(?:43|55)|717|832)|5(?:145|290|[4-6]\d\d|772|833|9(?:[06]1|92))|6(?:236|' +
       '6(?:12|39|8[59])|769)|7890|8(?:688|7(?:28|65)|85[06])|9(?:159|290)|1[2-9]\d';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:1[02]|55)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[02]|22|3[126]|4[04]|5[15-9]|6[18]|77|83)';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR smsServices }
    (HasData: True;
     NationalNumberPattern: '1(?:3(?:37|[58]6|65)|4(?:4|71)|5(?:07|78)|6(?:[02]6|99)|8(?:3|63|95))|(?:2(?:07|26|4[12]|5[78]|6' +
       '[14]|8\d|9[38])|3(?:0[07]|[38]5|4[036]|50|67|74|9[16])|4(?:0[2-47]|3[389]|[48]3|5[45]|71)|5(?:14' +
       '|29|[4-6]\d|77|83|9[069])|6(?:23|6[138]|76)|789|8(?:68|7[26]|85)|9(?:15|29))\d';
     ExampleNumber: '144';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:88|9[09])';
     ExampleNumber: '988';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT emergency }
    (HasData: True;
     NationalNumberPattern: '99[09]';
     ExampleNumber: '990';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:88|9[09])';
     ExampleNumber: '988';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV shortCode }
    (HasData: True;
     NationalNumberPattern: '1\d\d|911';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV tollFree }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{2,3}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW standardRate }
    (HasData: True;
     NationalNumberPattern: '1(?:65|9(?:1\d|50|85|98))';
     ExampleNumber: '165';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[04-6]|1[0237-9]|3[389]|6[05-8]|7[07]|8(?:0|11)|9(?:19|22|5[057]|68|8[05]|9[15689]))';
     ExampleNumber: '100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW emergency }
    (HasData: True;
     NationalNumberPattern: '11[029]';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW tollFree }
    (HasData: True;
     NationalNumberPattern: '11[0289]|1(?:81|92)\d';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW premiumRate }
    (HasData: True;
     NationalNumberPattern: '10[56]';
     ExampleNumber: '105';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[149]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1\d|9[09])|46400|999';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '464\d\d';
     ExampleNumber: '46400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ emergency }
    (HasData: True;
     NationalNumberPattern: '11[0-245]|999';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:1[0-79]|9[09])|999';
     ExampleNumber: '110';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ smsServices }
    (HasData: True;
     NationalNumberPattern: '464\d\d';
     ExampleNumber: '46400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[189]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-49]|1(?:2|6(?:000|1(?:11|23))|8\d\d?)|(?:[278]|5\d)\d)|[89]00\d\d?|151|1(?:06|4\d|6)\d\d';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '(?:118|[89]00)\d\d?';
     ExampleNumber: '1180';
     LengthOffset: 23; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|12)';
     ExampleNumber: '101';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:0[1-3]|1(?:2|6\d{3}))';
     ExampleNumber: '101';
     LengthOffset: 12; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG shortCode }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG emergency }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG tollFree }
    (HasData: True;
     NationalNumberPattern: '999';
     ExampleNumber: '999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{2,5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US standardRate }
    (HasData: True;
     NationalNumberPattern: '2(?:3333|(?:4224|7562|900)2|56447|6688)|3(?:1010|2665|7404)|40404|560560|6(?:0060|22639|5246|762' +
       '2)|7(?:0701|3822|4666)|8(?:(?:3825|7226)5|4816)|99099';
     ExampleNumber: '23333';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US shortCode }
    (HasData: True;
     NationalNumberPattern: '11(?:2|5[1-47]|[68]\d|7[0-57]|98)|[2-9]\d{3,5}|[2-8]11|9(?:11|33|88)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '336\d\d|[2-9]\d{3}|[2356]11';
     ExampleNumber: '211';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US emergency }
    (HasData: True;
     NationalNumberPattern: '112|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US tollFree }
    (HasData: True;
     NationalNumberPattern: '112|611|9(?:11|33|88)';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US premiumRate }
    (HasData: True;
     NationalNumberPattern: '24280|(?:381|968)35|4(?:3355|7553|8221)|5(?:(?:489|934)2|5928)|72078|(?:323|960)40|(?:276|414)63' +
       '|(?:2(?:520|744)|7390|9968)9|(?:693|732|976)88|(?:3(?:556|825)|5294|8623|9729)4|(?:3378|4136|764' +
       '2|8961|9979)6|(?:4(?:6(?:15|32)|827)|(?:591|720)8|9529)7';
     ExampleNumber: '24280';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US smsServices }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{4,5}';
     ExampleNumber: '20000';
     LengthOffset: 56; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY standardRate }
    (HasData: True;
     NationalNumberPattern: '178\d';
     ExampleNumber: '1780';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0[4-9]|1[2368]|2[0-3568]|787|997\d?)|911';
     ExampleNumber: '104';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY emergency }
    (HasData: True;
     NationalNumberPattern: '128|911';
     ExampleNumber: '128';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY tollFree }
    (HasData: True;
     NationalNumberPattern: '128|911';
     ExampleNumber: '128';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[04]\d(?:\d(?:\d{2})?)?';
     ExampleNumber: '';
     LengthOffset: 79; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ shortCode }
    (HasData: True;
     NationalNumberPattern: '0(?:0[1-3]|[1-3]|50)|45400';
     ExampleNumber: '01';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '454\d\d';
     ExampleNumber: '45400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ emergency }
    (HasData: True;
     NationalNumberPattern: '0(?:0[1-3]|[1-3]|50)';
     ExampleNumber: '01';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ tollFree }
    (HasData: True;
     NationalNumberPattern: '0(?:0[1-3]|[1-3]|50)';
     ExampleNumber: '01';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ smsServices }
    (HasData: True;
     NationalNumberPattern: '454\d\d';
     ExampleNumber: '45400';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA shortCode }
    (HasData: True;
     NationalNumberPattern: '11[2358]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA emergency }
    (HasData: True;
     NationalNumberPattern: '11[2358]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA tollFree }
    (HasData: True;
     NationalNumberPattern: '11[2358]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|71)|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|71)|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|71)|911';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88|99)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI generalDesc }
    (HasData: True;
     NationalNumberPattern: '9\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI shortCode }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI emergency }
    (HasData: True;
     NationalNumberPattern: '911';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|88)';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN shortCode }
    (HasData: True;
     NationalNumberPattern: '11[3-5]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN emergency }
    (HasData: True;
     NationalNumberPattern: '11[3-5]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN tollFree }
    (HasData: True;
     NationalNumberPattern: '11[3-5]';
     ExampleNumber: '113';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU shortCode }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU emergency }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU tollFree }
    (HasData: True;
     NationalNumberPattern: '112';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d';
     ExampleNumber: '';
     LengthOffset: 47; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF shortCode }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF emergency }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF tollFree }
    (HasData: True;
     NationalNumberPattern: '1[578]';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:1[12]|2[0-6]|[39]0)|9(?:11|9[4-79])';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '12[0-6]';
     ExampleNumber: '120';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS emergency }
    (HasData: True;
     NationalNumberPattern: '9(?:11|9[4-69])';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS tollFree }
    (HasData: True;
     NationalNumberPattern: '9(?:11|9[4-69])';
     ExampleNumber: '911';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[2-4])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[2-4])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|9[2-4])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE shortCode }
    (HasData: True;
     NationalNumberPattern: '19[1459]';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE emergency }
    (HasData: True;
     NationalNumberPattern: '19[1459]';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE tollFree }
    (HasData: True;
     NationalNumberPattern: '19[1459]';
     ExampleNumber: '191';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d\d?';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:12|5)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:12|5)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:12|5)';
     ExampleNumber: '15';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[134]\d{2,4}';
     ExampleNumber: '';
     LengthOffset: 14; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA standardRate }
    (HasData: True;
     NationalNumberPattern: '3(?:078[23]|7(?:064|567)|8126)|4(?:394[16]|7751|8837)|4[23]699';
     ExampleNumber: '30782';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA shortCode }
    (HasData: True;
     NationalNumberPattern: '1(?:0(?:1(?:11|77)|20|7)|1[12]|77(?:3[237]|[45]7|6[279]|9[26]))|[34]\d{4}';
     ExampleNumber: '107';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '111';
     ExampleNumber: '111';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA emergency }
    (HasData: True;
     NationalNumberPattern: '1(?:01(?:11|77)|12)';
     ExampleNumber: '112';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:01\d\d|12)';
     ExampleNumber: '112';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA premiumRate }
    (HasData: True;
     NationalNumberPattern: '41(?:348|851)';
     ExampleNumber: '41348';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA smsServices }
    (HasData: True;
     NationalNumberPattern: '[34]\d{4}';
     ExampleNumber: '30000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM shortCode }
    (HasData: True;
     NationalNumberPattern: '112|99[139]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM carrierSpecific }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM emergency }
    (HasData: True;
     NationalNumberPattern: '112|99[139]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM tollFree }
    (HasData: True;
     NationalNumberPattern: '112|99[139]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[139]\d\d(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW standardRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW shortCode }
    (HasData: True;
     NationalNumberPattern: '11[2469]|3[013-57-9]\d{3}|9(?:5[023]|6[0-25]|9[3-59])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW carrierSpecific }
    (HasData: True;
     NationalNumberPattern: '114|9(?:5[023]|6[0-25])';
     ExampleNumber: '114';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW emergency }
    (HasData: True;
     NationalNumberPattern: '112|99[3-59]';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW tollFree }
    (HasData: True;
     NationalNumberPattern: '112|9(?:5[023]|61|9[3-59])';
     ExampleNumber: '112';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW premiumRate }
    (HasData: True;
     NationalNumberPattern: '3[013-57-9]\d{3}';
     ExampleNumber: '30000';
     LengthOffset: 7; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW smsServices }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0)
  );

implementation

end.
