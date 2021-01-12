import 'package:fl_notes/blocs/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardSnackBarWrapper extends StatelessWidget {
  const BoardSnackBarWrapper({this.child}) : super();

  final Widget child;

  @override
  Widget build(BuildContext _context) {
    return BlocListener<NotesBloc, NotesState>(
      listenWhen: (NotesState previous, NotesState current) =>
          previous.error != current.error,
      listener: (BuildContext context, NotesState state) => {
        if (state.error)
          {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text('TODO'
                  //(AppLocalizations.of(context).notesError).toString()
                  ),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'TODO',
                onPressed: () {},
              ),
              // TODO
            ))
          }
        else
          {Scaffold.of(context).hideCurrentSnackBar()}
      },
      child: child,
    );
  }
}
