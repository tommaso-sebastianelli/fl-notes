import 'package:firebase_core/firebase_core.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/abstract_api.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/models/credentials.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logging/logging.dart';

class DevApi extends API {
  DevApi() {
    dbRef =
        FirebaseDatabase(app: Firebase.app(), databaseURL: dbURL).reference();
    dbRef.keepSynced(true);

    logger = Logger('FirebaseAPI');
  }

  DatabaseReference dbRef;

  @override
  Future<NoteModel> delete(NoteModel note) async {
    final DatabaseReference postRef =
        dbRef.child(notesPath).child(userId).child(note.id);

    final TransactionResult transactionResult =
        await postRef.runTransaction((MutableData data) async {
      data.value['deleted'] = ServerValue.timestamp;

      return data;
    });

    final NoteModel data = NoteModel.fromJson(
        transactionResult?.dataSnapshot?.value as Map<dynamic, dynamic>);
    data.id = note.id;

    return Future.value(data);
  }

  @override
  Future<List<NoteModel>> list({NotesFilter filter}) async {
    final List<NoteModel> response = [];

    await dbRef.child(notesPath).child(userId).once().then((snapshot) => {
          if (snapshot != null)
            {
              (snapshot.value)?.forEach((key, value) {
                value['id'] = key;
                try {
                  response
                      .add(NoteModel.fromJson(value as Map<dynamic, dynamic>));
                } on Exception catch (e) {
                  // in case of bad saved data we oonly skip the faulty note
                  logger.severe(e);
                }
              })
            }
          else
            {throw NullThrownError()}
        });
    if (response == null) {
      throw Error();
    }

    return Future.value(response);
  }

  @override
  Future<NoteModel> restore(NoteModel note) async {
    final DatabaseReference postRef =
        dbRef.child(notesPath).child(userId).child(note.id);

    final TransactionResult transactionResult =
        await postRef.runTransaction((MutableData data) async {
      data.value['deleted'] = null;

      return data;
    });

    final NoteModel data = NoteModel.fromJson(
        transactionResult?.dataSnapshot?.value as Map<dynamic, dynamic>);
    data.id = note.id;

    return Future.value(data);
  }

  @override
  Future<NoteModel> save(NoteModel note) async {
    final DatabaseReference postRef =
        dbRef.child(notesPath).child(userId).child(note.id);

    final TransactionResult transactionResult =
        await postRef.runTransaction((MutableData data) async {
      data.value = NoteModel(
              body: note.body,
              color: note.color,
              title: note.title,
              type: note.type,
              created: note.created ?? ServerValue.timestamp,
              edited: ServerValue.timestamp,
              deleted: note.deleted)
          .toJson();

      return data;
    });

    final NoteModel data = NoteModel.fromJson(
        transactionResult?.dataSnapshot?.value as Map<dynamic, dynamic>);
    data.id = postRef.key.toString();

    return Future.value(data);
  }

  @override
  Future<CredentialsModel> signIn() {
    final CredentialsModel data = CredentialsModel(
        name: 'john_doe',
        email: 'john.doe.00@mail.com',
        id: '0',
        photoUrl: '',
        token: 'efhd7Gs8Hbd7jVnmoL');
    return Future<CredentialsModel>.delayed(
        const Duration(seconds: 2), () => data);
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  String getId() {
    DatabaseReference postRef = dbRef.child(notesPath).child(userId).push();
    return postRef.key.toString();
  }
}
