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

      final CredentialsModel mockCredentials = CredentialsModel(
          name: 'john_doe',
          email: 'john.doe.00@mail.com',
          id: '0',
          photoUrl: '',
          token: 'efhd7Gs8Hbd7jVnmoL');

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

      when(authenticationRepository.signIn())
          .thenAnswer((_) => Future<CredentialsModel>.value(mockCredentials));

      expectLater(
        authenticationBloc,
        emitsInOrder(expected),
      );

      authenticationBloc.add(AuthenticationEvent.login);
    });

    test('user logs out', () {
      const InitialAuthenticationState oldState = InitialAuthenticationState();

      final List<NewAuthenticationState> expected = [
        NewAuthenticationState(oldState,
            authenticationStatus: AuthenticationStatus.notLogged)
      ];

      expectLater(
        authenticationBloc,
        emitsInOrder(expected),
      );

      authenticationBloc.add(AuthenticationEvent.logout);
    });
  });
}
