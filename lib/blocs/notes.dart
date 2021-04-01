import 'package:equatable/equatable.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NotesEventType {
  list,
  save,
  editing,
}

class NotesEvent {
  const NotesEvent({@required this.type, this.editingNote});

  final NoteModel editingNote;
  final NotesEventType type;
}

@immutable
abstract class NotesState extends Equatable {
  const NotesState(
      {this.error,
      this.loading,
      this.data,
      this.saving,
      this.savingError,
      this.editingNote});
  final List<NoteModel> data;
  final bool error;
  final bool loading;
  final bool saving;
  final bool savingError;
  final NoteModel editingNote;

  @override
  List<Object> get props =>
      [error, loading, data, saving, savingError, editingNote];
}

class InitialNotesState extends NotesState {
  InitialNotesState()
      : super(
          data: <NoteModel>[],
          error: false,
          loading: false,
          saving: false,
          savingError: false,
          editingNote: null,
        );
}

class NewNotesState extends NotesState {
  NewNotesState(
    NotesState oldState, {
    List<NoteModel> data,
    bool error,
    bool loading,
    bool saving,
    bool savingError,
    NoteModel editingNote,
  }) : super(
          data: data ?? oldState.data,
          error: error ?? oldState.error,
          loading: loading ?? oldState.loading,
          saving: saving ?? oldState.saving,
          savingError: savingError ?? oldState.savingError,
          editingNote: editingNote ?? oldState.editingNote,
        );
}

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc(this.notesRepository) : super(InitialNotesState());

  NotesRepository notesRepository;

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    switch (event.type) {
      case NotesEventType.list:
        {
          yield NewNotesState(state, loading: true, error: false);
          final List<NoteModel> data = await notesRepository.list();
          if (data != null) {
            yield NewNotesState(state,
                data: data, loading: false, error: false);
          } else {
            yield NewNotesState(state, loading: false, error: true);
          }
          break;
        }
      case NotesEventType.save:
        {
          yield NewNotesState(state, saving: true, savingError: false);
          final NoteModel lastSavedNote =
              await notesRepository.save(event.editingNote);
          print(lastSavedNote);
          if (lastSavedNote != null) {
            yield NewNotesState(
              state,
              saving: false,
              savingError: false,
              editingNote: lastSavedNote,
            );

            add(const NotesEvent(type: NotesEventType.list));
          } else {
            yield NewNotesState(state, saving: false, savingError: true);
          }
          break;
        }
      case NotesEventType.editing:
        {
          yield NewNotesState(state, editingNote: event.editingNote);
        }
        break;
    }
  }
}
