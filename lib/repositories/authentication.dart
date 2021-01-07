import 'package:fl_notes/models/credentials.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logging/logging.dart';

abstract class AuthenticationDataProvider {
  Future<Credentials> signIn();
  Future<void> signOut();
}

class AuthenticationRepository {
  final AuthenticationDataProvider _dataProvider;
  final Logger logger = Logger("AuthenticationRepository");

  AuthenticationRepository(this._dataProvider);

  Future<Credentials> signIn() {
    return this
        ._dataProvider
        .signIn()
        .then((value) => value)
        .catchError(onError);
  }

  Future<void> signOut() {
    return this
        ._dataProvider
        .signOut()
        .then((value) => value)
        .catchError(onError);
  }

  onError(Object e) {
    logger.severe(e);
    // throw (e);
  }
}
