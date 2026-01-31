import 'package:uniordle/shared/exports/game_exports.dart';

enum GameGrade {
  highDistinction("HIGH DISTINCTION"),
  distinction("DISTINCTION"),
  credit("CREDIT"),
  pass("PASS"),
  fail("FAIL");

  final String label;
  const GameGrade(this.label);

  factory GameGrade.calculate(bool won, int attempts, int maxAttempts) {
    if (!won) return GameGrade.fail;

    final double weight = (maxAttempts - attempts) / (maxAttempts - 1).toDouble();

    if (weight >= 0.85) return GameGrade.highDistinction;
    if (weight >= 0.70) return GameGrade.distinction;
    if (weight >= 0.50) return GameGrade.credit;
    return GameGrade.pass;
  }

  Color get color {
    switch (this) {
      case GameGrade.fail: return AppColors.accent2;
      case GameGrade.highDistinction: return AppColors.correctColor;
      case GameGrade.distinction: return AppColors.accent;
      case GameGrade.credit: return Colors.orange;
      case GameGrade.pass: return Colors.blueGrey;
    }
  }
}