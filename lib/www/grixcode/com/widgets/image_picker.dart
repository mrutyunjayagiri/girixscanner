import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GsImagePicker extends StatelessWidget {
  final picker = ImagePicker();

  void _getImage(bool hasCamera, BuildContext context) async {
    final pickedFile = await picker.getImage(
        source: hasCamera ? ImageSource.camera : ImageSource.gallery);

    Navigator.of(context).pop(pickedFile);
  }

  Widget _buildOptionList(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("Camera"),
            onTap: () => _getImage(true, context),
          ),
          ListTile(
            leading: Icon(Icons.toys),
            title: Text("Gallery"),
            onTap: () => _getImage(false, context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose Image"),
      content: _buildOptionList(context),
    );
  }
}
