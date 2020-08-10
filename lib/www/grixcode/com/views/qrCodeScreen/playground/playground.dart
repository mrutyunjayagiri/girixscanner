import 'dart:io';
import 'dart:math';

import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/colors.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/colorPickerScreen/color_picker.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/generateQrCode/qr_size_field.dart';
import 'package:girixscanner/www/grixcode/com/widgets/animation/my_animation.dart';
import 'package:girixscanner/www/grixcode/com/widgets/download.dart';
import 'package:girixscanner/www/grixcode/com/widgets/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class QrCodePlayGround extends StatefulWidget {
  final MainModel model;

  const QrCodePlayGround({Key key, this.model}) : super(key: key);

  @override
  _QrCodePlayGroundState createState() => _QrCodePlayGroundState();
}

class _QrCodePlayGroundState extends State<QrCodePlayGround> {
  final TextEditingController _textEditingController = TextEditingController();

  Color _foregroundColor = Colors.deepPurple[900];
  Color _backgroundColor = Colors.grey[200];
  int _qrVersion = -1;
  String _dataText = "";

  File _logoFile;

  double _width = 0.0;
  double _height = 0.0;
  double _fontSize = 0.0;
  String _message = "";

  void _onCreated() async {
    _textEditingController.text = 'Play ground';
    _dataText = _textEditingController.text;
  }

  void _onSaveExportTap(BuildContext buildContext) async {
    print("Background color: ${_backgroundColor}");

    final QrCodeProvider _provider = QrCodeProvider(
        fileName: dataSet['name'],
        id: null,
        data: _dataText.toString(),
//        barcode: Barcode.qrCode(typeNumber: _qrVersion == -1 ? 1 : _qrVersion),
        barcode: Barcode.qrCode(),
        background: _backgroundColor,
        foreground: _foregroundColor,
        createdAt: DateTime.now(),
        qrVersion: _qrVersion,
        qrCodeType: QrCodeType.PLAYGROUND);

    final QrCodeProvider _result = await widget.model.addQrcode(_provider);
    print("Result: ${_result.id}");
    if (_result == 0) {
      _showSnacks(buildContext, "Failed to save", true);
    }
    await _openSaveModal(buildContext);
  }

  String getHex(Color color) =>
      color.toString().split("ff")[1].replaceAll(')', '');

  _showSnacks(BuildContext buildContext, String msg, bool error) async {
    Scaffold.of(buildContext).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
      backgroundColor: error ? Colors.red[700] : Colors.green[700],
    ));
  }

  Future<void> onBarcodeShare() async {
    try {
      final bc = Barcode.qrCode(typeNumber: _qrVersion);
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

  Map<String, dynamic> get dataSet =>
      {
        "name": BarcodeUtility.fileName("Playground_"),
        "font": _fontSize,
        "height": _height,
        "width": _width,
        "message": _message,
        "background_color": {
          "color": _backgroundColor,
          "hex": getHex(_backgroundColor),
        },
        "foreground_color": {
          "color": _foregroundColor,
          "hex": getHex(_foregroundColor),
        },
        "image_path": _logoFile == null ? "" : _logoFile.path,
        "secret_data": _textEditingController.text
      };

  void _openSaveModal(BuildContext buildContext) async {
    print(getHex(_backgroundColor));

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: DownloadBarcode(
              barcode: Barcode.qrCode(),
//              barcode: Barcode.qrCode(
//                  typeNumber:
//                      _qrVersion == -1 || _qrVersion == 1 ? 2 : _qrVersion),
              model: widget.model,
              dataSet: dataSet,
            ),
          );
        }).then((value) {
      if (value == null) return;
      if (!value) {
        _showSnacks(buildContext, "Unable to save", true);
      } else {
        _showSnacks(buildContext, "File saved successfully", false);
      }
    }).catchError(
        (onError) => _showSnacks(buildContext, onError.toString(), true));
  }

  @override
  void initState() {
    super.initState();

    _onCreated();
  }

  void _reset() {
    double _width = 0.0;
    double _height = 0.0;
    double _fontSize = 0.0;
    String _message = "";

    _foregroundColor = Colors.deepPurple[900];
    _backgroundColor = Colors.grey[200];
    _qrVersion = 1;
    _dataText = "Play Ground";

    _logoFile = null;
    setState(() {});
  }

  void _onVersionChange(double value) {
    print("data Text Length: ${_dataText.length}");
    if (value.toInt() == 1) return;

    /// There is Bug While Version is set To 1;
    setState(() {
      _qrVersion = value.toInt();
    });
  }

  void _onColorSelect(String type) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ColorPicker(
              title: type,
              onFinished: (Color color) {
                if (!mounted) return;
                setState(() {
                  if (type == "Foreground") {
                    _foregroundColor = color;
                  } else {
                    _backgroundColor = color;
                  }
                });
              },
            )));
  }

  void _onDataTextChange(String value) {
    setState(() {
      _dataText = value;
    });
    print("data Text Length: ${_dataText.length}");
  }

  void onLogoTap() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => GsImagePicker()))
        .then((pickedFile) {
      if (!mounted) return;
      setState(() {
        _logoFile = File(pickedFile.path);
      });
    });
  }

  Widget _buildSizeFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: QrSizedFields(
        onHeightChange: (double height) {
          _height = height;
        },
        onPreviewtext: (double preview) {
          _fontSize = preview;
        },
        onWithChange: (double width) {
          _width = width;
        },
        onMessageChange: (String msg) {
          _message = msg;
        },
      ),
    );
  }

  Widget _buildBtn() {
    return MyFadeAnimation(
      delay: 0.1,
      child: Builder(builder: (BuildContext buildContext) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(3.0),
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
            onPressed: () => _onSaveExportTap(buildContext),
            child: Text("SAVE & EXPORT"),
            textColor: Colors.white,
          ),
        );
      }),
    );
  }

  Widget _buildFile() {
    return _buildTile(
        title: "Logo",
        child: Row(
          children: <Widget>[
            Expanded(
                child: _logoFile == null
                    ? Text("Select logo")
                    : Text("Logo${Random(1).nextInt(145)}")
//
                ),
            _logoFile != null
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _logoFile = null;
                      });
                    },
                    icon: Icon(
                      Icons.clear,
                      size: 19.0,
                    ),
                    color: Colors.black54,
                  )
                : Container(),
            IconButton(
              onPressed: () => onLogoTap(),
              icon: Icon(
                Icons.edit,
                size: 19.0,
              ),
              color: Colors.black54,
            )
          ],
        ));
  }

  Widget _buildText() {
    return ListTile(
      title: TextFormField(
        controller: _textEditingController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        onChanged: _onDataTextChange,
        decoration: InputDecoration(
          isDense: true,
//              prefixIcon: Icon(Icons.person),
          labelText: "Data",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildVersion() {
    return _buildTile(
        title: "Version",
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Slider(
            value: _qrVersion.toDouble(),
            onChanged: _onVersionChange,
            activeColor: primaryColor,
            label: "$_qrVersion",
            divisions: 20,
            max: 40,
            min: -1,
          ),
        ));
  }

  Widget _buildQrImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[50],
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 250.0,
          width: 250.0,
          child: Card(
            elevation: 0.0,
            child: QrImage(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
                backgroundColor: _backgroundColor,
                foregroundColor: _foregroundColor,
                data: "$_dataText",
                version: _qrVersion,
                gapless: false,
                embeddedImage: _logoFile == null ? null : FileImage(_logoFile),
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "${err.toString()}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

//              embeddedImageStyle: QrEmbeddedImageStyle(size: Size(35, 45)),
                ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    SystemConfig.setStatusBarColor(Colors.red);

    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black87,
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            "Qr Playground",
            style: CustomStyle(context).headline6,
          ),
          backgroundColor: Colors.grey[100],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => onBarcodeShare(),
              color: Colors.black87,
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _reset(),
              color: Colors.black87,
            ),
            SizedBox(
              width: 12.0,
            )
          ],
        ),
//          backgroundColor: Colors.grey[100],
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildQrImage(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildText(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildColor(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildVersion(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildFile(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSizeFields(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildBtn(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile({String title, Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title",
            style: CustomStyle(context).subtitle1.apply(fontWeightDelta: 1),
          ),
          SizedBox(
            height: 8.0,
          ),
          child
        ],
      ),
    );
  }

  Widget _buildColor() {
    return _buildTile(
      title: "Color",
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () => _onColorSelect("Foreground"),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                          color: _foregroundColor,
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Qr foreground")
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _onColorSelect("Background"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                          color: _backgroundColor,
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Qr background")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
