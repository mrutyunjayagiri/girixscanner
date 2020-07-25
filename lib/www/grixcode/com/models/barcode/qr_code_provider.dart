import 'package:barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_item.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/tables.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';

class QrCodeProvider extends BarcodeItem {
  Barcode barcode;
  String fileName;
  int id;
  String data;
  QrCodeType qrCodeType;

  DateTime createdAt;
  int qrVersion;

  QrCodeProvider(
      {this.barcode,
      this.fileName,
      this.id,
      this.data,
      this.qrCodeType,
      this.createdAt,
      this.qrVersion = 1});

  QrCodeProvider.fromSqlFliteMap(Map<String, dynamic> data) {
    this.fileName = data[QrTable.colFileName];
    this.data = data[QrTable.colData];
    this.id = data[QrTable.colId];
    this.qrVersion = data[QrTable.colQrVersion] ?? 1;
    // Get enum
    this.barcode = Barcode.qrCode(typeNumber: this.qrVersion);
    this.qrCodeType = _getType(data[QrTable.colQrType]);
    this.createdAt = DateTime.parse(data[QrTable.colCreatedAt]);
  }

  QrCodeType _getType(String type) => qrCodeTypeValues
      .firstWhere((QrCodeType _type) => _type.toString() == type, orElse: null);

  Map<String, dynamic> toSqlFliteMap() {
    final Map<String, dynamic> _dataSet = Map<String, dynamic>();
    _dataSet[QrTable.colId] = null;
    _dataSet[QrTable.colFileName] = this.fileName;
    _dataSet[QrTable.colData] = this.data;
    _dataSet[QrTable.colQrType] = this.qrCodeType.toString();
    _dataSet[QrTable.colCreatedAt] = DateTime.now().toString();
    _dataSet[QrTable.colQrVersion] = this.qrVersion ?? 1;

    return _dataSet;
  }
}

List<QrCodeType> qrCodeTypeValues = [
  QrCodeType.WIFI,
  QrCodeType.URL,
  QrCodeType.TEXT,
  QrCodeType.LOCATION,
  QrCodeType.PHONE,
  QrCodeType.DOB,
  QrCodeType.ADDRESS,
  QrCodeType.MEMO,
  QrCodeType.EMAIL,
  QrCodeType.SOUND,
  QrCodeType.SMS,
  QrCodeType.VIDEO,
  QrCodeType.ALL,
  QrCodeType.PLAYGROUND,
];
