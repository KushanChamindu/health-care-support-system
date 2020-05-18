import 'package:flutter/material.dart';
import 'package:healthcaredecision/HTD_card/HTD_dart.dart';
import 'package:healthcaredecision/pages/Home.dart';

class GradientAppBar extends StatelessWidget{
  final String title;
  final String route;
  final double barHeight=66;
  GradientAppBar(this.title,this.route);
  Widget build(BuildContext context){
    final double statusBarHeight= MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      height : barHeight,
        decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors:[
              const Color(0xFF3366FF),
               Colors.blue[900],
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp
        ),
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon:Icon(Icons.arrow_back),onPressed:(){
           Navigator.pushNamed(context, this.route);





          }),
          Text(title, style: const TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 24.0)),
          IconButton(icon:Icon(Icons.menu),onPressed:(){}),
        ],
      )
    );
  }

}