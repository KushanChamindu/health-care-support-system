import 'package:flutter/material.dart';
import 'dart:math';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double initmultipy=120;
  double multipy=0.0;

  @override
  void initState(){
    super.initState();

    controller=AnimationController( vsync: this, duration: Duration(milliseconds: 1500));
    animation_rotation=Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(CurvedAnimation(parent: controller, curve: Interval(0.0,1.0,curve: Curves.linear)));

    animation_radius_in=Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(
        parent: controller,curve: Interval(0.75, 1.0,curve: Curves.elasticIn)));
    animation_radius_out=Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,curve: Interval(0.0, 0.25,curve: Curves.elasticOut)));

    controller.addListener((){
      setState(() {
        if(controller.value>=0.75 && controller.value<=1.0){
          multipy=animation_radius_in.value*initmultipy;
        }else if (controller.value>=0.0 && controller.value<=0.25){
          multipy=animation_radius_out.value*initmultipy;
        }
      });
    });
//    controller.repeat(period: Duration(seconds: 3));
    controller.repeat();
    route_to_home();
  }
   void route_to_home() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/home');
    controller.stop();
  }
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 100,
      height: 100,
      child: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                color: Colors.white,
                  shape: BoxShape.circle,
                  image:DecorationImage(
                        image: AssetImage('assets/Doctor.png')
                            ),
                      ),
                ),
            ),
            RotationTransition(
              turns: animation_rotation,
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(multipy*cos(pi/4), multipy*sin(pi/4)),
                    child: Dot(
                      radius: 12,
                      color: Colors.redAccent,
                    ),
                  ),

            Transform.translate(
              offset: Offset(multipy*cos(2*pi/4), multipy*sin(2*pi/4)),
              child: Dot(
                radius: 12,
                color: Colors.black,
              ),
            ),
            Transform.translate(
              offset: Offset(multipy*cos(3*pi/4), multipy*sin(3*pi/4)),
              child: Dot(
                radius: 12,
                color: Colors.amber,
              ),
            ),
            Transform.translate(
              offset: Offset(multipy*cos(4*pi/4), multipy*sin(4*pi/4)),
              child: Dot(
                radius: 12,
                color: Colors.green,
              ),
            ),
            Transform.translate(
              offset: Offset(multipy*cos(5*pi/4), multipy*sin(5*pi/4)),
              child: Dot(
                radius: 12,
                color: Colors.orange,
              ),
            ),
            Transform.translate(
              offset: Offset(multipy*cos(6*pi/4), multipy*sin(6*pi/4)),
              child: Dot(
                radius: 12,
                color: Colors.purpleAccent,
              ),
            ),
            Transform.translate(
              offset: Offset(multipy*cos(7*pi/4), multipy*sin(7*pi/4)),
              child: Dot(
                radius: 12,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset: Offset(multipy*cos(8*pi/4), multipy*sin(8*pi/4)),
              child: Dot(
                radius: 12,
                color: Colors.brown,
              ),
            ),
                ],
              ),
            ),
          ],
    ),

        ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}


