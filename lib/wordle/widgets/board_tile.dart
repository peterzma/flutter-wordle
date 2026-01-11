import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

class BoardTile extends StatelessWidget {
  const BoardTile({
    Key? key,
    required this.letter,
    this.initialBorderColor = const Color(0xFF3A3A3C), 
  }) : super (key: key);

  final Letter letter;
  final Color initialBorderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      height: 62,
      width: 62,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: letter.backgroundColor,
        border: Border.all(
          color: letter.val.isEmpty ? initialBorderColor : letter.borderColor,
          width: 2,
        ),
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