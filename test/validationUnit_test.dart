import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/validation/ValidationForm_userForms.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';
import 'package:healthcaresupportsystem/Pages/validation/Validation_of_Form_waternotification.dart';
import 'package:healthcaresupportsystem/Pages/validation/Validation_of_Form_dietNotification.dart';

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

  @override
  Future setBreastCancerPrediction(String uid, double percentage) {
    // TODO: implement setBreastCancerPrediction
    return null;
  }

  @override
  Future sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    return null;
  }

}

MockFirebaseAuth _auth = MockFirebaseAuth();
BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
MockFirestore Mockfirestore= MockFirestore();
final MockAuth authClass = MockAuth();
final TextEditingController _startContoller=TextEditingController();
final TextEditingController _endController=TextEditingController();
final TextEditingController _breakfastController=TextEditingController(text: "06:00");
final TextEditingController _lunchController=TextEditingController(text:"12:00");
final TextEditingController _dinnerController=TextEditingController(text:"20:00");
void main() {

   group('logIn validation test', () {


    test('title', () {
      //setup
      //run
      // verify
    });
    test('Email should not be emplty', () {
      var result = ValidationForm_userForms.emailValidate('');
      expect(result, 'Email con\'t be empty');
    });
    test('non-Empty email return null', () {
      var result = ValidationForm_userForms.emailValidate('email@email.com');
      expect(result, null);
    });
    test('Password should not be emplty', () {
      var result = ValidationForm_userForms.passwordValidate('');
      expect(result, 'Password con\'t be empty');
    });
    test('non-Empty password return null', () {
      var result = ValidationForm_userForms.passwordValidate('asdkjasbk');
      expect(result, null);
    });
    test('Non-empty date return null', () {
      var result = ValidationForm_userForms.dateValidate(DateTime(0));
      expect(result, null);
    });
    test('non-Empty age shoud more than 10 years', () {
      var result = ValidationForm_userForms.dateValidate(DateTime.now());
      expect(result, 'Your age should be more than 10 years');
    });
    test('Date should not emplty', () {
      var result = ValidationForm_userForms.dateValidate(null);
      expect(result, 'Birthday is required');
    });
    test('Blood group should not be emplty', () {
      var result = ValidationForm_userForms.bloodValidate('');
      expect(result, 'Blood group con\'t be empty');
    });
    test('Blood group should correct as define', () {
      var result = ValidationForm_userForms.bloodValidate('Z+');
      expect(result,
          'Blood group should be one of thses: O−	O+	A−	A+	B−	B+	AB−	AB+');
    });
    test('Correct blodd goup rreturn null', () {
      var result = ValidationForm_userForms.bloodValidate('A+');
      expect(result, null);
    });
    test('Confirm password should not be empty', () {
      final TextEditingController _passwordController =
          TextEditingController(text: 'kushan');
      var result = ValidationForm_userForms.confirmPassValidate('', _passwordController);
      expect(result, 'Password con\'t be empty');
    });
    test(
        'Confirm password should same as passsword text if as define return null',
        () {
      final TextEditingController _passwordController =
          TextEditingController(text: 'kushan');
      var result =
          ValidationForm_userForms.confirmPassValidate('kushan', _passwordController);
      expect(result, null);
    });
    test(
        'Confirm password should same as password if not match return "Not match password"',
        () async {
      final TextEditingController _passwordController =
          TextEditingController(text: 'kushan');
      var result =
          ValidationForm_userForms.confirmPassValidate('kshan', _passwordController);
      expect(result, 'Not Match with password');
    });

  });
   group('water notiification validation test',(){
     test('start time should not be null', (){
       var result = ValidationOfFormWater.StartimeValidation(null, _endController);
       expect(result, 'Time is required');
     });
     test('start time should not be before end time', (){
       _endController.text='20:00';
       var result = ValidationOfFormWater.StartimeValidation('20:20', _endController);
       expect(result, 'Start time should be before end time');
     });
     test('start time should not be after now time', (){
       _endController.text='20:00';
       var result = ValidationOfFormWater.StartimeValidation('13:20', _endController);
       expect(result, 'Time should after now time');
     });
     test('End time should not be null', (){
       var result = ValidationOfFormWater.EndtimeValidation(null,_startContoller);
       expect(result, 'Time is required');
     });
     test('End time should not be after end time', (){
       _startContoller.text='20:20';
       var result = ValidationOfFormWater.EndtimeValidation('20:00', _startContoller);
       expect(result, 'End time should be after start time');
     });
     test('End time should not be after now time', (){
       _startContoller.text='16:00';
       var result = ValidationOfFormWater.EndtimeValidation('17:20', _startContoller);
       expect(result, 'Time should after now time');
     });
     test("water goal should be number", (){
       var result=ValidationOfFormWater.waterGoalValidation('jashd');
       expect(result, 'Goal should be a number');
     });
     test("drink amount  should be number", (){
       var result=ValidationOfFormWater.drinkWaterValidation('jashd');
       expect(result, 'Drink amount should be a number');
     });

   });
   group('diet notification validation', (){
     test('breakfast time should not be null or 0',(){
       var result1=ValidationOfFormDiet.BreakFastValidation(null, _lunchController, _dinnerController);
       var result2=ValidationOfFormDiet.BreakFastValidation("0", _lunchController, _dinnerController);
       expect(result1, 'Time is required');
       expect(result2, 'Time is required');
     });
     test('breakfast time should before lunch and dinner time null or 0',(){
       var result1=ValidationOfFormDiet.BreakFastValidation("13:00", _lunchController, _dinnerController);
       var result2=ValidationOfFormDiet.BreakFastValidation("21:00", _lunchController, _dinnerController);
       expect(result1, 'Breakfast time should be before lunch time');
       expect(result2, 'Breakfast time should be before lunch time');
     });
     test('lunch time should not be null or 0',(){
       var result1=ValidationOfFormDiet.LunchValidation(null, _breakfastController, _dinnerController);
       var result2=ValidationOfFormDiet.LunchValidation("0", _breakfastController, _dinnerController);
       expect(result1, 'Time is required');
       expect(result2, 'Time is required');
     });
     test('Lunch time should before dinner and after breakfast time null or 0',(){
       var result1=ValidationOfFormDiet.LunchValidation("21:00", _breakfastController, _dinnerController);
       var result2=ValidationOfFormDiet.LunchValidation("05:00", _breakfastController, _dinnerController);
       expect(result1, 'Lunch time time should be before dinner time');
       expect(result2, 'Lunch time time should be after breakfast time');
     });
     test('Dinner time should not be null or 0',(){
       var result1=ValidationOfFormDiet.DinnerValidation(null, _breakfastController, _lunchController);
       var result2=ValidationOfFormDiet.DinnerValidation("0", _breakfastController, _lunchController);
       expect(result1, 'Time is required');
       expect(result2, 'Time is required');
     });
     test('Dinner time should after lunch and breakfast time null or 0',(){
       var result1=ValidationOfFormDiet.DinnerValidation("05:00", _breakfastController, _dinnerController);
       var result2=ValidationOfFormDiet.DinnerValidation("10:10", _breakfastController, _dinnerController);
       expect(result1, 'Dinner time should be after breakfast time');
       expect(result2, 'Dinner time should be after lunch time');
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