import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/screens/board/components/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Note Component renders correctly', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
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
            child: Note(
              NoteModel(
                  title: 'lorem ipsum',
                  body: 'lorem ipsum dolor sit amet',
                  type: NoteType.text),
            ))));

    expect(find.text('lorem ipsum'), findsOneWidget);
    expect(find.text('lorem ipsum dolor sit amet'), findsOneWidget);
  });
}
