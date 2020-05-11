import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();
  Future<void> singOut();
  Future setUserData(
      String uid, String Username, DateTime Birthday, String bloodGroup);
  Stream<QuerySnapshot> get user_data;
  Future updateAccountDetails(
      String uid, String Username, String bloodGroup, DateTime Birthday);
  Future setUserImageDetails(String uid, String ImageURL);
  Future setCKDPrediction(String uid, double percentage);
  Future setBreastCancerPrediction(String uid, double percentage);
}

class Auth implements BaseAuth {
  final CollectionReference waterNotification =
  Firestore.instance.collection('waterNotification');
  final CollectionReference dietNotification =
  Firestore.instance.collection('dietNotification');
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      return null;
    } else {
      return user.uid;
    }
  }

  Future<void> singOut() async {
    return FirebaseAuth.instance.signOut();
  }
  Future setCKDPrediction(String uid, double percentage)async{
    DateTime date= DateTime.now();
    await userData.document(uid).updateData({
      'CKD':'${percentage.toString()}_${date.toIso8601String()}'
    });
  }
  Future setBreastCancerPrediction(String uid, double percentage)async{
    DateTime date= DateTime.now();
    await userData.document(uid).updateData({
      'Breast_canser':'${percentage.toString()}_${date.toIso8601String()}'
    });
  }
  Future setUserData(
      String uid, String Username, DateTime Birthday, String bloodGroup) async {
    print("in updateUserData function ${uid}");
    await userData.document(uid).setData({
      'Username': Username,
      "Birthday": Birthday,
      'bloodGroup': bloodGroup,
      'CKD': null,
      'Diabetits': null,
      'Breast_canser': null,
      'HeartIssue': null,
      'ProfilePic': null,
    });
    await waterNotification.document(uid).setData({
      'firstday':getAboveSunday(),
      'monday':0,
      'tuesday':0,
      'wednesday':0,
      'thursday':0,
      'friday':0,
      'saturday':0,
      'sunday ':0,
      'endTime':DateTime.now().add(Duration(hours: 2)),
      'startTime':DateTime.now(),
      'isAlermOn':false,
      'goal':1000,
      'isReset':true,
    });
    await dietNotification.document(uid).setData({
      'breakfast':null,
      'lunchtime':null,
      'dinnertime':null,
      'IsAlermOn':false
    });
  }
//  static List days=['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
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

  Future updateAccountDetails(
      String uid, String Username, String bloodGroup, DateTime Birthday) async {
    await Firestore.instance.collection('user_data').document(uid).updateData({
      'Username': Username,
      'bloodGroup': bloodGroup,
      'Birthday': Birthday,
    });
  }

  Future setUserImageDetails(String uid, String ImageURL) async {
    Firestore.instance
        .collection('user_data')
        .document(uid)
        .updateData({'ProfilePic': ImageURL});
  }

  final CollectionReference userData =
      Firestore.instance.collection('user_data');

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> get user_data{
    return userData.snapshots();
  }
}
