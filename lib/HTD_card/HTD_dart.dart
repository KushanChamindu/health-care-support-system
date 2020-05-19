import 'dart:ui';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/pages/HTD/HTD_Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';

class HTD_Cards extends StatefulWidget {
  final BaseAuth auth=Auth();
  HTD_Cards();
  @override
  _HTD_CardsState createState() => _HTD_CardsState();
}

class _HTD_CardsState extends State<HTD_Cards> {
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
                  'assets/HTD/images/card.png',
                  width: 300,
                  height: 200,
                  fit:BoxFit.fitWidth

              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Heart disease',
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
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                          key: ValueKey('CKDdiscriptionButton'),
                          onTap: ()async{
                            Navigator.push (
                              context,
                              MaterialPageRoute(
                                builder: (context)=>HTD_Home(),
                              ),
                            );
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
                                  'Discription',
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
                        onTap: ()async{
                          String uid= await widget.auth.currentUser();
                          Navigator.pushNamed(context, '/HTD_message',arguments:UID(uid: uid));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/HTD/images/docIcon.png',
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