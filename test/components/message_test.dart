import 'package:fl_notes/components/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Message Component renders correctly',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MaterialApp(
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Message(
            icon: Icons.info,
            text: 'test',
          )
        ],
      ),
      color: null,
    ));

    expect(find.text('test'), findsOneWidget);
    expect(find.byIcon(Icons.info).first, findsOneWidget);
  });
}
