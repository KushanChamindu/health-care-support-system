import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
// Here you can write your code
    Navigator.pushReplacementNamed(context, '/login');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('assets/splashScreen.gif'),
            ),
          ),
          Text('Welcome',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w800),),
          Container(
            height: 100,
            width: 100,
            child: Image(
              image: AssetImage('assets/splashLoading.gif'),
            ),
          )
        ],
      ),
    );
  }
}
