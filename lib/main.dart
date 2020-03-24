import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/Doctor.png'),
            radius: 30,
            backgroundColor: Colors.blueAccent,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(50, 150, 5, 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Doctor.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Text('Chronical kidney disease'),
            ),
            Container(

            )
          ],
        ),
      ),
    );
  }
}
