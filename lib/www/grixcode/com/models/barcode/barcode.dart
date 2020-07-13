import 'package:barcode_widget/barcode_widget.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';

abstract class BarcodeListItem {}

class BarcodeCategoryInfo extends BarcodeListItem {
  String category;

  BarcodeCategoryInfo(this.category);
}

class BarcodeInfo extends BarcodeListItem {
  BarcodeType type;
  String description;
  String method;
  Barcode barcode;
  BarcodeCategory category;

  BarcodeInfo({this.type = BarcodeType.Aztec,
    this.description,
    this.method,
    this.barcode,
    this.category});
}

final List<BarcodeInfo> barcodeInfoList = [
  BarcodeInfo(
      barcode: Barcode.qrCode(),
      description:
      "QR code (abbreviated from Quick Response code) is the trademark for a type of matrix barcode (or two-dimensional barcode) first designed in 1994 for the automotive industry in Japan.",
      method: "qrCode()",
      category: BarcodeCategory.TwoD,
      type: BarcodeType.QrCode),
  BarcodeInfo(
      barcode: Barcode.pdf417(),
      description:
      "PDF417 is a stacked linear barcode format used in a variety of applications such as transport, identification cards, and inventory management.",
      method: "pdf417()",
      category: BarcodeCategory.TwoD,
      type: BarcodeType.PDF417),
  BarcodeInfo(
      barcode: Barcode.dataMatrix(),
      description:
      "A Data Matrix is a two-dimensional barcode consisting of black and white 'cells' or modules arranged in either a square or rectangular pattern, also known as a matrix.",
      method: "dataMatrix()",
      category: BarcodeCategory.TwoD,
      type: BarcodeType.DataMatrix),
  BarcodeInfo(
      barcode: Barcode.aztec(),
      description:
      "Named after the resemblance of the central finder pattern to an Aztec pyramid.",
      method: "aztec()",
      category: BarcodeCategory.TwoD,
      type: BarcodeType.Aztec),
  BarcodeInfo(
      barcode: Barcode.rm4scc(),
      description:
      "The RM4SCC is used for the Royal Mail Cleanmail service. It enables UK postcodes as well as Delivery Point Suffixes (DPSs) to be easily read by a machine at high speed.",
      method: "rm4scc()",
      category: BarcodeCategory.TwoD,
      type: BarcodeType.Rm4scc),
  BarcodeInfo(
      barcode: Barcode.itf(),
      description:
      "Interleaved 2 of 5 (ITF) is a continuous two-width barcodesymbology encoding digits. It is used commercially on 135 film, for ITF-14 barcodes, and on cartons of some products, while the products inside are labeled with UPC or EAN.",
      method: "itf()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.Itf),
  BarcodeInfo(
      barcode: Barcode.itf14(),
      description:
      "ITF-14 is the GS1 implementation of an Interleaved 2 of 5 (ITF) bar code to encode a Global Trade Item Number. ITF-14 symbols are generally used on packaging levels of a product, such as a case box of 24 cans of soup. The ITF-14 will always encode 14 digits.",
      method: "itf14()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeITF14),
  BarcodeInfo(
      barcode: Barcode.ean13(drawEndChar: true),
      description:
      "The International Article Number is a standard describing a barcode symbology and numbering system used in global trade to identify a specific retail product type, in a specific packaging configuration, from a specific manufacturer.",
      method: "ean13(drawEndChar: true)",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeEAN13),
  BarcodeInfo(
      barcode: Barcode.ean8(drawSpacers: true),
      description:
      "An EAN-8 is an EAN/UPC symbology barcode and is derived from the longer International Article Number code. It was introduced for use on small packages where an EAN-13 barcode would be too large; for example on cigarettes, pencils, and chewing gum packets. It is encoded identically to the 12 digits of the UPC-A barcode, except that it has 4 digits in each of the left and right halves.",
      method: "ean8(drawSpacers: true)",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeEAN8),
  BarcodeInfo(
      barcode: Barcode.ean5(),
      description:
      "The EAN-5 is a 5-digit European Article Number code, and is a supplement to the EAN-13 barcode used on books. It is used to give a suggestion for the price of the book.",
      method: "ean5()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeEAN5),
  BarcodeInfo(
      barcode: Barcode.ean2(),
      description:
      "The EAN-2 is a supplement to the EAN-13 and UPC-A barcodes. It is often used on magazines and periodicals to indicate an issue number.",
      method: "ean2()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeEAN2),
  BarcodeInfo(
      barcode: Barcode.isbn(drawEndChar: true),
      description:
      "The International Standard Book Number is a numeric commercial book identifier which is intended to be unique. Publishers purchase ISBNs from an affiliate of the International ISBN Agency.",
      method: "isbn(drawEndChar: true)",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeISBN),
  BarcodeInfo(
      barcode: Barcode.code39(),
      description:
      "The Code 39 specification defines 43 characters, consisting of uppercase letters (A through Z), numeric digits (0 through 9) and a number of special characters (-, ., \$, /, +, %, and space). An additional character (denoted \'*\') is used for both start and stop delimiters.",
      method: "code39()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.Code39),
  BarcodeInfo(
      barcode: Barcode.code93(),
      description:
      "Code 93 is a barcode symbology designed in 1982 by Intermec to provide a higher density and data security enhancement to Code 39. It is an alphanumeric, variable length symbology. Code 93 is used primarily by Canada Post to encode supplementary delivery information.",
      method: "code93()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.Code93),
  BarcodeInfo(
      barcode: Barcode.upcA(),
      description:
      "The Universal Product Code is a barcode symbology that is widely used in the United States, Canada, Europe, Australia, New Zealand, and other countries for tracking trade items in stores. UPC consists of 12 numeric digits that are uniquely assigned to each trade item.",
      method: "upcA()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeUPCA),
  BarcodeInfo(
      barcode: Barcode.upcE(),
      description:
      "The Universal Product Code is a barcode symbology that is widely used in the United States, Canada, Europe, Australia, New Zealand, and other countries for tracking trade items in stores. To allow the use of UPC barcodes on smaller packages, where a full 12-digit barcode may not fit, a zero-suppressed version of UPC was developed, called UPC-E, in which the number system digit, all trailing zeros in the manufacturer code, and all leading zeros in the product code, are suppressed",
      method: "upcE()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.CodeUPCE),
  BarcodeInfo(
      barcode: Barcode.code128(escapes: true),
      description:
      "Code 128 is a high-density linear barcode symbology defined in ISO/IEC 15417:2007. It is used for alphanumeric or numeric-only barcodes. It can encode all 128 characters of ASCII and, by use of an extension symbol, the Latin-1 characters defined in ISO/IEC 8859-1.",
      method: "code128(escapes: true)",
      category: BarcodeCategory.OneD,
      type: BarcodeType.Code128),
  BarcodeInfo(
      barcode: Barcode.gs128(useCode128A: false, useCode128B: false),
      description:
      "The GS1-128 is an application standard of the GS1. It uses a series of Application Identifiers to include additional data such as best before dates, batch numbers, quantities, weights and many other attributes needed by the user.",
      method: "gs128(useCode128A: false, useCode128B: false)",
      category: BarcodeCategory.OneD,
      type: BarcodeType.GS128),
  BarcodeInfo(
      barcode: Barcode.telepen(),
      description:
      "Telepen is a barcode designed in 1972 in the UK to express all 128 ASCII characters without using shift characters for code switching, and using only two different widths for bars and spaces.",
      method: "telepen()",
      category: BarcodeCategory.OneD,
      type: BarcodeType.Telepen),
  BarcodeInfo(
      barcode: Barcode.codabar(),
      category: BarcodeCategory.OneD,
      description:
      "Codabar was designed to be accurately read even when printed on dot-matrix printers for multi-part forms such as FedEx airbills and blood bank forms, where variants are still in use as of 2007.",
      method: "codabar()",
      type: BarcodeType.Codabar)
];
