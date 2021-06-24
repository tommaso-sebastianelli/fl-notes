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

  NoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        body = json['body'] as String,
        title = json['title'] as String,
        color = json['color'] as String,
        type = json['type'] as NoteType,
        created = json['created'] as DateTime,
        edited = json['edited'] as DateTime,
        deleted = json['deleted'] as DateTime;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'color': color,
        'body': body,
        'created': created,
        'edited': edited,
        'delete': deleted
      };

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
