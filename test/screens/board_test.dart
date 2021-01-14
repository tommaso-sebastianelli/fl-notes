import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:fl_notes/screens/board/board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FlutterConfig.loadValueForTesting({'ENV': 'dev', 'LABEL': 'test'});

  testWidgets('Render Board screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc(AuthenticationRepository(MockApi())),
      ),
      BlocProvider<NotesBloc>(
        create: (BuildContext context) => NotesBloc(NotesRepository(MockApi())),
      ),
      // Add more providers here
    ], child: const Board())));

    await tester.pumpAndSettle(const Duration(seconds: 2000));
    expect(find.text('No notes yet'), findsOneWidget);
  });
}
