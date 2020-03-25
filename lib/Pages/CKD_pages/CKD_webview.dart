import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:healthcaresupportsystem/Pages/Loading.dart';

class CKD_webview extends StatefulWidget {
  @override
  _CKD_webviewState createState() => _CKD_webviewState();
}

class _CKD_webviewState extends State<CKD_webview> {
  final url='https://www.niddk.nih.gov/health-information/kidney-disease/chronic-kidney-disease-ckd/what-is-chronic-kidney-disease';
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(url: url,
    appBar: AppBar(
      title: Row(
        children: <Widget>[
          Text(
            'Chronic Kiney Disease Information',
            style: TextStyle(fontSize: 15),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/Doctor.png',
                ),
                radius: 25,
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
    ),
      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
    hidden: true,
    initialChild: Container(
      child:Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset(
                    'assets/wait.gif'
                ),
//                Image.asset(
//                    'assets/wait_2.gif'
//                ),
                Text(
                  "Loading.....",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3
                  ),
                )
              ],
            )
          ),
        ),
      )
    )
    );
  }
}
