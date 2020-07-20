import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/qr_code_type.dart';
import 'package:girixscanner/www/grixcode/com/views/scannerScreen/scanner_button.dart';

class QrCodeScreen extends StatefulWidget {
  final MainModel model;

  QrCodeScreen({Key key, this.model});

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrCodeScreen> {
  final double minValue = 8.0;

  String _data = "";

  void generateQrCode() async {
    final me = MeCard.wifi(
      ssid: 'WPA',
      password: 'password',
      hidden: false,
    );
    setState(() {
      _data = me.toString();
    });
//    MeCard.contact(videophone: );
    // Generate a SVG with a barcode that configures the wifi access
    final svg = Barcode.qrCode().toSvg(me.toString(), width: 200, height: 200);
    print(svg);

// Save the image
//    await File('wifi.svg').writeAsString(svg);
  }

  void _onCreateQrCode() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => QrCodeTypeScreen()));
  }

  @override
  void initState() {
    super.initState();

    generateQrCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QrCode"),
        actions: <Widget>[
          ScannerButton(
            title: "Scan QrCode",
          ),
          SizedBox(
            width: minValue,
          )
        ],
      ),
      body: Container(
        child: BarcodeWidget(
          barcode: Barcode.qrCode(),
          data: _data,
        ),
      ),
      floatingActionButton: RaisedButton.icon(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        label: Text("Generate QrCode"),
        textColor: Colors.white,
        elevation: 20.0,
        icon: Icon(
          Icons.add,
          size: 35.0,
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () => _onCreateQrCode(),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      ),
    );
  }
}
