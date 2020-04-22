
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
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
      try {
        String uid= await widget.auth.currentUser();
        Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Check your internet connection'),
        ));
      }
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
//    void set_visible(visi){
//      setState(() {
//        visible=!visi;
//      });
//    }
    return
      Scaffold(
        key: ValueKey('CKDsymptomPage'),
      appBar: AppBar(
        leading: IconButton(
          key: ValueKey('CKDsymptomBackButton'),
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: new Text(
                              'Blood in your pee (urine)',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Expanded(
                              child: Image.asset('assets/CKD_image/blood-in-pee.png', width: 30,height: 100,)),
                        ],
                      ),
                    ),
                    Card(
                      key: ValueKey('sampleCKDsymptom'),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: new Text(
                              'Shortness of breath',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/CKD_image/shortness-breath.png',  width: 30,height: 70,),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: new Text(
                              'Itchy skin',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Expanded(
                              child: Image.asset('assets/CKD_image/itchy-skin.png',  width: 30,height: 100,)),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: new Text(
                              'Muscle cramps',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/CKD_image/Muscle-cramps.png',  width: 30,height: 70,),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: new Text(
                              'Erectile dysfunction in men',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Expanded(
                              child: Image.asset('assets/CKD_image/Erectile.png',  width: 50,height: 100,)),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.6,
                                child: new Text( 'Swollen ankles, feet or hands – as a result of water retention',
                                  style: TextStyle(
                                      fontSize: 15,),
                                )
                            ),
                          Expanded(
                              child: Image.asset('assets/CKD_image/Swollen-ankles.png',width: 30,height: 70,)),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: new Text( 'Weight loss and poor appetite',
                                style: TextStyle(
                                  fontSize: 15,),
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/CKD_image/poor-appatite.png',width: 30,height: 70,),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: new Text( 'Tiredness',
                                style: TextStyle(
                                  fontSize: 15,),
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/CKD_image/Tiredness.png',width: 30,height: 70,),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: new Text( 'An increased need to pee – particularly at night',
                                style: TextStyle(
                                  fontSize: 15,),
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/CKD_image/increase-pee.jpg',width: 30,height: 70,),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: new Text('Difficulty sleeping (insomnia)',
                                style: TextStyle(
                                  fontSize: 15,),
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/CKD_image/Difficulty-sleeping.jpeg',width: 30,height: 70,),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: new Text('feeling sick',
                                style: TextStyle(
                                  fontSize: 15,),
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/CKD_image/feeling-sick.png',width: 30,height: 70,),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 25, 15),
                            child: new MyBullet(),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: new Text('Headaches',
                                style: TextStyle(
                                  fontSize: 15,),
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                                child: Image.asset('assets/CKD_image/Headaches.png',width: 30,height: 70,),
                              )),
                        ],
                      ),
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
