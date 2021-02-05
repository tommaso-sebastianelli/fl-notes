import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/screens/board/components/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Note Component renders correctly', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MaterialApp(
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Note(
            NoteModel(
                title: 'lorem ipsum',
                body: 'lorem ipsum dolor sit amet',
                type: NoteType.text),
          )
        ],
      ),
      color: null,
    ));

    expect(find.text('lorem ipsum'), findsOneWidget);
    expect(find.text('lorem ipsum dolor sit amet'), findsOneWidget);
  });
}
