import 'package:fl_notes/blocs/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'empty.dart';

class BoardNotesList extends StatelessWidget {
  const BoardNotesList() : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<NotesBloc, NotesState>(
              builder: (BuildContext context, NotesState state) {
            if (state.loading) {
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.data.isEmpty) const Empty(),
                if (state.data.isNotEmpty)
                  const Text('notes Should go here'), // TODO
              ],
            );
          })
        ],
      ),
    );
  }
}
