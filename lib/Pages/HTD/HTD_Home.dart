import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:healthcaresupportsystem/Pages/HTD/HTD_Pages/HTD_precautions.dart';
import 'package:healthcaresupportsystem/Pages/HTD/HTD_Pages/HTD_symptoms.dart';
import 'package:healthcaresupportsystem/Pages/HTD/HTD_Pages/HTD_More.dart';
import 'package:healthcaresupportsystem/Pages/HTD/Style.dart';
import 'package:healthcaresupportsystem/Pages/HTD/AppBar.dart';

class HTD_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: ValueKey('HTDdiscriptionPage'),
      body: new Column(
        key: Key('HomePage'),
        children: <Widget>[
          SafeArea(child: new GradientAppBar("Heart Disease", '/home')),
          new Image.asset(
            'assets/HTD/images/heart-beating.gif',
            fit: BoxFit.cover,
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text(
              'What is Heart Disease ?',
              textAlign: TextAlign.center,
              style: Style.headerTextStyle,
            ),
          ),
          // new Text('What is Heart Disease ?',textAlign: TextAlign.center,style: TextStyle(fontSize: 24.0, height: 1.5,color: Colors.black,fontWeight: FontWeight.bold,),),
          new Text(
            'Heart disease is a term covering any disorder of the heart.Unlike cardiovascular disease, which describes problems with the blood vessels and circulatory system as well as the heart, heart disease refers to issues and deformities in the heart itself.',
            textAlign: TextAlign.center,
            style: Style.titleTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        tooltip: 'HTDSpeedDial',
        backgroundColor: Colors.blue,
        closeManually: true,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(
                Icons.add_circle,
              key:ValueKey('HTDSymptomsbutton'),
            ),
            label: "Symptoms",
            labelStyle: TextStyle(
              fontSize: 18.0,
            ),
            labelBackgroundColor: Colors.indigo[200],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HTD_symptoms(),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(
                Icons.add_circle,
            key: ValueKey('HTDPrecautionsbutton'),),
            label: "Precautions",
            labelStyle: TextStyle(
              fontSize: 18.0,
            ),
            labelBackgroundColor: Colors.indigo[200],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HTD_precautions(),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(
                Icons.add_circle,
              key: ValueKey('HTDMorebutton'),
            ),
            label: "More",
            labelStyle: TextStyle(
              fontSize: 18.0,
            ),
            labelBackgroundColor: Colors.indigo[200],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HTD_More(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue[100],
    );
  }
}
