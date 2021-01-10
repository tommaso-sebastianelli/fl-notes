import 'package:fl_notes/models/credentials.dart';
import 'package:logging/logging.dart';

abstract class AuthenticationDataProvider {
  Future<Credentials> signIn();
  Future<void> signOut();
}

class AuthenticationRepository {
  AuthenticationRepository(this._dataProvider);

  final AuthenticationDataProvider _dataProvider;
  final Logger logger = Logger('AuthenticationRepository');

  Future<Credentials> signIn() {
    return _dataProvider
        .signIn()
        .then((Credentials value) => value)
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
