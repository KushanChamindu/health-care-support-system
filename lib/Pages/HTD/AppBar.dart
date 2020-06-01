import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Popupmenu.dart';

class GradientAppBar extends StatelessWidget {
  final BaseAuth auth = Auth();
  final String title;
  final String route;
  final double barHeight = 66;

  GradientAppBar(this.title, this.route);

  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return SafeArea(
      child: new Container(
          height: barHeight,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.blueAccent,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.5, 0.0),
                stops: [0.0, 0.5],
                tileMode: TileMode.clamp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  key: ValueKey('HTDBackbutton'),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
//                Navigator.pushNamed(context, this.route);
                  }),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0)),
//            IconButton(icon:Icon(Icons.),onPressed:(){}),
              Popupmenu(
                auth: auth,
              )
            ],
          )),
    );
  }
}
