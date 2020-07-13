import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/download.dart';
import 'package:scoped_model/scoped_model.dart';

class GeneratedBarcodeScreen extends StatefulWidget {
  final Map<String, dynamic> dataSet;
  final BarcodeInfo barcodeInfo;

  GeneratedBarcodeScreen({this.dataSet, this.barcodeInfo})
      : assert(dataSet != null && barcodeInfo != null);

  @override
  _GeneratedBarcodeScreenState createState() => _GeneratedBarcodeScreenState();
}

class _GeneratedBarcodeScreenState extends State<GeneratedBarcodeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onDownload() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (_, __, MainModel model) {
              return Container(
                height: 320.0,
                child: DownloadBarcode(
                  dataSet: widget.dataSet,
                  barcodeInfo: widget.barcodeInfo,
                  model: model,
                ),
              );
            },
          );
        }).then((value) {
      if (value) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "File saved successfully",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          backgroundColor: Colors.green[700],
        ));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "Unable to save",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          backgroundColor: Colors.red[700],
        ));
      }
    }).catchError((err) => print(err.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final _dataSet = widget.dataSet;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Result"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () => null),
          IconButton(icon: Icon(Icons.save), onPressed: () => onDownload()),
          IconButton(icon: Icon(Icons.delete), onPressed: () => null),
          SizedBox(
            width: 12.0,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Information",
                    style: CustomStyle(context)
                        .headline6
                        .apply(color: Colors.black87),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Barcode Name: ${widget.barcodeInfo.barcode.name}",
                    style: CustomStyle(context)
                        .subtitle1
                        .apply(color: Colors.black87),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Height: ${_dataSet['height']}",
                    style: CustomStyle(context)
                        .subtitle1
                        .apply(color: Colors.black87),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Width: ${_dataSet['width']}",
                    style: CustomStyle(context)
                        .subtitle1
                        .apply(color: Colors.black87),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Font Height: ${_dataSet['font']}",
                    style: CustomStyle(context)
                        .subtitle1
                        .apply(color: Colors.black87),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Data: ${_dataSet['secret_data']}",
                    style: CustomStyle(context)
                        .headline6
                        .apply(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 15.0,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Barcode",
                    style: CustomStyle(context)
                        .headline6
                        .apply(color: Colors.black87),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: BarcodeWidget(
                      barcode: widget.barcodeInfo.barcode,
                      data: _dataSet['secret_data'],
                      width: MediaQuery.of(context).size.width,
                      height: 120.0,
                      style: TextStyle(fontSize: _dataSet['font']),
                      errorBuilder: (BuildContext context, String error) {
                        return Text("Failed to load barcode: $error");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
