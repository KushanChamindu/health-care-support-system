import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService{
  final CollectionReference waterNotification =
  Firestore.instance.collection('waterNotification');
  DateTime getAboveSunday(){
    var today = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
//    var date= days[(today.weekday)];
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
}