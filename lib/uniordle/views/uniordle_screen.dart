import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/uniordle/data/word_list.dart';
import 'package:uniordle/uniordle/uniordle.dart';
import 'package:uniordle/uniordle/views/end_game_dialog.dart';
import 'dart:math';

const Duration _tileFlipDuration = Duration(milliseconds: 100);
const Duration _scrollDuration = Duration(milliseconds: 300);
const double _bottomKeyboardPadding = 72;
const double _topTitlePadding = 86;
const double _titleFontSize = 62;
const int _visibleRows = 6;

final int wordLength = 8;
// final int maxAttempts = 1;

enum GameStatus { 
  playing, // player is entering letters
  submitting, // word is being checked and tiles are flipping
  won, // player guessed word correctly
  lost
}

/// Main game screen for Uniordle
class UniordleScreen extends StatefulWidget {
  const UniordleScreen({
    super.key,
    });

  @override
  _UniordleScreenState createState() => _UniordleScreenState();
}

class _UniordleScreenState extends State<UniordleScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  int _attempts = 0;

  /// Game board containing all guessed words
  final List<Word> _board = List.generate(
    _visibleRows,
    (_) => Word(letters: List.generate(wordLength, (_) => Letter.empty())),
  );
  
  /// Keys used to trigger flip animations for each tile
  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
    _visibleRows,
    (_) => List.generate(wordLength, (_) => GlobalKey<FlipCardState>()),
  );

  /// Index of active word row
  int _currentWordIndex = 0;

  /// Currently active word being edited
  Word? get _currentWord =>
      _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;

  /// Correct solution word for the game
  Word _solution = Word.fromString(
    fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
  );

  // Letters used to update keyboard colouring
  final Set<Letter> _keyboardLetters = {};

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gameBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: _topTitlePadding,
        title: const Text(
            'Uniordle',
            style: TextStyle(
              fontSize: _titleFontSize,
              fontFamily: 'clashdisplay',
              fontWeight: FontWeight.w600,
            ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                reverse: true,
              child: Center(
                child: Board(board: _board, flipCardKeys: _flipCardKeys),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: _bottomKeyboardPadding),
            child: Keyboard(
              onKeyTapped: _onKeyTapped,
              onDeleteTapped: _onDeleteTapped,
              onEnterTapped: _onEnterTapped,
              letters: _keyboardLetters,
            ),
          ),
        ],
      ),
    );
  }

  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.addLetter(val));
    }
  }

    void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter());
    }
  }

  /// Submits the current word, checks letter states,
  /// and triggers tile flip animations
  Future<void> _onEnterTapped() async {
    if (_gameStatus != GameStatus.playing || _currentWord == null) return;
    if (_currentWord!.letters.contains(Letter.empty())) return;
    _gameStatus = GameStatus.submitting;

    // flip all letters with delay
    for (var i = 0; i < _currentWord!.letters.length; i++) {
      final currentWordLetter = _currentWord!.letters[i];
      final currentSolutionLetter = _solution.letters[i];

      setState(() {
        if (currentWordLetter == currentSolutionLetter) {
          _currentWord!.letters[i] =
              currentWordLetter.copyWith(status: LetterStatus.correct);
        } else if (_solution.letters.contains(currentWordLetter)) {
          _currentWord!.letters[i] =
              currentWordLetter.copyWith(status: LetterStatus.inWord);
        } else {
          _currentWord!.letters[i] =  
              currentWordLetter.copyWith(status: LetterStatus.notInWord);
        }
      });

      final letter = _keyboardLetters.firstWhere(
        (e) => e.val == currentWordLetter.val,
        orElse: () => Letter.empty(),
      );
      if (letter.status != LetterStatus.correct) {
        _keyboardLetters.removeWhere((e) => e.val == currentWordLetter.val);
        _keyboardLetters.add(_currentWord!.letters[i]);
      }

      // trigger flip
      _flipCardKeys[_currentWordIndex][i].currentState?.toggleCard();

      // flips slightly overlap
      await Future.delayed(_tileFlipDuration * 0.7);
    }

    await Future.delayed(_tileFlipDuration * 0.3);
      
    _attempts += 1;
    _checkIfWin();
  }

  void _checkIfWin() {
    if (_currentWord!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won;
      _showEndDialog(
        won: true,
      );
    } else {
      _gameStatus = GameStatus.playing;
      _currentWordIndex += 1;

      // Add a new row dynamically if needed
      if (_currentWordIndex >= _board.length) {
        _board.add(Word(letters: List.generate(
          wordLength, (_) => Letter.empty()))
        );
        _flipCardKeys.add(List.generate(
        wordLength, (_) => GlobalKey<FlipCardState>())
        );
      }

      // Scroll to bottom
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: _scrollDuration,
        curve: Curves.easeOut,
      )
    }
  }

  void _showEndDialog({
    required bool won,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EndGameDialog(
        won: won,
        solution: _solution.wordString,
        attempts: _currentWordIndex + 1,
        onRestart: () {
          Navigator.of(context).pop();
          _restart();
        }
      ),
    );
  }

  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _attempts = 0;

      _board
        ..clear()
        ..addAll(
          List.generate(
            _visibleRows,
            (_) => Word(letters: List.generate(wordLength, (_) => Letter.empty())),
          ),
        );
      _solution = Word.fromString(
        fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
      );
      _flipCardKeys
        ..clear()
        ..addAll(
          List.generate(
            _visibleRows,
            (_) => List.generate(wordLength, (_) => GlobalKey<FlipCardState>()),
          ),
        );
      _keyboardLetters.clear();
      _scrollController.jumpTo(0);
    });
  }
}