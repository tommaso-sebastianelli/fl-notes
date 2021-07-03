import 'package:firebase_core/firebase_core.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/data/abstract_api.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/models/credentials.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logging/logging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi extends API {
  FirebaseApi() {
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
  Future<List<NoteModel>> list(
      {NotesFilter filter = const NotesFilter(''),
      bool includeDeleted = false}) async {
    List<NoteModel> response = [];

    await dbRef
        .child(notesPath)
        .child(userId)
        .orderByChild('created')
        .once()
        .then((snapshot) => {
              if (snapshot != null)
                {
                  (snapshot.value)?.forEach((key, value) {
                    value['id'] = key;
                    try {
                      NoteModel note =
                          NoteModel.fromJson(value as Map<dynamic, dynamic>);
                      if (!includeDeleted && note.deleted != null) {
                        return;
                      }
                      response.add(note);
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

    if (filter.contains.isNotEmpty) {
      response = response
          .where((element) =>
              element.title
                  .toLowerCase()
                  .contains(filter.contains.toLowerCase()) ||
              element.body
                  .toLowerCase()
                  .contains(filter.contains.toLowerCase()))
          .toList();
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
  Future<CredentialsModel> signIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential cred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return Future<CredentialsModel>.delayed(
        const Duration(seconds: 2),
        () => CredentialsModel(
            id: cred.user.uid,
            name: cred.user.displayName,
            email: cred.user.email,
            photoUrl: cred.user.photoURL,
            token: cred.credential.token));
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
