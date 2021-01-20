import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({this.icon, this.text}) : super();

  @required
  final IconData icon;
  @required
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Icon(icon, color: Colors.grey, size: 44.0)),
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }
}
