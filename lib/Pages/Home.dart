import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/CKD_Card/CKD_Card.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Doctor.png'),
              radius: 30,
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ),
        body: ListView(
            children: <Widget>[
              Container(
                  margin:EdgeInsets.all(8.0),
                  child:CKD_Cards()
              ),
            ]
        )
    );
  }
}
