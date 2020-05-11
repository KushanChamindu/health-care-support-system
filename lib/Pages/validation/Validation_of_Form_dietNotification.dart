
import 'package:flutter/cupertino.dart';

class ValidationOfFormDiet{
  static String BreakFastValidation(
      String value, TextEditingController _lunchController,TextEditingController _dinnerController) {
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
        int.parse(_lunchController.text.split(':')[0]),
        int.parse(_lunchController.text.split(':')[1])))) {
      return 'Breakfast time should be before lunch time';
    }else if (!DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isBefore(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(_dinnerController.text.split(':')[0]),
        int.parse(_dinnerController.text.split(':')[1])))) {
      return 'BreakFasr time should be before dinner time';
    }
  }

  static String LunchValidation(
      String value, TextEditingController _breakfastController,TextEditingController _dinnerController) {
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
        int.parse(_breakfastController.text.split(':')[0]),
        int.parse(_breakfastController.text.split(':')[1])))) {
      return 'Lunch time time should be after breakfast time';
    } else if (! DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isBefore(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(_dinnerController.text.split(':')[0]),
        int.parse(_dinnerController.text.split(':')[1])))) {
      return 'Lunch time time should be before dinner time';
    }
  }
  static String DinnerValidation(
      String value, TextEditingController _breakfastController,TextEditingController _lunchController) {
    if (value == null) {
      return 'Time is required';
    } else if (!DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isAfter(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(_breakfastController.text.split(':')[0]),
        int.parse(_breakfastController.text.split(':')[1])))) {
      return 'Dinner time should be after brealfast time';
    } else if (!DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(value.split(':')[0]),
        int.parse(value.split(':')[1]))
        .isAfter(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(_lunchController.text.split(':')[0]),
        int.parse(_lunchController.text.split(':')[1])))) {
      return 'Dinner time should be after lunch time';
    }
  }
}