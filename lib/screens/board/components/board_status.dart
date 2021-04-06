import 'package:fl_notes/blocs/notes.dart';
import 'package:fl_notes/screens/board/components/sync_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardStatusBar extends StatelessWidget {
  const BoardStatusBar({Key key}) : super(key: key);

  TextStyle getTexStyle() =>
      const TextStyle(fontWeight: FontWeight.w500, color: Colors.black38);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 30.0),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: BlocBuilder<NotesBloc, NotesState>(
              buildWhen: (previous, current) =>
                  previous.loading != current.loading ||
                  previous.data.length != current.data.length ||
                  previous.lastDataSync != current.lastDataSync,
              builder: (BuildContext context, NotesState state) {
                if (state.loading) {
                  return Row(
                    children: [
                      Text(
                        'Syncing...',
                        style: getTexStyle(),
                      )
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SyncStatus(state, getTexStyle()),
                    Text(
                      // ignore: lines_longer_than_80_chars
                      state.data.isNotEmpty
                          ? 'Notes: ${state.data.length}'
                          : '',
                      style: getTexStyle(),
                    ),
                  ],
                );
              })),
    );
  }
}
