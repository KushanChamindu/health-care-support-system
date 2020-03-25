import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CKD_symptoms extends StatefulWidget {
  @override
  _CKD_symptomsState createState() => _CKD_symptomsState();
}

class _CKD_symptomsState extends State<CKD_symptoms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'Chronic Kiney Disease Symptoms',
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
        child: Container(
            child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Blood in your pee (urine)',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Shortness of breath',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Itchy skin',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Muscle cramps',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 15, 25, 15),
                              child: new MyBullet(),
                            ),
                            new Text(
                              'Erectile dysfunction in men',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Weight loss and poor appetite'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text(
                          'Swollen ankles, feet or hands – as a result of water retention'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Tiredness'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text(
                          'An increased need to pee – particularly at night'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Difficulty sleeping (insomnia'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('feeling sick'),
                    ),
                    new ListTile(
                      leading: new MyBullet(),
                      title: new Text('Headaches'),
                    ),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 0, 3),
      child: new Container(
        height: 10.0,
        width: 10.0,
        decoration: new BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
