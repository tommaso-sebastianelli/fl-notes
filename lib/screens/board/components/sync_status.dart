import 'dart:async';

import 'package:fl_notes/blocs/notes.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class SyncStatus extends StatefulWidget {
  const SyncStatus(
    this.state,
    this.style,
  ) : super();

  final NotesState state;
  final TextStyle style;

  @override
  _SyncStatusState createState() => _SyncStatusState();
}

class _SyncStatusState extends State<SyncStatus> {
  Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      // ignore: lines_longer_than_80_chars
      'Updated ${timeago.format(widget.state.lastDataSync)}',
      style: widget.style,
    );
  }
}
