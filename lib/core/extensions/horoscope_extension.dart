import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youapp_technical_test/core/assets/app_icons.dart';

extension HoroscopeCalculator on String {
  String getHoroscope() {
    try {
      DateFormat dateFormat = DateFormat("dd MM yyyy");
      DateTime birthDate = dateFormat.parse(this);

      int month = birthDate.month;
      int day = birthDate.day;

      if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
        return "Aries";
      } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
        return "Taurus";
      } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
        return "Gemini";
      } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
        return "Cancer";
      } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
        return "Leo";
      } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
        return "Virgo";
      } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
        return "Libra";
      } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
        return "Scorpio";
      } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
        return "Sagittarius";
      } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
        return "Capricorn";
      } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
        return "Aquarius";
      } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
        return "Pisces";
      } else {
        return "-";
      }
    } catch (e) {
      debugPrint("Invalid date format: $e");
      return "-";
    }
  }

  String getHoroscopeIcon() {
    String horoscope = getHoroscope().toLowerCase();
    switch (horoscope) {
      case "aries":
        return AppIcons.aries;
      case "taurus":
        return AppIcons.taurus;
      case "gemini":
        return AppIcons.gemini;
      case "cancer":
        return AppIcons.cancer;
      case "leo":
        return AppIcons.leo;
      case "virgo":
        return AppIcons.virgo;
      case "libra":
        return AppIcons.libra;
      case "scorpio":
        return AppIcons.scorpio;
      case "sagittarius":
        return AppIcons.sagitarius;
      case "capricorn":
        return AppIcons.capricorn;
      case "aquarius":
        return AppIcons.aquarius;
      case "pisces":
        return AppIcons.pisces;
      default:
        return "";
    }
  }
}
