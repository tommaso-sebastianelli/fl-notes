import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/models/note.dart';
import 'package:fl_notes/screens/editor/editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BoardFAB extends StatelessWidget {
  const BoardFAB() : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
        buildWhen: (NotesState previous, NotesState current) =>
            previous.loading != current.loading,
        builder: (BuildContext context, NotesState state) {
          if (state.loading) {
            return Container();
          }
          return GestureDetector(
              onTap: () => /* Navigator.pushNamed(context, Editor.routeName) */
                  showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) => SingleChildScrollView(
                      controller: ModalScrollController.of(context),
                      child: Editor(NoteModel.empty()),
                    ),
                  ),
              child: const FloatingActionButton(
                  onPressed: null, child: Icon(Icons.edit)));
        });
  }
}
