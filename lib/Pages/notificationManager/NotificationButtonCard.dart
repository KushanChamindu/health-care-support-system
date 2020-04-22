import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';

class waterButtonCard extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _waterButtonCardState createState() => _waterButtonCardState();
}

class _waterButtonCardState extends State<waterButtonCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints.loose(
          new Size(MediaQuery.of(context).size.width, 265.0)),
      child: Swiper(
        itemCount: 2,
        autoplay: true,
        curve: Curves.decelerate,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
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
                          'assets/waterNotifi.gif',
                          width: 387,
                          height: 200,
                          fit: BoxFit.fitWidth,
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
          } else {
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
                          'assets/diet-plan.gif',
                          width: 387,
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
        },
      ),
    );
  }
}
