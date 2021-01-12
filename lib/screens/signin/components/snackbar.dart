import 'package:fl_notes/blocs/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInSnackBarWrapper extends StatelessWidget {
  const SignInSnackBarWrapper({this.child}) : super();

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (AuthenticationState previous, AuthenticationState current) =>
          previous.error != current.error,
      listener: (BuildContext context, AuthenticationState state) => {
        if (state.error)
          {
            Scaffold.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                    // TODO
                    'TODO'),
                // (AppLocalizations.of(_context).loginError).toString()),
                duration: Duration(seconds: 2),
              ),
            )
          }
        else
          {Scaffold.of(context).hideCurrentSnackBar()}
      },
      child: child,
    );
  }
}
