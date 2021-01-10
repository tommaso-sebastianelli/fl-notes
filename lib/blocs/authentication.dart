import 'package:equatable/equatable.dart';
import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthenticationEvent { login, logout }

enum AuthenticationStatus {
  logged,
  notLogged,
}

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState(
      {this.credentials, this.authenticationStatus, this.loading, this.error});
  @required
  final AuthenticationStatus authenticationStatus;
  final bool error;
  final bool loading;
  final Credentials credentials;

  @override
  List<Object> get props => [authenticationStatus, error, loading, credentials];
}

class InitialAuthenticationState extends AuthenticationState {
  const InitialAuthenticationState()
      : super(
          authenticationStatus: AuthenticationStatus.notLogged,
          error: false,
          loading: false,
        );
}

class NewAuthenticationState extends AuthenticationState {
  NewAuthenticationState(AuthenticationState oldState,
      {AuthenticationStatus authenticationStatus,
      bool error,
      bool loading,
      Credentials credentials})
      : super(
            authenticationStatus:
                authenticationStatus ?? oldState.authenticationStatus,
            credentials: credentials ?? oldState.credentials,
            error: error ?? oldState.error,
            loading: loading ?? oldState.loading);
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.authenticationRepository)
      : super(const InitialAuthenticationState());

  AuthenticationRepository authenticationRepository;

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
                authenticationStatus: AuthenticationStatus.notLogged,
                loading: false,
                error: true);
          }
          break;
        }
      case AuthenticationEvent.logout:
        yield NewAuthenticationState(state,
            authenticationStatus: AuthenticationStatus.notLogged);
        break;
    }
  }
}
