import 'package:flutter/material.dart';

import 'Auth/Service/Auth.dart';
import 'Auth/UID.dart';
import 'CKD_pages/Constant.dart';

class Popupmenu extends StatefulWidget {
  final BaseAuth auth;

  Popupmenu({this.auth});

  @override
  _PopupmenuState createState() => _PopupmenuState();
}

class _PopupmenuState extends State<Popupmenu> {
  void choiceAction(String choice) async {
    if (choice == 'Account') {
      try {
        var user = await widget.auth.getCurrentUser();
        Navigator.pushNamed(context, '/account',
            arguments: UID(uid: user.uid, email: user.email));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Check your internet connection'),
        ));
      }
    } else if (choice == 'SignOut') {
      print('SignOut');
      await widget.auth.singOut();
      if (await widget.auth.currentUser() == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      showAboutDialog(
          context: context,
          applicationIcon: Container(
              width: 120,
              height: 170,
              child: Image.asset(
                'assets/CKD_image/Doctor.png',
                fit: BoxFit.fill,
              )),
          applicationName: "Mobile Doctor",
          applicationVersion: '0.0.1',
          applicationLegalese:
              ('This software developed by HCSS PVT LMD. Copyright © 2020 Arnoud Engelfriet. Some rights reserved.'),
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
            ),
            FlatButton.icon(
                icon: Icon(Icons.launch),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.blue[500],
                onPressed:() async =>  Navigator.pushNamed(context, '/aboutus'),
                label: Text('About us')),
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      key: ValueKey('HomePopUpMenueButton'),
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return Constant.choice.map((String choice) {
          if (choice == 'Account') {
            return PopupMenuItem(
                key: ValueKey('gotoAccountButton'),
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
                key: ValueKey("SignoutButton"),
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
    );
  }
}
