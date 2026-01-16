import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/uniordle/uniordle.dart';
import 'package:uniordle/uniordle/views/end_dialog.dart';
import 'package:uniordle/home/models/discipline.dart';

class UniordleScreen extends StatefulWidget {
  const UniordleScreen({
    super.key,
    });

  @override
  _UniordleScreenState createState() => _UniordleScreenState();
}

class _UniordleScreenState extends State<UniordleScreen> {
late UniordleController _controller;
  bool _isInitialized = false;

@override
  void didChangeDependencies() {
    super.didChangeDependencies();
  if (!_isInitialized) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    
    final discipline = args?['discipline'] as Discipline?;
    
    _controller = UniordleController(
      wordLength: args?['wordLength'] ?? 5,
      maxAttempts: 6,
      disciplineId: discipline?.id ?? 'engineering',
      onGameEnd: (won) => _showEndDialog(won),
    );

    _controller.addListener(() => setState(() {}));
    _isInitialized = true;
  }
  }

  void _showEndDialog(bool won) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EndGameDialog(
        won: won,
        solution: _controller.solution.wordString,
        attempts: _controller.currentWordIndex + 1,
        onRestart: () {
          Navigator.pop(context);
          _controller.restart();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: AppColors.gameBackground,
      appBar: const UniordleAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Board(
                board: _controller.board, 
                flipCardKeys: _controller.flipCardKeys
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Keyboard(
              onKeyTapped: _controller.addLetter,
              onDeleteTapped: _controller.removeLetter,
              onEnterTapped: _controller.submitWord,
              letters: _controller.keyboardLetters,
            ),
          ),
        ],
      ),
    );
  }
}