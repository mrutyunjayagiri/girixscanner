import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/views/testScreens/share_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/testScreens/share_test_screen.dart';

class AppDrawer extends StatelessWidget {
  void _onTap(BuildContext context, Widget child) {
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => child));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 50.0,
          ),
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text("Share Screen Test"),
            onTap: () => _onTap(context, ShareScreenTest()),
          ),
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text("Share Screen Test"),
            onTap: () => _onTap(context, ShareTestScreenTwo()),
          )
        ],
      ),
    );
  }
}
