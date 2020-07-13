import 'package:girixscanner/www/grixcode/com/models/settings/settings.dart';
import 'package:girixscanner/www/grixcode/com/models/user.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/barcodeService/barcode_service.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedModel extends Model {
  bool isLoading = false;

  User user;
  Settings settings;

  BarcodeService _barcodeService;

  BarcodeService get barcodeService =>
      _barcodeService == null ? BarcodeService() : _barcodeService;
}
