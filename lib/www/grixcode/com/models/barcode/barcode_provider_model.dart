import 'package:barcode/barcode.dart';

class BarcodeProvider {
  Barcode barcode;
  String fileName;
  String path;
  String id;
  String data;
  BarcodeType barcodeType;
  String QrType;

  BarcodeProvider(
      {this.barcode,
      this.fileName,
      this.path,
      this.id,
      this.data,
      this.barcodeType,
      this.QrType});

  BarcodeProvider.fromSqlFliteMap(Map<String, dynamic> data) {
    this.QrType = data['QrType'];
    this.fileName = data['fileName'];
    this.data = data['data'];
    this.path = data['path'];
    this.id = data['id'];

    // Get enum
    this.barcode = getBarcode(data['barcodeType']);
  }

  Barcode getBarcode(String type) {
//    BarcodeType.
  }

  Map<String, dynamic> toSqlFliteMap() {
    final Map<String, dynamic> _dataSet = Map<String, dynamic>();
    _dataSet['id'] = "";
    _dataSet['fileName'] = this.fileName;
    _dataSet['data'] = this.data;
    _dataSet['path'] = this.path;
    _dataSet['barcodeName'] = this.barcode.name;
    _dataSet['barcodeType'] = this.barcodeType.toString();
    _dataSet['QrType'] = this.QrType;
    return _dataSet;
  }
}
