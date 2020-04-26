import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/NotificationService.dart';
import 'package:healthcaresupportsystem/Pages/validation/ValidationForm.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WaterNotification extends StatefulWidget {
  final BaseAuth auth = Auth();
  final NotificationService notificationService = NotificationService();
  @override
  _WaterNotificationState createState() => _WaterNotificationState();
}

class _WaterNotificationState extends State<WaterNotification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UID args = ModalRoute.of(context).settings.arguments;
    void choiceAction(String choice) async {
      if (choice == 'Account') {
        try {
          String uid = await widget.auth.currentUser();
          Navigator.pushNamed(context, '/account', arguments: UID(uid: uid));
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Check your internet connection'),
          ));
        }
      } else if (choice == 'SignOut') {
        print('SignOut');
        await widget.auth.singOut();
        if (await widget.auth.currentUser() == null) {
          Navigator.pushReplacementNamed(context, '/');
        }
      } else {
        showAboutDialog(
            context: context,
            applicationIcon: Image.asset(
              'assets/CKD_image/Doctor.png',
              width: 100,
              height: 100,
            ),
            applicationName: "Mobile Doctor",
            applicationVersion: '0.0.1',
            applicationLegalese:
                'This software developed by HCSS PVT LMD. Copyright © 2020 Arnoud Engelfriet. Some rights reserved.',
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  child: Text('* Chronic kidney disease'),
                ),
              ),
              Container(
                child: Text('* Diabetise'),
              ),
              Container(
                child: Text('* Heart disease'),
              ),
              Container(
                child: Text('* Beast Cancer'),
              )
            ]);
      }
    }

    return StreamProvider<QuerySnapshot>.value(
        value: widget.notificationService.waterNotificationData,
        child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Water Drinking Plan',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 4, 0, 4),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/CKD_image/Doctor.png',
                        ),
                        radius: 20,
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return Constant.choice.map((String choice) {
                      if (choice == 'Account') {
                        return PopupMenuItem(
                            value: choice,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(choice)
                              ],
                            ));
                      } else if (choice == 'SignOut') {
                        return PopupMenuItem(
                            value: choice,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(choice)
                              ],
                            ));
                      } else {
                        return PopupMenuItem(
                            value: choice,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.flag,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(choice)
                              ],
                            ));
                      }
                    }).toList();
                  },
                )
              ],
              backgroundColor: Colors.blueAccent,
            ),
            body: Container(
              child: Center(
                child: WaterNotificationBody(
                  uid: args.uid,
                  auth: widget.auth,
                  notificationService: widget.notificationService,
                ),
              ),
            )));
//
  }
}

class WaterNotificationBody extends StatefulWidget {
  final String uid;
  final BaseAuth auth;
  final NotificationService notificationService;
  WaterNotificationBody({this.uid, this.auth, this.notificationService});
  @override
  _WaterNotificationBodyState createState() => _WaterNotificationBodyState();
}

class _WaterNotificationBodyState extends State<WaterNotificationBody> {
  final waterFormKey = new GlobalKey<FormState>();
  final formatTime = DateFormat("HH:mm");
  DateTime startTime;
  DateTime finishedTime;
  int waterGoal;
  var visibility = true;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingAndroid;
  var initializationSettingIOS;
  var initializationSettings;
  @override
  void initState() {
    super.initState();
    initializationSettingAndroid =
        new AndroidInitializationSettings('app_icon');
    initializationSettingIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingAndroid, initializationSettingIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
  void _showNotification() async {
    await _demoNotification();
  }
  Future<void> _demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel_name', 'chanell description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker',color: Colors.blueAccent,enableLights: true,);
    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);
    int difference= finishedTime.difference(startTime).inHours;
    for(var i=0;i<difference;i++){
      await flutterLocalNotificationsPlugin.schedule(
          i,
          'Water Alerm',
          ('Time to drink water and update your water tracking system'),
          startTime.add(Duration(seconds: i*2)),
          platformChannelSpecifics,
          payload: '/WaterNotification');
    }
  }
  Future onSelectNotification(String payload)async{
    if (payload=='/WaterNotification'){
      debugPrint(ModalRoute.of(context).settings.name ==null? 'on selected null': 'on selected notnull');
    }
//    debugPrint(ModalRoute.of(context).settings.name ==null? 'on selected null': 'on selected notnull');
  }
  void changeVIsibility() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    final waterNotificationData = Provider.of<QuerySnapshot>(context);
    try {
      var waterData = waterNotificationData.documents
          .firstWhere((doc) => doc.documentID == '${widget.uid}')
          .data;
      bool alermToggle = waterData['isAlermOn'] || false;
      final TextEditingController _goalController = new TextEditingController(
          text: (waterData['goal'] != 0) ? waterData['goal'].toString() : '0');
      final TextEditingController _startController = new TextEditingController(
          text: (waterData['startTime'] != null)
              ? waterData['startTime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[0] +
                  ":" +
                  waterData['startTime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[1]
              : '0');
      final TextEditingController _endController = new TextEditingController(
          text: (waterData['endTime'] != null)
              ? waterData['endTime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[0] +
                  ":" +
                  waterData['endTime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[1]
              : '0');

      bool validateAndSave() {
        final form = waterFormKey.currentState;
        if (form.validate()) {
          form.save();
          return true;
        } else {
          return false;
        }
      }
      toggleButton() async {
        try {
          await widget.notificationService
              .updateIsAlarm(widget.uid, !alermToggle);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Connection problem'),
          ));
        }
        setState(() {
          alermToggle = !alermToggle;
        });
      }
      createAlertDialog(BuildContext context) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 20,
                title: Text('Will you want to set alerm'),
                actions: <Widget>[
                  MaterialButton(
                    elevation: 2.0,
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    elevation: 2.0,
                    child: Text('Submit'),
                    onPressed: () {
                      if (alermToggle == false) {
                        toggleButton();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            });
      }
      void validateAndSubmit() async {
        if (validateAndSave()) {
          try {
            // ignore: unrelated_type_equality_checks
            if (startTime == waterData['startTime'].toDate() &&
                finishedTime == waterData['endTime'].toDate() &&
                waterGoal == waterData['goal']) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Already Saved details'),
              ));
            } else {
              await widget.notificationService.updateWaterTimer(
                  widget.uid, startTime, finishedTime, waterGoal);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Saved changes'),
              ));
            }
            alermToggle==false?toggleButton():null;
            await _showNotification();
          } catch (e) {
            print('Error : $e');
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Check your internet connection'),
            ));
          }
        }
      }

      List<String> waterGoalList = [
        '1000 ml',
        '1500 ml',
        '2000 ml',
        '2500 ml',
        '3000 ml',
        '3500 ml',
      ];
      if(waterData['isAlermOn']!=null && waterData['startTime'].toDate().day != DateTime.now().day && waterData['isAlermOn']==true){
        toggleButton();
      }
      return Builder(
          builder: (context) => Scaffold(
                bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: Colors.blueAccent,
                  height: 50,
                  animationDuration: Duration(milliseconds: 200),
                  animationCurve: Curves.decelerate,
                  items: <Widget>[
                    Icon(Icons.alarm, size: 30),
                    Icon(Icons.assessment, size: 30),
                  ],
                  onTap: (index) {
                    changeVIsibility();
                  },
                ),
                body: Scaffold(
                    backgroundColor: Colors.blueAccent,
                    body: Stack(
                      children: <Widget>[
                        AnimatedContainer(
                          transform: visibility
                              ? Matrix4.rotationY(pi / 180)
                              : Matrix4.rotationY(pi / 1),
                          duration: Duration(milliseconds: 200),
                          alignment: visibility
                              ? Alignment.topCenter
                              : AlignmentDirectional.topStart,
                          curve: Curves.ease,
                          child: Visibility(
                            visible: visibility,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              125),
                                          height: 50,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                (alermToggle == true)
                                                    ? 'Water notification turn on'
                                                    : "Water notification turn off",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 400),
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: alermToggle
                                                  ? Colors.green[100]
                                                  : Colors.red[100],
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                AnimatedPositioned(
                                                  duration: Duration(
                                                      milliseconds: 400),
                                                  curve: Curves.easeIn,
                                                  top: 3.0,
                                                  left:
                                                      alermToggle ? 55.0 : 0.0,
                                                  right:
                                                      alermToggle ? 0.0 : 55.0,
                                                  child: Tooltip(
                                                    message: alermToggle==false?'first add valide data':'submit form',
                                                    child: InkWell(
                                                      onTap: ()async{
                                                        if(alermToggle==false) {
                                                          await validateAndSubmit();
                                                        }else{
                                                          await flutterLocalNotificationsPlugin.cancelAll();
                                                          toggleButton();
                                                        };
                                                        },
                                                      child: AnimatedSwitcher(
                                                        duration: Duration(
                                                            milliseconds: 400),
                                                        transitionBuilder:
                                                            (Widget child,
                                                                Animation<double>
                                                                    animation) {
                                                          return ScaleTransition(
                                                            child: child,
                                                            scale: animation,
                                                          );
                                                        },
                                                        child: alermToggle
                                                            ? Icon(
                                                                Icons
                                                                    .notifications_active,
                                                                color:
                                                                    Colors.green,
                                                                size: 30,
                                                                key: UniqueKey(),
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .notifications,
                                                                color: Colors.red,
                                                                size: 30,
                                                                key: UniqueKey(),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 8.0),
                                      child: Form(
                                        onChanged: (){if(alermToggle==true){validateAndSubmit();}},
                                        autovalidate: true,
                                        key: waterFormKey,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              onSaved: (value) => startTime =
                                                  DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                      int.parse(
                                                          value.split(':')[0]),
                                                      int.parse(
                                                          value.split(':')[1])),
                                              autovalidate:
                                                  true, //startTime =value,
                                              validator: (value) => ValidationForm
                                                  .StartimeValidation(
                                                      value, _endController),
                                              readOnly: true,
                                              controller: _startController,
                                              decoration: InputDecoration(
                                                  labelText: 'Start time',
                                                  hintText: 'Input start time',
                                                  prefixIcon: Icon(Icons.alarm),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      4)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .blue))),
                                              onTap: () async {
                                                final time = (await showTimePicker(
                                                    context: context,
                                                    initialTime: waterData[
                                                                'startTime'] !=
                                                            null
                                                        ? TimeOfDay(
                                                            hour: int.parse(
                                                                waterData['startTime']
                                                                    .toDate()
                                                                    .toString()
                                                                    .split(' ')[1]
                                                                    .trim()
                                                                    .split(
                                                                        ':')[0]),
                                                            minute: int.parse(
                                                                waterData['startTime']
                                                                    .toDate()
                                                                    .toString()
                                                                    .split(' ')[1]
                                                                    .trim()
                                                                    .split(
                                                                        ':')[1]))
                                                        : TimeOfDay.now()));
                                                (time != null)
                                                    ?
                                                _startController.text =
                                                        time.toString().split(':')[0].substring(10,12) +
                                                            ":" +
                                                            time.toString().split(':')[1].substring(0,2)
                                                    : null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              onSaved: (value) => finishedTime =
                                                  DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                      int.parse(
                                                          value.split(':')[0]),
                                                      int.parse(
                                                          value.split(':')[1])),
                                              autovalidate: true,
                                              validator: (value) => ValidationForm
                                                  .EndtimeValidation(
                                                      value, _startController),
                                              readOnly: true,
                                              controller: _endController,
                                              decoration: InputDecoration(
                                                  labelText: 'End time',
                                                  hintText: 'Input end time',
                                                  prefixIcon: Icon(Icons.alarm),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      4)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .blue))),
                                              onTap: () async {
                                                final time = (await showTimePicker(
                                                    context: context,
                                                    initialTime: waterData[
                                                                'endTime'] !=
                                                            null
                                                        ? TimeOfDay(
                                                            hour: int.parse(
                                                                waterData['endTime']
                                                                    .toDate()
                                                                    .toString()
                                                                    .split(' ')[1]
                                                                    .trim()
                                                                    .split(
                                                                        ':')[0]),
                                                            minute: int.parse(
                                                                waterData['endTime']
                                                                    .toDate()
                                                                    .toString()
                                                                    .split(' ')[1]
                                                                    .trim()
                                                                    .split(
                                                                        ':')[1]))
                                                        : TimeOfDay.now()));
                                                (time != null)
                                                    ? _endController.text =
                                                    time.toString().split(':')[0].substring(10,12) +
                                                        ":" +
                                                        time.toString().split(':')[1].substring(0,2)
                                                    : null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) => ValidationForm
                                                  .waterGoalValidation(value),
                                              onSaved: (value) =>
                                                  waterGoal = int.parse(value),
                                              controller: _goalController,
                                              decoration: InputDecoration(
                                                labelText: 'Goal',
                                                hintText: 'Input Goal',
                                                prefixIcon: Icon(Icons.face),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.blue)),
                                                suffixIcon:
                                                    PopupMenuButton<String>(
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  onSelected: (String value) {
                                                    _goalController.text =
                                                        value.substring(0, 4);
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return waterGoalList.map<
                                                            PopupMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return new PopupMenuItem(
                                                          child: new Text(value),
                                                          value: value);
                                                    }).toList();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      height: 45,
                                      child: RaisedButton.icon(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        color: Colors.blue[200],
                                        splashColor: Colors.black38,
                                        elevation: 10,
                                        onPressed: validateAndSubmit,
                                        icon: Icon(Icons.alarm),
                                        label: Text('Set alarm'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RaisedButton.icon(
                                        onPressed: _showNotification,
                                        icon: Icon(Icons.notifications_active),
                                        label: Text('kushan')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          alignment: !visibility
                              ? Alignment.topCenter
                              : AlignmentDirectional.topEnd,
                          curve: Curves.ease,
                          child: Visibility(
                            visible: !visibility,
                            child: Container(
                              color: Colors.blueAccent,
                              child: Text('Graph'),
                            ),
                          ),
                        )
                      ],
                    )),
              ));
    } catch (e) {
      print(e);
      return Builder(
        builder: (context) => Center(
            child: Text(
          'Loading....',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        )),
      );
    }
  }
}

