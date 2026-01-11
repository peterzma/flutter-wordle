import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

class BoardTile extends StatelessWidget {
  const BoardTile({
    Key? key,
    required this.letter,
  }) : super (key: key);

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 64,
      width: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: letter.backgroundColor,
        border: Border.all(color: letter.borderColor),
        borderRadius: BorderRadius.zero,
      ),
      // display letter values
      child: Center(
        child: Text(
          letter.val,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: -0.15, // ensures vertical centering
          ),
        ),
      ),
    );
  }
}