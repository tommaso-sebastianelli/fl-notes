import 'package:fl_notes/blocs/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BoardSnackBarWrapper extends StatelessWidget {
  const BoardSnackBarWrapper({this.child, this.localizedContext}) : super();

  final Widget child;
  final BuildContext localizedContext;

  @override
  Widget build(BuildContext _context) {
    return BlocListener<NotesBloc, NotesState>(
      listenWhen: (NotesState previous, NotesState current) =>
          previous.error != current.error ||
          previous.editingNote?.deleted != current.editingNote?.deleted,
      listener: (BuildContext context, NotesState state) => {
        if (state.error) // There was a problem on first load of data
          {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text((AppLocalizations.of(localizedContext).notesError)
                  .toString()),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: AppLocalizations.of(localizedContext)
                    .retry
                    .toString()
                    .toUpperCase(),
                onPressed: () {
                  context
                      .read<NotesBloc>()
                      .add(const NotesEvent(type: NotesEventType.list));
                },
              ),
            ))
          }
        else if (state.editingNote.deleted != null) // one note has been deleted
          {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text((AppLocalizations.of(localizedContext).notesDelete)
                  .toString()),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: AppLocalizations.of(localizedContext)
                    .genericUndo
                    .toString()
                    .toUpperCase(),
                onPressed: () {
                  context
                      .read<NotesBloc>()
                      .add(const NotesEvent(type: NotesEventType.restore));
                },
              ),
            ))
          }
        else
          {Scaffold.of(context).hideCurrentSnackBar()}
      },
      child: child,
    );
  }
}
