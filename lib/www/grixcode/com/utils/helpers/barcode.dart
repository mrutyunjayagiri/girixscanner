import 'package:barcode/barcode.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:girixscanner/www/grixcode/com/utils/utility.dart';
import 'package:image/image.dart' as im;

class BarcodeUtility extends AppUtility {
  Future<String> getExternalDocumentPath() {
    super.getExternalDocumentPath();
  }

  static String fileName(String name) {
    final DateTime _date = DateTime.now();
    final _ran =
        "${_date.hour}${_date.minute}${_date.second}${_date.millisecond}";
    return name + "" + _ran;
  }

  static Future<List<int>> getBarcodePng(
      Barcode bc, Map<String, dynamic> dataSet) async {
    final image =
    im.Image(dataSet['width'].toInt() * 2, dataSet['height'].toInt() * 2);
    im.fill(image, im.getColor(255, 255, 255));
    drawBarcode(image, bc, dataSet['secret_data'], font: im.arial_48);
    return im.encodePng(image);
  }
}
