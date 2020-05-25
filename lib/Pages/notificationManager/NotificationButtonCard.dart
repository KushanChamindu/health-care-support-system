import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';

class NotificationButtonCard extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _NotificationButtonCardState createState() => _NotificationButtonCardState();
}

class _NotificationButtonCardState extends State<NotificationButtonCard> {
  Widget WaterCard(BuildContext context){
    return Card(
      key: ValueKey('waterNotificationCard'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/NotificationManager/waterNotifi.gif',
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.fill,
                )),
            ListTile(
              title: Center(
                child: Text(
                  'Notification for drink water',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () async{
          String uid= await widget.auth.currentUser();
          Navigator.pushNamed(context, '/WaterNotification',arguments:UID(uid: uid));},
      ),
    );
  }
  Widget DietCard(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/NotificationManager/diet-plan.gif',
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.fitWidth,
                )),
            ListTile(
              title: Center(
                child: Text(
                  'Notification for diet plan',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () async{
          String uid= await widget.auth.currentUser();
          Navigator.pushNamed(context, '/DietNotification',arguments:UID(uid: uid));},
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Widget watercard=WaterCard(context);
    Widget dietcard=DietCard(context);
    return ConstrainedBox(
      constraints: new BoxConstraints.loose(
          new Size(MediaQuery.of(context).size.width, 265.0)),
      child: Swiper(
        itemCount: 2,
//        scrollDirection: Axis.vertical,
      layout:SwiperLayout.STACK,
        itemWidth: MediaQuery.of(context).size.width,
        autoplay: true,
        curve: Curves.decelerate,

        itemBuilder: (BuildContext context, int index,) {
          if (index == 0) {
            return watercard;
          } else {
            return dietcard;
          }
        },
      ),
    );
  }
}
