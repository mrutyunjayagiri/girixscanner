import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';

class PreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Preview Screen", style: CustomStyle(context).headline6)
        ],
      ),
    );
  }
}
