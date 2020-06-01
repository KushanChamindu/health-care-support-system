import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';

import '../../Popupmenu.dart';

class Bresult extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _BresultState createState() => _BresultState();
}

class _BresultState extends State<Bresult> {
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
                    child: Text(
                      "Result is't good...!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
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
        'You have 97% of chance having the cancer cancer.  '
            'This doesn’t define you.. '
            'Meet your doctor immediately ',
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
            ),
        softWrap: true,
        ),
        FlatButton(
          onPressed: (){
            Navigator.pushNamed(context, '/bc_solutions');
          }, 
          child: Text('Precausions'),
          color: Colors.blueAccent,
        ),
        Text(
            'Check if you have the following symptoms',
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
            Navigator.pushNamed(context, '/bc_symptoms');
          }, 
          child: Text('Symptoms'),
          color: Colors.blueAccent,
        )
      ],
      )
        
    );

    return Scaffold(
      appBar: AppBar(

        actions: <Widget>[
          Popupmenu(auth: widget.auth,)
        ],
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Results...- Breast Cancer",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        //centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body:ListView(
        children: <Widget>[
          titleSection,
          Image.asset(
            'assets/breast_cancer_image/bad3.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          textSection,
          buttonSection,
          Image.asset(
            'assets/breast_cancer_image/bad1.jpg',
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