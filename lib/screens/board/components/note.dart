import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/screens/editor/editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<Editor> _navigateAndDisplayEditor(
    BuildContext context, NoteModel data) async {
  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Editor(NoteModel.fromNote(data)),
    ),
  );
}

class Note extends StatefulWidget {
  const Note(this.data) : super();

  final NoteModel data;
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 150),
        child: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, Editor.routeName,
            //     arguments: <String, NoteModel>{
            //       'data': NoteModel.fromNote(widget.data)
            //     });
            _navigateAndDisplayEditor(context, widget.data);
          },
          child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: BlocBuilder<NotesBloc, NotesState>(
                      buildWhen: (NotesState previous, NotesState current) =>
                          current.lastSavedNote?.id == widget.data.id,
                      builder: (BuildContext context, NotesState state) {
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            if (widget.data.title != null &&
                                widget.data.title.length > 0)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  widget.data?.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            Text(
                              widget.data?.body,
                              maxLines: 5,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.black54),
                            )
                          ],
                        );
                      }))),
        ));
  }
}
