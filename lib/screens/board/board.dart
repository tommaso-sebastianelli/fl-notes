import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/screens/board/components/fab.dart';
import 'package:fl_notes/screens/board/components/notes_list.dart';
import 'package:fl_notes/screens/board/components/snackbar.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<NotesBloc>().add(const NotesEvent(type: NotesEventType.list));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: BoardSnackBarWrapper(
              localizedContext: context,
              child: Center(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: BlocBuilder<NotesBloc, NotesState>(
                        builder: (BuildContext context, NotesState state) {
                      return FloatingSearchBar(pinned: true, children: <Widget>[
                        BoardNotesList(
                          localizedContext: context,
                        )
                      ]);
                    })),
              )),
        ),
        floatingActionButton: const BoardFAB(),
      ),
    );
  }
}
