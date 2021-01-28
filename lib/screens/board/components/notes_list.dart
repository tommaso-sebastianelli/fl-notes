import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/components/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BoardNotesList extends StatelessWidget {
  const BoardNotesList({this.localizedContext}) : super();

  final BuildContext localizedContext;

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
            if (state.data.isEmpty) {
              return Message(
                  icon: Icons.notes,
                  text: AppLocalizations.of(localizedContext)
                      .notesEmpty
                      .toString());
            }
            return Expanded(
                child: Column(
              children: <Widget>[
                const Text('notes Should go here'), // TODO
              ],
            ));
          })
        ],
      ),
    );
  }
}
