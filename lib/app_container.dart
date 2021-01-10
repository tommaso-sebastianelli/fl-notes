import 'package:fl_notes/blocs/authentication.dart';
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
        '/board': (BuildContext context) => Board(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
          child: child,
        );
      },
      // onGenerateRoute: (_) => SplashPage.route(), // TODO
    );
  }
}
