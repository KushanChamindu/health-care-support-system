import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/CKD_Card/CKD_Card.dart';


class Home extends StatelessWidget {

  void choiceAction(String choice){
    print('Working');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return Constant.choice.map((String choice){
                  if(choice=='Account'){
                  return PopupMenuItem(
                    value: choice,
                      child: Row(children: <Widget>[Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.person, color: Colors.black,),
                      ), Text(choice)],));

                }else if(choice=='SignOut'){
                  return PopupMenuItem(
                      value: choice,
                      child: Row(children: <Widget>[Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.lock, color: Colors.black,),
                      ), Text(choice)],));
                }else{
                  return PopupMenuItem(
                      value: choice,
                      child: Row(children: <Widget>[Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.flag, color: Colors.black,),
                      ), Text(choice)],));
                  }
                }
                ).toList();
              },
          )
          ],
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/CKD_image/Doctor.png'),
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
class Constant{
  static const String Account='Account';
  static const String SignOut='SignOut';
  static const String About='About';

  static const List<String> choice=<String>[
    Account,
    SignOut,
    About
  ];
}