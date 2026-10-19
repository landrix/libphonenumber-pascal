unit LibPhoneNumber.Types;

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

type
  TPhoneNumberFormat = (
    pnfE164,
    pnfInternational,
    pnfInternationalLegacy,
    pnfNational,
    pnfRfc3966
  );

  TPhoneNumberParseError = (
    pnpeNone,
    pnpeNotANumber,
    pnpeInvalidCountryCode,
    pnpeTooShortAfterIdd,
    pnpeTooShortNsn,
    pnpeTooLongNsn
  );

  { Port of PhoneNumberUtil.MatchType, in upstream declaration order. The
    result of TPhoneNumberUtil.IsNumberMatch; see the doc comment there for
    what each value means. }
  TPhoneNumberMatchType = (
    pnmtNotANumber,
    pnmtNoMatch,
    pnmtShortNsnMatch,
    pnmtNsnMatch,
    pnmtExactMatch
  );

  { Port of Phonenumber.PhoneNumber.CountryCodeSource. Upstream only records
    the source when the number is parsed with keepRawInput, so
    TPhoneNumberUtil.Parse leaves the field at pnccsUnspecified (Java's
    "field not set") and only TPhoneNumberUtil.ParseAndKeepRawInput fills it
    in. Upstream declaration order is preserved from
    pnccsFromNumberWithPlusSign onwards. }
  TCountryCodeSource = (
    pnccsUnspecified,
    pnccsFromNumberWithPlusSign,
    pnccsFromNumberWithIdd,
    pnccsFromNumberWithoutPlusSign,
    pnccsFromDefaultCountry
  );

  { The parse result. Port of Phonenumber.PhoneNumber, with the deliberate
    differences spelled out below.

    Contract of the two national number fields
    ------------------------------------------
    NationalNumberDigits is CANONICAL. It carries the national significant
    number as a digit string, so a significant leading zero survives - upstream
    models the same information as italianLeadingZero / numberOfLeadingZeros
    next to its numeric nationalNumber, which this record does not have. Every
    API of this port that takes a national number takes THIS field.

    NationalNumber is DERIVED and LOSSY: it is the numeric value of the same
    digits, so every leading zero is gone and a number longer than 20 digits
    (which parse rejects) would not fit at all. It exists because a numeric
    national number is what upstream's proto carries. Read it for arithmetic or for a compact
    key; never reconstruct the number from it, and never compare two numbers
    with it alone. When the two disagree - "0123" versus 123 - the digits win.

    Contract of RegionCode
    ----------------------
    A deliberate ADDITION; upstream's PhoneNumber carries no region at all,
    because a calling code can belong to many regions. It answers "which region
    does this port report for this number", not "which region was it dialled
    in", and it is filled as follows:

      * the caller supplied region, upper-cased and trimmed, when that region
        belongs to the extracted calling code - this is what keeps CA a CA
        number instead of turning every +1 into US;
      * otherwise the MAIN region of the calling code
        (getRegionCodeForCountryCode), i.e. US for +1;
      * the sentinel 'ZZ' when the calling code is not supported.

    It is metadata derived and therefore SOURCE BOUND like everything else the
    metadata layer answers: the same number parsed against the testing metadata
    can report a different region. No formatting, validation or matching path
    of this port reads it - they all resolve the region from the calling code
    themselves, exactly like upstream - so changing it does not change any
    other answer.

    Fields only ParseAndKeepRawInput fills
    --------------------------------------
    RawInput, CountryCodeSource and PreferredDomesticCarrierCode mirror the
    upstream keepRawInput gate; plain Parse leaves all three empty. RawInput is
    the ORIGINAL input string, not the normalised one. }
  TPhoneNumber = record
    CountryCode: Integer;
    NationalNumber: UInt64;
    NationalNumberDigits: string;
    Extension: string;
    RawInput: string;
    RegionCode: string;
    CountryCodeSource: TCountryCodeSource;
    PreferredDomesticCarrierCode: string;
  end;

implementation

end.
