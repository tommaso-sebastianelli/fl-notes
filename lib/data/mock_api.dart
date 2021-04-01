import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/models/note.dart';

import 'abstract_api.dart';

List<NoteModel> notes = [
  NoteModel(
      id: 0,
      // ignore: lines_longer_than_80_chars
      body: 'Buy groceries',
      type: NoteType.text,
      created: DateTime.fromMillisecondsSinceEpoch(1600134000000),
      edited: DateTime.fromMillisecondsSinceEpoch(1600134000000)),
  NoteModel(
      id: 1,
      title: 'Flutter',
      body:
          // ignore: lines_longer_than_80_chars
          'Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.',
      type: NoteType.text,
      created: DateTime.fromMillisecondsSinceEpoch(1609455600000),
      edited: DateTime.fromMillisecondsSinceEpoch(1609455600000)),
  NoteModel(
      id: 2,
      title: 'Welcome',
      body: 'This is my note app project made with Flutter',
      type: NoteType.text,
      created: DateTime.fromMillisecondsSinceEpoch(1614553200000),
      edited: DateTime.fromMillisecondsSinceEpoch(1614553200000)),
];

class MockApi extends API {
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
    return Future<void>.value();
  }

  @override
  Future<List<NoteModel>> list() {
    final List<NoteModel> data = notes.toList();
    data.sort((NoteModel a, NoteModel b) => b.created.compareTo(a.created));
    return Future<List<NoteModel>>.delayed(
        const Duration(seconds: 2), () => data);
  }

  @override
  Future<NoteModel> save(NoteModel note) {
    if (note.id < 0) {
      note.id = notes.length;
      note.created = DateTime.now();
      note.edited = DateTime.now();
      notes.add(note);
    } else {
      NoteModel item = notes.firstWhere(
          (NoteModel element) => element.id == note.id,
          orElse: () => NoteModel.empty());
      item.title = note.title;
      item.body = note.body;
      item.edited = DateTime.now();
    }

    return Future.delayed(Duration(seconds: 1), () => note);
  }
}
