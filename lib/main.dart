import 'dart:developer';

import 'package:fl_notes/app_container.dart';
import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables(); // Load env file

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc(AuthenticationRepository(MockApi())),
      ),
      BlocProvider<NotesBloc>(
        create: (BuildContext context) => NotesBloc(NotesRepository(MockApi())),
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
          return const SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          log('Firebase successfully loaded');
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
    return Container(
        // TODO
        );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // TODO
        );
  }
}
