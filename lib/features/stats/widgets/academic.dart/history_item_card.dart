import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/services/models/game_grade.dart';

class HistoryItemCard extends StatelessWidget {
  final Map<String, dynamic> game;
  const HistoryItemCard({required this.game});

  @override
  Widget build(BuildContext context) {
    final bool won = game['won'] ?? true;
    final int attempts = game['attempts'] ?? 0;
    final int maxAttempts = game['maxAttempts'] ?? 8;
    final int merit = game['merit'] ?? 0;
    final String word = game['word'] ?? "?????";

    // One-liner to get all the data we need
    final grade = GameGrade.calculate(won, attempts, maxAttempts);

    return Container(
      margin: EdgeInsets.only(bottom: context.r(10)),
      padding: EdgeInsets.all(context.r(12)),
      decoration: BoxDecoration(
        color: grade.color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(context.r(12)),
        border: Border.all(color: grade.color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.autoText(word.toUpperCase(), 
                  style: AppFonts.labelLarge.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  textAlign: TextAlign.left,
                ),
                context.autoText(
                  won ? "$attempts/$maxAttempts ATTEMPTS" : "X/$maxAttempts ATTEMPTS", 
                  style: AppFonts.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              context.autoText(grade.label, 
                style: AppFonts.labelSmall.copyWith(color: grade.color, fontWeight: FontWeight.bold),
              ),
              context.autoText(
                won ? "+$merit MERITS" : "$merit MERITS",
                style: AppFonts.labelSmall.copyWith(
                  color: won ? AppColors.correctColor : AppColors.accent2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}