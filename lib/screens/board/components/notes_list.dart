import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/screens/board/components/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardNotesList extends StatelessWidget {
  const BoardNotesList({this.localizedContext}) : super();

  final BuildContext localizedContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Center(
        child: Column(children: [
          BlocBuilder<NotesBloc, NotesState>(
              buildWhen: (NotesState previous, NotesState current) =>
                  previous.data.length != current.data.length,
              builder: (BuildContext context, NotesState state) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Note(state.data.elementAt(index));
                    });
              })
        ]),
      ),
    );
  }
}
