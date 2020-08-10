import 'dart:io';

import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/image/gsx_image.dart';
import 'package:girixscanner/www/grixcode/com/utils/permissions/permissions.dart';
import 'package:girixscanner/www/grixcode/com/widgets/error/error.dart';
import 'package:girixscanner/www/grixcode/com/widgets/loader.dart';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  final MainModel model;

  const ScanScreen({Key key, this.model}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File _scanImageFile;
  bool isPermitted = false;
  ImagePicker _picker;
  bool isProcess = false;

  ImageCropperState state;

  void _onCreated() async {
    try {
      if (await GXSPermissions.camera()) {
        isPermitted = true;
        isProcess = true;
        setState(() {});

        final pickedFile = await _picker.getImage(source: ImageSource.camera);
        if (pickedFile != null) {
          _scanImageFile = File(pickedFile.path);
          state = ImageCropperState.picked;

          final File _croppedImage = await GsXImage().cropImage(_scanImageFile);

          if (_croppedImage != null) {
//            final File _filterImage =
//                await GsXImage().filterImage(context, _croppedImage);
            _scanImageFile = _croppedImage;
          }
        }
      }
      isProcess = false;
      setState(() {});
    } catch (e) {
      print("Error Caught In Processing Image: ${e.toString()}");
    }
  }

  Future<void> _onBack() async {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _onCreated();
    state = ImageCropperState.free;
  }

  Widget _buildImage() {
    return Container(
      child: Column(
        children: <Widget>[
          _scanImageFile != null
              ? Image.file(
                  _scanImageFile,
                  fit: BoxFit.contain,
                )
              : Text(
                  "No Image",
                  style: TextStyle(color: Colors.white70),
                ),
        ],
      ),
    );
  }

  Widget _buildFilterEffect() {
    return Container(
      height: 110.0,
      color: Colors.redAccent,
      child: Container(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildImage(),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: _buildFilterEffect(),
//          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Scan Document"),
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () => _onBack(),
          icon: Icon(Icons.close),
          color: Colors.white70,
        ),
        actions: _scanImageFile != null
            ? <Widget>[
                IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.share),
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.done),
                  color: Colors.white,
                ),
                SizedBox(
                  width: 12.0,
                ),
              ]
            : null,
      ),
      body: !isPermitted
          ? ErrorView(
              errorType: ErrorResponse.NOT_PERMITTED,
              title: "Permission required",
              subtitle: "$APP_NAME needs camera permission to perform actions.",
            )
          : isProcess ? Center(child: Loader()) : _buildBody(),
    );
  }
}
