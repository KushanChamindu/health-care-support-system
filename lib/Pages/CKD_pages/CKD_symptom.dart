import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'Constant.dart';

class CKD_symptoms extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _CKD_symptomsState createState() => _CKD_symptomsState();
}

class _CKD_symptomsState extends State<CKD_symptoms> {
  void choiceAction(String choice) async{
    if (choice == 'Account') {
      String uid= await widget.auth.currentUser();
      Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
    } else if (choice == 'SignOut') {
      print('SignOut');
      await widget.auth.singOut();
      if(await widget.auth.currentUser()==null){
        Navigator.pushReplacementNamed(context, '/');
      }
    } else {
      showAboutDialog(
          context: context,
          applicationIcon: Image.asset(
            'assets/CKD_image/Doctor.png',
            width: 100,
            height: 100,
          ),
          applicationName: "Mobile Doctor",
          applicationVersion: '0.0.1',
          applicationLegalese:
              'This software developed by HCSS PVT LMD. Copyright © 2020 Arnoud Engelfriet. Some rights reserved.',
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
          ]);
    }
  }
  bool visible=true;
  @override
  Widget build(BuildContext context) {
    void set_visible(visi){
      setState(() {
        visible=!visi;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'CKD Symptoms',
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
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constant.choice.map((String choice) {
                if (choice == 'Account') {
                  return PopupMenuItem(
                      value: choice,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                          Text(choice)
                        ],
                      ));
                } else if (choice == 'SignOut') {
                  return PopupMenuItem(
                      value: choice,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                          ),
                          Text(choice)
                        ],
                      ));
                } else {
                  return PopupMenuItem(
                      value: choice,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.flag,
                              color: Colors.black,
                            ),
                          ),
                          Text(choice)
                        ],
                      ));
                }
              }).toList();
            },
          )
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Blood in your pee (urine)',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Shortness of breath',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Itchy skin',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Muscle cramps',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Erectile dysfunction in men',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900,color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Weight loss and poor appetite'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text(
                          'Swollen ankles, feet or hands – as a result of water retention'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Tiredness'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text(
                          'An increased need to pee – particularly at night'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Difficulty sleeping (insomnia'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('feeling sick'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Headaches'),
                    ),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 0, 3),
      child: new Container(
        height: 10.0,
        width: 10.0,
        decoration: new BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
