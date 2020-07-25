import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_item.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/tables.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:image/image.dart' as im;

class QrCodeProvider extends BarcodeItem {
  Barcode barcode;
  String fileName;
  int id;
  String data;
  QrCodeType qrCodeType;

  DateTime createdAt;
  int qrVersion;
  Color foreground;
  Color background;

  QrCodeProvider(
      {this.barcode,
      this.fileName,
      this.id,
      this.data,
      this.qrCodeType,
      this.createdAt,
      this.qrVersion = 1,
      this.foreground,
      this.background});

  QrCodeProvider.fromSqlFliteMap(Map<String, dynamic> data) {
    this.fileName = data[QrTable.colFileName];
    this.data = data[QrTable.colData];
    this.id = data[QrTable.colId];
    this.qrVersion = data[QrTable.colQrVersion] ?? 1;
    this.barcode =
        Barcode.qrCode(typeNumber: this.qrVersion == -1 ? 2 : this.qrVersion);
    this.qrCodeType = _getType(data[QrTable.colQrType]);
    this.createdAt = DateTime.parse(data[QrTable.colCreatedAt]);
    this.foreground = data[QrTable.colForegroundColor] == null
        ? Color(0xff000000)
        : _convertRGBToColor(data[QrTable.colForegroundColor]);
    this.background = data[QrTable.colBackgroundColor] == null
        ? Colors.grey[200]
        : _convertRGBToColor(data[QrTable.colBackgroundColor]);
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
    _dataSet[QrTable.colQrVersion] =
    this.qrVersion == null || this.qrVersion == -1 ? 2 : this.qrVersion;

    _dataSet[QrTable.colForegroundColor] =
    this.foreground == null ? null : _convertColorToRGBStr(this.foreground);
    _dataSet[QrTable.colBackgroundColor] =
    this.background == null ? null : _convertColorToRGBStr(this.background);

    return _dataSet;
  }

  String _convertColorToRGBStr(Color color) {
    return "${color.red}|${color.green}|${color.blue}";
  }

  Color _convertRGBToColor(String rgbColor) {
    final _splitStr = rgbColor.split('|');
    int _r = int.parse(_splitStr[0]);
    int _g = int.parse(_splitStr[1]);
    int _b = int.parse(_splitStr[2]);
    int color = im.getColor(_r, _g, _b);
    return Color(color);
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
