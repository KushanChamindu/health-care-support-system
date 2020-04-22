import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';

import 'Constant.dart';

class CKD_message extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _CKD_messageState createState() => _CKD_messageState();
}

class _CKD_messageState extends State<CKD_message> {
  void choiceAction(String choice)async{
    if(choice=='Account'){
      try {
        String uid= await widget.auth.currentUser();
        Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Check your internet connection'),
        ));
      }
    }else if(choice=='SignOut'){
      print('SignOut');
      await widget.auth.singOut();
      if(await widget.auth.currentUser()==null){
        Navigator.pushReplacementNamed(context, '/');
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:  AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'CKD Specialist',
                style: TextStyle(fontSize: 16),
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
        backgroundColor: Colors.blueAccent,
      ),
      body: Text('Message')
    );
  }
}
