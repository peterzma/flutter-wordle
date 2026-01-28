import 'package:uniordle/shared/exports/end_game_exports.dart';

class EndDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final int maxAttempts;
  final String yearLevel;
  final Discipline discipline;
  final VoidCallback onRestart;
  final VoidCallback onNext;

  const EndDialog({
    super.key,
    required this.won,
    required this.solution,
    required this.attempts,
    required this.maxAttempts,
    required this.yearLevel,
    required this.discipline,
    required this.onRestart,
    required this.onNext,
  });


  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16, 
          horizontal: 12
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EndDialogHeader(won: won),
            const SizedBox(height: 12),
            SolutionBox(solution: solution),
            const SizedBox(height: 12),
            AttemptsInfo(attempts: attempts, maxAttempts: maxAttempts, won: won),
            const SizedBox(height: 12),
            GameInfoBar(disciplineName: discipline.name, yearLevel: yearLevel, wordLength: solution.length),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'NEXT',
              color: AppColors.accent,
              onPressed: onNext,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}