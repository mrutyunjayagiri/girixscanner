import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SystemConfig {
  static Future<void> makeDeviceLandscape() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  static Future<void> makeDevicePotrait() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  static makeStatusBarHide() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static makeStatusBarVisible() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  static setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
    ));
  }
}
