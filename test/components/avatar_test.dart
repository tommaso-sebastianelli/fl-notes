import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/components/avatar.dart';
import 'package:fl_notes/components/message.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Message Component renders correctly',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MaterialApp(
        home: MultiBlocProvider(
            providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(AuthenticationRepository(MockApi())),
          ),
          BlocProvider<NotesBloc>(
            create: (BuildContext context) =>
                NotesBloc(NotesRepository(MockApi())),
          ),
          // Add more providers here
        ],
            child: Avatar(
              onTap: () => {},
            ))));

    expect(find.byType(Avatar).first, findsOneWidget);
  });
}
