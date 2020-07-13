import 'package:barcode_scan/barcode_scan.dart';
import 'package:girixscanner/www/grixcode/com/models/settings/settings.dart';

class BarcodeSettings extends Settings {
  ScanOptions scanOptions;
  int _selectedCameras = 0;
  bool _useAutoFocus = true;
  bool _autoEnableFlash = false;
  double _aspectTolerance = 0.00;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  void _getCamera() {
    BarcodeScanner.numberOfCameras
        .then((value) => this._selectedCameras = value);
  }

  BarcodeSettings({this.scanOptions}) {
    _getCamera();
    if (scanOptions == null) {
      print("ScanOptions Initiated");
      this.scanOptions = ScanOptions(
        strings: {
          "cancel": "Cancel",
          "flash_on": "Flash on",
          "flash_off": "Flash Off",
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCameras,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );
    }
  }
}
