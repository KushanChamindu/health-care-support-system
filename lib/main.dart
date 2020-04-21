import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Account.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/CKD_precautions.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/CKD_symptom.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/CKD_webview.dart';
import 'package:healthcaresupportsystem/Pages/Home.dart';
import 'package:healthcaresupportsystem/Pages/breast_cancer/bc_more.dart';
import 'package:healthcaresupportsystem/Pages/breast_cancer/breast_solutions.dart';
import 'package:healthcaresupportsystem/Pages/breast_cancer/breast_symptoms.dart';
import 'package:healthcaresupportsystem/Pages/notificationManager/dietNotification.dart';
import 'package:healthcaresupportsystem/Pages/notificationManager/waterNotification.dart';
import 'Pages/Auth/LogIn.dart';
import 'Pages/CKD_pages/CKD_message.dart';
import 'Pages/CKD_pages/CKD_discription.dart';
import 'Pages/breast_cancer/breast_cancer.dart';

void main() => runApp(MaterialApp(
      routes: {
//    '/loading':(context) =>Loading(auth: Auth()),
        '/': (context) => LogIn(),
        '/account': (context) => Account(),
        '/home': (context) => Home(
            ),
        '/CKD_message': (context) => CKD_message(),
        '/CKD_discription': (context) => CKD_discription(),
        '/CKD_webview': (context) => CKD_webview(),
        '/CKD_symptom': (context) => CKD_symptoms(),
        '/CKD_precaution': (context) => CKD_precautions(),
        '/WaterNotification':(context)=>WaterNotification(),
        '/DietNotification':(context)=>DietNotification(),

//        -----------------------------------------------------------
        '/breastcancer':(context) =>BrestCancer(),
        '/bc_symptoms':(context)=>BC_Symptoms(),
        '/bc_solutions':(context)=>BC_Solutions(),
        '/bc_more':(context)=>BC_More(),

      },
    ));
