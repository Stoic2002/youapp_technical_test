import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youapp_technical_test/core/assets/app_icons.dart';

extension ChineseZodiacCalculator on String {
  String getChineseZodiac() {
    try {
      DateFormat dateFormat = DateFormat("dd MM yyyy");
      DateTime birthDate = dateFormat.parse(this);

      List<String> zodiacSigns = [
        "Rat",
        "Ox",
        "Tiger",
        "Rabbit",
        "Dragon",
        "Snake",
        "Horse",
        "Goat",
        "Monkey",
        "Rooster",
        "Dog",
        "Pig"
      ];

      int year = birthDate.year;
      int zodiacIndex = (year - 1900) % 12;

      return zodiacSigns[zodiacIndex];
    } catch (e) {
      debugPrint("Invalid date format: $e");
      return "-";
    }
  }

  String getChineseZodiacIcon() {
    String zodiac = getChineseZodiac().toLowerCase();
    switch (zodiac) {
      case "rat":
        return AppIcons.rat;
      case "ox":
        return AppIcons.ox;
      case "tiger":
        return AppIcons.tiger;
      case "rabbit":
        return AppIcons.rabbit;
      case "dragon":
        return AppIcons.dragon;
      case "snake":
        return AppIcons.snake;
      case "horse":
        return AppIcons.horse;
      case "goat":
        return AppIcons.goat;
      case "monkey":
        return AppIcons.monkey;
      case "rooster":
        return AppIcons.rooster;
      case "dog":
        return AppIcons.dog;
      case "pig":
        return AppIcons.pig;
      default:
        return "";
    }
  }
}
