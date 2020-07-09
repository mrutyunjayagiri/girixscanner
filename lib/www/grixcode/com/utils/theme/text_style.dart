import 'package:flutter/material.dart';

class CustomStyle {
  BuildContext _context;

  CustomStyle(BuildContext context) {
    _context = context;
  }

  TextStyle get headline6 => Theme.of(_context).textTheme.headline6;

  TextStyle get subtitle1 => Theme.of(_context).textTheme.subtitle1;

  TextStyle get subtitle2 => Theme.of(_context).textTheme.subtitle2;

  TextStyle get bodyText2 => Theme.of(_context).textTheme.bodyText2;

  TextStyle get bodyText1 => Theme.of(_context).textTheme.bodyText1;

  TextStyle get caption => Theme.of(_context).textTheme.caption;

  TextStyle get button => Theme.of(_context).textTheme.button;
}
