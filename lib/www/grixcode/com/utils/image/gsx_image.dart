import 'dart:io';

import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/colors.dart';
import 'package:image/image.dart' as Image;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';

class GsXImage {
  Future<File> cropImage(File _scanImageFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _scanImageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Crop',
        ));
    return croppedFile;
  }

  Future<File> filterImage(BuildContext context, File imageFile) async {
    final String fileName = basename(imageFile.path);
    Image.Image image = Image.decodeImage(imageFile.readAsBytesSync());
    image = Image.copyResize(image, width: 600);
    Map mapImage = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          appBarColor: primaryColor,
          title: Text("Filter"),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
          circleShape: false,
        ),
      ),
    );
    if (mapImage != null && mapImage.containsKey('image_filtered')) {
      return mapImage['image_filtered'];
    }
    return null;
  }
}
