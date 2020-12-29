// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fl_notes/app_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_config/flutter_config.dart';

void main() {
  FlutterConfig.loadValueForTesting({'ENV': 'dev'});

  testWidgets('Render AppContainer', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(AppContainer());

    // Verify the main widget renders.
    expect(find.text('env: dev'), findsOneWidget);
    // actions edit test
  });
}
