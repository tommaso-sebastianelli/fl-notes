import 'package:flutter/material.dart';

enum NoteType { text, audio, draw }

class NoteModel {
  NoteModel({this.id, this.type, this.title, this.color, this.body});

  @required
  final int id;
  @required
  final NoteType type;
  final String title;
  @required
  final String body;
  final String color;
}
