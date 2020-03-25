import 'package:flutter/material.dart';

class CKD_precautions extends StatefulWidget {
  @override
  _CKD_precautionsState createState() => _CKD_precautionsState();
}

class _CKD_precautionsState extends State<CKD_precautions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text(
                'Chronic Kiney Disease Precautions',
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
//              Container(
//                color: Colors.white,
//                child:Column(
//                  children: <Widget>[
//                    Image.asset('assets/Doctor.png',
//                    ),
//                   Text('ahgdfjafg'),
//                  ],
//                ),
//              )
              Text('cat'),
              Row(
                children: <Widget>[
                  Image.asset('assets/CKD_image/low_salt.jpg', width: 100,height: 100,),
                      ],
                    ),

                  ],
          ),
        ));
  }
}
