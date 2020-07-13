import 'dart:io';

import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:path_provider/path_provider.dart';

class AppUtility {
  static Future<String> getExternalDocumentPath() async {
    final Directory _directory = await getExternalStorageDirectory();
    final exPath = _directory.path.split('0')[0] + "0/$APP_NAME/documents";
    print("Saved Path: $exPath");
    await Directory('$exPath').create(recursive: true);
    return exPath;
  }
}
