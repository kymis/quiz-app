import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  final String text;
  const PaddedText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(text, textScaleFactor: 3),
    );
  }
}