import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/barcode_builder.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/generate/generated_barcode_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/generate/select_category_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/preview_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/scannerScreen/scanner_button.dart';
import 'package:girixscanner/www/grixcode/com/widgets/error/error.dart';
import 'package:girixscanner/www/grixcode/com/widgets/loader.dart';
import 'package:scoped_model/scoped_model.dart';

class BarcodeScreen extends StatefulWidget {
  final MainModel model;

  BarcodeScreen({this.model});

  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  final double minValue = 8.0;

  bool isScroll = false;

  void _onPreviewTap() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PreviewScreen()));
  }

  void _onGenerateTap() async {
//    DialogHandler.showInforamtionDialog(context: context, content: null);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BarcodeCategoryScreen(
                  model: widget.model,
                )));
  }

  void _barcodeTileTap(BarcodeProvider barcodeProvider) {
    final Map<String, dynamic> _data = {
      "name": barcodeProvider.fileName,
      "id": barcodeProvider.id,
      "width": 320.0,
      "height": 120.0,
      "font": 30.0,
      "secret_data": barcodeProvider.data,
      "svg": null
    };

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => GeneratedBarcodeScreen(
                  barcode: barcodeProvider.barcode,
                  dataSet: _data,
                  model: widget.model,
                )));
  }

  void _onCreated() async {
    await widget.model.fetchAllBarcode();
  }

  @override
  void initState() {
    super.initState();

    _onCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode"),
        actions: <Widget>[
          ScannerButton(),
          SizedBox(
            width: minValue,
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ScopedModelDescendant(builder: (_, __, MainModel model) {
          return model.isLoading
              ? Loader()
              : model.barcodeProviders == null ||
                      model.barcodeProviders.length == 0
                  ? ErrorView(
                      errorType: ErrorResponse.EMPTY,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(
//                              horizontal: minValue * 2, vertical: minValue * 2),
//                          child: Text(
//                            "My Barcode",
//                            style: CustomStyle(context)
//                                .headline6
//                                .apply(color: Colors.black87),
//                          ),
//                        ),
                        Expanded(
                          child: BarcodeBuilder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 25.0),
                            barcodes: model.barcodeProviders,
                            builder: (BuildContext context, int index) {
                              final BarcodeProvider _bar =
                                  model.barcodeProviders[index];
                              return BarcodeProviderTile(
                                barcodeProvider: _bar,
                                onTap: () => _barcodeTileTap(_bar),
                              );
                            },
                          ),
                        ),
                      ],
                    );
        }),
      ),
      floatingActionButton: isScroll
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () => _onGenerateTap(),
              child: Icon(Icons.camera),
            )
          : RaisedButton.icon(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              label: Text("Generate Barcode"),
              textColor: Colors.white,
              elevation: 20.0,
              icon: Icon(
                Icons.add,
                size: 35.0,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => _onGenerateTap(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
            ),
    );
  }
}

class BarcodeProviderTile extends StatelessWidget {
  final BarcodeProvider barcodeProvider;
  final Function onTap;

  BarcodeProviderTile({this.barcodeProvider, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 70.0,
          width: 70.0,
          child: Card(
              child: Container(
            margin: EdgeInsets.all(8),
            child: BarcodeWidget(
              barcode: barcodeProvider.barcode,
              data: barcodeProvider.data,
              style: TextStyle(fontSize: 10.0),
              errorBuilder: (BuildContext context, String error) {
                return Text("Failed to load barcode: $error");
              },
            ),
          )),
        ),
        Expanded(
            child: Container(
          height: 70.0,
          child: ListTile(
            onTap: onTap,
            title: Text(
              "${barcodeProvider.fileName}",
              style: CustomStyle(context).subtitle1,
            ),
            subtitle: Text(
              "${barcodeProvider.data}",
              style: CustomStyle(context).caption,
            ),
          ),
        ))
      ],
    ));
  }
}
