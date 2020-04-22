import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';
import 'package:provider/provider.dart';

class WaterNotification extends StatefulWidget {
  final BaseAuth auth = Auth();
  @override
  _WaterNotificationState createState() => _WaterNotificationState();
}

class _WaterNotificationState extends State<WaterNotification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UID args = ModalRoute.of(context).settings.arguments;
    void choiceAction(String choice) async {
      if (choice == 'Account') {
        try {
          String uid = await widget.auth.currentUser();
          Navigator.pushNamed(context, '/account', arguments: UID(uid: uid));
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Check your internet connection'),
          ));
        }
      } else if (choice == 'SignOut') {
        print('SignOut');
        await widget.auth.singOut();
        if (await widget.auth.currentUser() == null) {
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

    return StreamProvider<QuerySnapshot>.value(
        value: widget.auth.waterNotificationData,
        child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Water Drinking Plan',
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
            body: Container(
              child: Center(
                child: WaterNotificationBody(
                  uid: args.uid,
                ),
              ),
            )));
//
  }
}

class WaterNotificationBody extends StatefulWidget {
  final String uid;

  WaterNotificationBody({this.uid});
  @override
  _WaterNotificationBodyState createState() => _WaterNotificationBodyState();
}

class _WaterNotificationBodyState extends State<WaterNotificationBody> {
  var visibility=true;
  void changeVIsibility(){
    setState(() {
      visibility=!visibility;
    });
  }
  @override
  Widget build(BuildContext context) {
    final waterNotificationData = Provider.of<QuerySnapshot>(context);
    try {
      var waterData = waterNotificationData.documents
          .firstWhere((doc) => doc.documentID == '${widget.uid}')
          .data;
      print(waterData);
      return Builder(
          builder: (context) => Scaffold(
                bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: Colors.blueAccent,
                  items: <Widget>[
                    Icon(Icons.alarm, size: 30),
                    Icon(Icons.assessment, size: 30),
                  ],
                  onTap: (index) {
                    changeVIsibility();
                  },
                ),
                body: Scaffold(
                    backgroundColor: Colors.blueAccent,
                    body: Stack(
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          alignment: visibility ? Alignment.center : AlignmentDirectional.centerStart,
                          curve: Curves.ease,
                          child: Visibility(
                            visible: visibility,
                            child: Container(
                              child: Container(child: Text('Alerm')),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          alignment: !visibility ? Alignment.center : AlignmentDirectional.centerEnd,
                          curve: Curves.ease,
                          child: Visibility(
                            visible: !visibility,
                            child: Container(
                              color: Colors.blueAccent,
                              child: Text('Graph'),
                            ),
                          ),
                        )
                      ],
                    )),
              ));
    } catch (e) {
      return Builder(
        builder: (context) => Center(
            child: Text(
          'Loading....',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        )),
      );
    }
  }
}
