import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CKD_Cards extends StatefulWidget {
  @override
  _CKD_CardsState createState() => _CKD_CardsState();
}

class _CKD_CardsState extends State<CKD_Cards> {
  @override
  bool viewVisible = true ;
  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }

  bool getVisible(){
    return !viewVisible;
  }

  Widget build(BuildContext context) {
    bool viewVisible = getVisible();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(
                  'assets/kidney.png',
                  width: 300,
                  height: 200,
                  fit:BoxFit.fitWidth

              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Chronical kidney disease',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Visibility(
                visible: viewVisible,
                child:Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.local_hospital,
                          size: 40,
                          color: Colors.black,
                        ), onPressed: null)
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}