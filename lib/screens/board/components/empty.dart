import 'package:flutter/material.dart';

@immutable
class Empty extends StatelessWidget {
  const Empty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.notes, color: Colors.grey, size: 32.0),
        const Text(
          'No notes yet', // TODO: add i18n
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }
}
