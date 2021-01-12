import 'package:fl_notes/blocs/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (BuildContext context, AuthenticationState state) =>
                  state.loading
                      ? const CircularProgressIndicator()
                      : Column(children: [
                          GoogleSignInButton(
                            onPressed: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(AuthenticationEvent.login);
                            }, // default: false
                          )
                        ]))
        ],
      ),
    );
  }
}
