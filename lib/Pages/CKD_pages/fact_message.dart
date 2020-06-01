import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FactsMessage extends StatelessWidget {
  FactsMessage({this.text, this.name, this.type, this.imageUrl});

  final String text;
  final String name;
  final bool type;
  final String imageUrl;

  List<Widget> botMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/CKD_image/docProf.png'),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                )),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  colors: [Colors.grey[400],Colors.grey[200]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500),
              ),
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
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                      colors: [Colors.grey[400],Colors.grey[200]],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  )
              ),
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 4.0),
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
