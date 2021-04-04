import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Message extends StatelessWidget {
  const Message({this.icon, this.title, this.subtitle}) : super();

  @required
  final IconData icon;
  @required
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null)
          Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(icon, color: Colors.grey, size: 64.0))
        else
          Container(),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 32),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 200,
              child: Text(subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38)),
            ),
          )
        else
          Container(),
      ],
    );
  }
}
