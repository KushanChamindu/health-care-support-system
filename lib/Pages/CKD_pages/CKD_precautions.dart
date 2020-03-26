import 'package:flutter/material.dart';

class CKD_precautions extends StatefulWidget {
  @override
  _CKD_precautionsState createState() => _CKD_precautionsState();
}

class _CKD_precautionsState extends State<CKD_precautions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text(
                'Chronic Kiney Disease Precautions',
                style: TextStyle(fontSize: 15),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/CKD_image/Doctor.png',
                    ),
                    radius: 25,
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
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