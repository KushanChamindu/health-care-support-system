import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';

import '../../Popupmenu.dart';

class Gresult extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _GresultState createState() => _GresultState();
}

class _GresultState extends State<Gresult> {
  @override
  Widget build(BuildContext context) {

    Widget titleSection = Container(
      padding: const EdgeInsets.all(24),
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
                      'You have a Good News...!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28.0,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
      child: Text(
        'Good news....!! You have only 3% of havin cancer.  '
            '',
            style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Cairo',
            ),
        softWrap: true,  
      ),
    );
    Widget buttonSection = Container(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
        'Be careful.  '
            'Before you leave be aware of precausions',
            style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Cairo',
                        backgroundColor: Colors.grey[200],
                        fontWeight: FontWeight.w100
            ),
        softWrap: true,
        ),
        FlatButton(
          onPressed: (){
            Navigator.pushNamed(context, '/bc_solutions');
          }, 
          child: Text('Precausions'),
          color: Colors.blueAccent,
        )
      ],
      )
        
    );

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Results...- Breast Cancer",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        actions: <Widget>[
          Popupmenu(auth: widget.auth,)
        ],
        //centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body:ListView(
        children: <Widget>[
          titleSection,
          Image.asset(
            'assets/breast_cancer_image/good.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          textSection,
          buttonSection,
          Image.asset(
            'assets/breast_cancer_image/good1.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 3.0),
        ],
      )
      
    );
  }
}