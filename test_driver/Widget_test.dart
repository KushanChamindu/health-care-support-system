import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//command for the run that test:  flutter drive --target=test_driver/Widget.dart

void main() {
  //Loading widget essential variables
  final logInEmail = find.byValueKey('loginEmailField');
  final logInPassword = find.byValueKey('loginPasswordField');
  final logInButton = find.byValueKey('logInButton');
  final loadingpage = find.byValueKey('loadingContainer');
  final loadingErrorContainer = find.byValueKey('LoadignErrorContainer');
  final errorBoxOkButton = find.byValueKey('error_box_ok_button');
  final registerSwitchButton = find.text('Create a account');
  final loginSwitchButton = find.text('Have a account? LogIn');
  final registerButton = find.byValueKey('registerButton');
  final homePage = find.byValueKey('HomePage');
  final registerUsernameField = find.byValueKey('registerUsernameField');
  final registerEmailField = find.byValueKey('registerEmailField');
  final registerDateTimeField = find.byValueKey('registerDateTimeField');
  final registerBloodGroupField = find.byValueKey('registerBloodGroupField');
  final registerBloodGroup_dropdown =
      find.byValueKey('registerBloodGroup_dropdown');
  final registerPasswordField = find.byValueKey('registerPasswordField');
  final registerConfirmPasswordField =
      find.byValueKey("registerConfirmPasswordField");
  final login_switch_button = find.byValueKey('login_switch_button');
  final HomePopUpMenueButton = find.byValueKey("HomePopUpMenueButton");
  final SignoutButton = find.byValueKey('SignoutButton');

  //home Page/CKD pages test essential variables
  final CKDCard = find.byValueKey('CKD_Card');
  final CKDdiscriptionButton = find.byValueKey('CKDdiscriptionButton');
  final CKDdiscriptionPage = find.byValueKey('CKDdiscriptionPage');
  final CKDsymptomButton = find.byValueKey('CKDsymptomButton');
  final CKDprecautionButton = find.byValueKey('CKDprecautionButton');
  final CKDprecautionBackButton = find.byValueKey('CKDprecautionBackButton');
  final sampleCKDdirscription = find.byValueKey('sampleCKDdirscription');
  final CKDprecautionPage = find.byValueKey('CKDprecautionPage');
  final sampleCKDsymptom = find.byValueKey('sampleCKDsymptom');
  final CKDsymptomPage = find.byValueKey('CKDsymptomPage');
  final CKDsymptomBackButton = find.byValueKey('CKDsymptomBackButton');
  final webviewBackButton = find.byValueKey('webviewBackButton');
  final webviewInitialWidget = find.byValueKey('webviewInitialWidget');

  //Account test
  final AccountProfilePic = find.byValueKey('AccountProfilePic');
  final gotoAccountButton = find.byValueKey('gotoAccountButton');
  final AccountEditButton = find.byValueKey('AccountEditButton');
  final AccountEditBox = find.byValueKey('AccountEditBox');
  final AccountUsernameEdit = find.byValueKey('AccountUsernameEdit');
  final AccountBirthdayEdit = find.byValueKey('AccountBirthdayEdit');
  final AccountBloodGoupEdit = find.byValueKey('AccountBloodGoupEdit');
  final AccountEditSubmitButton = find.byValueKey('AccountEditSubmitButton');
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
    test('can\'t create account with using email already used', () async {
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
    test('logIn Successfully', () async {
      await driver.tap(login_switch_button);
      await driver.tap(logInEmail);
      await driver.enterText('kushan@kushan.com');
      await driver.tap(logInPassword);
      await driver.enterText('kushan1234');
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(logInButton);
      await driver.waitFor(homePage);
    });
    test('Successfully logout', () async {
      await driver.tap(HomePopUpMenueButton);
      await driver.tap(SignoutButton);
      await driver.waitFor(registerSwitchButton);
      await Future.delayed(Duration(milliseconds: 2000), () {});
    });
  });
  group('home Page/CKD pages test', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('logIn Successfully', () async {
      await driver.tap(logInEmail);
      await driver.enterText('kushan@kushan.com');
      await driver.tap(logInPassword);
      await driver.enterText('kushan1234');
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(logInButton);
      await driver.waitFor(homePage);
      await driver.waitFor(CKDCard);
    });
    test('Goto CKD discrption and CKD discription page UI test', () async {
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
      await driver.waitFor(CKDprecautionPage);
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
  group('Account test', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('go to the account page', () async {
      await driver.tap(HomePopUpMenueButton);
      await driver.tap(gotoAccountButton);
      await driver.waitFor(AccountProfilePic);
    });
    test('account edit', () async {
      await driver.tap(AccountEditButton);
      await driver.waitFor(AccountEditBox);
      await driver.tap(AccountUsernameEdit);
      await driver.enterText("Kushan Nilanga");
      await driver.tap(AccountBirthdayEdit);
      await Future.delayed(Duration(milliseconds: 2000), () {});
      await driver.tap(find.text('25'));
      await driver.tap(find.text('OK'));
      await driver.tap(AccountBloodGoupEdit);
      await driver.tap(find.text('AB+'));
      await driver.tap(AccountEditSubmitButton);
      await Future.delayed(Duration(milliseconds: 2000), () {});
    });
  });
}