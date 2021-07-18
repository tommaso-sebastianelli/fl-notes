import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.elliptical(50, 0),
                        bottomRight: Radius.elliptical(300, 250))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black38,
                              blurRadius: 0.1,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          color: Colors.amber[200],
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(22),
                            child: Icon(
                              Icons.edit,
                              size: 75,
                              color: Colors.black54,
                            )),
                      ),
                      // Icon(Icons.login),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 22),
                        child: Text(AppLocalizations.of(context).signInAppDesc,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            )),
                      )
                    ],
                  ),
                ),
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
                                      style: TextStyle(
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
