import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Smart Selection prioritizes unsolved words', () {
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
}