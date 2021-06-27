import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:fl_notes/data/abstract_api.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/screens/board/components/note.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_database/firebase_database.dart';

final String dbURL = FlutterConfig.get('DB_URL').toString();
const String notesPath = 'notes';

class DevApi extends API {
  @override
  Future<NoteModel> delete(NoteModel note) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> list() async {
    final DatabaseReference dbRef =
        FirebaseDatabase(app: Firebase.app(), databaseURL: dbURL).reference();
    List<NoteModel> response;

    await dbRef.child(notesPath).once().then((snapshot) => {
          if (snapshot != null)
            {
              response = (snapshot.value as List)
                  .map((item) =>
                      NoteModel.fromJson(item as Map<dynamic, dynamic>))
                  .toList()
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
  Future<NoteModel> restore(NoteModel note) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  Future<NoteModel> save(NoteModel note) {
    // TODO: implement save
    throw UnimplementedError();
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
  // TODO
}
