import 'package:flutter/cupertino.dart';

class ValidationOfFormWater{
  static String StartimeValidation(
      String value, TextEditingController _endController) {
    if (value == null) {
      return 'Time is required';
    } else if (!DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isBefore(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(_endController.text.split(':')[0]),
        int.parse(_endController.text.split(':')[1])))) {
      return 'Start time should be before end time';
    } else if (!DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isAfter(DateTime.now())) {
      return 'Time should after now time';
    }
  }

  static String EndtimeValidation(
      String value, TextEditingController _startController) {
    if (value == null) {
      return 'Time is required';
    } else if (! DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isAfter(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(_startController.text.split(':')[0]),
        int.parse(_startController.text.split(':')[1])))) {
      return 'End time should be after start time';
    } else if (!DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isAfter(DateTime.now())) {
      return 'Time should after now time';
    }
  }
  static String waterGoalValidation(String value) {
    try {
      int goal = int.parse(value);
      return null;
    } catch (e) {
      return 'Goal should be a number';
    }
  }
  static String drinkWaterValidation(String value) {
    try {
      int goal = int.parse(value);
      return null;
    } catch (e) {
      return 'Drink amount should be a number';
    }
  }
}