import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';


class BrestCancer extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _BrestCancerState createState() => _BrestCancerState();
}

class _BrestCancerState extends State<BrestCancer> {
  void choiceAction(String choice)async{
    if(choice=='Account'){
      try {
        String uid= await widget.auth.currentUser();
        Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Check your internet connection'),
        ));
      }
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
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              /*1*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*2*/
                  Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      'What is breast cancer...?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.0,
                        fontFamily: 'KaushanScript',
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
    );
  Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Symptoms' ,'/bc_symptoms'),
          _buildButtonColumn(color, Icons.security, 'Precausion', '/bc_solutions'),
          _buildButtonColumn(color, Icons.share, 'More...', '/bc_more'),
        ],
      ),
    );
    Widget textSection = Container(
      padding: const EdgeInsets.fromLTRB(32, 0, 24, 24),
      child: Text(
        'Breast cancer is a disease in which cells in the breast grow out of control. '
            'There are different kinds of breast cancer. '
            'The kind of breast cancer depends on which cells in the breast turn into cancer ',
            style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'KaushanScript',
            ),
        softWrap: true,  
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
        title: Text(
          "Breast Cancer",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontFamily: 'KaushanScript'
          ),
        ),
        //centerTitle: true,
      ),
      body:ListView(
        children: <Widget>[
          Image.asset(
            'assets/breast_cancer_image/bc.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          textSection,
          buttonSection,
          
        ],
      )
    );
  }
  Column _buildButtonColumn(Color color, IconData icon, String label, String url) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          height: 80,
          width: 110,
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, url);
            },
            child: Center(
              child: Column(
                children: <Widget>[
                //Icon(icon, color: color),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 24, 2, 4),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'KaushanScript',
                    ),
                    ),
                ),
              ],
              ),
            ),
//            backgroundColor: Colors.blueAccent,
            color: Colors.blueAccent,
            ),
        ),
      ],
    );
  }
}