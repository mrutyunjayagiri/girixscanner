import 'package:barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/tables.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';

class QrCodeProvider {
  Barcode barcode;
  String fileName;
  int id;
  String data;
  QrCodeType qrCodeType;

  DateTime createdAt;

  QrCodeProvider({
    this.barcode,
    this.fileName,
    this.id,
    this.data,
    this.qrCodeType,
    this.createdAt,
  });

  QrCodeProvider.fromSqlFliteMap(Map<String, dynamic> data) {
    this.fileName = data[QrTable.colFileName];
    this.data = data[QrTable.colData];
    this.id = data[QrTable.colId];
    // Get enum
    this.barcode = Barcode.qrCode();
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
  QrCodeType.VIDEO
];
