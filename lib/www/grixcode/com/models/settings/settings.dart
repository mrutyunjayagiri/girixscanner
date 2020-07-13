import 'package:girixscanner/www/grixcode/com/models/settings/barcode_settings_model.dart';

class Settings {
  BarcodeSettings _barcodeSettings;

  BarcodeSettings get barcodeSettings =>
      _barcodeSettings == null ? BarcodeSettings() : _barcodeSettings;
}
