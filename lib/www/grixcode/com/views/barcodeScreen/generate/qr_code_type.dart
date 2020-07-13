import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/generate/create_barcode.dart';

class QrCodeTypeScreen extends StatelessWidget {
  final BarcodeInfo barcodeInfo;

  final List _items = [
    {"icon": FontAwesomeIcons.textHeight, "title": "Text"},
    {"icon": FontAwesomeIcons.globeAsia, "title": "URL"},
    {"icon": FontAwesomeIcons.envelope, "title": "Email"},
    {"icon": FontAwesomeIcons.phoneSquareAlt, "title": "Phone"},
    {"icon": FontAwesomeIcons.sms, "title": "SMS"},
    {"icon": FontAwesomeIcons.mapMarkedAlt, "title": "Location"},
    {"icon": FontAwesomeIcons.idCard, "title": "Contact information"},
    {"icon": FontAwesomeIcons.calendar, "title": "Event"},
    {"icon": FontAwesomeIcons.wifi, "title": "WiFi network"},
  ];

  QrCodeTypeScreen({this.barcodeInfo});

  void onTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CreateBarcodeScreen(
                  barcodeInfo: barcodeInfo,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose QR code"),
      ),
      body: ListView.separated(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> _item = _items[index];

          return ListTile(
            onTap: () => onTap(context),
            leading: FaIcon(
              _item['icon'],
              size: 22,
            ),
            title: Text(
              "${_item['title']}",
              style: CustomStyle(context).subtitle1,
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
