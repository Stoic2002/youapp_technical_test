import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_technical_test/core/extensions/age_extension.dart';

void main() {
  group('AgeCalculator Extension', () {
    test('calculates age correctly for a valid date', () {
      const birthDate = '01 01 2000';
      final age = birthDate.getAge();
      final expectedAge = DateTime.now().year - 2000;
      expect(age, expectedAge);
    });

    test('returns 0 for invalid date format', () {
      const invalidDate = 'invalid date';
      final age = invalidDate.getAge();
      expect(age, 0);
    });
  });
}
