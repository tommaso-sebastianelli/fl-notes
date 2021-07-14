import 'dart:async';

import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/screens/board/components/fab.dart';
import 'package:fl_notes/screens/board/components/notes_list.dart';
import 'package:fl_notes/screens/board/components/snackbar.dart';
import 'package:fl_notes/components/avatar.dart';
import 'package:fl_notes/screens/profile/profile.dart';
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
  Timer _debounce;
  static const int debounceTime = 700;

  TextEditingController searchFieldController =
      TextEditingController.fromValue(const TextEditingValue());

  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(const NotesEvent(type: NotesEventType.list));
  }

  void _onSearchBarChange(String value) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: debounceTime), () {
      context.read<NotesBloc>().add(
          NotesEvent(type: NotesEventType.filter, filter: NotesFilter(value)));
    });
  }

  void _onSearchBarClear() {
    searchFieldController.clear();
    _onSearchBarChange('');
  }

  void _openProfileModal() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12,
      barrierDismissible: true,
      barrierLabel: 'profile-modal',
      pageBuilder: (_, __, ___) => FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.75,
        heightFactor: 0.35,
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const Profile()),
      ),
    );
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
                    return FloatingSearchBar(
                        controller: searchFieldController,
                        trailing: state.filter.contains.isEmpty
                            ? Avatar(
                                onTap: _openProfileModal,
                              )
                            : IconButton(
                                icon: const Icon(Icons.cancel_outlined),
                                onPressed: _onSearchBarClear),
                        pinned: true,
                        onChanged: _onSearchBarChange,
                        children: <Widget>[
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
