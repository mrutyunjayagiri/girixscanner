import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/views/homeScreen/home_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/welcomeScreen/intro_screen.dart';
import 'package:girixscanner/www/grixcode/com/widgets/logo.dart';
import 'package:scoped_model/scoped_model.dart';

class SplashScreen extends StatefulWidget {
  final MainModel model;

  SplashScreen({this.model}) : assert(model != null);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _init() async {
    if (widget.model.user != null) {
      await Future.delayed(Duration(seconds: 2));
      _onNext(HomeScreen(
        model: widget.model,
      ));
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _onNext(Widget child) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => child),
        (Route<dynamic> d) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    child: GsLogo(),
                    alignment: Alignment.center,
                  )),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: ScopedModelDescendant(
                    builder: (_, __, MainModel model) {
                      if (model.user == null) {
                        return MaterialButton(
                          onPressed: () => _onNext(IntoScreen()),
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          textColor: Colors.white,
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text("NEXT"),
                        );
                      } else {
                        return Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
