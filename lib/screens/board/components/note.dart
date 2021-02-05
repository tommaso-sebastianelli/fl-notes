import 'package:fl_notes/models/note.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  const Note(this.data) : super();

  final NoteModel data;
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 150),
        child: Card(
            color: Colors.yellow[200],
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (widget.data.title != null && widget.data.title.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        widget.data?.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  Text(
                    widget.data?.body,
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 22, color: Colors.black54),
                  )
                ],
              ),
            )));
  }
}
