import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/types/contact_qr_code.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/types/email_qr_code.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/types/phone_qr_code.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/types/sms_qr_code.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/types/text_qr_code.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/types/wifi_qr_code.dart';

class GenerateQrCodeScreen extends StatelessWidget {
  final QrCodeType qrCodeType;
  final String title;

  const GenerateQrCodeScreen({Key key, this.qrCodeType, this.title})
      : super(key: key);

  Widget _buildQrWidget() {
    switch (qrCodeType) {
      case QrCodeType.TEXT:
        return TextQrCode();
        break;
      case QrCodeType.ADDRESS:
        return ContactQrCode();
        break;
      case QrCodeType.PHONE:
        return PhoneQrCode();
        break;
      case QrCodeType.EMAIL:
        return EmailQrCode();
        break;
      case QrCodeType.MEMO:
        return TextQrCode();
        break;
      case QrCodeType.SMS:
        return SMSQrCode();
        break;
      case QrCodeType.ALL:
        return ContactQrCode();
        break;
      case QrCodeType.WIFI:
        return WiFiQrCode();
        break;
      case QrCodeType.DOB:
        return TextQrCode();
        break;
      case QrCodeType.SOUND:
        return TextQrCode();
        break;
      case QrCodeType.URL:
        return TextQrCode();
        break;

      case QrCodeType.VIDEO:
        return TextQrCode();
        break;
      default:
        return TextQrCode();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Qr Code"),
      ),
      body: _buildQrWidget(),
    );
  }
}
