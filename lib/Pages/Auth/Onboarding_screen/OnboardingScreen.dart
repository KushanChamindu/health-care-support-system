import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Onboarding_screen/onboardScreenStyles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 6;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.blueAccent[100],
                Colors.blueAccent[200],
                Colors.blueAccent[400],
                Colors.blueAccent[700],
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 55.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      _buildContainerColumn('Open chat-bot...','Click the disease(except Breast cancer) you want then Click "Doctor" button','assets/breast_cancer_image/guide/Click doctor_1.gif'),
                      _buildContainerColumn('Start predicting... ','Open chat-bot then say "Hi"','assets/breast_cancer_image/guide/say hi_1.gif'),
                      _buildContainerColumn('Predict Breast Cancer...','Scroll down for Breast cancer the click "Doctor" button','assets/breast_cancer_image/guide/Kshyapa form click_1.gif'),
                      _buildContainerColumn('Get disease information...','Select a disease then click the "Description" button','assets/breast_cancer_image/guide/Description click_1.gif'),
                      _buildContainerColumn('Activate notification alert...','Click notification you want to activate then click the bell icon','assets/breast_cancer_image/guide/notification on_1.gif'),
                      _buildContainerColumn('Get current situation of your disease.','Go to your profile..','assets/breast_cancer_image/guide/Profile click_2.gif'),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
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
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 60.0,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, '/home'),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Color(0xFF5B16D0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }

    Widget _buildContainerColumn(String lable,String description,String url) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                lable,
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.purple,
                ),
              ),
              // Solid text as fill.
              Text(
                lable,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    url,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            description,
            style: kSubtitleStyle,
            textAlign: TextAlign.center,
//          TextStyle(
//            color: Colors.black,
//              fontSize: 16.0,
//              fontFamily: 'Cairo',
//          ),
//          textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}