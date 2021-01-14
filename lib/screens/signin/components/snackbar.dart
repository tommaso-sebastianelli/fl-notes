import 'package:fl_notes/blocs/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInSnackBarWrapper extends StatelessWidget {
  const SignInSnackBarWrapper({this.child, this.localizedContext}) : super();

  final Widget child;
  final BuildContext localizedContext;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (AuthenticationState previous, AuthenticationState current) =>
          previous.error != current.error,
      listener: (BuildContext context, AuthenticationState state) => {
        if (state.error)
          {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                content: Text((AppLocalizations.of(localizedContext).loginError)
                    .toString()),
                duration: const Duration(seconds: 2),
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
