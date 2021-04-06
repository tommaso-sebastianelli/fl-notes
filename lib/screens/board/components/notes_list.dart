import 'dart:ui';

import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/components/message.dart';
import 'package:fl_notes/screens/board/components/note.dart';
import 'package:fl_notes/screens/board/components/note_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeleton_text/skeleton_text.dart';
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
            BlocBuilder<NotesBloc, NotesState>(
                buildWhen: (previous, current) =>
                    previous.data?.length != current.data?.length,
                builder: (BuildContext context, NotesState state) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.loading ? 4 : state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BlocBuilder<NotesBloc, NotesState>(
                            buildWhen: (previous, current) =>
                                previous.loading != current.loading ||
                                previous.data.elementAt(index) !=
                                    current.data.elementAt(index),
                            builder: (BuildContext context, NotesState state) {
                              return state.loading && state.lastDataSync == null
                                  ? (const NoteSkeleton())
                                  : state.data.elementAt(index).deleted == null
                                      ? Note(state.data.elementAt(index))
                                      : Container();
                            });
                      });
                })
          ],
        );
      }),
    );
  }
}
