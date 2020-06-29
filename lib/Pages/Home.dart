import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/CKD_Card/CKD_Card.dart';
import 'package:healthcaresupportsystem/Diab_Card/Diab_Card.dart';
import 'package:healthcaresupportsystem/HTD_card/HTD_dart.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/breast_cancer_Card/breast_cancer_Card.dart';
import 'Popupmenu.dart';
import 'notificationManager/NotificationButtonCard.dart';



class Home extends StatelessWidget {
  final BaseAuth auth=Auth();
  @override
  Widget build(BuildContext context,) {
    Future<bool> _onBackPress(){
      return showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text('Do you really want to exit the app?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: ()=>Navigator.pop(context,true),
              ),
              FlatButton(
                child: Text('No'),
                onPressed: ()=>Navigator.pop(context,false),
              ),
            ],
          )
      );
    }
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
          backgroundColor: Colors.blue[100],
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              Popupmenu(auth: auth,)
            ],
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/CKD_image/Doctor.png'),
                radius: 30,
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              ListView(
                key: Key('HomePage'),
                  children: <Widget>[
                    Container(
                        margin:EdgeInsets.all(8.0),
                        child:Column(
                          children: <Widget>[
                            NotificationButtonCard(),
                            CKD_Cards(),
                            BC_Cards(),
                            HTD_Cards(),
                            Diab_Cards(),
                          ],
                        )
                    ),
                  ]
              ),
            ],
          )
      ),
    );
  }
}

