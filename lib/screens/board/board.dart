import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/screens/board/components/fab.dart';
import 'package:fl_notes/screens/board/components/notes_list.dart';
import 'package:fl_notes/screens/board/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';

class Board extends StatefulWidget {
  const Board({Key key}) : super(key: key);

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
  Widget build(BuildContext _context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(FlutterConfig.get('LABEL').toString()),
        ),
        body: const BoardSnackBarWrapper(child: BoardNotesList()),
        floatingActionButton: const BoardFAB(),
      ),
    );
  }
}
