import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lightlog/main.dart';

void main() {
  testWidgets('LightLog app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LightLogApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}