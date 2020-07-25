import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:image/image.dart' as im;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class DownloadBarcode extends StatelessWidget {
  final Map<String, dynamic> dataSet;
  final Barcode barcode;
  final MainModel model;

//  final Barcode barcode;
//  final String fileName;
//  final String secretData;
//  final double width;
//  final double height;
//  final double fontSize

  DownloadBarcode({this.dataSet, this.barcode, this.model});

  @override
  Widget build(BuildContext context) {
    if (!barcode.isValid(dataSet['secret_data'])) {
      return const Text("Invalid Barcode data");
    }
    final doubleIconSize = 30.0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            title: Text(
              "Save as",
              style: CustomStyle(context).bodyText2,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.save_alt,
              size: doubleIconSize,
              color: Colors.green,
            ),
            title: Text(
              "SVG",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _exportSvg(context),
            subtitle: Text("Download as SVG"),
            dense: true,
          ),
          ListTile(
            leading: Icon(
              Icons.image,
              size: doubleIconSize,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "PNG",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _exportPng(context),
            subtitle: Text("Download as PNG"),
            dense: true,
          ),
          ListTile(
            leading: Icon(
              Icons.picture_as_pdf,
              size: doubleIconSize,
              color: Colors.pink,
            ),
            subtitle: Text("Download as PDF"),
            dense: true,
            title: Text(
              "PDF",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _exportPdf(context),
          ),
        ],
      ),
    );
  }

  Future<bool> _checkPermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else {
      PermissionStatus _requestStatus = await Permission.storage.request();
      if (_requestStatus.isGranted)
        return true;
      else
        _checkPermission();
    }

    return false;
  }

  Future<String> _getExternalPath() async {
    return BarcodeUtility().getExternalDocumentPath();
  }

  void _exportPdf(BuildContext context) async {
    // Check Permission
    bool isPermission = await _checkPermission();
    if (!isPermission) {
      print("Permission Required");
      Navigator.of(context).pop(false);

      return;
    }

    final pdf = pw.Document(
      author: '${model.user.name}',
      keywords: 'barcode, dart, ${barcode.name}',
      subject: barcode.name,
      title: '${dataSet['name']}',
    );
    const scale = 5.0;

    final PdfImage assetImage = await pdfImageFromImageProvider(
      pdf: pdf.document,
      image: const AssetImage('assets/logo/gs_logo.png'),
    );

    pdf.addPage(pw.Page(
      build: (context) => pw.Center(
        child: pw.Column(children: [
          pw.Row(children: [pw.Image(assetImage, height: 30, width: 60)]),
//          pw.Header(text: APP_NAME, level: 3),
          pw.Spacer(),
          pw.Text("Data: ${dataSet['secret_data']}",
              style: pw.TextStyle(
                  fontSize: 18.0, color: PdfColor.fromHex("000000"))),
          pw.Spacer(),
          pw.BarcodeWidget(
            barcode: barcode,
            backgroundColor: dataSet['background_color'] != null
                ? PdfColor.fromHex("${dataSet['background_color']['hex']}")
                : null,
            color: dataSet['foreground_color'] != null
                ? PdfColor.fromHex("#${dataSet['foreground_color']['hex']}")
                : null,
            data: dataSet['secret_data'],
            width: dataSet['width'] * PdfPageFormat.mm / scale,
            height: dataSet['height'] * PdfPageFormat.mm / scale,
            textStyle: pw.TextStyle(
              fontSize: dataSet['font'] * PdfPageFormat.mm / scale,
            ),
          ),
          pw.Spacer(),
          pw.Paragraph(text: dataSet['message']),
          pw.Spacer(),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.RichText(
              text: pw.TextSpan(
                text: 'Pdf generated by $APP_NAME\nFor more info visit',
                children: [
                  pw.TextSpan(
                    text: 'https://codingbhai.com/about',
                    annotation: pw.AnnotationUrl(
                      'https://codingbhai.com/about',
                    ),
                    style: const pw.TextStyle(
                      color: PdfColors.blue,
                      decoration: pw.TextDecoration.underline,
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    ));

    final _fileName = BarcodeUtility.fileName(dataSet['name']);
    final file = File('${await _getExternalPath()}/${_fileName}.pdf');
    file.writeAsBytesSync(pdf.save());
    Navigator.of(context).pop(true);
  }

  void _exportPng(BuildContext context) async {
    // Check Permission
    bool isPermission = await _checkPermission();
    if (!isPermission) {
      print("Permission Required");
      Navigator.of(context).pop(false);

      return;
    }

    final data = await BarcodeUtility.getBarcodePng(barcode, dataSet);
    final _fileName = BarcodeUtility.fileName(dataSet['name']);
    final File _pngFile = File("${await _getExternalPath()}/$_fileName.png");
    await _pngFile.writeAsBytesSync(data, mode: FileMode.write);
    Navigator.of(context).pop(true);

//    share(
//      bytes: Uint8List.fromList(data),
//      filename: '${barcode.name}.png',
//      mimetype: 'image/png',
//    );
  }

  void _exportSvg(BuildContext context) async {
    // Check Permission
    bool isPermission = await _checkPermission();
    if (!isPermission) {
      print("Permission Required");
      Navigator.of(context).pop(false);
      return;
    }
    int backColor = im.getColor(255, 255, 255);
    int foreColor = im.getColor(0, 0, 0);
    Color foreground, _background;
    if (dataSet['foreground_color'] != null) {
      foreground = dataSet['foreground_color']['color'];
      foreColor =
          im.getColor(foreground.red, foreground.green, foreground.blue);
    }
    if (dataSet['background_color'] != null) {
      _background = dataSet['background_color']['color'];
      backColor =
          im.getColor(_background.red, _background.green, _background.blue);
    }
    final data = barcode.toSvg(
      dataSet['secret_data'],
      width: dataSet['width'],
      height: dataSet['height'],
      fontHeight: dataSet['font'],
      color: foreColor,
    );
    final _fileName = BarcodeUtility.fileName(dataSet['name']);

    final File svgFile = File("${await _getExternalPath()}/$_fileName.svg");
    await svgFile.writeAsStringSync(
      data,
      mode: FileMode.write,
    );
    Navigator.of(context).pop(true);
  }
}
