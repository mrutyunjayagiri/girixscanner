import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';

class PdfScreen extends StatefulWidget {
  final MainModel model;

  const PdfScreen({Key key, this.model}) : super(key: key);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  void _onCreated() async {}

  @override
  void initState() {
    super.initState();

    _onCreated();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),
      ),
    );
  }
}
