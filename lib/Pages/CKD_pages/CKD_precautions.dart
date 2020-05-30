import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import '../Popupmenu.dart';


class CKD_precautions extends StatefulWidget {
  final BaseAuth auth = Auth();
  @override
  _CKD_precautionsState createState() => _CKD_precautionsState();
}

class _CKD_precautionsState extends State<CKD_precautions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey('CKDprecautionPage'),
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
        body: ListView(
            itemExtent: 115,
            children: <Widget>[
              PrecautionCard(image: 'assets/CKD_image/fruit.png',text: 'Follow a low-salt, low-fat diet'),
              PrecautionCard(text:  'Exercise at least 30 minutes on most days of the week',image:  'assets/CKD_image/excersis.gif',),
              PrecautionCard(text: 'Have regular check-ups with your doctor',image: 'assets/CKD_image/meet_doctor.gif',),
              PrecautionCard(text: 'Do not smoke or use tobacco',image: 'assets/CKD_image/nosmoke.gif',),
              PrecautionCard(text: 'Limit alcohol',image:  'assets/CKD_image/noAlcohol.jpeg',),
            ],
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
class PrecautionCard extends StatelessWidget {
  final image;
  final text;
  PrecautionCard({this.image,this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyBullet(),
          ),
          Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800))),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              image,
              width: 110,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
