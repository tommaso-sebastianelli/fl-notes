import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/repositories/authentication.dart';

class MockApi extends AuthenticationDataProvider {
  @override
  Future<Credentials> signIn() {
    final Credentials data = Credentials(
        name: 'john_doe',
        email: 'john.doe.00@mail.com',
        id: '0',
        photoUrl: '',
        token: 'efhd7Gs8Hbd7jVnmoL');
    return Future<Credentials>.delayed(const Duration(seconds: 2), () => data);
  }

  @override
  Future<void> signOut() {
    return Future<void>.value();
  }
}
