import 'package:equatable/equatable.dart';
import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

enum AuthenticationEventType { login, logout }

enum AuthenticationStatus {
  logged,
  notLogged,
}

class AuthenticationEvent {
  const AuthenticationEvent({@required this.type, this.signInType});

  final AuthenticationSignInType signInType;
  final AuthenticationEventType type;
}

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState(
      {this.credentials, this.authenticationStatus, this.loading, this.error});
  @required
  final AuthenticationStatus authenticationStatus;
  final bool error;
  final bool loading;
  final CredentialsModel credentials;

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
      CredentialsModel credentials})
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
  Logger logger = Logger('AuthenticationBloc');

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    logger.fine('new event: $event');
    switch (event.type) {
      case AuthenticationEventType.login:
        {
          yield NewAuthenticationState(
            state,
            loading: true,
            error: false,
          );
          CredentialsModel credentials;
          try {
            credentials =
                await authenticationRepository.signIn(event.signInType);

            yield NewAuthenticationState(
              state,
              credentials: credentials,
              authenticationStatus: AuthenticationStatus.logged,
              loading: false,
              error: false,
            );
          } on Exception catch (e) {
            logger.severe(e);
            yield NewAuthenticationState(state,
                authenticationStatus: AuthenticationStatus.notLogged,
                loading: false,
                error: true);
          }

          break;
        }
      case AuthenticationEventType.logout:
        try {
          await authenticationRepository.signOut();
          yield NewAuthenticationState(state,
              authenticationStatus: AuthenticationStatus.notLogged,
              credentials: CredentialsModel());
        } on Exception catch (e) {
          logger.severe(e);
          yield NewAuthenticationState(state, loading: false, error: true);
        }
        break;
    }
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    logger.fine('state change: $change');
    super.onChange(change);
  }
}
