import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:fl_notes/screens/editor/components/editor_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  FlutterConfig.loadValueForTesting({'ENV': 'dev', 'LABEL': 'test'});

  testWidgets('Cancel Button is present and pop navigation on press',
      (WidgetTester tester) async {
    final MockNavigatorObserver mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: [mockObserver],
        home: MultiBlocProvider(
            providers: [
              BlocProvider<NotesBloc>(
                create: (BuildContext context) =>
                    NotesBloc(NotesRepository(MockApi())),
              ),
              // Add more providers here
            ],
            child: const Scaffold(
              body: EditorHeader(),
            ))));

    await tester.pumpAndSettle(const Duration(seconds: 2000));

    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    /// Verify that a push event happened
    verify(mockObserver.didPop(any, any));
  });
}
