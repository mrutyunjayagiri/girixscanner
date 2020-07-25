import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';

final List<Map<String, dynamic>> qrCodeCategories = [
//  {
//    "icon": FontAwesomeIcons.textHeight,
//    "title": "Text",
//    "type": QrCodeType.TEXT
//  },
//  {"icon": FontAwesomeIcons.globeAsia, "title": "URL", "type": QrCodeType.URL},
  {
    "icon": FontAwesomeIcons.envelope,
    "title": "Email",
    "type": QrCodeType.EMAIL
  },

//  {
//    "icon": FontAwesomeIcons.phoneSquareAlt,
//    "title": "Phone",
//    "type": QrCodeType.PHONE
//  },
//  {"icon": FontAwesomeIcons.sms, "title": "SMS", "type": QrCodeType.SMS},
//  {
//    "icon": FontAwesomeIcons.mapMarkedAlt,
//    "title": "Location",
//    "type": QrCodeType.LOCATION
//  },
  {
    "icon": FontAwesomeIcons.addressCard,
    "title": "Contact information",
    "type": QrCodeType.ALL
  },

//    {"icon": FontAwesomeIcons.calendar, "title": "Event", "type": QrCodeType.TEXT},
  {
    "icon": FontAwesomeIcons.wifi,
    "title": "WiFi network",
    "type": QrCodeType.WIFI
  },
  {
    "icon": FontAwesomeIcons.play,
    "title": "Play Ground",
    "type": QrCodeType.PLAYGROUND
  },
];
