import 'package:flutter/material.dart';

enum NoteType { text, audio, draw }

class NoteModel {
  NoteModel({this.id, this.type, this.title, this.color, this.body});

  NoteModel.fromNote(NoteModel model) {
    id = model.id;
    body = model.body;
    title = model.title;
    color = model.color;
    type = model.type;
  }

  NoteModel.empty() {
    id = -1;
    body = '';
    title = '';
    color = '';
    type = NoteType.text;
  }

  @required
  int id;
  @required
  NoteType type;
  String title;
  @required
  String body;
  String color;
  DateTime created;
  DateTime edited;
}
