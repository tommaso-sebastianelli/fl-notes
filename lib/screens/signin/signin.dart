import 'package:fl_notes/blocs/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Add this line

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(FlutterConfig.get('LABEL').toString()),
          ),
          body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen:
                (AuthenticationState previous, AuthenticationState current) =>
                    previous.error != current.error,
            listener: (BuildContext context, AuthenticationState state) => {
              if (state.error)
                {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black,
                      content: Text((AppLocalizations.of(_context).loginError)
                          .toString()),
                      duration: const Duration(seconds: 2),
                    ),
                  )
                }
              else
                {Scaffold.of(context).hideCurrentSnackBar()}
            },
            child: _child(_context),
          )),
    );
  }

  Widget _child(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
          )
        ],
      ),
    );
  }
}
