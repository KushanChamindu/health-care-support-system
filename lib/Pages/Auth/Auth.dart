import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();
  Future<void> singOut();
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
}
