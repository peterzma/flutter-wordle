import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

class Board extends StatelessWidget {
  const Board({ 
    Key? key, 
    required this.board
  }) : super(key: key);

  final List<Word> board;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}