import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';

class BC_Solutions extends StatelessWidget {
  final BaseAuth auth=Auth();

  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice)async{
      if(choice=='Account'){
        try {
          String uid= await auth.currentUser();
          Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Check your internet connection'),
          ));
          // TODO
        }
      }else if(choice=='SignOut'){
        print('SignOut');
        await auth.singOut();
        if(await auth.currentUser()==null){
          Navigator.pushReplacementNamed(context, '/');
        }else{
          showAboutDialog(BuildContext context){
            AlertDialog alert=AlertDialog(
              backgroundColor: Colors.grey[100],
              title: Center(
                child: Text(
                  "Connection Problem!!",
                  style: TextStyle(fontSize: 25,),
                ),
              ),
              content: Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Image.asset('assets/connection_lost.gif', width: 250,height: 150,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,0, 8, 0),
                    child: Text('SignOut problem',style: TextStyle(fontSize: 17),textAlign: TextAlign.center,),
                  )
                ],
              ),
              actions: <Widget>[CupertinoButton(child: Text("Ok"), onPressed:(){Navigator.of(context).pop();})],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(child: Container(width: 500,height: 400,child: alert));
              },
            );
          }
          showAboutDialog(context);
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

    List precautions = [
      'Be physically active...Physical activity can help you maintain a healthy weight, which helps prevent breast cancer',
      'Limit alcohol.....The more alcohol you drink, the greater your risk of developing breast cancer. So, limit yourself to less than one drink a day, as even small amounts increase risk.',
      "Don't smoke'...... Evidence suggests a link between smoking and breast cancer risk, particularly in premenopausal womensyptoms 1",
      'Control your weight..... Being overweight or obese increases the risk of breast cancer',
      'Breast-feed.... The longer you breast-feed, the greater the protective effect',
      'Limit dose and duration of hormone therapy.... ',
      'Avoid exposure to radiation and environmental pollution.....',
    ];

    List image =[
      'assets/breast_cancer_image/physically.gif',
      'assets/breast_cancer_image/noalcohol.webp',
      'assets/breast_cancer_image/nosmoke.gif',
      'assets/breast_cancer_image/noweight.gif',
      'assets/breast_cancer_image/feed.gif',
      'assets/breast_cancer_image/nosmoke.gif',
      'assets/breast_cancer_image/nosmoke.gif',
    ];
  
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
          "Precautions...- Breast Cancer",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontFamily: 'KaushanScript'
          ),
        ),
        //centerTitle: true,
//        backgroundColor: Colors.lightBlue,
      ),
       body:ListView.builder(
          itemCount: precautions.length,
          itemBuilder: (context,index){
            return Card(
                 child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.blur_linear),
                    ),
                    Expanded(
                      child: Text(precautions[index],
                      style: TextStyle(
                        fontSize:17, 
                        fontWeight: FontWeight.w800,
                        fontFamily: 'KaushanScript',
                        ) 
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(image[index], width: 110,height: 100,),
                    ),
                  ],
                ),
            );        
                  }
       ),
    );
  }
}
