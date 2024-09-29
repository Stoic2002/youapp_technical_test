import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AgeCalculator on String {
  int getAge() {
    try {
      DateFormat dateFormat = DateFormat("dd MM yyyy");

      DateTime birthDate = dateFormat.parse(this);

      DateTime today = DateTime.now();

      int age = today.year - birthDate.year;

      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      debugPrint("Invalid date format: $e");
      return 0;
    }
  }
}
