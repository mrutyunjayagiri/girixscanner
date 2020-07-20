import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/generateQrCode/generate_form_screen.dart';

class QrCodeTypeScreen extends StatelessWidget {
  final List _items = [
    {
      "icon": FontAwesomeIcons.textHeight,
      "title": "Text",
      "type": QrCodeType.TEXT
    },
    {
      "icon": FontAwesomeIcons.globeAsia,
      "title": "URL",
      "type": QrCodeType.URL
    },
    {
      "icon": FontAwesomeIcons.envelope,
      "title": "Email",
      "type": QrCodeType.EMAIL
    },
    {
      "icon": FontAwesomeIcons.phoneSquareAlt,
      "title": "Phone",
      "type": QrCodeType.PHONE
    },
    {"icon": FontAwesomeIcons.sms, "title": "SMS", "type": QrCodeType.SMS},
    {
      "icon": FontAwesomeIcons.mapMarkedAlt,
      "title": "Location",
      "type": QrCodeType.LOCATION
    },
    {
      "icon": FontAwesomeIcons.idCard,
      "title": "Contact information",
      "type": QrCodeType.ADDRESS
    },
//    {"icon": FontAwesomeIcons.calendar, "title": "Event", "type": QrCodeType.TEXT},
    {
      "icon": FontAwesomeIcons.wifi,
      "title": "WiFi network",
      "type": QrCodeType.WIFI
    },
  ];

  void onTap(BuildContext context, Map<String, dynamic> _item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => GenerateQrCodeScreen(
                  title: _item['title'],
                  qrCodeType: _item['type'],
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
            onTap: () => onTap(context, _item),
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
