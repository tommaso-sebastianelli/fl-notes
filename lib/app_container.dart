import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/screens/editor/editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'screens/board/board.dart';
import 'screens/signin/signin.dart';

class AppContainer extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      routes: {
        '/': (BuildContext context) => const SignIn(),
        Board.routeName: (BuildContext context) => const Board(),
        Editor.routeName: (BuildContext context) => Editor(NoteModel.empty()),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(color: Colors.black12),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.amber[300]),
        // textTheme: GoogleFonts.barlowTextTheme(
        //   Theme.of(context,).textTheme,
        // ),
      ),
      builder: (BuildContext context, Widget child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen:
              (AuthenticationState previous, AuthenticationState current) =>
                  previous.authenticationStatus != current.authenticationStatus,
          listener: (BuildContext context, AuthenticationState state) {
            switch (state.authenticationStatus) {
              case AuthenticationStatus.logged:
                _navigator.pushNamedAndRemoveUntil(
                    '/board', (Route<dynamic> route) => false);
                break;
              case AuthenticationStatus.notLogged:
                _navigator.pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
                break;
              default:
                break;
            }
          },
          child: Material(child: child),
        );
      },
      // onGenerateRoute: (_) => SplashPage.route(), // TODO
    );
  }
}
