import 'package:fl_notes/models/credentials.dart';
import 'package:fl_notes/models/note.dart';

import 'abstract_api.dart';

List<NoteModel> notes = [
  NoteModel(
      id: 0,
      title: 'title 1',
      // ignore: lines_longer_than_80_chars
      body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus bibendum, lorem nec convallis tincidunt, sem nulla efficitur purus, sit amet eleifend arcu neque nec nibh. Morbi quis risus posuere, sagittis sapien et, efficitur leo. Nullam dictum, orci at posuere vehicula, nisl nisi feugiat nisl, quis lobortis nulla ipsum vitae velit. Nulla quis maximus ante. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent id aliquam nulla. Aliquam congue auctor scelerisque. Pellentesque convallis ante ut eros aliquam elementum. Fusce faucibus sagittis lorem, vel consequat dolor mattis a. Etiam varius consectetur sem eu elementum. Aliquam gravida ex in sapien blandit, nec lobortis metus consectetur. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' +
          // ignore: lines_longer_than_80_chars
          'Donec condimentum accumsan enim, vitae semper purus. Nulla ex augue, malesuada eu fringilla in, lobortis eu metus. Nulla sed nibh dolor. Nullam commodo ut turpis sed feugiat. Nam vitae eleifend nibh. In quis bibendum turpis. Aliquam tellus lectus, sodales quis pellentesque vitae, accumsan id massa. Etiam maximus odio euismod imperdiet dapibus. Nunc lobortis ipsum ut ultricies egestas. Praesent quis elit vulputate, molestie nisl in, tristique dui. In hac habitasse platea dictumst. Nam et magna ante. Quisque gravida et tellus eget pulvinar. Phasellus tincidunt lacinia odio a suscipit. Pellentesque ultricies congue viverra. Donec sollicitudin finibus lobortis.',
      type: NoteType.text),
  NoteModel(id: 1, title: 'title 2', body: 'note 2', type: NoteType.text),
  NoteModel(id: 2, body: 'note 3', type: NoteType.text),
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
    final List<NoteModel> data = notes;
    // final Set<NoteModel> data = <NoteModel>{};
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
