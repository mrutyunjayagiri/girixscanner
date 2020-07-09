import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/theme/colors.dart';
import 'package:girixscanner/www/grixcode/com/views/welcomeScreen/splash_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MainModel _model = MainModel();
  await _model.autoAuthenticate();
  runApp(MyApp(model: _model));
}

class MyApp extends StatelessWidget {
  final MainModel model;

  MyApp({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(
          model: model,
        ),
      ),
    );
  }
}
