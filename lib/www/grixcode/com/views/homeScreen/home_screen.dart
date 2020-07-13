import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/views/homeScreen/dashboard_views.dart';
import 'package:girixscanner/www/grixcode/com/views/homeScreen/my_documnets.dart';
import 'package:girixscanner/www/grixcode/com/widgets/bottom_nav_bar.dart';
import 'package:girixscanner/www/grixcode/com/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  final MainModel model;

  HomeScreen({this.model}) : assert(model != null);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("${_currentIndex == 0 ? APP_NAME : 'My Documents'}"),
          elevation: 0.0,
          centerTitle: true,
        ),
        body:
            <Widget>[DashboardScreen(), MyDocuments()].elementAt(_currentIndex),
        bottomNavigationBar: BottomNavBar(
          index: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
