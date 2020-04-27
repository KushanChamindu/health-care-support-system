import 'package:flutter/cupertino.dart';

class ValidationForm {
  static String emailValidate(String value) {
    return value.isEmpty ? 'Email con\'t be empty' : null;
  }

  static String passwordValidate(String value) {
    return value.isEmpty ? 'Password con\'t be empty' : null;
  }

  static String usernameValidate(String value) {
    return value.isEmpty ? 'User name con\'t be empty' : null;
  }

  static String dateValidate(DateTime value) {
    if (value == null) {
      return 'Birthday is required';
    } else {
      String date = value.toString().trim().split(' ')[0];
      final birthday = DateTime(
        int.parse(date.split('-')[0]),
        int.parse(date.split('-')[1]),
        int.parse(date.split('-')[2]),
      );
      final date2 = DateTime.now();
      final difference = date2.difference(birthday).inDays;
      if (difference <= 3650) {
        return 'Your age should be more than 10 years';
      } else {
        return null;
      }
    }
  }

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

  static String bloodValidate(String value) {
    List<String> bloodGroups = [
      'O−',
      'O+',
      'A−',
      'A+',
      'B−',
      'B+',
      'AB−',
      'AB+'
    ];
    if (value.isEmpty) {
      return 'Blood group con\'t be empty';
    } else if (!bloodGroups.contains(value)) {
      return 'Blood group should be one of thses: O−	O+	A−	A+	B−	B+	AB−	AB+';
    } else {
      return null;
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

  static String confirmPassValidate(
      String value, TextEditingController _passwordController) {
    if (value.isEmpty) return 'Password con\'t be empty';
    if (value != _passwordController.text) return 'Not Match with password';
    return null;
  }
}
