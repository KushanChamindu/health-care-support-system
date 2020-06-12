import 'package:flutter/material.dart';

import '../Popupmenu.dart';
import 'Service/Auth.dart';

class AboutUs extends StatefulWidget {
  final BaseAuth auth = Auth();
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
Widget titleSection = Container(
      padding: const EdgeInsets.all(16),
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
                      'What is breast cancer...?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
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

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'About us',
                style: TextStyle(fontSize: 16),
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
          Popupmenu(
            auth: widget.auth,
          )
        ],
        backgroundColor: Colors.blueAccent,
      ),
       body:ListView(
        children: <Widget>[
          _buildTextRow('Who are we...?'),
          _buildContainer("We are undergraduates at Department of Computer Science and Enginnering, Faculty of Engineering, University of Moratuwa"),
          _buildTextContainer('Kushan Nilanga','kushanchamindu@gmail.com'),
          _buildTextContainer('Nishothan Vettivel','nishothanvettivel@gmail.com'),
          _buildTextContainer('Kashyapa Niyarepola','kashyapaniyarepola@gmail.com'),
          _buildTextContainer('Thukaraka Pakeerathan','thukarakapakeerathan@gmail.com'),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Image.asset(
              'assets/breast_cancer_image/guide/us.jpg',
              width: 500,
              height: 300,
              fit: BoxFit.cover,
          ),
           ),

        ],
        
        
      ),
      
    );
  }

  Row _buildTextRow(String label) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 36,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.brown[700],
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),   
              ],
            ),
          ),
        ),
      ],
    );
  }

 Card _buildTextContainer(String text,String email) {
    return Card(
      child: Container(
      padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            Icon(Icons.blur_linear),
            Expanded(
              /*1*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*2*/
                  Container(
                    //padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  Text(
                      email,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Cairo',
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      )
    );  
  }
 Container _buildContainer(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
      child: Text(
        text,
            style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Cairo',
            ),
        softWrap: true,  
      ),
    );
  }

}