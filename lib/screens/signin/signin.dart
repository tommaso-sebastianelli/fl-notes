import 'package:fl_notes/screens/signin/components/form.dart';
import 'package:fl_notes/screens/signin/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(FlutterConfig.get('LABEL').toString()),
        ),
        body: SignInSnackBarWrapper(
          localizedContext: context,
          child: const SignInForm(),
        ));
  }
}
