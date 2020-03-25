//import 'dart:html';

import 'package:flutter/material.dart';
import 'CKD_symptom.dart';

class CKD_discription extends StatefulWidget {
  @override
  _CKD_discriptionState createState() => _CKD_discriptionState();
}

class _CKD_discriptionState extends State<CKD_discription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'Chronic Kiney Disease Information',
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
            Card(
              child: Image.asset('assets/CKD_image/kidney_1.jpg',
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0,5, 0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        child: FlatButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/CKD_symptom');
                            },
                            icon: Icon(
                              Icons.touch_app,
                              size: 25,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                              child: Text("CKD Symptoms",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w900)),
                            )),
                      ),
                    ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: FlatButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/CKD_precaution');
                        },
                        icon: Icon(
                          Icons.local_pharmacy,
                          size: 25,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                          child: Text("CKD precautions",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900)),
                        )),
                  ),
                ),
              ],
            ),

            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'What Is Chronic Kidney Disease?',
                  text2:
                      'Chronic kidney disease (CKD) means your kidneys are damaged and can’t filter blood the way they should. The main risk factors for developing kidney disease are diabetes, high blood pressure, heart disease, and a family history of kidney failure.',
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'Causes of Chronic Kidney Disease',
                  text2:
                      'Diabetes, high blood pressure, using Alcohol and smorking are the most common causes of kidney disease. Your health care provider may do tests to find out why you have kidney disease. The cause of your kidney disease may affect the type of treatment you receive.',
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'Test & Diagnosis',
                  text2:
                      'Testing may be the only way to know if you have kidney disease. Get checked if you have diabetes, high blood pressure, heart disease, or a family history of kidney failure. The sooner you know you have kidney disease, the sooner you can get treatment.',
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'Managing Chronic Kidney Disease',
                  text2:
                      'You can take steps to protect your kidneys. The most important step you can take to treat kidney disease is to control your blood pressure. Healthy habits can also help you manage your kidney disease.',
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'Eating Right for Chronic Kidney Disease',
                  text2:
                      'Eating the right foods can help keep your kidney disease from getting worse. Work with a dietitian to create a meal plan that includes foods that you enjoy eating while maintaining your kidney health.',
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'Preventing Chronic Kidney Disease',
                  text2:
                      'You are at risk for kidney disease if you have diabetes, high blood pressure, heart disease, or a family history of kidney failure. If you have risk factors, get tested for kidney disease and protect your kidneys by making healthy food choices, being more active, aiming for a healthy weight, and managing health conditions that cause kidney damage.',
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'What if My Kidneys Fail?',
                  text2:
                      'Kidney failure means that your kidneys have lost most of their ability to function. Work with your health care team and family to consider your options to replace your lost kidney function, such as dialysis or transplant. Choose a treatment that is right for you.',
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Titles(
                  text1: 'Clinical Trials',
                  text2:
                      'The National Institute of Diabetes and Digestive and Kidney Diseases (NIDDK) and other components of the National Institutes of Health (NIH) conduct and support research into many diseases and conditions.',
                )),
            Card(
                child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/CKD_webview');
                    },
                    icon: Icon(Icons.public),
                    label: Expanded(
                        child: Text("Open More Info",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900)))),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class Titles extends StatefulWidget {
  final String text1, text2;
  bool visible = false;

  Titles({this.text1, this.text2});

  @override
  _TitlesState createState() => _TitlesState();
}

class _TitlesState extends State<Titles> {
  void get_visible() {
    setState(() {
      if (widget.visible) {
        widget.visible = false;
      } else {
        widget.visible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          child: Column(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () {
                get_visible();
              },
              icon: Icon(Icons.list),
              label: Expanded(
                  child: Text(widget.text1, style: TextStyle(fontSize: 16)))),
          Visibility(
              visible: widget.visible,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
                child: Text(
                  widget.text2,
                  style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5),
                ),
              ))
        ],
      )),
    );
  }
}


