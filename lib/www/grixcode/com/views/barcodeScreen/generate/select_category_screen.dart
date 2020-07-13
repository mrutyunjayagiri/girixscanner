import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/barcode.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/generate/create_barcode.dart';
import 'package:girixscanner/www/grixcode/com/views/barcodeScreen/generate/qr_code_type.dart';
import 'package:girixscanner/www/grixcode/com/widgets/loader.dart';
import 'package:scoped_model/scoped_model.dart';

class BarcodeCategoryScreen extends StatefulWidget {
  final MainModel model;

  BarcodeCategoryScreen({Key key, this.model});

  @override
  _BarcodeCategoryScreenState createState() => _BarcodeCategoryScreenState();
}

class _BarcodeCategoryScreenState extends State<BarcodeCategoryScreen> {
  List<BarcodeListItem> _items;

  void _onCreated() async {
    _items = widget.model.barcodeService.getBarcodeCategories();
  }

  @override
  void initState() {
    super.initState();
    _onCreated();
  }

  void _onTapCategory(BarcodeInfo barcodeInfo) {
    if (barcodeInfo.type == BarcodeType.QrCode) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => QrCodeTypeScreen(
                    barcodeInfo: barcodeInfo,
                  )));
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CreateBarcodeScreen(
                  barcodeInfo: barcodeInfo,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select category"),
      ),
      body: ScopedModelDescendant(
        builder: (_, __, MainModel model) {
          return model.isLoading
              ? Loader()
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final item = _items[index];
                    if (item is BarcodeCategoryInfo) {
                      return ListTile(
                        title: Text(
                          "${item.category}",
                          style: TextStyle(color: Colors.black54),
                        ),
                      );
                    } else if (item is BarcodeInfo) {
                      return BarcodeCategoryTile(
                        barcodeInfo: item,
                        onTap: _onTapCategory,
                      );
                    } else {
                      return Container();
                    }
                  },
//                  separatorBuilder: (context, index) => Divider(),
                  itemCount: _items.length);
        },
      ),
    );
  }
}

class BarcodeCategoryTile extends StatelessWidget {
  final BarcodeInfo barcodeInfo;
  final Function onTap;

  BarcodeCategoryTile({this.barcodeInfo, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bc = barcodeInfo.barcode;

    final charset = StringBuffer();
    for (var c in bc.charSet) {
      if (c > 0x20) {
        charset.write(String.fromCharCode(c) + ' ');
      } else {
        charset.write('0x' + c.toRadixString(16) + ' ');
      }
    }
    return Container(
      child: ListTile(
        onTap: () => onTap(barcodeInfo),
        leading: FaIcon(
          barcodeInfo.category == BarcodeCategory.OneD
              ? FontAwesomeIcons.barcode
              : FontAwesomeIcons.qrcode,
          color: Colors.black54,
        ),
        title: Text(
          "${barcodeInfo.barcode.name}",
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          "Accepted ${charset}",
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
