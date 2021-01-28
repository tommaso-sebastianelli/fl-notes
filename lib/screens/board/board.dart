import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/screens/board/components/fab.dart';
import 'package:fl_notes/screens/board/components/notes_list.dart';
import 'package:fl_notes/screens/board/components/snackbar.dart';
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
    context.read<NotesBloc>().add(NotesEvent.list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(FlutterConfig.get('LABEL').toString()),
      // ),
      body: BoardSnackBarWrapper(
          localizedContext: context,
          child: BoardNotesList(localizedContext: context)),
      floatingActionButton: const BoardFAB(),
    );
  }
}
