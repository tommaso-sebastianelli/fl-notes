import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/data/mock_api.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FlutterConfig.loadValueForTesting({'ENV': 'dev', 'LABEL': 'test'});

  testWidgets('Render SignIn screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc(AuthenticationRepository(MockApi())),
      ),
      // Add more providers here
    ], child: const SignIn())));

    expect(find.text('Sign in with Google'), findsOneWidget);
  });
}
