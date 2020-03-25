import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Home.dart';
import 'Pages/Loading.dart';
import 'Pages/CKD_pages/CKD_message.dart';
import 'Pages/CKD_pages/CKD_discription.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) =>Loading(),
    '/home': (context) => Home(),
    '/CKD_message' :(context)=> CKD_message(),
    '/CKD_discription':(context) =>CKD_discription()
  },
));



