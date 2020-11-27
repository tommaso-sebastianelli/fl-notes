// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:fl_notes/main.dart';

void main() {
  FlutterConfig.loadValueForTesting({'ENV': 'MOCK'});

  testWidgets('Render main widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the main widget renders.
    expect(find.text('Hello World MOCK'), findsOneWidget);
  });
}
