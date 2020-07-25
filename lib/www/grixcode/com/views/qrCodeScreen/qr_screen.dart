import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_item.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/models/data/shared_data.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/qr_code_type.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/qrcode_builder.dart';
import 'package:girixscanner/www/grixcode/com/views/scannerScreen/scanner_button.dart';
import 'package:girixscanner/www/grixcode/com/widgets/error/error.dart';
import 'package:girixscanner/www/grixcode/com/widgets/loader.dart';
import 'package:scoped_model/scoped_model.dart';

class QrCodeScreen extends StatefulWidget {
  final MainModel model;

  QrCodeScreen({Key key, this.model});

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrCodeScreen> {
  final double minValue = 8.0;

  String _data = "";

  void _onCreateQrCode() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => QrCodeTypeScreen()));
  }

  Future<void> _onCreated() async {
    final qrItems = await widget.model.fetchQrCode();
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
        title: Text("QrCode"),
        actions: <Widget>[
          ScannerButton(
            title: "Scan QrCode",
          ),
          SizedBox(
            width: minValue,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onCreated,
        child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ScopedModelDescendant(
                    builder: (_, __, MainModel model) {
                      return model.isLoading
                          ? Loader()
                          : model.qrCodeProviders.length == 0
                              ? ErrorView(
                                  errorType: ErrorResponse.EMPTY,
                                )
                              : QrCodeBuilder(
                                  qrCodeProviders: model.qrCodeProviders,
                                  builder: (BuildContext context, int index) {
                                    final item = model.qrCodeProviders[index];
                                    if (item is BarcodeHeader) {
                                      return ListTile(
                                        title: Text(
                                          "${item.dateText}",
                                          style: CustomStyle(context).bodyText2,
                                        ),
                                      );
                                    } else if (item is QrCodeProvider) {
                                      return QrCodeTile(
                                        provider: item,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );
                    },
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: RaisedButton.icon(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        label: Text("Generate QrCode"),
        textColor: Colors.white,
        elevation: 20.0,
        icon: Icon(
          Icons.add,
          size: 35.0,
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () => _onCreateQrCode(),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      ),
    );
  }
}

class QrCodeTile extends StatelessWidget {
  final QrCodeProvider provider;

  const QrCodeTile({Key key, this.provider}) : super(key: key);

  Map<String, dynamic> get categoryMap => qrCodeCategories
      .firstWhere((Map map) => map['type'] == provider.qrCodeType);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        categoryMap['icon'],
        color: Colors.black54,
        size: 21.0,
      ),
      title: Text(
        "${provider.fileName}",
        style: CustomStyle(context)
            .subtitle1
            .apply(color: Colors.black87, fontWeightDelta: 1),
      ),
      subtitle: Text("${categoryMap['title']}"),
      dense: true,
    );
  }
}
