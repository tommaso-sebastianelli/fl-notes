import 'package:equatable/equatable.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

enum NotesEventType { list, save, editing, delete, restore, filter }

class NotesFilter {
  const NotesFilter(this.contains);

  final String contains;
}

class NotesEvent {
  const NotesEvent({@required this.type, this.editingNote, this.filter});

  final NoteModel editingNote;
  final NotesFilter filter;
  final NotesEventType type;
}

@immutable
abstract class NotesState extends Equatable {
  const NotesState({
    this.error,
    this.loading,
    this.data,
    this.saving,
    this.savingError,
    this.editingNote,
    this.lastDataSync,
    this.filter,
  });
  final List<NoteModel> data;
  final bool error;
  final bool loading;
  final bool saving;
  final bool savingError;
  final NoteModel editingNote;
  final DateTime lastDataSync;
  final NotesFilter filter;

  @override
  List<Object> get props =>
      [error, loading, data, saving, savingError, editingNote, filter];
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
          lastDataSync: null,
          filter: const NotesFilter(''),
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
    DateTime lastDataSync,
    NotesFilter filter,
  }) : super(
          data: data ?? oldState.data,
          error: error ?? oldState.error,
          loading: loading ?? oldState.loading,
          saving: saving ?? oldState.saving,
          savingError: savingError ?? oldState.savingError,
          editingNote: editingNote ?? oldState.editingNote,
          lastDataSync: lastDataSync ?? oldState.lastDataSync,
          filter: filter ?? oldState.filter,
        );
}

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc(this.notesRepository) : super(InitialNotesState());

  NotesRepository notesRepository;
  Logger logger = Logger('NotesBloc');

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    logger.fine('new event: ${event.type}');
    switch (event.type) {
      case NotesEventType.list:
        {
          yield NewNotesState(state, loading: true, error: false);

          try {
            final List<NoteModel> data =
                await notesRepository.list(filter: state.filter);

            yield NewNotesState(state,
                data: data,
                lastDataSync: DateTime.now(),
                loading: false,
                error: false);
          } on Exception catch (e) {
            logger.severe(e);
            yield NewNotesState(state, loading: false, error: true);
          }
          break;
        }
      case NotesEventType.save:
        {
          yield NewNotesState(state, saving: true, savingError: false);

          try {
            final NoteModel lastSavedNote =
                await notesRepository.save(event.editingNote);
            yield NewNotesState(state,
                saving: false, savingError: false, editingNote: lastSavedNote);
          } on Exception catch (e) {
            logger.severe(e);
            yield NewNotesState(state, saving: false, savingError: true);
          }
          add(const NotesEvent(type: NotesEventType.list));

          break;
        }
      case NotesEventType.editing:
        {
          event.editingNote.id ??= notesRepository.getNoteKey();
          yield NewNotesState(state, editingNote: event.editingNote);
        }
        break;
      case NotesEventType.delete:
        {
          try {
            final NoteModel deleted =
                await notesRepository.delete(state.editingNote);
            yield NewNotesState(state,
                editingNote: NoteModel.fromNote(deleted), saving: false);
          } on Exception catch (e) {
            logger.severe(e);
            yield NewNotesState(state, error: true, saving: false);
          }

          add(const NotesEvent(type: NotesEventType.list));
        }
        break;
      case NotesEventType.restore:
        {
          try {
            final NoteModel restored =
                await notesRepository.restore(state.editingNote);
            yield NewNotesState(state,
                editingNote: NoteModel.fromNote(restored));
          } on Exception catch (e) {
            logger.severe(e);
            yield NewNotesState(state, error: true);
          }

          add(const NotesEvent(type: NotesEventType.list));
        }
        break;
      case NotesEventType.filter:
        {
          yield NewNotesState(state, filter: event.filter);
          add(const NotesEvent(type: NotesEventType.list));
        }
        break;
    }
  }

  @override
  void onChange(Change<NotesState> change) {
    logger.fine('state change: $change');
    super.onChange(change);
  }
}
