import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import '../Popupmenu.dart';
import 'Constant.dart';

class CKD_precautions extends StatefulWidget {
  final BaseAuth auth = Auth();
  @override
  _CKD_precautionsState createState() => _CKD_precautionsState();
}

class _CKD_precautionsState extends State<CKD_precautions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: IconButton(
            key: ValueKey('CKDprecautionBackButton'),
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'CKD Precautions',
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
            Popupmenu(auth: widget.auth,)
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
                key: ValueKey('sampleCKDprecaution'),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyBullet(),
                    ),
                    Expanded(
                        child: Text('Follow a low-salt, low-fat diet',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800))),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/CKD_image/fruit.png',
                        width: 110,
                        height: 100,
                      ),
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
                    Expanded(
                        child: Text(
                            'Exercise at least 30 minutes on most days of the week',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800))),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/CKD_image/excersis.gif',
                        width: 110,
                        height: 100,
                      ),
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
                    Expanded(
                        child: Text('Have regular check-ups with your doctor',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800))),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/CKD_image/meet_doctor.gif',
                        width: 110,
                        height: 100,
                      ),
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
                    Expanded(
                        child: Text('Do not smoke or use tobacco',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800))),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/CKD_image/nosmoke.gif',
                        width: 110,
                        height: 100,
                      ),
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
                    Expanded(
                        child: Text('Limit alcohol',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800))),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/CKD_image/noAlcohol.jpeg',
                        width: 110,
                        height: 100,
                      ),
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
