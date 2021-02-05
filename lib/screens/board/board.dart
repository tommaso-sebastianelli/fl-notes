import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/components/message.dart';
import 'package:fl_notes/screens/board/components/fab.dart';
import 'package:fl_notes/screens/board/components/notes_list.dart';
import 'package:fl_notes/screens/board/components/snackbar.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Board extends StatefulWidget {
  const Board({Key key}) : super(key: key);

  static const String routeName = '/board';

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(NotesEvent.list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BoardSnackBarWrapper(
            localizedContext: context,
            child: Center(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: BlocBuilder<NotesBloc, NotesState>(
                      builder: (BuildContext context, NotesState state) {
                    if (state.loading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[CircularProgressIndicator()],
                      );
                    }
                    if (state.data.isEmpty) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Message(
                                icon: Icons.notes,
                                text: AppLocalizations.of(context)
                                    .notesEmpty
                                    .toString()),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: 200,
                                child: Text(
                                    AppLocalizations.of(context)
                                        .notesEmptyHint
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54)),
                              ),
                            ),
                          ]);
                    }
                    return FloatingSearchBar(children: <Widget>[
                      BoardNotesList(
                        localizedContext: context,
                      )
                    ]);
                  })),
            )),
      ),
      floatingActionButton: const BoardFAB(),
    );
  }
}
