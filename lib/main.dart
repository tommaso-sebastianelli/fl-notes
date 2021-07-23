import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/abstract_api.dart';
import 'package:fl_notes/data/firebase_api.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

import 'app_container.dart';
import 'components/message.dart';

API getAPI() {
  switch (FlutterConfig.get('ENV').toString()) {
    case 'dev':
      return DevApi();
    case 'mock':
    default:
      return MockApi();
  }
}

Future<void> main() async {
  if (!kReleaseMode) {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      String prefix;
      String suffix = '\x1B[0m';

      switch (record.level.name) {
        case 'SEVERE':
        case 'SHOUT':
          prefix = '\x1B[31m';
          break;
        case 'WARNING':
          prefix = '\x1B[33m';
          break;
        case 'INFO':
          prefix = '\x1B[36m';
          break;
        default:
          prefix = '\x1B[37m';
      }

      print('''
      $prefix${record.loggerName}$suffix
      $prefix${record.message}$suffix
      $prefix${record.time}$suffix
      $prefix------------------------------------------$suffix''');
    });
  }

  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables(); // Load env file

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc(AuthenticationRepository(getAPI())),
      ),
      BlocProvider<NotesBloc>(
        create: (BuildContext context) => NotesBloc(NotesRepository(getAPI())),
      ),
      // Add more providers here
    ],
    child: MyApp(),
  ));

  return Future<void>.value();
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Critical();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          Logger('main').info('Firebase successfully loaded');
          return AppContainer();
        }

        // Otherwise, show loading
        return const Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      )),
    );
  }
}

class Critical extends StatelessWidget {
  const Critical() : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (BuildContext context, Widget child) => Center(
                child: Scaffold(
                    body: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                  Message(
                      icon: Icons.error_outline,
                      title:
                          AppLocalizations.of(context).genericError.toString())
                ])))));
  }
}
