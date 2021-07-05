import 'dart:convert';

import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'abstract_api.dart';

class MockApi extends API {
  factory MockApi() {
    return _instance;
  }

  MockApi._privateConstructor() {}

  static final MockApi _instance = MockApi._privateConstructor();
  Logger logger = Logger('MockAPI');
  String _userId;

  @override
  Future<CredentialsModel> signIn() {
    final CredentialsModel data = CredentialsModel(
        name: 'john_doe',
        email: 'john.doe.00@mail.com',
        id: 'dev_user',
        photoUrl: '',
        token: 7246824910843085630);
    _userId = data.id;
    return Future<CredentialsModel>.delayed(
        const Duration(seconds: 2), () => data);
  }

  @override
  Future<void> signOut() {
    return Future<void>.value();
  }

  @override
  Future<List<NoteModel>> list(
      {NotesFilter filter = const NotesFilter(''),
      bool includeDeleted = false}) async {
    List<NoteModel> data = [];
    await http.get(Uri.parse('$dbURL$notesPath')).then(
        (value) => (jsonDecode(value.body)[getUserId()])?.forEach((key, value) {
              value['id'] = key;
              data.add(NoteModel.fromJson(value as Map<dynamic, dynamic>));
            }));

    if (!includeDeleted) {
      data = data.where((element) => element.deleted == null).toList();
    }
    if (filter.contains.isNotEmpty) {
      data = data
          .where((element) =>
              element.title
                  .toLowerCase()
                  .contains(filter.contains.toLowerCase()) ||
              element.body
                  .toLowerCase()
                  .contains(filter.contains.toLowerCase()))
          .toList();
    }

    data.sort((NoteModel a, NoteModel b) =>
        (b.created as DateTime).compareTo(a.created as DateTime));

    return Future<List<NoteModel>>.delayed(
        const Duration(seconds: 1), () => data);
  }

  @override
  Future<NoteModel> save(NoteModel note) async {
    final List<NoteModel> data = await list();
    NoteModel item;

    item = data.firstWhere((NoteModel element) => element.id == note.id,
        orElse: () => NoteModel.empty());
    item.id = note.id;
    item.title = note.title;
    item.body = note.body;
    item.created = item.created ?? DateTime.now();
    item.edited = DateTime.now();

    logger.fine(jsonEncode(item));

    if (!data.any((element) => element.id == item.id)) {
      data.add(item);
    }

    await updateSnapshot(data);

    return Future.delayed(Duration(seconds: 1), () => item);
  }

  @override
  Future<NoteModel> delete(NoteModel note) async {
    final List<NoteModel> data = await list();

    NoteModel item = data.firstWhere(
        (NoteModel element) => element.id == note.id,
        orElse: () => NoteModel.empty());
    item.deleted = DateTime.now();

    await updateSnapshot(data);

    return Future.delayed(const Duration(seconds: 1), () => item);
  }

  @override
  Future<NoteModel> restore(NoteModel note) async {
    final List<NoteModel> data = await list(includeDeleted: true);

    NoteModel item = data.firstWhere(
        (NoteModel element) => element.id == note.id,
        orElse: () => NoteModel.empty());
    item.deleted = null;

    await updateSnapshot(data);

    return Future.delayed(const Duration(seconds: 1), () => item);
  }

  Future<NoteModel> updateSnapshot(List<NoteModel> data) async {
    final buffer = {for (var e in data) e.id: e.toJson()};

    logger.fine('NEW DB SNAPSHOT---> ${jsonEncode({getUserId(): buffer})}\n');

    await http
        .post(Uri.parse('$dbURL$notesPath'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            body: jsonEncode({getUserId(): buffer}))
        .then((value) => logger
            .fine('UPDATE SNAPSHOT RESPONSE---> ${jsonDecode(value.body)}\n'))
        // item = NoteModel.fromJson(value as Map<dynamic, dynamic>))
        .catchError((e) => {throw Error()});
  }

  @override
  String getNoteKey() {
    return DateTime.now().toString();
  }

  @override
  String getUserId() {
    if (_userId == null) {
      throw NullThrownError();
    }
    return _userId;
  }
}
