import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/settings/barcode/barcode_settings_screen.dart';
import 'package:girixscanner/www/grixcode/com/widgets/error/error.dart';
import 'package:girixscanner/www/grixcode/com/widgets/loader.dart';

class BarcodeScanScreen extends StatefulWidget {
  final MainModel model;

  BarcodeScanScreen({this.model}) : assert(model != null);

  @override
  _BarcodeScanScreenState createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  ScanResult scanResult;

  final double minValue = 8.0;
  bool isLoading = false;

  void _onCreated() async {
    scan();
  }

  @override
  initState() {
    super.initState();
    _onCreated();
  }

  void _onSettings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => BarcodeSettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scan'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "Scan",
            onPressed: _onSettings,
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: minValue * 3, vertical: minValue * 4),
            child: Text(
              "Scan Result",
              style:
                  CustomStyle(context).headline6.apply(color: Colors.black87),
            ),
          ),
          isLoading
              ? Loader(
                  loaderType: LoaderType.CIRCULAR,
                )
              : scanResult == null
                  ? ErrorView(
                      errorType: ErrorResponse.FAILED,
                    )
                  : Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      margin: EdgeInsets.symmetric(horizontal: minValue * 2),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("Result Type"),
                            subtitle: Text(scanResult.type?.toString() ?? ""),
                          ),
                          ListTile(
                            title: Text("Raw Content"),
                            subtitle: Text(scanResult.rawContent ?? ""),
                          ),
                          ListTile(
                            title: Text("Format"),
                            subtitle:
                                Text(scanResult.format.name?.toString() ?? ""),
                          ),
                          ListTile(
                            title: Text("Format note"),
                            subtitle: Text(scanResult.formatNote ?? ""),
                          ),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }

  Future scan() async {
    setState(() {
      isLoading = true;
    });
    try {
      var options = widget.model.settings.barcodeSettings.scanOptions;

      var result = await BarcodeScanner.scan(
        options: options,
      );

      setState(() {
        isLoading = false;
        scanResult = result;
      });
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }
}
