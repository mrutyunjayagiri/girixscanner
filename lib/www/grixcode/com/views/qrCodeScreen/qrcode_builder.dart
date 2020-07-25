import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_item.dart';

class QrCodeBuilder extends StatelessWidget {
  final List<BarcodeItem> qrCodeProviders;
  final Function builder;

  const QrCodeBuilder({Key key, this.qrCodeProviders, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: false,
        padding: EdgeInsets.only(top: 12.0, bottom: 50),
        itemBuilder: builder,
        separatorBuilder: (context, index) => Divider(),
        itemCount: qrCodeProviders.length);
  }
}
