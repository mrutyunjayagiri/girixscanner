import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_item.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/connected_model.dart';

class QrCodeService extends ConnectedModel {
  Future<List<QrCodeProvider>> fetchQrCode() async {
    isLoading = true;
    notifyListeners();

    qrCodeProviders.clear();
    final List<QrCodeProvider> _items = await databaseHelper.fetchAllQrcodes();
//    await Future.delayed(Duration(seconds: 2));
    if (_items != null) {
//      final _barcodeItem = _items.reversed.toList();

      final String _today = DateTime.now().toString().split(' ')[0];
      final List _checker = List();

      _items.forEach((element) {
        final String _createdDate = element.createdAt.toString().split(' ')[0];
//        print("Created: $_createdDate");

        if (!_checker.contains(_createdDate)) {
          if (_today == _createdDate) {
            _checker.add(_createdDate);
            qrCodeProviders.add(
                BarcodeHeader(dateText: "Today", dateTime: element.createdAt));
          } else {
            _checker.add(_createdDate);
            qrCodeProviders.add(BarcodeHeader(
                dateText: "$_createdDate", dateTime: element.createdAt));
          }
          qrCodeProviders.add(element);
        } else {
          qrCodeProviders.add(element);
        }
      });
    }
    isLoading = false;
    notifyListeners();
    return _items;
  }

  Future<QrCodeProvider> addQrcode(QrCodeProvider provider) async {
    isLoading = true;
    notifyListeners();
    QrCodeProvider _item = await databaseHelper.insertQrcode(provider);
    if (_item != null) {
      fetchQrCode();
    }
    isLoading = false;
    notifyListeners();
    return _item;
  }

  Future<int> deleteQrcode(int id) async {
    isLoading = true;
    notifyListeners();
    int result = await databaseHelper.deleteQrcode(id);
    if (result != 0) {
      print("Deleted");
      fetchQrCode();
    }
//    isLoading = false;
//    notifyListeners();
    return result;
  }
}
