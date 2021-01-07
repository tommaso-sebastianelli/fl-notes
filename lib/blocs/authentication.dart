import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthenticationEvent { login, logout }

enum AuthenticationStatus {
  logged,
  not_logged,
}

@immutable
abstract class AuthenticationState {
  @required
  final AuthenticationStatus authenticationStatus;
  final Credentials credentials;
  final bool loading;
  final bool error;
  AuthenticationState(
      {this.credentials, this.authenticationStatus, this.loading, this.error});
}

class InitialAuthenticationState extends AuthenticationState {
  InitialAuthenticationState()
      : super(
          authenticationStatus: AuthenticationStatus.not_logged,
          loading: false,
          error: false,
        );
}

class NewAuthenticationState extends AuthenticationState {
  NewAuthenticationState(AuthenticationState oldState,
      {Credentials credentials,
      AuthenticationStatus authenticationStatus,
      bool loading,
      bool error})
      : super(
            credentials: credentials ?? oldState.credentials,
            authenticationStatus:
                authenticationStatus ?? oldState.authenticationStatus,
            loading: loading ?? oldState.loading,
            error: error ?? oldState.error);
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository authenticationRepository;
  AuthenticationBloc(this.authenticationRepository)
      : super(InitialAuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    switch (event) {
      case AuthenticationEvent.login:
        {
          yield NewAuthenticationState(
            state,
            loading: true,
            error: false,
          );
          final Credentials credentials =
              await authenticationRepository.signIn();
          if (credentials != null) {
            yield NewAuthenticationState(
              state,
              credentials: credentials,
              authenticationStatus: AuthenticationStatus.logged,
              loading: false,
              error: false,
            );
          } else {
            yield NewAuthenticationState(state,
                authenticationStatus: AuthenticationStatus.not_logged,
                loading: false,
                error: true);
          }
          break;
        }
      case AuthenticationEvent.logout:
        yield NewAuthenticationState(state,
            authenticationStatus: AuthenticationStatus.not_logged);
        break;
    }
  }
}
