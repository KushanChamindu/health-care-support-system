import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/HTD_card/HTD_dart.dart';
import 'package:healthcaresupportsystem/Pages/Account.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Onboarding_screen/OnboardingScreen.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/CKD_precautions.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/CKD_symptom.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/CKD_moreInfo.dart';
import 'package:healthcaresupportsystem/Pages/HTD/HTD_Home.dart';
import 'package:healthcaresupportsystem/Pages/Home.dart';
import 'package:healthcaresupportsystem/Pages/breast_cancer/bc_more.dart';
import 'package:healthcaresupportsystem/Pages/breast_cancer/breast_solutions.dart';
import 'package:healthcaresupportsystem/Pages/breast_cancer/breast_symptoms.dart';
import 'package:healthcaresupportsystem/Pages/notificationManager/dietNotification.dart';
import 'package:healthcaresupportsystem/Pages/notificationManager/waterNotification.dart';
import 'Pages/Auth/LogIn.dart';
import 'Pages/CKD_pages/CKD_message.dart';
import 'Pages/CKD_pages/CKD_discription.dart';
import 'Pages/Auth/SplashScreen.dart';
import 'Pages/HTD/HTD_Pages/CKD_message_about.dart';
import 'Pages/HTD/dialog_flow.dart';
import 'Pages/breast_cancer/breast_cancer.dart';
import 'Pages/breast_cancer/prediction/b_result.dart';
import 'Pages/breast_cancer/prediction/breast_cancer_prediction.dart';
import 'Pages/breast_cancer/prediction/g_result.dart';
import 'Pages/breast_cancer/prediction/prediction_help.dart';

void main() => runApp(MaterialApp(
      routes: {
//    '/loading':(context) =>Loading(auth: Auth()),
        '/':(context)=>SplashScreen(),
        '/login': (context) => LogIn(),
        '/onboard_screen':(context)=>OnboardingScreen(),
        '/account': (context) => Account(),
        '/home': (context) => Home(),
        '/CKD_message': (context) => CKD_message(),
        '/CKD_discription': (context) => CKD_discription(),
        '/CKD_webview': (context) => CKD_webview(),
        '/CKD_symptom': (context) => CKD_symptoms(),
        '/CKD_precaution': (context) => CKD_precautions(),
        '/WaterNotification':(context)=>WaterNotification(),
        '/DietNotification':(context)=>DietNotification(),
        '/CKD_messageAbout':(context)=>CKDMessageAbout(),

//        -----------------------------------------------------------
        '/breastcancer':(context) =>BrestCancer(),
        '/bc_symptoms':(context)=>BC_Symptoms(),
        '/bc_solutions':(context)=>BC_Solutions(),
        '/bc_more':(context)=>BC_More(),
        '/bc_prediction':(context)=>BreastCancerPrediction(),
        '/gresult':(context)=>Gresult(),
        '/bresult':(context)=>Bresult(),
        '/predictionhelp':(context)=>PredictionHelp(),

//       -----------------------------------------------------------
        '/HTD_message':(context)=>FlutterFactsChatBot(),
        '/HTD_home':(context)=>HTD_Home(),
        '/HTD_card':(context)=>HTD_Cards(),

      },
    ));