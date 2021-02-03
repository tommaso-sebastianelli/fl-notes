import 'package:fl_notes/blocs/authentication.dart';
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
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.elliptical(50, 0),
                        bottomRight: Radius.elliptical(500, 250))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(width: 1, color: Colors.black38),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(28)),
                          color: Colors.yellow[600],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            'fln',
                            style:
                                TextStyle(fontSize: 112, color: Colors.black54),
                          ),
                        ),
                      ),

                      // Icon(Icons.login),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
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
                        : GoogleSignInButton(
                            onPressed: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(AuthenticationEvent.login);
                            }, // default: false
                          ),
              ),
            )
          ],
        ),
      )
    ]);
  }
}
