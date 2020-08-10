import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/dialog/dialog_handler.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/widgets/animation/my_animation.dart';
import 'package:girixscanner/www/grixcode/com/widgets/download.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class QrCodeDetailScreen extends StatelessWidget {
  final QrCodeProvider provider;

  const QrCodeDetailScreen({Key key, this.provider}) : super(key: key);

  Widget _buildQrImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 280.0,
      alignment: Alignment.center,
      color: provider.background,
      child: Hero(
        tag: provider,
        child: QrImage(
          data: "${provider.data}",
          backgroundColor: provider.background,
          foregroundColor: provider.foreground,
          errorStateBuilder: (context, err) => Text(
            "Failed",
            style: CustomStyle.errorStyle,
          ),
        ),
      ),
    );
  }

  String getHex(Color color) =>
      color.toString().split("ff")[1].replaceAll(')', '');

  Map<String, dynamic> get dataSet => {
        "name": provider.fileName,
        "font": 30.0,
        "height": 120.0,
        "width": 320.0,
        "message": "",
        "background_color": {
          "color": provider.background,
          "hex": getHex(provider.background),
        },
        "foreground_color": {
          "color": provider.foreground,
          "hex": getHex(provider.foreground),
        },
        "image_path": null,
        "secret_data": provider.data
      };

  void onDownload(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (_, __, MainModel model) {
              print(provider.qrVersion);
              return Container(
                padding: EdgeInsets.all(15.0),
                height: 300.0,
                child: DownloadBarcode(
                  dataSet: dataSet,
//                  barcode: Barcode.qrCode(typeNumber: provider.qrVersion),
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

  _showSnacks(BuildContext buildContext, String msg, bool error) async {
    Scaffold.of(buildContext).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
      backgroundColor: error ? Colors.red[700] : Colors.green[700],
    ));
  }

  Future<void> onBarcodeShare(BuildContext context) async {
    try {
      print("Version: ${provider.qrVersion}");
      final bc = Barcode.qrCode();
      final data = await BarcodeUtility.getBarcodePng(bc, dataSet);
      final _fileName = await BarcodeUtility.fileName(dataSet['name']);
      await WcFlutterShare.share(
        sharePopupTitle: '${bc.name} qrcode',
        subject: 'My QrCode',
        text: 'I created ${bc.name} with $APP_NAME. Take a look.',
        fileName: '$_fileName.png',
        mimeType: 'image/png',
        bytesOfFile: data,
      );
    } catch (e) {
      print('error: $e');
    }
  }

  void onBarcodeDelete(BuildContext context, MainModel model) async {
    DialogHandler.showMyCustomDialog(
      context: context,
      content: Text("Are you sure, you want to do this?"),
      titleText: "Delete ${provider.fileName}",
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("CLOSE")),
        FlatButton(
            onPressed: () async {
              int result = await model.deleteQrcode(provider.id);
              if (result != 0) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                _showSnacks(context, "Failed to delete", true);
              }
            },
            child: Text("DELETE")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 1, child: _buildQrImage(context)),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    ListTile(
                      title: Text(
                        'Qr details',
                        style: CustomStyle(context)
                            .headline6
                            .apply(color: Colors.black87),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text('${provider.data}'),
                      subtitle: Text("Data"),
                    ),
                    ListTile(
                      leading: Icon(Icons.insert_drive_file),
                      title: Text('${provider.fileName}'),
                      subtitle: Text("File name"),
                    ),
                    ListTile(
                      leading: Icon(Icons.timelapse),
                      title: Text(
                          '${DateFormat.yMMMMd().format(provider.createdAt)}'),
                      subtitle: Text("Created date"),
                    ),
                    Expanded(
                        child: Align(
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
                                        borderSide:
                                            BorderSide(color: Colors.black26)),
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.deepPurpleAccent,
                                              Theme.of(context).primaryColor,
                                            ])),
                                    child: MaterialButton(
                                      elevation: 0.0,
                                      onPressed: () => onBarcodeShare(context),
                                      child: Text("SHARE"),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(14.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.pink[400],
                                              Colors.red,
                                            ])),
                                    child: ScopedModelDescendant(
                                        builder: (_, __, MainModel model) {
                                      return MaterialButton(
                                        elevation: 0.0,
                                        onPressed: () =>
                                            onBarcodeDelete(context, model),
                                        child: Text("DELETE"),
                                        textColor: Colors.white,
                                        padding: EdgeInsets.all(14.0),
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
