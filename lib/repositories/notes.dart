import 'package:fl_notes/models/note.dart';
import 'package:logging/logging.dart';

abstract class NotesProvider {
  Future<List<Note>> list();
}

class NotesRepository {
  NotesRepository(this._dataProvider);

  final NotesProvider _dataProvider;
  final Logger logger = Logger('AuthenticationRepository');

  Future<List<Note>> list() {
    return _dataProvider
        .list()
        .then((List<Note> value) => value)
        .catchError(onError);
  }

  void onError(Object e) {
    logger.severe(e);
    // throw (e);
  }
}
