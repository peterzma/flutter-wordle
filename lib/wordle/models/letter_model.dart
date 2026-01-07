import 'package:equatable/equatable.dart';

enum LetterStatus { initial, notInWorld, inWord, correct }

class Letter extends Equatable {
  const Letter({
    required this.val,
  });

  final String val;
}