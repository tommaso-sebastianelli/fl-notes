import 'package:fl_notes/models/note.dart';
import 'package:logging/logging.dart';
import 'package:fl_notes/blocs/notes.dart';

abstract class NotesProvider {
  Future<List<NoteModel>> list({NotesFilter filter});
  Future<NoteModel> save(NoteModel note);
  Future<NoteModel> delete(NoteModel note);
  Future<NoteModel> restore(NoteModel note);
  String getId();
}

class NotesRepository {
  NotesRepository(this._dataProvider);

  Logger logger = Logger('NotesRepository');
  final NotesProvider _dataProvider;

  Future<List<NoteModel>> list({NotesFilter filter}) {
    logger.fine('list::start');
    return _dataProvider
        .list(filter: filter)
        .then((List<NoteModel> value) => value)
        .catchError(onError)
        .whenComplete(() => logger.fine('list::success'));
  }

  Future<NoteModel> save(NoteModel note) {
    logger.fine('save::start $note');

    return _dataProvider
        .save(note)
        .catchError(onError)
        .whenComplete(() => logger.fine('save::success'));
  }

  Future<NoteModel> delete(NoteModel note) {
    logger.fine('delete::start $note');
    return _dataProvider
        .delete(note)
        .catchError(onError)
        .whenComplete(() => logger.fine('delete::success'));
  }

  Future<NoteModel> restore(NoteModel note) {
    logger.fine('restore::start $note');
    return _dataProvider
        .restore(note)
        .catchError(onError)
        .whenComplete(() => logger.fine('restore::success'));
  }

  String getId() {
    final String id = _dataProvider.getId();
    logger.fine('getId: $id');
    return id;
  }

  void onError(Object e) {
    logger.severe(e);
    throw e;
  }
}
