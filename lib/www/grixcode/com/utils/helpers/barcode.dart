import 'package:barcode/barcode.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/utility.dart';
import 'package:image/image.dart' as im;

class BarcodeUtility extends AppUtility {
  Future<String> getExternalDocumentPath() {
    return super.getExternalDocumentPath();
  }

  static String fileName(String name) {
    final DateTime _date = DateTime.now();
    final _ran =
        "${_date.hour}${_date.minute}${_date.second}${_date.millisecond}";
    return name + "" + _ran;
  }

  static Future<List<int>> getBarcodePng(
      Barcode bc, Map<String, dynamic> dataSet) async {
    Color foreground, _background;
    int backColor = im.getColor(255, 255, 255);
    int foreColor = im.getColor(0, 0, 0);
    if (dataSet['foreground_color'] != null) {
      foreground = dataSet['foreground_color']['color'];
      foreColor =
          im.getColor(foreground.red, foreground.green, foreground.blue);
    }
    if (dataSet['background_color'] != null) {
      _background = dataSet['background_color']['color'];
      backColor =
          im.getColor(_background.red, _background.green, _background.blue);
    }

    final image = im.Image(
      dataSet['width'].toInt() * 2,
      dataSet['height'].toInt() * 2,
    );

    im.fill(image, backColor);
    drawBarcode(image, bc, dataSet['secret_data'],
        font: im.arial_48, color: foreColor);
    return im.encodePng(image);
  }
}
