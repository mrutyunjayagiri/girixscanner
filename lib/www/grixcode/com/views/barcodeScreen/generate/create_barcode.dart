import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/utils/validator/auth_validator.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/generate/generated_barcode_screen.dart';
import 'package:girixscanner/www/grixcode/com/widgets/loader.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateBarcodeScreen extends StatefulWidget {
  final BarcodeInfo barcodeInfo;

  CreateBarcodeScreen({this.barcodeInfo});

  @override
  _CreateBarcodeScreenState createState() => _CreateBarcodeScreenState();
}

class _CreateBarcodeScreenState extends State<CreateBarcodeScreen>
    with AuthValidation {
  final TextEditingController _barcodeNameController = TextEditingController();
  final TextEditingController _barcodeDataController = TextEditingController();
  final TextEditingController _barcodeHeightController =
      TextEditingController(text: "120");
  final TextEditingController _barcodeWidthController =
      TextEditingController(text: "320");
  final TextEditingController _barcodeFontWeightController =
      TextEditingController(text: "30");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double _fontSizePreview = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fontSizePreview = double.parse(_barcodeFontWeightController.text);
    _barcodeNameController.text = widget.barcodeInfo.barcode.name;
  }

  void onFontChange(String value) {
    if (value.isEmpty) return;
    if (double.parse(value) > 90) return;
    setState(() {
      _fontSizePreview = double.parse(value);
    });
  }

  void _onCreateBarcode(MainModel model) async {
    try {
      setState(() {
        isLoading = true;
      });
      final width = double.parse(_barcodeWidthController.text);
      final height = double.parse(_barcodeHeightController.text);

      final svg = widget.barcodeInfo.barcode.toSvg(
        _barcodeDataController.text,
        width: width,
        height: height,
        fontHeight: _fontSizePreview,
      );

      // Save the image
      final _name = _barcodeNameController.text.isEmpty
          ? widget.barcodeInfo.barcode.name
              .replaceAll(RegExp(r'\s'), '-')
              .toLowerCase()
          : _barcodeNameController.text;
//      final file = File('$_name.svg').writeAsStringSync(svg);
      final Map<String, dynamic> _data = {
        "name": _name,
        "width": width,
        "height": height,
        "font": _fontSizePreview,
        "secret_data": _barcodeDataController.text,
        "svg": svg
      };
      setState(() {
        isLoading = false;
      });
      // Save To Device
      await _saveToDevice(_data, model).then((_result) {
        if (_result != null) {
          print("Result id: ${_result.id}");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => GeneratedBarcodeScreen(
                        barcode: widget.barcodeInfo.barcode,
                        dataSet: {..._data, "id": _result.id},
                        model: model,
                      )));
        } else {
          print("Not Inserted..");
          _snackBar("File not saved", true);
        }
      }).catchError((e) {
        _snackBar("File not saved\n${e.message}", true);
      });

      _resetToDefault();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _resetToDefault();
      if (e is BarcodeException) {
        _snackBar("Invalid data\n${e.message}", true);
        return;
      }
      _snackBar("Invalid data", true);
    }
  }

  Future _saveToDevice(Map<String, dynamic> dataSet, MainModel model) async {
    final BarcodeProvider _provider = BarcodeProvider(
        barcode: widget.barcodeInfo.barcode,
        data: dataSet['secret_data'],
        barcodeType: widget.barcodeInfo.type,
        fileName: dataSet['name'],
        path: "",
        QrType: "");

    return await model.addBarcode(_provider);
  }

  void _snackBar(String message, bool error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "$message",
        style: CustomStyle(context).subtitle1.apply(color: Colors.white),
      ),
      backgroundColor: error ? Colors.red[700] : Colors.green,
      elevation: 15.0,
    ));
  }

  void _resetToDefault() {
    _fontSizePreview = 30.0;
    _barcodeNameController.text = widget.barcodeInfo.barcode.name;
    _barcodeDataController.text = "";
  }

  Widget _buildBarcodeNameField() {
    return TextFormField(
      controller: _barcodeNameController,
      keyboardType: TextInputType.text,
      validator: generalValidator,
      autofocus: false,
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "File name",
        labelStyle: CustomStyle.labelStyle,
        errorStyle: CustomStyle.errorStyle,
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }

  Widget _buildBarcodeDataField() {
    return TextFormField(
      controller: _barcodeDataController,
      keyboardType: TextInputType.text,
      validator: generalValidator,
      autofocus: false,
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "Data*",
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

  Widget _buildBarcodeSubmitButton() {
    return ScopedModelDescendant(
      builder: (_, __, MainModel model) {
        return isLoading
            ? Loader()
            : MaterialButton(
                onPressed: () => _onCreateBarcode(model),
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                textColor: Colors.white,
                elevation: 0.0,
                minWidth: MediaQuery.of(context).size.width,
                child: Text("GENERATE"),
              );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widget.barcodeInfo.barcode.name}",
                style:
                    CustomStyle(context).headline6.apply(color: Colors.black87),
              ),
              SizedBox(
                height: 8,
              ),
              Flexible(
                  child: Text(
                "${widget.barcodeInfo.description.split('.')[0]}.",
                style:
                    CustomStyle(context).bodyText2.apply(color: Colors.black54),
              )),
              SizedBox(
                height: 10,
              ),
              Text.rich(TextSpan(text: "Length- ", children: [
                TextSpan(text: "Min: ${widget.barcodeInfo.barcode.minLength}"),
                TextSpan(text: " "),
                TextSpan(text: "Max: ${widget.barcodeInfo.barcode.maxLength}")
              ]))
            ],
          )),
          SizedBox(
            width: 12.0,
          ),
          Container(
            child: FaIcon(
              widget.barcodeInfo.category == BarcodeCategory.OneD
                  ? FontAwesomeIcons.barcode
                  : FontAwesomeIcons.qrcode,
              size: 80.0,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create ${widget.barcodeInfo.barcode.name} barcode"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            children: <Widget>[
              _buildHeader(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Fill the details",
                style:
                    CustomStyle(context).headline6.apply(color: Colors.black87),
              ),
              SizedBox(
                height: 20.0,
              ),
              _buildBarcodeNameField(),
              SizedBox(
                height: 20.0,
              ),
              _buildBarcodeDataField(),
              SizedBox(
                height: 20.0,
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
              SizedBox(
                height: 40.0,
              ),
              _buildBarcodeSubmitButton()
            ],
          ),
        ),
      ),
    );
  }
}
