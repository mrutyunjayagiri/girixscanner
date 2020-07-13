import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class ShareTestScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to: wc_flutter_share'),
        textTheme: TextTheme(button: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          FlatButton(onPressed: _shareText, child: Text('Share text')),
          SizedBox(
            height: 10,
          ),
          FlatButton(onPressed: _shareImage, child: Text('Share file only')),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              onPressed: _shareImageAndText,
              child: Text('Share file and text')),
        ],
      ),
    );
  }

  void _shareText() async {
    try {
      WcFlutterShare.share(
          sharePopupTitle: 'Share',
          subject: 'This is subject',
          text: 'This is text',
          mimeType: 'text/plain');
    } catch (e) {
      print(e);
    }
  }

  void _shareImage() async {
    try {
      final ByteData bytes =
          await rootBundle.load('assets/files/AttestationForm.pdf');
      await WcFlutterShare.share(
          sharePopupTitle: 'share',
          fileName: 'share.png',
          mimeType: 'image/png',
          bytesOfFile: bytes.buffer.asUint8List());
    } catch (e) {
      print('error: $e');
    }
  }

  void _shareImageAndText() async {
    try {
      final ByteData bytes =
          await rootBundle.load('assets/images/server_down.png');
      await WcFlutterShare.share(
          sharePopupTitle: 'Server Down',
          subject: 'This is subject',
          text: 'This is text',
          fileName: 'Server_down.png',
          mimeType: 'image/png',
          bytesOfFile: bytes.buffer.asUint8List());
    } catch (e) {
      print('error: $e');
    }
  }
}
