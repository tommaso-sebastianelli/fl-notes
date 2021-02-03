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
      child: Column(children: [
        BlocBuilder<NotesBloc, NotesState>(
            builder: (BuildContext context, NotesState state) {
          return Padding(
              padding: EdgeInsets.all(16), child: Text('notes should go here'));
        })
      ]),
    );
  }
}
