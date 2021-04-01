import 'dart:async';

import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Editor extends StatefulWidget {
  const Editor(this.data) : super();

  static const String routeName = '/editor';
  final NoteModel data;

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  NoteModel data;
  TextEditingController titleController;
  TextEditingController bodyController;
  Timer _debounce;

  static const int debounceTime = 700;

  void _onTextFieldValueChange() {
    final NoteModel note = context.read<NotesBloc>().state?.editingNote;
    print('Editing note ID: ${note.id}');
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: debounceTime), () {
      final NoteModel editingNote = NoteModel.fromNote(note ?? data);
      // For some reason _onTextFieldValueChange is also triggered on focus
      if (titleController.text == editingNote.title &&
          bodyController.text == editingNote.body) {
        return;
      }
      editingNote.title = titleController.text;
      editingNote.body = bodyController.text;
      editingNote.id = note.id;
      // For some reason onTextFieldValueChange is triggered on new notes open
      if (titleController.text.isEmpty &&
          editingNote.body.isEmpty &&
          data.id < 0) {
        return;
      }
      context
          .read<NotesBloc>()
          .add(NotesEvent(type: NotesEventType.save, editingNote: editingNote));
    });
  }

  @override
  void initState() {
    data = widget.data;
    titleController = TextEditingController.fromValue(
        TextEditingValue(text: widget.data.title ?? ''));
    titleController.addListener(_onTextFieldValueChange);
    bodyController = TextEditingController.fromValue(
        TextEditingValue(text: widget.data.body.toString()));
    bodyController.addListener(_onTextFieldValueChange);
    context
        .read<NotesBloc>()
        .add(NotesEvent(type: NotesEventType.editing, editingNote: data));

    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    titleController.removeListener(_onTextFieldValueChange);
    bodyController.removeListener(_onTextFieldValueChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 16, color: Colors.grey, spreadRadius: 2)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.85,
            maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 4, 22, 8),
          child: Column(children: [
            Flexible(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<NotesBloc, NotesState>(
                        builder: (BuildContext context, NotesState state) {
                      if (state.saving) {
                        return Text(AppLocalizations.of(context)
                            .editorSaving
                            .toString());
                      } else if (state?.editingNote?.created != null) {
                        return Text(
                          AppLocalizations.of(context)
                                  .editorLastSaved
                                  .toString() +
                              DateFormat(' dd/MM/yy, H:m:s').format(
                                  state.editingNote?.edited ??
                                      state.editingNote?.created),
                          style: const TextStyle(
                              color: Colors.black38, decorationThickness: 5.0),
                        );
                      } else {
                        return const Text('');
                      }
                    }),
                    BlocBuilder<NotesBloc, NotesState>(
                        builder: (BuildContext context, NotesState state) {
                      if (state.editingNote?.created != null) {
                        return TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(AppLocalizations.of(context)
                                .genericDelete
                                .toString()));
                      } else {
                        return TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(AppLocalizations.of(context)
                                .genericCancel
                                .toString()));
                      }
                    }),
                  ],
                )),
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(fontSize: 28),
                  // maxLength: 50,
                  decoration: InputDecoration.collapsed(
                      hintText: AppLocalizations.of(context)
                          .editorTitleHint
                          .toString()),
                ),
              ),
            ),
            Flexible(
                child: TextField(
              controller: bodyController,
              decoration: InputDecoration.collapsed(
                  hintText:
                      AppLocalizations.of(context).editorBodyHint.toString()),
              style: const TextStyle(fontSize: 22),
              maxLines: null,
            ))
          ]),
        ),
      ),
    );
  }
}
