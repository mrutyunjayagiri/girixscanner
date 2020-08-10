import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/config/config.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/views/documentViews/my_documnets.dart';
import 'package:girixscanner/www/grixcode/com/views/documentViews/scan/scan_screen.dart';
import 'package:girixscanner/www/grixcode/com/views/homeScreen/dashboard_views.dart';
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

  void _onFloatingAction() async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ScanScreen(model: widget.model)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
//          leading: Transform.rotate(
//            angle: pi / 4,
//            child: Container(
//              decoration: BoxDecoration(color: Colors.black87),
//              child: Icon(
//                Icons.menu,
//                color: Colors.white,
//              ),
//            ),
//          ),
//          backgroundColor: Colors.grey[50],
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: _onFloatingAction,
            child: Icon(
              Icons.camera,
              size: 30.0,
            ),
            elevation: 23.0,
            heroTag: "SCAN_DOCS",
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }
}
