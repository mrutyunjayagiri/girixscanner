import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarcodeFeatureList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Generate Barcode"),
            subtitle: Text("Generate barcode in different format"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.barcode),
            title: Text("Scan Barcode"),
            subtitle: Text("Scan all types of barcode"),
          )
        ],
      ),
    );
  }
}
