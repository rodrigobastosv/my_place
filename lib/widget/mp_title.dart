import 'package:flutter/material.dart';

class MPTitle extends StatelessWidget {
  final String text;

  const MPTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
