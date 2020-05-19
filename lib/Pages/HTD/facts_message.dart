import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/pages/HTD/Style.dart';
class Facts extends StatelessWidget {
  Facts({this.text, this.name, this.type,this.imageUrl});

  final String text;
  final String name;
  final bool type;
  final String imageUrl;

  List<Widget> botMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child:  new Image.asset("assets/HTD/images/mobile_doctor.png"),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
        margin: const EdgeInsets.only(left: 16.0),
        child: imageUrl != null
            ? Container(
          width: 55,
                height: 56,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                      fadeInCurve: Curves.decelerate,
                      fit: BoxFit.fill,
                      placeholder: 'assets/loading.gif',
                      image: imageUrl),
                ))
            : CircleAvatar(
                radius: 25,
                child: Text(
                  this.name[0],
                  style: TextStyle(fontSize: 22),
                ),
              ),
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