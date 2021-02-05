import 'package:fl_notes/models/note.dart';
import 'package:logging/logging.dart';

abstract class NotesProvider {
  Future<Set<NoteModel>> list();
}

class NotesRepository {
  NotesRepository(this._dataProvider);

  final NotesProvider _dataProvider;
  final Logger logger = Logger('AuthenticationRepository');

  Future<Set<NoteModel>> list() {
    return _dataProvider
        .list()
        .then((Set<NoteModel> value) => value)
        .catchError(onError);
  }

  void onError(Object e) {
    logger.severe(e);
    // throw (e);
  }
}
