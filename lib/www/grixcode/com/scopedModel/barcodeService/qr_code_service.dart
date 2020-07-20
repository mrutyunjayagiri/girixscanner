import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/connected_model.dart';

class QrCodeService extends ConnectedModel {
  Future<List<QrCodeProvider>> fetchAllQrcode() async {
    isLoading = true;
    notifyListeners();
    qrCodeProviders.clear();
    List<QrCodeProvider> _items = await databaseHelper.fetchAllQrcodes();
    if (_items != null) {
      qrCodeProviders = _items;
    }
    isLoading = false;
    notifyListeners();
    return _items;
  }

  Future<QrCodeProvider> addQrcode(QrCodeProvider provider) async {
    isLoading = true;
    notifyListeners();
    QrCodeProvider _item = await databaseHelper.insertQrcode(provider);
    qrCodeProviders.add(_item);
    isLoading = false;
    notifyListeners();
    return _item;
  }

  Future<int> deleteQrcode(int id) async {
    isLoading = true;
    notifyListeners();
    int result = await databaseHelper.deleteQrcode(id);

    isLoading = false;
    notifyListeners();
    return result;
  }
}
