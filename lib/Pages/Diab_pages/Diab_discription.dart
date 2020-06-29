//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Diab_symptom.dart';



class Diab_discription extends StatefulWidget {

  @override
  _Diab_discriptionState createState() => _Diab_discriptionState();
}

class _Diab_discriptionState extends State<Diab_discription> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar:  AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Diabetes',
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 4, 0, 4),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/Diab_images/Doctor.png',
                  ),
                  radius: 20,
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),


        backgroundColor: Colors.grey[850],
      ),
      body:
       SingleChildScrollView(
        child: Column(
          children: <Widget>[



            Align(
                child: Card_body(
                    image : 'assets/Diab_images/diab1-cropped.png',
                    text1: 'Facts about Diabetes',
                    routeName: '/Diab_about',
                    substring1:'Brief Description' ,
                    substring2: 'Causes of Diabetes',
                    substring3: 'What actually happens',),



                ),
            Align(
              child: Card_body(
                image : 'assets/Diab_images/diab2-cropped.png',
                text1: 'Symptoms of Diabetes',
                routeName: '/Diab_symptom',
                substring1:'Main Symptoms' ,
                substring2: 'Small Description',
                substring3: 'What actually happens',),



            ),
            Align(
              child: Card_body(
                image : 'assets/Diab_images/diab-cropped.png',
                text1: 'Precautions of Diabetes',
                routeName: '/Diab_precaution',
                substring1:'Main Precautions' ,
                substring2: 'Small Description',
                substring3: 'What actually happens',),



            ),
            Align(
              child: Card_body(
                image : 'assets/Diab_images/food.png',
                text1: 'Foods for Diabetes',
                routeName: '/Diab_food',
                substring1:'Food Contents' ,
                substring2: 'Healthy Food Choices',
                substring3: 'Best and Worst Foods',),



            ),


            Card(
                color:Colors.amberAccent,
                child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Diab_webview');
                    },

                    icon: Icon(Icons.public),
                    label: Expanded(
                        child: Text("Open More Info",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900)))),
              ],
            )),
          ],
        ),
      ),
    );
  }
}


class Card_body extends StatelessWidget {
  final String image;
  final String text1;
  final String routeName;
  final String substring1;
  final String substring2;
  final String substring3;
  Card_body({this.image,this.text1,this.routeName,this.substring1,this.substring2,this.substring3});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: new Stack(
        children: <Widget>[
          DetailCard(text2: text1, routeName: routeName,substring1: substring1,substring2: substring2,substring3: substring3),
          DetailThumbnail(ima : image),
        ],
      ),
    );
  }
}
class DetailCard extends StatelessWidget {
  final String text2;
  String routeName;
  final String substring1;
  final String substring2;
  final String substring3;

  DetailCard({this.text2, this.routeName,this.substring1,this.substring2,this.substring3});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 124,
        margin: new EdgeInsets.only(left: 46,right: 20),
        decoration: new BoxDecoration(
          color: Colors.grey[800],
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: new Offset(0, 10)
            )
          ]
        ),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Column(
              children:<Widget>[
                SizedBox(height: 20,),

                Text(text2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat'
              ),
              ),
                Divider(
                  height: 5,
                  color: Colors.white,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                    children:<Widget>[new MyBullet(), Text(substring1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontFamily: 'Montserrat'),)]),
                Row(children:<Widget>[new MyBullet(), Text(substring2,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontFamily: 'Montserrat'),)]),
                Row(children:<Widget>[new MyBullet(), Text(substring3,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontFamily: 'Montserrat'),)]),
              ]
            ),

          ],
        ),


      ),
      onTap: (){
        print ('tapped');
        Navigator.pushNamed(context, routeName);
      },
    );

  }
}
class DetailThumbnail extends StatelessWidget {
  final String ima;
  DetailThumbnail({this.ima});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage(ima),
        height: 92,
          width: 92,
      ),
    );
  }
}
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: EdgeInsets.fromLTRB(20, 8, 5, 8),
      child: new Container(
        height: 5.0,
        width: 5.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}


