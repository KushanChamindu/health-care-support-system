import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthcaresupportsystem/Pages/validation/ValidationForm.dart';

void main() {
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
    expect(result, 'Blood group should be one of thses: O−	O+	A−	A+	B−	B+	AB−	AB+');
  });
  test('Correct blodd goup rreturn null', () {
    var result = ValidationForm.bloodValidate('A+');
    expect(result, null);
  });
  test('Confirm password should not be empty', (){
    final TextEditingController _passwordController = TextEditingController(text: 'kushan');
    var result= ValidationForm.confirmPassValidate('',_passwordController );
    expect(result, 'Password con\'t be empty');
  });
  test('Confirm password should same as passsword text if as define return null', (){
    final TextEditingController _passwordController = TextEditingController(text: 'kushan');
    var result= ValidationForm.confirmPassValidate('kushan',_passwordController );
    expect(result, null);
  });
  test('Confirm password should same as password if not match return "Not match password"', (){
    final TextEditingController _passwordController = TextEditingController(text: 'kushan');
    var result= ValidationForm.confirmPassValidate('kshan',_passwordController );
    expect(result, 'Not Match with password');
  });
}
