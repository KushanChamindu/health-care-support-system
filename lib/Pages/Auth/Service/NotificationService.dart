import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService{
  final CollectionReference waterNotification =
  Firestore.instance.collection('waterNotification');
  DateTime getAboveSunday(){
    var today = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
    print(today.weekday);
    for(var i=0; i<7;i++){
      today=today.add(Duration(days: 1));
      if(today.weekday==7){
        return today;
      }
    }
    return null;
  }

  Future<void> updateWaterTimer(String uid, DateTime startTime,DateTime finishedTime,int goal)async{
    await waterNotification.document(uid).updateData({
      'firstday':getAboveSunday(),
      'startTime':startTime,
      'endTime':finishedTime,
      'goal':goal
    });
  }
  Stream<QuerySnapshot> get waterNotificationData{
    return waterNotification.snapshots();
  }
  Future<void> updateIsAlarm (String uid, bool isAlarmOn)async{
    await waterNotification.document(uid).updateData({
      'isAlermOn': isAlarmOn
    });
  }
  Future<void> updateDrinkWater(String uid,int drinkAMount,int drunkAmount)async{
//      List<int> days=[];
      List<String> dayNames = [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ];
      int nowDay= DateTime.now().weekday-1;
      for(var i=0;i<7;i++){
        if(i==nowDay){
          await waterNotification.document(uid).updateData({
          dayNames[i]:drinkAMount+drunkAmount
          });
        }
      }

  }
  Future<void> resetData(String uid) async{
    print('reset');
    await waterNotification.document(uid).updateData({
      'firstday':getAboveSunday(),
      'isReset':false,
      'monday':0,
      'tuesday':0,
      'wednesday':0,
      'thursday':0,
      'friday':0,
      'saturday':0,
      'sunday ':0,
    });
  }
  Future<void> setResetVariable(String uid)async{
    await waterNotification.document(uid).updateData({
      'isReset':true,
    });
  }
}