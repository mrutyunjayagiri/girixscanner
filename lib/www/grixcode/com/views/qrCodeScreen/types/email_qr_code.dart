import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/qrUtils/QrCode.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/utils/validator/auth_validator.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/generateQrCode/generate_button.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/generateQrCode/qr_size_field.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/result.dart';

class EmailQrCode extends StatefulWidget {
  @override
  _WiFiQrCodeState createState() => _WiFiQrCodeState();
}

class _WiFiQrCodeState extends State<EmailQrCode> with AuthValidation {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageBodyController = TextEditingController();
  double _width = 0.0;
  double _height = 0.0;
  double _fontSize = 0.0;
  String _message = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSubmit(MainModel model) async {
    if (_formKey.currentState.validate()) {
//      final met = MeTuple.sub("Email", [_emailController.text]).toString();
      final me = QrCode.createEmail(
          email: _emailController.text,
          body: _messageBodyController.text,
          subject: _subjectController.text);

      final svg =
          Barcode.qrCode().toSvg(me.toString(), width: 200, height: 200);

      // Saving to database

      final QrCodeProvider _provider = QrCodeProvider(
          fileName: _emailController.text,
          id: null,
          data: me.toString(),
          barcode: Barcode.qrCode(),
          createdAt: DateTime.now(),
          qrCodeType: QrCodeType.EMAIL);

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
                  "name": BarcodeUtility.fileName(_emailController.text),
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
          leading: Icon(Icons.email),
          title: Text(
            "${_emailController.text}",
            style: style,
          ),
          subtitle: Text("Email"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.text_format),
          title: Text(
            "${_subjectController.text}",
            style: style,
          ),
          subtitle: Text("Subject"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.enhanced_encryption),
          title: Text(
            "${_messageBodyController.text}",
            style: style,
          ),
          subtitle: Text("Message"),
          dense: true,
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text(
            "${_message}",
            style: style,
          ),
          subtitle: Text("Description"),
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
        validator: validateEmail,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Email*",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildSubject() {
    return ListTile(
      title: TextFormField(
        controller: _subjectController,
        keyboardType: TextInputType.text,
        validator: generalValidator,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Subject*",
          labelStyle: CustomStyle.labelStyle,
          errorStyle: CustomStyle.errorStyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildMessageBody() {
    return ListTile(
      title: TextFormField(
        controller: _messageBodyController,
        keyboardType: TextInputType.text,
        validator: generalValidator,
        autofocus: false,
        decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
          labelText: "Message",
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
        "Email Details",
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
                _buildEmail(),
                SizedBox(
                  height: 12.0,
                ),
                _buildSubject(),
                SizedBox(
                  height: 12.0,
                ),
                _buildMessageBody(),
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
