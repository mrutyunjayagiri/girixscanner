import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/utils/validator/auth_validator.dart';

class QrSizedFields extends StatefulWidget {
  final Function onPreviewtext;
  final Function onWithChange;
  final Function onHeightChange;
  final Function onMessageChange;

  const QrSizedFields(
      {Key key,
      this.onPreviewtext,
      this.onWithChange,
      this.onHeightChange,
      this.onMessageChange})
      : super(key: key);

  @override
  _QrSizedFieldsState createState() => _QrSizedFieldsState();
}

class _QrSizedFieldsState extends State<QrSizedFields> with AuthValidation {
  double _fontSizePreview = 0.0;

  final TextEditingController _barcodeHeightController =
      TextEditingController(text: "120");
  final TextEditingController _barcodeWidthController =
      TextEditingController(text: "320");
  final TextEditingController _barcodeFontWeightController =
      TextEditingController(text: "30");

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.onHeightChange(120.0);
    widget.onWithChange(320.0);
    widget.onPreviewtext(30.0);
  }

  void onFontChange(String value) {
    if (value.isEmpty) return;
    if (double.parse(value) > 90) return;
    setState(() {
      _fontSizePreview = double.parse(value);
    });
    widget.onPreviewtext(_fontSizePreview);
  }

  Widget _buildDescription() {
    return TextFormField(
      controller: _descriptionController,
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: widget.onMessageChange,
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "Description",
        labelStyle: CustomStyle.labelStyle,
        errorStyle: CustomStyle.errorStyle,
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }

  Widget _buildBarcodeWidthField() {
    return TextFormField(
      controller: _barcodeWidthController,
      keyboardType: TextInputType.number,
      validator: generalValidator,
      autofocus: false,
      onChanged: (String value) {
        try {
          final _v = double.parse(value);
          widget.onWithChange(_v);
        } catch (e) {
          print("Double Parsing Error: ${e.toString()}");
        }
      },
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "Width",
        labelStyle: CustomStyle.labelStyle,
        errorStyle: CustomStyle.errorStyle,
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }

  Widget _buildBarcodeHeightField() {
    return TextFormField(
      controller: _barcodeHeightController,
      keyboardType: TextInputType.number,
      validator: generalValidator,
      autofocus: false,
      onChanged: (String value) {
        try {
          final _v = double.parse(value);
          widget.onHeightChange(_v);
        } catch (e) {
          print("Double Parsing Error: ${e.toString()}");
        }
      },
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "Height",
        labelStyle: CustomStyle.labelStyle,
        errorStyle: CustomStyle.errorStyle,
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }

  Widget _buildBarcodeFontField() {
    return TextFormField(
      controller: _barcodeFontWeightController,
      keyboardType: TextInputType.number,
      validator: barcodeFontValidator,
      autofocus: false,
      onChanged: onFontChange,
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "Font Height",
        labelStyle: CustomStyle.labelStyle,
        errorStyle: CustomStyle.errorStyle,
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }

  Widget _buildBarcodeFontPreview() {
    return Text(
      "${_barcodeFontWeightController.text}",
      textAlign: TextAlign.right,
      style: TextStyle(fontSize: _fontSizePreview),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildDescription(),
        SizedBox(
          height: 18.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _buildBarcodeHeightField(),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: _buildBarcodeWidthField(),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _buildBarcodeFontField(),
            ),
            Expanded(
              child: _buildBarcodeFontPreview(),
            )
          ],
        ),
      ],
    );
  }
}
