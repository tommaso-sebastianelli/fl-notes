import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/repositories/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('AuthenticationBloc', () {
    final AuthenticationRepository authenticationRepository =
        MockAuthenticationRepository();
    AuthenticationBloc authenticationBloc;
    final CredentialsModel mockCredentials = CredentialsModel(
        name: 'john_doe',
        email: 'john.doe.00@mail.com',
        id: '0',
        photoUrl: '',
        token: 8719346124610418764);

    setUp(() {
      authenticationBloc = AuthenticationBloc(authenticationRepository);
    });

    tearDown(() {
      authenticationBloc?.close();
    });

    test('initial state check', () {
      expect(authenticationBloc.state, const InitialAuthenticationState());
    });

    test('user logs in', () {
      const InitialAuthenticationState oldState = InitialAuthenticationState();

      final List<NewAuthenticationState> expected = [
        NewAuthenticationState(
          oldState,
          authenticationStatus: AuthenticationStatus.notLogged,
          error: false,
          loading: true,
        ),
        NewAuthenticationState(
          oldState,
          credentials: mockCredentials,
          authenticationStatus: AuthenticationStatus.logged,
          loading: false,
          error: false,
        )
      ];

      when(authenticationRepository.signIn(AuthenticationSignInType.anonymous))
          .thenAnswer((_) => Future<CredentialsModel>.value(mockCredentials));

      expectLater(
        authenticationBloc,
        emitsInOrder(expected),
      );

      authenticationBloc.add(const AuthenticationEvent(
          type: AuthenticationEventType.login,
          signInType: AuthenticationSignInType.anonymous));
    });

    test('user logs out', () {
      const initialState = InitialAuthenticationState();
      final NewAuthenticationState oldState = NewAuthenticationState(
          initialState,
          authenticationStatus: AuthenticationStatus.logged,
          credentials: mockCredentials);

      final CredentialsModel emptyCredentials = CredentialsModel();

      final List<NewAuthenticationState> expected = [
        NewAuthenticationState(oldState,
            authenticationStatus: AuthenticationStatus.notLogged,
            credentials: emptyCredentials)
      ];

      when(authenticationRepository.signOut())
          .thenAnswer((_) => Future<void>.value());

      expectLater(
        authenticationBloc,
        emitsInOrder(expected),
      );

      authenticationBloc
          .add(const AuthenticationEvent(type: AuthenticationEventType.logout));
    });
  });
}
