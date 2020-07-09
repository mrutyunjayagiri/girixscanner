import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:google_fonts/google_fonts.dart';

class GsLogo extends StatelessWidget {
  final bool hasDark;

  GsLogo({this.hasDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 95.0,
            height: 12.0,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${APP_NAME}",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 55.0),
          )
        ],
      ),
    );
  }
}
