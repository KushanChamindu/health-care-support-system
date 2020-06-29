import 'package:flutter/material.dart';


class Diab_precautions extends StatefulWidget {

  @override
  _Diab_precautionsState createState() => _Diab_precautionsState();
}

class _Diab_precautionsState extends State<Diab_precautions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Diabetes Precautions',
                  style: TextStyle(fontSize: 20),
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
          backgroundColor: Colors.grey[850],
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
                    Expanded(child: Text('Control your diet',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/Diab_images/diet.jpg', width: 110,height: 100,),
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
                    Expanded(child: Text('Keep your vaccines up to date',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/Diab_images/vaccine.png', width: 110,height: 100,),
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
                    Expanded(child: Text('Schedule regular physicals and eye exams',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/Diab_images/eyeexam.jpg', width: 110,height: 100,),
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
                    Expanded(child: Text('Keep your blood pressure and cholesterol under control',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/Diab_images/pressure.jpg', width: 110,height: 100,),
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
                    Expanded(child: Text('If you drink alcohol, do so responsibly',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/CKD_image/noAlcohol.jpeg', width: 110,height: 100,),
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
                    Expanded(child: Text('Get more physical activity',style: TextStyle(fontSize:17, fontWeight: FontWeight.w800) )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/Diab_images/physical.jpeg', width: 110,height: 100,),
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