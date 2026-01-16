import 'package:uniordle/uniordle/uniordle.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';

enum GameStatus { playing, submitting, won, lost }

class UniordleController extends ChangeNotifier {

  final int wordLength;
  final int maxAttempts;
  final String disciplineId;
  final Function(bool won) onGameEnd;

  UniordleController({
    required this.wordLength,
    required this.maxAttempts,
    required this.disciplineId,
    required this.onGameEnd,
  }) {
    _initGame();
  }

  late List<Word> board;
  late List<List<GlobalKey<FlipCardState>>> flipCardKeys;
  late Word solution;
  int currentWordIndex = 0;
  GameStatus status = GameStatus.playing;
  final Set<Letter> keyboardLetters = {};

  void _initGame() {
    board = List.generate(maxAttempts, (_) => Word(letters: List.generate(wordLength, (_) => Letter.empty())));
    flipCardKeys = List.generate(maxAttempts, (_) => List.generate(wordLength, (_) => GlobalKey<FlipCardState>()));
    
    final disciplineLibrary = categorizedWords[disciplineId.toLowerCase()] ?? categorizedWords['engineering']!;
    final library = disciplineLibrary[wordLength] ?? disciplineLibrary[5]!;

    solution = Word.fromString(
      library[Random().nextInt(library.length)].toUpperCase(),
    );
  }

  Word? get currentWord => currentWordIndex < board.length ? board[currentWordIndex] : null;

  void addLetter(String val) {
    if (status == GameStatus.playing) {
      currentWord?.addLetter(val);
      notifyListeners();
    }
  }

  void removeLetter() {
    if (status == GameStatus.playing) {
      currentWord?.removeLetter();
      notifyListeners();
    }
  }

  Future<void> submitWord() async {
    if (status != GameStatus.playing || currentWord == null) return;
    if (currentWord!.letters.contains(Letter.empty())) return;

    status = GameStatus.submitting;
    notifyListeners();

    for (var i = 0; i < currentWord!.letters.length; i++) {
      final curLet = currentWord!.letters[i];
      
      LetterStatus finalStatus;
      if (curLet.val == solution.letters[i].val) {
        finalStatus = LetterStatus.correct;
      } else if (solution.letters.any((l) => l.val == curLet.val)) {
        finalStatus = LetterStatus.inWord;
      } else {
        finalStatus = LetterStatus.notInWord;
      }

      currentWord!.letters[i] = curLet.copyWith(status: finalStatus);
      _updateKeyboard(currentWord!.letters[i]);

      flipCardKeys[currentWordIndex][i].currentState?.toggleCard();
      await Future.delayed(const Duration(milliseconds: 70));
    }

    _checkResult();
  }

  void _updateKeyboard(Letter newLetter) {
    final existing = keyboardLetters.firstWhere((l) => l.val == newLetter.val, orElse: () => Letter.empty());
    if (existing.status != LetterStatus.correct) {
      keyboardLetters.removeWhere((l) => l.val == newLetter.val);
      keyboardLetters.add(newLetter);
    }
  }

  void _checkResult() {
    if (currentWord!.wordString == solution.wordString) {
      status = GameStatus.won;
      onGameEnd(true);
    } else if (currentWordIndex + 1 >= maxAttempts) {
      status = GameStatus.lost;
      onGameEnd(false);
    } else {
      status = GameStatus.playing;
      currentWordIndex++;
    }
    notifyListeners();
  }

  void restart() {
    currentWordIndex = 0;
    status = GameStatus.playing;
    keyboardLetters.clear();
    _initGame();
    notifyListeners();
  }
}