import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_technical_test/core/extensions/horoscope_extension.dart';

void main() {
  group('HoroscopeCalculator Extension', () {
    test('returns correct horoscope for a given date', () {
      const birthDate = '01 04 1990';
      final horoscope = birthDate.getHoroscope();
      expect(horoscope, 'Aries');
    });

    test('returns "-" for invalid date format', () {
      const invalidDate = 'invalid date';
      final horoscope = invalidDate.getHoroscope();
      expect(horoscope, '-');
    });
  });
}
