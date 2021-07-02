import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  group('NotesBloc', () {
    final NotesRepository notesRepository = MockNotesRepository();
    NotesBloc notesBloc;

    setUp(() {
      notesBloc = NotesBloc(notesRepository);
    });

    tearDown(() {
      notesBloc?.close();
    });

    test('initial state check', () {
      expect(notesBloc.state, InitialNotesState());
    });

    test('should return a list of notes', () {
      final InitialNotesState oldState = InitialNotesState();

      final List<NoteModel> mockNoteSet = <NoteModel>[
        NoteModel(id: '598717278', type: NoteType.text, body: 'note 0'),
        NoteModel(id: '604946528', type: NoteType.text, body: 'note 1')
      ];

      final List<NewNotesState> expected = [
        NewNotesState(oldState, loading: true, error: false),
        NewNotesState(oldState, loading: false, data: mockNoteSet),
      ];

      when(notesRepository.list(filter: const NotesFilter('')))
          .thenAnswer((_) => Future<List<NoteModel>>.value(mockNoteSet));

      expectLater(
        notesBloc,
        emitsInOrder(expected),
      );

      notesBloc.add(const NotesEvent(type: NotesEventType.list));
    });
  });
}
