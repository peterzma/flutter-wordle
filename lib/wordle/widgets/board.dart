import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

class Board extends StatelessWidget {
  const Board({ 
    Key? key, 
    required this.board
    required this.flipCardKeys,
  }) : super(key: key);

  final List<Word> board;

  final List<List<GlobalKey<FlipCardState>>> flipCardKeys;

  @override
  Widget build(BuildContext context) {
    // six rows and column
    return Column(
      children: board
          .asMap()
          .map(
            (i, word) => MapEntry(
              i,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: word.letters
                    .asMap()
                    .map(
                      (j, letter) => MapEntry(j, BoardTile(letter: letter)),
                    )
                    .values
                    .toList(),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}