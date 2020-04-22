import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CKD_webview extends StatefulWidget {
  @override
  _CKD_webviewState createState() => _CKD_webviewState();
}

class _CKD_webviewState extends State<CKD_webview> {
  final url='https://www.niddk.nih.gov/health-information/kidney-disease/chronic-kidney-disease-ckd/what-is-chronic-kidney-disease';
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: url,
    scrollBar: true,
    withLocalUrl: true,
    appBar: AppBar(
      leading: IconButton(
        key: ValueKey('webviewBackButton'),
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              'CKD More Info',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 4, 0, 4),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/CKD_image/Doctor.png',
                ),
                radius: 20,
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
    withOverviewMode: true,
    initialChild: Container(
      key: ValueKey('webviewInitialWidget'),
      child:Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset(
                    'assets/CKD_image/wait.gif'
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
