unit LibPhoneNumber.TestingMetadata.Descs;

{
  GENERATED FILE - DO NOT EDIT.

  Phone number descriptions (patterns, example numbers, possible length slices) for every territory and number type.

  Source:    vendor/libphonenumber/resources/PhoneNumberMetadataForTesting.xml
  Commit:    8d8d75272c351b60b87163db5328e439c53a6b56
  Generator: tools/generate_metadata.ps1 (testing-metadata-v1)

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
  PhoneMetadataDescCount = 432;

  PhoneMetadataDescs: array[0..431] of TPhoneNumberDescRec = (
    { AD generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{6}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD fixedLine }
    (HasData: True;
     NationalNumberPattern: '\d{6}';
     ExampleNumber: '123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE uan }
    (HasData: True;
     NationalNumberPattern: '600\d{6}';
     ExampleNumber: '600123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 2),
    { AM fixedLine }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{7}';
     ExampleNumber: '10123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 4; LocalOnlyCount: 2),
    { AM mobile }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{7}';
     ExampleNumber: '10123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 4; LocalOnlyCount: 2),
    { AM tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[29]\d{8}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO fixedLine }
    (HasData: True;
     NationalNumberPattern: '2\d(?:[26-9]\d|\d[26-9])\d{5}';
     ExampleNumber: '222123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO mobile }
    (HasData: True;
     NationalNumberPattern: '9[1-3]\d{7}';
     ExampleNumber: '923123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-3689]\d{9,10}';
     ExampleNumber: '';
     LengthOffset: 6; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR fixedLine }
    (HasData: True;
     NationalNumberPattern: '[1-3]\d{5,9}';
     ExampleNumber: '1234567890';
     LengthOffset: 12; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR mobile }
    (HasData: True;
     NationalNumberPattern: '9\d{10}|[1-3]\d{9}';
     ExampleNumber: '9234567890';
     LengthOffset: 17; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{8}';
     ExampleNumber: '8034567890';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR premiumRate }
    (HasData: True;
     NationalNumberPattern: '6(0\d|10)\d{7}';
     ExampleNumber: '6234567890';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-578]\d{4,14}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU fixedLine }
    (HasData: True;
     NationalNumberPattern: '[2378]\d{8}';
     ExampleNumber: '212345678';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU mobile }
    (HasData: True;
     NationalNumberPattern: '4\d{8}';
     ExampleNumber: '412345678';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{6}';
     ExampleNumber: '1800123456';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU premiumRate }
    (HasData: True;
     NationalNumberPattern: '190[0126]\d{6}';
     ExampleNumber: '1900123456';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB generalDesc }
    (HasData: True;
     NationalNumberPattern: '246\d{7}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { BB fixedLine }
    (HasData: True;
     NationalNumberPattern: '';
     ExampleNumber: '2464567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { BB mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{8,10}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 3; LocalOnlyCount: 1),
    { BR fixedLine }
    (HasData: True;
     NationalNumberPattern: '\d{8,10}';
     ExampleNumber: '12345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 3; LocalOnlyCount: 1),
    { BR mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS generalDesc }
    (HasData: True;
     NationalNumberPattern: '(242|8(00|66|77|88)|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { BS fixedLine }
    (HasData: True;
     NationalNumberPattern: '242(?:3(?:02|[236][1-9]|4[0-24-9]|5[0-68]|7[3-57]|9[2-5])|4(?:2[237]|51|64|77)|502|636|702)\d{4}';
     ExampleNumber: '2425027890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { BS mobile }
    (HasData: True;
     NationalNumberPattern: '242(357|359|457|557)\d{4}';
     ExampleNumber: '2423577890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS tollFree }
    (HasData: True;
     NationalNumberPattern: '8(00|66|77|88)\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{5}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY fixedLine }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{5}';
     ExampleNumber: '112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA generalDesc }
    (HasData: True;
     NationalNumberPattern: '226\d{7}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { CA fixedLine }
    (HasData: True;
     NationalNumberPattern: '226\d{7}';
     ExampleNumber: '2261234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { CA mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{6,10}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 1),
    { CC fixedLine }
    (HasData: True;
     NationalNumberPattern: '\d{6,10}';
     ExampleNumber: '2261234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 1),
    { CC mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-7]\d{6,11}|8[0-357-9]\d{6,9}|9\d{7,10}';
     ExampleNumber: '';
     LengthOffset: 23; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN fixedLine }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{10}';
     ExampleNumber: '91234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN mobile }
    (HasData: True;
     NationalNumberPattern: '1(?:[38]\d|4[57]|5[0-35-9]|7[0136-8])\d{8}';
     ExampleNumber: '13123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:60|3\d)\d{8}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO fixedLine }
    (HasData: True;
     NationalNumberPattern: '60\d{8}';
     ExampleNumber: '6012345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO mobile }
    (HasData: True;
     NationalNumberPattern: '3(?:0[0-5]|1\d|2[0-3]|5[01]|70)\d{7}';
     ExampleNumber: '3211234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{8,10}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 3; LocalOnlyCount: 1),
    { CX fixedLine }
    (HasData: True;
     NationalNumberPattern: '\d{8,10}';
     ExampleNumber: '2261234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 3; LocalOnlyCount: 1),
    { CX mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{4,14}';
     ExampleNumber: '';
     LengthOffset: 24; LengthCount: 8;
     LocalOnlyOffset: 32; LocalOnlyCount: 2),
    { DE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:[24-6]\d{2}|3[03-9]\d|[789](?:0[2-9]|[1-9]\d))\d{1,8}';
     ExampleNumber: '30123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 32; LocalOnlyCount: 2),
    { DE mobile }
    (HasData: True;
     NationalNumberPattern: '1(5\d{9}|7\d{8}|6[02]\d{8}|63\d{7})';
     ExampleNumber: '15123456789';
     LengthOffset: 17; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE premiumRate }
    (HasData: True;
     NationalNumberPattern: '900([135]\d{6}|9\d{7})';
     ExampleNumber: '9001234567';
     LengthOffset: 17; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR generalDesc }
    (HasData: True;
     NationalNumberPattern: '3\d{6}';
     ExampleNumber: '';
     LengthOffset: 22; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR fixedLine }
    (HasData: True;
     NationalNumberPattern: '3\d{6}';
     ExampleNumber: '3123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{10}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 2;
     LocalOnlyOffset: 34; LocalOnlyCount: 3),
    { GB fixedLine }
    (HasData: True;
     NationalNumberPattern: '[1-6]\d{9}';
     ExampleNumber: '3123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 34; LocalOnlyCount: 3),
    { GB mobile }
    (HasData: True;
     NationalNumberPattern: '7[1-57-9]\d{8}';
     ExampleNumber: '7123456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{8}';
     ExampleNumber: '8023456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB premiumRate }
    (HasData: True;
     NationalNumberPattern: '9[018]\d{8}';
     ExampleNumber: '9023456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB sharedCost }
    (HasData: True;
     NationalNumberPattern: '8(?:4[3-5]|7[0-2])\d{7}';
     ExampleNumber: '8433456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{8}';
     ExampleNumber: '7033456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB voip }
    (HasData: True;
     NationalNumberPattern: '56\d{8}';
     ExampleNumber: '5633456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB pager }
    (HasData: True;
     NationalNumberPattern: '76\d{8}';
     ExampleNumber: '7623456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{6,10}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 1),
    { GG fixedLine }
    (HasData: True;
     NationalNumberPattern: '\d{6,10}';
     ExampleNumber: '7033456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 1),
    { GG mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[0389]\d{5,10}';
     ExampleNumber: '';
     LengthOffset: 37; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT fixedLine }
    (HasData: True;
     NationalNumberPattern: '0\d{9,10}';
     ExampleNumber: '0123456789';
     LengthOffset: 17; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT mobile }
    (HasData: True;
     NationalNumberPattern: '3\d{8,9}';
     ExampleNumber: '3123456789';
     LengthOffset: 20; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT tollFree }
    (HasData: True;
     NationalNumberPattern: '80(?:0\d{6}|3\d{3})';
     ExampleNumber: '800123456';
     LengthOffset: 41; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT premiumRate }
    (HasData: True;
     NationalNumberPattern: '89(?:2\d{3}|9\d{6})';
     ExampleNumber: '892123';
     LengthOffset: 41; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP generalDesc }
    (HasData: True;
     NationalNumberPattern: '07\d{5}|[1-357-9]\d{3,10}';
     ExampleNumber: '';
     LengthOffset: 24; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP fixedLine }
    (HasData: True;
     NationalNumberPattern: '07\d{5}|[1-357-9]\d{3,10}';
     ExampleNumber: '0712345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP tollFree }
    (HasData: True;
     NationalNumberPattern: '0777[01]\d{2}';
     ExampleNumber: '0777012';
     LengthOffset: 22; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '[23]\d{3}';
     ExampleNumber: '2123';
     LengthOffset: 43; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-7]\d{3,9}|8\d{8}';
     ExampleNumber: '';
     LengthOffset: 44; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2|[34][1-3]|5[1-5]|6[1-4])(?:1\d{2,3}|[2-9]\d{6,7})';
     ExampleNumber: '22123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR mobile }
    (HasData: True;
     NationalNumberPattern: '1[0-25-9]\d{7,8}';
     ExampleNumber: '1023456789';
     LengthOffset: 20; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{7}';
     ExampleNumber: '801234567';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR premiumRate }
    (HasData: True;
     NationalNumberPattern: '60[2-9]\d{6}';
     ExampleNumber: '602345678';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR personalNumber }
    (HasData: True;
     NationalNumberPattern: '50\d{8}';
     ExampleNumber: '5012345678';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR voip }
    (HasData: True;
     NationalNumberPattern: '70\d{8}';
     ExampleNumber: '7012345678';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{9,10}';
     ExampleNumber: '';
     LengthOffset: 17; LengthCount: 2;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { MX fixedLine }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{9}';
     ExampleNumber: '2123456789';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { MX mobile }
    (HasData: True;
     NationalNumberPattern: '1\d{10}';
     ExampleNumber: '11234567890';
     LengthOffset: 23; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[289]\d{7,9}|[3-7]\d{7}';
     ExampleNumber: '';
     LengthOffset: 51; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '24099\d{3}|(?:3[2-79]|[479][2-689]|6[235-9])\d{6}';
     ExampleNumber: '24099123';
     LengthOffset: 55; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ mobile }
    (HasData: True;
     NationalNumberPattern: '2(?:[027]\d{7}|9\d{6,7}|1(?:0\d{5,7}|[12]\d{5,6}|[3-9]\d{5})|4[1-9]\d{6}|8\d{7,8})';
     ExampleNumber: '201234567';
     LengthOffset: 57; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6,7}';
     ExampleNumber: '8001234567';
     LengthOffset: 20; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{6,7}';
     ExampleNumber: '9001234567';
     LengthOffset: 20; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL mobile }
    (HasData: True;
     NationalNumberPattern: '(?:5[01]|6[069]|7[289]|88)\d{7}';
     ExampleNumber: '501234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL premiumRate }
    (HasData: True;
     NationalNumberPattern: '70\d{7}';
     ExampleNumber: '701234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[268]\d{8}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE fixedLine }
    (HasData: True;
     NationalNumberPattern: '262\d{6}';
     ExampleNumber: '262161234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE mobile }
    (HasData: True;
     NationalNumberPattern: '6(?:9[23]|47)\d{6}';
     ExampleNumber: '692123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{7}';
     ExampleNumber: '801234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE premiumRate }
    (HasData: True;
     NationalNumberPattern: '8(?:1[01]|2[0156]|84|9[0-37-9])\d{6}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[347-9]\d{9}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU fixedLine }
    (HasData: True;
     NationalNumberPattern: '[348]\d{9}';
     ExampleNumber: '3011234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU mobile }
    (HasData: True;
     NationalNumberPattern: '9\d{9}';
     ExampleNumber: '9123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{9}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE fixedLine }
    (HasData: True;
     NationalNumberPattern: '';
     ExampleNumber: '123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13689]\d{7,10}';
     ExampleNumber: '';
     LengthOffset: 60; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG fixedLine }
    (HasData: True;
     NationalNumberPattern: '[36]\d{7}';
     ExampleNumber: '31234567';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG mobile }
    (HasData: True;
     NationalNumberPattern: '[89]\d{7}';
     ExampleNumber: '81234567';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG tollFree }
    (HasData: True;
     NationalNumberPattern: '1?800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 17; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG premiumRate }
    (HasData: True;
     NationalNumberPattern: '1900\d{7}';
     ExampleNumber: '19001234567';
     LengthOffset: 23; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{3,7}';
     ExampleNumber: '';
     LengthOffset: 63; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA fixedLine }
    (HasData: True;
     NationalNumberPattern: '8\d{5}';
     ExampleNumber: '812345';
     LengthOffset: 0; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA mobile }
    (HasData: True;
     NationalNumberPattern: '8\d{3}';
     ExampleNumber: '8123';
     LengthOffset: 43; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA tollFree }
    (HasData: True;
     NationalNumberPattern: '8\d{7}';
     ExampleNumber: '81234567';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13-689]\d{9}|2[0-35-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { US fixedLine }
    (HasData: True;
     NationalNumberPattern: '[13-689]\d{9}|2[0-35-9]\d{8}';
     ExampleNumber: '1234567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { US mobile }
    (HasData: True;
     NationalNumberPattern: '[13-689]\d{9}|2[0-35-9]\d{8}';
     ExampleNumber: '1234567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { US tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|66|77|88)\d{7}';
     ExampleNumber: '8004567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{7}';
     ExampleNumber: '9004567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8004567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[69]\d{8}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { UZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '6122\d{5}';
     ExampleNumber: '662345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 22; LocalOnlyCount: 1),
    { UZ mobile }
    (HasData: True;
     NationalNumberPattern: '9[0-57-9]\d{7}';
     ExampleNumber: '912345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[268]\d{8}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT fixedLine }
    (HasData: True;
     NationalNumberPattern: '2696[0-4]\d{4}';
     ExampleNumber: '269601234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT mobile }
    (HasData: True;
     NationalNumberPattern: '639\d{6}';
     ExampleNumber: '639123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{7}';
     ExampleNumber: '801234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{8}';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: True;
     NationalNumberPattern: '\d{8}';
     ExampleNumber: '12345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{9}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: True;
     NationalNumberPattern: '\d{9}';
     ExampleNumber: '123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{9}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: True;
     NationalNumberPattern: '\d{9}';
     ExampleNumber: '123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 1; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0)
  );

implementation

end.
