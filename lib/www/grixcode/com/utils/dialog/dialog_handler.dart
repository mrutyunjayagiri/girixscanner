import 'package:flutter/material.dart';

class DialogHandler {
  static Future<void> showMyCustomDialog(
      {@required BuildContext context,
      @required Widget content,
      @required String titleText,
      Widget title,
      isBarrier = true}) {
    return showGeneralDialog<void>(
        barrierColor: Colors.black.withOpacity(0.5),
        barrierLabel: '',
        context: context,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, anim1, anim2) {},
        barrierDismissible: isBarrier,
        transitionBuilder: (context, a1, a2, ch) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  contentPadding: EdgeInsets.all(5.0),
//                shape: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(6.0)),
                  title: title ?? Text(titleText),
                  content: Container(
                    child: content,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 210.0,
                  )),
            ),
          );
        });
  }

  static Future<void> showInforamtionDialog(
      {@required BuildContext context,
      @required Widget content,
      Widget title,
      isBarrier = true}) {
    return showGeneralDialog<void>(
        barrierColor: Colors.black.withOpacity(0.5),
        barrierLabel: '',
        context: context,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, anim1, anim2) {},
        barrierDismissible: isBarrier,
        transitionBuilder: (context, a1, a2, ch) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: Container(
                  child: content,
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 410.0,
                )),
          );
        });
  }
}
