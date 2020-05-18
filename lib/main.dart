import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcaredecision/HTD_card/HTD_dart.dart';
import 'package:healthcaredecision/pages/Home.dart';
import 'package:healthcaredecision/pages/HTD/HTD_precautions.dart';
void main() => runApp(MaterialApp(
  routes: {

    '/': (context) => HTD_Cards(),
    '/card': (context) => HTD_Cards(),

    '/home': (context) => Home(),

  },
));
