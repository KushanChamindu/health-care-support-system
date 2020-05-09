import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/validation/ValidationForm.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockAuthResult extends Mock implements AuthResult {}

class MockFirestore extends Mock implements Firestore{}

class MockAuth implements BaseAuth {
  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    MockAuthResult mockAuthResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return (mockAuthResult != null) ? 'Mockresult came' : 'error happen';
  }

  @override
  Future<String> currentUser()async {
    FirebaseUser mockUser=await _auth.currentUser();
    return (mockUser!=null)?'Mock user came':'error occur';
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    MockAuthResult mockAuthResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return (mockAuthResult != null) ? 'Mockresult came' : 'error happen';
  }

  @override
  Future<String> singOut() async{
    bool issognout= await _auth.signOut() as bool;
    return (issognout==true)?'signOut':'error hapend';
  }

  @override
  Future setUserData(
      String uid, String Username, DateTime Birthday, String bloodGroup){
    return null;
  }
  @override
  Future setUserImageDetails(String uid, String ImageURL) {
    return null;
  }

  @override
  Future updateAccountDetails(
      String uid, String Username, String bloodGroup, DateTime Birthday) {
    return null;
  }

  @override
  Stream<QuerySnapshot> get user_data => null;

  @override
  Future setCKDPrediction(String uid, double percentage) {
    // TODO: implement setCKDPrediction
    return null;
  }

}

MockFirebaseAuth _auth = MockFirebaseAuth();
BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
MockFirestore Mockfirestore= MockFirestore();
final MockAuth authClass = MockAuth();
void main() {

   group('logIn validation test', () {


    test('title', () {
      //setup
      //run
      // verify
    });
    test('Email should not be emplty', () {
      var result = ValidationForm.emailValidate('');
      expect(result, 'Email con\'t be empty');
    });
    test('non-Empty email return null', () {
      var result = ValidationForm.emailValidate('email@email.com');
      expect(result, null);
    });
    test('Password should not be emplty', () {
      var result = ValidationForm.passwordValidate('');
      expect(result, 'Password con\'t be empty');
    });
    test('non-Empty password return null', () {
      var result = ValidationForm.passwordValidate('asdkjasbk');
      expect(result, null);
    });
    test('Non-empty date return null', () {
      var result = ValidationForm.dateValidate(DateTime(0));
      expect(result, null);
    });
    test('non-Empty age shoud more than 10 years', () {
      var result = ValidationForm.dateValidate(DateTime.now());
      expect(result, 'Your age should be more than 10 years');
    });
    test('Date should not emplty', () {
      var result = ValidationForm.dateValidate(null);
      expect(result, 'Birthday is required');
    });
    test('Blood group should not be emplty', () {
      var result = ValidationForm.bloodValidate('');
      expect(result, 'Blood group con\'t be empty');
    });
    test('Blood group should correct as define', () {
      var result = ValidationForm.bloodValidate('Z+');
      expect(result,
          'Blood group should be one of thses: O−	O+	A−	A+	B−	B+	AB−	AB+');
    });
    test('Correct blodd goup rreturn null', () {
      var result = ValidationForm.bloodValidate('A+');
      expect(result, null);
    });
    test('Confirm password should not be empty', () {
      final TextEditingController _passwordController =
          TextEditingController(text: 'kushan');
      var result = ValidationForm.confirmPassValidate('', _passwordController);
      expect(result, 'Password con\'t be empty');
    });
    test(
        'Confirm password should same as passsword text if as define return null',
        () {
      final TextEditingController _passwordController =
          TextEditingController(text: 'kushan');
      var result =
          ValidationForm.confirmPassValidate('kushan', _passwordController);
      expect(result, null);
    });
    test(
        'Confirm password should same as password if not match return "Not match password"',
        () async {
      final TextEditingController _passwordController =
          TextEditingController(text: 'kushan');
      var result =
          ValidationForm.confirmPassValidate('kshan', _passwordController);
      expect(result, 'Not Match with password');
    });
  });
   group('test Firbase methodes', () {
    when(_auth.signInWithEmailAndPassword(email: "email", password: "password"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });
    when(_auth.signInWithEmailAndPassword(email: "mail", password: "pass"))
        .thenThrow(() {
      return null;
    });
    when(_auth.createUserWithEmailAndPassword(
            email: "email", password: "password"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });
    when(_auth.createUserWithEmailAndPassword(email: "mail", password: "pass"))
        .thenThrow(() {
      return null;
    });
    when(_auth.currentUser()).thenAnswer((_)async{
      _user.add(MockFirebaseUser());
      return MockFirebaseUser();
    });
    when(_auth.signOut()).thenAnswer((_)async{
      return true;
    });
    test('signIn successfully', () async {
      String signIn =
          await authClass.signInWithEmailAndPassword('email', 'password');
      expect(signIn, 'Mockresult came');
    });
    test('signIn fails test', () async {
      String signIn =
          await authClass.signInWithEmailAndPassword('mail', 'password');
      expect(signIn, 'error happen');
    });
    test('Create user successfully', () async {
      String signIn =
          await authClass.createUserWithEmailAndPassword('email', 'password');
      expect(signIn, 'Mockresult came');
    });
    test('signIn fails test', () async {
      String signIn =
          await authClass.createUserWithEmailAndPassword('mail', 'password');
      expect(signIn, 'error happen');
    });
    test('current user test', ()async{
      String currentUser= await authClass.currentUser();
      expect(currentUser, 'Mock user came');
    });
    test("sign Out result", ()async{
      String issignout =await authClass.singOut();
      expect(issignout, 'signOut');
    });
  });
}
//TODO: do some test unit,widget and driver also