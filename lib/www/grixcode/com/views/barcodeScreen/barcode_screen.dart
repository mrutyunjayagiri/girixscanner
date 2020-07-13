import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/barcode_scan_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/generate/select_category_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/preview_screen.dart';

class BarcodeScreen extends StatefulWidget {
  final MainModel model;

  BarcodeScreen({this.model});

  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  final double minValue = 8.0;

  bool isScroll = false;

  void _onPreviewTap() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PreviewScreen()));
  }

  void _onGenerateTap() async {
//    DialogHandler.showInforamtionDialog(context: context, content: null);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BarcodeCategoryScreen(
                  model: widget.model,
                )));
  }

  void _onBarcodeScanTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BarcodeScanScreen(
                  model: widget.model,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode"),
        actions: <Widget>[
//          IconButton(icon: Icon(Icons.add), onPressed: () => _onGenerateTap()),
          FlatButton.icon(
              label: Text("Scan Barcode"),
              icon: Icon(Icons.camera_alt),
              textColor: Colors.white,
              onPressed: () => _onBarcodeScanTap()),
          SizedBox(
            width: minValue,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: minValue * 2, vertical: minValue * 2),
            child: Text(
              "All barcodes",
              style:
                  CustomStyle(context).headline6.apply(color: Colors.black87),
            ),
          ),
        ],
      ),
      floatingActionButton: isScroll
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () => _onGenerateTap(),
              child: Icon(Icons.camera),
            )
          : RaisedButton.icon(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              label: Text("Generate Barcode"),
              textColor: Colors.white,
              elevation: 20.0,
              icon: Icon(
                Icons.add,
                size: 35.0,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => _onGenerateTap(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
            ),
    );
  }
}
