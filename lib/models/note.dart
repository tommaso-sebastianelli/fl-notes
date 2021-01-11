import 'package:flutter/material.dart';

enum NoteType { text, audio, draw }

class Note {
  Note({this.id, this.type, this.title, this.color, this.body});

  @required
  final String id;
  @required
  final NoteType type;
  final String title;
  final String body;
  final String color;
}
