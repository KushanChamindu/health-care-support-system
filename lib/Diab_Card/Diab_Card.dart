import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';


class Diab_Cards extends StatefulWidget {
  final BaseAuth auth=Auth();
  Diab_Cards();
  @override
  _Diab_CardsState createState() => _Diab_CardsState();
}

class _Diab_CardsState extends State<Diab_Cards> {
  @override
  bool viewVisible = false ;
  bool getVisible(){
    if(viewVisible==false){
      setState(() {
        viewVisible = true ;
      });
    }else{
      setState(() {
        viewVisible = false ;
      });
    }
  }

  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        onTap: (){getVisible();},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(
                  'assets/Diab_images/bc.jpg',
                  width: 300,
                  height: 200,
                  fit:BoxFit.fitWidth

              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Diabetes',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Visibility(
                visible: viewVisible,
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/Diab_discription');
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15,0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.local_hospital,
                                    size: 40,),
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                    Expanded(
                      child:Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: ()async{
                            String uid= await widget.auth.currentUser();
                            Navigator.pushNamed(context, '/Diab_message',arguments:UID(uid: uid));
                          },
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50, 0, 7, 3),
                                child: Image.asset(
                                  'assets/Diab_images/docIcon.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              Text(
                                'Doctor',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}