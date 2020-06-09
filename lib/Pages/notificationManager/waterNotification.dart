import 'dart:async';
import 'dart:math';

//import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/NotificationService.dart';
import 'package:healthcaresupportsystem/Pages/validation/Validation_of_Form_waternotification.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Popupmenu.dart';
import 'Chart.dart';

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
    return StreamProvider<DocumentSnapshot>.value(
        value: widget.notificationService.waterNotificationData(args.uid),
        child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              leading: IconButton(
                key: ValueKey('waterNotificationBackButton'),
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
                Popupmenu(
                  auth: widget.auth,
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
  final drinkWaterFormKey = new GlobalKey<FormState>();
  final formatTime = DateFormat("HH:mm");

  DateTime startTime;
  DateTime finishedTime;
  int waterGoal;
  int drunkWater;
  double percentage;
  var visibility = true;
  List<String> waterMotivation = [
    'Promotes Proper Kidney Function',
    'Fueling the body with oxygen delivery',
    'Regulating temperature',
    'Lubricating joints',
    'Gastrointestinal health',
    'Maintains a Healthy Digestion',
    'Promotes Healthy Skin',
    'Reduces Risk for Urinary Tract Infections',
    'Helps Alleviate Mood'
  ];
  List<String> waterGoalList = [
    '1000 ml',
    '1500 ml',
    '2000 ml',
    '2500 ml',
    '3000 ml',
    '3500 ml',
  ];
  List<String> dayNames = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
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
      'channel_ID',
      'channel_name',
      'chanell description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker',
      color: Colors.blueAccent,
      enableLights: true,
    );
    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);
    //TODO: demonstration only
    int difference = finishedTime.difference(startTime).inMinutes;
    var alarmStartTime = DateTime(startTime.year, startTime.month,
        startTime.day, startTime.hour, startTime.minute, 0);
    for (var i = 0; i < difference; i++) {
      await flutterLocalNotificationsPlugin.schedule(
          i,
          'Water Alerm $i',
          ('Time to drink water and update your water tracking system'),
          alarmStartTime.add(Duration(seconds: i * 2)),
          platformChannelSpecifics,
          payload: '/WaterNotification');
    }
  }

  Future onSelectNotification(String payload) async {
    if (payload == '/WaterNotification') {
      debugPrint(ModalRoute.of(context).settings.name == null
          ? 'on selected null'
          : 'on selected notnull');
    }
//    debugPrint(ModalRoute.of(context).settings.name ==null? 'on selected null': 'on selected notnull');
  }

  void changeVIsibility(index) {
    setState(() {
      if (index == 1) {
        visibility = false;
      } else {
        visibility = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final waterNotificationData = Provider.of<DocumentSnapshot>(context);
    try {
      var waterData = waterNotificationData.data;
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
      final TextEditingController _drinkWaterController =
          new TextEditingController(text: '100');

      toggleButton() async {
        try {
          await widget.notificationService
              .updateIsAlarm(widget.uid, !alermToggle);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Connection problem'),
            backgroundColor: Colors.blue[900],
            duration: Duration(seconds: 1),
            action: new SnackBarAction(
                textColor: Colors.white, label: 'OK', onPressed: () {}),
          ));
        }
        setState(() {
          alermToggle = !alermToggle;
        });
      }

      bool validateAndSave() {
        final form = waterFormKey.currentState;
        if (form.validate()) {
          form.save();
          return true;
        } else {
          return false;
        }
      }

      void validateAndSubmit() async {
        if (validateAndSave()) {
          alermToggle == false ? toggleButton() : null;
          try {
            // ignore: unrelated_type_equality_checks
            if (startTime == waterData['startTime'].toDate() &&
                finishedTime == waterData['endTime'].toDate() &&
                waterGoal == waterData['goal']) {
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Already Saved details'),
                backgroundColor: Colors.blue[900],
                action: new SnackBarAction(
                    textColor: Colors.white, label: 'OK', onPressed: () {}),
              ));
            } else {
              await widget.notificationService.updateWaterTimer(
                  widget.uid, startTime, finishedTime, waterGoal);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Saved changes'),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.blue[900],
                action: new SnackBarAction(
                    textColor: Colors.white, label: 'OK', onPressed: () {}),
              ));
            }
            await _showNotification();
          } catch (e) {
            print('Error : $e');
            Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Check your internet connection'),
              backgroundColor: Colors.blue[900],
              action: new SnackBarAction(
                  textColor: Colors.white, label: 'OK', onPressed: () {}),
            ));
          }
        }
      }

      createAlertDialog(BuildContext context, status) {
        return showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(milliseconds: 1000), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: status == 'okey'
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
//                      borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/NotificationManager/drinkwater.gif'))),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/connection_lost.gif'))),
                        ));
            });
      }

      void dinkWaterSubmit() async {
        final drinkForm = drinkWaterFormKey.currentState;
        if (drinkForm.validate()) {
          drinkForm.save();
          try {
            await widget.notificationService.updateDrinkWater(widget.uid,
                drunkWater, waterData[dayNames[DateTime.now().weekday - 1]]);
//            createAlertDialog(context, 'okey');
          } catch (e) {
            createAlertDialog(context, 'error');
          }
        }
      }

      //variable setting codes
      if (waterData['firstday']
                  .toDate()
                  .difference(DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day))
                  .inDays <=
              0 &&
          waterData['isReset'] == true) {
        widget.notificationService.resetData(widget.uid).then((_) => {});
      }
      if (waterData['firstday']
                  .toDate()
                  .difference(DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day))
                  .inDays <=
              2 &&
          waterData['isReset'] == false) {
        widget.notificationService.setResetVariable(widget.uid);
      }
      if (waterData['isAlermOn'] != null &&
          waterData['startTime'].toDate().day != DateTime.now().day &&
          waterData['isAlermOn'] == true) {
        toggleButton();
      }
      if (waterData[dayNames[DateTime.now().weekday - 1]] != null) {
        percentage = ((waterData[dayNames[DateTime.now().weekday - 1]] /
                waterData['goal'])
            .toDouble());
        if (percentage >= 1) percentage = 1;
      } else {
        percentage = 0.0;
      }
      return Builder(
          builder: (context) => Scaffold(
                key: ValueKey('waterNotificationPage'),
                bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: Colors.blueAccent,
                  height: 50,
                  animationDuration: Duration(milliseconds: 200),
                  animationCurve: Curves.decelerate,
                  items: <Widget>[
                    Icon(Icons.alarm,
                        size: 30,
                        key: ValueKey('waterNotificationDrinkPageButton')),
                    Icon(
                      Icons.assessment,
                      size: 30,
                      key: ValueKey('waterNotificationChartPageButton'),
                    ),
                  ],
                  onTap: (index) {
                    changeVIsibility(index);
                  },
                ),
                body: Container(
                    color: Colors.blueAccent,
                    child: Stack(
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
                                                      milliseconds: 200),
                                                  curve: Curves.easeIn,
                                                  top: 3.0,
                                                  left:
                                                      alermToggle ? 55.0 : 0.0,
                                                  right:
                                                      alermToggle ? 0.0 : 55.0,
                                                  child: Tooltip(
                                                    message: alermToggle ==
                                                            false
                                                        ? 'first add valide data'
                                                        : 'submit form',
                                                    child: InkWell(
                                                      key: ValueKey(
                                                          'waterNotificationBellButton'),
                                                      onTap: () async {
                                                        if (alermToggle ==
                                                            false) {
                                                          await validateAndSubmit();
                                                        } else {
                                                          toggleButton();
                                                          await flutterLocalNotificationsPlugin
                                                              .cancelAll();
                                                        }
                                                        ;
                                                      },
                                                      child: AnimatedSwitcher(
                                                        duration: Duration(
                                                            milliseconds: 100),
                                                        transitionBuilder:
                                                            (Widget child,
                                                                Animation<
                                                                        double>
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
                                                                color: Colors
                                                                    .green,
                                                                size: 30,
                                                                key:
                                                                    UniqueKey(),
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .notifications,
                                                                color:
                                                                    Colors.red,
                                                                size: 30,
                                                                key:
                                                                    UniqueKey(),
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
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 8.0),
                                      child: Form(
                                        onChanged: () {
                                          if (alermToggle == true) {
                                            validateAndSubmit();
                                          }
                                        },
                                        autovalidate: true,
                                        key: waterFormKey,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              key: ValueKey(
                                                  'waterNotificationStartTime'),
                                              onSaved: (value) => startTime =
                                                  DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                      int.parse(
                                                          value.split(':')[0]),
                                                      int.parse(
                                                          value.split(':')[1])),
                                              autovalidate: true,
                                              //startTime =value,
                                              validator: (value) =>
                                                  ValidationOfFormWater
                                                      .StartimeValidation(value,
                                                          _endController),
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
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide: BorderSide(
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
                                                            hour: int.parse(waterData[
                                                                    'startTime']
                                                                .toDate()
                                                                .toString()
                                                                .split(' ')[1]
                                                                .trim()
                                                                .split(':')[0]),
                                                            minute: int.parse(
                                                                waterData['startTime']
                                                                    .toDate()
                                                                    .toString()
                                                                    .split(
                                                                        ' ')[1]
                                                                    .trim()
                                                                    .split(':')[1]))
                                                        : TimeOfDay.now()));
                                                (time != null)
                                                    ? _startController
                                                        .text = time
                                                            .toString()
                                                            .split(':')[0]
                                                            .substring(10, 12) +
                                                        ":" +
                                                        time
                                                            .toString()
                                                            .split(':')[1]
                                                            .substring(0, 2)
                                                    : null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              key: ValueKey(
                                                  'waterNotificationEndTime'),
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
                                              validator: (value) =>
                                                  ValidationOfFormWater
                                                      .EndtimeValidation(value,
                                                          _startController),
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
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide: BorderSide(
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
                                                            hour: int.parse(waterData[
                                                                    'endTime']
                                                                .toDate()
                                                                .toString()
                                                                .split(' ')[1]
                                                                .trim()
                                                                .split(':')[0]),
                                                            minute: int.parse(
                                                                waterData['endTime']
                                                                    .toDate()
                                                                    .toString()
                                                                    .split(
                                                                        ' ')[1]
                                                                    .trim()
                                                                    .split(':')[1]))
                                                        : TimeOfDay.now()));
                                                (time != null)
                                                    ? _endController.text = time
                                                            .toString()
                                                            .split(':')[0]
                                                            .substring(10, 12) +
                                                        ":" +
                                                        time
                                                            .toString()
                                                            .split(':')[1]
                                                            .substring(0, 2)
                                                    : null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) =>
                                                  ValidationOfFormWater
                                                      .waterGoalValidation(
                                                          value),
                                              onSaved: (value) =>
                                                  waterGoal = int.parse(value),
                                              controller: _goalController,
                                              decoration: InputDecoration(
                                                labelText: 'Goal',
                                                hintText: 'Input Goal',
                                                prefixIcon: Icon(Icons.face),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.blue)),
                                                suffixIcon:
                                                    PopupMenuButton<String>(
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    key: ValueKey(
                                                        'waterNotificationGoal'),
                                                  ),
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
                                                          child:
                                                              new Text(value),
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
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06),
                                            child: CircularPercentIndicator(
                                              progressColor: Colors.blueAccent,
                                              lineWidth: 15,
                                              radius: 150,
                                              curve: Curves.ease,
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              center: Container(
                                                width: 119,
                                                height: 119,
                                                child: RaisedButton(
                                                  key: ValueKey(
                                                      'waterNotificationDrinkButton'),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    dinkWaterSubmit();
                                                  },
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      Text('Tap to drink'),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      (waterData[dayNames[DateTime
                                                                              .now()
                                                                          .weekday -
                                                                      1]] /
                                                                  waterData[
                                                                      'goal']) >=
                                                              1
                                                          ? Text(
                                                              (waterData[dayNames[DateTime.now().weekday -
                                                                              1]] /
                                                                          waterData[
                                                                              'goal'] *
                                                                          100)
                                                                      .toString()
                                                                      .split(
                                                                          '.')[0] +
                                                                  '%',
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            )
                                                          : Text(
                                                              (waterData[dayNames[DateTime.now().weekday -
                                                                              1]] /
                                                                          waterData[
                                                                              'goal'] *
                                                                          100)
                                                                      .toString()
                                                                      .split(
                                                                          '.')[0] +
                                                                  '%',
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                    ],
                                                  ),
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          width: 2,
                                                          color: Colors.white,
                                                          style: BorderStyle
                                                              .solid)),
                                                ),
                                              ),
                                              percent: percentage,
                                              animation: true,
                                              animateFromLastPercent: true,
                                              backgroundColor: Colors.black26,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              'Benefites of water',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            ConstrainedBox(
                                              constraints:
                                                  new BoxConstraints.loose(
                                                      new Size(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          55.0)),
                                              child: Swiper(
                                                  itemCount: 8,
                                                  autoplay: true,
                                                  curve: Curves.ease,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        waterMotivation[index],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            letterSpacing: 1),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Form(
                                                  key: drinkWaterFormKey,
                                                  autovalidate: true,
                                                  child: TextFormField(
                                                    key: ValueKey("waterNotificationAmount"),
                                                    controller:
                                                        _drinkWaterController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      WhitelistingTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    validator: (value) =>
                                                        ValidationOfFormWater
                                                            .drinkWaterValidation(
                                                                value),
                                                    onSaved: (value) =>
                                                        drunkWater =
                                                            int.parse(value),
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Drinking amount',
                                                      hintText:
                                                          'Drinking amount',
                                                      prefixIcon: Icon(
                                                          Icons.local_drink),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .blue)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          transform: !visibility
                              ? Matrix4.rotationY(pi / 180)
                              : Matrix4.rotationY(pi / 1),
                          alignment: !visibility
                              ? Alignment.topCenter
                              : AlignmentDirectional.topEnd,
                          curve: Curves.ease,
                          child: Visibility(
                            visible: !visibility,
                            child: visibility == false
                                ? BarChartSample1(
                                    waterData: waterData,
                                    isVisible: !visibility,
                                  )
                                : Text(''),
                          ),
                        )
                      ],
                    )),
              ));
    } catch (e) {
      print(e);
      return Builder(
        builder: (context) => Center(
            child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/loading.gif'),
            ),
          ),
        )),
      );
    }
  }
}
