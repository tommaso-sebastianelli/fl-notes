import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/models/note.dart';

import 'abstract_api.dart';

class MockApi extends API {
  @override
  Future<Credentials> signIn() {
    final Credentials data = Credentials(
        name: 'john_doe',
        email: 'john.doe.00@mail.com',
        id: '0',
        photoUrl: '',
        token: 'efhd7Gs8Hbd7jVnmoL');
    return Future<Credentials>.delayed(const Duration(seconds: 2), () => data);
  }

  @override
  Future<void> signOut() {
    return Future<void>.value();
  }

  @override
  Future<List<Note>> list() {
    // final List<Note> data = [
    //   Note(id: 0, body: 'test note 1', type: NoteType.text)
    // ];
    final List<Note> data = List<Note>.empty();
    return Future<List<Note>>.delayed(const Duration(seconds: 2), () => data);
  }
}
