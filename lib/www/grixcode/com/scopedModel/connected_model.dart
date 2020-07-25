import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_item.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';
import 'package:girixscanner/www/grixcode/com/models/settings/settings.dart';
import 'package:girixscanner/www/grixcode/com/models/user.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/barcodeService/barcode_service.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/database_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedModel extends Model {
  bool isLoading = false;

  User user;
  Settings settings = Settings();

  BarcodeService _barcodeService;

  BarcodeService get barcodeService => _barcodeService ?? BarcodeService();

  DatabaseHelper _databaseHelper;

  DatabaseHelper get databaseHelper => _databaseHelper ?? DatabaseHelper();

  List<BarcodeProvider> barcodeProviders = List<BarcodeProvider>();
  List<BarcodeItem> qrCodeProviders = List<BarcodeItem>();
}
