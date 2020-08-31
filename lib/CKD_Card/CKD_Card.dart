import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';

class CKD_Cards extends StatefulWidget {
  final BaseAuth auth=Auth();
  CKD_Cards();
  @override
  _CKD_CardsState createState() => _CKD_CardsState();
}

class _CKD_CardsState extends State<CKD_Cards> {
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
      key: ValueKey('CKD_Card'),
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
                  'assets/CKD_image/kidney.png',
                  width: 300,
                  height: 200,
                  fit:BoxFit.fitWidth

              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Chronical kidney disease',
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
                      child: InkWell(
                        key: ValueKey('CKDdiscriptionButton'),
                        onTap: ()async{
                          Navigator.pushNamed(context, '/CKD_discription');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left :15),
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
                    Expanded(
                        child:InkWell(
                          onTap: ()async {
                            String uid= await widget.auth.currentUser();
                            Navigator.pushNamed(context, '/CKD_message',arguments:UID(uid: uid));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                              padding: EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  'assets/CKD_image/docIcon.png',
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