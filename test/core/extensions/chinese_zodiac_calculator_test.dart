import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_technical_test/core/extensions/zodiac_extension.dart';

void main() {
  group('ChineseZodiacCalculator Extension', () {
    test('returns correct Chinese zodiac for a given date', () {
      const birthDate = '01 01 2000';
      final chineseZodiac = birthDate.getChineseZodiac();
      expect(chineseZodiac, 'Dragon');
    });

    test('returns "-" for invalid date format', () {
      const invalidDate = 'invalid date';
      final chineseZodiac = invalidDate.getChineseZodiac();
      expect(chineseZodiac, '-');
    });
  });
}
