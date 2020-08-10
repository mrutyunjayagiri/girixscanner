import 'package:permission_handler/permission_handler.dart';

class GXSPermissions {
  static Future<bool> camera() async {
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      PermissionStatus _requestStatus = await Permission.camera.request();
      if (!_requestStatus.isGranted) return false;
    }
    return true;
  }

  static Future<bool> storage() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      PermissionStatus _requestStatus = await Permission.storage.request();
      if (!_requestStatus.isGranted) return false;
    }
    return true;
  }

  static Future<bool> openAppSettings() async => openAppSettings();
}
