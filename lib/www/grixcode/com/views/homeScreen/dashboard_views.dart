import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/widgets/document_tile.dart';

class DashboardScreen extends StatelessWidget {
  final double value = 8.0;

  Widget _buildRecentActivity(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: value * 2),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return DocumentTile();
          }),
    );
  }

  Widget _buildLinks(BuildContext context, {String title, IconData iconData}) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(color: Colors.grey[100]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FaIcon(
            iconData,
            size: 28.0,
            color:
                Random().nextInt(20) % 2 == 0 ? Colors.teal[700] : Colors.red,
          ),
          Text(
            "$title",
            style: CustomStyle(context).button,
          )
        ],
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: value * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: _buildLinks(context,
                  title: "PDF", iconData: FontAwesomeIcons.filePdf)),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: _buildLinks(context,
                  title: "Barcode", iconData: FontAwesomeIcons.barcode)),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: _buildLinks(context,
                  title: "QR code", iconData: FontAwesomeIcons.qrcode)),
        ],
      ),
    );
  }

  Widget _buildActivityHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: value, horizontal: value * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Recent activity",
            style: CustomStyle(context).headline6.apply(color: Colors.black87),
          ),
          MaterialButton(
            onPressed: () => null,
            child: Text(
              "MORE",
              style: CustomStyle(context).caption,
            ),
            padding: EdgeInsets.all(3),
            color: Colors.grey[200],
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(value * 3)),
          )
        ],
      ),
    );
  }

  Widget _buildQuickActivityHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: value, horizontal: value * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Quick activity",
            style: CustomStyle(context).headline6.apply(color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildActivityHeader(context),
          SizedBox(
            height: 12.0,
          ),
          _buildRecentActivity(context),
          SizedBox(
            height: 12.0,
          ),
          _buildQuickActivityHeader(context),
          SizedBox(
            height: 12.0,
          ),
          _buildQuickLinks(context)
        ],
      ),
    );
  }
}
