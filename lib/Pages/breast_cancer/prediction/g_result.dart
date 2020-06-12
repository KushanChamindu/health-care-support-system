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
                    child: Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'You have a Good News...!',
                          style: TextStyle(
                            fontSize: 32,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = Colors.green[800],
                          ),
                        ),
                        // Solid text as fill.
                        Text(
                          'You have a Good News...!',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
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
      child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            'Good news....!! You have only 3% of having cancer.',
            style: TextStyle(
              fontSize: 16,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = Colors.green[700],
            ),
          ),
          // Solid text as fill.
          Text(
            'Good news....!! You have only 3% of having cancer.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
        ],
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
          color: Colors.lightBlueAccent,
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
        backgroundColor: Colors.lightBlue,
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