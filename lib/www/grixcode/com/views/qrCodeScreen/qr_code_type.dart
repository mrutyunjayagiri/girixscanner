import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:girixscanner/www/grixcode/com/models/data/shared_data.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/enum/enum.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/text_style.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/generateQrCode/generate_form_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/qrCodeScreen/playground/playground.dart';
import 'package:girixscanner/www/grixcode/com/widgets/animation/my_animation.dart';
import 'package:scoped_model/scoped_model.dart';

class QrCodeTypeScreen extends StatelessWidget {
  void onTap(BuildContext context, Map<String, dynamic> _item) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => GenerateQrCodeScreen(
                  title: _item['title'],
                  qrCodeType: _item['type'],
                )));
  }

  void _onPlayGroundTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                ScopedModelDescendant(builder: (_, __, MainModel model) {
                  return QrCodePlayGround(
                    model: model,
                  );
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose QR code"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: qrCodeCategories.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> _item = qrCodeCategories[index];

                return _item['type'] == QrCodeType.PLAYGROUND
                    ? Container()
                    : ListTile(
                        onTap: () => onTap(context, _item),
                        leading: FaIcon(
                          _item['icon'],
                          size: 22,
                        ),
                        title: Text(
                          "${_item['title']}",
                          style: CustomStyle(context).subtitle1,
                        ),
                      );
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          ),
          MyFadeAnimation(
            delay: 0.2,
            child: Row(
              children: <Widget>[
                Expanded(child: Divider()),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      shape: BoxShape.rectangle),
                  child: Text(
                    "Time to Play",
                    style: CustomStyle(context).caption,
                  ),
                ),
                Expanded(
                  child: Divider(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                MyFadeAnimation(
                  delay: 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.deepPurpleAccent,
                              Theme.of(context).primaryColor,
                            ])),
                    child: MaterialButton(
                      elevation: 0.0,
                      onPressed: () => _onPlayGroundTap(context),
                      child: Text("PLAY GROUND"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(14.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
