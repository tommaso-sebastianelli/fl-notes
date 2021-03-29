import 'package:fl_notes/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Editor extends StatefulWidget {
  const Editor(this.data) : super();

  static const String routeName = '/editor';
  final NoteModel data;

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  NoteModel data;
  TextEditingController titleController;
  TextEditingController bodyController;
  @override
  void initState() {
    data = widget.data;
    titleController = TextEditingController.fromValue(
        TextEditingValue(text: widget.data.title ?? ''));
    bodyController = TextEditingController.fromValue(
        TextEditingValue(text: widget.data.body.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //     home: Scaffold(
    //         backgroundColor: Colors.white,
    //         extendBody: true,
    //         appBar: AppBar(
    //           // title: const Text('New Note'),
    //           backgroundColor: Colors.white,
    //           toolbarHeight: 50,

    //           actions: <Widget>[
    //             FlatButton(
    //                 onPressed: () {
    //                   // TODO
    //                 },
    //                 child: ButtonBar(
    //                   children: [
    //                     Text(
    //                       AppLocalizations.of(context)
    //                           .genericSave
    //                           .toString()
    //                           .toUpperCase(),
    //                     ),
    //                   ],
    //                 ))
    //           ],
    //         ),
    //         body: SafeArea(
    //             child: Padding(
    //           padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    //           child: Column(
    //             children: [
    //               Flexible(
    //                 flex: 0,
    //                 child: TextField(
    //                   controller: titleController,
    //                   style: TextStyle(fontSize: 28),
    //                   maxLength: 50,
    //                   decoration: InputDecoration.collapsed(
    //                       hintText: AppLocalizations.of(context)
    //                           .editorTitleHint
    //                           .toString()),
    //                 ),
    //               ),
    //               Flexible(
    //                   child: TextField(
    //                 controller: bodyController,
    //                 decoration: InputDecoration.collapsed(
    //                     hintText: AppLocalizations.of(context)
    //                         .editorBodyHint
    //                         .toString()),
    //                 style: const TextStyle(fontSize: 22),
    //                 maxLines: null,
    //               ))
    //             ],
    //           ),
    //         ))));
    return DecoratedBox(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 16, color: Colors.grey, spreadRadius: 2)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.85,
            maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 4, 22, 8),
          child: Column(children: [
            Flexible(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLocalizations.of(context)
                            .genericCancel
                            .toString()
                            .toUpperCase()))
                  ],
                )),
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(fontSize: 28),
                  // maxLength: 50,
                  decoration: InputDecoration.collapsed(
                      hintText: AppLocalizations.of(context)
                          .editorTitleHint
                          .toString()),
                ),
              ),
            ),
            Flexible(
                child: TextField(
              controller: bodyController,
              decoration: InputDecoration.collapsed(
                  hintText:
                      AppLocalizations.of(context).editorBodyHint.toString()),
              style: const TextStyle(fontSize: 22),
              maxLines: null,
            ))
          ]),
        ),
      ),
    );
  }
}
