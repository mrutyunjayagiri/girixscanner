import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';

class BarcodeBuilder extends StatelessWidget {
  final Function builder;
  final List<BarcodeProvider> barcodes;
  final bool isGridView;
  final EdgeInsetsGeometry padding;

  BarcodeBuilder(
      {this.barcodes, this.builder, this.isGridView = false, this.padding})
      : assert(barcodes != null && builder != null);

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      return GridView.builder(
        shrinkWrap: true,
//      reverse: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: builder,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: barcodes.length,
      );
    }
    return ListView.builder(
      padding: padding ?? EdgeInsets.symmetric(),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: builder,
      itemCount: barcodes.length,
    );
  }
}
