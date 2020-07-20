import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/barcode_scan_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ScannerButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const ScannerButton({this.onTap, this.title = "Scan Barcode"});

  void _onBarcodeScanTap(BuildContext context, MainModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BarcodeScanScreen(
                  model: model,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (_, __, MainModel model) {
      return FlatButton.icon(
          label: Text("${title}"),
          icon: Icon(Icons.camera_alt),
          textColor: Colors.white,
          onPressed: onTap ?? () => _onBarcodeScanTap(context, model));
    });
  }
}
