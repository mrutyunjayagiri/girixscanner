import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/dialog/dialog_handler.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import 'file:///G:/PROJECT/Mine/MobileApp/girixscanner/lib/www/grixcode/com/widgets/download.dart';

class GeneratedBarcodeScreen extends StatefulWidget {
  final Map<String, dynamic> dataSet;
  final Barcode barcode;
  final MainModel model;

  GeneratedBarcodeScreen({this.dataSet, this.barcode, this.model})
      : assert(dataSet != null && barcode != null);

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
                padding: EdgeInsets.all(15.0),
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Save as",
                      style: CustomStyle(context).subtitle1,
                    ),
                    DownloadBarcode(
                      dataSet: widget.dataSet,
                      barcode: widget.barcode,
                      model: model,
                    ),
                  ],
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

  void _onBarcodeShare(BuildContext context) async {
    try {
      final bc = widget.barcode;
      final data = await BarcodeUtility.getBarcodePng(bc, widget.dataSet);
      final _fileName = await BarcodeUtility.fileName(widget.dataSet['name']);
      await WcFlutterShare.share(
        sharePopupTitle: '${widget.barcode.name} barcode',
        subject: 'Barcode generation',
        text:
            'I created ${widget.barcode.name} barcode with $APP_NAME. Take a look.',
        fileName: '$_fileName.png',
        mimeType: 'image/png',
        bytesOfFile: data,
      );
    } catch (e) {
      print('error: $e');
    }
  }

  void _onCreated() async {
    final BarcodeProvider _provider = BarcodeProvider(
        barcode: widget.barcode,
        data: widget.dataSet['secret_data'],
        barcodeType: null,
        fileName: widget.dataSet['name'],
        path: "",
        QrType: "");

    final BarcodeProvider _result = await widget.model.addBarcode(_provider);
    if (_result != null) {
      print("Result id: ${_result.id}");
    } else {
      print("Not Inserted..");
    }
  }

  void _onDeleteBarcode() async {
    DialogHandler.showMyCustomDialog(
      context: context,
      content: Text("Are you sure, you want to do this"),
      titleText: "Delete ${widget.dataSet['name']}",
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("CLOSE")),
        FlatButton(
            onPressed: () async {
              int result =
                  await widget.model.deleteBarcode(widget.dataSet['id']);
              if (result != 0) {
                await widget.model.fetchAllBarcode();
                _showSnack("", true);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            child: Text("DELETE")),
      ],
    );
  }

  void _showSnack(String message, bool type) {}

  @override
  void initState() {
    super.initState();

//    _onCreated();
  }

  @override
  void dispose() {
    widget.model.disposeLoader();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _dataSet = widget.dataSet;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Result"),
        actions: <Widget>[
//          IconButton(icon: Icon(Icons.share), onPressed: () => null),
//          IconButton(icon: Icon(Icons.save), onPressed: () => onDownload()),
          IconButton(icon: Icon(Icons.delete), onPressed: _onDeleteBarcode),
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
                    "Barcode Name: ${widget.barcode.name}",
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
                    height: 10.0,
                  ),
                  Text(
                    " ${_dataSet['secret_data']}",
                    style: CustomStyle(context)
                        .subtitle1
                        .apply(color: Colors.black87, fontWeightDelta: 1),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0.0,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  Text(
//                    "Barcode",
//                    style: CustomStyle(context)
//                        .headline6
//                        .apply(color: Colors.black54),
//                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: BarcodeWidget(
                      barcode: widget.barcode,
                      data: _dataSet['secret_data'],
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 120.0,
                      style: TextStyle(fontSize: _dataSet['font']),
                      errorBuilder: (BuildContext context, String error) {
                        return Text("Failed to load barcode: $error");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    elevation: 0.0,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26)),
                    onPressed: () => onDownload(),
                    child: Text("SAVE"),
                    textColor: Theme
                        .of(context)
                        .primaryColor,
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.deepPurpleAccent,
                              Theme
                                  .of(context)
                                  .primaryColor,
                            ])),
                    child: MaterialButton(
                      elevation: 0.0,
                      onPressed: () => _onBarcodeShare(context),
                      child: Text("SHARE"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(14.0),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
