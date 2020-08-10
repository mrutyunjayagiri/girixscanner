enum DocumentType { FILE, PDF, BARCODE, IMAGE, QR_CODE, XSLX, DOCUMENT }
enum ErrorResponse { ERROR, FAILED, EMPTY, SUCCESS, NOT_PERMITTED }
enum LoaderType { CIRCULAR, LINEAR }
enum BarcodeTypeEnum {
  Itf,
  CodeITF14,
  CodeEAN13,
  CodeEAN8,
  CodeEAN5,
  CodeEAN2,
  CodeISBN,
  Code39,
  Code93,
  CodeUPCA,
  CodeUPCE,
  Code128,
  GS128,
  Telepen,
  QrCode,
  Codabar,
  PDF417,
  DataMatrix,
  Aztec,
  Rm4scc
}
enum BarcodeCategory { OneD, TwoD }

enum QrCodeType {
  PLAYGROUND,
  ALL,
  WIFI,
  URL,
  TEXT,
  LOCATION,
  PHONE,
  DOB,
  ADDRESS,
  MEMO,
  EMAIL,
  SOUND,
  SMS,
  VIDEO,
}

enum ImageCropperState {
  free,
  picked,
  cropped,
}
