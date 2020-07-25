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
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/result.dart';

class ContactQrCode extends StatefulWidget {
  @override
  _WiFiQrCodeState createState() => _WiFiQrCodeState();
}

class _WiFiQrCodeState extends State<ContactQrCode> with AuthValidation {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _urlController =
      TextEditingController(text: "https://");

  double _width = 0.0;
  double _height = 0.0;
  double _fontSize = 0.0;
  String _message = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSubmit(MainModel model) async {
    if (_formKey.currentState.validate()) {
//      final met = MeTuple.sub("Email", [_emailController.text]).toString();
      final me = MeCard.contact(
          email: _emailController.text,
          name: _nameController.text,
          address: _addressController.text,
          nickname: _nickNameController.text,
          url: _urlController.text,
          tel: _phoneController.text);

      final svg =
          Barcode.qrCode().toSvg(me.toString(), width: 200, height: 200);

      // Saving to database

      final QrCodeProvider _provider = QrCodeProvider(
          fileName: _emailController.text,
          id: null,
          data: me.toString(),
          barcode: Barcode.qrCode(),
          createdAt: DateTime.now(),
          qrCodeType: QrCodeType.ALL);

      final QrCodeProvider _result = await model.addQrcode(_provider);
      print("Result: ${_result.id}");
      if (_result == 0) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Failed to save"),
          backgroundColor: Colors.red,
        ));
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => QrCodeResultScreen(
                child: _buildTransferWidget(),
                dataSet: {
                  "name": BarcodeUtility.fileName(_nameController.text.isEmpty
                      ? _emailController.text
                      : _nameController.text),
                  "font": _fontSize,
                  "height": _height,
                  "width": _width,
                  "message": _message,
                  "secret_data": me.toString()
                },
                qrCodeProvider: _result,
              )));
    }
  }

  Widget _buildTransferWidget() {
    final style = TextStyle(fontSize: 18.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            "${_nameController.text}",
            style: style,
          ),
          subtitle: Text("Name"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.perm_identity),
          title: Text(
            "${_nickNameController.text}",
            style: style,
          ),
          subtitle: Text("Nick Name"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text(
            "${_emailController.text}",
            style: style,
          ),
          subtitle: Text("Email"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(
            "${_phoneController.text}",
            style: style,
          ),
          subtitle: Text("Phone No"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text(
            "${_addressController.text}",
            style: style,
          ),
          subtitle: Text("Address"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(
            "${_urlController.text}",
            style: style,
          ),
          subtitle: Text("URL"),
          dense: true,
        )
      ],
    );
  }

  Widget _buildEmail() {
    return ListTile(
      title: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Email",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildName() {
    return ListTile(
      title: TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Name",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildNick() {
    return ListTile(
      title: TextFormField(
        controller: _nickNameController,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Nick Name",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildPhone() {
    return ListTile(
      title: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.numberWithOptions(),
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Phone",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return ListTile(
      title: TextFormField(
        controller: _addressController,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Address",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildUrl() {
    return ListTile(
      title: TextFormField(
        controller: _urlController,
        keyboardType: TextInputType.url,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "URL",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      title: Text(
        "Contact QR Code",
        style: CustomStyle(context).headline6.apply(color: Colors.black87),
      ),
    );
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
                _buildName(),
                SizedBox(
                  height: 12.0,
                ),
                _buildNick(),
                SizedBox(
                  height: 12.0,
                ),
                _buildEmail(),
                SizedBox(
                  height: 12.0,
                ),
                _buildPhone(),
                SizedBox(
                  height: 12.0,
                ),
                _buildAddress(),
                SizedBox(
                  height: 12.0,
                ),
                _buildUrl(),
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
