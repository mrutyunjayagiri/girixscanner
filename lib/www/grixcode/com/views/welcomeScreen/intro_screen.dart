import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/views/welcomeScreen/quick_setup_screen.dart';

class IntoScreen extends StatefulWidget {
  @override
  _IntoScreenState createState() => _IntoScreenState();
}

class _IntoScreenState extends State<IntoScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int totalNumber = 4;
  final List<int> dots = [0, 1, 2, 3];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dots
          .map((no) => Container(
                height: 8,
                width: 8,
                padding: EdgeInsets.only(right: 5, left: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        no == _currentIndex ? Colors.black87 : Colors.black38),
                child: Container(),
              ))
          .toList(),
    );
  }

  Widget _getStarted() {
    return Column(
      children: <Widget>[
        MaterialButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => QuickSetup())),
          child: Text("GET STARTED"),
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(12.0),
          elevation: 0.0,
          textColor: Colors.white,
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }

  Widget _makePage({String image, String title, String content}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Image.asset(
                image,
                alignment: Alignment.center,
              )),
          SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 1,
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Column(children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentIndex = page;
                });
              },
              children: <Widget>[
                _makePage(
                    image: "assets/images/image-resize.png",
                    title: "Keep your image to a particular size",
                    content: ""),
                _makePage(
                    image: "assets/images/my_personal_files.png",
                    title: "Make your files protected",
                    content: ""),
                _makePage(
                    image: "assets/images/organize_photos.png",
                    title: "Organize your docs, Better visualisation",
                    content: ""),
                _makePage(
                    image: "assets/images/reviewed_docs_neeb.png",
                    title: "Review your existing documents",
                    content: ""),
              ],
            ),
          ),
          _currentIndex == 3
              ? _getStarted()
              : Container(
                  alignment: Alignment.center,
                  width: 85.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: _buildDots(),
                )
        ]),
      ),
    );
  }
}
