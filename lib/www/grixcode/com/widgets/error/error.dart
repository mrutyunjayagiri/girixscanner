import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';

class ErrorView extends StatelessWidget {
  final ErrorResponse errorType;
  final String title;
  final String subtitle;

  ErrorView({this.errorType, this.title, this.subtitle})
      : assert(errorType != null);

  String get _assetName {
    if (errorType == null) return "assets/images/empty.png";
    if (errorType == ErrorResponse.EMPTY) {
      return "assets/images/empty.png";
    } else if (errorType == ErrorResponse.ERROR) {
      return "assets/images/server_down.png";
    } else {
      return "assets/images/warning.png";
    }
  }

  String get _title {
    if (errorType == null) return "Something went wrong";
    if (errorType == ErrorResponse.EMPTY) {
      return "No data found";
    } else if (errorType == ErrorResponse.ERROR) {
      return "Internal error";
    } else if (errorType == ErrorResponse.NOT_PERMITTED) {
      return "Permission required";
    } else {
      return "Unable to fetch";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            _assetName,
            fit: BoxFit.cover,
            width: 250.0,
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            "${title ?? _title}",
            style: CustomStyle(context).headline6,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "${subtitle ?? "Please check settings."}",
            style: CustomStyle(context).bodyText2,
          ),
        ],
      ),
    );
  }
}
