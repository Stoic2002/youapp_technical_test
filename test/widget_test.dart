import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_technical_test/main.dart'; // Sesuaikan dengan aplikasi utama

void main() {
  testWidgets('App starts up and displays some initial text',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
