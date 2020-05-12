import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/NotificationService.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/validation/Validation_of_Form_dietNotification.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import '../Popupmenu.dart';
import 'package:provider/provider.dart';

class DietNotification extends StatefulWidget {
  final BaseAuth auth = Auth();
  final NotificationService notificationService = NotificationService();

  @override
  _DietNotificationState createState() => _DietNotificationState();
}

class _DietNotificationState extends State<DietNotification> {
  static List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  var date = days[DateTime.now().weekday - 1];

  @override
  Widget build(BuildContext context) {
    final UID args = ModalRoute.of(context).settings.arguments;
    return StreamProvider<QuerySnapshot>.value(
      value: widget.notificationService.dietNotificationStream,
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
                    'Eating Plan',
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
          body: DietNotificationBody(
            uid: args.uid,
            auth: widget.auth,
            notificationService: widget.notificationService,
          )),
    );
  }
}

class DietNotificationBody extends StatefulWidget {
  final String uid;
  final BaseAuth auth;
  final NotificationService notificationService;

  DietNotificationBody({this.uid, this.auth, this.notificationService});

  @override
  _DietNotificationBodyState createState() => _DietNotificationBodyState();
}

class _DietNotificationBodyState extends State<DietNotificationBody> {
  final dietForm = new GlobalKey<FormState>();
  final formatTime = DateFormat("HH:mm");
  DateTime breakfast;
  DateTime lunch;
  DateTime dinner;
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
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Eating time reminder',
        'You shoud get your breakfast now',
        Time(breakfast.hour, breakfast.minute),
        platformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Eating time reminder',
        'You shoud get your lunch now',
        Time(lunch.hour, lunch.minute),
        platformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Eating time reminder',
        'You shoud get your dinner now',
        Time(dinner.hour, dinner.minute),
        platformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    if (payload == '/WaterNotification') {
      debugPrint(ModalRoute.of(context).settings.name == null
          ? 'on selected null'
          : 'on selected notnull');
    }
//    debugPrint(ModalRoute.of(context).settings.name ==null? 'on selected null': 'on selected notnull');
  }

  @override
  Widget build(BuildContext context) {
    final dietNotificationData = Provider.of<QuerySnapshot>(context);
    try {
      var dietData = dietNotificationData.documents
          .firstWhere((doc) => doc.documentID == '${widget.uid}')
          .data;
      bool alermToggle = dietData['IsAlermOn'] || false;
      final TextEditingController _breakfastController =
          new TextEditingController(
              text: (dietData['breakfast'] != null)
                  ? dietData['breakfast']
                          .toDate()
                          .toString()
                          .split(' ')[1]
                          .trim()
                          .split(':')[0] +
                      ":" +
                      dietData['breakfast']
                          .toDate()
                          .toString()
                          .split(' ')[1]
                          .trim()
                          .split(':')[1]
                  : '0');
      final TextEditingController _lunchController = new TextEditingController(
          text: (dietData['lunchtime'] != null)
              ? dietData['lunchtime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[0] +
                  ":" +
                  dietData['lunchtime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[1]
              : '0');
      final TextEditingController _dinnerController = new TextEditingController(
          text: (dietData['dinnertime'] != null)
              ? dietData['dinnertime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[0] +
                  ":" +
                  dietData['dinnertime']
                      .toDate()
                      .toString()
                      .split(' ')[1]
                      .trim()
                      .split(':')[1]
              : '0');
      toggleButton() async {
        try {
          await widget.notificationService.dietAlerm(widget.uid, !alermToggle);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Connection problem'),
          ));
        }
        setState(() {
          alermToggle = !alermToggle;
        });
      }

      bool validateAndSave() {
        final form = dietForm.currentState;
        if (form.validate()) {
          form.save();
          return true;
        } else {
          return false;
        }
      }

      void validateAndSubmit() async {
        if (validateAndSave()) {
          try {
            alermToggle == false ? toggleButton() : null;
            // ignore: unrelated_type_equality_checks
            if (breakfast == dietData['breakfast'].toDate() &&
                lunch == dietData['lunchtime'].toDate() &&
                dinner == dietData['dinnertime'].toDate()) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Already Saved details'),
              ));
            } else {
              await widget.notificationService
                  .updateDietTimes(widget.uid, breakfast, lunch, dinner);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Saved changes'),
              ));
            }

            await _showNotification();
          } catch (e) {
            print('Error : $e');
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Check your internet connection'),
            ));
          }
        }
      }

      return Builder(
        builder: (context) => Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/NotificationManager/backgroundDietpalan.png",),
                fit: BoxFit.fill,
              ),),
            child: Padding(
              padding: const EdgeInsets.only(top:8.0,left: 8),
              child: Form(
                key: dietForm,
                onChanged: () {
                  if (alermToggle == true) {
                    validateAndSubmit();
                  }
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width - 125),
                          height: 50,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                (alermToggle == true)
                                    ? 'Diet notification turn on'
                                    : "Diet notification turn off",
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
                            duration: Duration(milliseconds: 400),
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: alermToggle
                                  ? Colors.green[100]
                                  : Colors.red[100],
                            ),
                            child: Stack(
                              children: <Widget>[
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  top: 3.0,
                                  left: alermToggle ? 55.0 : 0.0,
                                  right: alermToggle ? 0.0 : 55.0,
                                  child: Tooltip(
                                    message: alermToggle == false
                                        ? 'first add valide data'
                                        : 'submit form',
                                    child: InkWell(
                                      onTap: () async {
                                        if (alermToggle == false) {
                                          validateAndSubmit();
                                        } else {
                                          await flutterLocalNotificationsPlugin
                                              .cancelAll();
                                          toggleButton();
                                        }
                                      },
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 100),
                                        transitionBuilder: (Widget child,
                                            Animation<double> animation) {
                                          return ScaleTransition(
                                            child: child,
                                            scale: animation,
                                          );
                                        },
                                        child: alermToggle
                                            ? Icon(
                                                Icons.notifications_active,
                                                color: Colors.green,
                                                size: 30,
                                                key: UniqueKey(),
                                              )
                                            : Icon(
                                                Icons.notifications,
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: TextFormField(
                          readOnly: true,
                        onTap: () async {
                          final time = (await showTimePicker(
                              context: context,
                              initialTime: dietData['breakfast'] != null
                                  ? TimeOfDay(
                                      hour: int.parse(dietData['breakfast']
                                          .toDate()
                                          .toString()
                                          .split(' ')[1]
                                          .trim()
                                          .split(':')[0]),
                                      minute: int.parse(dietData['breakfast']
                                          .toDate()
                                          .toString()
                                          .split(' ')[1]
                                          .trim()
                                          .split(':')[1]))
                                  : TimeOfDay.now()));
                          (time != null)
                              ? _breakfastController.text = time
                                      .toString()
                                      .split(':')[0]
                                      .substring(10, 12) +
                                  ":" +
                                  time.toString().split(':')[1].substring(0, 2)
                              : null;
                        },
                        onSaved: (value) => breakfast = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            int.parse(value.split(':')[0]),
                            int.parse(value.split(':')[1])),
                        validator: (value) =>
                            ValidationOfFormDiet.BreakFastValidation(
                                value, _lunchController, _dinnerController),
                        controller: _breakfastController,
                        decoration: InputDecoration(
                            labelText: 'Breakfast',
                            hintText: 'Input breakfast time',
                            prefixIcon: Icon(Icons.free_breakfast),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue))),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          final time = (await showTimePicker(
                              context: context,
                              initialTime: dietData['lunchtime'] != null
                                  ? TimeOfDay(
                                      hour: int.parse(dietData['lunchtime']
                                          .toDate()
                                          .toString()
                                          .split(' ')[1]
                                          .trim()
                                          .split(':')[0]),
                                      minute: int.parse(dietData['lunchtime']
                                          .toDate()
                                          .toString()
                                          .split(' ')[1]
                                          .trim()
                                          .split(':')[1]))
                                  : TimeOfDay.now()));
                          (time != null)
                              ? _lunchController.text = time
                                      .toString()
                                      .split(':')[0]
                                      .substring(10, 12) +
                                  ":" +
                                  time.toString().split(':')[1].substring(0, 2)
                              : null;
                        },
                        onSaved: (value) => lunch = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            int.parse(value.split(':')[0]),
                            int.parse(value.split(':')[1])),
                        validator: (value) =>
                            ValidationOfFormDiet.LunchValidation(
                                value, _breakfastController, _dinnerController),
                        controller: _lunchController,
                        decoration: InputDecoration(
                            labelText: 'Lunch',
                            hintText: 'Input lunch time',
                            prefixIcon: Icon(Icons.fastfood),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue))),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          final time = (await showTimePicker(
                              context: context,
                              initialTime: dietData['dinnertime'] != null
                                  ? TimeOfDay(
                                      hour: int.parse(dietData['dinnertime']
                                          .toDate()
                                          .toString()
                                          .split(' ')[1]
                                          .trim()
                                          .split(':')[0]),
                                      minute: int.parse(dietData['dinnertime']
                                          .toDate()
                                          .toString()
                                          .split(' ')[1]
                                          .trim()
                                          .split(':')[1]))
                                  : TimeOfDay.now()));
                          (time != null)
                              ? _dinnerController.text = time
                                      .toString()
                                      .split(':')[0]
                                      .substring(10, 12) +
                                  ":" +
                                  time.toString().split(':')[1].substring(0, 2)
                              : null;
                        },
                        onSaved: (value) => dinner = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            int.parse(value.split(':')[0]),
                            int.parse(value.split(':')[1])),
                        validator: (value) =>
                            ValidationOfFormDiet.DinnerValidation(
                                value, _breakfastController, _lunchController),
                        controller: _dinnerController,
                        decoration: InputDecoration(
                            labelText: 'Dinner',
                            hintText: 'Input dinner time',
                            prefixIcon: Icon(Icons.local_dining),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } catch (e) {
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
