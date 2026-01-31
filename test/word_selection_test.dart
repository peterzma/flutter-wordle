import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Word Selection Logic:', () {
    test('Higher chance of an unique word', () {
      final List<String> userSolved = ['ATOMS', 'CELLS', 'GENES'];
      final List<String> results = [];

      for (int i = 0; i < 100; i++) {
        results.add(WordRepository.getNextWord(
          disciplineId: 'science',
          length: 5,
          userSolvedWords: userSolved,
        ));
      }

      final int repeats = results.where((w) => userSolved.contains(w.toUpperCase())).length;
      final int uniqueCount = results.length - repeats;

      expect(
        repeats, 
        lessThan(30), 
        reason: 'Selection logic should favor unique words (Found $uniqueCount unique vs $repeats repeats).',
      ); 
    });

    test('Handles edge case 100% completion', () {
      final allScienceWords = WordRepository.getWordsForLength(5);
      
      final result = WordRepository.getNextWord(
        disciplineId: 'science',
        length: 5,
        userSolvedWords: allScienceWords,
      );

      // Verify state without printing
      expect(result, isA<String>(), reason: 'Should return a valid String even when category is complete.');
      expect(result, isNotEmpty);
      expect(
        allScienceWords.contains(result.toUpperCase()), 
        isTrue, 
        reason: 'When 100% complete, the returned word must be a repeat from the existing library.',
      );
    });

    test('All disciplines have valid word lists', () {
    // Loop through every major ID you've registered
    for (final entry in categorizedWords.entries) {
      final String disciplineId = entry.key;
      final Map<int, List<String>> wordMap = entry.value;

      // Check 5, 6, and 7 letter categories
      for (int length in [5, 6, 7]) {
        final List<String>? wordList = wordMap[length];

        // Failure message if a list is missing or empty
        expect(
          wordList, 
          isNotNull, 
          reason: 'Major "$disciplineId" is missing the $length-letter word list.',
        );
        
        expect(
          wordList!.isNotEmpty, 
          isTrue, 
          reason: 'Major "$disciplineId" has an empty list for $length-letter words.',
        );

        // Ensure no empty strings sneaked into the lists
      expect(
        wordList.every((word) => word.trim().isNotEmpty),
        isTrue,
        reason: 'Major "$disciplineId" ($length letters) contains an empty string entry.',
      );
    }
  }
});
  });
}