import 'package:girixscanner/www/grixcode/com/models/barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/connected_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';

class BarcodeService extends ConnectedModel {
  List<BarcodeListItem> getBarcodeCategories() {
    isLoading = true;
    notifyListeners();
    final List<BarcodeListItem> _items = List<BarcodeListItem>();
    // Define Flag
    final List<BarcodeCategory> _categoryList = List<BarcodeCategory>();
    print(_categoryList.length);
    barcodeInfoList.forEach((BarcodeInfo barcodeInfo) {
      // Add Barcode Category Header If Not In List
      if (barcodeInfo.category == BarcodeCategory.TwoD) {
        if (!_categoryList.contains(BarcodeCategory.TwoD)) {
          _categoryList.add(BarcodeCategory.TwoD);
          _items.add(BarcodeCategoryInfo("2D Barcode"));
        }
      } else {
        if (!_categoryList.contains(BarcodeCategory.OneD)) {
          print("1D Added");

          _categoryList.add(BarcodeCategory.OneD);
          _items.add(BarcodeCategoryInfo("1D Barcode"));
        }
      }
      _items.add(barcodeInfo);
    });

    /// For Make Server request If Any..hjkl;'
    /// 1
    _categoryList.clear();
    isLoading = false;
    notifyListeners();

    return _items;
  }

  Future<List<BarcodeProvider>> fetchAllBarcode() async {
    isLoading = true;
    notifyListeners();
    barcodeProviders.clear();
    List<BarcodeProvider> _items = await databaseHelper.fetchAllBarcode();
    if (_items != null) {
      barcodeProviders = _items;
    }
    isLoading = false;
    notifyListeners();
    return _items;
  }

  Future<BarcodeProvider> addBarcode(BarcodeProvider provider) async {
    isLoading = true;
    notifyListeners();
    BarcodeProvider _item = await databaseHelper.insertBarcode(provider);
    barcodeProviders.add(_item);
    isLoading = false;
    notifyListeners();
    return _item;
  }

  Future<int> deleteBarcode(int id) async {
    isLoading = true;
    notifyListeners();
    int result = await databaseHelper.deleteBarcode(id);

    isLoading = false;
    notifyListeners();
    return result;
  }
}
