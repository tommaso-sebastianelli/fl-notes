import 'package:fl_notes/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FlutterConfig.loadValueForTesting({'ENV': 'dev', 'LABEL': 'test'});

  testWidgets('Render AppContainer', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignIn()));

    expect(find.text('Sign in with Google'), findsOneWidget);
  });
}
