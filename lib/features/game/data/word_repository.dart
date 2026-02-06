import 'package:uniordle/shared/exports/game_exports.dart';
import 'dart:math';

import 'package:uniordle/features/game/data/possible_word/possible_5_letters.dart';
import 'package:uniordle/features/game/data/possible_word/possible_6_letters.dart';
import 'package:uniordle/features/game/data/possible_word/possible_7_letters.dart';

class WordRepository {
  static List<String> getWordsForLength(int length) {
    switch (length) {
      case 5:
        return possible5Letters;
      case 6:
        return possible6Letters;
      case 7:
        return possible7Letters;
      default:
        return [];
    }
  }

  static bool isValidWord(String word) {
    int length = word.length;
    List<String> validList = getWordsForLength(length);
    return validList.contains(word.toUpperCase());
  }

  static String getNextWord({
    required String majorId,
    required int length,
    required List<String> userSolvedWords,
  }) {
    final Map<int, List<String>>? majorMap =
        categorizedWords[majorId.toLowerCase()];
    final List<String> allWords = majorMap?[length] ?? [];

    if (allWords.isEmpty) return "ERROR";

    final List<String> unsolved = allWords
        .where((w) => !userSolvedWords.contains(w.toUpperCase()))
        .toList();

    final Random random = Random();

    final bool wantNew = random.nextDouble() < 0.8;

    if (wantNew && unsolved.isNotEmpty) {
      return unsolved[random.nextInt(unsolved.length)];
    }

    if (userSolvedWords.isNotEmpty) {
      final List<String> reviewPool = allWords
          .where((w) => userSolvedWords.contains(w.toUpperCase()))
          .toList();

      if (reviewPool.isNotEmpty) {
        return reviewPool[random.nextInt(reviewPool.length)];
      }
    }

    return allWords[random.nextInt(allWords.length)];
  }
}
