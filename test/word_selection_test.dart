import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Higher chance of an unique word', () {
    List<String> userSolved = ['ATOMS', 'CELLS', 'GENES'];
    List<String> results = [];

    for (int i = 0; i < 100; i++) {
      results.add(WordRepository.getNextWord(
        disciplineId: 'science',
        length: 5,
        userSolvedWords: userSolved,
      ));
    }

    int repeats = results.where((w) => userSolved.contains(w)).length;
    print('Out of 100 games, $repeats were repeats and ${100 - repeats} were new.');
    
    // You should see roughly 20 repeats and 80 new words
    expect(repeats, lessThan(30)); 
  });

  test('Handles edge case 100% completion', () {
  // Mock a user who has solved everything in the small test list
  final allScienceWords = WordRepository.getWordsForLength(5);
  
  final result = WordRepository.getNextWord(
    disciplineId: 'science',
    length: 5,
    userSolvedWords: allScienceWords,
  );

  // It should still return a word (a repeat), not an error or null
  expect(result, isNotNull);
  expect(allScienceWords.contains(result), isTrue);
  print('Completion Test: Picked "${result}" from a fully mastered list.');
});
}