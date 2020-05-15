import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//command for the run that test:  flutter drive --target=test_driver/Widget.dart

void main() {
  group('Loading widget', (){
    isPresent(SerializableFinder byValueKey, FlutterDriver driver,
        {Duration timeout = const Duration(seconds: 3)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }
    var logInEmail = find.byValueKey('loginEmailField');
    var logInPassword = find.byValueKey('loginPasswordField');
    var logInButton = find.byValueKey('logInButton');
    var loadingpage = find.byValueKey('loadingContainer');
    var loadingErrorContainer = find.byValueKey('LoadignErrorContainer');
    var errorBoxOkButton = find.byValueKey('error_box_ok_button');
    var registerSwitchButton = find.text('Create a account');
    var loginSwitchButton = find.text('Have a account? LogIn');
    var registerButton = find.byValueKey('registerButton');
    var homePage= find.byValueKey('HomePage');
    var registerUsernameField = find.byValueKey('registerUsernameField');
    var registerEmailField = find.byValueKey('registerEmailField');
    var registerDateTimeField = find.byValueKey('registerDateTimeField');
    var registerBloodGroupField = find.byValueKey('registerBloodGroupField');
    var registerBloodGroup_dropdown=find.byValueKey('registerBloodGroup_dropdown');
    var registerPasswordField = find.byValueKey('registerPasswordField');
    var registerConfirmPasswordField =find.byValueKey("registerConfirmPasswordField");
    var login_switch_button=find.byValueKey('login_switch_button');
    var homePopUpMenueButton= find.byValueKey("HomePopUpMenueButton");
    var homeSignoutButton=find.byValueKey('homeSignoutButton');
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('Log in with wrong password', () async {
      await driver.tap(logInEmail);
      await driver.enterText('kushan@kushan.com');
      await driver.tap(logInPassword);
      await driver.enterText('kushan');
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(logInButton);
      await driver.waitFor(loadingpage);
      final isExist = await isPresent(loadingErrorContainer, driver);
      await Future.delayed(Duration(milliseconds: 2000), () {});
      expect(isExist, true);
      await driver.tap(errorBoxOkButton); // go to the loading page
    });
    test('Log in with wrong email', () async {
      await driver.tap(logInEmail);
      await driver.enterText('kushan@.com');
      await driver.tap(logInPassword);
      await driver.enterText('kushan1234');
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(logInButton);
      await driver.waitFor(loadingpage);
      final isExist = await isPresent(loadingErrorContainer, driver);
      expect(isExist, true);
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(errorBoxOkButton); // go to the loading page
    });
    test('Log in with empty email or password', () async {
      await driver.tap(logInEmail);
      await driver.enterText('');
      await driver.tap(logInPassword);
      await driver.enterText('');
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(logInButton);
//      await driver.waitFor(loadingpage);
      await driver.waitFor(find.text('Password con\'t be empty'));
      await driver.waitFor(find.text('Email con\'t be empty'));
      await Future.delayed(Duration(milliseconds: 2000), () {});
    });
    test('switch to register', () async {
      await driver.tap(registerSwitchButton);
      await driver.waitFor(loginSwitchButton);
      await Future.delayed(Duration(milliseconds: 2000), () {});
    });
    test('switch to login', () async {
      await driver.tap(loginSwitchButton);
      await driver.waitFor(registerSwitchButton);
      await Future.delayed(Duration(milliseconds: 2000), () {});
    });
    test('can\'t create account with using same emial', () async {
      await driver.tap(registerSwitchButton);
      await driver.tap(registerUsernameField);
      await driver.enterText('kushan');
      await driver.tap(registerEmailField);
      await driver.enterText('kushan@kushan.com');
      await driver.tap(registerDateTimeField);
      await driver.tap(find.text('2020'));
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.scroll(
          find.text('2021'), 0, 800, Duration(milliseconds: 500));
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(find.text('2009'));
      await driver.tap(find.text('OK'));
      await driver.tap(registerBloodGroupField);
      await driver.tap(registerBloodGroup_dropdown);
      await driver.tap(find.text('AB+'));
      await driver.tap(registerPasswordField);
      await driver.enterText('kushan1234');
      await driver.tap(registerConfirmPasswordField);
      await driver.enterText('kushan1234');
      await driver.tap(registerButton);
      await driver.waitFor(loadingpage);
      final isExist = await isPresent(loadingErrorContainer, driver);
      expect(isExist, true);
      await driver.tap(errorBoxOkButton);
      await Future.delayed(Duration(milliseconds: 2000), () {});
    });
    test('logIn Successfully', ()async{
      await driver.tap(login_switch_button);
      await driver.tap(logInEmail);
      await driver.enterText('kushan@kushan.com');
      await driver.tap(logInPassword);
      await driver.enterText('kushan1234');
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(logInButton);
      await driver.waitFor(homePage);
    });
    test('Successfully logout', ()async{
        await driver.tap(homePopUpMenueButton);
        await driver.tap(homeSignoutButton);
        await driver.waitFor(registerSwitchButton);
        await Future.delayed(Duration(milliseconds: 2000), () {});
    });
  });
  group('home Page test',(){
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    var logInEmail = find.byValueKey('loginEmailField');
    var logInPassword = find.byValueKey('loginPasswordField');
    var logInButton = find.byValueKey('logInButton');
    var homePage= find.byValueKey('HomePage');
    var CKDCard=find.byValueKey('CKD_Card');
    var CKDdiscriptionButton=find.byValueKey('CKDdiscriptionButton');
    var CKDdiscriptionPage=find.byValueKey('CKDdiscriptionPage');
    var CKDsymptomButton=find.byValueKey('CKDsymptomButton');
    var CKDprecautionButton=find.byValueKey('CKDprecautionButton');
    var CKDprecautionBackButton=find.byValueKey('CKDprecautionBackButton');
    var sampleCKDdirscription=find.byValueKey('sampleCKDdirscription');
    var sampleCKDprecaution=find.byValueKey('sampleCKDprecaution');
    var sampleCKDsymptom=find.byValueKey('sampleCKDsymptom');
    var CKDsymptomPage=find.byValueKey('CKDsymptomPage');
    var CKDsymptomBackButton=find.byValueKey('CKDsymptomBackButton');
    var webviewBackButton=find.byValueKey('webviewBackButton');
    var webviewInitialWidget=find.byValueKey('webviewInitialWidget');
    test('logIn Successfully', ()async{
      await driver.tap(logInEmail);
      await driver.enterText('kushan@kushan.com');
      await driver.tap(logInPassword);
      await driver.enterText('kushan1234');
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(logInButton);
      await driver.waitFor(homePage);
      await driver.waitFor(CKDCard);
    });
    test('Goto CKD discrption and CKD discription page UI test', ()async{
      await driver.tap(CKDCard);
      await driver.waitFor(CKDdiscriptionButton);
      await driver.tap(CKDdiscriptionButton);
      await driver.waitFor(CKDdiscriptionPage);
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(sampleCKDdirscription);
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(sampleCKDdirscription);
    });
    test('test UI of CKD symptopm page', ()async{
      await driver.tap(CKDsymptomButton);
      await driver.waitFor(CKDsymptomPage);
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.scroll(
          sampleCKDsymptom, 0, -800, Duration(milliseconds: 500));
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(CKDsymptomBackButton);
      await driver.waitFor(CKDdiscriptionPage);
    });
    test('test UI of CKD precaution', ()async{
      await driver.tap(CKDprecautionButton);
      await driver.waitFor(sampleCKDprecaution);
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(CKDprecautionBackButton);
      await driver.waitFor(CKDdiscriptionPage);
    });
    test('test web view', ()async{
      await driver.scroll(
          sampleCKDdirscription, 0, -880, Duration(milliseconds: 500));
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(find.text('Open More Info'));
      await driver.waitFor(webviewInitialWidget);
      await Future.delayed(Duration(milliseconds: 10000), () {});
      await driver.tap(webviewBackButton);
    });
  });
  group('Account validation', (){

  });
}
