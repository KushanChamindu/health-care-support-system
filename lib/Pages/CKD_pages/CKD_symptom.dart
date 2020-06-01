import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import '../Popupmenu.dart';

class CKD_symptoms extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _CKD_symptomsState createState() => _CKD_symptomsState();
}

class _CKD_symptomsState extends State<CKD_symptoms> {
  @override
  Widget build(BuildContext context) {
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
          Popupmenu(auth: widget.auth,)
        ],
        backgroundColor: Colors.blueAccent,
      ),
//      body: Padding(
//          padding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
          body: ListView(
            children: <Widget>[
              SymptomCard(text:'Blood in your pee (urine)',image: 'assets/CKD_image/blood-in-pee.png',imageHeight: 90.0,imageWidth: 120.0,isImapotant: true,),
              SymptomCard(text: 'Shortness of breath',image: 'assets/CKD_image/shortness-breath.png',imageWidth: 90.0,imageHeight: 90.0,isImapotant: true,),
              SymptomCard(text: 'Itchy skin',image: 'assets/CKD_image/itchy-skin.png',imageHeight: 100.0,imageWidth: 100.0,isImapotant: true,),
              SymptomCard(identifier: 'sampleCKDsymptom',text: 'Muscle cramps',image: 'assets/CKD_image/Muscle-cramps.png',imageHeight: 80.0,imageWidth: 110.0,isImapotant: true,),
              SymptomCard(text: 'Erectile dysfunction in men',image: 'assets/CKD_image/Erectile.png',imageWidth: 100.0,imageHeight: 110.0,isImapotant: true,),
              SymptomCard(text: 'Swollen ankles, feet or hands –> as a result of water retention',image: 'assets/CKD_image/Swollen-ankles.png',imageHeight: 90.0,imageWidth: 100.0,),
              SymptomCard(text: 'Weight loss and poor appetite',image: 'assets/CKD_image/poor-appatite.png',imageHeight: 100.0,imageWidth: 100.0,),
              SymptomCard(text: 'Tiredness',image: 'assets/CKD_image/Tiredness.png',imageHeight: 90.0,imageWidth: 90.0,),
              SymptomCard(text: 'An increased need to pee – particularly at night',image:'assets/CKD_image/increase-pee.jpg',imageHeight: 80.0,imageWidth: 100.0,),
              SymptomCard(text: 'Difficulty sleeping (insomnia)',image: 'assets/CKD_image/Difficulty-sleeping.jpeg',imageWidth: 100.0,imageHeight: 90.0,),
              SymptomCard(text: 'feeling sick',image: 'assets/CKD_image/feeling-sick.png',imageWidth: 110.0,imageHeight: 80.0,),
              SymptomCard(text: 'Headaches',image: 'assets/CKD_image/Headaches.png',imageHeight: 90.0,imageWidth: 100.0,),
            ],
          )
//      ),
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

class SymptomCard extends StatelessWidget {
  final text;
  final image;
  final imageWidth;
  final imageHeight;
  final isImapotant;
  final String identifier;
  SymptomCard({this.image,this.text,this.imageHeight,this.imageWidth,this.isImapotant,this.identifier});
  @override
  Widget build(BuildContext context) {
    return Card(
      key: identifier!=null?ValueKey(identifier):null,
      child: Row(
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.fromLTRB(0, 15,25, 15),
            child: new MyBullet(),
          ),
          Expanded(
            child: new Text(
              text,
              style: TextStyle(
                  fontSize: isImapotant==true?16:15, fontWeight: isImapotant==true?FontWeight.w900:null),
            ),
          ),
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(image, width: imageWidth,height: imageHeight,),
              ),
        ],
      ),
    );
  }
}

