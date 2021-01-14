import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@immutable
class Empty extends StatelessWidget {
  const Empty({this.localizedContext}) : super();

  final BuildContext localizedContext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.notes, color: Colors.grey, size: 32.0),
        Text(
          AppLocalizations.of(localizedContext).notesEmpty.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }
}
