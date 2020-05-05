import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboardingpage/styles.dart';

import 'circle_progress.dart';
import 'circle_progress_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> nameImages = [
    'assets/images/onboarding3.png',
    'assets/images/onboarding4.png',
    'assets/images/onboarding5.png',
    'assets/images/onboarding3.png'
  ];

  List<String> nameTitles = [
    '',
    '',
    '',
    '',
  ];

  List<String> nameSubTitles = [
    'Browse the menu and order directly from the application',
    'Your order will be immediately collected and',
    'Pick up delivery at your door and enjoy groceries',
    'Browse the menu and order directly from the application'
  ];

  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  double progressPercent = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('back');
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFBD5D9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          iconSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {
                          print('Skip');
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 550.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                        //progressPercent = (_currentPage + 1) * 1.0/_numPages;
                      });
                    },
                    children: _buildListContentPage(),
                  ),
                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: _buildPageIndicator(),
//                ),
                _customProgress(),
                _buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return (_currentPage != _numPages - 1
        ? Expanded(
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: FlatButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
//                    Text(
//                      'Next',
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 22.0,
//                      ),
//                    ),
                  ],
                ),
              ),
            ),
          )
        : Expanded(
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: FlatButton(
                onPressed: () {
                  print('Start');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
//                    Text(
//                      'Start',
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 22.0,
//                      ),
//                    ),
                  ],
                ),
              ),
            ),
          ));
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF7B51D3) : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _customProgress() {
    return Stack(
      alignment: Alignment.center,
      children: [
//        CustomPaint(
//            foregroundPainter: CircleProgress((_currentPage + 1) * 100 / _numPages),
//            // this will add custom painter after child
//            child: Container(
//                width: 90,
//                height: 90,
//                child: GestureDetector(
//                  onTap: () {},
//                ))),
        Container(
          width: 80,
          height: 80,
          child: CircleProgressBar(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF7B51D3),
            value: ((_currentPage + 1) * 1.0 / _numPages),
          ),
        ),
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF7B51D3),
          ),
          child: IconButton(
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            iconSize: 15,
          ),
        )
      ],
    );
  }

  List<Widget> _buildListContentPage() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(
        _buildMainContent(nameImages[i], nameTitles[i], nameSubTitles[i]),
      );
    }
    return list;
  }

  Padding _buildMainContent(
      String nameImage, String nameTitle, String nameSubTitle) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage(nameImage),
              height: 360.0,
              width: 360.0,
            ),
          ),
          SizedBox(
            height: 9.0,
          ),
          Text(
            nameTitle,
            style: kTitleStyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            nameSubTitle,
            style: kSubtitleStyle,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
