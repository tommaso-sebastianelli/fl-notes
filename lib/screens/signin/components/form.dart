import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'logo.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
      Expanded(
        flex: 3,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(50, 0),
                        bottomRight: Radius.elliptical(300, 250))),
                child: const Logo(),
              ),
            ),
          ],
        ),
      ),
      Flexible(
        flex: 1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (BuildContext context, AuthenticationState state) =>
                      state.loading
                          ? const CircularProgressIndicator()
                          : Column(
                              children: [
                                GoogleSignInButton(
                                  onPressed: () {
                                    context.read<AuthenticationBloc>().add(
                                        const AuthenticationEvent(
                                            type: AuthenticationEventType.login,
                                            signInType: AuthenticationSignInType
                                                .google));
                                  }, // default: false
                                ),
                                TextButton(
                                    onPressed: () {
                                      context.read<AuthenticationBloc>().add(
                                          const AuthenticationEvent(
                                              type:
                                                  AuthenticationEventType.login,
                                              signInType:
                                                  AuthenticationSignInType
                                                      .anonymous));
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .signInAnonymously
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black45),
                                    ))
                              ],
                            )),
            )
          ],
        ),
      )
    ]);
  }
}
