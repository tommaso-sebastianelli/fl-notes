import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum NoteType { text, audio, draw }

class NoteModel extends Equatable {
  NoteModel(
      {this.id,
      this.type,
      this.title,
      this.color,
      this.body,
      this.created,
      this.edited,
      this.deleted});

  NoteModel.fromNote(NoteModel model) {
    id = model.id;
    body = model.body;
    title = model.title;
    color = model.color;
    type = model.type;
    created = model.created;
    edited = model.edited;
    deleted = model.deleted;
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
  DateTime deleted;

  @override
  List<Object> get props =>
      [id, type, title, body, color, created, edited, deleted];
}
