import 'package:fl_notes/blocs/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class EditorHeader extends StatelessWidget {
  const EditorHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _delete() {
      context
          .read<NotesBloc>()
          .add(const NotesEvent(type: NotesEventType.delete));

      Navigator.pop(context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<NotesBloc, NotesState>(
            builder: (BuildContext context, NotesState state) {
          if (state.saving) {
            return Text(AppLocalizations.of(context).editorSaving.toString());
          } else if (state?.editingNote?.created != null) {
            return Text(
              AppLocalizations.of(context).editorLastSaved.toString() +
                  DateFormat(' dd/MM/yy, H:m:s').format(
                      state.editingNote?.edited ?? state.editingNote?.created),
              style: const TextStyle(
                  color: Colors.black38, decorationThickness: 5.0),
            );
          } else {
            return const Text('');
          }
        }),
        BlocBuilder<NotesBloc, NotesState>(
            builder: (BuildContext context, NotesState state) {
          if (state.editingNote?.created != null) {
            return TextButton(
                onPressed: () => _delete(),
                child: Text(
                    AppLocalizations.of(context).genericDelete.toString()));
          } else {
            return TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                    AppLocalizations.of(context).genericCancel.toString()));
          }
        }),
      ],
    );
  }
}
