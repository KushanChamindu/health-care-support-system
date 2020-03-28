import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Auth/Auth.dart';
import 'CKD_pages/Constant.dart';

class Account extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice)async{
      if(choice=='SignOut'){
        print('SignOut');
        await widget.auth.singOut();
        if(await widget.auth.currentUser()==null){
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        hoverColor: Colors.white,
        tooltip: 'Edit your account details',
        elevation: 10,
        splashColor: Colors.black,
        child: Text("Edit"),),
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'My Account',
                  style: TextStyle(fontSize: 18),
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
              itemBuilder: (BuildContext context){
                return Constant.choice.map((String choice){
                  if(choice=='Account'){
                    return null;
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
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
//          leading: Padding(
//            padding: EdgeInsets.all(8.0),
//            child: CircleAvatar(
//              backgroundImage: AssetImage('assets/CKD_image/Doctor.png'),
//              radius: 30,
//              backgroundColor: Colors.blueAccent,
//            ),
//          ),
        ),
        body:StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.white
                        ]
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white60,width: 2.0)
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/CKD_image/kidney_1.jpg'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Text('User name', style: TextStyle(color: Colors.black38),),
                          Text('Kushan chamindu nilanga',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.black),),
                          SizedBox(height: 10,),
                          Text('Birthday', style: TextStyle(color: Colors.black38),),
                          SizedBox(height: 5,),
                          Text('Birthday',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black),),
                          SizedBox(height: 10,),
                          Text('Blood group', style: TextStyle(color: Colors.black38),),
                          SizedBox(height: 5,),
                          Text('A+',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black),),
                          SizedBox(height: 50,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                child: Card(
                                  child: Container(
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Chronic Kidney Disease', style: TextStyle(fontWeight: FontWeight.w500),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Percentage: ${''}', style: TextStyle(fontSize: 15),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Precautions according to precentage : ${''}',style: TextStyle(fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                child: Card(
                                  child: Container(
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Diabetits', style: TextStyle(fontWeight: FontWeight.w500),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Percentage: ${''}', style: TextStyle(fontSize: 15),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Precautions according to precentage : ${''}',style: TextStyle(fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                child: Card(
                                  child: Container(
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Breast Canser', style: TextStyle(fontWeight: FontWeight.w500),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Percentage: ${''}', style: TextStyle(fontSize: 15),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Precautions according to precentage : ${''}',style: TextStyle(fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                child: Card(
                                  child: Container(
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Heart Disease', style: TextStyle(fontWeight: FontWeight.w500),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Percentage: ${''}', style: TextStyle(fontSize: 15),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(14, 0, 8, 8),
                                            child: Text('Precautions according to precentage : ${''}',style: TextStyle(fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],

                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        )
    );
  }
}
