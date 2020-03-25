import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CKD_Cards extends StatefulWidget {
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
                  'assets/kidney.png',
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
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/CKD_discription');
                        },
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50, 0, 5, 2),
                                child: Icon(
                                    Icons.local_hospital,
                                    size: 40,),
                              ),
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
                          onTap: (){
                            Navigator.pushNamed(context, '/CKD_message');
                          },
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50, 0, 7, 3),
                                child: Image.asset(
                                  'assets/docIcon.png',
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