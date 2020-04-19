import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Loading widget', () {
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
    var registerPasswordField = find.byValueKey('registerPasswordField');
    var registerConfirmPasswordField =find.byValueKey("registerConfirmPasswordField");
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
      await driver.enterText('A−');
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
    });
  });
}
