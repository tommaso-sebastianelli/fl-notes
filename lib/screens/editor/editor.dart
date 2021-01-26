import 'package:fl_notes/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Editor extends StatelessWidget {
  const Editor({this.data}) : super();

  static const String routeName = '/editor';
  final Note data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            extendBody: true,
            appBar: AppBar(
              // title: const Text('New Note'),
              backgroundColor: Colors.white,
              toolbarHeight: 50,

              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    // TODO
                  },
                  child: Text(
                    AppLocalizations.of(context)
                        .genericSave
                        .toString()
                        .toUpperCase(),
                  ),
                )
              ],
            ),
            body: SafeArea(
                child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(fontSize: 28),
                      maxLength: 50,
                      decoration: InputDecoration.collapsed(
                          hintText: AppLocalizations.of(context)
                              .editorTitleHint
                              .toString()),
                    ),
                    TextField(
                      maxLines: 8,
                      decoration: InputDecoration.collapsed(
                          hintText: AppLocalizations.of(context)
                              .editorBodyHint
                              .toString()),
                    )
                  ],
                ),
              ),
            ]))));
  }
}
