import 'package:equatable/equatable.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NoteEditorEventType {
  save,
}

class NoteEditorEvent {
  const NoteEditorEvent({this.modifiedNote, @required this.type});

  final NoteModel modifiedNote;
  final NoteEditorEventType type;
}

@immutable
abstract class NoteEditorState extends Equatable {
  const NoteEditorState({this.error, this.loading});
  final bool error;
  final bool loading;

  @override
  List<Object> get props => [error, loading];
}

class InitialNoteEditorState extends NoteEditorState {
  const InitialNoteEditorState()
      : super(
          error: false,
          loading: false,
        );
}

class NewNotesEditorState extends NoteEditorState {
  NewNotesEditorState(
    NoteEditorState oldState, {
    bool error,
    bool loading,
  }) : super(
            error: error ?? oldState.error,
            loading: loading ?? oldState.loading);
}

class NoteEditorBloc extends Bloc<NoteEditorEvent, NoteEditorState> {
  NoteEditorBloc(this.notesRepository) : super(const InitialNoteEditorState());

  NotesRepository notesRepository;

  @override
  Stream<NoteEditorState> mapEventToState(NoteEditorEvent event) async* {
    switch (event.type) {
      case NoteEditorEventType.save:
        {
          yield NewNotesEditorState(state, loading: true, error: false);
          NoteModel data = await notesRepository.save(event.modifiedNote);
          if (data != null) {
            yield NewNotesEditorState(state, loading: false, error: false);
          } else {
            yield NewNotesEditorState(state, loading: false, error: false);
          }
          break;
        }
    }
  }
}
