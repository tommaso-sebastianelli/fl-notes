import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(FlutterConfig.get('LABEL')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoogleSignInButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/board');
                },
                darkMode: false, // default: false
              ),
            ],
          ),
        ),
      ),
      color: null,
    );
  }
}
