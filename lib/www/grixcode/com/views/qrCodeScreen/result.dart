import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode.dart';
import 'package:girixscanner/www/grixcode/com/widgets/animation/my_animation.dart';
import 'package:girixscanner/www/grixcode/com/widgets/download.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class QrCodeResultScreen extends StatelessWidget {
  final Map<String, dynamic> dataSet;
  final QrCodeProvider qrCodeProvider;
  final Widget child;

  const QrCodeResultScreen({this.dataSet, this.qrCodeProvider, this.child});

  void onDownload(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (_, __, MainModel model) {
              return Container(
                padding: EdgeInsets.all(15.0),
                height: 300.0,
                child: DownloadBarcode(
                  dataSet: dataSet,
                  barcode: Barcode.qrCode(),
                  model: model,
                ),
              );
            },
          );
        }).then((value) {
      if (value) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "File saved successfully",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          backgroundColor: Colors.green[700],
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
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
      final bc = Barcode.qrCode();
      final data = await BarcodeUtility.getBarcodePng(bc, dataSet);
      final _fileName = await BarcodeUtility.fileName(dataSet['name']);
      await WcFlutterShare.share(
        sharePopupTitle: '${bc.name} barcode',
        subject: 'Barcode generation',
        text: 'I created ${bc.name} barcode with $APP_NAME. Take a look.',
        fileName: '$_fileName.png',
        mimeType: 'image/png',
        bytesOfFile: data,
      );
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
                  child: child,
                ),
                SizedBox(
                  height: 20.0,
                ),
                MyFadeAnimation(
                  delay: 0.1,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: BarcodeWidget(
                        data: qrCodeProvider.data,
                        barcode: Barcode.qrCode(),
                        height: 210.0,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Builder(builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(12.0),
                child: MyFadeAnimation(
                  delay: 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          elevation: 0.0,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26)),
                          onPressed: () => onDownload(context),
                          child: Text("SAVE"),
                          textColor: Theme.of(context).primaryColor,
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
                                    Theme.of(context).primaryColor,
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
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
