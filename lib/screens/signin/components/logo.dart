import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black38,
            blurRadius: 0.1,
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Colors.amber[200],
      ),
      child: const Padding(
          padding: EdgeInsets.all(22),
          child: Icon(
            Icons.edit,
            size: 75,
            color: Colors.black87,
          )),
    );
  }
}
