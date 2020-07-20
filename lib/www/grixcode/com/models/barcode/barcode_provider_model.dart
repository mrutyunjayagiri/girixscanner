import 'package:barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/tables.dart';

class BarcodeProvider {
  Barcode barcode;
  String fileName;
  String path;
  int id;
  String data;
  BarcodeType barcodeType;
  String QrType;
  DateTime createdAt;

  BarcodeProvider(
      {this.barcode,
      this.fileName,
      this.path,
      this.id,
      this.data,
      this.barcodeType,
      this.createdAt,
      this.QrType});

  BarcodeProvider.fromSqlFliteMap(Map<String, dynamic> data) {
    this.QrType = data[BarcodeTable.colQrType];
    this.fileName = data[BarcodeTable.colFileName];
    this.data = data[BarcodeTable.colData];
    this.path = data[BarcodeTable.colPath];
    this.id = data[BarcodeTable.colId];
    // Get enum
    this.barcode = _getBarcode(data[BarcodeTable.colBarcodeType]);
    this.barcodeType = _getType(data[BarcodeTable.colBarcodeType]);
    this.createdAt = DateTime.parse(data[BarcodeTable.colCreatedAt]);
  }

  BarcodeType _getType(String type) =>
      barcodeTypeValues.firstWhere(
              (BarcodeType _type) => _type.toString() == type,
          orElse: null);

  Barcode _getBarcode(String type) {
    print("Barcode Type: $type}");

    final _type = _getType(type);
    print("Barcode Type: $_type}");
    switch (_type) {
      case BarcodeType.CodeITF14:
        return Barcode.itf14();
        break;
      case BarcodeType.CodeEAN13:
        return Barcode.ean13();
        break;
      case BarcodeType.CodeEAN8:
        return Barcode.ean8();
        break;
      case BarcodeType.CodeEAN5:
        return Barcode.ean5();
        break;
      case BarcodeType.CodeEAN2:
        return Barcode.ean2();
        break;
      case BarcodeType.CodeISBN:
        return Barcode.isbn();
        break;
      case BarcodeType.Code39:
        return Barcode.code39();
        break;
      case BarcodeType.Code93:
        return Barcode.code93();
        break;
      case BarcodeType.CodeUPCA:
        return Barcode.upcA();
        break;
      case BarcodeType.CodeUPCE:
        return Barcode.upcE();
        break;
      case BarcodeType.Code128:
        return Barcode.code128();
        break;
      case BarcodeType.GS128:
        return Barcode.gs128();
        break;
      case BarcodeType.Telepen:
        return Barcode.telepen();
        break;
      case BarcodeType.QrCode:
        return Barcode.qrCode();
        break;
      case BarcodeType.Codabar:
        return Barcode.codabar();
        break;
      case BarcodeType.PDF417:
        return Barcode.pdf417();
        break;
      case BarcodeType.DataMatrix:
        return Barcode.dataMatrix();
        break;
      case BarcodeType.Aztec:
        return Barcode.aztec();
        break;
      case BarcodeType.Rm4scc:
        return Barcode.rm4scc();
        break;
      case BarcodeType.Itf:
        return Barcode.itf();
        break;
      default:
        return Barcode.qrCode();
    }
  }

  Map<String, dynamic> toSqlFliteMap() {
    final Map<String, dynamic> _dataSet = Map<String, dynamic>();
    _dataSet[BarcodeTable.colId] = null;
    _dataSet[BarcodeTable.colFileName] = this.fileName;
    _dataSet[BarcodeTable.colData] = this.data;
    _dataSet[BarcodeTable.colPath] = this.path;
    _dataSet[BarcodeTable.colBarcodeName] = this.barcode.name;
    _dataSet[BarcodeTable.colBarcodeType] = this.barcodeType.toString();
    _dataSet[BarcodeTable.colQrType] = this.QrType;
    _dataSet[BarcodeTable.colCreatedAt] = DateTime.now().toString();

    return _dataSet;
  }
}

List<BarcodeType> barcodeTypeValues = [
  BarcodeType.CodeITF14,
  BarcodeType.CodeEAN13,
  BarcodeType.CodeEAN8,
  BarcodeType.CodeEAN5,
  BarcodeType.CodeEAN2,
  BarcodeType.CodeISBN,
  BarcodeType.Code39,
  BarcodeType.Code93,
  BarcodeType.CodeUPCA,
  BarcodeType.CodeUPCE,
  BarcodeType.Code128,
  BarcodeType.GS128,
  BarcodeType.Telepen,
  BarcodeType.QrCode,
  BarcodeType.Codabar,
  BarcodeType.PDF417,
  BarcodeType.DataMatrix,
  BarcodeType.Aztec,
  BarcodeType.Rm4scc,
  BarcodeType.Itf,
];
