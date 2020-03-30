import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'Constant.dart';

class CKD_precautions extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _CKD_precautionsState createState() => _CKD_precautionsState();
}

class _CKD_precautionsState extends State<CKD_precautions> {
  void choiceAction(String choice)async{
    if(choice=='Account'){
      String uid= await widget.auth.currentUser();
      Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
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
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Chronic Kiney Disease Information',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(3, 4, 0, 4),
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
//              Container(
//                color: Colors.white,
//                child:Column(
//                  children: <Widget>[
//                    Image.asset('assets/Doctor.png',
//                    ),
//                   Text('ahgdfjafg'),
//                  ],
//                ),
//              )
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyBullet(),
                    ),
                    Expanded(child: Text('Follow a low-salt, low-fat diet',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/CKD_image/fruit.png', width: 110,height: 100,),
                    ),
                        ],
                      ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyBullet(),
                    ),
                    Expanded(child: Text('Exercise at least 30 minutes on most days of the week',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/CKD_image/excersis.gif', width: 110,height: 100,),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyBullet(),
                    ),
                    Expanded(child: Text('Have regular check-ups with your doctor',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/CKD_image/meet_doctor.gif', width: 110,height: 100,),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyBullet(),
                    ),
                    Expanded(child: Text('Do not smoke or use tobacco',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/CKD_image/nosmoke.gif', width: 110,height: 100,),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyBullet(),
                    ),
                    Expanded(child: Text('Limit alcohol',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/CKD_image/noAlcohol.jpeg', width: 110,height: 100,),
                    ),
                  ],
                ),
              ),
                  ],
          ),
        ));
  }
}
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 0, 3),
      child: new Container(
        height: 9.0,
        width: 9.0,
        decoration: new BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}