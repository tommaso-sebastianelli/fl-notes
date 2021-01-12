import 'package:fl_notes/blocs/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return const FloatingActionButton(
              onPressed: null, child: Icon(Icons.add));
        });
  }
}
