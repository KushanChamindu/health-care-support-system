import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/User.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();
  Future<void> singOut();
  Future setUserData(String uid, String Username,DateTime Birthday,String bloodGroup);
  Stream<QuerySnapshot> get user_data;
  Future updateAccountDetails(String uid, String Username, String bloodGroup, DateTime Birthday );
}

class Auth implements BaseAuth {

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
    if(user==null){
      return null;
    }else{
      return user.uid;
    }

  }
  Future<void> singOut()async{
    return FirebaseAuth.instance.signOut();
  }
  // ignore: non_constant_identifier_names

  final CollectionReference userData=Firestore.instance.collection('user_data');
  Future setUserData(String uid, String Username,DateTime Birthday,String bloodGroup)async{
    print("in updateUserData function ${uid}");
    await userData.document(uid).setData({
      'Username':Username,
      "Birthday":Birthday,
      'bloodGroup':bloodGroup,
      'CKD': null,
      'Diabetits':null,
      'Breast_canser':null,
      'HeartIssue':null,
    });
  }
  Future updateAccountDetails(String uid, String Username, String bloodGroup, DateTime Birthday ){
    Firestore.instance
        .collection('user_data')
        .document(uid)
        .updateData({
      'Username': Username,
      'bloodGroup': bloodGroup,
      'Birthday': Birthday,
    });
  }

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> get user_data{
    return userData.snapshots();
  }
}