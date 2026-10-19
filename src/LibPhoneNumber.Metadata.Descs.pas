unit LibPhoneNumber.Metadata.Descs;

{
  GENERATED FILE - DO NOT EDIT.

  Phone number descriptions (patterns, example numbers, possible length slices) for every territory and number type.

  Source:    vendor/libphonenumber/resources/PhoneNumberMetadata.xml
  Commit:    33be5664343676b27761213d8f5500d682568ea7
  Generator: tools/generate_metadata.ps1 (metadata-v1)

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
  PhoneMetadataDescCount = 3048;

  PhoneMetadataDescs: array[0..3047] of TPhoneNumberDescRec = (
    { AC generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[01589]\d|[2-467])\d{4}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC fixedLine }
    (HasData: True;
     NationalNumberPattern: '6\d{4}';
     ExampleNumber: '62889';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC mobile }
    (HasData: True;
     NationalNumberPattern: '[2-47]\d{4}';
     ExampleNumber: '40123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC uan }
    (HasData: True;
     NationalNumberPattern: '(?:0[1-9]|[1589]\d)\d{4}';
     ExampleNumber: '542011';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1|6\d)\d{7}|[135-9]\d{5}';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD fixedLine }
    (HasData: True;
     NationalNumberPattern: '[78]\d{5}';
     ExampleNumber: '712345';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD mobile }
    (HasData: True;
     NationalNumberPattern: '690\d{6}|[356]\d{5}';
     ExampleNumber: '312345';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD tollFree }
    (HasData: True;
     NationalNumberPattern: '180[02]\d{4}';
     ExampleNumber: '18001234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD premiumRate }
    (HasData: True;
     NationalNumberPattern: '[19]\d{5}';
     ExampleNumber: '912345';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AD noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '1800\d{4}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[4-7]\d|9[0-689])\d{7}|800\d{2,9}|[2-4679]\d{7}';
     ExampleNumber: '';
     LengthOffset: 11; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE fixedLine }
    (HasData: True;
     NationalNumberPattern: '[2-4679][2-8]\d{6}';
     ExampleNumber: '22345678';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AE mobile }
    (HasData: True;
     NationalNumberPattern: '5[02-68]\d{7}';
     ExampleNumber: '501234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE tollFree }
    (HasData: True;
     NationalNumberPattern: '400\d{6}|800\d{2,9}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[02]\d{5}';
     ExampleNumber: '900234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE sharedCost }
    (HasData: True;
     NationalNumberPattern: '700[05]\d{5}';
     ExampleNumber: '700012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE uan }
    (HasData: True;
     NationalNumberPattern: '600[25]\d{5}';
     ExampleNumber: '600212345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-7]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AF fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:[25][0-8]|[34][0-4]|6[0-5])[2-9]\d{6}';
     ExampleNumber: '234567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AF mobile }
    (HasData: True;
     NationalNumberPattern: '7\d{8}';
     ExampleNumber: '701234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AF tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AF noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:268|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AG fixedLine }
    (HasData: True;
     NationalNumberPattern: '268(?:4(?:6[0-38]|84)|56[0-2])\d{4}';
     ExampleNumber: '2684601234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AG mobile }
    (HasData: True;
     NationalNumberPattern: '268(?:464|7(?:1[3-9]|[28]\d|3[0246]|64|7[0-689]))\d{4}';
     ExampleNumber: '2684641234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AG tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG voip }
    (HasData: True;
     NationalNumberPattern: '26848[01]\d{4}';
     ExampleNumber: '2684801234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AG pager }
    (HasData: True;
     NationalNumberPattern: '26840[69]\d{4}';
     ExampleNumber: '2684061234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:264|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AI fixedLine }
    (HasData: True;
     NationalNumberPattern: '264(?:292|4(?:6[12]|9[78]))\d{4}';
     ExampleNumber: '2644612345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AI mobile }
    (HasData: True;
     NationalNumberPattern: '264(?:235|4(?:69|7[67])|5(?:3[6-9]|8[1-4])|7(?:29|72))\d{4}';
     ExampleNumber: '2642351234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AI tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI pager }
    (HasData: True;
     NationalNumberPattern: '264724\d{4}';
     ExampleNumber: '2647241234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:700\d\d|900)\d{3}|8\d{5,7}|(?:[2-5]|6\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 22; LengthCount: 4;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { AL fixedLine }
    (HasData: True;
     NationalNumberPattern: '4505[0-2]\d{3}|(?:[2358][16-9]\d[2-9]|4410)\d{4}|(?:[2358][2-5][2-9]|4(?:[2-57-9][2-9]|6\d))\d{5' +
       '}';
     ExampleNumber: '22345678';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { AL mobile }
    (HasData: True;
     NationalNumberPattern: '6(?:[78][2-9]|9\d)\d{6}';
     ExampleNumber: '672123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4}';
     ExampleNumber: '8001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[1-9]\d\d';
     ExampleNumber: '900123';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL sharedCost }
    (HasData: True;
     NationalNumberPattern: '808[1-9]\d\d';
     ExampleNumber: '808123';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL personalNumber }
    (HasData: True;
     NationalNumberPattern: '700[2-9]\d{4}';
     ExampleNumber: '70021234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AL noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[1-489]\d|55|60|77)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { AM fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:1[0-25]|47)\d|2(?:2[2-46]|3[1-8]|4[2-69]|5[2-7]|6[1-9]|8[1-7])|3[12]2)\d{5}';
     ExampleNumber: '10123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { AM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:33|4[1349]|55|77|88|9[13-9])\d{6}';
     ExampleNumber: '77123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[016]\d{5}';
     ExampleNumber: '90012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM sharedCost }
    (HasData: True;
     NationalNumberPattern: '80[1-4]\d{5}';
     ExampleNumber: '80112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM voip }
    (HasData: True;
     NationalNumberPattern: '60(?:2[78]|3[5-9]|4[02-9]|5[0-46-9]|[6-8]\d|9[0-2])\d{4}';
     ExampleNumber: '60271234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[29]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO fixedLine }
    (HasData: True;
     NationalNumberPattern: '2\d(?:[0134][25-9]|[25-9]\d)\d{5}';
     ExampleNumber: '222123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO mobile }
    (HasData: True;
     NationalNumberPattern: '9[1-79]\d{7}';
     ExampleNumber: '923123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:11|[89]\d\d)\d{8}|[2368]\d{9}';
     ExampleNumber: '';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 31; LocalOnlyCount: 3),
    { AR fixedLine }
    (HasData: True;
     NationalNumberPattern: '3(?:7(?:1[15]|81)|8(?:21|4[16]|69|9[12]))[46]\d{5}|(?:2(?:2(?:2[59]|44|52)|3(?:26|44)|47[35]|9(?' +
       ':[07]2|2[26]|34|46))|3327)[45]\d{5}|(?:2(?:657|9(?:54|66))|3(?:48[27]|7(?:55|77)|8(?:65|78)))[2-' +
       '8]\d{5}|(?:2(?:284|3(?:02|23)|477|622|920)|3(?:4(?:46|89|92)|541))[2-7]\d{5}|(?:(?:11[0-8]|670)\' +
       'd|2(?:2(?:0[45]|1[2-6]|3[3-6])|3(?:[06]4|7[45])|494|6(?:04|1[2-8]|[36][45]|4[3-6])|80[45]|9(?:[1' +
       '7][4-6]|[48][45]|9[3-6]))|3(?:364|4(?:1[2-8]|[25][4-6]|3[3-6]|84)|5(?:1[2-9]|[38][4-6])|6(?:2[45' +
       ']|44)|7[069][45]|8(?:0[45]|1[2-7]|3[4-6]|5[3-6]|7[2-6]|8[3-68])))\d{6}|(?:2(?:2(?:62|81)|320|9(?' +
       ':42|83))|3(?:329|4(?:62|7[16])|5(?:43|64)|7(?:18|5[17])))[2-6]\d{5}|2(?:2(?:21|4[23]|6[145]|7[1-' +
       '4]|8[356]|9[267])|3(?:16|3[13-8]|43|5[346-8]|9[3-5])|6(?:2[46]|4[78]|5[1568])|9(?:03|2[1457-9]|3' +
       '[1356]|4[08]|[56][23]|82))4\d{5}|(?:2(?:257|3(?:24|46|92)|9(?:01|23|64))|3(?:4(?:42|64)|5(?:25|3' +
       '7|4[47]|71)|7(?:35|72)|825))[3-6]\d{5}|(?:2(?:2(?:02|2[3467]|4[156]|5[45]|6[6-8]|91)|3(?:1[47]|2' +
       '5|[45][25]|96)|47[48]|625|932)|3(?:38[2578]|4(?:0[0-24-9]|3[78]|4[457]|58|6[035-9]|72|83|9[136-8' +
       '])|5(?:2[124]|[368][23]|4[2689]|7[2-6])|7(?:16|2[15]|3[14]|4[13]|5[468]|7[3-5]|8[26])|8(?:2[67]|' +
       '3[278]|4[3-5]|5[78]|6[1-378]|[78]7|94)))[4-6]\d{5}';
     ExampleNumber: '1123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 31; LocalOnlyCount: 3),
    { AR mobile }
    (HasData: True;
     NationalNumberPattern: '93(?:7(?:1[15]|81)|8(?:21|4[16]|69|9[12]))[46]\d{5}|9(?:2(?:2(?:2[59]|44|52)|3(?:26|44)|47[35]|9' +
       '(?:[07]2|2[26]|34|46))|3327)[45]\d{5}|9(?:2(?:657|9(?:54|66))|3(?:48[27]|7(?:55|77)|8(?:65|78)))' +
       '[2-8]\d{5}|9(?:2(?:284|3(?:02|23)|477|622|920)|3(?:4(?:46|89|92)|541))[2-7]\d{5}|(?:675\d|9(?:11' +
       '[0-8]\d|2(?:2(?:0[45]|1[2-6]|3[3-6])|3(?:[06]4|7[45])|494|6(?:04|1[2-8]|[36][45]|4[3-6])|80[45]|' +
       '9(?:[17][4-6]|[48][45]|9[3-6]))|3(?:364|4(?:1[2-8]|[25][4-6]|3[3-6]|84)|5(?:1[2-9]|[38][4-6])|6(' +
       '?:2[45]|44)|7[069][45]|8(?:0[45]|1[2-7]|3[4-6]|5[3-6]|7[2-6]|8[3-68]))))\d{6}|9(?:2(?:2(?:62|81)' +
       '|320|9(?:42|83))|3(?:329|4(?:62|7[16])|5(?:43|64)|7(?:18|5[17])))[2-6]\d{5}|92(?:2(?:21|4[23]|6[' +
       '145]|7[1-4]|8[356]|9[267])|3(?:16|3[13-8]|43|5[346-8]|9[3-5])|6(?:2[46]|4[78]|5[1568])|9(?:03|2[' +
       '1457-9]|3[1356]|4[08]|[56][23]|82))4\d{5}|9(?:2(?:257|3(?:24|46|92)|9(?:01|23|64))|3(?:4(?:42|64' +
       ')|5(?:25|37|4[47]|71)|7(?:35|72)|825))[3-6]\d{5}|9(?:2(?:2(?:02|2[3467]|4[156]|5[45]|6[6-8]|91)|' +
       '3(?:1[47]|25|[45][25]|96)|47[48]|625|932)|3(?:38[2578]|4(?:0[0-24-9]|3[78]|4[457]|58|6[035-9]|72' +
       '|83|9[136-8])|5(?:2[124]|[368][23]|4[2689]|7[2-6])|7(?:16|2[15]|3[14]|4[13]|5[468]|7[3-5]|8[26])' +
       '|8(?:2[67]|3[278]|4[3-5]|5[78]|6[1-378]|[78]7|94)))[4-6]\d{5}';
     ExampleNumber: '91123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 31; LocalOnlyCount: 3),
    { AR tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7,8}';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR premiumRate }
    (HasData: True;
     NationalNumberPattern: '60[04579]\d{7}';
     ExampleNumber: '6001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR uan }
    (HasData: True;
     NationalNumberPattern: '810\d{7}';
     ExampleNumber: '8101234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AR noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '810\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|684|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AS fixedLine }
    (HasData: True;
     NationalNumberPattern: '684(?:274|6(?:22|33|44|55|77|88|9[19]))\d{4}';
     ExampleNumber: '6846221234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AS mobile }
    (HasData: True;
     NationalNumberPattern: '684(?:2(?:48|5[2468]|7[246])|7(?:3[13]|70|82))\d{4}';
     ExampleNumber: '6847331234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AS tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{3,12}|2\d{6,12}|43(?:(?:0\d|5[02-9])\d{3,9}|2\d{4,5}|[3467]\d{4}|8\d{4,6}|9\d{4,7})|5\d{4,12' +
       '}|8\d{7,12}|9\d{8,12}|(?:[367]\d|4[0-24-9])\d{4,11}';
     ExampleNumber: '';
     LengthOffset: 34; LengthCount: 10;
     LocalOnlyOffset: 44; LocalOnlyCount: 1),
    { AT fixedLine }
    (HasData: True;
     NationalNumberPattern: '1(?:11\d|[2-9]\d{3,11})|(?:316|463)\d{3,10}|648[34]\d{3,9}|(?:51|66|73)2\d{3,10}|(?:2(?:1[467]|2' +
       '[13-8]|5[2357]|6[1-46-8]|7[1-8]|8[124-7]|9[1458])|3(?:1[1-578]|3[23568]|4[5-7]|5[1378]|6[1-38]|8' +
       '[3-68])|4(?:2[1-8]|35|7[1368]|8[2457])|5(?:2[1-8]|3[357]|4[147]|5[12578]|6[37])|6(?:13|2[1-47]|4' +
       '[135-7]|5[468])|7(?:2[1-8]|35|4[13478]|5[68]|6[16-8]|7[1-6]|9[45]))\d{4,10}';
     ExampleNumber: '1234567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 44; LocalOnlyCount: 1),
    { AT mobile }
    (HasData: True;
     NationalNumberPattern: '6(?:485|(?:5[0-3579]|6[013-9]|[7-9]\d)\d)\d{3,9}';
     ExampleNumber: '664123456';
     LengthOffset: 45; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6,10}';
     ExampleNumber: '800123456';
     LengthOffset: 52; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:8[69][2-68]|9(?:0[01]|3[019]))\d{6,10}';
     ExampleNumber: '900123456';
     LengthOffset: 52; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT sharedCost }
    (HasData: True;
     NationalNumberPattern: '8(?:10|2[018])\d{6,10}|828\d{5}';
     ExampleNumber: '810123456';
     LengthOffset: 57; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT voip }
    (HasData: True;
     NationalNumberPattern: '5(?:0[1-9]|17|[79]\d)\d{2,10}|7[28]0\d{6,10}';
     ExampleNumber: '780123456';
     LengthOffset: 63; LengthCount: 9;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU generalDesc }
    (HasData: True;
     NationalNumberPattern: '1(?:[0-79]\d{7}(?:\d(?:\d{2})?)?|8[0-24-9]\d{7})|[2-478]\d{8}|1\d{4,7}';
     ExampleNumber: '';
     LengthOffset: 72; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:241|349)0\d\d|8(?:51(?:0(?:0[03-9]|[12479]\d|3[2-9]|5[0-8]|6[1-9]|8[0-7])|1(?:[0235689]\d|' +
       '1[0-69]|4[0-589]|7[0-47-9])|2(?:0[0-79]|[18][13579]|2[14-9]|3[0-46-9]|[4-6]\d|7[89]|9[0-4])|[34]' +
       '\d\d)|91(?:(?:[0-58]\d|6[0135-9])\d|7(?:0[0-24-9]|[1-9]\d)|9(?:[0-46-9]\d|5[0-79]))))\d{3}|(?:2(' +
       '?:[0-26-9]\d|3[0-8]|4[02-9]|5[0135-9])|3(?:[0-3589]\d|4[0-578]|6[1-9]|7[0-35-9])|7(?:[013-57-9]\' +
       'd|2[0-8])|8(?:55|6[0-8]|[78]\d|9[02-9]))\d{6}';
     ExampleNumber: '212345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 10; LocalOnlyCount: 1),
    { AU mobile }
    (HasData: True;
     NationalNumberPattern: '4(?:79[01]|83[0-36-9]|95[0-3])\d{5}|4(?:[0-36]\d|4[047-9]|[58][0-24-9]|7[02-8]|9[0-47-9])\d{6}';
     ExampleNumber: '412345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU tollFree }
    (HasData: True;
     NationalNumberPattern: '180(?:0\d{3}|2)\d{3}';
     ExampleNumber: '1800123456';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU premiumRate }
    (HasData: True;
     NationalNumberPattern: '190[0-26]\d{6}';
     ExampleNumber: '1900123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU sharedCost }
    (HasData: True;
     NationalNumberPattern: '13(?:00\d{6}(?:\d{2})?|45[0-4]\d{3})|13\d{4}';
     ExampleNumber: '1300123456';
     LengthOffset: 81; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU voip }
    (HasData: True;
     NationalNumberPattern: '14(?:5(?:1[0458]|[23][458])|71\d)\d{4}';
     ExampleNumber: '147101234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU pager }
    (HasData: True;
     NationalNumberPattern: '163\d{2,6}';
     ExampleNumber: '1631234';
     LengthOffset: 85; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AU noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '1(?:3(?:00\d{5}|45[0-4])|802)\d{3}|1[38]00\d{6}|13\d{4}';
     ExampleNumber: '';
     LengthOffset: 90; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[25-79]\d\d|800)\d{4}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW fixedLine }
    (HasData: True;
     NationalNumberPattern: '5(?:2\d|8[1-9])\d{4}';
     ExampleNumber: '5212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW mobile }
    (HasData: True;
     NationalNumberPattern: '(?:290|5[69]\d|6(?:[03]0|22|4[0-2]|[69]\d)|7(?:[34]\d|7[07])|9(?:6[45]|9[4-8]))\d{4}';
     ExampleNumber: '5601234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4}';
     ExampleNumber: '8001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{4}';
     ExampleNumber: '9001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW voip }
    (HasData: True;
     NationalNumberPattern: '(?:28\d|501)\d{4}';
     ExampleNumber: '5011234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX generalDesc }
    (HasData: True;
     NationalNumberPattern: '2\d{4,9}|35\d{4,5}|(?:60\d\d|800)\d{4,6}|7\d{5,11}|(?:[14]\d|3[0-46-9]|50)\d{4,8}';
     ExampleNumber: '';
     LengthOffset: 11; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX fixedLine }
    (HasData: True;
     NationalNumberPattern: '18[1-8]\d{3,6}';
     ExampleNumber: '181234567';
     LengthOffset: 22; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX mobile }
    (HasData: True;
     NationalNumberPattern: '4946\d{2,6}|(?:4[0-8]|50)\d{4,8}';
     ExampleNumber: '412345678';
     LengthOffset: 95; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4,6}';
     ExampleNumber: '800123456';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX premiumRate }
    (HasData: True;
     NationalNumberPattern: '[67]00\d{5,6}';
     ExampleNumber: '600123456';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX uan }
    (HasData: True;
     NationalNumberPattern: '20\d{4,8}|60[12]\d{5,6}|7(?:099\d{4,5}|5[03-9]\d{3,7})|20[2-59]\d\d|(?:606|7(?:0[78]|1|3\d))\d{7' +
       '}|(?:10|29|3[09]|70[1-5]\d)\d{4,8}';
     ExampleNumber: '10112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AX noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '365\d{6}|(?:[124579]\d|60|88)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[12]428|3655[02])\d{4}|(?:2(?:22[0-79]|63[0-28])|3654)\d{5}|(?:(?:1[28]|46)\d|2(?:[014-6]2|[' +
       '23]3))\d{6}';
     ExampleNumber: '123123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { AZ mobile }
    (HasData: True;
     NationalNumberPattern: '36554\d{4}|(?:[16]0|4[04]|5[015]|7[07]|99)\d{7}';
     ExampleNumber: '401234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ tollFree }
    (HasData: True;
     NationalNumberPattern: '88\d{7}';
     ExampleNumber: '881234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '900200\d{3}';
     ExampleNumber: '900200123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { AZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA generalDesc }
    (HasData: True;
     NationalNumberPattern: '6\d{8}|(?:[35689]\d|49|70)\d{6}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { BA fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3(?:[05-79][2-9]|1[4579]|[23][24-9]|4[2-4689]|8[2457-9])|49[2-579]|5(?:0[2-49]|[13][2-9]|[268' +
       '][2-4679]|4[4689]|5[2-79]|7[2-69]|9[2-4689]))\d{5}';
     ExampleNumber: '30212345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { BA mobile }
    (HasData: True;
     NationalNumberPattern: '6040\d{5}|6(?:03|[1-356]|44|7\d)\d{6}';
     ExampleNumber: '61123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA tollFree }
    (HasData: True;
     NationalNumberPattern: '8[08]\d{6}';
     ExampleNumber: '80123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA premiumRate }
    (HasData: True;
     NationalNumberPattern: '9[0246]\d{6}';
     ExampleNumber: '90123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA sharedCost }
    (HasData: True;
     NationalNumberPattern: '8[12]\d{6}';
     ExampleNumber: '82123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA uan }
    (HasData: True;
     NationalNumberPattern: '703[235]0\d{3}|70(?:2[0-5]|3[0146]|[56]0)\d{4}';
     ExampleNumber: '70341234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:246|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BB fixedLine }
    (HasData: True;
     NationalNumberPattern: '246521[0369]\d{3}|246(?:2(?:2[78]|7[0-4])|4(?:1[024-6]|2\d|3[2-9])|5(?:20|[34]\d|54|7[1-3])|6(?:' +
       '2\d|38)|7[35]7|9(?:1[89]|63))\d{4}';
     ExampleNumber: '2464123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BB mobile }
    (HasData: True;
     NationalNumberPattern: '246(?:(?:2(?:[3568]\d|4[0-57-9])|3(?:5[2-9]|6[0-6])|4(?:46|5\d)|69[5-7]|8(?:[2-5]\d|83))\d|52(?:' +
       '1[147]|20))\d{3}';
     ExampleNumber: '2462501234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BB tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:246976|900[2-9]\d\d)\d{4}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BB sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB voip }
    (HasData: True;
     NationalNumberPattern: '24631\d{5}';
     ExampleNumber: '2463101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BB pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB uan }
    (HasData: True;
     NationalNumberPattern: '246(?:292|367|4(?:1[7-9]|3[01]|4[47-9]|67)|7(?:1[2-9]|2\d|3[016]|53))\d{4}';
     ExampleNumber: '2464301234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BB voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BB noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-469]\d{9}|8[0-79]\d{7,8}|[2-79]\d{8}|[2-9]\d{7}|[3-9]\d{6}|[57-9]\d{5}';
     ExampleNumber: '';
     LengthOffset: 95; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:4(?:31\d\d|423)|5222)\d{3}(?:\d{2})?|8332[6-9]\d\d|(?:3(?:03[56]|224)|4(?:22[25]|653))\d{3,4}' +
       '|(?:3(?:42[47]|529|823)|4(?:027|525|65(?:28|8))|562|6257|7(?:1(?:5[3-5]|6[12]|7[156]|89)|22[589]' +
       '56|32|42675|52(?:[25689](?:56|8)|[347]8)|71(?:6[1267]|75|89)|92374)|82(?:2[59]|32)56|9(?:03[23]5' +
       '6|23(?:256|373)|31|5(?:1|2[4589]56)))\d{3}|(?:3(?:02[348]|22[35]|324|422)|4(?:22[67]|32[236-9]|6' +
       '(?:2[46]|5[57])|953)|5526|6(?:024|6655)|81)\d{4,5}|(?:2(?:7(?:1[0-267]|2[0-289]|3[0-29]|4[01]|5[' +
       '1-3]|6[013]|7[0178]|91)|8(?:0[125]|1[1-6]|2[0157-9]|3[1-69]|41|6[1-35]|7[1-5]|8[1-8]|9[0-6])|9(?' +
       ':0[0-2]|1[0-4]|2[568]|3[3-6]|5[5-7]|6[0136-9]|7[0-7]|8[014-9]))|3(?:0(?:2[025-79]|3[2-4])|181|22' +
       '[12]|32[2356]|824)|4(?:02[09]|22[348]|32[045]|523|6(?:27|54))|666(?:22|53)|7(?:22[57-9]|42[56]|8' +
       '2[35])8|8(?:0[124-9]|2(?:181|2[02-4679]8)|4[12]|[5-7]2)|9(?:[04]2|2(?:2|328)|81))\d{4}|(?:2(?:[2' +
       '3]\d|[45])\d\d|3(?:1(?:2[5-7]|[5-7])|425|822)|4(?:033|1\d|[257]1|332|4(?:2[246]|5[25])|6(?:2[35]' +
       '|56|62)|8(?:23|54)|92[2-5])|5(?:02[03489]|22[457]|32[35-79]|42[46]|6(?:[18]|53)|724|826)|6(?:023' +
       '|2(?:2[2-5]|5[3-5]|8)|32[3478]|42[34]|52[47]|6(?:[18]|6(?:2[34]|5[24]))|[78]2[2-5]|92[2-6])|7(?:' +
       '02|21\d|[3-589]1|6[12]|72[24])|8(?:217|3[12]|[5-7]1)|9[24]1)\d{5}|(?:(?:3[2-8]|5[2-57-9]|6[03-58' +
       '9])1|4[4689][18])\d{5}|[59]1\d{5}';
     ExampleNumber: '27111234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD mobile }
    (HasData: True;
     NationalNumberPattern: '(?:1[13-9]|64)\d{8}|(?:3[78]|44|66)[02-9]\d{7}';
     ExampleNumber: '1812345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD tollFree }
    (HasData: True;
     NationalNumberPattern: '80[03]\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD voip }
    (HasData: True;
     NationalNumberPattern: '96(?:0[1-69]|1[0-479]|2[278]|3[13-9]|4[0-47-9]|54|6[69]|7[78]|88)\d{6}';
     ExampleNumber: '9604123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BD noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE generalDesc }
    (HasData: True;
     NationalNumberPattern: '4\d{8}|[1-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE fixedLine }
    (HasData: True;
     NationalNumberPattern: '80[2-8]\d{5}|(?:1[0-69]|[23][2-8]|4[23]|5\d|6[013-57-9]|71|8[1-79]|9[2-4])\d{6}';
     ExampleNumber: '12345678';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE mobile }
    (HasData: True;
     NationalNumberPattern: '4[5-9]\d{7}';
     ExampleNumber: '450001234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE tollFree }
    (HasData: True;
     NationalNumberPattern: '800[1-9]\d{4}';
     ExampleNumber: '80012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:70(?:2[0-57]|3[04-7]|44|6[04-69]|7[0579])|90\d\d)\d{4}';
     ExampleNumber: '90012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE sharedCost }
    (HasData: True;
     NationalNumberPattern: '7879\d{4}';
     ExampleNumber: '78791234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE uan }
    (HasData: True;
     NationalNumberPattern: '78(?:0[578]|1[014-8]|2[25]|3[15-8]|48|5[05]|60|7[06-8]|9\d)\d{4}';
     ExampleNumber: '78102345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF generalDesc }
    (HasData: True;
     NationalNumberPattern: '[024-7]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:0(?:49|5[23]|6[5-7]|9[016-9])|4(?:4[569]|5[4-6]|6[5-7]|7[0179])|5(?:[34]\d|50|6[5-8]))\d{4}';
     ExampleNumber: '20491234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF mobile }
    (HasData: True;
     NationalNumberPattern: '(?:0[1-7]|4[4-6]|5[0-8]|[67]\d)\d{6}';
     ExampleNumber: '70123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BF noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG generalDesc }
    (HasData: True;
     NationalNumberPattern: '00800\d{7}|[2-7]\d{6,7}|[89]\d{6,8}|2\d{5}';
     ExampleNumber: '';
     LengthOffset: 105; LengthCount: 5;
     LocalOnlyOffset: 110; LocalOnlyCount: 2),
    { BG fixedLine }
    (HasData: True;
     NationalNumberPattern: '2\d{5,7}|(?:43[1-6]|70[1-9])\d{4,5}|(?:[36]\d|4[124-7]|[57][1-9]|8[1-6]|9[1-7])\d{5,6}';
     ExampleNumber: '2123456';
     LengthOffset: 31; LengthCount: 3;
     LocalOnlyOffset: 110; LocalOnlyCount: 2),
    { BG mobile }
    (HasData: True;
     NationalNumberPattern: '(?:43[07-9]|99[69]\d)\d{5}|(?:8[7-9]|98)\d{7}';
     ExampleNumber: '43012345';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:00800\d\d|800)\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 112; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d{6}';
     ExampleNumber: '90123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG sharedCost }
    (HasData: True;
     NationalNumberPattern: '700\d{5}';
     ExampleNumber: '70012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[136-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:3[1356]|6[0156]|7\d)\d|6(?:1[16]\d|500|6(?:0\d|3[12]|44|55|7[7-9]|88)|9[69][69])|7(?:[07]' +
       '\d\d|1(?:11|78)))\d{4}';
     ExampleNumber: '17001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:3(?:[0-79]\d|8[0-57-9])\d|6(?:3(?:00|33|6[16])|441|6(?:3[03-9]|[69]\d|7[0-689])))\d{4}';
     ExampleNumber: '36001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH tollFree }
    (HasData: True;
     NationalNumberPattern: '8[02369]\d{6}';
     ExampleNumber: '80123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:87|9[0-8])\d{6}';
     ExampleNumber: '90123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH sharedCost }
    (HasData: True;
     NationalNumberPattern: '84\d{6}';
     ExampleNumber: '84123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[267]\d|31)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:22|31)\d{6}';
     ExampleNumber: '22201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI mobile }
    (HasData: True;
     NationalNumberPattern: '(?:29|6[1-9]|7[125-9])\d{6}';
     ExampleNumber: '79561234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:01\d|8)\d{7}';
     ExampleNumber: '';
     LengthOffset: 114; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ fixedLine }
    (HasData: True;
     NationalNumberPattern: '012\d{7}';
     ExampleNumber: '0120211234';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ mobile }
    (HasData: True;
     NationalNumberPattern: '01(?:2[5-9]|[4-69]\d)\d{6}';
     ExampleNumber: '0195123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ voip }
    (HasData: True;
     NationalNumberPattern: '857[58]\d{4}';
     ExampleNumber: '85751234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ uan }
    (HasData: True;
     NationalNumberPattern: '81\d{6}';
     ExampleNumber: '81123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BJ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL generalDesc }
    (HasData: True;
     NationalNumberPattern: '7090\d{5}|(?:[56]9|[89]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:59(?:0(?:2[7-9]|3[3-7]|5[12]|87)|87\d)|80[6-9]\d\d)\d{4}';
     ExampleNumber: '590271234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL mobile }
    (HasData: True;
     NationalNumberPattern: '(?:69(?:0\d\d|1(?:2[2-9]|3[0-5]))|7090[0-4])\d{4}';
     ExampleNumber: '690001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL premiumRate }
    (HasData: True;
     NationalNumberPattern: '8[129]\d{7}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL voip }
    (HasData: True;
     NationalNumberPattern: '9(?:(?:39[5-7]|76[018])\d|475[0-6])\d{4}';
     ExampleNumber: '976012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BL noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:441|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BM fixedLine }
    (HasData: True;
     NationalNumberPattern: '441(?:[46]\d\d|5(?:4\d|60|89))\d{4}';
     ExampleNumber: '4414123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BM mobile }
    (HasData: True;
     NationalNumberPattern: '441(?:[2378]\d|5[0-39]|9[02])\d{5}';
     ExampleNumber: '4413701234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BM tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-578]\d{6}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN fixedLine }
    (HasData: True;
     NationalNumberPattern: '22[0-7]\d{4}|(?:2[013-9]|[34]\d|5[0-25-9])\d{5}';
     ExampleNumber: '2345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN mobile }
    (HasData: True;
     NationalNumberPattern: '(?:22[89]|[78]\d\d)\d{4}';
     ExampleNumber: '7123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN voip }
    (HasData: True;
     NationalNumberPattern: '5[34]\d{5}';
     ExampleNumber: '5345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BN noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-7]\d\d|8001)\d{5}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BO fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:2\d\d|5(?:11|[258]\d|9[67])|6(?:12|2\d|9[34])|8(?:2[34]|39|62))|3(?:3\d\d|4(?:6\d|8[24])|' +
       '8(?:25|42|5[257]|86|9[25])|9(?:[27]\d|3[2-4]|4[248]|5[24]|6[2-6]))|4(?:4\d\d|6(?:11|[24689]\d|72' +
       ')))\d{4}';
     ExampleNumber: '22123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BO mobile }
    (HasData: True;
     NationalNumberPattern: '(?:57|[67]\d)\d{6}';
     ExampleNumber: '71234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO tollFree }
    (HasData: True;
     NationalNumberPattern: '8001[07]\d{4}';
     ExampleNumber: '800171234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO voip }
    (HasData: True;
     NationalNumberPattern: '50\d{6}';
     ExampleNumber: '50123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BO noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '8001[07]\d{4}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[34]1|7\d)\d{5}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:318[023]|41(?:6[023]|70)|7(?:1[578]|2[05]|50)\d)\d{3}';
     ExampleNumber: '7151234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ mobile }
    (HasData: True;
     NationalNumberPattern: '(?:31(?:8[14-8]|9[14578])|416[14-9]|7(?:0[01]|7[07]|8\d|9[056])\d)\d{3}';
     ExampleNumber: '3181234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BQ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-467]\d{9,10}|55[0-46-9]\d{8}|[34]\d{7}|55\d{7,8}|(?:5[0-46-9]|[89]\d)\d{7,9}';
     ExampleNumber: '';
     LengthOffset: 116; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:[14689][1-9]|2[12478]|3[1-578]|5[13-5]|7[13-579])[2-5]\d{7}';
     ExampleNumber: '1123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 10; LocalOnlyCount: 1),
    { BR mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[14689][1-9]|2[12478]|3[1-578]|5[13-5]|7[13-579])(?:7|9\d)\d{7}';
     ExampleNumber: '11961234567';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 103; LocalOnlyCount: 2),
    { BR tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6,7}';
     ExampleNumber: '800123456';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR premiumRate }
    (HasData: True;
     NationalNumberPattern: '[59]00\d{6,7}';
     ExampleNumber: '500123456';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR sharedCost }
    (HasData: True;
     NationalNumberPattern: '(?:30[03]\d{3}|4(?:0(?:0\d|20)|370|864))\d{4}|300\d{5}';
     ExampleNumber: '40041234';
     LengthOffset: 114; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BR noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '(?:30[03]\d{3}|4(?:0(?:0\d|20)|864))\d{4}|800\d{6,7}|300\d{5}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:242|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BS fixedLine }
    (HasData: True;
     NationalNumberPattern: '242(?:3(?:02|[236][1-9]|4[0-24-9]|5[0-68]|7[347]|8[0-4]|9[2-467])|461|502|6(?:0[1-5]|12|2[013]|[' +
       '45]0|7[67]|8[78]|9[89])|7(?:02|88))\d{4}';
     ExampleNumber: '2423456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BS mobile }
    (HasData: True;
     NationalNumberPattern: '242(?:3(?:5[79]|7[56]|95)|4(?:[23][1-9]|4[1-35-9]|5[1-8]|6[2-8]|7\d|81)|5(?:2[45]|3[35]|44|5[1-4' +
       '6-9]|65|77)|6[34]6|7(?:27|38)|8(?:0[1-9]|1[02-9]|2\d|3[0-4]|[89]9))\d{4}';
     ExampleNumber: '2423591234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BS tollFree }
    (HasData: True;
     NationalNumberPattern: '242300\d{4}|8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { BS premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS uan }
    (HasData: True;
     NationalNumberPattern: '242225\d{4}';
     ExampleNumber: '2422250123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[178]\d{7}|[2-8]\d{6}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { BT fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[3-6]|[34][5-7]|5[236]|6[2-46]|7[246]|8[2-4])\d{5}';
     ExampleNumber: '2345678';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { BT mobile }
    (HasData: True;
     NationalNumberPattern: '(?:1[67]|[78]7)\d{6}';
     ExampleNumber: '17123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:0800|(?:[37]|800)\d)\d{6}|(?:[2-6]\d|90)\d{5}';
     ExampleNumber: '';
     LengthOffset: 127; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:4[0-48]|6[0-24]|9[0578])|3(?:1[0-35-9]|55|[69]\d|7[013]|81)|4(?:6[03]|7[1267]|9[0-5])|5(?' +
       ':3[03489]|4[0489]|7[1-47]|88|9[0-49])|6(?:2[1-35]|5[149]|8[013467]))\d{4}';
     ExampleNumber: '2401234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW mobile }
    (HasData: True;
     NationalNumberPattern: '(?:321|7(?:[1-8]\d|9[03]))\d{5}';
     ExampleNumber: '71123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:0800|800\d)\d{6}';
     ExampleNumber: '0800012345';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d{5}';
     ExampleNumber: '9012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW voip }
    (HasData: True;
     NationalNumberPattern: '79(?:1(?:[0-2]\d|3[0-8])|2[0-7]\d)\d{3}';
     ExampleNumber: '79101234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[12]\d|33|44|902)\d{7}|8(?:0[0-79]\d{5,7}|[1-7]\d{9})|8(?:1[0-489]|[5-79]\d)\d{7}|8[1-79]\d{6' +
       ',7}|8[0-79]\d{5}|8\d{5}';
     ExampleNumber: '';
     LengthOffset: 130; LengthCount: 6;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { BY fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:5(?:1[1-5]|[24]\d|6[2-4]|9[1-7])|6(?:[235]\d|4[1-7])|7\d\d)|2(?:1(?:[246]\d|3[0-35-9]|5[1' +
       '-9])|2(?:[235]\d|4[0-8])|3(?:[26]\d|3[02-79]|4[024-7]|5[03-7])))\d{5}';
     ExampleNumber: '152450911';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { BY mobile }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:5[5-79]|9[1-9])|(?:33|44)\d)\d{6}';
     ExampleNumber: '294911911';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{3,7}|8(?:0[13]|20\d)\d{7}';
     ExampleNumber: '8011234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:810|902)\d{7}';
     ExampleNumber: '9021234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY voip }
    (HasData: True;
     NationalNumberPattern: '249\d{6}';
     ExampleNumber: '249123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BY noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '800\d{3,7}|(?:8(?:0[13]|10|20\d)|902)\d{7}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:0800\d|[2-8])\d{6}';
     ExampleNumber: '';
     LengthOffset: 136; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:[02]\d|36|[68]0)|[3-58](?:[02]\d|[68]0)|7(?:[02]\d|32|[68]0))\d{4}';
     ExampleNumber: '2221234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ mobile }
    (HasData: True;
     NationalNumberPattern: '6[0-35-7]\d{5}';
     ExampleNumber: '6221234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ tollFree }
    (HasData: True;
     NationalNumberPattern: '0800\d{7}';
     ExampleNumber: '08001234123';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { BZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{9}|3\d{6}';
     ExampleNumber: '';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:04|[23]6|[48]9|5[07]|[67]3)|3(?:06|43|54|6[578]|82)|4(?:03|1[68]|[26]8|3[178]|50|74)|5(?:' +
       '06|1[49]|48|79|8[147])|6(?:04|[18]3|39|47|72)|7(?:0[59]|42|53|78|8[02])|8(?:[06]7|19|25|7[39])|9' +
       '(?:0[25]|42))[2-9]\d{6}';
     ExampleNumber: '5062345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { CA mobile }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:04|[23]6|[48]9|5[07]|[67]3)|3(?:06|43|54|6[578]|82)|4(?:03|1[68]|[26]8|3[178]|50|74)|5(?:' +
       '06|1[49]|48|79|8[147])|6(?:04|[18]3|39|47|72)|7(?:0[59]|42|53|78|8[02])|8(?:[06]7|19|25|7[39])|9' +
       '(?:0[25]|42))[2-9]\d{6}';
     ExampleNumber: '5062345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { CA tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|(?:5(?:2[12' +
       '5-9]|3[23]|44|66|77|88)|6(?:22|33))[2-9]\d{6}';
     ExampleNumber: '5219023456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA voip }
    (HasData: True;
     NationalNumberPattern: '600[2-9]\d{6}';
     ExampleNumber: '6002012345';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA uan }
    (HasData: True;
     NationalNumberPattern: '310\d{4}';
     ExampleNumber: '3101234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC generalDesc }
    (HasData: True;
     NationalNumberPattern: '1(?:[0-79]\d{8}(?:\d{2})?|8[0-24-9]\d{7})|[148]\d{8}|1\d{5,7}';
     ExampleNumber: '';
     LengthOffset: 139; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC fixedLine }
    (HasData: True;
     NationalNumberPattern: '8(?:51(?:0(?:02|31|60|89)|1(?:18|76)|223)|91(?:0(?:1[0-2]|29)|1(?:[28]2|50|79)|2(?:10|64)|3(?:[0' +
       '6]8|22)|4[29]8|62\d|70[23]|959))\d{3}';
     ExampleNumber: '891621234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 10; LocalOnlyCount: 1),
    { CC mobile }
    (HasData: True;
     NationalNumberPattern: '4(?:79[01]|83[0-36-9]|95[0-3])\d{5}|4(?:[0-36]\d|4[047-9]|[58][0-24-9]|7[02-8]|9[0-47-9])\d{6}';
     ExampleNumber: '412345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC tollFree }
    (HasData: True;
     NationalNumberPattern: '180(?:0\d{3}|2)\d{3}';
     ExampleNumber: '1800123456';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC premiumRate }
    (HasData: True;
     NationalNumberPattern: '190[0-26]\d{6}';
     ExampleNumber: '1900123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC sharedCost }
    (HasData: True;
     NationalNumberPattern: '13(?:00\d{6}(?:\d{2})?|45[0-4]\d{3})|13\d{4}';
     ExampleNumber: '1300123456';
     LengthOffset: 81; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC voip }
    (HasData: True;
     NationalNumberPattern: '14(?:5(?:1[0458]|[23][458])|71\d)\d{4}';
     ExampleNumber: '147101234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:(?:[189]|5\d)\d|2)\d{7}|[1-68]\d{6}';
     ExampleNumber: '';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:12|573)\d\d|276)\d{5}|[1-6]\d{6}';
     ExampleNumber: '1234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD mobile }
    (HasData: True;
     NationalNumberPattern: '88\d{5}|(?:8[0-79]|9[016-9])\d{7}';
     ExampleNumber: '991234567';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CD noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF generalDesc }
    (HasData: True;
     NationalNumberPattern: '8776\d{4}|(?:[27]\d|61)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[12]|61)\d{6}';
     ExampleNumber: '21612345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF mobile }
    (HasData: True;
     NationalNumberPattern: '7[02-7]\d{6}';
     ExampleNumber: '70012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF premiumRate }
    (HasData: True;
     NationalNumberPattern: '8776\d{4}';
     ExampleNumber: '87761234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CF noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG generalDesc }
    (HasData: True;
     NationalNumberPattern: '222\d{6}|(?:0\d|80)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG fixedLine }
    (HasData: True;
     NationalNumberPattern: '222[1-589]\d{5}';
     ExampleNumber: '222123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG mobile }
    (HasData: True;
     NationalNumberPattern: '026(?:1[0-5]|6[6-9])\d{4}|0(?:[14-6]\d\d|2(?:40|5[5-8]|6[07-9]))\d{5}';
     ExampleNumber: '061234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG premiumRate }
    (HasData: True;
     NationalNumberPattern: '80[0-2]\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{11}|[2-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 151; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[12467]|3[1-4]|4[134]|5[256]|6[12]|[7-9]1)\d{7}';
     ExampleNumber: '212345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6[89]|7[235-9])\d{7}';
     ExampleNumber: '781234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[016]\d{6}';
     ExampleNumber: '900123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH sharedCost }
    (HasData: True;
     NationalNumberPattern: '84[0248]\d{6}';
     ExampleNumber: '840123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH personalNumber }
    (HasData: True;
     NationalNumberPattern: '878\d{6}';
     ExampleNumber: '878123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH pager }
    (HasData: True;
     NationalNumberPattern: '74[0248]\d{6}';
     ExampleNumber: '740123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH uan }
    (HasData: True;
     NationalNumberPattern: '5[18]\d{7}';
     ExampleNumber: '581234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH voicemail }
    (HasData: True;
     NationalNumberPattern: '860\d{9}';
     ExampleNumber: '860123456789';
     LengthOffset: 153; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[02]\d{9}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:[15]\d{3}|7(?:2(?:0[23]|1[2357]|2[245]|3[45]|4[3-5])|3(?:06|1[69]|[2-6]7)))\d{5}';
     ExampleNumber: '2123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI mobile }
    (HasData: True;
     NationalNumberPattern: '0[157]\d{8}';
     ExampleNumber: '0123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-578]\d{4}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2\d|3[13-7]|4[1-5])\d{3}';
     ExampleNumber: '21234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK mobile }
    (HasData: True;
     NationalNumberPattern: '[578]\d{4}';
     ExampleNumber: '71234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL generalDesc }
    (HasData: True;
     NationalNumberPattern: '12300\d{6}|6\d{9,10}|[2-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 154; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:1982[0-6]|3314[05-9])\d{3}|(?:2(?:1(?:160|962)|3(?:(?:[24]\d|50)\d|3(?:[0346-9]\d|1[0-35-9]|' +
       '2[1-9]|5[0-24-9])|600)|646[59])|(?:600|80[1-9])\d\d|9(?:(?:10[0-2]|7[1-9]\d)\d|3(?:[0-57-9]\d\d|' +
       '6(?:0[02-9]|[1-9]\d))|6(?:[0-8]\d\d|9(?:[02-79]\d|1[05-9]))|9(?:[03-9]\d\d|1(?:[0235-9]\d|4[0-24' +
       '-9])|2(?:[0-79]\d|8[0-46-9]))))\d{4}|(?:22|3[2-5]|[47][1-35]|5[1-3578]|6[13-57]|8[1-9]|9[2458])\' +
       'd{7}';
     ExampleNumber: '600123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL mobile }
    (HasData: True;
     NationalNumberPattern: '2(?:1982[0-6]|3314[05-9])\d{3}|(?:2(?:1(?:160|962)|3(?:(?:[24]\d|50)\d|3(?:[0346-9]\d|1[0-35-9]|' +
       '2[1-9]|5[0-24-9])|600)|646[59])|80[1-8]\d\d|9(?:(?:10[0-2]|7[1-9]\d)\d|3(?:[0-57-9]\d\d|6(?:0[02' +
       '-9]|[1-9]\d))|6(?:[0-8]\d\d|9(?:[02-79]\d|1[05-9]))|9(?:[03-9]\d\d|1(?:[0235-9]\d|4[0-24-9])|2(?' +
       ':[0-79]\d|8[0-46-9]))))\d{4}|(?:22|3[2-5]|[47][1-35]|5[1-3578]|6[13-57]|8[1-9]|9[2458])\d{7}';
     ExampleNumber: '221234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:123|8)00\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 157; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL sharedCost }
    (HasData: True;
     NationalNumberPattern: '600\d{7,8}';
     ExampleNumber: '6001234567';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL voip }
    (HasData: True;
     NationalNumberPattern: '44\d{7}';
     ExampleNumber: '441234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CL noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '600\d{7,8}';
     ExampleNumber: '';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[26]\d{8}|88\d{6,7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:22|33)\d{6}';
     ExampleNumber: '222123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:24[23]|6(?:[25-9]\d|4[0-2]))\d{6}';
     ExampleNumber: '671234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM tollFree }
    (HasData: True;
     NationalNumberPattern: '88\d{6,7}';
     ExampleNumber: '88012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:(?:1[03-689]|2\d)\d\d|6)\d{8}|1\d{10}|[126]\d{6}(?:\d(?:\d{2})?)?|86\d{5,6}|(?:[3-579]\d|8[0-' +
       '57-9])\d{5,9}';
     ExampleNumber: '';
     LengthOffset: 159; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { CN fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:10(?:[02-79]\d\d|[18](?:0[1-9]|[1-9]\d))|2(?:[02-57-9]\d{3}|1(?:[18](?:0[1-9]|[1-9]\d)|[2-79]' +
       '\d\d))|(?:41[03]|8078|9(?:78|94))\d\d)\d{5}|(?:10|2[0-57-9])(?:1(?:00|23)\d\d|95\d{3,4})|(?:41[0' +
       '3]|9(?:78|94))(?:100\d\d|95\d{3,4})|8078123|(?:43[35]|754|851)\d{7,8}|(?:43[35]|754|851)(?:1(?:0' +
       '0\d|23)\d|95\d{3,4})|(?:3(?:11|7[179])|4(?:[15]1|3[12])|5(?:1\d|2[37]|3[12]|51|7[13-79]|9[15])|7' +
       '(?:[39]1|5[57]|6[09])|8(?:71|98))(?:[02-8]\d{7}|1(?:0(?:0\d\d(?:\d{3})?|[1-9]\d{5})|[13-9]\d{6}|' +
       '2(?:[0-24-9]\d{5}|3\d(?:\d{4})?))|9(?:[0-46-9]\d{6}|5\d{3}(?:\d(?:\d{2})?)?))|(?:3(?:1[02-9]|35|' +
       '49|5\d|7[02-68]|9[1-68])|4(?:1[24-9]|2[179]|3[46-9]|5[2-9]|6[47-9]|7\d|8[23])|5(?:3[03-9]|4[36]|' +
       '5[02-9]|6[1-46]|7[028]|80|9[2-46-9])|6(?:3[1-5]|6[0238]|9[12])|7(?:01|[17]\d|2[248]|3[04-9]|4[3-' +
       '6]|5[0-3689]|6[2368]|9[02-9])|8(?:1[236-8]|2[5-7]|3\d|5[2-9]|7[02-9]|8[36-8]|9[1-7])|9(?:0[1-368' +
       '9]|1[1-79]|3\d|4[13]|5[1-5]|7[0-79]|9[0-35-9]))(?:[02-8]\d{6}|1(?:0(?:0\d\d(?:\d{2})?|[1-9]\d{4}' +
       ')|[13-9]\d{5}|2(?:[0-24-9]\d{4}|3\d(?:\d{3})?))|9(?:[0-46-9]\d{5}|5\d{3,5}))';
     ExampleNumber: '1012345678';
     LengthOffset: 165; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { CN mobile }
    (HasData: True;
     NationalNumberPattern: '1(?:610\d|740[0-5])\d{6}|1(?:[38]\d|4[57]|[59][0-35-9]|6[25-7]|7[0-35-8])\d{8}';
     ExampleNumber: '13123456789';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:(?:10|21)8|8)00\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 170; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN premiumRate }
    (HasData: True;
     NationalNumberPattern: '16[08]\d{5}';
     ExampleNumber: '16812345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN sharedCost }
    (HasData: True;
     NationalNumberPattern: '10(?:10\d{4}|96\d{3,4})|400\d{7}|950\d{7,8}|(?:2[0-57-9]|3(?:[157]\d|35|49|9[1-68])|4(?:[17]\d|2' +
       '[179]|[35][1-9]|6[47-9]|8[23])|5(?:[1357]\d|2[37]|4[36]|6[1-46]|80|9[1-9])|6(?:3[1-5]|6[0238]|9[' +
       '12])|7(?:01|[1579]\d|2[248]|3[014-9]|4[3-6]|6[023689])|8(?:1[236-8]|2[5-7]|[37]\d|5[14-9]|8[36-8' +
       ']|9[1-8])|9(?:0[1-3689]|1[1-79]|[379]\d|4[13]|5[1-5]))96\d{3,4}';
     ExampleNumber: '4001234567';
     LengthOffset: 165; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { CN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CN noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '(?:(?:10|21)8|[48])00\d{7}|950\d{7,8}';
     ExampleNumber: '';
     LengthOffset: 172; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:46|60\d\d)\d{6}|(?:1\d|[39])\d{9}';
     ExampleNumber: '';
     LengthOffset: 175; LengthCount: 3;
     LocalOnlyOffset: 178; LocalOnlyCount: 2),
    { CO fixedLine }
    (HasData: True;
     NationalNumberPattern: '601055(?:[0-4]\d|50)\d\d|6010(?:[0-4]\d|5[0-4])\d{4}|(?:46|60(?:[18][1-9]|[24-7][2-9]))\d{6}';
     ExampleNumber: '6012345678';
     LengthOffset: 114; LengthCount: 2;
     LocalOnlyOffset: 178; LocalOnlyCount: 2),
    { CO mobile }
    (HasData: True;
     NationalNumberPattern: '333301[0-5]\d{3}|3333(?:00|2[5-9]|[3-9]\d)\d{4}|(?:3(?:(?:0[0-5]|1\d|5[01]|70)\d|2(?:[0-3]\d|4[1' +
       '-9])|3(?:00|3[0-24-9]))|9(?:101|408))\d{6}';
     ExampleNumber: '3211234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{7}';
     ExampleNumber: '18001234567';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:19(?:0[01]|4[78])|901)\d{7}';
     ExampleNumber: '19001234567';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:8\d|90)\d{8}|(?:[24-8]\d{3}|3005)\d{4}';
     ExampleNumber: '';
     LengthOffset: 114; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR fixedLine }
    (HasData: True;
     NationalNumberPattern: '210[7-9]\d{4}|2(?:[024-7]\d|1[1-9])\d{5}';
     ExampleNumber: '22123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR mobile }
    (HasData: True;
     NationalNumberPattern: '(?:3005\d|6500[01])\d{3}|(?:5[07]|6[0-4]|7[0-3]|8[3-9])\d{6}';
     ExampleNumber: '83123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[059]\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR voip }
    (HasData: True;
     NationalNumberPattern: '(?:210[0-6]|4\d{3}|5100)\d{4}';
     ExampleNumber: '40001234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-7]|8\d\d)\d{7}|[2-47]\d{6}|[34]\d{5}';
     ExampleNumber: '';
     LengthOffset: 180; LengthCount: 4;
     LocalOnlyOffset: 110; LocalOnlyCount: 2),
    { CU fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3[23]|4[89])\d{4,6}|(?:31|4[36]|8(?:0[25]|78)\d)\d{6}|(?:2[1-4]|4[1257]|7\d)\d{5,6}';
     ExampleNumber: '71234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 110; LocalOnlyCount: 2),
    { CU mobile }
    (HasData: True;
     NationalNumberPattern: '(?:5\d|6[2-4])\d{6}';
     ExampleNumber: '51234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU sharedCost }
    (HasData: True;
     NationalNumberPattern: '807\d{7}';
     ExampleNumber: '8071234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-59]\d\d|800)\d{4}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:2[1-7]|3[0-8]|4[12]|5[1256]|6\d|7[1-3]|8[1-5])\d{4}';
     ExampleNumber: '2211234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV mobile }
    (HasData: True;
     NationalNumberPattern: '(?:36|5[1-389]|9\d)\d{5}';
     ExampleNumber: '9911234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4}';
     ExampleNumber: '8001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV voip }
    (HasData: True;
     NationalNumberPattern: '(?:3[3-5]|4[356])\d{5}';
     ExampleNumber: '3401234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CV noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[34]1|60|(?:7|9\d)\d)\d{5}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW fixedLine }
    (HasData: True;
     NationalNumberPattern: '9(?:4(?:3[0-5]|4[14]|6\d)|50\d|7(?:2[014]|3[02-9]|4[4-9]|6[357]|77|8[7-9])|8(?:3[39]|[46]\d|7[01' +
       ']|8[57-9]))\d{4}';
     ExampleNumber: '94351234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW mobile }
    (HasData: True;
     NationalNumberPattern: '953[01]\d{4}|9(?:5[12467]|6[5-9])\d{5}';
     ExampleNumber: '95181234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW sharedCost }
    (HasData: True;
     NationalNumberPattern: '60[0-2]\d{4}';
     ExampleNumber: '6001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW pager }
    (HasData: True;
     NationalNumberPattern: '955\d{5}';
     ExampleNumber: '95581234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX generalDesc }
    (HasData: True;
     NationalNumberPattern: '1(?:[0-79]\d{8}(?:\d{2})?|8[0-24-9]\d{7})|[148]\d{8}|1\d{5,7}';
     ExampleNumber: '';
     LengthOffset: 139; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX fixedLine }
    (HasData: True;
     NationalNumberPattern: '8(?:51(?:0(?:01|30|59|88)|1(?:17|46|75)|2(?:22|35))|91(?:00[6-9]|1(?:[28]1|49|78)|2(?:09|63)|3(?' +
       ':12|26|75)|4(?:56|97)|64\d|7(?:0[01]|1[0-2])|958))\d{3}';
     ExampleNumber: '891641234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 10; LocalOnlyCount: 1),
    { CX mobile }
    (HasData: True;
     NationalNumberPattern: '4(?:79[01]|83[0-36-9]|95[0-3])\d{5}|4(?:[0-36]\d|4[047-9]|[58][0-24-9]|7[02-8]|9[0-47-9])\d{6}';
     ExampleNumber: '412345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX tollFree }
    (HasData: True;
     NationalNumberPattern: '180(?:0\d{3}|2)\d{3}';
     ExampleNumber: '1800123456';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX premiumRate }
    (HasData: True;
     NationalNumberPattern: '190[0-26]\d{6}';
     ExampleNumber: '1900123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX sharedCost }
    (HasData: True;
     NationalNumberPattern: '13(?:00\d{6}(?:\d{2})?|45[0-4]\d{3})|13\d{4}';
     ExampleNumber: '1300123456';
     LengthOffset: 81; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX voip }
    (HasData: True;
     NationalNumberPattern: '14(?:5(?:1[0458]|[23][458])|71\d)\d{4}';
     ExampleNumber: '147101234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CX noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[279]\d|[58]0)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY fixedLine }
    (HasData: True;
     NationalNumberPattern: '2[2-6]\d{6}';
     ExampleNumber: '22345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY mobile }
    (HasData: True;
     NationalNumberPattern: '9(?:10|[4-79]\d)\d{5}';
     ExampleNumber: '96123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[09]\d{5}';
     ExampleNumber: '90012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY sharedCost }
    (HasData: True;
     NationalNumberPattern: '80[1-9]\d{5}';
     ExampleNumber: '80112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY personalNumber }
    (HasData: True;
     NationalNumberPattern: '700\d{5}';
     ExampleNumber: '70012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY uan }
    (HasData: True;
     NationalNumberPattern: '(?:50|77)\d{6}';
     ExampleNumber: '77123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-578]\d|60)\d{7}|9\d{8,11}';
     ExampleNumber: '';
     LengthOffset: 184; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2\d|3[1257-9]|4[16-9]|5[13-9])\d{7}';
     ExampleNumber: '212345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ mobile }
    (HasData: True;
     NationalNumberPattern: '7060\d{5}|(?:60[1-8]|7(?:0[2-5]|19|[2379]\d))\d{6}';
     ExampleNumber: '601123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '9(?:0[05689]|76)\d{6}';
     ExampleNumber: '900123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ sharedCost }
    (HasData: True;
     NationalNumberPattern: '8[134]\d{7}';
     ExampleNumber: '811234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ personalNumber }
    (HasData: True;
     NationalNumberPattern: '70[01]\d{6}';
     ExampleNumber: '700123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ voip }
    (HasData: True;
     NationalNumberPattern: '9[17]0\d{6}';
     ExampleNumber: '910123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ uan }
    (HasData: True;
     NationalNumberPattern: '9(?:5\d|7[2-4])\d{6}';
     ExampleNumber: '972123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ voicemail }
    (HasData: True;
     NationalNumberPattern: '9(?:3\d{9}|6\d{7,10})';
     ExampleNumber: '93123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { CZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2579]\d{5,14}|49(?:[34]0|69|8\d)\d\d?|49(?:37|49|60|7[089]|9\d)\d{1,3}|49(?:2[024-9]|3[2-689]|7' +
       '[1-7])\d{1,8}|(?:1|[368]\d|4[0-8])\d{3,13}|49(?:[015]\d|2[13]|31|[46][1-8])\d{1,9}';
     ExampleNumber: '';
     LengthOffset: 188; LengthCount: 12;
     LocalOnlyOffset: 200; LocalOnlyCount: 2),
    { DE fixedLine }
    (HasData: True;
     NationalNumberPattern: '32\d{9,11}|49[1-6]\d{10}|322\d{6}|49[0-7]\d{3,9}|(?:[34]0|[68]9)\d{3,13}|(?:2(?:0[1-689]|[1-3569' +
       ']\d|4[0-8]|7[1-7]|8[0-7])|3(?:[3569]\d|4[0-79]|7[1-7]|8[1-8])|4(?:1[02-9]|[2-48]\d|5[0-6]|6[0-8]' +
       '|7[0-79])|5(?:0[2-8]|[124-6]\d|[38][0-8]|[79][0-7])|6(?:0[02-9]|[1-358]\d|[47][0-8]|6[1-9])|7(?:' +
       '0[2-8]|1[1-9]|[27][0-7]|3\d|[4-6][0-8]|8[0-5]|9[013-7])|8(?:0[2-9]|1[0-79]|2\d|3[0-46-9]|4[0-6]|' +
       '5[013-9]|6[1-8]|7[0-8]|8[0-24-6])|9(?:0[6-9]|[1-4]\d|[589][0-7]|6[0-8]|7[0-467]))\d{3,12}';
     ExampleNumber: '30123456';
     LengthOffset: 202; LengthCount: 11;
     LocalOnlyOffset: 213; LocalOnlyCount: 3),
    { DE mobile }
    (HasData: True;
     NationalNumberPattern: '1(?:6[023]|7\d)\d{7,8}|15(?:[0-25-9]\d\d|3(?:10|33))\d{6}';
     ExampleNumber: '15123456789';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7,12}';
     ExampleNumber: '8001234567890';
     LengthOffset: 216; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:137[7-9]|900(?:[135]|9\d))\d{6}';
     ExampleNumber: '9001234567';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE sharedCost }
    (HasData: True;
     NationalNumberPattern: '180\d{5,11}|13(?:7[1-6]\d\d|8)\d{4}';
     ExampleNumber: '18012345';
     LengthOffset: 222; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE personalNumber }
    (HasData: True;
     NationalNumberPattern: '700\d{8}';
     ExampleNumber: '70012345678';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE pager }
    (HasData: True;
     NationalNumberPattern: '16(?:4\d{1,10}|[89]\d{1,11})';
     ExampleNumber: '16412345';
     LengthOffset: 230; LengthCount: 11;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE uan }
    (HasData: True;
     NationalNumberPattern: '18(?:1\d{5,11}|[2-9]\d{8})';
     ExampleNumber: '18500123456';
     LengthOffset: 241; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE voicemail }
    (HasData: True;
     NationalNumberPattern: '1(?:6(?:013|255|399)|7(?:(?:[015]1|[69]3)3|[2-4]55|[78]99))\d{7,8}|15(?:(?:[03-68]00|113)\d|2\d5' +
       '5|7\d99|9\d33)\d{7}';
     ExampleNumber: '177991234567';
     LengthOffset: 248; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:2\d|77)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:1[2-5]|7[45])\d{5}';
     ExampleNumber: '21360003';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ mobile }
    (HasData: True;
     NationalNumberPattern: '77\d{6}';
     ExampleNumber: '77831001';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DJ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:[0-59][1-9]|[6-8]\d)|3(?:[0-3][1-9]|4[13]|5[1-58]|6[1347-9]|7\d|8[1-8]|9[1-79])|4(?:[0-25' +
       '][1-9]|[34][2-9]|6[13-579]|7[13579]|8[1-47]|9[127])|5(?:[0-36][1-9]|4[146-9]|5[3-57-9]|7[568]|8[' +
       '1-358]|9[1-69])|6(?:[0135][1-9]|2[1-68]|4[2-8]|6[1689]|[78]\d|9[15689])|7(?:[0-69][1-9]|7[3-9]|8' +
       '[147])|8(?:[16-9][1-9]|2[1-58])|9(?:[1-47-9][1-9]|6\d))\d{5}';
     ExampleNumber: '32123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK mobile }
    (HasData: True;
     NationalNumberPattern: '(?:2[6-8]|37|6[78]|96)\d{6}|(?:2[0-59]|3[0-689]|[457]\d|6[0-69]|8[126-9]|9[1-47-9])[1-9]\d{5}';
     ExampleNumber: '34412345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{6}';
     ExampleNumber: '80123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d{6}';
     ExampleNumber: '90123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|767|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { DM fixedLine }
    (HasData: True;
     NationalNumberPattern: '767(?:2(?:55|66)|4(?:2[01]|4[0-25-9])|50[0-4])\d{4}';
     ExampleNumber: '7674201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { DM mobile }
    (HasData: True;
     NationalNumberPattern: '767(?:2(?:[2-4689]5|7[5-7])|31[5-7]|61[1-8]|70[1-6])\d{4}';
     ExampleNumber: '7672251234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { DM tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { DO fixedLine }
    (HasData: True;
     NationalNumberPattern: '8(?:[04]9[2-9]\d\d|29(?:2(?:[0-59]\d|6[04-9]|7[0-27]|8[0237-9])|3(?:[0-35-9]\d|4[7-9])|[45]\d\d|' +
       '6(?:[0-27-9]\d|[3-5][1-9]|6[0135-8])|7(?:0[013-9]|[1-37]\d|4[1-35689]|5[1-4689]|6[1-57-9]|8[1-79' +
       ']|9[1-8])|8(?:0[146-9]|1[0-48]|[248]\d|3[1-79]|5[01589]|6[013-68]|7[124-8]|9[0-8])|9(?:[0-24]\d|' +
       '3[02-46-9]|5[0-79]|60|7[0169]|8[57-9]|9[02-9])))\d{4}';
     ExampleNumber: '8092345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { DO mobile }
    (HasData: True;
     NationalNumberPattern: '8[024]9[2-9]\d{6}';
     ExampleNumber: '8092345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { DO tollFree }
    (HasData: True;
     NationalNumberPattern: '800(?:14|[2-9]\d)\d{5}|8[024]9[01]\d{6}|8(?:33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[1-4]|[5-79]\d|80)\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '9619\d{5}|(?:[1-3]\d|4[013-689])\d{6}';
     ExampleNumber: '12345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ mobile }
    (HasData: True;
     NationalNumberPattern: '5(?:4[0-29]|6[0-4])\d{6}|(?:55|6\d|7[7-9])\d{7}';
     ExampleNumber: '551234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '80[3-689]1\d{5}';
     ExampleNumber: '808123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ sharedCost }
    (HasData: True;
     NationalNumberPattern: '80[12]1\d{5}';
     ExampleNumber: '801123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ voip }
    (HasData: True;
     NationalNumberPattern: '98[23]\d{6}';
     ExampleNumber: '983123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { DZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{9,10}|(?:[2-7]|9\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 116; LengthCount: 4;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { EC fixedLine }
    (HasData: True;
     NationalNumberPattern: '[2-7][2-7]\d{6}';
     ExampleNumber: '22123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { EC mobile }
    (HasData: True;
     NationalNumberPattern: '964[0-2]\d{5}|9(?:39|[57][89]|6[0-36-9]|[89]\d)\d{6}';
     ExampleNumber: '991234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{7}|1[78]00\d{6}';
     ExampleNumber: '18001234567';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC voip }
    (HasData: True;
     NationalNumberPattern: '[2-7]890\d{4}';
     ExampleNumber: '28901234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{9}|[4578]\d{7}|(?:[3-8]\d|90)\d{5}';
     ExampleNumber: '';
     LengthOffset: 127; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3[23589]|4[3-8]|6\d|7[1-9]|88)\d{5}';
     ExampleNumber: '3212345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE mobile }
    (HasData: True;
     NationalNumberPattern: '(?:5\d{5}|8(?:1(?:0(?:0(?:00|[178]\d)|[3-9]\d\d)|(?:1(?:0[2-6]|1\d)|[2-79]\d\d)\d)|2(?:0(?:0(?:0' +
       '0|4\d)|[1-7]\d\d)|(?:(?:[124-69]\d|3[5-9])\d|7(?:[0-79]\d|8[013-9])|8(?:[2-6]\d|7[01]))\d)|[349]' +
       '\d{4}))\d\d|5(?:(?:[02]\d|5[0-478])\d|1(?:[0-8]\d|95)|6(?:4[0-4]|5[1-589]))\d{3}';
     ExampleNumber: '51234567';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE tollFree }
    (HasData: True;
     NationalNumberPattern: '800(?:(?:0\d\d|1)\d|[2-9])\d{3}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:40\d\d|900)\d{4}';
     ExampleNumber: '9001234';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE personalNumber }
    (HasData: True;
     NationalNumberPattern: '70[0-2]\d{5}';
     ExampleNumber: '70012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EE noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '800[2-9]\d{3}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[189]\d{8,9}|[24-6]\d{8}|[135]\d{7}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { EG fixedLine }
    (HasData: True;
     NationalNumberPattern: '13[23]\d{6}|(?:15|57)\d{6,7}|(?:2\d|3|4[05-8]|5[05]|6[24-689]|8[2468]|9[235-7])\d{7}';
     ExampleNumber: '234567890';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { EG mobile }
    (HasData: True;
     NationalNumberPattern: '1[0-25]\d{8}';
     ExampleNumber: '1001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[5-8]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH fixedLine }
    (HasData: True;
     NationalNumberPattern: '528[89]\d{5}';
     ExampleNumber: '528812345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6(?:[0-79]\d|8[0-247-9])|7(?:[016-8]\d|2[0-8]|3[01]|5[0-5]))\d{6}';
     ExampleNumber: '650123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-7]\d{6}';
     ExampleNumber: '801234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH premiumRate }
    (HasData: True;
     NationalNumberPattern: '89\d{7}';
     ExampleNumber: '891234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH voip }
    (HasData: True;
     NationalNumberPattern: '(?:592(?:4[0-2]|93)|80[89]\d\d)\d{4}';
     ExampleNumber: '592401234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { EH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER generalDesc }
    (HasData: True;
     NationalNumberPattern: '[178]\d{6}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { ER fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:1[12568]|[24]0|55|6[146])|8\d\d)\d{4}';
     ExampleNumber: '8370362';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { ER mobile }
    (HasData: True;
     NationalNumberPattern: '(?:17[1-3]|7\d\d)\d{4}';
     ExampleNumber: '7123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ER noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:400|[5-9]\d\d)\d{6}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES fixedLine }
    (HasData: True;
     NationalNumberPattern: '96906(?:0[0-8]|1[1-9]|[2-9]\d)\d\d|9(?:69(?:0[0-57-9]|[1-9]\d)|73(?:[0-8]\d|9[1-9]))\d{4}|(?:400' +
       '|8(?:[1356]\d|[28][0-8]|[47][1-9])|9(?:[135]\d|[268][0-8]|4[1-9]|7[124-9]))\d{6}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES mobile }
    (HasData: True;
     NationalNumberPattern: '96906(?:09|10)\d\d|(?:590(?:10[0-2]|600)|97390\d)\d{3}|(?:6\d|7[1-48])\d{7}';
     ExampleNumber: '612345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES tollFree }
    (HasData: True;
     NationalNumberPattern: '[89]00\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES premiumRate }
    (HasData: True;
     NationalNumberPattern: '80[367]\d{6}';
     ExampleNumber: '803123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES sharedCost }
    (HasData: True;
     NationalNumberPattern: '90[12]\d{6}';
     ExampleNumber: '901123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{7}';
     ExampleNumber: '701234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES uan }
    (HasData: True;
     NationalNumberPattern: '51\d{7}';
     ExampleNumber: '511234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ES noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:11|[2-57-9]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { ET fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:11(?:[124]\d\d|3(?:[0-79]\d|8[0-7])|5(?:[02-9]\d|1[0-57-9])|6(?:[02-79]\d|1[0-57-9]|8[0-8]))|' +
       '2(?:2(?:11[1-9]|22[0-7]|33\d|44[1467]|66[1-68])|5(?:11[124-6]|33[2-8]|44[1467]|55[14]|66[1-3679]' +
       '|77[124-79]|880))|3(?:3(?:11[0-46-8]|(?:22|55)[0-6]|33[0134689]|44[04]|66[01467])|4(?:44[0-8]|55' +
       '[0-69]|66[0-3]|77[1-5]))|4(?:6(?:119|22[0-24-7]|33[1-5]|44[13-69]|55[14-689]|660|88[1-4])|7(?:(?' +
       ':11|22)[1-9]|33[13-7]|44[13-6]|55[1-689]))|5(?:7(?:227|55[05]|(?:66|77)[14-8])|8(?:11[149]|22[01' +
       '3-79]|33[0-68]|44[013-8]|550|66[1-5]|77\d)))\d{4}';
     ExampleNumber: '111112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { ET mobile }
    (HasData: True;
     NationalNumberPattern: '700[1-9]\d{5}|(?:7(?:0[1-9]|1[0-8]|2[1-35-79]|3\d|77|86|99)|(?:8[01]|9\d)\d)\d{6}';
     ExampleNumber: '911234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ET noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-35689]\d{4}|7\d{10,11}|(?:[124-7]\d|3[0-46-9])\d{8}|[1-9]\d{5,8}';
     ExampleNumber: '';
     LengthOffset: 11; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI fixedLine }
    (HasData: True;
     NationalNumberPattern: '1[3-7][1-8]\d{3,6}|(?:19[1-8]|[23568][1-8]\d|9(?:00|[1-8]\d))\d{2,6}';
     ExampleNumber: '131234567';
     LengthOffset: 85; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI mobile }
    (HasData: True;
     NationalNumberPattern: '4946\d{2,6}|(?:4[0-8]|50)\d{4,8}';
     ExampleNumber: '412345678';
     LengthOffset: 95; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4,6}';
     ExampleNumber: '800123456';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI premiumRate }
    (HasData: True;
     NationalNumberPattern: '[67]00\d{5,6}';
     ExampleNumber: '600123456';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI uan }
    (HasData: True;
     NationalNumberPattern: '20\d{4,8}|60[12]\d{5,6}|7(?:099\d{4,5}|5[03-9]\d{3,7})|20[2-59]\d\d|(?:606|7(?:0[78]|1|3\d))\d{7' +
       '}|(?:10|29|3[09]|70[1-5]\d)\d{4,8}';
     ExampleNumber: '10112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FI noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '20(?:2[023]|9[89])\d{1,6}|(?:60[12]\d|7099)\d{4,5}|(?:606|7(?:0[78]|1|3\d))\d{7}|(?:[1-3]00|7(?:' +
       '0[1-5]\d\d|5[03-9]))\d{3,7}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '45\d{5}|(?:0800\d|[235-9])\d{6}';
     ExampleNumber: '';
     LengthOffset: 136; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ fixedLine }
    (HasData: True;
     NationalNumberPattern: '603\d{4}|(?:3[0-6]|6[25-7]|8[58])\d{5}';
     ExampleNumber: '3212345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[279]\d|45|5[01568]|8[034679])\d{5}';
     ExampleNumber: '7012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ tollFree }
    (HasData: True;
     NationalNumberPattern: '0800\d{7}';
     ExampleNumber: '08001234567';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FJ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-7]\d{4}';
     ExampleNumber: '';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK fixedLine }
    (HasData: True;
     NationalNumberPattern: '[2-47]\d{4}';
     ExampleNumber: '31234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK mobile }
    (HasData: True;
     NationalNumberPattern: '[56]\d{4}';
     ExampleNumber: '51234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[39]\d\d|820)\d{4}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM fixedLine }
    (HasData: True;
     NationalNumberPattern: '31(?:00[67]|208|309)\d\d|(?:3(?:[2357]0[1-9]|602|804|905)|(?:820|9[2-6]\d)\d)\d{3}';
     ExampleNumber: '3201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM mobile }
    (HasData: True;
     NationalNumberPattern: '31(?:00[67]|208|309)\d\d|(?:3(?:[2357]0[1-9]|602|804|905)|(?:820|9[2-7]\d)\d)\d{3}';
     ExampleNumber: '3501234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{5}';
     ExampleNumber: '';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:20|[34]\d|8[19])\d{4}';
     ExampleNumber: '201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[27][1-9]|5\d|9[16])\d{4}';
     ExampleNumber: '211234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO tollFree }
    (HasData: True;
     NationalNumberPattern: '80[257-9]\d{3}';
     ExampleNumber: '802123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO premiumRate }
    (HasData: True;
     NationalNumberPattern: '90(?:[13-5][15-7]|2[125-7]|9\d)\d\d';
     ExampleNumber: '901123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO voip }
    (HasData: True;
     NationalNumberPattern: '6[0-36]\d{4}';
     ExampleNumber: '601234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:26[013-9]|59[1-35-9])\d{6}|(?:[13]\d|2[0-57-9]|4[1-9]|5[0-8])\d{7}';
     ExampleNumber: '123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6(?:[0-24-8]\d|3[0-8]|9[589])|7[3-9]\d)\d{6}';
     ExampleNumber: '612345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '801234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR premiumRate }
    (HasData: True;
     NationalNumberPattern: '836(?:0[0-36-9]|[1-9]\d)\d{4}|8(?:1[2-9]|2[2-47-9]|3[0-57-9]|[569]\d|8[0-35-9])\d{6}';
     ExampleNumber: '891123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR sharedCost }
    (HasData: True;
     NationalNumberPattern: '8(?:1[01]|2[0156]|4[024]|84)\d{6}';
     ExampleNumber: '884012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR voip }
    (HasData: True;
     NationalNumberPattern: '9\d{8}';
     ExampleNumber: '912345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR uan }
    (HasData: True;
     NationalNumberPattern: '80[6-9]\d{6}';
     ExampleNumber: '806123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { FR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[067]\d|11)\d{6}|[2-7]\d{6}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA fixedLine }
    (HasData: True;
     NationalNumberPattern: '[01]1\d{6}';
     ExampleNumber: '01441234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:0[2-7]|7[467])\d|6(?:0[0-4]|10|[256]\d))\d{5}|[2-7]\d{6}';
     ExampleNumber: '06031234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-357-9]\d{9}|[18]\d{8}|8\d{6}';
     ExampleNumber: '';
     LengthOffset: 252; LengthCount: 3;
     LocalOnlyOffset: 255; LocalOnlyCount: 4),
    { GB fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:1(?:3(?:[0-58]\d\d|73[0-5])|4(?:(?:[0-5]\d|70)\d|69[7-9])|(?:(?:5[0-26-9]|[78][0-49])\d|6' +
       '(?:[0-4]\d|5[01]))\d)|(?:2(?:(?:0[024-9]|2[3-9]|3[3-79]|4[1-689]|[58][02-9]|6[0-47-9]|7[013-9]|9' +
       '\d)\d|1(?:[0-7]\d|8[0-3]))|(?:3(?:0\d|1[0-8]|[25][02-9]|3[02-579]|[468][0-46-9]|7[1-35-79]|9[2-5' +
       '78])|4(?:0[03-9]|[137]\d|[28][02-57-9]|4[02-69]|5[0-8]|[69][0-79])|5(?:0[1-35-9]|[16]\d|2[024-9]' +
       '|3[015689]|4[02-9]|5[03-9]|7[0-35-9]|8[0-468]|9[0-57-9])|6(?:0[034689]|1\d|2[0-35689]|[38][013-9' +
       ']|4[1-467]|5[0-69]|6[13-9]|7[0-8]|9[0-24578])|7(?:0[0246-9]|2\d|3[0236-8]|4[03-9]|5[0-46-9]|6[01' +
       '3-9]|7[0-35-9]|8[024-9]|9[02-9])|8(?:0[35-9]|2[1-57-9]|3[02-578]|4[0-578]|5[124-9]|6[2-69]|7\d|8' +
       '[02-9]|9[02569])|9(?:0[02-589]|[18]\d|2[02-689]|3[1-57-9]|4[2-9]|5[0-579]|6[2-47-9]|7[0-24578]|9' +
       '[2-57]))\d)\d)|2(?:0[013478]|3[0189]|4[017]|8[0-46-9]|9[0-2])\d{3})\d{4}|1(?:2(?:0(?:46[1-4]|87[' +
       '2-9])|545[1-79]|76(?:2\d|3[1-8]|6[1-6])|9(?:7(?:2[0-4]|3[2-5])|8(?:2[2-8]|7[0-47-9]|8[3-5])))|3(' +
       '?:6(?:38[2-5]|47[23])|8(?:47[04-9]|64[0157-9]))|4(?:044[1-7]|20(?:2[23]|8\d)|6(?:0(?:30|5[2-57]|' +
       '6[1-8]|7[2-8])|140)|8(?:052|87[1-3]))|5(?:2(?:4(?:3[2-79]|6\d)|76\d)|6(?:26[06-9]|686))|6(?:06(?' +
       ':4\d|7[4-79])|295[5-7]|35[34]\d|47(?:24|61)|59(?:5[08]|6[67]|74)|9(?:55[0-4]|77[23]))|7(?:26(?:6' +
       '[13-9]|7[0-7])|(?:442|688)\d|50(?:2[0-3]|[3-68]2|76))|8(?:27[56]\d|37(?:5[2-5]|8[239])|843[2-58]' +
       ')|9(?:0(?:0(?:6[1-8]|85)|52\d)|3583|4(?:66[1-8]|9(?:2[01]|81))|63(?:23|3[1-4])|9561))\d{3}';
     ExampleNumber: '1212345678';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 259; LocalOnlyCount: 5),
    { GB mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:457[0-57-9]|700[01]|911[028])\d{5}|7(?:[1-3]\d\d|4(?:[0-46-9]\d|5[0-689])|5(?:0[0-8]|[13-9]\' +
       'd|2[0-35-9])|7(?:0[1-9]|[1-7]\d|8[02-9]|9[0-689])|8(?:[014-9]\d|[23][0-8])|9(?:[024-9]\d|1[02-9]' +
       '|3[0-689]))\d{6}';
     ExampleNumber: '7400123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB tollFree }
    (HasData: True;
     NationalNumberPattern: '80[08]\d{7}|800\d{6}|8001111';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:8(?:4[2-5]|7[0-3])|9(?:[01]\d|8[2-49]))\d{7}|845464\d';
     ExampleNumber: '9012345678';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{8}';
     ExampleNumber: '7012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB voip }
    (HasData: True;
     NationalNumberPattern: '56\d{8}';
     ExampleNumber: '5612345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB pager }
    (HasData: True;
     NationalNumberPattern: '76(?:464|652)\d{5}|76(?:0[0-28]|2[356]|34|4[01347]|5[49]|6[0-369]|77|8[14]|9[139])\d{6}';
     ExampleNumber: '7640123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB uan }
    (HasData: True;
     NationalNumberPattern: '(?:3[0347]|55)\d{8}';
     ExampleNumber: '5512345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GB noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:473|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GD fixedLine }
    (HasData: True;
     NationalNumberPattern: '473(?:2(?:3[0-2]|69)|3(?:2[89]|86)|4(?:[06]8|3[5-9]|4[0-4]|5[59]|73|90)|63[68]|7(?:58|84)|800|93' +
       '8)\d{4}';
     ExampleNumber: '4732691234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GD mobile }
    (HasData: True;
     NationalNumberPattern: '473(?:4(?:0[2-79]|1[04-9]|2[0-5]|49|5[6-8])|5(?:2[01]|3[3-8])|901)\d{4}';
     ExampleNumber: '4734031234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GD tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GD noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[3-57]\d\d|800)\d{6}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { GE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3(?:[256]\d|4[124-9]|7[0-4])|4(?:1\d|2[2-7]|3[1-79]|4[2-8]|7[239]|9[1-7]))\d{6}';
     ExampleNumber: '322123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { GE mobile }
    (HasData: True;
     NationalNumberPattern: '5(?:(?:(?:0555|1(?:[17]77|555))[5-9]|757(?:7[7-9]|8[01]))\d|22252[0-4])\d\d|5(?:0(?:0(?:1[09]|70' +
       ')|505)|1(?:0[01]0|1(?:07|33|51))|2(?:0[02]0|2[25]2)|3(?:0[03]0|3[35]3)|4(?:0[04]0|411)|5222|9000' +
       ')[0-4]\d{3}|(?:5(?:0(?:0(?:0\d|1[12]|2[02]|3[0-6]|4[04]|5[05]|77|88|9[09])|(?:[14]\d|77)\d|22[02' +
       '])|1(?:1(?:[03][01]|[124]\d|5[02-6]|7[0-6])|4\d\d)|2(?:228|555)|3555|4(?:4(?:[02-9]\d|14)|555)|5' +
       '(?:[0157-9]\d\d|200|333|4(?:44|55))|6[89]\d\d|7(?:(?:[0147-9]\d|22)\d|5(?:00|[57]5))|8(?:0(?:[01' +
       '8]\d|2[0-4])|5(?:55|8[89])|8(?:55|88))|9(?:090|[1-35-9]\d\d))|790\d\d)\d{4}';
     ExampleNumber: '555123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE voip }
    (HasData: True;
     NationalNumberPattern: '70[67]\d{6}';
     ExampleNumber: '706123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GE noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '70[67]\d{6}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:694\d|7093)\d{5}|(?:59|[89]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:59(?:4(?:[02-49]\d|1[0-5]|5[6-9]|6[0-3]|80)|88\d)|80[6-9]\d\d)\d{4}';
     ExampleNumber: '594101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF mobile }
    (HasData: True;
     NationalNumberPattern: '(?:694(?:[0-249]\d|3[0-8])|7093[0-3])\d{4}';
     ExampleNumber: '694201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF premiumRate }
    (HasData: True;
     NationalNumberPattern: '8[129]\d{7}';
     ExampleNumber: '890123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF voip }
    (HasData: True;
     NationalNumberPattern: '9(?:(?:396|76\d)\d|476[0-6])\d{4}';
     ExampleNumber: '976012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GF noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1481|[357-9]\d{3})\d{6}|8\d{6}(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 252; LengthCount: 3;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { GG fixedLine }
    (HasData: True;
     NationalNumberPattern: '1481[25-9]\d{5}';
     ExampleNumber: '1481256789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { GG mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:(?:781|839)\d|911[17])\d{5}';
     ExampleNumber: '7781123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG tollFree }
    (HasData: True;
     NationalNumberPattern: '80[08]\d{7}|800\d{6}|8001111';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:8(?:4[2-5]|7[0-3])|9(?:[01]\d|8[0-3]))\d{7}|845464\d';
     ExampleNumber: '9012345678';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{8}';
     ExampleNumber: '7012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG voip }
    (HasData: True;
     NationalNumberPattern: '56\d{8}';
     ExampleNumber: '5612345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG pager }
    (HasData: True;
     NationalNumberPattern: '76(?:464|652)\d{5}|76(?:0[0-28]|2[356]|34|4[01347]|5[49]|6[0-369]|77|8[14]|9[139])\d{6}';
     ExampleNumber: '7640123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG uan }
    (HasData: True;
     NationalNumberPattern: '(?:3[0347]|55)\d{8}';
     ExampleNumber: '5512345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH generalDesc }
    (HasData: True;
     NationalNumberPattern: '[235]\d{8}|800\d{5,6}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GH fixedLine }
    (HasData: True;
     NationalNumberPattern: '3082[0-5]\d{4}|3(?:0(?:[237]\d|8[01])|[167](?:2[0-6]|7\d|80)|2(?:2[0-5]|7\d|80)|3(?:2[0-3]|7\d|8' +
       '0)|4(?:2[013-9]|3[01]|7\d|80)|5(?:2[0-7]|7\d|80)|8(?:2[0-2]|7\d|80)|9(?:[28]0|7\d))\d{5}';
     ExampleNumber: '302345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:[0346-9]\d|5[67])|5(?:[03-7]\d|9[1-9]))\d{6}';
     ExampleNumber: '231234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5,6}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GH noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '800\d{5,6}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[25]\d|60)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI fixedLine }
    (HasData: True;
     NationalNumberPattern: '2190[0-2]\d{3}|2(?:0(?:[02]\d|3[01])|16[24-9]|2[2-5]\d)\d{4}';
     ExampleNumber: '20012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI mobile }
    (HasData: True;
     NationalNumberPattern: '5251[0-4]\d{3}|(?:5(?:[146-8]\d\d|250)|60(?:1[01]|6\d))\d{4}';
     ExampleNumber: '57123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:19|[2-689]\d|70)\d{4}';
     ExampleNumber: '';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:19|3[1-7]|[68][1-9]|70|9\d)\d{4}';
     ExampleNumber: '321000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL mobile }
    (HasData: True;
     NationalNumberPattern: '[245]\d{5}';
     ExampleNumber: '221234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{4}';
     ExampleNumber: '801234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL voip }
    (HasData: True;
     NationalNumberPattern: '3[89]\d{4}';
     ExampleNumber: '381234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GL noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[48]\d{8}|[2-9]\d{6}';
     ExampleNumber: '';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:4(?:[23]\d\d|4(?:1[024679]|(?:4(?:[237-9]\d|4[14-9])|8[0-389]\d)\d|5(?:5(?:3\d|4[0-7])|[67]\d' +
       '\d)))|5(?:5(?:3\d|4[0-7])|6[67]\d|7(?:1[04]|2[035]|3[58]|48))|8[0-389]\d\d)\d{3}|44[6-9]\d{4}';
     ExampleNumber: '5661234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:[23679]\d|4[015]|8(?:(?:3[35]|6[68]|99)\d|7(?:[27]\d|4[015])))\d|5(?:[0-489]\d|56))\d{4}|8' +
       '[4-7]\d{5}';
     ExampleNumber: '3012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN generalDesc }
    (HasData: True;
     NationalNumberPattern: '722\d{6}|(?:3|6\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN fixedLine }
    (HasData: True;
     NationalNumberPattern: '3(?:0(?:24|3[12]|4[1-35-7]|5[13]|6[189]|[78]1|9[1478])|1\d\d)\d{4}';
     ExampleNumber: '30241234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN mobile }
    (HasData: True;
     NationalNumberPattern: '6[0-356]\d{7}';
     ExampleNumber: '601123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN voip }
    (HasData: True;
     NationalNumberPattern: '722\d{6}';
     ExampleNumber: '722123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GN noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP generalDesc }
    (HasData: True;
     NationalNumberPattern: '7090\d{5}|(?:[56]9|[89]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:59(?:0(?:0[1-68]|[14][0-24-9]|2[0-68]|3[1-9]|5[3-579]|[68][0-689]|7[08]|9\d)|87\d)|80[6-9]\d\' +
       'd)\d{4}';
     ExampleNumber: '590201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP mobile }
    (HasData: True;
     NationalNumberPattern: '(?:69(?:0\d\d|1(?:2[2-9]|3[0-5]))|7090[0-4])\d{4}';
     ExampleNumber: '690001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP premiumRate }
    (HasData: True;
     NationalNumberPattern: '8[129]\d{7}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP voip }
    (HasData: True;
     NationalNumberPattern: '9(?:(?:39[5-7]|76[018])\d|475[0-6])\d{4}';
     ExampleNumber: '976012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GP noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ generalDesc }
    (HasData: True;
     NationalNumberPattern: '222\d{6}|(?:3\d|55|[89]0)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ fixedLine }
    (HasData: True;
     NationalNumberPattern: '33[0-24-9]\d[46]\d{4}|3(?:33|5\d)\d[7-9]\d{4}';
     ExampleNumber: '333091234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ mobile }
    (HasData: True;
     NationalNumberPattern: '(?:222|55\d)\d{6}';
     ExampleNumber: '222123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d[1-9]\d{5}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d[1-9]\d{5}';
     ExampleNumber: '900123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GQ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR generalDesc }
    (HasData: True;
     NationalNumberPattern: '5005000\d{3}|8\d{9,11}|(?:[269]\d|70)\d{8}';
     ExampleNumber: '';
     LengthOffset: 172; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:1\d\d|2(?:2[1-46-9]|[36][1-8]|4[1-7]|5[1-4]|7[1-5]|[89][1-9])|3(?:1\d|2[1-57]|[35][1-3]|4[13' +
       ']|7[1-7]|8[124-6]|9[1-79])|4(?:1\d|2[1-8]|3[1-4]|4[13-5]|6[1-578]|9[1-5])|5(?:1\d|[29][1-4]|3[1-' +
       '5]|4[124]|5[1-6])|6(?:1\d|[269][1-6]|3[1245]|4[1-7]|5[13-9]|7[14]|8[1-5])|7(?:1\d|2[1-5]|3[1-6]|' +
       '4[1-7]|5[1-57]|6[135]|9[125-7])|8(?:1\d|2[1-5]|[34][1-4]|9[1-57]))\d{6}';
     ExampleNumber: '2123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR mobile }
    (HasData: True;
     NationalNumberPattern: '68[57-9]\d{7}|(?:69|94)\d{8}';
     ExampleNumber: '6912345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7,9}';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[19]\d{7}';
     ExampleNumber: '9091234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR sharedCost }
    (HasData: True;
     NationalNumberPattern: '8(?:0[16]|12|[27]5|50)\d{7}';
     ExampleNumber: '8011234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{8}';
     ExampleNumber: '7012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR uan }
    (HasData: True;
     NationalNumberPattern: '5005000\d{3}';
     ExampleNumber: '5005000123';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT generalDesc }
    (HasData: True;
     NationalNumberPattern: '80\d{6}|(?:1\d{3}|[2-7])\d{7}';
     ExampleNumber: '';
     LengthOffset: 264; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT fixedLine }
    (HasData: True;
     NationalNumberPattern: '[267][2-9]\d{6}';
     ExampleNumber: '22456789';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[3-5]\d\d|80[0-4])\d{5}';
     ExampleNumber: '51234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT tollFree }
    (HasData: True;
     NationalNumberPattern: '18[01]\d{8}';
     ExampleNumber: '18001112222';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT premiumRate }
    (HasData: True;
     NationalNumberPattern: '19\d{9}';
     ExampleNumber: '19001112222';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|671|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GU fixedLine }
    (HasData: True;
     NationalNumberPattern: '671(?:2\d\d|3(?:00|3[39]|4[349]|55|6[26])|4(?:00|56|7[1-9]|8[02-9])|5(?:55|6[2-5]|88)|6(?:3[2-57' +
       '8]|4[24-9]|5[34]|78|8[235-9])|7(?:[0479]7|2[0167]|3[45]|8[7-9])|8(?:[2-57-9]8|6[478])|9(?:2[29]|' +
       '6[79]|7[1279]|8[7-9]|9[16-9]))\d{4}';
     ExampleNumber: '6713001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GU mobile }
    (HasData: True;
     NationalNumberPattern: '671(?:2\d\d|3(?:00|3[39]|4[349]|55|6[26])|4(?:00|56|7[1-9]|8[02-9])|5(?:55|6[2-5]|88)|6(?:3[2-57' +
       '8]|4[24-9]|5[34]|78|8[235-9])|7(?:[0479]7|2[0167]|3[45]|8[7-9])|8(?:[2-57-9]8|6[478])|9(?:2[29]|' +
       '6[79]|7[1279]|8[7-9]|9[16-9]))\d{4}';
     ExampleNumber: '6713001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { GU tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[49]\d{8}|4\d{6}';
     ExampleNumber: '';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW fixedLine }
    (HasData: True;
     NationalNumberPattern: '443\d{6}';
     ExampleNumber: '443201234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW mobile }
    (HasData: True;
     NationalNumberPattern: '9(?:5\d|6[569]|77)\d{6}';
     ExampleNumber: '955012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW voip }
    (HasData: True;
     NationalNumberPattern: '40\d{5}';
     ExampleNumber: '4012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-8]\d{3}|9008)\d{3}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:1[6-9]|2[0-35-9]|3[1-4]|5[3-9]|6\d|7[0-79])|3(?:2[25-9]|3\d)|4(?:4[0-24]|5[56])|50[0-6]|7' +
       '7[1-57])\d{4}';
     ExampleNumber: '2201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY mobile }
    (HasData: True;
     NationalNumberPattern: '(?:51[01]|6\d\d|7(?:[0-5]\d|6[0-79]|70|8[067]))\d{4}';
     ExampleNumber: '6091234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:289|8(?:00|6[28]|88|99))\d{4}';
     ExampleNumber: '2891234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY premiumRate }
    (HasData: True;
     NationalNumberPattern: '9008\d{3}';
     ExampleNumber: '9008123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY voip }
    (HasData: True;
     NationalNumberPattern: '515\d{4}';
     ExampleNumber: '5151234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { GY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK generalDesc }
    (HasData: True;
     NationalNumberPattern: '8[0-46-9]\d{6,7}|9\d{4,7}|(?:[2-7]|9\d{3})\d{7}';
     ExampleNumber: '';
     LengthOffset: 266; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:[13-9]\d|2[013-9])\d|3(?:(?:[1569][0-24-9]|4[0-246-9]|7[0-24-69])\d|8(?:4[0-8]|[579]\d|6[' +
       '0-5]))|58(?:0[1-9]|1[2-9]))\d{4}';
     ExampleNumber: '21234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK mobile }
    (HasData: True;
     NationalNumberPattern: '(?:4(?:0(?:6[0-3]|9[3-6])|24[3-6]|44[0-35-9]|6(?:4[0-57-9]|6[0-6])|7(?:4[0-48]|6[0-5]))|5(?:25[3' +
       '-7]|35[4-8]|73[0-6]|95[0-8])|6(?:26[013-8]|(?:66|78)[0-5])|7(?:0(?:7[1-8]|8[0-8])|10[1-4])|84(?:' +
       '4[0-2]|8[0-35-9])|9(?:29[013-9]|39[014-9]|59[0-467]|899))\d{4}|(?:4(?:4[0-35-9]|6[0-357-9]|7[0-3' +
       '5])|5(?:[1-59][0-46-9]|6[0-4689]|7[0-246-9])|6(?:0[1-9]|[13-59]\d|[268][0-57-9]|7[0-79])|70[1-59' +
       ']|84[0-39]|9(?:0[1-9]|1[02-9]|[2358][0-8]|[467]\d))\d{5}';
     ExampleNumber: '51234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK premiumRate }
    (HasData: True;
     NationalNumberPattern: '900(?:[0-24-9]\d{7}|3\d{1,4})';
     ExampleNumber: '90012345678';
     LengthOffset: 272; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK personalNumber }
    (HasData: True;
     NationalNumberPattern: '8(?:1[0-4679]\d|2(?:[0-36]\d|7[0-4])|3(?:[034]\d|2[09]|70))\d{4}';
     ExampleNumber: '81123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK pager }
    (HasData: True;
     NationalNumberPattern: '7(?:1(?:0[08]|1[0-3679]|3[013]|69|9[0136])|2(?:[02389]\d|1[18]|7[27-9])|3(?:[0-38]\d|7[0-369]|9[' +
       '2357-9])|47\d|5(?:[178]\d|5[0-5])|6(?:0[0-7]|2[236-9]|[35]\d)|7(?:[27]\d|8[7-9])|8(?:[23689]\d|7' +
       '[1-9])|9(?:[025]\d|6[0-246-8]|7[0-36-9]|8[238]))\d{4}';
     ExampleNumber: '71123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK uan }
    (HasData: True;
     NationalNumberPattern: '30(?:0[1-9]|[15-7]\d|2[047]|89)\d{4}';
     ExampleNumber: '30161234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{10}|[237-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 264; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:2(?:0[0-59]|1[1-9]|[23]\d|4[02-8]|5[57]|6[2458]|7[0135689]|8[01346-9]|9[0-2])|4(?:0[578]|2[3' +
       '-59]|3[13-9]|4[0-68]|5[1-3589]|80)|5(?:0[2357-9]|1[1-6]|4[03-58]|5\d|6[014-69]|7[04]|80)|6(?:[05' +
       '6]\d|17|2[067]|3[047]|4[0-378]|[78][0-8]|9[01])|7(?:0[5-79]|2[01]|6[46-9]|7[02-9]|8[034]|91)|8(?' +
       ':79|8[0-357-9]|9[1-57-9]))\d{4}';
     ExampleNumber: '22123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN mobile }
    (HasData: True;
     NationalNumberPattern: '[37-9]\d{7}';
     ExampleNumber: '91234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN tollFree }
    (HasData: True;
     NationalNumberPattern: '8002\d{7}';
     ExampleNumber: '80021234567';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HN noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '8002\d{7}';
     ExampleNumber: '';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-69]\d{8}|80\d{5,7}|[1-79]\d{7}|6\d{6}';
     ExampleNumber: '';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { HR fixedLine }
    (HasData: True;
     NationalNumberPattern: '1\d{7}|(?:2[0-3]|3[1-5]|4[02-47-9]|5[1-3])\d{6,7}';
     ExampleNumber: '12345678';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { HR mobile }
    (HasData: True;
     NationalNumberPattern: '9(?:(?:0[1-9]|[12589]\d)\d\d|7(?:[0679]\d\d|5(?:[01]\d|44|55|77|9[5-79])))\d{4}|98\d{6}';
     ExampleNumber: '921234567';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{5,7}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR premiumRate }
    (HasData: True;
     NationalNumberPattern: '6[01459]\d{6}|6[01]\d{5}';
     ExampleNumber: '6001234';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR personalNumber }
    (HasData: True;
     NationalNumberPattern: '7[45]\d{6}';
     ExampleNumber: '74123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR uan }
    (HasData: True;
     NationalNumberPattern: '62\d{6,7}|72\d{6}';
     ExampleNumber: '62123456';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-589]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:2\d|5[1-5]|81|9[149])\d{5}';
     ExampleNumber: '22453300';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[34]\d|5[568])\d{6}';
     ExampleNumber: '34101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT tollFree }
    (HasData: True;
     NationalNumberPattern: '8\d{7}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT voip }
    (HasData: True;
     NationalNumberPattern: '9(?:[67][0-4]|8[0-3589]|9\d)\d{5}';
     ExampleNumber: '98901234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[235-7]\d{8}|[1-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { HU fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1\d|[27][2-9]|3[2-7]|4[24-9]|5[2-79]|6[23689]|8[2-57-9]|9[2-69])\d{6}';
     ExampleNumber: '12345678';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { HU mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[257]0|3[01])\d{7}';
     ExampleNumber: '201234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:[48]0\d|680[29])\d{5}';
     ExampleNumber: '80123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU premiumRate }
    (HasData: True;
     NationalNumberPattern: '9[01]\d{6}';
     ExampleNumber: '90123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU voip }
    (HasData: True;
     NationalNumberPattern: '21\d{7}';
     ExampleNumber: '211234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU uan }
    (HasData: True;
     NationalNumberPattern: '38\d{7}';
     ExampleNumber: '381234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { HU noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '(?:[48]0\d|680[29])\d{5}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID generalDesc }
    (HasData: True;
     NationalNumberPattern: '00[1-9]\d{9,14}|(?:[1-36]|8\d{5})\d{6}|00\d{9}|[1-9]\d{8,10}|[2-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 277; LengthCount: 11;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { ID fixedLine }
    (HasData: True;
     NationalNumberPattern: '2[124]\d{7,8}|619\d{8}|2(?:1(?:14|500)|2\d{3})\d{3}|61\d{5,8}|(?:2(?:[35][1-4]|6[0-8]|7[1-6]|8\d' +
       '|9[1-8])|3(?:1|[25][1-8]|3[1-68]|4[1-3]|6[1-3568]|7[0-469]|8\d)|4(?:0[1-589]|1[01347-9]|2[0-36-8' +
       ']|3[0-24-68]|43|5[1-378]|6[1-5]|7[134]|8[1245])|5(?:1[1-35-9]|2[25-8]|3[124-9]|4[1-3589]|5[1-46]' +
       '|6[1-8])|6(?:[25]\d|3[1-69]|4[1-6])|7(?:02|[125][1-9]|[36]\d|4[1-8]|7[0-36-9])|9(?:0[12]|1[013-8' +
       ']|2[0-479]|5[125-8]|6[23679]|7[159]|8[01346]))\d{5,8}';
     ExampleNumber: '218350123';
     LengthOffset: 165; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { ID mobile }
    (HasData: True;
     NationalNumberPattern: '8[1-35-9]\d{7,10}';
     ExampleNumber: '812345678';
     LengthOffset: 184; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID tollFree }
    (HasData: True;
     NationalNumberPattern: '00(?:1803\d{5,11}|7803\d{7})|(?:177\d|800)\d{5,7}';
     ExampleNumber: '8001234567';
     LengthOffset: 288; LengthCount: 10;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID premiumRate }
    (HasData: True;
     NationalNumberPattern: '809\d{7}';
     ExampleNumber: '8091234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID sharedCost }
    (HasData: True;
     NationalNumberPattern: '804\d{7}';
     ExampleNumber: '8041234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID uan }
    (HasData: True;
     NationalNumberPattern: '(?:1500|8071\d{3})\d{3}';
     ExampleNumber: '8071123456';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ID noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '001803\d{5,11}|(?:007803\d|8071)\d{6}';
     ExampleNumber: '';
     LengthOffset: 298; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1\d|[2569])\d{6,8}|4\d{6,9}|7\d{8}|8\d{8,9}';
     ExampleNumber: '';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { IE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1\d|21)\d{6,7}|(?:2[24-9]|4(?:0[24]|5\d|7)|5(?:0[45]|1\d|8)|6(?:1\d|[237-9])|9(?:1\d|[35-9]))' +
       '\d{5}|(?:23|4(?:[1-469]|8\d)|5[23679]|6[4-6]|7[14]|9[04])\d{7}';
     ExampleNumber: '2212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { IE mobile }
    (HasData: True;
     NationalNumberPattern: '8(?:22|[35-9]\d)\d{6}';
     ExampleNumber: '850123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{6}';
     ExampleNumber: '1800123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE premiumRate }
    (HasData: True;
     NationalNumberPattern: '15(?:1[2-8]|[2-8]0|9[089])\d{6}';
     ExampleNumber: '1520123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE sharedCost }
    (HasData: True;
     NationalNumberPattern: '18[59]0\d{6}';
     ExampleNumber: '1850123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE personalNumber }
    (HasData: True;
     NationalNumberPattern: '700\d{6}';
     ExampleNumber: '700123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE voip }
    (HasData: True;
     NationalNumberPattern: '76\d{7}';
     ExampleNumber: '761234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE uan }
    (HasData: True;
     NationalNumberPattern: '818\d{6}';
     ExampleNumber: '818123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE voicemail }
    (HasData: True;
     NationalNumberPattern: '88210[1-9]\d{4}|8(?:[35-79]5\d\d|8(?:[013-9]\d\d|2(?:[01][1-9]|[2-9]\d)))\d{5}';
     ExampleNumber: '8551234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IE noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '18[59]0\d{6}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{6}(?:\d{3,5})?|[57]\d{8}|[1-489]\d{7}';
     ExampleNumber: '';
     LengthOffset: 159; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL fixedLine }
    (HasData: True;
     NationalNumberPattern: '153\d{8,9}|29[1-9]\d{5}|(?:2[0-8]|[3489]\d)\d{6}';
     ExampleNumber: '21234567';
     LengthOffset: 306; LengthCount: 3;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { IL mobile }
    (HasData: True;
     NationalNumberPattern: '55(?:4(?:0[0-4]|10|6[015-9])|57[0-289]|8[06][0-2])\d{4}|5(?:(?:[0-2][02-9]|[36]\d|[49][2-9]|8[3-' +
       '7])\d|5(?:01|2\d|3[0-3]|4[3-5]|5[0-25689]|6[6-8]|7[0-267]|8[7-9]|9[1-9]))\d{5}';
     ExampleNumber: '502345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:255|80[019]\d{3})\d{3}';
     ExampleNumber: '1800123456';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL premiumRate }
    (HasData: True;
     NationalNumberPattern: '1212\d{4}|1(?:200|9(?:0[0-2]|19|9\d))\d{6}';
     ExampleNumber: '1919123456';
     LengthOffset: 114; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL sharedCost }
    (HasData: True;
     NationalNumberPattern: '1700\d{6}';
     ExampleNumber: '1700123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL voip }
    (HasData: True;
     NationalNumberPattern: '7(?:280[01]|38(?:[05]\d|8[0-358])|8(?:33|55|77|81)\d)\d{4}|7(?:18|2[23]|3[237]|47|6[258]|7\d|82|' +
       '9[2-9])\d{6}';
     ExampleNumber: '771234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL uan }
    (HasData: True;
     NationalNumberPattern: '1599\d{6}';
     ExampleNumber: '1599123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL voicemail }
    (HasData: True;
     NationalNumberPattern: '151\d{8,9}';
     ExampleNumber: '15112340000';
     LengthOffset: 309; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IL noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '1700\d{6}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM generalDesc }
    (HasData: True;
     NationalNumberPattern: '1624\d{6}|(?:[3578]\d|90)\d{8}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { IM fixedLine }
    (HasData: True;
     NationalNumberPattern: '1624(?:230|[5-8]\d\d)\d{3}';
     ExampleNumber: '1624756789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { IM mobile }
    (HasData: True;
     NationalNumberPattern: '76245[06]\d{4}|7(?:4576|[59]24\d|624[0-4689])\d{5}';
     ExampleNumber: '7924123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM tollFree }
    (HasData: True;
     NationalNumberPattern: '808162\d{4}';
     ExampleNumber: '8081624567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM premiumRate }
    (HasData: True;
     NationalNumberPattern: '8(?:440[49]06|72299\d)\d{3}|(?:8(?:45|70)|90[0167])624\d{4}';
     ExampleNumber: '9016247890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{8}';
     ExampleNumber: '7012345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM voip }
    (HasData: True;
     NationalNumberPattern: '56\d{8}';
     ExampleNumber: '5612345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM uan }
    (HasData: True;
     NationalNumberPattern: '3440[49]06\d{3}|(?:3(?:08162|3\d{4}|45624|7(?:0624|2299))|55\d{4})\d{4}';
     ExampleNumber: '5512345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:000800|[2-9]\d\d)\d{7}|1\d{7,12}';
     ExampleNumber: '';
     LengthOffset: 57; LengthCount: 6;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { IN fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2717(?:[2-7]\d|95)|6828[235-7]\d)\d{4}|(?:170[24]|280[13468]|4(?:20[24]|72[2-8])|552[1-7])\d{' +
       '6}|(?:271[0-689]|682[0-79]|782[0-6])[2-7]\d{5}|(?:2(?:[02][2-79]|90)|3(?:23|80)|683|79[1-6])\d{7' +
       '}|(?:11|33|4[04]|80)[2-7]\d{7}|(?:342|674|788)(?:[0189][2-7]|[2-7]\d)\d{5}|(?:1(?:2[0-249]|3[0-2' +
       '5]|4[145]|[59][14]|6[014]|7[1257]|8[01346])|2(?:1[257]|3[013]|4[01]|5[0137]|6[0158]|78|8[1568]|9' +
       '[14])|3(?:26|4[13]|5[34]|6[01489]|7[02-46]|8[159])|4(?:1[36]|2[1-47]|3[15]|5[12]|6[0-26-9]|7[014' +
       '-9]|8[013-57]|9[014-7])|5(?:1[025]|22|[36][25]|4[28]|[578]1|9[15])|6(?:12|[2-47]1|5[17]|6[13]|80' +
       ')|7(?:12|2[14]|3[134]|4[47]|5[15]|[67]1)|8(?:16|2[014]|3[126]|6[136]|7[078]|8[34]|91))[2-7]\d{6}' +
       '|(?:1(?:2[35-8]|3[346-9]|4[236-9]|[59][0235-9]|6[235-9]|7[34689]|8[257-9])|2(?:1[134689]|3[24-8]' +
       '|4[2-8]|5[25689]|6[2-4679]|7[3-79]|8[2-479]|9[235-9])|3(?:01|1[79]|2[1245]|4[5-8]|5[125689]|6[23' +
       '5-7]|7[157-9]|8[2-46-8])|4(?:1[14578]|2[5689]|3[2-467]|5[4-7]|6[35]|73|8[2689]|9[2389])|5(?:[16]' +
       '[146-9]|2[14-8]|3[1346]|4[14-69]|5[46]|7[2-4]|8[2-8]|9[246])|6(?:1[1358]|2[2457]|3[2-4]|4[235-7]' +
       '|5[2-689]|6[24578]|7[235689]|8[14-6])|7(?:1[013-9]|2[0235-9]|3[2679]|4[1-35689]|5[2-46-9]|[67][0' +
       '2-9]|8[013-7]|90)|8(?:1[1357-9]|2[235-8]|3[03-57-9]|4[0-24-9]|5\d|6[2457-9]|7[1-6]|8[1256]|9[2-4' +
       ']))\d[2-7]\d{5}';
     ExampleNumber: '7410410123';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 31; LocalOnlyCount: 3),
    { IN mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6(?:1279|828[01489])|7(?:887[02-9]|9313)|8(?:079[04-9]|(?:84|91)7[02-8]))\d{5}|(?:160[01]|6(?' +
       ':(?:12|[2-4]1|5[17]|6[13]|80)[0189]|7(?:1[0189]|86))|7(?:1(?:2[0189]|9[0-5])|3(?:2[5-8]|[34][017' +
       '-9]|9[016-9])|5(?:[15][017-9]|2[04-9]|9[7-9])|6(?:0[0-47]|1[0-257-9]|2[0-4]|3[19]|5[4589])|70[02' +
       '89]|88[089])|8(?:0(?:6[67]|7[02-8])|70[017-9]|84[01489]|91[0-289]))\d{6}|(?:731|8(?:16|2[014]|3[' +
       '126]|6[136]|7[78]|83))(?:[0189]\d|7[02-8])\d{5}|(?:6(?:(?:1[1358]|2[2457]|3[2-4]|4[235-7]|5[2-68' +
       '9]|6[24578])\d|7(?:[23569]\d|4[0189]|8[0-57-9])|8(?:[14-6]\d|2[0-79]))|7(?:1(?:[013-8]\d|9[6-9])' +
       '|3(?:2[0-49]|9[2-5])|5(?:2[1-3]|9[0-6])|6(?:0[5689]|2[5-9]|3[02-8]|4\d|5[0-367])|70[13-7]|881))[' +
       '0189]\d{5}|(?:6(?:[09]\d|1[04679]|2[03689]|3[05-9]|4[0489]|50|6[069]|7[07]|8[7-9])|7(?:[024]\d|3' +
       '[05-8]|5[0346-8]|6[6-9]|7[1-9]|8[0-79]|9[07-9])|8(?:0[01589]|1[0-57-9]|2[235-9]|3[03-57-9]|[45]\' +
       'd|6[02457-9]|7[1-69]|8[0-25-9]|9[02-9])|9\d\d)\d{7}';
     ExampleNumber: '8123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN tollFree }
    (HasData: True;
     NationalNumberPattern: '000800\d{7}|180(?:0\d{4,9}|3\d{9})';
     ExampleNumber: '1800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN premiumRate }
    (HasData: True;
     NationalNumberPattern: '186[12]\d{9}';
     ExampleNumber: '1861123456789';
     LengthOffset: 311; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN sharedCost }
    (HasData: True;
     NationalNumberPattern: '1860\d{7}';
     ExampleNumber: '18603451234';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN uan }
    (HasData: True;
     NationalNumberPattern: '140\d{7}';
     ExampleNumber: '1409305260';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IN noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '1800\d{4,9}|(?:000800|18(?:03\d\d|6(?:0|[12]\d\d)))\d{7}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO generalDesc }
    (HasData: True;
     NationalNumberPattern: '3\d{6}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO fixedLine }
    (HasData: True;
     NationalNumberPattern: '37\d{5}';
     ExampleNumber: '3709100';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO mobile }
    (HasData: True;
     NationalNumberPattern: '38\d{5}';
     ExampleNumber: '3801234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1|7\d\d)\d{7}|[2-6]\d{7,8}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { IQ fixedLine }
    (HasData: True;
     NationalNumberPattern: '1\d{7}|(?:2[13-5]|3[02367]|4[023]|5[03]|6[026])\d{6,7}';
     ExampleNumber: '12345678';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { IQ mobile }
    (HasData: True;
     NationalNumberPattern: '7[3-9]\d{8}';
     ExampleNumber: '7912345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IQ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{9}|(?:[1-8]\d\d|9)\d{3,4}';
     ExampleNumber: '';
     LengthOffset: 312; LengthCount: 5;
     LocalOnlyOffset: 10; LocalOnlyCount: 1),
    { IR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1[137]|2[13-68]|3[1458]|4[145]|5[1468]|6[16]|7[1467]|8[13467])(?:[03-57]\d{7}|[16]\d{3}(?:\d{' +
       '4})?|[289]\d{3}(?:\d(?:\d{3})?)?)|94(?:000[09]|(?:12\d|30[0-2])\d|2(?:[02689]0\d|121)|4(?:111|40' +
       '\d))\d{4}';
     ExampleNumber: '2123456789';
     LengthOffset: 317; LengthCount: 3;
     LocalOnlyOffset: 320; LocalOnlyCount: 3),
    { IR mobile }
    (HasData: True;
     NationalNumberPattern: '9(?:(?:0[0-5]|[13]\d|2[0-3])\d\d|9(?:[0-46]\d\d|5(?:10|5\d)|8(?:[12]\d|3[0-2]|88)|9(?:[0-359]\d|' +
       '69|77|8[7-9])))\d{5}';
     ExampleNumber: '9123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR uan }
    (HasData: True;
     NationalNumberPattern: '96(?:0[12]|2[16-8]|3(?:08|[14]5|[23]|66)|4(?:0|80)|5[01]|6[89]|86|9[19])';
     ExampleNumber: '9601';
     LengthOffset: 110; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IR noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '9(?:4440\d{5}|6(?:0[12]|2[16-8]|3(?:08|[14]5|[23]|66)|4(?:0|80)|5[01]|6[89]|86|9[19]))';
     ExampleNumber: '';
     LengthOffset: 323; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:38\d|[4-9])\d{6}';
     ExampleNumber: '';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:4(?:1[0-24-69]|2[0-7]|[37][0-8]|4[0-24589]|5[0-68]|6\d|8[0-36-8])|5(?:05|[156]\d|2[02578]|3[0' +
       '-579]|4[03-7]|7[0-2578]|8[0-35-9]|9[013-689])|872)\d{4}';
     ExampleNumber: '4101234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS mobile }
    (HasData: True;
     NationalNumberPattern: '(?:38[589]\d\d|6(?:1[1-8]|2[0-6]|3[026-9]|4[014679]|5[0159]|6[0-69]|70|8[06-8]|9\d)|7(?:5[057]|[' +
       '6-9]\d)|8(?:2[0-59]|[3-69]\d|8[238]))\d{4}';
     ExampleNumber: '6111234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-8]\d{4}';
     ExampleNumber: '8001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS premiumRate }
    (HasData: True;
     NationalNumberPattern: '90(?:0\d|1[5-79]|2[015-79]|3[135-79]|4[125-7]|5[25-79]|7[1-37]|8[0-35-7])\d{3}';
     ExampleNumber: '9001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS voip }
    (HasData: True;
     NationalNumberPattern: '49[0-24-79]\d{4}';
     ExampleNumber: '4921234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS uan }
    (HasData: True;
     NationalNumberPattern: '809\d{4}';
     ExampleNumber: '8091234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS voicemail }
    (HasData: True;
     NationalNumberPattern: '(?:689|8(?:7[18]|80)|95[48])\d{4}';
     ExampleNumber: '6891234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT generalDesc }
    (HasData: True;
     NationalNumberPattern: '0\d{5,11}|1\d{8,10}|3(?:[0-8]\d{7,10}|9\d{7,8})|(?:43|55|70)\d{8}|8\d{5}(?:\d{2,4})?';
     ExampleNumber: '';
     LengthOffset: 326; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT fixedLine }
    (HasData: True;
     NationalNumberPattern: '0(?:669[0-79]\d{1,6}|831\d{2,8})|0(?:1(?:[0159]\d|[27][1-5]|31|4[1-4]|6[1356]|8[2-57])|2\d\d|3(?' +
       ':[0159]\d|2[1-4]|3[12]|[48][1-6]|6[2-59]|7[1-7])|4(?:[0159]\d|[23][1-9]|4[245]|6[1-5]|7[1-4]|81)' +
       '|5(?:[0159]\d|2[1-5]|3[2-6]|4[1-79]|6[4-6]|7[1-578]|8[3-8])|6(?:[0-57-9]\d|6[0-8])|7(?:[0159]\d|' +
       '2[12]|3[1-7]|4[2-46]|6[13569]|7[13-6]|8[1-59])|8(?:[0159]\d|2[3-578]|3[2356]|[6-8][1-5])|9(?:[01' +
       '59]\d|[238][1-5]|4[12]|6[1-8]|7[1-6]))\d{2,7}';
     ExampleNumber: '0212345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT mobile }
    (HasData: True;
     NationalNumberPattern: '3[2-9]\d{7,8}|(?:31|43)\d{8}';
     ExampleNumber: '3123456789';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT tollFree }
    (HasData: True;
     NationalNumberPattern: '80(?:0\d{3}|3)\d{3}';
     ExampleNumber: '800123456';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:0878\d{3}|89(?:2\d|3[04]|4(?:[0-4]|[5-9]\d\d)|5[0-4]))\d\d|(?:1(?:44|6[346])|89(?:38|5[5-9]|9' +
       '))\d{6}';
     ExampleNumber: '899123456';
     LengthOffset: 333; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT sharedCost }
    (HasData: True;
     NationalNumberPattern: '84(?:[08]\d{3}|[17])\d{3}';
     ExampleNumber: '848123456';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT personalNumber }
    (HasData: True;
     NationalNumberPattern: '1(?:78\d|99)\d{6}';
     ExampleNumber: '1781234567';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT voip }
    (HasData: True;
     NationalNumberPattern: '55\d{8}';
     ExampleNumber: '5512345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT voicemail }
    (HasData: True;
     NationalNumberPattern: '3[2-8]\d{9,10}';
     ExampleNumber: '33101234501';
     LengthOffset: 309; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { IT noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '848\d{6}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE generalDesc }
    (HasData: True;
     NationalNumberPattern: '1534\d{6}|(?:[3578]\d|90)\d{8}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { JE fixedLine }
    (HasData: True;
     NationalNumberPattern: '1534[0-24-8]\d{5}';
     ExampleNumber: '1534456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { JE mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:(?:(?:50|82)9|937)\d|7(?:00[378]|97\d))\d{5}';
     ExampleNumber: '7797712345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE tollFree }
    (HasData: True;
     NationalNumberPattern: '80(?:07(?:35|81)|8901)\d{4}';
     ExampleNumber: '8007354567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:8(?:4(?:4(?:4(?:05|42|69)|703)|5(?:041|800))|7(?:0002|1206))|90(?:066[59]|1810|71(?:07|55)))\' +
       'd{4}';
     ExampleNumber: '9018105678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE personalNumber }
    (HasData: True;
     NationalNumberPattern: '701511\d{4}';
     ExampleNumber: '7015115678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE voip }
    (HasData: True;
     NationalNumberPattern: '56\d{8}';
     ExampleNumber: '5612345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE pager }
    (HasData: True;
     NationalNumberPattern: '76(?:464|652)\d{5}|76(?:0[0-28]|2[356]|34|4[01347]|5[49]|6[0-369]|77|8[14]|9[139])\d{6}';
     ExampleNumber: '7640123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE uan }
    (HasData: True;
     NationalNumberPattern: '(?:3(?:0(?:07(?:35|81)|8901)|3\d{4}|4(?:4(?:4(?:05|42|69)|703)|5(?:041|800))|7(?:0002|1206))|55\' +
       'd{4})\d{4}';
     ExampleNumber: '5512345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|658|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { JM fixedLine }
    (HasData: True;
     NationalNumberPattern: '8766060\d{3}|(?:658(?:2(?:[5-8]\d|9[0-46-9])|[3-9]\d\d)|876(?:52[35]|6(?:0[1-3579]|1[0235-9]|[23' +
       ']\d|40|5[06]|6[2-589]|7[0-25-9]|8[04]|9[4-9])|7(?:0[2-689]|[1-6]\d|8[056]|9[45])|9(?:0[1-8]|1[02' +
       '378]|[2-8]\d|9[2-468])))\d{4}';
     ExampleNumber: '8765230123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { JM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6582(?:[0-4]\d|95)|876(?:2(?:0[1-9]|[13-9]\d|2[013-9])|[348]\d\d|5(?:0[1-9]|[1-9]\d)|6(?:4[89' +
       ']|6[67])|7(?:0[07]|7\d|8[1-47-9]|9[0-36-9])|9(?:[01]9|9[0579])))\d{4}';
     ExampleNumber: '8762101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { JM tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:(?:[2689]|7\d)\d|32|427|53)\d{6}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO fixedLine }
    (HasData: True;
     NationalNumberPattern: '87(?:000|90[01])\d{3}|(?:2(?:6(?:2[0-35-9]|3[0-578]|4[24-7]|5[0-24-8]|[6-8][023]|9[0-3])|7(?:0[1' +
       '-79]|10|2[014-7]|3[0-689]|4[019]|5[0-3578]))|32(?:0[1-69]|1[1-35-7]|2[024-7]|3\d|4[0-3]|[5-7][02' +
       '3])|53(?:0[0-3]|[13][023]|2[0-59]|49|5[0-35-9]|6[15]|7[45]|8[1-6]|9[0-36-9])|6(?:2(?:[05]0|22)|3' +
       '(?:00|33)|4(?:0[0-25]|1[2-7]|2[0569]|[38][07-9]|4[025689]|6[0-589]|7\d|9[0-2])|5(?:[01][056]|2[0' +
       '34]|3[0-57-9]|4[178]|5[0-69]|6[0-35-9]|7[1-379]|8[0-68]|9[0239]))|87(?:20|7[078]|99))\d{4}';
     ExampleNumber: '62001234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO mobile }
    (HasData: True;
     NationalNumberPattern: '(?:427|7(?:11|[29]\d|[78][0-25-9]))\d{6}';
     ExampleNumber: '790123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{6}';
     ExampleNumber: '80012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO premiumRate }
    (HasData: True;
     NationalNumberPattern: '9\d{7}';
     ExampleNumber: '90012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO sharedCost }
    (HasData: True;
     NationalNumberPattern: '85\d{6}';
     ExampleNumber: '85012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{7}';
     ExampleNumber: '700123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO pager }
    (HasData: True;
     NationalNumberPattern: '74(?:66|77)\d{5}';
     ExampleNumber: '746612345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO uan }
    (HasData: True;
     NationalNumberPattern: '8(?:10|8\d)\d{5}';
     ExampleNumber: '88101234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP generalDesc }
    (HasData: True;
     NationalNumberPattern: '00[1-9]\d{6,14}|[25-9]\d{9}|(?:00|[1-9]\d\d)\d{6}';
     ExampleNumber: '';
     LengthOffset: 288; LengthCount: 10;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:1[235-8]|2[3-6]|3[3-9]|4[2-6]|[58][2-8]|6[2-7]|7[2-9]|9[1-9])|(?:2[2-9]|[36][1-9])\d|4(?:' +
       '[2-578]\d|6[02-8]|9[2-59])|5(?:[2-589]\d|6[1-9]|7[2-8])|7(?:[25-9]\d|3[4-9]|4[02-9])|8(?:[2679]\' +
       'd|3[2-9]|4[5-9]|5[1-9]|8[03-9])|9(?:[2-58]\d|[679][1-9]))\d{6}';
     ExampleNumber: '312345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP mobile }
    (HasData: True;
     NationalNumberPattern: '[6-9]0[1-9]\d{7}';
     ExampleNumber: '9012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP tollFree }
    (HasData: True;
     NationalNumberPattern: '00777(?:[01]|5\d)\d\d|(?:00(?:7778|882[1245])|(?:120|800\d)\d\d)\d{4}|00(?:37|66|78)\d{6,13}';
     ExampleNumber: '120123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP premiumRate }
    (HasData: True;
     NationalNumberPattern: '990\d{6}';
     ExampleNumber: '990123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP personalNumber }
    (HasData: True;
     NationalNumberPattern: '60\d{7}';
     ExampleNumber: '601234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP voip }
    (HasData: True;
     NationalNumberPattern: '50[1-9]\d{7}';
     ExampleNumber: '5012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP pager }
    (HasData: True;
     NationalNumberPattern: '20\d{8}';
     ExampleNumber: '2012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP uan }
    (HasData: True;
     NationalNumberPattern: '570\d{6}';
     ExampleNumber: '570123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { JP noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '00(?:777(?:[01]|(?:5|8\d)\d)|882[1245]\d\d)\d\d|00(?:37|66|78)\d{6,13}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[17]\d\d|900)\d{6}|(?:2|80)0\d{6,7}|[4-6]\d{6,8}';
     ExampleNumber: '';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:4[245]|5[1-79]|6[01457-9])\d{5,7}|(?:4[136]|5[08]|62)\d{7}|(?:[24]0|66)\d{6,7}';
     ExampleNumber: '202012345';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE mobile }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:0[0-8]|[18]\d|2[014]|30|4[0-5])|7\d\d)\d{6}';
     ExampleNumber: '712123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE tollFree }
    (HasData: True;
     NationalNumberPattern: '800[02-8]\d{5,6}';
     ExampleNumber: '800223456';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[02-9]\d{5}';
     ExampleNumber: '900223456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{9}|[235-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { KG fixedLine }
    (HasData: True;
     NationalNumberPattern: '312(?:5[0-79]\d|9(?:[0-689]\d|7[0-24-9]))\d{3}|(?:3(?:1(?:2[0-46-8]|3[1-9]|47|[56]\d)|2(?:22|3[0' +
       '-479]|6[0-7])|4(?:22|5[6-9]|6\d)|5(?:22|3[4-7]|59|6\d)|6(?:22|5[35-7]|6\d)|7(?:22|3[468]|4[1-9]|' +
       '59|[67]\d)|9(?:22|4[1-8]|6\d))|6(?:09|12|2[2-4])\d)\d{5}';
     ExampleNumber: '312123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { KG mobile }
    (HasData: True;
     NationalNumberPattern: '312(?:58\d|973)\d{3}|(?:2(?:0[0-35]|2\d)|5[0-24-7]\d|600|7(?:[07]\d|55)|88[08]|9(?:12|9[05-9]))\' +
       'd{6}';
     ExampleNumber: '700123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6,7}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{9}|[1-9]\d{7,8}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { KH fixedLine }
    (HasData: True;
     NationalNumberPattern: '23(?:4(?:[2-4]|[56]\d)|[568]\d\d)\d{4}|23[236-9]\d{5}|(?:2[4-6]|3[2-6]|4[2-4]|[5-7][2-5])(?:(?:[' +
       '237-9]|4[56]|5\d)\d{5}|6\d{5,6})';
     ExampleNumber: '23756789';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { KH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:1[28]|3[18]|9[67])\d|6[016-9]|7(?:[07-9]|[16]\d)|8(?:[013-79]|8\d))\d{6}|(?:1\d|9[0-57-9])' +
       '\d{6}|(?:2[3-6]|3[2-6]|4[2-4]|[5-7][2-5])48\d{5}';
     ExampleNumber: '91234567';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH tollFree }
    (HasData: True;
     NationalNumberPattern: '1800(?:1\d|2[019])\d{4}';
     ExampleNumber: '1800123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH premiumRate }
    (HasData: True;
     NationalNumberPattern: '1900(?:1\d|2[09])\d{4}';
     ExampleNumber: '1900123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[37]\d|6[0-79])\d{6}|(?:[2-48]\d|50)\d{3}';
     ExampleNumber: '';
     LengthOffset: 337; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:[24]\d|3[1-9]|50|65(?:02[12]|12[56]|22[89]|[3-5]00)|7(?:27\d\d|3100|5(?:02[12]|12[56]|22[89]|' +
       '[34](?:00|81)|500))|8[0-5])\d{3}';
     ExampleNumber: '31234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6200[01]|7(?:310[1-9]|5(?:02[03-9]|12[0-47-9]|22[0-7]|[34](?:0[1-9]|8[02-9])|50[1-9])))\d{3}|' +
       '(?:63\d\d|7(?:(?:[0146-9]\d|2[0-689])\d|3(?:[02-9]\d|1[1-9])|5(?:[0-2][013-9]|[34][1-79]|5[1-9]|' +
       '[6-9]\d)))\d{4}';
     ExampleNumber: '72001234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI voip }
    (HasData: True;
     NationalNumberPattern: '30(?:0[01]\d\d|12(?:11|20))\d\d';
     ExampleNumber: '30010000';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[3478]\d{6}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 339; LocalOnlyCount: 1),
    { KM fixedLine }
    (HasData: True;
     NationalNumberPattern: '7[4-7]\d{5}';
     ExampleNumber: '7712345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 339; LocalOnlyCount: 1),
    { KM mobile }
    (HasData: True;
     NationalNumberPattern: '[34]\d{6}';
     ExampleNumber: '3212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM premiumRate }
    (HasData: True;
     NationalNumberPattern: '8\d{6}';
     ExampleNumber: '8001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { KN fixedLine }
    (HasData: True;
     NationalNumberPattern: '869(?:2(?:29|36)|302|4(?:6[015-9]|70)|56[5-7])\d{4}';
     ExampleNumber: '8692361234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { KN mobile }
    (HasData: True;
     NationalNumberPattern: '869(?:48[89]|55[6-8]|66\d|76[02-7])\d{4}';
     ExampleNumber: '8697652917';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { KN tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KN noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP generalDesc }
    (HasData: True;
     NationalNumberPattern: '85\d{6}|(?:19\d|[2-7])\d{7}';
     ExampleNumber: '';
     LengthOffset: 114; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { KP fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:195|2)\d|3[19]|4[159]|5[37]|6[17]|7[39]|85)\d{6}';
     ExampleNumber: '21234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { KP mobile }
    (HasData: True;
     NationalNumberPattern: '19[1-3]\d{7}';
     ExampleNumber: '1921234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KP noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '238[02-9]\d{4}|2(?:[0-24-9]\d|3[0-79])\d{5}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR generalDesc }
    (HasData: True;
     NationalNumberPattern: '00[1-9]\d{8,11}|(?:[12]|5\d{3})\d{7}|[13-6]\d{9}|(?:[1-6]\d|80)\d{7}|[3-6]\d{4,5}|(?:00|7)0\d{8}';
     ExampleNumber: '';
     LengthOffset: 340; LengthCount: 9;
     LocalOnlyOffset: 349; LocalOnlyCount: 3),
    { KR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2|3[1-3]|[46][1-4]|5[1-5])[1-9]\d{6,7}|(?:3[1-3]|[46][1-4]|5[1-5])1\d{2,3}';
     ExampleNumber: '22123456';
     LengthOffset: 352; LengthCount: 5;
     LocalOnlyOffset: 349; LocalOnlyCount: 3),
    { KR mobile }
    (HasData: True;
     NationalNumberPattern: '1(?:05(?:[0-8]\d|9[0-6])|22[13]\d)\d{4,5}|1(?:0[0-46-9]|[16-9]\d|2[013-9])\d{6,7}';
     ExampleNumber: '1020000000';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR tollFree }
    (HasData: True;
     NationalNumberPattern: '00(?:308\d{6,7}|798\d{7,9})|(?:00368|[38]0)\d{7}';
     ExampleNumber: '801234567';
     LengthOffset: 357; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR premiumRate }
    (HasData: True;
     NationalNumberPattern: '60[2-9]\d{6}';
     ExampleNumber: '602345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR personalNumber }
    (HasData: True;
     NationalNumberPattern: '50\d{8,9}';
     ExampleNumber: '5012345678';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR voip }
    (HasData: True;
     NationalNumberPattern: '70\d{8}';
     ExampleNumber: '7012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR pager }
    (HasData: True;
     NationalNumberPattern: '15\d{7,8}';
     ExampleNumber: '1523456789';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR uan }
    (HasData: True;
     NationalNumberPattern: '1(?:5(?:22|33|44|66|77|88|99)|6(?:[07]0|44|6[0168]|88)|8(?:00|33|55|77|99))\d{4}';
     ExampleNumber: '15441234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KR noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '00(?:3(?:08\d{6,7}|68\d{7})|798\d{7,9})';
     ExampleNumber: '';
     LengthOffset: 362; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW generalDesc }
    (HasData: True;
     NationalNumberPattern: '18\d{5}|(?:[2569]\d|41)\d{6}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:[23]\d\d|4(?:[1-35-9]\d|44)|5(?:0[034]|[2-46]\d|5[1-3]|7[1-7]))\d{4}';
     ExampleNumber: '22345678';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW mobile }
    (HasData: True;
     NationalNumberPattern: '(?:41\d\d|5(?:(?:[05]\d|1[0-7]|6[56])\d|2(?:22|5[25])|7(?:55|77)|88[58])|6(?:(?:0[034679]|5[015-' +
       '9]|6\d)\d|1(?:00|11|6[16])|2[26]2|3[36]3|4[46]4|7(?:0[013-9]|[67]\d)|8[68]8|9(?:[069]\d|3[039]))' +
       '|9(?:(?:[04679]\d|8[057-9])\d|1(?:00|1[01]|99)|2(?:00|2\d)|3(?:00|3[03])|5(?:00|5\d)))\d{4}';
     ExampleNumber: '50012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW tollFree }
    (HasData: True;
     NationalNumberPattern: '18\d{5}';
     ExampleNumber: '1801234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:345|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { KY fixedLine }
    (HasData: True;
     NationalNumberPattern: '345(?:2(?:22|3[23]|44|66)|333|444|6(?:23|38|40)|7(?:30|4[35-79]|6[6-9]|77)|8(?:00|1[45]|4[89]|88' +
       ')|9(?:14|4[035-9]))\d{4}';
     ExampleNumber: '3452221234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { KY mobile }
    (HasData: True;
     NationalNumberPattern: '345(?:32[1-9]|4(?:1[2-6]|2[0-4])|5(?:1[67]|2[5-79]|4[6-9]|50|76)|649|82[56]|9(?:1[679]|2[2-9]|3[' +
       '06-9]|90))\d{4}';
     ExampleNumber: '3453231234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { KY tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:345976|900[2-9]\d\d)\d{4}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{13}|[78]\d{9}';
     ExampleNumber: '';
     LengthOffset: 366; LengthCount: 2;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { KZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '7(?:1(?:0(?:[23]\d|4[0-3]|59|63)|1(?:[23]\d|4[0-79]|59)|2(?:[23]\d|59)|3(?:2\d|3[0-79]|4[0-35-9]' +
       '|59)|4(?:[24]\d|3[013-9]|5[1-9]|97)|5(?:2\d|3[1-9]|4[0-7]|59)|6(?:[2-4]\d|5[19]|61)|72\d|8(?:[27' +
       ']\d|3[1-46-9]|4[0-5]|59))|2(?:1(?:[23]\d|4[46-9]|5[3469])|2(?:2\d|3[0679]|46|5[12679])|3(?:[2-4]' +
       '\d|5[139])|4(?:2\d|3[1-35-9]|59)|5(?:[23]\d|4[0-8]|59|61)|6(?:2\d|3[1-9]|4[0-4]|59)|7(?:[2379]\d' +
       '|40|5[279])|8(?:[23]\d|4[0-3]|59)|9(?:2\d|3[124578]|59)))\d{5}';
     ExampleNumber: '7123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { KZ mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:0[0-25-8]|47|6[0-4]|7[15-8]|85)\d{7}';
     ExampleNumber: '7710009998';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|108\d{3})\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '809\d{7}';
     ExampleNumber: '8091234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ personalNumber }
    (HasData: True;
     NationalNumberPattern: '808\d{7}';
     ExampleNumber: '8081234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ voip }
    (HasData: True;
     NationalNumberPattern: '751\d{7}';
     ExampleNumber: '7511234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { KZ noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '751\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[23]\d{9}|3\d{8}|(?:[235-8]\d|41)\d{6}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { LA fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[13]|[35-7][14]|41|8[1468])\d{6}';
     ExampleNumber: '21212862';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { LA mobile }
    (HasData: True;
     NationalNumberPattern: '(?:20(?:[23579]\d|8[78])|30[24]\d)\d{6}|30\d{7}';
     ExampleNumber: '2023123456';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB generalDesc }
    (HasData: True;
     NationalNumberPattern: '[27-9]\d{7}|[13-9]\d{6}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB fixedLine }
    (HasData: True;
     NationalNumberPattern: '7(?:62|8[0-6]|9[04-9])\d{4}|(?:[14-69]\d|2(?:[14-69]\d|[78][1-9])|7[2-57]|8[02-9])\d{5}';
     ExampleNumber: '1123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:3|81)\d|7(?:[01]\d|6[013-9]|8[7-9]|9[0-4]))\d{5}';
     ExampleNumber: '71123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB premiumRate }
    (HasData: True;
     NationalNumberPattern: '9[01]\d{6}';
     ExampleNumber: '90123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB sharedCost }
    (HasData: True;
     NationalNumberPattern: '80\d{6}';
     ExampleNumber: '80123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LB noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|758|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { LC fixedLine }
    (HasData: True;
     NationalNumberPattern: '758(?:234|4(?:30|5\d|6[2-9]|8[0-2])|57[0-2]|(?:63|75)8)\d{4}';
     ExampleNumber: '7584305678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { LC mobile }
    (HasData: True;
     NationalNumberPattern: '758(?:28[4-7]|384|4(?:6[01]|8[4-9])|5(?:1[89]|20|84)|7(?:1[2-9]|2\d|3[0-3])|812)\d{4}';
     ExampleNumber: '7582845678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { LC tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[68]\d{8}|(?:[2378]\d|90)\d{5}';
     ExampleNumber: '';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:01|1[27]|2[024]|3\d|6[02-578]|9[06])|3(?:[24]0|33|7[0135-7]|8[048]|9[0269]))\d{4}';
     ExampleNumber: '2345678';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6(?:(?:4[5-9]|5\d)\d|6(?:[024-68]\d|1[01]|3[7-9]|7[02]))\d|7(?:[37-9]\d|42|56))\d{4}';
     ExampleNumber: '660234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI tollFree }
    (HasData: True;
     NationalNumberPattern: '8002[28]\d\d|80(?:05\d|9)\d{4}';
     ExampleNumber: '8002222';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI premiumRate }
    (HasData: True;
     NationalNumberPattern: '90(?:02[258]|1(?:23|3[14])|66[136])\d\d';
     ExampleNumber: '9002222';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI uan }
    (HasData: True;
     NationalNumberPattern: '870(?:28|87)\d\d';
     ExampleNumber: '8702812';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI voicemail }
    (HasData: True;
     NationalNumberPattern: '697(?:42|56|[78]\d)\d{4}';
     ExampleNumber: '697861234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { LK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:12[2-9]|602|8[12]\d|9(?:1\d|22|9[245]))\d{6}|(?:11|2[13-7]|3[1-8]|4[157]|5[12457]|6[35-7])[2-' +
       '57]\d{6}';
     ExampleNumber: '112345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { LK mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:[0-25-8]\d|4[0-4])\d{6}';
     ExampleNumber: '712345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK uan }
    (HasData: True;
     NationalNumberPattern: '1973\d{5}';
     ExampleNumber: '197312345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2457]\d|33|88)\d{7}|(?:2\d|[4-6])\d{6}';
     ExampleNumber: '';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR fixedLine }
    (HasData: True;
     NationalNumberPattern: '2\d{7}';
     ExampleNumber: '21234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:(?:22|33)0|555|7(?:6[01]|7\d)|88\d)\d|4(?:240|[67]))\d{5}|[56]\d{6}';
     ExampleNumber: '770123456';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR premiumRate }
    (HasData: True;
     NationalNumberPattern: '332(?:02|[34]\d)\d{4}';
     ExampleNumber: '332021234';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[256]\d\d|800)\d{5}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS fixedLine }
    (HasData: True;
     NationalNumberPattern: '2\d{7}';
     ExampleNumber: '22123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS mobile }
    (HasData: True;
     NationalNumberPattern: '[56]\d{7}';
     ExampleNumber: '50123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS tollFree }
    (HasData: True;
     NationalNumberPattern: '800[1256]\d{4}';
     ExampleNumber: '80021234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[3469]\d|52|[78]0)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3[1478]|4[124-6]|52)\d{6}';
     ExampleNumber: '31234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT mobile }
    (HasData: True;
     NationalNumberPattern: '6\d{7}';
     ExampleNumber: '61234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT tollFree }
    (HasData: True;
     NationalNumberPattern: '80[02]\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT premiumRate }
    (HasData: True;
     NationalNumberPattern: '9(?:0[0239]|10)\d{5}';
     ExampleNumber: '90012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT sharedCost }
    (HasData: True;
     NationalNumberPattern: '808\d{5}';
     ExampleNumber: '80812345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT personalNumber }
    (HasData: True;
     NationalNumberPattern: '70[05]\d{5}';
     ExampleNumber: '70012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT voip }
    (HasData: True;
     NationalNumberPattern: '[89]01\d{5}';
     ExampleNumber: '80123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT uan }
    (HasData: True;
     NationalNumberPattern: '70[67]\d{5}';
     ExampleNumber: '70712345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU generalDesc }
    (HasData: True;
     NationalNumberPattern: '35[013-9]\d{4,8}|6\d{8}|35\d{2,4}|(?:[2457-9]\d|3[0-46-9])\d{2,9}';
     ExampleNumber: '';
     LengthOffset: 368; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:35[013-9]|80[2-9]|90[89])\d{1,8}|(?:2[2-9]|3[0-46-9]|[457]\d|8[13-9]|9[2-579])\d{2,9}';
     ExampleNumber: '27123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU mobile }
    (HasData: True;
     NationalNumberPattern: '6(?:[26][18]|5[1568]|7[189]|81|9[128])\d{6}';
     ExampleNumber: '628123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[015]\d{5}';
     ExampleNumber: '90012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU sharedCost }
    (HasData: True;
     NationalNumberPattern: '801\d{5}';
     ExampleNumber: '80112345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU voip }
    (HasData: True;
     NationalNumberPattern: '20(?:1\d{5}|[2-689]\d{1,7})';
     ExampleNumber: '20201234';
     LengthOffset: 376; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[268]\d|78|90)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV fixedLine }
    (HasData: True;
     NationalNumberPattern: '6\d{7}';
     ExampleNumber: '63123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV mobile }
    (HasData: True;
     NationalNumberPattern: '2333[0-8]\d{3}|2(?:[0-24-9]\d\d|3(?:0[07]|[14-9]\d|2[02-9]|3[0-24-9]))\d{4}';
     ExampleNumber: '21234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{6}';
     ExampleNumber: '80123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d{6}';
     ExampleNumber: '90123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV sharedCost }
    (HasData: True;
     NationalNumberPattern: '81\d{6}';
     ExampleNumber: '81123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LV noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { LY fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:0[56]|[1-6]\d|7[124579]|8[124])|3(?:1\d|2[2356])|4(?:[17]\d|2[1-357]|5[2-4]|8[124])|5(?:[' +
       '1347]\d|2[1-469]|5[13-5]|8[1-4])|6(?:[1-479]\d|5[2-57]|8[1-5])|7(?:[13]\d|2[13-79])|8(?:[124]\d|' +
       '5[124]|84))\d{6}';
     ExampleNumber: '212345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { LY mobile }
    (HasData: True;
     NationalNumberPattern: '9[1-6]\d{7}';
     ExampleNumber: '912345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { LY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[5-8]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA fixedLine }
    (HasData: True;
     NationalNumberPattern: '5(?:(?:18|4[0679]|5[03])\d|2(?:[0-25-79]\d|3[1-578]|4[02-46-8]|8[0235-9])|3(?:[0-47]\d|5[02-9]|6' +
       '[02-8]|8[014-9]|9[3-9]))\d{5}';
     ExampleNumber: '520123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6(?:[0-79]\d|8[0-247-9])|7(?:[016-8]\d|2[0-8]|3[01]|5[0-5]))\d{6}';
     ExampleNumber: '650123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-7]\d{6}';
     ExampleNumber: '801234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA premiumRate }
    (HasData: True;
     NationalNumberPattern: '89\d{7}';
     ExampleNumber: '891234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA voip }
    (HasData: True;
     NationalNumberPattern: '(?:592(?:4[0-2]|93)|80[89]\d\d)\d{4}';
     ExampleNumber: '592401234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[3489]|[67]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:870|9[2-47-9]\d)\d{5}';
     ExampleNumber: '99123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC mobile }
    (HasData: True;
     NationalNumberPattern: '4(?:[46]\d|5[1-9])\d{5}|(?:3|[67]\d)\d{7}';
     ExampleNumber: '612345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:800|90\d)\d{5}';
     ExampleNumber: '90123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MC noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '8[07]0\d{5}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[235-7]\d|[89]0)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:2[1-9]|3[1-79])\d|5(?:33|5[257]))\d{5}';
     ExampleNumber: '22212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD mobile }
    (HasData: True;
     NationalNumberPattern: '562\d{5}|(?:6\d|7[16-9])\d{6}';
     ExampleNumber: '62112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[056]\d{5}';
     ExampleNumber: '90012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD sharedCost }
    (HasData: True;
     NationalNumberPattern: '808\d{5}';
     ExampleNumber: '80812345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD voip }
    (HasData: True;
     NationalNumberPattern: '3[08]\d{6}';
     ExampleNumber: '30123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD uan }
    (HasData: True;
     NationalNumberPattern: '803\d{5}';
     ExampleNumber: '80312345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MD noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:20|[3-79]\d)\d{6}|80\d{6,7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { ME fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:20[2-8]|3(?:[0-2][2-7]|3[24-7])|4(?:0[2-467]|1[2467])|5(?:0[2467]|1[24-7]|2[2-467]))\d{5}';
     ExampleNumber: '30234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { ME mobile }
    (HasData: True;
     NationalNumberPattern: '6(?:[07-9]\d|3[024]|6[0-25])\d{5}';
     ExampleNumber: '60123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME tollFree }
    (HasData: True;
     NationalNumberPattern: '80(?:[0-2578]|9\d)\d{5}';
     ExampleNumber: '80080002';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME premiumRate }
    (HasData: True;
     NationalNumberPattern: '9(?:4[1568]|5[178])\d{5}';
     ExampleNumber: '94515151';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME voip }
    (HasData: True;
     NationalNumberPattern: '78[1-49]\d{5}';
     ExampleNumber: '78108780';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME uan }
    (HasData: True;
     NationalNumberPattern: '77[1-9]\d{5}';
     ExampleNumber: '77273012';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ME noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF generalDesc }
    (HasData: True;
     NationalNumberPattern: '7090\d{5}|(?:[56]9|[89]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:59(?:0(?:0[079]|[14]3|[27][79]|3[03-7]|5[0-268]|87)|87\d)|80[6-9]\d\d)\d{4}';
     ExampleNumber: '590271234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF mobile }
    (HasData: True;
     NationalNumberPattern: '(?:69(?:0\d\d|1(?:2[2-9]|3[0-5]))|7090[0-4])\d{4}';
     ExampleNumber: '690001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF premiumRate }
    (HasData: True;
     NationalNumberPattern: '8[129]\d{7}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF voip }
    (HasData: True;
     NationalNumberPattern: '9(?:(?:39[5-7]|76[018])\d|475[0-6])\d{4}';
     ExampleNumber: '976012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MF noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[23]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MG fixedLine }
    (HasData: True;
     NationalNumberPattern: '2072[29]\d{4}|20(?:2\d|4[47]|5[3467]|6[279]|7[356]|8[268]|9[2457])\d{5}';
     ExampleNumber: '202123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MG mobile }
    (HasData: True;
     NationalNumberPattern: '3[2-9]\d{7}';
     ExampleNumber: '321234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG voip }
    (HasData: True;
     NationalNumberPattern: '22\d{7}';
     ExampleNumber: '221234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH generalDesc }
    (HasData: True;
     NationalNumberPattern: '329\d{4}|(?:[256]\d|45)\d{5}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:247|528|625)\d{4}';
     ExampleNumber: '2471234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:23|54)5|329|45[35-8])\d{4}';
     ExampleNumber: '2351234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH voip }
    (HasData: True;
     NationalNumberPattern: '635\d{4}';
     ExampleNumber: '6351234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-578]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { MK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:2(?:62|77)0|3444)\d|4[56]440)\d{3}|(?:34|4[357])700\d{3}|(?:2(?:[0-3]\d|5[0-578]|6[01]|82)' +
       '|3(?:1[3-68]|[23][2-68]|4[23568])|4(?:[23][2-68]|4[3-68]|5[2568]|6[25-8]|7[24-68]|8[4-68]))\d{5}';
     ExampleNumber: '22012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { MK mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:3555|(?:474|9[019]7)7)\d{3}|7(?:[0-25-8]\d\d|3(?:[1-478]\d|6[01])|4(?:2\d|60|7[01578])|9(?:[' +
       '2-4]\d|5[01]|7[015]))\d{4}';
     ExampleNumber: '72345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK premiumRate }
    (HasData: True;
     NationalNumberPattern: '5\d{7}';
     ExampleNumber: '50012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK sharedCost }
    (HasData: True;
     NationalNumberPattern: '8(?:0[1-9]|[1-9]\d)\d{5}';
     ExampleNumber: '80123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML generalDesc }
    (HasData: True;
     NationalNumberPattern: '[24-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:07[0-8]|12[67])\d{4}|(?:2(?:02|1[4-689])|4(?:0[0-4]|4[1-69]))\d{5}';
     ExampleNumber: '20212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML mobile }
    (HasData: True;
     NationalNumberPattern: '2(?:0(?:01|79)|17\d)\d{4}|(?:5[0-3]|[679]\d|8[2-59])\d{6}';
     ExampleNumber: '65012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{6}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ML noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '80\d{6}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{5,7}|95\d{6}|(?:[4-7]|9[0-46-9])\d{6,8}|(?:2|8\d)\d{5,8}';
     ExampleNumber: '';
     LengthOffset: 95; LengthCount: 5;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { MM fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:(?:12|[28]\d|3[56]|7[3-6]|9[0-6])\d|4(?:2[29]|7[0-2]|83)|6)|2(?:2(?:00|8[34])|4(?:0\d|22|' +
       '7[0-2]|83)|51\d\d)|4(?:2(?:2\d\d|48[013])|3(?:20\d|4(?:70|83)|56)|420\d|5(?:2\d|470))|6(?:0(?:[2' +
       '3]|88\d)|(?:124|[56]2\d)\d|2472|3(?:20\d|470)|4(?:2[04]\d|472)|7(?:3\d\d|4[67]0|8(?:[01459]\d|8)' +
       ')))\d{4}|5(?:2(?:2\d{5,6}|47[02]\d{4})|(?:3472|4(?:2(?:1|86)|470)|522\d|6(?:20\d|483)|7(?:20\d|4' +
       '8[01])|8(?:20\d|47[02])|9(?:20\d|470))\d{4})|7(?:(?:0470|4(?:25\d|470)|5(?:202|470|96\d))\d{4}|1' +
       '(?:20\d{4,5}|4(?:70|83)\d{4}))|8(?:1(?:2\d{5,6}|4(?:10|7[01]\d)\d{3})|2(?:2\d{5,6}|(?:320|490\d)' +
       '\d{3})|(?:3(?:2\d\d|470)|4[24-7]|5(?:(?:2\d|51)\d|4(?:[1-35-9]\d|4[0-57-9]))|6[23])\d{4})|(?:1[2' +
       '-6]\d|4(?:2[24-8]|3[2-7]|[46][2-6]|5[3-5])|5(?:[27][2-8]|3[2-68]|4[24-8]|5[23]|6[2-4]|8[24-7]|9[' +
       '2-7])|6(?:[19]20|42[03-6]|(?:52|7[45])\d)|7(?:[04][24-8]|[15][2-7]|22|3[2-4])|8(?:1[2-689]|2[2-8' +
       ']|(?:[35]2|64)\d))\d{4}|25\d{5,6}|(?:2[2-9]|6(?:1[2356]|[24][2-6]|3[24-6]|5[2-4]|6[2-8]|7[235-7]' +
       '|8[245]|9[24])|8(?:3[24]|5[245]))\d{4}';
     ExampleNumber: '1234567';
     LengthOffset: 22; LengthCount: 4;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { MM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:17[01]|9(?:2(?:[0-4]|[56]\d\d)|(?:3(?:[0-36]|4\d)|(?:6\d|8[89]|9[4-8])\d|7(?:3|40|[5-9]\d))\d' +
       '|4(?:(?:[0245]\d|[1379])\d|88)|5[0-6])\d)\d{4}|9[69]1\d{6}|9(?:[68]\d|9[089])\d{5}';
     ExampleNumber: '92123456';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM tollFree }
    (HasData: True;
     NationalNumberPattern: '80080(?:0[1-9]|2\d)\d{3}';
     ExampleNumber: '8008001234';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM voip }
    (HasData: True;
     NationalNumberPattern: '1333\d{4}';
     ExampleNumber: '13331234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12]\d{7,9}|[5-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 383; LocalOnlyCount: 3),
    { MN fixedLine }
    (HasData: True;
     NationalNumberPattern: '[12](?:2[1-3]|(?:3[2-8]|4[2-68]|5[1-4689])\d)\d{5,6}|7(?:0(?:[0-5]\d|7[078]|80)|128)\d{4}|[12]27' +
       '\d{6}|(?:11|2[16]|5[368])\d{6}';
     ExampleNumber: '53123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 383; LocalOnlyCount: 3),
    { MN mobile }
    (HasData: True;
     NationalNumberPattern: '(?:87[01]|92[0139])\d{5}|(?:5[05]|6[069]|7[28]|8[0135689]|9[013-9])\d{6}';
     ExampleNumber: '88123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN voip }
    (HasData: True;
     NationalNumberPattern: '712[0-79]\d{4}|7(?:1[013-9]|[5-79]\d)\d{5}';
     ExampleNumber: '75123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MN noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO generalDesc }
    (HasData: True;
     NationalNumberPattern: '0800\d{3}|(?:28|[68]\d)\d{6}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:28[2-9]|8(?:11|[2-57-9]\d))\d{5}';
     ExampleNumber: '28212345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO mobile }
    (HasData: True;
     NationalNumberPattern: '6800[0-79]\d{3}|6(?:[235]\d\d|6(?:0[0-5]|[1-9]\d)|8(?:0[1-9]|[14-8]\d|2[5-9]|[39][0-4]))\d{4}';
     ExampleNumber: '66123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO tollFree }
    (HasData: True;
     NationalNumberPattern: '0800\d{3}';
     ExampleNumber: '0800501';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP generalDesc }
    (HasData: True;
     NationalNumberPattern: '[58]\d{9}|(?:67|90)0\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MP fixedLine }
    (HasData: True;
     NationalNumberPattern: '670(?:2(?:3[3-7]|56|8[4-8])|32[1-38]|4(?:33|8[348])|5(?:32|55|88)|6(?:64|70|82)|78[3589]|8[3-9]8' +
       '|989)\d{4}';
     ExampleNumber: '6702345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MP mobile }
    (HasData: True;
     NationalNumberPattern: '670(?:2(?:3[3-7]|56|8[4-8])|32[1-38]|4(?:33|8[348])|5(?:32|55|88)|6(?:64|70|82)|78[3589]|8[3-9]8' +
       '|989)\d{4}';
     ExampleNumber: '6702345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MP tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MP noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ generalDesc }
    (HasData: True;
     NationalNumberPattern: '7091\d{5}|(?:[56]9|[89]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:59(?:6(?:[03-7]\d|1[05]|2[7-9]|8[0-39]|9[04-9])|89\d)|80[6-9]\d\d|9(?:477[6-9]|767[4589]))\d{' +
       '4}';
     ExampleNumber: '596301234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ mobile }
    (HasData: True;
     NationalNumberPattern: '(?:69[67]\d\d|7091[0-3])\d{4}';
     ExampleNumber: '696201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ premiumRate }
    (HasData: True;
     NationalNumberPattern: '8[129]\d{7}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ voip }
    (HasData: True;
     NationalNumberPattern: '9(?:397[0-3]|477[0-5]|76(?:6\d|7[0-367]))\d{4}';
     ExampleNumber: '976612345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MQ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-4]\d\d|800)\d{5}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:25[08]|35\d|45[1-7])\d{5}';
     ExampleNumber: '35123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR mobile }
    (HasData: True;
     NationalNumberPattern: '[2-4][0-46-9]\d{6}';
     ExampleNumber: '22123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|664|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MS fixedLine }
    (HasData: True;
     NationalNumberPattern: '6644(?:1[0-3]|91)\d{4}';
     ExampleNumber: '6644912345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MS mobile }
    (HasData: True;
     NationalNumberPattern: '664(?:3(?:49|9[1-6])|49[2-6])\d{4}';
     ExampleNumber: '6644923456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { MS tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT generalDesc }
    (HasData: True;
     NationalNumberPattern: '3550\d{4}|(?:[2579]\d\d|800)\d{5}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT fixedLine }
    (HasData: True;
     NationalNumberPattern: '20(?:3[1-4]|6[059])\d{4}|2(?:0[19]|[1-357]\d|60)\d{5}';
     ExampleNumber: '21001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT mobile }
    (HasData: True;
     NationalNumberPattern: '(?:7(?:210|[79]\d\d)|9(?:[29]\d\d|69[67]|8(?:1[1-3]|89|97)))\d{4}';
     ExampleNumber: '96961234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT tollFree }
    (HasData: True;
     NationalNumberPattern: '800(?:02|[3467]\d)\d{3}';
     ExampleNumber: '80071234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT premiumRate }
    (HasData: True;
     NationalNumberPattern: '5(?:0(?:0(?:37|43)|(?:6\d|70|9[0168])\d)|[12]\d0[1-5])\d{3}';
     ExampleNumber: '50037123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT voip }
    (HasData: True;
     NationalNumberPattern: '3550\d{4}';
     ExampleNumber: '35501234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT pager }
    (HasData: True;
     NationalNumberPattern: '7117\d{4}';
     ExampleNumber: '71171234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT uan }
    (HasData: True;
     NationalNumberPattern: '501\d{5}';
     ExampleNumber: '50112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[57]|8\d\d)\d{7}|[2-468]\d{6}';
     ExampleNumber: '';
     LengthOffset: 127; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:[0346-8]\d|1[0-8])|4(?:[013568]\d|2[0-24-8]|71|90)|54(?:[3-5]\d|71)|6\d\d|8(?:14|3[129]))' +
       '\d{4}';
     ExampleNumber: '54480123';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU mobile }
    (HasData: True;
     NationalNumberPattern: '5(?:4(?:2[1-389]|7[1-9])|87[15-8])\d{4}|(?:5(?:2[5-9]|4[3-689]|[57]\d|8[0-689]|9[0-8])|7(?:0[0-7' +
       ']|3[013]))\d{5}';
     ExampleNumber: '52512345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU tollFree }
    (HasData: True;
     NationalNumberPattern: '802\d{7}|80[0-2]\d{4}';
     ExampleNumber: '8001234';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU premiumRate }
    (HasData: True;
     NationalNumberPattern: '30\d{5}';
     ExampleNumber: '3012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU voip }
    (HasData: True;
     NationalNumberPattern: '3(?:20|9\d)\d{4}';
     ExampleNumber: '3201234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU pager }
    (HasData: True;
     NationalNumberPattern: '219\d{4}';
     ExampleNumber: '2190123';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:800|9[0-57-9]\d)\d{7}|[34679]\d{6}';
     ExampleNumber: '';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3(?:0[0-4]|3[0-59])|6(?:[58][024689]|6[024-68]|7[02468]))\d{4}';
     ExampleNumber: '6701234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV mobile }
    (HasData: True;
     NationalNumberPattern: '(?:46[46]|[79]\d\d)\d{4}';
     ExampleNumber: '7712345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV uan }
    (HasData: True;
     NationalNumberPattern: '4(?:0[01]|50)\d{4}';
     ExampleNumber: '4001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MV noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[1289]\d|31|77)\d{7}|1\d{6}';
     ExampleNumber: '';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW fixedLine }
    (HasData: True;
     NationalNumberPattern: '1[2-9]\d{5}';
     ExampleNumber: '1234567';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW mobile }
    (HasData: True;
     NationalNumberPattern: '111\d{6}|(?:2[12]|31|77|[89][89])\d{7}';
     ExampleNumber: '991234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{9}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 125; LocalOnlyCount: 2),
    { MX fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:0[01]|2\d|3[1-35-8]|4[13-9]|7[1-689]|8[1-578]|9[467])|3(?:1[1-79]|[2458][1-9]|3\d|7[1-8]|' +
       '9[1-5])|4(?:1[1-57-9]|[267][1-9]|3[1-8]|[45]\d|8[1-35-9]|9[2-689])|5(?:[56]\d|88|9[1-79])|6(?:1[' +
       '2-68]|[2-4][1-9]|5[1-36-9]|6[0-57-9]|7[1-7]|8[67]|9[4-8])|7(?:[1346][1-9]|[27]\d|5[13-9]|8[1-69]' +
       '|9[17])|8(?:1\d|2[13-689]|3[1-6]|4[124-6]|6[1246-9]|7[0-378]|9[12479])|9(?:1[346-9]|2[1-4]|3[2-4' +
       '6-8]|5[1348]|[69]\d|7[12]|8[1-8]))\d{7}';
     ExampleNumber: '2001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 125; LocalOnlyCount: 2),
    { MX mobile }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:2\d|3[1-35-8]|4[13-9]|7[1-689]|8[1-578]|9[467])|3(?:1[1-79]|[2458][1-9]|3\d|7[1-8]|9[1-5]' +
       ')|4(?:1[1-57-9]|[267][1-9]|3[1-8]|[45]\d|8[1-35-9]|9[2-689])|5(?:[56]\d|88|9[1-79])|6(?:1[2-68]|' +
       '[2-4][1-9]|5[1-36-9]|6[0-57-9]|7[1-7]|8[67]|9[4-8])|7(?:[1346][1-9]|[27]\d|5[13-9]|8[1-69]|9[17]' +
       ')|8(?:1\d|2[13-689]|3[1-6]|4[124-6]|6[1246-9]|7[0-378]|9[12479])|9(?:1[346-9]|2[1-4]|3[2-46-8]|5' +
       '[1348]|[69]\d|7[12]|8[1-8]))\d{7}';
     ExampleNumber: '2221234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 125; LocalOnlyCount: 2),
    { MX tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|88)\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX sharedCost }
    (HasData: True;
     NationalNumberPattern: '300\d{7}';
     ExampleNumber: '3001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX personalNumber }
    (HasData: True;
     NationalNumberPattern: '500\d{7}';
     ExampleNumber: '5001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MX noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY generalDesc }
    (HasData: True;
     NationalNumberPattern: '1\d{8,9}|(?:3\d|[4-9])\d{7}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { MY fixedLine }
    (HasData: True;
     NationalNumberPattern: '427[01]\d{4}|(?:3(?:2[0-36-9]|3[0-368]|4[0-278]|5[0-24-8]|6[0-467]|7[1246-9]|8\d|9[0-57])\d|4(?:' +
       '2[0-689]|[3-79]\d|8[1-35689])|5(?:2[0-589]|[3468]\d|5[0-489]|7[1-9]|9[23])|6(?:2[2-9]|3[1357-9]|' +
       '[46]\d|5[0-6]|7[0-35-9]|85|9[015-8])|7(?:[2579]\d|3[03-68]|4[0-8]|6[5-9]|8[0-35-9])|8(?:[24][2-8' +
       ']|3[2-5]|5[2-7]|6[2-589]|7[2-578]|[89][2-9])|9(?:0[57]|13|[25-7]\d|[3489][0-8]))\d{5}';
     ExampleNumber: '323856789';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { MY mobile }
    (HasData: True;
     NationalNumberPattern: '1(?:(?:1888[689]|4400|8(?:47|8[27])[0-4])\d{4}|9\d{7,8})|1(?:0(?:[23568]\d|4[0-6]|7[016-9]|9[0-8' +
       '])|1(?:[1-5]\d\d|6(?:0[5-9]|[1-9]\d)|7(?:[0-4]\d|5[0-79]|6[02-4]|8[02-5]))|(?:[26]\d|[37][1-9]|4' +
       '[235-9])\d|5(?:31|9\d\d)|8(?:1[23]|[236]\d|4[06]|5(?:46|[7-9])|7[016-9]|8[01]|9[0-8]))\d{5}';
     ExampleNumber: '123456789';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY tollFree }
    (HasData: True;
     NationalNumberPattern: '1[378]00\d{6}';
     ExampleNumber: '1300123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY premiumRate }
    (HasData: True;
     NationalNumberPattern: '1600\d{6}';
     ExampleNumber: '1600123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY voip }
    (HasData: True;
     NationalNumberPattern: '15(?:4(?:6[0-4]\d|8(?:0[125]|[17]\d|21|3[01]|4[01589]|5[014]|6[02]))|6(?:32[0-6]|78\d))\d{4}';
     ExampleNumber: '1546012345';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:2|8\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:[1346]\d|5[0-2]|[78][12]|93)\d{5}';
     ExampleNumber: '21123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ mobile }
    (HasData: True;
     NationalNumberPattern: '8[2-9]\d{7}';
     ExampleNumber: '821234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { MZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[68]\d{7,8}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA fixedLine }
    (HasData: True;
     NationalNumberPattern: '64426\d{3}|6(?:1(?:2[2-7]|3[01378]|4[0-4])|254|32[0237]|4(?:27|41|5[25])|52[236-8]|626|7(?:2[2-4' +
       ']|30))\d{4,5}|6(?:1(?:(?:0\d|2[0189]|3[24-69]|4[5-9])\d|17|69|7[014])|2(?:17|5[0-36-8]|69|70)|3(' +
       '?:17|2[14-689]|34|6[289]|7[01]|81)|4(?:17|2[0-2]|4[06]|5[0137]|69|7[01])|5(?:17|2[0459]|69|7[01]' +
       ')|6(?:17|25|38|42|69|7[01])|7(?:17|2[569]|3[13]|6[89]|7[01]))\d{4}';
     ExampleNumber: '61221234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA mobile }
    (HasData: True;
     NationalNumberPattern: '(?:60|8[1245])\d{7}';
     ExampleNumber: '811234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{7}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA premiumRate }
    (HasData: True;
     NationalNumberPattern: '8701\d{5}';
     ExampleNumber: '870123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA voip }
    (HasData: True;
     NationalNumberPattern: '8(?:3\d\d|86)\d{5}';
     ExampleNumber: '88612345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:050|[2-57-9]\d\d)\d{3}';
     ExampleNumber: '';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[03-9]|3[0-5]|4[1-7]|88)\d{4}';
     ExampleNumber: '201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[579]\d|8[0-79])\d{4}';
     ExampleNumber: '751234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC tollFree }
    (HasData: True;
     NationalNumberPattern: '050\d{3}';
     ExampleNumber: '050012';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC premiumRate }
    (HasData: True;
     NationalNumberPattern: '36\d{4}';
     ExampleNumber: '366711';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[027-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:0(?:20|3[1-8]|4[13-5]|5[14]|6[14578]|7[1-578])|1(?:4[145]|5[14]|6[14-68]|7[169]|88))\d{4}';
     ExampleNumber: '20201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE mobile }
    (HasData: True;
     NationalNumberPattern: '(?:23|7[0467]|[89]\d)\d{6}';
     ExampleNumber: '93123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE tollFree }
    (HasData: True;
     NationalNumberPattern: '08\d{6}';
     ExampleNumber: '08123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE premiumRate }
    (HasData: True;
     NationalNumberPattern: '09\d{6}';
     ExampleNumber: '09123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d{5}';
     ExampleNumber: '';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { NF fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:06|17|28|39)|3[0-2]\d)\d{3}';
     ExampleNumber: '106609';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { NF mobile }
    (HasData: True;
     NationalNumberPattern: '(?:14|3[58])\d{4}';
     ExampleNumber: '381234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { NF tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NF noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:20|9\d)\d{8}|[78]\d{9,13}';
     ExampleNumber: '';
     LengthOffset: 386; LengthCount: 5;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { NG fixedLine }
    (HasData: True;
     NationalNumberPattern: '20(?:[1259]\d|3[013-9]|4[1-8]|6[024-689]|7[1-79]|8[2-9])\d{6}';
     ExampleNumber: '2033123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { NG mobile }
    (HasData: True;
     NationalNumberPattern: '(?:702[0-24-9]|819[01])\d{6}|(?:7(?:0[13-9]|[12]\d)|8(?:0[1-9]|1[0-8])|9(?:0[1-9]|1[0-6]))\d{7}';
     ExampleNumber: '8021234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7,11}';
     ExampleNumber: '80017591759';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG uan }
    (HasData: True;
     NationalNumberPattern: '700\d{7,11}';
     ExampleNumber: '7001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1800|[25-8]\d{3})\d{4}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI fixedLine }
    (HasData: True;
     NationalNumberPattern: '2\d{7}';
     ExampleNumber: '21234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI mobile }
    (HasData: True;
     NationalNumberPattern: '(?:5(?:5[0-7]|[78]\d)|6(?:20|3[035]|4[045]|5[05]|77|8[1-9]|9[059])|(?:7[5-8]|8\d)\d)\d{5}';
     ExampleNumber: '81234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{4}';
     ExampleNumber: '18001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[124-7]\d\d|3(?:[02-9]\d|1[0-8]))\d{6}|8\d{6,9}|9\d{6,10}|1\d{4,5}';
     ExampleNumber: '';
     LengthOffset: 391; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:[035]\d|1[13-578]|6[124-8]|7[24]|8[0-467])|2(?:[0346]\d|2[2-46-9]|5[125]|9[479])|3(?:[035' +
       '68]\d|1[3-8]|2[01]|4[1-8])|4(?:[0356]\d|1[1-368]|7[58]|8[15-8]|9[23579])|5(?:[0358]\d|[19][1-9]|' +
       '2[1-57-9]|4[13-8]|6[126]|7[0-3578])|7\d\d)\d{6}';
     ExampleNumber: '101234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6[1-58]|970\d)\d{7}';
     ExampleNumber: '612345678';
     LengthOffset: 157; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4,7}';
     ExampleNumber: '8001234';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[069]\d{4,7}';
     ExampleNumber: '9061234';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL voip }
    (HasData: True;
     NationalNumberPattern: '(?:85|91)\d{7}';
     ExampleNumber: '851234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL pager }
    (HasData: True;
     NationalNumberPattern: '66\d{7}';
     ExampleNumber: '662345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL uan }
    (HasData: True;
     NationalNumberPattern: '140(?:1[035]|2[0346]|3[03568]|4[0356]|5[0358]|8[458])|(?:140(?:1[16-8]|2[259]|3[124]|4[17-9]|5[1' +
       '24679]|7)|8[478]\d{6})\d';
     ExampleNumber: '14020';
     LengthOffset: 398; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NL noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '140(?:1[035]|2[0346]|3[03568]|4[0356]|5[0358]|8[458])|140(?:1[16-8]|2[259]|3[124]|4[17-9]|5[1246' +
       '79]|7)\d';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:0|[2-9]\d{3})\d{4}';
     ExampleNumber: '';
     LengthOffset: 337; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[1-4]|3[1-3578]|5[1-35-7]|6[1-46-9]|7[0-8])\d{6}';
     ExampleNumber: '21234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO mobile }
    (HasData: True;
     NationalNumberPattern: '45(?:[0-24-9]\d|3[0-57-9])\d{4}|(?:4[016-8]|9\d)\d{6}';
     ExampleNumber: '40612345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO tollFree }
    (HasData: True;
     NationalNumberPattern: '80[01]\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO premiumRate }
    (HasData: True;
     NationalNumberPattern: '82[09]\d{5}';
     ExampleNumber: '82012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO sharedCost }
    (HasData: True;
     NationalNumberPattern: '810(?:0[0-6]|[2-8]\d)\d{3}';
     ExampleNumber: '81021234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO personalNumber }
    (HasData: True;
     NationalNumberPattern: '880\d{5}';
     ExampleNumber: '88012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO voip }
    (HasData: True;
     NationalNumberPattern: '85[0-5]\d{5}';
     ExampleNumber: '85012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO uan }
    (HasData: True;
     NationalNumberPattern: '(?:0[235-9]|81(?:0(?:0[7-9]|1\d)|5\d\d))\d{3}';
     ExampleNumber: '02000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO voicemail }
    (HasData: True;
     NationalNumberPattern: '81[23]\d{5}';
     ExampleNumber: '81212345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1\d|9)\d{9}|[1-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 175; LengthCount: 3;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { NP fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1[0-6]\d|99[02-6])\d{5}|(?:2[13-79]|3[135-8]|4[146-9]|5[135-7]|6[13-9]|7[15-9]|8[1-46-9]|9[1-' +
       '7])[2-6]\d{5}';
     ExampleNumber: '14567890';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { NP mobile }
    (HasData: True;
     NationalNumberPattern: '9(?:00|6[0-3]|7[0-24-6]|8[0-24-68])\d{7}';
     ExampleNumber: '9841234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP tollFree }
    (HasData: True;
     NationalNumberPattern: '1(?:66001|800\d\d)\d{5}';
     ExampleNumber: '16600101234';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NP noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:222|444|(?:55|8\d)\d|666|777|999)\d{4}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR fixedLine }
    (HasData: True;
     NationalNumberPattern: '444\d{4}';
     ExampleNumber: '4441234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR mobile }
    (HasData: True;
     NationalNumberPattern: '(?:222|55[3-9]|666|777|8\d\d|999)\d{4}';
     ExampleNumber: '5551234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[4-7]|888\d)\d{3}';
     ExampleNumber: '';
     LengthOffset: 178; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU fixedLine }
    (HasData: True;
     NationalNumberPattern: '[47]\d{3}';
     ExampleNumber: '7012';
     LengthOffset: 339; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[56]|888[1-9])\d{3}';
     ExampleNumber: '8884012';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1289]\d{9}|50\d{5}(?:\d{2,3})?|[27-9]\d{7,8}|(?:[34]\d|6[0-35-9])\d{6}|8\d{4,6}';
     ExampleNumber: '';
     LengthOffset: 401; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '240\d{5}|(?:3[2-79]|[49][2-9]|6[235-9]|7[2-57-9])\d{6}';
     ExampleNumber: '32345678';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { NZ mobile }
    (HasData: True;
     NationalNumberPattern: '2(?:[0-27-9]\d|6)\d{6,7}|2(?:1\d|75)\d{5}';
     ExampleNumber: '211234567';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ tollFree }
    (HasData: True;
     NationalNumberPattern: '508\d{6,7}|80\d{6,8}';
     ExampleNumber: '800123456';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:1[13-57-9]\d{5}|50(?:0[08]|30|66|77|88))\d{3}|90\d{6,8}';
     ExampleNumber: '900123456';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{7}';
     ExampleNumber: '701234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ uan }
    (HasData: True;
     NationalNumberPattern: '8(?:1[16-9]|22|3\d|4[045]|5[459]|6[235-9]|7[0-3579]|90)\d{2,7}';
     ExampleNumber: '83012378';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { NZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1505|[279]\d{3}|500)\d{4}|800\d{5,6}';
     ExampleNumber: '';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM fixedLine }
    (HasData: True;
     NationalNumberPattern: '2[1-6]\d{6}';
     ExampleNumber: '23123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:1505|90[1-9]\d)\d{4}|(?:7[124-9]|9[1-9])\d{6}';
     ExampleNumber: '92123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM tollFree }
    (HasData: True;
     NationalNumberPattern: '8007\d{4,5}|(?:500|800[05])\d{4}';
     ExampleNumber: '80071234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{5}';
     ExampleNumber: '90012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { OM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:00800|8\d{3})\d{6}|[68]\d{7}|[1-57-9]\d{6}';
     ExampleNumber: '';
     LengthOffset: 407; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:0\d|1[0479]|2[37]|3[0137]|4[147]|5[05]|6[058]|7[0167]|8[2358]|9[1389])|2(?:[0235-79]\d|1[' +
       '0-7]|4[013-9]|8[02-9])|3(?:[0147-9]\d|[25][0-5]|33|6[068])|4(?:00|3[0-579]|4\d|7[0-57-9])|5(?:[0' +
       '1]\d|2[0-7]|[56]0|79)|7(?:0[09]|2[0-26-8]|3[03]|4[04]|5[05-9]|6[0156]|7[0-24-9]|8[4-9]|90)|8(?:0' +
       '9|2[89]|3\d|4[0-24-689]|5[014]|8[02])|9(?:0[5-9]|1[0-35-8]|2[036-9]|3[35-79]|40|5[0457-9]|6[05-9' +
       ']|7[04-9]|8[235-8]|9\d))\d{4}';
     ExampleNumber: '2001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA mobile }
    (HasData: True;
     NationalNumberPattern: '(?:1[16]1|21[89]|6\d{3}|8(?:1[01]|7[23]))\d{4}';
     ExampleNumber: '61234567';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4,5}|(?:00800|800\d)\d{6}';
     ExampleNumber: '8001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:8(?:22|55|60|7[78]|86)|9(?:00|81))\d{4}';
     ExampleNumber: '8601234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[14-8]|9\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { PE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:19[02-68]|(?:4[34]|5[14])[0-8]|687)\d|7(?:173|(?:3[0-8]|55)\d)|8(?:10[05689]|6(?:0[06-9]|1' +
       '[6-9]|29)|7(?:0[0569]|[56]0)))\d{4}|(?:1[0-8]|4[12]|5[236]|6[1-7]|7[246]|8[2-4])\d{6}';
     ExampleNumber: '11234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { PE mobile }
    (HasData: True;
     NationalNumberPattern: '9\d{8}';
     ExampleNumber: '912345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE premiumRate }
    (HasData: True;
     NationalNumberPattern: '805\d{5}';
     ExampleNumber: '80512345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE sharedCost }
    (HasData: True;
     NationalNumberPattern: '801\d{5}';
     ExampleNumber: '80112345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE personalNumber }
    (HasData: True;
     NationalNumberPattern: '80[24]\d{5}';
     ExampleNumber: '80212345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF generalDesc }
    (HasData: True;
     NationalNumberPattern: '4\d{5}(?:\d{2})?|8\d{7,8}';
     ExampleNumber: '';
     LengthOffset: 5; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF fixedLine }
    (HasData: True;
     NationalNumberPattern: '4(?:0[4-689]|9[4-68])\d{5}';
     ExampleNumber: '40412345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF mobile }
    (HasData: True;
     NationalNumberPattern: '8[7-9]\d{6}';
     ExampleNumber: '87123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF voip }
    (HasData: True;
     NationalNumberPattern: '499\d{5}';
     ExampleNumber: '49901234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF uan }
    (HasData: True;
     NationalNumberPattern: '44\d{4}';
     ExampleNumber: '440123';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PF noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '44\d{4}';
     ExampleNumber: '';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:180|[78]\d{3})\d{4}|(?:[2-589]\d|64)\d{5}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:3[0-2]|4[257]|5[34]|9[78])\d|64[1-9]|85[02-46-9])\d{4}';
     ExampleNumber: '3123456';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG mobile }
    (HasData: True;
     NationalNumberPattern: '(?:7\d|8[1-58])\d{6}';
     ExampleNumber: '70123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG tollFree }
    (HasData: True;
     NationalNumberPattern: '180\d{4}';
     ExampleNumber: '1801234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG voip }
    (HasData: True;
     NationalNumberPattern: '2(?:0[0-57]|7[568])\d{4}';
     ExampleNumber: '2751234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG pager }
    (HasData: True;
     NationalNumberPattern: '27[01]\d{4}';
     ExampleNumber: '2700123';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-7]|9\d)\d{8}|2\d{5}|(?:1800|8)\d{7,9}';
     ExampleNumber: '';
     LengthOffset: 411; LengthCount: 7;
     LocalOnlyOffset: 418; LocalOnlyCount: 3),
    { PH fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:2[3-8]|3[2-68]|4[2-9]|5[2-6]|6[2-58]|7[24578])\d{3}|88(?:22\d\d|42))\d{4}|(?:2|8[2-8]\d\d)' +
       '\d{5}';
     ExampleNumber: '232345678';
     LengthOffset: 333; LengthCount: 4;
     LocalOnlyOffset: 418; LocalOnlyCount: 3),
    { PH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:8(?:1[37]|9[5-8])|9(?:0[5-9]|1[0-24-9]|[235-7]\d|4[2-9]|8[135-9]|9[1-9]))\d{7}';
     ExampleNumber: '9051234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{7,9}';
     ExampleNumber: '180012345678';
     LengthOffset: 421; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK generalDesc }
    (HasData: True;
     NationalNumberPattern: '122\d{6}|[24-8]\d{10,11}|9(?:[013-9]\d{8,10}|2(?:[01]\d\d|2(?:[06-8]\d|1[01]))\d{7})|(?:[2-8]\d{' +
       '3}|92(?:[0-7]\d|8[1-9]))\d{6}|[24-9]\d{8}|[89]\d{7}';
     ExampleNumber: '';
     LengthOffset: 424; LengthCount: 5;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { PK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:21|42)[2-9]|58[126])\d{7}|(?:2[25]|4[0146-9]|5[1-35-7]|6[1-8]|7[14]|8[16]|91)[2-9]\d{6,7}|' +
       '(?:2(?:3[2358]|4[2-4]|9[2-8])|45[3479]|54[2-467]|60[468]|72[236]|8(?:2[2-689]|3[23578]|4[3478]|5' +
       '[2356])|9(?:2[2-8]|3[27-9]|4[2-6]|6[3569]|9[25-8]))[2-9]\d{5,6}';
     ExampleNumber: '2123456789';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 429; LocalOnlyCount: 4),
    { PK mobile }
    (HasData: True;
     NationalNumberPattern: '3(?:[0-247]\d|3[0-79]|55|64)\d{7}';
     ExampleNumber: '3012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}(?:\d{3})?';
     ExampleNumber: '80012345';
     LengthOffset: 264; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{5}';
     ExampleNumber: '90012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK personalNumber }
    (HasData: True;
     NationalNumberPattern: '122\d{6}';
     ExampleNumber: '122044444';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK uan }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:[125]|3[2358]|4[2-4]|9[2-8])|4(?:[0-246-9]|5[3479])|5(?:[1-35-7]|4[2-467])|6(?:0[468]|[1-' +
       '8])|7(?:[14]|2[236])|8(?:[16]|2[2-689]|3[23578]|4[3478]|5[2356])|9(?:1|22|3[27-9]|4[2-6]|6[3569]' +
       '|9[2-7]))111\d{6}';
     ExampleNumber: '21111825888';
     LengthOffset: 309; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:6|8\d\d)\d{7}|[1-9]\d{6}(?:\d{2})?|[26]\d{5}';
     ExampleNumber: '';
     LengthOffset: 95; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:30|47\d\d)\d{5}|(?:1[2-8]|2[2-69]|3[2-4]|4[1-468]|5[24-689]|6[1-3578]|7[14-7]|8[1-79]|9[145])' +
       '(?:[02-9]\d{6}|1(?:[0-8]\d{5}|9\d{3}(?:\d{2})?))';
     ExampleNumber: '123456789';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL mobile }
    (HasData: True;
     NationalNumberPattern: '21(?:1[013-5]|2\d|3[1-9])\d{5}|(?:45|5[0137]|6[069]|7[2389]|88)\d{7}';
     ExampleNumber: '512345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6,7}';
     ExampleNumber: '800123456';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL premiumRate }
    (HasData: True;
     NationalNumberPattern: '70[01346-8]\d{6}';
     ExampleNumber: '701234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL sharedCost }
    (HasData: True;
     NationalNumberPattern: '801\d{6}';
     ExampleNumber: '801234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL voip }
    (HasData: True;
     NationalNumberPattern: '39\d{7}';
     ExampleNumber: '391234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL pager }
    (HasData: True;
     NationalNumberPattern: '64\d{4,7}';
     ExampleNumber: '641234567';
     LengthOffset: 22; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL uan }
    (HasData: True;
     NationalNumberPattern: '804\d{6}';
     ExampleNumber: '804123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PL noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[78]\d{8}|[2-9]\d{5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM fixedLine }
    (HasData: True;
     NationalNumberPattern: '80[6-9]\d{6}|(?:[236-9]\d|4[1-35-9]|5[0-47-9])\d{4}';
     ExampleNumber: '430123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM mobile }
    (HasData: True;
     NationalNumberPattern: '708(?:4[0-5]|5[0-6])\d{4}|(?:[236-9]\d|4[02-489]|5[02-9])\d{4}';
     ExampleNumber: '551234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM premiumRate }
    (HasData: True;
     NationalNumberPattern: '8[129]\d{7}';
     ExampleNumber: '810123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[589]\d\d|787)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { PR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:787|939)[2-9]\d{6}';
     ExampleNumber: '7872345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { PR mobile }
    (HasData: True;
     NationalNumberPattern: '(?:787|939)[2-9]\d{6}';
     ExampleNumber: '7872345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { PR tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2489]2\d{6}|(?:1\d|5)\d{8}';
     ExampleNumber: '';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { PS fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:22[2-47-9]|42[45]|82[014-68]|92[3569])\d{5}';
     ExampleNumber: '22234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { PS mobile }
    (HasData: True;
     NationalNumberPattern: '5[69]\d{7}';
     ExampleNumber: '599123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{6}';
     ExampleNumber: '1800123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS sharedCost }
    (HasData: True;
     NationalNumberPattern: '1700\d{6}';
     ExampleNumber: '1700123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT generalDesc }
    (HasData: True;
     NationalNumberPattern: '1693\d{5}|(?:[26-9]\d|30)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:[12]\d|3[1-689]|4[1-59]|[57][1-9]|6[1-35689]|8[1-69]|9[1256])\d{6}';
     ExampleNumber: '212345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT mobile }
    (HasData: True;
     NationalNumberPattern: '6(?:[06]92(?:30|9\d)|[35]92(?:[049]\d|3[034]))\d{3}|(?:(?:16|6[0356])93|9(?:[1-36]\d\d|480))\d{5' +
       '}';
     ExampleNumber: '912345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT tollFree }
    (HasData: True;
     NationalNumberPattern: '80[02]\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:6(?:0[178]|4[68])\d|76(?:0[1-57]|1[2-47]|2[1-37]))\d{5}';
     ExampleNumber: '760123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT sharedCost }
    (HasData: True;
     NationalNumberPattern: '80(?:8\d|9[1579])\d{5}';
     ExampleNumber: '808123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT personalNumber }
    (HasData: True;
     NationalNumberPattern: '884[0-4689]\d{5}';
     ExampleNumber: '884123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT voip }
    (HasData: True;
     NationalNumberPattern: '30\d{7}';
     ExampleNumber: '301234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT pager }
    (HasData: True;
     NationalNumberPattern: '6(?:222\d|89(?:00|88|99))\d{4}';
     ExampleNumber: '622212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT uan }
    (HasData: True;
     NationalNumberPattern: '70(?:38[01]|596|(?:7\d|8[17])\d)\d{4}';
     ExampleNumber: '707123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT voicemail }
    (HasData: True;
     NationalNumberPattern: '600\d{6}|6[06]92(?:0\d|3[349]|49)\d{3}';
     ExampleNumber: '600110000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[24-8]\d\d|345|900)\d{4}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:55|77)|345|488|5(?:35|44|87)|6(?:22|54|79)|7(?:33|47)|8(?:24|55|76)|900)\d{4}';
     ExampleNumber: '2771234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:46|83)[0-5]|(?:6[2-4689]|78)0)\d{4}|(?:45|77|88)\d{5}';
     ExampleNumber: '6201234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[36-8]\d{5,8}|4\d{6,8}|59\d{6}|9\d{5,10}|(?:2\d|5[0-8])\d{6,7}';
     ExampleNumber: '';
     LengthOffset: 130; LengthCount: 6;
     LocalOnlyOffset: 2; LocalOnlyCount: 1),
    { PY fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3[289]|4[246-8]|61|7[1-3]|8[1-36])\d{5,7}|(?:2(?:[14-68]\d|2[4-68]|7[15]|9[1-5])|3(?:18|3[167' +
       ']|4[2357]|51|[67]\d)|4(?:1\d|3[12]|5[13]|9[1-47])|5(?:[1-4]\d|5[02-4])|6(?:3[1-3]|44|7[1-8])|7(?' +
       ':4[0-4]|5\d|6[1-578]|75|8[0-8])|858)\d{5,6}';
     ExampleNumber: '212345678';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 2),
    { PY mobile }
    (HasData: True;
     NationalNumberPattern: '9(?:51|6[129]|7[1-6]|8[1-7]|9[1-5])\d{6}';
     ExampleNumber: '961456789';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY tollFree }
    (HasData: True;
     NationalNumberPattern: '9800\d{5,7}';
     ExampleNumber: '98000123456';
     LengthOffset: 154; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY voip }
    (HasData: True;
     NationalNumberPattern: '8700[0-4]\d{4}';
     ExampleNumber: '870012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY uan }
    (HasData: True;
     NationalNumberPattern: '[245]0\d{6,7}|[36-9]0\d{4,7}';
     ExampleNumber: '201234567';
     LengthOffset: 22; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { PY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA generalDesc }
    (HasData: True;
     NationalNumberPattern: '800\d{4}|(?:2|800)\d{6}|(?:0080|[3-7])\d{7}';
     ExampleNumber: '';
     LengthOffset: 433; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA fixedLine }
    (HasData: True;
     NationalNumberPattern: '4(?:(?:[014]\d\d|999)\d|2022)\d{3}';
     ExampleNumber: '44123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA mobile }
    (HasData: True;
     NationalNumberPattern: '[35-7]\d{7}';
     ExampleNumber: '33123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{4}|(?:0080[01]|800)\d{6}';
     ExampleNumber: '8001234';
     LengthOffset: 437; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA pager }
    (HasData: True;
     NationalNumberPattern: '2[136]\d{5}';
     ExampleNumber: '2123456';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { QA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE generalDesc }
    (HasData: True;
     NationalNumberPattern: '709\d{6}|(?:26|[689]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE fixedLine }
    (HasData: True;
     NationalNumberPattern: '2631[0-6]\d{4}|26(?:2\d|30|88)\d{5}';
     ExampleNumber: '262161234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE mobile }
    (HasData: True;
     NationalNumberPattern: '(?:69(?:2\d\d|3(?:[06][0-6]|1[0-3]|2[0-2]|3[0-39]|4\d|5[0-5]|7[0-37]|8[0-8]|9[0-479]))|7092[0-3]' +
       ')\d{4}';
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
     NationalNumberPattern: '89[1-37-9]\d{6}';
     ExampleNumber: '891123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE sharedCost }
    (HasData: True;
     NationalNumberPattern: '8(?:1[019]|2[0156]|84|90)\d{6}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE voip }
    (HasData: True;
     NationalNumberPattern: '9(?:399[0-3]|479[0-6]|76(?:2[278]|3[0-37]))\d{4}';
     ExampleNumber: '939901234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[236-8]\d|90)\d{7}|[23]\d{5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO fixedLine }
    (HasData: True;
     NationalNumberPattern: '[23][13-6]\d{7}|(?:2(?:19\d|[3-6]\d9)|31\d\d)\d\d';
     ExampleNumber: '211234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO mobile }
    (HasData: True;
     NationalNumberPattern: '(?:630|702)0\d{5}|(?:6(?:00|2\d)|7(?:0[013-9]|1[0-3]|[2-7]\d|8[03-8]|9[0-39]))\d{6}';
     ExampleNumber: '712034567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[0136]\d{6}';
     ExampleNumber: '900123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO sharedCost }
    (HasData: True;
     NationalNumberPattern: '801\d{6}';
     ExampleNumber: '801123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO uan }
    (HasData: True;
     NationalNumberPattern: '(?:37\d|80[578])\d{6}';
     ExampleNumber: '372123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS generalDesc }
    (HasData: True;
     NationalNumberPattern: '38[02-9]\d{6,9}|6\d{7,9}|90\d{4,8}|38\d{5,6}|(?:7\d\d|800)\d{3,9}|(?:[12]\d|3[0-79])\d{5,10}';
     ExampleNumber: '';
     LengthOffset: 326; LengthCount: 7;
     LocalOnlyOffset: 110; LocalOnlyCount: 2),
    { RS fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:11[1-9]\d|(?:2[389]|39)(?:0[2-9]|[2-9]\d))\d{3,8}|(?:1[02-9]|2[0-24-7]|3[0-8])[2-9]\d{4,9}';
     ExampleNumber: '10234567';
     LengthOffset: 159; LengthCount: 6;
     LocalOnlyOffset: 383; LocalOnlyCount: 3),
    { RS mobile }
    (HasData: True;
     NationalNumberPattern: '6(?:[0-689]|7\d)\d{6,7}';
     ExampleNumber: '601234567';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{3,9}';
     ExampleNumber: '80012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:78\d|90[0169])\d{3,7}';
     ExampleNumber: '90012345';
     LengthOffset: 95; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS uan }
    (HasData: True;
     NationalNumberPattern: '7[06]\d{4,10}';
     ExampleNumber: '700123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{13}|[347-9]\d{9}';
     ExampleNumber: '';
     LengthOffset: 366; LengthCount: 2;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { RU fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3(?:0[12]|36|4[1-35-79]|5[1-3]|65|8[1-58]|9[0145])|4(?:01|1[1356]|2[13467]|7[1-5]|8[1-7]|9[1-' +
       '689])|8(?:1[1-8]|2[01]|3[13-6]|4[0-8]|5[15-7]|6[0-35-79]|7[1-37-9]))\d{7}';
     ExampleNumber: '3011234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { RU mobile }
    (HasData: True;
     NationalNumberPattern: '9\d{9}';
     ExampleNumber: '9123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:0[04]|108\d{3})\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU premiumRate }
    (HasData: True;
     NationalNumberPattern: '80[39]\d{7}';
     ExampleNumber: '8091234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU personalNumber }
    (HasData: True;
     NationalNumberPattern: '808\d{7}';
     ExampleNumber: '8081234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:06|[27]\d\d|[89]00)\d{6}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:06|2[23568]\d)\d{6}';
     ExampleNumber: '250123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW mobile }
    (HasData: True;
     NationalNumberPattern: '7[237-9]\d{7}';
     ExampleNumber: '720123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{6}';
     ExampleNumber: '900123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { RW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[15]\d|800|92)\d{7}';
     ExampleNumber: '';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { SA fixedLine }
    (HasData: True;
     NationalNumberPattern: '1(?:1\d|2[24-8]|3[35-8]|4[3-68]|6[2-5]|7[235-7])\d{6}';
     ExampleNumber: '112345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { SA mobile }
    (HasData: True;
     NationalNumberPattern: '579[0-8]\d{5}|5(?:[013-689]\d|7[0-8])\d{6}';
     ExampleNumber: '512345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA premiumRate }
    (HasData: True;
     NationalNumberPattern: '925\d{6}';
     ExampleNumber: '925012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA sharedCost }
    (HasData: True;
     NationalNumberPattern: '920\d{6}';
     ExampleNumber: '920012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB generalDesc }
    (HasData: True;
     NationalNumberPattern: '[6-9]\d{6}|[1-6]\d{4}';
     ExampleNumber: '';
     LengthOffset: 440; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1[4-79]|[23]\d|4[0-2]|5[03]|6[0-37])\d{3}';
     ExampleNumber: '40123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB mobile }
    (HasData: True;
     NationalNumberPattern: '(?:48|99[0-8]\d)\d{3}|(?:6[89]|7[1-9]|8[4-9]|9[0-8])\d{5}';
     ExampleNumber: '7421234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB tollFree }
    (HasData: True;
     NationalNumberPattern: '1[38]\d{3}';
     ExampleNumber: '18123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB voip }
    (HasData: True;
     NationalNumberPattern: '5[12]\d{3}';
     ExampleNumber: '51123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SB noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2489]\d|64)\d{5}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC fixedLine }
    (HasData: True;
     NationalNumberPattern: '4[2-46]\d{5}';
     ExampleNumber: '4217123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC mobile }
    (HasData: True;
     NationalNumberPattern: '2[125-8]\d{5}';
     ExampleNumber: '2510123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC tollFree }
    (HasData: True;
     NationalNumberPattern: '800[08]\d{3}';
     ExampleNumber: '8000000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC premiumRate }
    (HasData: True;
     NationalNumberPattern: '85\d{5}';
     ExampleNumber: '8512345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC voip }
    (HasData: True;
     NationalNumberPattern: '971\d{4}|(?:64|95)\d{5}';
     ExampleNumber: '6412345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD fixedLine }
    (HasData: True;
     NationalNumberPattern: '1(?:5\d|8[35-7])\d{6}';
     ExampleNumber: '153123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD mobile }
    (HasData: True;
     NationalNumberPattern: '(?:1[0-2]|9[0-3569])\d{7}';
     ExampleNumber: '911231234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SD noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[26]\d\d|9)\d{9}|[1-9]\d{8}|[1-689]\d{7}|[1-4689]\d{6}|2\d{5}';
     ExampleNumber: '';
     LengthOffset: 139; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:[12][136]|3[356]|4[0246]|6[03]|8\d)\d|90[1-9])\d{4,6}|(?:1(?:2[0-35]|4[0-4]|5[0-25-9]|7[13' +
       '-6]|[89]\d)|2(?:2[0-7]|4[0136-8]|5[0138]|7[018]|8[01]|9[0-57])|3(?:0[0-4]|1\d|2[0-25]|4[056]|7[0' +
       '-2]|8[0-3]|9[023])|4(?:1[013-8]|3[0135]|5[14-79]|7[0-246-9]|8[0156]|9[0-689])|5(?:0[0-6]|[15][0-' +
       '5]|2[0-68]|3[0-4]|4\d|6[03-5]|7[013]|8[0-79]|9[01])|6(?:1[1-3]|2[0-4]|4[02-57]|5[0-37]|6[0-3]|7[' +
       '0-2]|8[0247]|9[0-356])|9(?:1[0-68]|2\d|3[02-5]|4[0-3]|5[0-4]|[68][01]|7[0135-8]))\d{5,6}';
     ExampleNumber: '8123456';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE mobile }
    (HasData: True;
     NationalNumberPattern: '7[023689]\d{7}';
     ExampleNumber: '701234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE tollFree }
    (HasData: True;
     NationalNumberPattern: '20\d{4,7}';
     ExampleNumber: '20123456';
     LengthOffset: 22; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE premiumRate }
    (HasData: True;
     NationalNumberPattern: '649\d{6}|99[1-59]\d{4}(?:\d{3})?|9(?:00|39|44)[1-8]\d{3,6}';
     ExampleNumber: '9001234567';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE sharedCost }
    (HasData: True;
     NationalNumberPattern: '77[0-7]\d{6}';
     ExampleNumber: '771234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE personalNumber }
    (HasData: True;
     NationalNumberPattern: '75[1-8]\d{6}';
     ExampleNumber: '751234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE pager }
    (HasData: True;
     NationalNumberPattern: '74[02-9]\d{6}';
     ExampleNumber: '740123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE uan }
    (HasData: True;
     NationalNumberPattern: '10[1-8]\d{6}';
     ExampleNumber: '102345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE voicemail }
    (HasData: True;
     NationalNumberPattern: '(?:25[245]|67[3-68])\d{9}';
     ExampleNumber: '254123456789';
     LengthOffset: 153; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:(?:1\d|8)\d\d|7000)\d{7}|[3689]\d{7}';
     ExampleNumber: '';
     LengthOffset: 175; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG fixedLine }
    (HasData: True;
     NationalNumberPattern: '662[0-24-9]\d{4}|6(?:[0-578]\d|6[013-57-9]|9[0-35-9])\d{5}';
     ExampleNumber: '61234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG mobile }
    (HasData: True;
     NationalNumberPattern: '80[1-9]\d{5}|(?:8[1-9]|9[0-8])\d{6}';
     ExampleNumber: '81234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:18|8)00\d{7}';
     ExampleNumber: '18001234567';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG premiumRate }
    (HasData: True;
     NationalNumberPattern: '1900\d{7}';
     ExampleNumber: '19001234567';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG voip }
    (HasData: True;
     NationalNumberPattern: '(?:3[12]\d|666)\d{5}';
     ExampleNumber: '31234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG uan }
    (HasData: True;
     NationalNumberPattern: '7000\d{7}';
     ExampleNumber: '70001234567';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[256]\d|8)\d{3}';
     ExampleNumber: '';
     LengthOffset: 110; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:[0-57-9]\d|6[4-9])\d\d';
     ExampleNumber: '22158';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH mobile }
    (HasData: True;
     NationalNumberPattern: '[56]\d{4}';
     ExampleNumber: '51234';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH voip }
    (HasData: True;
     NationalNumberPattern: '262\d\d';
     ExampleNumber: '26212';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-7]\d{7}|8\d{4,7}|90\d{4,6}';
     ExampleNumber: '';
     LengthOffset: 429; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:[1-357][2-8]|4[24-8])\d{6}';
     ExampleNumber: '12345678';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { SI mobile }
    (HasData: True;
     NationalNumberPattern: '65(?:[178]\d|5[56]|6[01])\d{4}|(?:[37][01]|4[013]|51|6[489])\d{6}';
     ExampleNumber: '31234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{4,6}';
     ExampleNumber: '80123456';
     LengthOffset: 31; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI premiumRate }
    (HasData: True;
     NationalNumberPattern: '89[1-3]\d{2,5}|90\d{4,6}';
     ExampleNumber: '90123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI voip }
    (HasData: True;
     NationalNumberPattern: '(?:59\d\d|8(?:1(?:[67]\d|8[0-589])|2(?:0\d|2[0-37-9]|8[0-2489])|3[389]\d))\d{4}';
     ExampleNumber: '59012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '0\d{4}|(?:[489]\d|79)\d{6}';
     ExampleNumber: '';
     LengthOffset: 337; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ fixedLine }
    (HasData: True;
     NationalNumberPattern: '79\d{6}';
     ExampleNumber: '79123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ mobile }
    (HasData: True;
     NationalNumberPattern: '45(?:[0-24-9]\d|3[0-57-9])\d{4}|(?:4[016-8]|9\d)\d{6}';
     ExampleNumber: '41234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ tollFree }
    (HasData: True;
     NationalNumberPattern: '80[01]\d{5}';
     ExampleNumber: '80012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ premiumRate }
    (HasData: True;
     NationalNumberPattern: '82[09]\d{5}';
     ExampleNumber: '82012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ sharedCost }
    (HasData: True;
     NationalNumberPattern: '810(?:0[0-6]|[2-8]\d)\d{3}';
     ExampleNumber: '81021234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ personalNumber }
    (HasData: True;
     NationalNumberPattern: '880\d{5}';
     ExampleNumber: '88012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ voip }
    (HasData: True;
     NationalNumberPattern: '85[0-5]\d{5}';
     ExampleNumber: '85012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ uan }
    (HasData: True;
     NationalNumberPattern: '(?:0[235-9]|81(?:0(?:0[7-9]|1\d)|5\d\d))\d{3}';
     ExampleNumber: '02000';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ voicemail }
    (HasData: True;
     NationalNumberPattern: '81[23]\d{5}';
     ExampleNumber: '81212345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SJ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-689]\d{8}|[2-59]\d{6}|[2-5]\d{5}';
     ExampleNumber: '';
     LengthOffset: 442; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:16|[2-9]\d{3})|(?:(?:[3-5][1-8]\d|819)\d|601[1-5])\d)\d{4}|(?:2|[3-5][1-8])1[67]\d{3}|[3-' +
       '5][1-8]16\d\d';
     ExampleNumber: '221234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK mobile }
    (HasData: True;
     NationalNumberPattern: '909[1-9]\d{5}|9(?:0[1-8]|1[0-24-9]|4[03-57-9]|5\d)\d{6}';
     ExampleNumber: '912123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK premiumRate }
    (HasData: True;
     NationalNumberPattern: '9(?:00|[78]\d)\d{6}';
     ExampleNumber: '900123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK sharedCost }
    (HasData: True;
     NationalNumberPattern: '8[5-9]\d{7}';
     ExampleNumber: '850123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK voip }
    (HasData: True;
     NationalNumberPattern: '6(?:02|5[0-4]|9[0-6])\d{6}';
     ExampleNumber: '690123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK pager }
    (HasData: True;
     NationalNumberPattern: '9090\d{3}';
     ExampleNumber: '9090123';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK uan }
    (HasData: True;
     NationalNumberPattern: '96\d{7}';
     ExampleNumber: '961234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SK noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '9090\d{3}|(?:602|8(?:00|[5-9]\d)|9(?:00|[78]\d))\d{6}';
     ExampleNumber: '';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[237-9]\d|66)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { SL fixedLine }
    (HasData: True;
     NationalNumberPattern: '22[2-4][2-9]\d{4}';
     ExampleNumber: '22221234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { SL mobile }
    (HasData: True;
     NationalNumberPattern: '(?:25|3[0-5]|66|7\d|8[08]|9[09])\d{6}';
     ExampleNumber: '25123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SL noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:0549|[5-7]\d)\d{6}';
     ExampleNumber: '';
     LengthOffset: 114; LengthCount: 2;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { SM fixedLine }
    (HasData: True;
     NationalNumberPattern: '0549(?:8[0157-9]|9\d)\d{4}';
     ExampleNumber: '0549886377';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { SM mobile }
    (HasData: True;
     NationalNumberPattern: '6[16]\d{6}';
     ExampleNumber: '66661212';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM premiumRate }
    (HasData: True;
     NationalNumberPattern: '7[178]\d{6}';
     ExampleNumber: '71123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM voip }
    (HasData: True;
     NationalNumberPattern: '5[158]\d{6}';
     ExampleNumber: '58001110';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[378]\d|93)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN fixedLine }
    (HasData: True;
     NationalNumberPattern: '3(?:[026]\d|3[89])\d{6}';
     ExampleNumber: '301012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:[015-8]\d|21|90)\d{6}';
     ExampleNumber: '701234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN premiumRate }
    (HasData: True;
     NationalNumberPattern: '88[4689]\d{6}';
     ExampleNumber: '884123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN sharedCost }
    (HasData: True;
     NationalNumberPattern: '81[02468]\d{6}';
     ExampleNumber: '810123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN voip }
    (HasData: True;
     NationalNumberPattern: '(?:39|93)\d{7}';
     ExampleNumber: '933301234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SN noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO generalDesc }
    (HasData: True;
     NationalNumberPattern: '[346-9]\d{8}|[12679]\d{7}|[1-5]\d{6}|[1348]\d{5}';
     ExampleNumber: '';
     LengthOffset: 22; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1\d|2[0-79]|3[0-46-8]|4[0-7]|5[57-9])\d{5}|(?:[134]\d|8[125])\d{4}';
     ExampleNumber: '4012345';
     LengthOffset: 250; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:15|(?:3[59]|4[89]|6\d|7[0-35-9]|8[08])\d|9(?:0\d|[2-9]))\d|2(?:4\d|8))\d{5}|(?:[67]\d\d|90' +
       '4)\d{5}';
     ExampleNumber: '71123456';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-5]|[6-9]\d)\d{5}';
     ExampleNumber: '';
     LengthOffset: 250; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[1-3]|3[0-7]|4\d|5[2-578])\d{4}';
     ExampleNumber: '211234';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6[08]|7[1-79]|8[1-9])\d{5}';
     ExampleNumber: '7412345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{5}';
     ExampleNumber: '8012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d{5}';
     ExampleNumber: '9012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR voip }
    (HasData: True;
     NationalNumberPattern: '(?:56|91\d)\d{4}';
     ExampleNumber: '561234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SR noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS generalDesc }
    (HasData: True;
     NationalNumberPattern: '[19]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS fixedLine }
    (HasData: True;
     NationalNumberPattern: '1[89]\d{7}';
     ExampleNumber: '181234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS mobile }
    (HasData: True;
     NationalNumberPattern: '(?:12|9[1257-9])\d{7}';
     ExampleNumber: '977123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:22|9\d)\d{5}';
     ExampleNumber: '';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST fixedLine }
    (HasData: True;
     NationalNumberPattern: '22\d{5}';
     ExampleNumber: '2221234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST mobile }
    (HasData: True;
     NationalNumberPattern: '900[5-9]\d{3}|9(?:0[1-9]|[89]\d)\d{4}';
     ExampleNumber: '9812345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ST noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV generalDesc }
    (HasData: True;
     NationalNumberPattern: '[25-7]\d{7}|(?:80\d|900)\d{4}(?:\d{4})?';
     ExampleNumber: '';
     LengthOffset: 445; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:79(?:0[0347-9]|[1-9]\d)|89(?:0[024589]|[1-9]\d))\d{3}|2(?:[1-69]\d|[78][0-8])\d{5}';
     ExampleNumber: '21234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV mobile }
    (HasData: True;
     NationalNumberPattern: '[5-7]\d{7}';
     ExampleNumber: '70123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{8}|80[01]\d{4}';
     ExampleNumber: '8001234';
     LengthOffset: 136; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{4}(?:\d{4})?';
     ExampleNumber: '9001234';
     LengthOffset: 136; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SV noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX generalDesc }
    (HasData: True;
     NationalNumberPattern: '7215\d{6}|(?:[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { SX fixedLine }
    (HasData: True;
     NationalNumberPattern: '7215(?:4[2-8]|8[39]|9[056])\d{4}';
     ExampleNumber: '7215425678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { SX mobile }
    (HasData: True;
     NationalNumberPattern: '7215(?:1[02]|2\d|5[034679]|8[0-24-8])\d{4}';
     ExampleNumber: '7215205678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { SX tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SX noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-359]\d{8}|[1-5]\d{7}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { SY fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:[1478]\d|[2356])|21\d|3(?:[13]\d|4)|4[134]|5[1-3])\d{6}|2[1-5]\d{6}';
     ExampleNumber: '112345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 250; LocalOnlyCount: 2),
    { SY mobile }
    (HasData: True;
     NationalNumberPattern: '(?:50|9[03-689])\d{7}';
     ExampleNumber: '944567890';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '0800\d{4}|(?:[237]\d|900)\d{6}';
     ExampleNumber: '';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '[23][2-5]\d{6}';
     ExampleNumber: '22171234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ mobile }
    (HasData: True;
     NationalNumberPattern: '7[5-9]\d{6}';
     ExampleNumber: '76123456';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ tollFree }
    (HasData: True;
     NationalNumberPattern: '0800\d{4}';
     ExampleNumber: '08001234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{6}';
     ExampleNumber: '900012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ voip }
    (HasData: True;
     NationalNumberPattern: '70\d{6}';
     ExampleNumber: '70012345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { SZ noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '0800\d{4}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA generalDesc }
    (HasData: True;
     NationalNumberPattern: '8\d{3}';
     ExampleNumber: '';
     LengthOffset: 339; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA fixedLine }
    (HasData: True;
     NationalNumberPattern: '8\d{3}';
     ExampleNumber: '8999';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|649|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TC fixedLine }
    (HasData: True;
     NationalNumberPattern: '649(?:266|712|9(?:4\d|50))\d{4}';
     ExampleNumber: '6497121234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TC mobile }
    (HasData: True;
     NationalNumberPattern: '649(?:2(?:3[129]|4[1-79])|3\d\d|4[34][1-3])\d{4}';
     ExampleNumber: '6492311234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TC tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC voip }
    (HasData: True;
     NationalNumberPattern: '649(?:71[01]|966)\d{4}';
     ExampleNumber: '6497101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:22|[3689]\d|77)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD fixedLine }
    (HasData: True;
     NationalNumberPattern: '22(?:[37-9]0|5[0-5]|6[89])\d{4}';
     ExampleNumber: '22501234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD mobile }
    (HasData: True;
     NationalNumberPattern: '(?:3[01]|[69]\d|77|8[5-7])\d{6}';
     ExampleNumber: '63012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TD noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG generalDesc }
    (HasData: True;
     NationalNumberPattern: '[279]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:2[2-7]|3[23]|4[45]|55|6[67]|77)\d{5}';
     ExampleNumber: '22212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG mobile }
    (HasData: True;
     NationalNumberPattern: '(?:7[0-389]|9[0-36-9])\d{6}';
     ExampleNumber: '90112345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:001800|[2-57]|[689]\d)\d{7}|1\d{7,9}';
     ExampleNumber: '';
     LengthOffset: 448; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1[0689]|2\d|3[2-9]|4[2-5]|5[2-6]|7[3-7])\d{6}';
     ExampleNumber: '21234567';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:14|[89]\d)\d\d|6(?:[1-6]\d\d|7(?:1[0-8]|2[4-7]|3[1-6])))\d{5}';
     ExampleNumber: '812345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:001800\d|1800)\d{6}';
     ExampleNumber: '1800123456';
     LengthOffset: 452; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH premiumRate }
    (HasData: True;
     NationalNumberPattern: '1900\d{6}';
     ExampleNumber: '1900123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH voip }
    (HasData: True;
     NationalNumberPattern: '6[08]\d{7}';
     ExampleNumber: '601234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TH noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[0-57-9]\d|66)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 454; LocalOnlyCount: 4),
    { TJ fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3(?:1[3-5]|2[245]|3[12]|4[24-7]|5[25]|72)|4(?:46|74|87))\d{6}';
     ExampleNumber: '372123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 454; LocalOnlyCount: 4),
    { TJ mobile }
    (HasData: True;
     NationalNumberPattern: '(?:33[03-9]|4(?:1[18]|4[02-479])|81[1-9])\d{6}|(?:[09]\d|1[0-27-9]|2[0-27]|3[08]|40|5[05]|66|7[0' +
       '157-9]|8[07-9])\d{7}';
     ExampleNumber: '917123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TJ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-47]\d{3,6}';
     ExampleNumber: '';
     LengthOffset: 458; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[2-4]|[34]\d)\d{2,5}';
     ExampleNumber: '3101';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK mobile }
    (HasData: True;
     NationalNumberPattern: '7[2-4]\d{2,5}';
     ExampleNumber: '7290';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL generalDesc }
    (HasData: True;
     NationalNumberPattern: '7\d{7}|(?:[2-47]\d|[89]0)\d{5}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[1-5]|3[1-9]|4[1-4])\d{5}';
     ExampleNumber: '2112345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL mobile }
    (HasData: True;
     NationalNumberPattern: '7[2-8]\d{6}';
     ExampleNumber: '77212345';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{5}';
     ExampleNumber: '8012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d{5}';
     ExampleNumber: '9012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL personalNumber }
    (HasData: True;
     NationalNumberPattern: '70\d{5}';
     ExampleNumber: '7012345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TL noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-7]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:2\d|3[1-9])|2(?:22|4[0-35-8])|3(?:22|4[03-9])|4(?:22|3[128]|4\d|6[15])|5(?:22|5[7-9]|6[01' +
       '4-689]))\d{5}';
     ExampleNumber: '12345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6\d|7[12])\d{6}';
     ExampleNumber: '66123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-57-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN fixedLine }
    (HasData: True;
     NationalNumberPattern: '81200\d{3}|(?:3[0-2]|7\d)\d{6}';
     ExampleNumber: '30010123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN mobile }
    (HasData: True;
     NationalNumberPattern: '3(?:001|[12]40)\d{4}|(?:(?:[259]\d|4[0-8])\d|3(?:1[1-35]|6[0-4]|91))\d{5}';
     ExampleNumber: '20123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN tollFree }
    (HasData: True;
     NationalNumberPattern: '8010\d{4}';
     ExampleNumber: '80101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN premiumRate }
    (HasData: True;
     NationalNumberPattern: '88\d{6}';
     ExampleNumber: '88123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN sharedCost }
    (HasData: True;
     NationalNumberPattern: '8[12]10\d{4}';
     ExampleNumber: '81101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TN noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:0800|(?:[5-8]\d\d|999)\d)\d{3}|[2-8]\d{4}';
     ExampleNumber: '';
     LengthOffset: 440; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2\d|3[0-8]|4[0-4]|50|6[09]|7[0-24-69]|8[05])\d{3}';
     ExampleNumber: '20123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO mobile }
    (HasData: True;
     NationalNumberPattern: '(?:5(?:4[0-5]|5[4-6])|6(?:[09]\d|3[02]|8[15-9])|(?:7\d|8[46-9])\d|999)\d{4}';
     ExampleNumber: '7715123';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO tollFree }
    (HasData: True;
     NationalNumberPattern: '0800\d{3}';
     ExampleNumber: '0800222';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO voip }
    (HasData: True;
     NationalNumberPattern: '55[0-37-9]\d{4}';
     ExampleNumber: '5510123';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TO noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR generalDesc }
    (HasData: True;
     NationalNumberPattern: '4\d{6}|8\d{11,12}|(?:[2-58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 462; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:1[26]|[28][2468]|[3-5][268]|[67][246])|3(?:[13][28]|[24-6][2468]|[78][02468]|92)|4(?:[16]' +
       '[246]|[23578][2468]|4[26]))\d{7}';
     ExampleNumber: '2123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR mobile }
    (HasData: True;
     NationalNumberPattern: '5(?:61(?:011|61\d)|82[2-5]\d\d)\d{4}|5(?:[03-5]\d|1[06]|24|6[24]|7[245]|9[46])\d{7}';
     ExampleNumber: '5012345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00\d{7}(?:\d{2,3})?|11\d{7})';
     ExampleNumber: '8001234567';
     LengthOffset: 466; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:8[89]8|900)\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR personalNumber }
    (HasData: True;
     NationalNumberPattern: '592(?:21[12]|461)\d{4}';
     ExampleNumber: '5922121234';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR voip }
    (HasData: True;
     NationalNumberPattern: '850\d{7}';
     ExampleNumber: '8500123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR pager }
    (HasData: True;
     NationalNumberPattern: '512\d{7}';
     ExampleNumber: '5123456789';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR uan }
    (HasData: True;
     NationalNumberPattern: '444\d{4}';
     ExampleNumber: '4441444';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TR noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '(?:444|811\d{3})\d{4}';
     ExampleNumber: '';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TT fixedLine }
    (HasData: True;
     NationalNumberPattern: '868(?:2(?:01|1[5-9]|[23]\d|4[0-2])|6(?:0[7-9]|1[02-8]|2[1-9]|[3-69]\d|7[0-79])|82[124])\d{4}';
     ExampleNumber: '8682211234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TT mobile }
    (HasData: True;
     NationalNumberPattern: '868(?:(?:2[5-9]|3\d)\d|4(?:3[0-6]|[6-9]\d)|6(?:20|78|8\d)|7(?:0[1-9]|1[02-9]|[2-9]\d))\d{4}';
     ExampleNumber: '8682911234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TT tollFree }
    (HasData: True;
     NationalNumberPattern: '868800\d{4}|8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TT voicemail }
    (HasData: True;
     NationalNumberPattern: '868619\d{4}';
     ExampleNumber: '8686191234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { TT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:2|7\d\d|90)\d{4}';
     ExampleNumber: '';
     LengthOffset: 26; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV fixedLine }
    (HasData: True;
     NationalNumberPattern: '2[02-9]\d{3}';
     ExampleNumber: '20123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV mobile }
    (HasData: True;
     NationalNumberPattern: '(?:7[01]\d|90)\d{4}';
     ExampleNumber: '901234';
     LengthOffset: 250; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TV noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-689]\d{8}|7\d{9,10}|[2-8]\d{7}|2\d{6}';
     ExampleNumber: '';
     LengthOffset: 165; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2[2-8]\d|370|55[01]|7[1-9])\d{6}|4(?:(?:0(?:0[1-9]|[2-48]\d)|1[023]\d)\d{4,5}|(?:[239]\d\d|4(' +
       '?:0[56]|12|49))\d{5})|6(?:[01]\d{7}|4(?:0[56]|12|24|4[09])\d{4,5})|8(?:(?:2(?:3\d|4[0-269]|[578]' +
       '0|66)|36[24-9]|90\d\d)\d{4}|4(?:0[56]|12|24|4[09])\d{4,5})|(?:2(?:2(?:0\d\d|4(?:0[68]|[249]0|3[0' +
       '-467]|5[0-25-9]|6[0235689]))|(?:3(?:[09]\d|1[0-4])|(?:4\d|5[0-49]|6[0-29]|7[0-5])\d)\d)|(?:(?:3[' +
       '2-9]|5[2-8]|6[0-35-79]|8[7-9])\d\d|4(?:2(?:[089]\d|7[1-9])|(?:3[0-4]|[78]\d|9[01])\d))\d)\d{3}';
     ExampleNumber: '221234567';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW mobile }
    (HasData: True;
     NationalNumberPattern: '(?:40001[0-2]|9[0-8]\d{4})\d{3}';
     ExampleNumber: '912345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-79]\d{6}|800\d{5}';
     ExampleNumber: '800123456';
     LengthOffset: 103; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW premiumRate }
    (HasData: True;
     NationalNumberPattern: '20(?:[013-9]\d\d|2)\d{4}';
     ExampleNumber: '203123456';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW personalNumber }
    (HasData: True;
     NationalNumberPattern: '99\d{7}';
     ExampleNumber: '990123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW voip }
    (HasData: True;
     NationalNumberPattern: '7010(?:[0-2679]\d|3[0-7]|8[0-5])\d{5}|70\d{8}';
     ExampleNumber: '7012345678';
     LengthOffset: 29; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW uan }
    (HasData: True;
     NationalNumberPattern: '50[0-46-9]\d{6}';
     ExampleNumber: '500123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[25-8]\d|41|90)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '2[2-8]\d{7}';
     ExampleNumber: '222345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ mobile }
    (HasData: True;
     NationalNumberPattern: '(?:6[0-35-9]|7\d)\d{7}';
     ExampleNumber: '621234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ tollFree }
    (HasData: True;
     NationalNumberPattern: '80[08]\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ premiumRate }
    (HasData: True;
     NationalNumberPattern: '90\d{7}';
     ExampleNumber: '900123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ sharedCost }
    (HasData: True;
     NationalNumberPattern: '8(?:40|6[01])\d{6}';
     ExampleNumber: '840123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ voip }
    (HasData: True;
     NationalNumberPattern: '41\d{7}';
     ExampleNumber: '412345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { TZ noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '(?:8(?:[04]0|6[01])|90\d)\d{6}';
     ExampleNumber: '';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[89]\d{9}|[3-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { UA fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:3[1-8]|4[13-8]|5[1-7]|6[12459])\d{7}';
     ExampleNumber: '311234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { UA mobile }
    (HasData: True;
     NationalNumberPattern: '790\d{6}|(?:39|50|6[36-8]|7[1-357]|9[1-9])\d{7}';
     ExampleNumber: '501234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA tollFree }
    (HasData: True;
     NationalNumberPattern: '800[1-8]\d{5,6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[239]\d{5,6}';
     ExampleNumber: '900212345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA voip }
    (HasData: True;
     NationalNumberPattern: '89[1-579]\d{6}';
     ExampleNumber: '891234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG generalDesc }
    (HasData: True;
     NationalNumberPattern: '800\d{6}|(?:[29]0|[347]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { UG fixedLine }
    (HasData: True;
     NationalNumberPattern: '20(?:(?:24[09]|30[67])\d|6(?:00[0-2]|30[0-4]))\d{3}|(?:20(?:[017]\d|2[5-9]|3[1-4]|5[0-4]|6[15-9]' +
       ')|[34]\d{3})\d{5}';
     ExampleNumber: '312345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 26; LocalOnlyCount: 3),
    { UG mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:28|34)0\d{5}|7(?:[014-8]\d|2[01467]|3[0-267]|9[0-589])\d{6}';
     ExampleNumber: '712345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG tollFree }
    (HasData: True;
     NationalNumberPattern: '800[1-3]\d{5}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[1-3]\d{6}';
     ExampleNumber: '901123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US generalDesc }
    (HasData: True;
     NationalNumberPattern: '[2-9]\d{9}|3\d{6}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { US fixedLine }
    (HasData: True;
     NationalNumberPattern: '983[2-57-9]\d{6}|(?:2(?:0[1-35-9]|1[02-9]|2[03-57-9]|3[1459]|4[08]|5[1-46]|6[0279]|7[02469]|8[13' +
       '])|3(?:0[1-57-9]|1[02-9]|2[013-79]|3[0-24679]|4[167]|5[0-3]|6[01349]|8[056])|4(?:0[124-9]|1[02-5' +
       '79]|2[3-5]|3[0245]|4[023578]|58|6[349]|7[02589]|8[04])|5(?:0[1-57-9]|1[0235-8]|20|3[0149]|4[01]|' +
       '5[179]|6[1-47]|7[0-5]|8[0256])|6(?:0[1-35-9]|1[024-9]|2[03689]|3[016]|4[0156]|5[01679]|6[0-279]|' +
       '78|8[0-269])|7(?:0[1-46-8]|1[2-9]|2[04-8]|3[0-2478]|4[0378]|5[47]|6[02359]|7[0-59]|8[156])|8(?:0' +
       '[1-68]|1[02-8]|2[0168]|3[0-2589]|4[03578]|5[046-9]|6[02-5]|7[028])|9(?:0[1346-9]|1[02-9]|2[0589]' +
       '|3[0146-8]|4[01357-9]|5[12469]|7[0-3589]|8[04-69]))[2-9]\d{6}';
     ExampleNumber: '2015550123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { US mobile }
    (HasData: True;
     NationalNumberPattern: '983[2-57-9]\d{6}|(?:2(?:0[1-35-9]|1[02-9]|2[03-57-9]|3[1459]|4[08]|5[1-46]|6[0279]|7[02469]|8[13' +
       '])|3(?:0[1-57-9]|1[02-9]|2[013-79]|3[0-24679]|4[167]|5[0-3]|6[01349]|8[056])|4(?:0[124-9]|1[02-5' +
       '79]|2[3-5]|3[0245]|4[023578]|58|6[349]|7[02589]|8[04])|5(?:0[1-57-9]|1[0235-8]|20|3[0149]|4[01]|' +
       '5[179]|6[1-47]|7[0-5]|8[0256])|6(?:0[1-35-9]|1[024-9]|2[03689]|3[016]|4[0156]|5[01679]|6[0-279]|' +
       '78|8[0-269])|7(?:0[1-46-8]|1[2-9]|2[04-8]|3[0-2478]|4[0378]|5[47]|6[02359]|7[0-59]|8[156])|8(?:0' +
       '[1-68]|1[02-8]|2[0168]|3[0-2589]|4[03578]|5[046-9]|6[02-5]|7[028])|9(?:0[1346-9]|1[02-9]|2[0589]' +
       '|3[0146-8]|4[01357-9]|5[12469]|7[0-3589]|8[04-69]))[2-9]\d{6}';
     ExampleNumber: '2015550123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { US tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { US noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY generalDesc }
    (HasData: True;
     NationalNumberPattern: '0004\d{2,9}|[1249]\d{7}|2\d{3,4}|(?:[49]\d|80)\d{5}';
     ExampleNumber: '';
     LengthOffset: 34; LengthCount: 10;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:770|9(?:20|[89]7))|(?:2\d|4[2-7])\d\d)\d{4}';
     ExampleNumber: '21231234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { UY mobile }
    (HasData: True;
     NationalNumberPattern: '9[1-9]\d{6}';
     ExampleNumber: '94231234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY tollFree }
    (HasData: True;
     NationalNumberPattern: '0004\d{2,9}|(?:405|80[05])\d{4}';
     ExampleNumber: '8001234';
     LengthOffset: 469; LengthCount: 8;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[0-8]\d{4}';
     ExampleNumber: '9001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY uan }
    (HasData: True;
     NationalNumberPattern: '21\d{2,3}';
     ExampleNumber: '21123';
     LengthOffset: 110; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UY noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:20|33|[5-9]\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:55\d\d|6(?:1(?:22|3[124]|4[1-4]|5[1-3578]|64)|2(?:22|3[0-57-9]|41)|5(?:22|3[3-7]|5[024-8])|[6' +
       '9]\d\d|7(?:[23]\d|7[69]))|7(?:[168]\d\d|2(?:22|3[13-57-9]|4[1-3579]|5[14])|3(?:2\d|3[1578]|4[1-3' +
       '5-7]|5[1-57]|61)|4(?:2\d|3[1-579]|7[1-79])|5(?:22|5[1-9]|6[1457])|9(?:22|5[1-9])))\d{5}';
     ExampleNumber: '669050123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ mobile }
    (HasData: True;
     NationalNumberPattern: '(?:(?:[25]0|33|8[078]|9[0-57-9])\d{3}|6(?:1(?:2(?:2[01]|98)|35[0-4]|50\d|61[23]|7(?:[01][017]|4\' +
       'd|55|9[5-9]))|2(?:(?:11|7\d)\d|2(?:[12]1|9[01379])|5(?:[126]\d|3[0-4]))|5(?:19[01]|2(?:27|9[26])' +
       '|(?:30|59|7\d)\d)|6(?:2(?:1[5-9]|2[0367]|38|41|52|60)|(?:3[79]|9[0-3])\d|4(?:56|83)|7(?:[07]\d|1' +
       '[017]|3[07]|4[047]|5[057]|67|8[0178]|9[79]))|7(?:2(?:24|3[237]|4[5-9]|7[15-8])|5(?:7[12]|8[0589]' +
       ')|7(?:0\d|[39][07])|9(?:0\d|7[079])))|7(?:[07]\d{3}|2(?:2(?:2[79]|95)|3(?:2[5-9]|6[0-6])|57\d|7(' +
       '?:0\d|1[17]|2[27]|3[37]|44|5[057]|66|88))|3(?:2(?:1[0-6]|21|3[469]|7[159])|(?:33|9[4-6])\d|5(?:0' +
       '[0-4]|5[579]|9\d)|7(?:[0-3579]\d|4[0467]|6[67]|8[078]))|4(?:2(?:29|5[0257]|6[0-7]|7[1-57])|5(?:1' +
       '[0-4]|8\d|9[5-9])|7(?:0\d|1[024589]|2[0-27]|3[0137]|[46][07]|5[01]|7[5-9]|9[079])|9(?:7[015-9]|[' +
       '89]\d))|5(?:112|2(?:0\d|2[29]|[49]4)|3[1568]\d|52[6-9]|7(?:0[01578]|1[017]|[23]7|4[047]|[5-7]\d|' +
       '8[78]|9[079]))|9(?:22[128]|3(?:2[0-4]|7\d)|57[02569]|7(?:2[05-9]|3[37]|4\d|60|7[2579]|87|9[07]))' +
       '))\d{4}';
     ExampleNumber: '912345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { UZ noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA generalDesc }
    (HasData: True;
     NationalNumberPattern: '0\d{5,10}|3[0-8]\d{7,10}|55\d{8}|8\d{5}(?:\d{2,4})?|(?:1\d|39)\d{7,8}';
     ExampleNumber: '';
     LengthOffset: 326; LengthCount: 7;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA fixedLine }
    (HasData: True;
     NationalNumberPattern: '06698\d{1,6}';
     ExampleNumber: '0669812345';
     LengthOffset: 130; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA mobile }
    (HasData: True;
     NationalNumberPattern: '3[1-9]\d{8}|3[2-9]\d{7}';
     ExampleNumber: '3123456789';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA tollFree }
    (HasData: True;
     NationalNumberPattern: '80(?:0\d{3}|3)\d{3}';
     ExampleNumber: '800123456';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:0878\d{3}|89(?:2\d|3[04]|4(?:[0-4]|[5-9]\d\d)|5[0-4]))\d\d|(?:1(?:44|6[346])|89(?:38|5[5-9]|9' +
       '))\d{6}';
     ExampleNumber: '899123456';
     LengthOffset: 333; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA sharedCost }
    (HasData: True;
     NationalNumberPattern: '84(?:[08]\d{3}|[17])\d{3}';
     ExampleNumber: '848123456';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA personalNumber }
    (HasData: True;
     NationalNumberPattern: '1(?:78\d|99)\d{6}';
     ExampleNumber: '1781234567';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA voip }
    (HasData: True;
     NationalNumberPattern: '55\d{8}';
     ExampleNumber: '5512345678';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA voicemail }
    (HasData: True;
     NationalNumberPattern: '3[2-8]\d{9,10}';
     ExampleNumber: '33101234501';
     LengthOffset: 309; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d\d|784|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VC fixedLine }
    (HasData: True;
     NationalNumberPattern: '784(?:266|3(?:6[6-9]|7\d|8[0-6])|4(?:38|5[0-36-8]|8[0-8])|5(?:55|7[0-2]|93)|638|784)\d{4}';
     ExampleNumber: '7842661234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VC mobile }
    (HasData: True;
     NationalNumberPattern: '784(?:4(?:3[0-5]|5[45]|89|9[0-8])|5(?:2[6-9]|3[0-4])|720)\d{4}';
     ExampleNumber: '7844301234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VC tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC voip }
    (HasData: True;
     NationalNumberPattern: '78451[0-2]\d{4}';
     ExampleNumber: '7845101234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VC pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VC noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE generalDesc }
    (HasData: True;
     NationalNumberPattern: '[68]00\d{7}|(?:[24]\d|[59]0)\d{8}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VE fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:12|3[457-9]|[467]\d|[58][1-9]|9[1-6])|[4-6]00)\d{7}';
     ExampleNumber: '2121234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VE mobile }
    (HasData: True;
     NationalNumberPattern: '4(?:1[24-8]|2[246])\d{7}';
     ExampleNumber: '4121234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{7}';
     ExampleNumber: '8001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE premiumRate }
    (HasData: True;
     NationalNumberPattern: '90[01]\d{7}';
     ExampleNumber: '9001234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE uan }
    (HasData: True;
     NationalNumberPattern: '501\d{7}';
     ExampleNumber: '5010123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:284|[58]\d\d|900)\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VG fixedLine }
    (HasData: True;
     NationalNumberPattern: '284(?:229|4(?:22|9[45])|774|8(?:52|6[459]))\d{4}';
     ExampleNumber: '2842291234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VG mobile }
    (HasData: True;
     NationalNumberPattern: '284(?:245|3(?:0[0-3]|4[0-7]|68|9[34])|4(?:4[0-6]|68|9[69])|5(?:4[0-7]|68|9[69]))\d{4}';
     ExampleNumber: '2843001234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VG tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VG noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI generalDesc }
    (HasData: True;
     NationalNumberPattern: '[58]\d{9}|(?:34|90)0\d{7}';
     ExampleNumber: '';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VI fixedLine }
    (HasData: True;
     NationalNumberPattern: '340(?:2(?:0\d|10|2[06-8]|4[49]|77)|3(?:32|44)|4(?:2[23]|44|7[34]|89)|5(?:1[34]|55)|6(?:2[56]|4[2' +
       '3]|77|9[023])|7(?:1[2-57-9]|2[57]|7\d)|884|998)\d{4}';
     ExampleNumber: '3406421234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VI mobile }
    (HasData: True;
     NationalNumberPattern: '340(?:2(?:0\d|10|2[06-8]|4[49]|77)|3(?:32|44)|4(?:2[23]|44|7[34]|89)|5(?:1[34]|55)|6(?:2[56]|4[2' +
       '3]|77|9[023])|7(?:1[2-57-9]|2[57]|7\d)|884|998)\d{4}';
     ExampleNumber: '3406421234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 19; LocalOnlyCount: 1),
    { VI tollFree }
    (HasData: True;
     NationalNumberPattern: '8(?:00|33|44|55|66|77|88)[2-9]\d{6}';
     ExampleNumber: '8002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI premiumRate }
    (HasData: True;
     NationalNumberPattern: '900[2-9]\d{6}';
     ExampleNumber: '9002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI personalNumber }
    (HasData: True;
     NationalNumberPattern: '52(?:3(?:[2-46-9][02-9]\d|5(?:[02-46-9]\d|5[0-46-9]))|4(?:[2-478][02-9]\d|5(?:[034]\d|2[024-9]|5' +
       '[0-46-9])|6(?:0[1-9]|[2-9]\d)|9(?:[05-9]\d|2[0-5]|49)))\d{4}|52[34][2-9]1[02-9]\d{4}|5(?:00|2[12' +
       '5-9]|3[23]|44|66|77|88)[2-9]\d{6}';
     ExampleNumber: '5002345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VI noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN generalDesc }
    (HasData: True;
     NationalNumberPattern: '[12]\d{9}|[135-9]\d{8}|[16]\d{6,7}|7\d{6}';
     ExampleNumber: '';
     LengthOffset: 145; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN fixedLine }
    (HasData: True;
     NationalNumberPattern: '2(?:0[3-9]|1[0-689]|2[0-25-9]|[38][2-9]|4[2-8]|5[124-9]|6[0-39]|7[0-7]|9[0-4679])\d{7}';
     ExampleNumber: '2101234567';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN mobile }
    (HasData: True;
     NationalNumberPattern: '121[0-3]\d{5}|(?:1[46]0|(?:3\d|7[06-9])\d|5(?:[1689]\d|2[238]|59)|8(?:[1-8]\d|9[6-9])|9(?:[0-8]\' +
       'd|9[013-9]))\d{6}';
     ExampleNumber: '912345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN tollFree }
    (HasData: True;
     NationalNumberPattern: '1800\d{4,6}|12(?:0[13]|28)\d{4}';
     ExampleNumber: '1800123456';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN premiumRate }
    (HasData: True;
     NationalNumberPattern: '1900\d{4,6}';
     ExampleNumber: '1900123456';
     LengthOffset: 122; LengthCount: 3;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN voip }
    (HasData: True;
     NationalNumberPattern: '672\d{6}';
     ExampleNumber: '672012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN uan }
    (HasData: True;
     NationalNumberPattern: '[17]99\d{4}|69\d{5,6}';
     ExampleNumber: '1992000';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VN noInternationalDialling }
    (HasData: True;
     NationalNumberPattern: '[17]99\d{4}|69\d{5,6}';
     ExampleNumber: '';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU generalDesc }
    (HasData: True;
     NationalNumberPattern: '[57-9]\d{6}|(?:[238]\d|48)\d{3}';
     ExampleNumber: '';
     LengthOffset: 440; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:38[0-8]|48[4-9])\d\d|(?:2[02-9]|3[4-7]|88)\d{3}';
     ExampleNumber: '22123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[58]\d|7[0-7])\d{5}';
     ExampleNumber: '5912345';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU tollFree }
    (HasData: True;
     NationalNumberPattern: '81[18]\d\d';
     ExampleNumber: '81123';
     LengthOffset: 2; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU voip }
    (HasData: True;
     NationalNumberPattern: '9(?:0[1-9]|1[01])\d{4}';
     ExampleNumber: '9010123';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU uan }
    (HasData: True;
     NationalNumberPattern: '(?:3[03]|900\d)\d{3}';
     ExampleNumber: '30123';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { VU noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:40|72|8\d{4})\d{4}|[89]\d{5}';
     ExampleNumber: '';
     LengthOffset: 8; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF fixedLine }
    (HasData: True;
     NationalNumberPattern: '72\d{4}';
     ExampleNumber: '721234';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF mobile }
    (HasData: True;
     NationalNumberPattern: '(?:72|8[23])\d{4}';
     ExampleNumber: '821234';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF tollFree }
    (HasData: True;
     NationalNumberPattern: '80[0-5]\d{6}';
     ExampleNumber: '800012345';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF voip }
    (HasData: True;
     NationalNumberPattern: '9[23]\d{4}';
     ExampleNumber: '921234';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF voicemail }
    (HasData: True;
     NationalNumberPattern: '[48]0\d{4}';
     ExampleNumber: '401234';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WF noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[2-6]|8\d{5})\d{4}|[78]\d{6}|[68]\d{5}';
     ExampleNumber: '';
     LengthOffset: 477; LengthCount: 4;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS fixedLine }
    (HasData: True;
     NationalNumberPattern: '6[1-9]\d{3}|(?:[2-5]|60)\d{4}';
     ExampleNumber: '22123';
     LengthOffset: 0; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS mobile }
    (HasData: True;
     NationalNumberPattern: '(?:7[1-35-8]|8(?:[3-7]|9\d{3}))\d{5}';
     ExampleNumber: '7212345';
     LengthOffset: 79; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{3}';
     ExampleNumber: '800123';
     LengthOffset: 4; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { WS noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK generalDesc }
    (HasData: True;
     NationalNumberPattern: '2\d{7,8}|3\d{7,11}|(?:4\d\d|[89]00)\d{5}';
     ExampleNumber: '';
     LengthOffset: 424; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK fixedLine }
    (HasData: True;
     NationalNumberPattern: '38\d{6,10}|(?:2[89]|39)(?:0\d{5,6}|[1-9]\d{5})';
     ExampleNumber: '28012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK mobile }
    (HasData: True;
     NationalNumberPattern: '4[3-9]\d{6}';
     ExampleNumber: '43201234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{5}';
     ExampleNumber: '80001234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK premiumRate }
    (HasData: True;
     NationalNumberPattern: '900\d{5}';
     ExampleNumber: '90001234';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { XK noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:1|7\d)\d{7}|[1-7]\d{6}';
     ExampleNumber: '';
     LengthOffset: 100; LengthCount: 3;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { YE fixedLine }
    (HasData: True;
     NationalNumberPattern: '78[0-7]\d{4}|17\d{6}|(?:[12][2-68]|3[2358]|4[2-58]|5[2-6]|6[3-58]|7[24-6])\d{5}';
     ExampleNumber: '1234567';
     LengthOffset: 125; LengthCount: 2;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { YE mobile }
    (HasData: True;
     NationalNumberPattern: '7[01378]\d{7}';
     ExampleNumber: '712345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YE noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:639\d|7093)\d{5}|(?:26|80|9\d)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT fixedLine }
    (HasData: True;
     NationalNumberPattern: '26(?:89\d|9(?:0[0-467]|15|5[0-4]|6\d|[78]0))\d{4}';
     ExampleNumber: '269601234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT mobile }
    (HasData: True;
     NationalNumberPattern: '(?:639(?:0[0-79]|1[019]|[267]\d|3[09]|40|5[05-9]|9[04-79])|7093[5-7])\d{4}';
     ExampleNumber: '639012345';
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
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT voip }
    (HasData: True;
     NationalNumberPattern: '9(?:(?:39|47)8[01]|769\d)\d{4}';
     ExampleNumber: '939801234';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { YT noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-79]\d{8}|8\d{4,9}';
     ExampleNumber: '';
     LengthOffset: 401; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:0330|4302)|52087)0\d{3}|(?:1[0-8]|2[1-378]|3[1-69]|4\d|5[1346-8])\d{7}';
     ExampleNumber: '101234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA mobile }
    (HasData: True;
     NationalNumberPattern: '(?:1(?:3492[0-25]|4495[0235]|549(?:20|5[01]))|4[34]492[01])\d{3}|8[1-4]\d{3,7}|(?:2[27]|47|54)49' +
       '50\d{3}|(?:1(?:049[2-4]|9[12]\d\d)|(?:50[0-2]|[67]\d\d)\d\d|8(?:5\d{3}|7(?:08[67]|158|28[5-9]|31' +
       '0)))\d{4}|(?:1[6-8]|28|3[2-69]|4[025689]|5[36-8])4920\d{3}|(?:12|[2-5]1)492\d{4}';
     ExampleNumber: '711234567';
     LengthOffset: 85; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA tollFree }
    (HasData: True;
     NationalNumberPattern: '80\d{7}';
     ExampleNumber: '801234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA premiumRate }
    (HasData: True;
     NationalNumberPattern: '(?:86[2-9]|9[0-2]\d)\d{6}';
     ExampleNumber: '862345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA sharedCost }
    (HasData: True;
     NationalNumberPattern: '860\d{6}';
     ExampleNumber: '860123456';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA voip }
    (HasData: True;
     NationalNumberPattern: '87(?:08[0-589]|15[0-79]|28[0-4]|31[1-9])\d{4}|87(?:[02][0-79]|1[0-46-9]|3[02-9]|[4-9]\d)\d{5}';
     ExampleNumber: '871234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA uan }
    (HasData: True;
     NationalNumberPattern: '861\d{6,7}';
     ExampleNumber: '861123456';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZA noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM generalDesc }
    (HasData: True;
     NationalNumberPattern: '800\d{6}|(?:21|[579]\d|63)\d{7}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { ZM fixedLine }
    (HasData: True;
     NationalNumberPattern: '21[1-8]\d{6}';
     ExampleNumber: '211234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 4; LocalOnlyCount: 1),
    { ZM mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[59][5-8]|7[5-9])\d{7}';
     ExampleNumber: '955123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM tollFree }
    (HasData: True;
     NationalNumberPattern: '800\d{6}';
     ExampleNumber: '800123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM voip }
    (HasData: True;
     NationalNumberPattern: '63\d{7}';
     ExampleNumber: '630123456';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZM noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:13|8\d{4})\d{5}|[235-8]\d{8}|[23568]\d{6}';
     ExampleNumber: '';
     LengthOffset: 252; LengthCount: 3;
     LocalOnlyOffset: 481; LocalOnlyCount: 4),
    { ZW fixedLine }
    (HasData: True;
     NationalNumberPattern: '(?:(?:(?:13|6(?:[16-8]21|52[013])|8(?:[1349]28|523))\d|3(?:(?:123|92\d)\d|7[56]))\d|2(?:(?:(?:02' +
       '[014]|[56]20|72[03]|9\d\d)\d|4(?:2\d\d|8))\d|2(?:[278]\d|92))|5(?:4(?:2\d{3}|83)|525\d\d))\d{3}|' +
       '(?:2(?:(?:0\d|7[1-7])\d|583)|(?:55|6[78])\d\d)\d{3}';
     ExampleNumber: '1312345';
     LengthOffset: 149; LengthCount: 2;
     LocalOnlyOffset: 481; LocalOnlyCount: 4),
    { ZW mobile }
    (HasData: True;
     NationalNumberPattern: '7(?:[1278]\d|3[1-9]|9[01])\d{6}';
     ExampleNumber: '712345678';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW tollFree }
    (HasData: True;
     NationalNumberPattern: '80(?:[01]\d|20|8[0-8])\d{3}';
     ExampleNumber: '8001234';
     LengthOffset: 19; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW voip }
    (HasData: True;
     NationalNumberPattern: '86(?:1[12]|22|30|44|55|77|8[368])\d{6}';
     ExampleNumber: '8686123456';
     LengthOffset: 21; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { ZW noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:00|[1-9]\d)\d{6}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: True;
     NationalNumberPattern: '(?:00|[1-9]\d)\d{6}';
     ExampleNumber: '12345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{7}';
     ExampleNumber: '';
     LengthOffset: 10; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: True;
     NationalNumberPattern: '[1-9]\d{7}';
     ExampleNumber: '12345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '7\d{11}|[235-7]\d{8}';
     ExampleNumber: '';
     LengthOffset: 151; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: True;
     NationalNumberPattern: '(?:[356]|774[45])\d{8}|7[6-8]\d{7}';
     ExampleNumber: '301234567';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: True;
     NationalNumberPattern: '2\d{8}';
     ExampleNumber: '201234567';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '10\d{10}';
     ExampleNumber: '';
     LengthOffset: 153; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: True;
     NationalNumberPattern: '10\d{10}';
     ExampleNumber: '101234567890';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '6\d{9}|[0-36-9]\d{8}';
     ExampleNumber: '';
     LengthOffset: 120; LengthCount: 2;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: True;
     NationalNumberPattern: '6\d{9}|[0-36-9]\d{8}';
     ExampleNumber: '612345678';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '[13]\d{6}(?:\d{2,5})?|[19]\d{7}|(?:[25]\d\d|4)\d{7}(?:\d{2})?';
     ExampleNumber: '';
     LengthOffset: 159; LengthCount: 6;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: True;
     NationalNumberPattern: '342\d{4}|(?:337|49)\d{6}|(?:3(?:2|47|7\d{3})|5(?:0\d{3}|2[0-2]))\d{7}';
     ExampleNumber: '3421234';
     LengthOffset: 485; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: True;
     NationalNumberPattern: '1(?:3(?:0[0347]|[13][0139]|2[035]|4[013568]|6[0459]|7[06]|8[15-8]|9[0689])\d{4}|6\d{5,10})|(?:34' +
       '5\d|9[89])\d{6}|(?:10|2(?:3|85\d)|3(?:[15]|[69]\d\d)|4[15-8]|51)\d{8}';
     ExampleNumber: '390123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: True;
     NationalNumberPattern: '348[57]\d{7}';
     ExampleNumber: '34851234567';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '(?:[1-4]\d|51)\d{6,10}';
     ExampleNumber: '';
     LengthOffset: 424; LengthCount: 5;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: True;
     NationalNumberPattern: '(?:2(?:00\d\d|10)|(?:370[1-9]|51\d0)\d)\d{7}|51(?:00\d{5}|[24-9]0\d{4,7})|(?:1[0-79]|2[24-689]|3' +
       '[02-689]|4[0-4])0\d{5,9}';
     ExampleNumber: '510012345';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '\d{11}';
     ExampleNumber: '';
     LengthOffset: 138; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: True;
     NationalNumberPattern: '\d{11}';
     ExampleNumber: '12345678901';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 generalDesc }
    (HasData: True;
     NationalNumberPattern: '[1359]\d{8}';
     ExampleNumber: '';
     LengthOffset: 20; LengthCount: 1;
     LocalOnlyOffset: 10; LocalOnlyCount: 1),
    { 001 fixedLine }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 mobile }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 tollFree }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 premiumRate }
    (HasData: True;
     NationalNumberPattern: '[1359]\d{8}';
     ExampleNumber: '123456789';
     LengthOffset: 0; LengthCount: 0;
     LocalOnlyOffset: 10; LocalOnlyCount: 1),
    { 001 sharedCost }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 personalNumber }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voip }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 pager }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 uan }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 voicemail }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0),
    { 001 noInternationalDialling }
    (HasData: False;
     NationalNumberPattern: '';
     ExampleNumber: '';
     LengthOffset: 3; LengthCount: 1;
     LocalOnlyOffset: 0; LocalOnlyCount: 0)
  );

implementation

end.
