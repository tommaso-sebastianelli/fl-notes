import 'package:equatable/equatable.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NotesEvent {
  list,
}

@immutable
abstract class NotesState extends Equatable {
  const NotesState({this.error, this.loading, this.data});
  final List<NoteModel> data;
  final bool error;
  final bool loading;

  @override
  List<Object> get props => [error, loading, data];
}

class InitialNotesState extends NotesState {
  InitialNotesState()
      : super(
          data: List<NoteModel>.empty(),
          error: false,
          loading: false,
        );
}

class NewNotesState extends NotesState {
  NewNotesState(
    NotesState oldState, {
    List<NoteModel> data,
    bool error,
    bool loading,
  }) : super(
            data: data ?? oldState.data,
            error: error ?? oldState.error,
            loading: loading ?? oldState.loading);
}

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc(this.notesRepository) : super(InitialNotesState());

  NotesRepository notesRepository;

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    switch (event) {
      case NotesEvent.list:
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
    }
  }
}
