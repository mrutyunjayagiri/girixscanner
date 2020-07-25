import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/colors.dart';

class ColorPicker extends StatefulWidget {
  final String title;
  final Function onFinished;

  ColorPicker({this.title, this.onFinished}) : assert(onFinished != null);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color _selectedColor = primaryColor;

  void _onSave() {
    Navigator.of(context).pop(true);
    widget.onFinished(_selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title ?? 'Select color'}"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => _onSave(),
            icon: Icon(Icons.done),
            textColor: Colors.white,
            label: Text("Save"),
          )
        ],
      ),
      body: Center(
        child: CircleColorPicker(
          initialColor: Theme.of(context).primaryColor,
          onChanged: (color) {
            setState(() {
              _selectedColor = color;
            });
          },
          size: const Size(240, 240),
          strokeWidth: 4,
          thumbSize: 36,
        ),
      ),
    );
  }
}
