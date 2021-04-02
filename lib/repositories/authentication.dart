import 'package:fl_notes/models/credentials.dart';
import 'package:logging/logging.dart';

abstract class AuthenticationProvider {
  Future<CredentialsModel> signIn();
  Future<void> signOut();
}

class AuthenticationRepository {
  AuthenticationRepository(this._dataProvider);

  final AuthenticationProvider _dataProvider;
  final Logger logger = Logger('AuthenticationRepository');

  Future<CredentialsModel> signIn() {
    return _dataProvider
        .signIn()
        .then((CredentialsModel value) => value)
        .catchError(onError);
  }

  Future<void> signOut() {
    return _dataProvider
        .signOut()
        .then((void value) => value)
        .catchError(onError);
  }

  void onError(Object e) {
    logger.severe(e);
    // throw (e);
  }
}
