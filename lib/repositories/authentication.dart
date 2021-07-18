import 'package:fl_notes/models/credentials.dart';
import 'package:logging/logging.dart';

abstract class AuthenticationProvider {
  Future<CredentialsModel> signIn(AuthenticationSignInType type);
  Future<void> signOut();
  String getUserId();
  CredentialsModel isUserAuthenticated();
}

enum AuthenticationSignInType { google, anonymous }

class AuthenticationRepository {
  AuthenticationRepository(this._dataProvider);

  final AuthenticationProvider _dataProvider;
  final Logger logger = Logger('AuthenticationRepository');

  Future<CredentialsModel> signIn(AuthenticationSignInType type) {
    logger.fine('signIn::start');
    return _dataProvider
        .signIn(type)
        .then((CredentialsModel value) => value)
        .catchError(onError)
        .whenComplete(() => logger.fine('signIn::success'));
  }

  Future<void> signOut() {
    logger.fine('signOut::start');
    return _dataProvider
        .signOut()
        .then((void value) => value)
        .catchError(onError)
        .whenComplete(() => logger.fine('signOut::success'));
  }

  CredentialsModel isUserAuthenticated() {
    logger.fine(
        'isUserAuthenticated::${_dataProvider.isUserAuthenticated() != null}');
    return _dataProvider.isUserAuthenticated();
  }

  void onError(Object e) {
    logger.severe(e);
    throw e;
  }
}
