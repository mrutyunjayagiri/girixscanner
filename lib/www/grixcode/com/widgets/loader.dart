import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';

class Loader extends StatelessWidget {
  final LoaderType loaderType;
  final String title;

  const Loader({this.loaderType = LoaderType.CIRCULAR, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          title != null
              ? Text(
                  "${title}",
                  style: CustomStyle(context).headline6,
                )
              : Container(),
          SizedBox(
            height: 16.0,
          ),
          loaderType == LoaderType.CIRCULAR
              ? CircularProgressIndicator()
              : LinearProgressIndicator()
        ],
      ),
    );
  }
}
