import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/CKD_Card/CKD_Card.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/breast_cancer_Card/breast_cancer_Card.dart';
import 'CKD_pages/Constant.dart';
import 'notificationManager/NotificationButtonCard.dart';



class Home extends StatelessWidget {
  final BaseAuth auth=Auth();
  @override
  Widget build(BuildContext context,) {
    void choiceAction(String choice)async{
      if(choice=='Account'){
        try {
          String uid= await auth.currentUser();
          Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Check your internet connection'),
          ));
        }
      }else if(choice=='SignOut'){
        print('SignOut');
        await auth.singOut();
        if(await auth.currentUser()==null){
          Navigator.pushReplacementNamed(context, '/');
        }else{
          showAboutDialog(BuildContext context){
            AlertDialog alert=AlertDialog(
              backgroundColor: Colors.grey[100],
              title: Center(
                child: Text(
                  "Connection Problem!!",
                  style: TextStyle(fontSize: 25,),
                ),
              ),
              content: Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Image.asset('assets/connection_lost.gif', width: 250,height: 150,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,0, 8, 0),
                    child: Text('SignOut problem',style: TextStyle(fontSize: 17),textAlign: TextAlign.center,),
                  )
                ],
              ),
              actions: <Widget>[CupertinoButton(child: Text("Ok"), onPressed:(){Navigator.of(context).pop();})],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(child: Container(width: 500,height: 400,child: alert));
              },
            );
          }
          showAboutDialog(context);
        }
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
              key: ValueKey('HomePopUpMenueButton'),
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
                      key: ValueKey('homeSignoutButton'),
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
        body: Stack(
          children: <Widget>[
            ListView(
              key: Key('HomePage'),
                children: <Widget>[
                  Container(
                      margin:EdgeInsets.all(8.0),
                      child:Column(
                        children: <Widget>[
                          waterButtonCard(),
                          CKD_Cards(),
                          BC_Cards(),
                        ],
                      )
                  ),
                ]
            ),
          ],
        )
    );
  }
}

