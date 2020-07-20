import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/utils/validator/auth_validator.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/generateQrCode/generate_button.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/generateQrCode/qr_size_field.dart';

class WiFiQrCode extends StatefulWidget {
  @override
  _WiFiQrCodeState createState() => _WiFiQrCodeState();
}

class _WiFiQrCodeState extends State<WiFiQrCode> with AuthValidation {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double _width = 0.0;
  double _height = 0.0;
  double _fontSize = 0.0;
  String _message = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _hiddenValue = false;

  void _onHiddenChange(bool value) {
    setState(() {
      _hiddenValue = value;
    });
  }

  void _onSubmit(MainModel model) async {
    if (_formKey.currentState.validate()) {
      final me = MeCard.wifi(
          ssid: _ssidController.text,
          password: _passwordController.text,
          hidden: _hiddenValue,
          type: _encriptionType);

      final svg =
          Barcode.qrCode().toSvg(me.toString(), width: 200, height: 200);

      // Saving to database

      final QrCodeProvider _provider = QrCodeProvider(
          fileName: BarcodeUtility.fileName(_ssidController.text),
          id: null,
          data: svg,
          barcode: Barcode.qrCode(),
          createdAt: DateTime.now(),
          qrCodeType: QrCodeType.WIFI);

      final QrCodeProvider _result = await model.addQrcode(_provider);
      print("Result: ${_result.id}");
    }
  }

  Widget _buildTranferWidget() {}

  Widget _buildSsid() {
    return ListTile(
      title: TextFormField(
        controller: _ssidController,
        keyboardType: TextInputType.text,
        validator: generalValidator,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "SSID*",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return ListTile(
      title: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.text,
        validator: generalValidator,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Password*",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildHiddenBox() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _hiddenValue,
          onChanged: _onHiddenChange,
          activeColor: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Hidden",
          style: CustomStyle.labelStyle,
        )
      ],
    );
  }

  Widget _buildHeader() {
    return ListTile(
      title: Text(
        "WiFi network details",
        style: CustomStyle(context).headline6.apply(color: Colors.black87),
      ),
    );
  }

  String _encriptionType = _encriptionList[0];
  static final List<String> _encriptionList = ['WPA/WPA2', 'WEP'];

  Widget _buildDropDown() {
    return DropdownButton<String>(
        hint: Text("$_encriptionType"),
        style: CustomStyle.labelStyle,
        items: _encriptionList
            .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                  child: Text("$e"),
                  value: e,
                  onTap: () {
                    setState(() {
                      _encriptionType = e;
                    });
                  },
                ))
            .toList(),
        onChanged: (String v) {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                _buildHeader(),
                SizedBox(
                  height: 12.0,
                ),
                _buildSsid(),
                SizedBox(
                  height: 12.0,
                ),
                _buildPassword(),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Encryption",
                        style: CustomStyle.labelStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: _buildDropDown()),
                          _buildHiddenBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                )
              ],
            ),
          ),
        ),
        GenerateButton(
          onGenerate: _onSubmit,
        )
      ],
    );
  }
}
