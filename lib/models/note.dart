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
    id = null;
    body = '';
    title = '';
    color = '';
    type = NoteType.text;
  }

  NoteModel.fromJson(Map json)
      : id = json['id'] as String,
        body = json['body'] as String,
        title = json['title'] as String,
        color = json['color'] as String,
        type = NoteType.values[json['type'] as int],
        created = DateTime.fromMillisecondsSinceEpoch(json['created'] as int),
        edited = json['edited'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['edited'] as int)
            : null,
        deleted = json['deleted'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['deleted'] as int)
            : null;

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'type': type?.index ?? 0,
        'title': title,
        'color': color,
        'body': body,
        'created':
            created is DateTime ? created?.millisecondsSinceEpoch : created,
        'edited': edited is DateTime ? edited?.millisecondsSinceEpoch : edited,
        'deleted':
            deleted is DateTime ? deleted?.millisecondsSinceEpoch : deleted
      };

  @required
  String id;
  @required
  NoteType type;
  String title;
  @required
  String body;
  String color;
  dynamic created;
  dynamic edited;
  dynamic deleted;

  @override
  List<Object> get props =>
      [id, type, title, body, color, created, edited, deleted];
}
