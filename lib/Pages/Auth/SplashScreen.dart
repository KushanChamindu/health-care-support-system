import 'package:flutter/material.dart';

import 'Service/Auth.dart';
class SplashScreen extends StatefulWidget {
  final BaseAuth auth = Auth();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      widget.auth.currentUser().then((value) {
        setState(() {
          if (value != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }else{
            // Here you can write your code
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            height: MediaQuery.of(context).size.height*0.2,
            width: 130,
            child: Image(
              image: AssetImage('assets/splashLoading.gif'),
            ),
          )
        ],
      ),
    );
  }
}
