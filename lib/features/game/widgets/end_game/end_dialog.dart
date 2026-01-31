import 'package:uniordle/shared/exports/end_game_exports.dart';
import 'package:uniordle/shared/layout/base_show_dialog.dart';

class EndDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final int maxAttempts;
  final String yearLevel;
  final Major major;
  final int gainedMerit;

  const EndDialog({
    super.key,
    required this.won,
    required this.solution,
    required this.attempts,
    required this.maxAttempts,
    required this.yearLevel,
    required this.major,
    required this.gainedMerit,
  });

  void _handleNext(BuildContext context) {
    final currentStats = statsManager.statsNotifier.value;
    
    final double directedMerit = won ? gainedMerit.toDouble() : -gainedMerit.toDouble();

    final prevState = UserStatsProgress.getPreviousState(
    currentStats.merit, 
    directedMerit.toInt(),
    );

    Navigator.pop(context);
    baseShowDialog(
      context: context,
      child: LevelUpDialog(
        startingLevel: prevState.$1,
        startingProgress: prevState.$2,
        gainedMerit: directedMerit,
        major: major,
        attempts: attempts,
        maxAttempts: maxAttempts,
        won: won,
      ),
);
  }
  
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
            const SizedBox(height: AppLayout.titleToSubtitle),
            SolutionBox(solution: solution),
            const SizedBox(height: 12),
            // AttemptsInfo(attempts: attempts, maxAttempts: maxAttempts, won: won),
            // const SizedBox(height: 12),
            GameInfoBar(disciplineName: major.name, yearLevel: yearLevel, wordLength: solution.length),
            const SizedBox(height: AppLayout.size2XL),
            PrimaryButton(
              label: 'NEXT',
              color: AppColors.accent,
              onPressed: () => _handleNext(context),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}