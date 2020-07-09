import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:pdf_render/pdf_render_widgets2.dart';

class DocumentTile extends StatelessWidget {
  final double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 140.0,
          width: 120,
          padding: EdgeInsets.symmetric(vertical: minValue),
          margin: EdgeInsets.only(right: minValue),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.3, 0.6],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.grey[300], Colors.grey[100]]),
              borderRadius: BorderRadius.circular(minValue)),
          child: PdfDocumentLoader(
              assetName: 'assets/files/AttestationForm.pdf',
              pageNumber: 1,
              onError: (error) {
                print("Error: $error");
              },
              pageBuilder: (context, textureBuilder, pageSize) => Column(
                    children: <Widget>[
                      // the container adds shadow on each page
                      Expanded(
                        child: Container(child: textureBuilder()),
                      ),
                      // adding page number on the bottom of rendered page
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Attestation Form',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: CustomStyle(context).bodyText2),
                      )
                    ],
                  )),
        ),
      ],
    );
  }
}
