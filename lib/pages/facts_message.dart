import 'package:flutter/material.dart';
import 'package:healthcaredecision/pages/Style.dart';
class Facts extends StatelessWidget {
  Facts({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> botMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child:  new Image.asset("assets/images/mobile_doctor.png"),
        ), backgroundColor: Colors.lightBlueAccent[200], radius: 24,),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Text(this.name,
               style: Style.baseTextStyle),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text,style:Style.titleTextStyle ),
                )
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> userMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name,
                style: Style.baseTextStyle),
            Card(
              color: Colors.lightBlue[400],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, style: Style.titleTextStyle),
                )
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(child: new Text(this.name[0]),backgroundColor: Colors.lightBlueAccent[200], radius: 24,),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? userMessage(context) : botMessage(context),
      ),
    );
  }
}