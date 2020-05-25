import 'package:flutter_driver/flutter_driver.dart';
import 'package:intl/intl.dart';
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
  final AccountBackButton=find.byValueKey('AccountBackButton');
  final CKDDiscriptionBackButton=find.byValueKey('CKDDiscriptionBackButton');

  //Breast cancer widget test
  final BC_Card=find.byValueKey('BC_Card');
  final BCdiscriptionButton=find.byValueKey('BCdiscriptionButton');
  final BCdiscriptionPage=find.byValueKey('BCdiscriptionPage');
  final BCSymptomsButton=find.byValueKey('BCSymptomsButton');
  final BCSolutionButton=find.byValueKey('BCSolutionButton');
  final BCMoreButton=find.byValueKey('BCMoreButton');
  final BCSymptomSampleEarly=find.byValueKey('BCSymptomSampleEarly');
  final BCSymptomSampleInvasive=find.byValueKey('BCSymptomSampleInvasive');
  final BCSymptomBackButton=find.byValueKey('BCSymptomBackButton');
  final BCSolutionBackButton=find.byValueKey('BCSolutionBackButton');
  final BCSolutionPage=find.byValueKey('BCSolutionPage');
  final BCMoreBackButton=find.byValueKey('BCMoreBackButton');
  final BCMoreSample=find.byValueKey('BCMoreSample');
  final BCdiscriptionBackButton=find.byValueKey('BCdiscriptionBackButton');

  //Heart issue widget test
  final HTD_Card=find.byValueKey('HTD_Card');
  final HTDdiscriptionButton=find.byValueKey('HTDdiscriptionButton');
  final HTDdiscriptionPage=find.byValueKey('HTDdiscriptionPage');
  final HTDSpeedDial=find.byTooltip('HTDSpeedDial');
  final HTDSymptomsbutton=find.byValueKey('HTDSymptomsbutton');
  final HTDPrecautionsbutton=find.byValueKey('HTDPrecautionsbutton');
  final HTDMorebutton=find.byValueKey('HTDMorebutton');
  final HTD_symptompage=find.byValueKey('HTD_symptompage');
  final HTDSymptomsSample=find.text('Symptoms of heart disease in your blood vessels (atherosclerotic disease)');
  final HTDBackbutton=find.byValueKey('HTDBackbutton');
  final HTDPrecuationBackButton=find.byValueKey('HTDPrecuationBackButton');
  final HTDMoreBackButton=find.byValueKey('HTDMoreBackButton');
  final HTDPrecautionsSample=find.text("Don't smoke or use tobacco");
  final HTD_precautionpage=find.byValueKey('HTD_precautionpage');
  final HTD_Morepage=find.byValueKey('HTD_Morepage');
  final HTDMoreSample=find.text('How the heart functions?');

  //Water notification test
  final waterNotificationCard=find.byValueKey('waterNotificationCard');
  final waterNotificationPage=find.byValueKey('waterNotificationPage');
  final waterNotificationDrinkPageButton=find.byValueKey('waterNotificationDrinkPageButton');
  final waterNotificationChartPageButton=find.byValueKey('waterNotificationChartPageButton');
  final waterNotificationBellButton=find.byValueKey('waterNotificationBellButton');
  final waterNotificationStartTime=find.byValueKey('waterNotificationStartTime');
  final waterNotificationEndTime=find.byValueKey('waterNotificationEndTime');
  final waterNotificationGoal=find.byValueKey('waterNotificationGoal');
  final waterNotificationDrinkButton=find.byValueKey('waterNotificationDrinkButton');
  final waterNotificationChart=find.byValueKey('waterNotificationChart');
//  group('Loading widget', () {
//    isPresent(SerializableFinder byValueKey, FlutterDriver driver,
//        {Duration timeout = const Duration(seconds: 3)}) async {
//      try {
//        await driver.waitFor(byValueKey, timeout: timeout);
//        return true;
//      } catch (exception) {
//        return false;
//      }
//    }
//
//    FlutterDriver driver;
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//    });
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//    test('Log in with wrong password', () async {
//      await driver.tap(logInEmail);
//      await driver.enterText('kushan@kushan.com');
//      await driver.tap(logInPassword);
//      await driver.enterText('kushan');
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(logInButton);
//      await driver.waitFor(loadingpage);
//      final isExist = await isPresent(loadingErrorContainer, driver);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      expect(isExist, true);
//      await driver.tap(errorBoxOkButton); // go to the loading page
//    });
//    test('Log in with wrong email', () async {
//      await driver.tap(logInEmail);
//      await driver.enterText('kushan@.com');
//      await driver.tap(logInPassword);
//      await driver.enterText('kushan1234');
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(logInButton);
//      await driver.waitFor(loadingpage);
//      final isExist = await isPresent(loadingErrorContainer, driver);
//      expect(isExist, true);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(errorBoxOkButton); // go to the loading page
//    });
//    test('Log in with empty email or password', () async {
//      await driver.tap(logInEmail);
//      await driver.enterText('');
//      await driver.tap(logInPassword);
//      await driver.enterText('');
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(logInButton);
////      await driver.waitFor(loadingpage);
//      await driver.waitFor(find.text('Password con\'t be empty'));
//      await driver.waitFor(find.text('Email con\'t be empty'));
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//    });
//    test('switch to register', () async {
//      await driver.tap(registerSwitchButton);
//      await driver.waitFor(loginSwitchButton);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//    });
//    test('switch to login', () async {
//      await driver.tap(loginSwitchButton);
//      await driver.waitFor(registerSwitchButton);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//    });
//    test('can\'t create account with using email already used', () async {
//      await driver.tap(registerSwitchButton);
//      await driver.tap(registerUsernameField);
//      await driver.enterText('kushan');
//      await driver.tap(registerEmailField);
//      await driver.enterText('kushan@kushan.com');
//      await driver.tap(registerDateTimeField);
//      await driver.tap(find.text('2020'));
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.scroll(
//          find.text('2021'), 0, 800, Duration(milliseconds: 500));
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(find.text('2009'));
//      await driver.tap(find.text('OK'));
//      await driver.tap(registerBloodGroupField);
//      await driver.tap(registerBloodGroup_dropdown);
//      await driver.tap(find.text('AB+'));
//      await driver.tap(registerPasswordField);
//      await driver.enterText('kushan1234');
//      await driver.tap(registerConfirmPasswordField);
//      await driver.enterText('kushan1234');
//      await driver.tap(registerButton);
//      await driver.waitFor(loadingpage);
//      final isExist = await isPresent(loadingErrorContainer, driver);
//      expect(isExist, true);
//      await driver.tap(errorBoxOkButton);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//    });
//    test('logIn Successfully', () async {
//      await driver.tap(login_switch_button);
//      await driver.tap(logInEmail);
//      await driver.enterText('kushan@kushan.com');
//      await driver.tap(logInPassword);
//      await driver.enterText('kushan1234');
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(logInButton);
//      await driver.waitFor(homePage);
//    });
//    test('Successfully logout', () async {
//      await driver.tap(HomePopUpMenueButton);
//      await driver.tap(SignoutButton);
//      await driver.waitFor(registerSwitchButton);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//    });
//  });
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
//    test('Goto CKD discrption and CKD discription page UI test', () async {
//      await driver.tap(CKDCard);
//      await driver.waitFor(CKDdiscriptionButton);
//      await driver.tap(CKDdiscriptionButton);
//      print('kushan');
//      await driver.waitFor(CKDdiscriptionPage);
//      print('kushan1');
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(sampleCKDdirscription);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(sampleCKDdirscription);
//    });
//    test('test UI of CKD symptopm page', ()async{
//      await driver.tap(CKDsymptomButton);
//      await driver.waitFor(CKDsymptomPage);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.scroll(
//          sampleCKDsymptom, 0, -800, Duration(milliseconds: 500));
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(CKDsymptomBackButton);
//      await driver.waitFor(CKDdiscriptionPage);
//    });
//    test('test UI of CKD precaution', ()async{
//      await driver.tap(CKDprecautionButton);
//      await driver.waitFor(CKDprecautionPage);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(CKDprecautionBackButton);
//      await driver.waitFor(CKDdiscriptionPage);
//    });
//    test('test web view', ()async{
//      await driver.scroll(
//          sampleCKDdirscription, 0, -880, Duration(milliseconds: 500));
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(find.text('Open More Info'));
//      await driver.waitFor(webviewInitialWidget);
//      await Future.delayed(Duration(milliseconds: 10000), () {});
//      await driver.tap(webviewBackButton);
//    });
  });
//  group('Account test', () {
//    FlutterDriver driver;
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//    });
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//    test('go to the account page', () async {
//      await driver.tap(HomePopUpMenueButton);
//      await driver.tap(gotoAccountButton);
//      await driver.waitFor(AccountProfilePic);
//    });
//    test('account edit', () async {
//      await driver.tap(AccountEditButton);
//      await driver.waitFor(AccountEditBox);
//      await driver.tap(AccountUsernameEdit);
//      await driver.enterText("Kushan Nilanga");
//      await driver.tap(AccountBirthdayEdit);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(find.text('25'));
//      await driver.tap(find.text('OK'));
//      await driver.tap(AccountBloodGoupEdit);
//      await driver.tap(find.text('AB+'));
//      await driver.tap(AccountEditSubmitButton);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(AccountBackButton);
//      await driver.tap(CKDDiscriptionBackButton);
//      await driver.waitFor(homePage);
//    });
//  });
//  group('braest cancer UI test', () {
//    FlutterDriver driver;
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//    });
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//    test('breast cancer description test', () async {
//      await driver.scroll(
//          CKDCard, 0, -800, Duration(milliseconds: 500));
//      await driver.tap(BC_Card);
//      await driver.waitFor(BCdiscriptionButton);
//      await driver.tap(BCdiscriptionButton);
//      await driver.waitFor(BCdiscriptionPage);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//    });
//    test('breast cancer symptom', () async {
//      await driver.scroll(
//          find.text('What is breast cancer...?'), 0, -800,
//          Duration(milliseconds: 500));
//      await driver.tap(BCSymptomsButton);
//      await driver.waitFor(BCSymptomSampleEarly);
//      await driver.tap(BCSymptomSampleInvasive);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(BCSymptomSampleEarly);
//      await driver.tap(BCSymptomBackButton);
//      await driver.waitFor(BCdiscriptionPage);
//    });
//    test('breast cancer solution', () async {
//      await driver.tap(BCSolutionButton);
//      await driver.waitFor(BCSolutionPage);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(BCSolutionBackButton);
//      await driver.waitFor(BCdiscriptionPage);
//    });
//    test('breast cancer more pagee', () async {
//      await driver.tap(BCMoreButton);
//      await driver.waitFor(BCMoreSample);
//      await driver.tap(find.text('Ductal carcinoma symptoms'));
//      await driver.scroll(
//          BCMoreSample, 0, -800, Duration(milliseconds: 500));
//      await driver.tap(BCMoreBackButton);
//      await driver.waitFor(BCdiscriptionPage);
//      await driver.tap(BCdiscriptionBackButton);
//      await driver.scroll(
//          BC_Card, 0, 800, Duration(milliseconds: 500));
//    });
//  });
//  group('HTD UI test', (){
//    FlutterDriver driver;
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//    });
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//    test('HTD description UI test', ()async{
//      await driver.scroll(
//          CKDCard, 0, -800, Duration(milliseconds: 500));
//      await driver.tap(HTD_Card);
//      await driver.scroll(
//          HTD_Card, 0, -100, Duration(milliseconds: 500));
//      await driver.tap(HTDdiscriptionButton);
//      await driver.waitFor(HTDdiscriptionPage);
//      await driver.waitFor(HTDSpeedDial);
//    });
//
//    test('HTD symptom UI test', ()async{
//      await driver.tap(HTDSpeedDial);
//      await driver.waitFor(HTDSymptomsbutton);
//      await driver.tap(HTDSymptomsbutton);
//      await driver.waitFor(HTD_symptompage);
//      await driver.tap(HTDSymptomsSample);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(HTDBackbutton);
//      await driver.waitFor(HTDdiscriptionPage);
//    });
//    test('HTD precaution UI test', ()async{
//      await driver.tap(HTDPrecautionsbutton);
//      await driver.waitFor(HTD_precautionpage);
//      await driver.tap(HTDPrecautionsSample);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(HTDPrecuationBackButton);
//      await driver.waitFor(HTD_precautionpage);
//      await driver.tap(HTDBackbutton);
//      await driver.waitFor(HTDdiscriptionPage);
//    });
//    test('HTD More-info UI test', ()async{
//      await driver.tap(HTDMorebutton);
//      await driver.waitFor(HTD_Morepage);
//      await driver.tap(HTDMoreSample);
//      await Future.delayed(Duration(milliseconds: 2000), () {});
//      await driver.tap(HTDMoreBackButton);
//      await driver.waitFor(HTD_Morepage);
//      await driver.tap(HTDBackbutton);
//      await driver.waitFor(HTDdiscriptionPage);
//      await driver.tap(HTDBackbutton);
//      await driver.scroll(
//          CKDCard, 0, 8800, Duration(milliseconds: 500));
//    });
//  });
    group('water notification page ui validation', (){
      FlutterDriver driver;
      setUpAll(() async {
        driver = await FlutterDriver.connect();
      });
      tearDownAll(() async {
        if (driver != null) {
          driver.close();
        }
      });
      test('Go to water notofocaition page', ()async{
        await driver.tap(waterNotificationCard);
        await driver.waitFor(waterNotificationBellButton);
      });
      test('Good path of alarm creation', ()async{
        await driver.tap(waterNotificationStartTime);
        DateTime time=DateTime.now();
        String formattedDate1 = DateFormat('jm').format(time).split(' ')[0];
        print(formattedDate1);
        print(formattedDate1.split(':')[0]);
        print(formattedDate1.split(':')[1]);
        await driver.tap(find.text('1'));
        await driver.tap(find.text('10'));
        await Future.delayed(Duration(milliseconds: 2000), () {});
        await driver.tap(find.text('OK'));
      });
    });
}