import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sevasetu/app/app.dart';

void main() {
  testWidgets('SevaSetu app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SevaSetuApp());
    expect(find.byType(SevaSetuApp), findsOneWidget);
  });
}