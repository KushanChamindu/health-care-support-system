import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/CKD_Card/CKD_Card.dart';
import 'CKD_pages/Constant.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice){
      if(choice=='Account'){
        Navigator.pushNamed(context, '/account');
      }else if(choice=='SignOut'){
        print('SignOut');
      }else{
        showAboutDialog(
            context: context,
            applicationIcon: Image.asset('assets/CKD_image/Doctor.png', width: 100,height: 100,),
            applicationName: "Mobile Doctor",
            applicationVersion: '0.0.1',
            applicationLegalese: 'This software developed by HCSS PVT LMD. Copyright © 2020 Arnoud Engelfriet. Some rights reserved.',
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  child: Text('* Chronic kidney disease'),
                ),
              ),
              Container(
                child: Text('* Diabetise'),
              ),
              Container(
                child: Text('* Heart disease'),
              ),
              Container(
                child: Text('* Beast Cancer'),
              )
            ]

        );
      }
    }
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
