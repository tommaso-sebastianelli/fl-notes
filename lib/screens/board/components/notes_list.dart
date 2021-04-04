import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/components/message.dart';
import 'package:fl_notes/screens/board/components/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'board_status.dart';

class BoardNotesList extends StatelessWidget {
  const BoardNotesList({this.localizedContext}) : super();

  final BuildContext localizedContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: BlocBuilder<NotesBloc, NotesState>(
          // buildWhen: (NotesState previous, NotesState current) =>
          //     previous.data.length != current.data.length,
          builder: (BuildContext context, NotesState state) {
        if (state.data.isEmpty && !state.loading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BoardStatusBar(),
              Padding(
                padding: const EdgeInsets.only(top: 128), // FIXME
                child: Message(
                  icon: Icons.notes,
                  title: AppLocalizations.of(context).notesEmpty.toString(),
                  subtitle:
                      AppLocalizations.of(context).notesEmptyHint.toString(),
                ),
              )
            ],
          );
        }
        return Column(
          children: [
            const BoardStatusBar(),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Note(state.data.elementAt(index));
                })
          ],
        );
      }),
    );
  }
}
