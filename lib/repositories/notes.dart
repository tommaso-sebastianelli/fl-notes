import 'package:fl_notes/models/note.dart';
import 'package:logging/logging.dart';

abstract class NotesProvider {
  Future<List<NoteModel>> list();
  Future<NoteModel> save(NoteModel note);
}

class NotesRepository {
  NotesRepository(this._dataProvider);

  final NotesProvider _dataProvider;
  final Logger logger = Logger('AuthenticationRepository');

  Future<List<NoteModel>> list() {
    return _dataProvider
        .list()
        .then((List<NoteModel> value) => value)
        .catchError(onError);
  }

  Future<NoteModel> save(NoteModel note) {
    return _dataProvider.save(note).catchError(onError);
  }

  void onError(Object e) {
    logger.severe(e);
    // throw (e);
  }
}
