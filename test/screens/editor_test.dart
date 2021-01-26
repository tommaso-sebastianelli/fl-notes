import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:fl_notes/screens/editor/editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  FlutterConfig.loadValueForTesting({'ENV': 'dev', 'LABEL': 'test'});

  testWidgets('Render Editor screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(AuthenticationRepository(MockApi())),
          ),
          BlocProvider<NotesBloc>(
            create: (BuildContext context) =>
                NotesBloc(NotesRepository(MockApi())),
          ),
          // Add more providers here
        ], child: const Editor())));

    await tester.pumpAndSettle(const Duration(seconds: 2000));

    expect(find.text('Enter a title'), findsOneWidget);
    expect(find.text('Enter some text'), findsOneWidget);
  });
}
