part of 'user_stats.dart';

extension UserStatsRewards on UserStats {
  double get masteryBonusValue =>
      masteredCount >= MajorsData.all.length ? 2.0 : 0.0;

  double get summitBonusValue => currentLevel >= 100 ? 1.0 : 0.0;

  double get majorMultiplier {
    final int unlockedCount = unlockedIds.length;
    double baseMultiplier = 0.0;

    if (unlockedCount >= 20) {
      baseMultiplier = 1.0;
    } else if (unlockedCount == 19) {
      baseMultiplier = 0.90;
    } else {
      baseMultiplier = unlockedCount * 0.05;
    }

    final double researchBonus = extraBoosts * 0.10;

    return baseMultiplier + researchBonus;
  }

  double get meritMultiplier {
    // Rank Bonus: +10% for every 10 levels

    final int effectiveLevelForBonus = currentLevel.clamp(0, 100);

    final double rankMultiplier = (effectiveLevelForBonus ~/ 10) * 0.10;

    // Major Bonus: 200%
    final double majorBonus = majorMultiplier;

    // Base is 1.0 (100%)
    return 1.0 +
        majorBonus +
        rankMultiplier +
        summitBonusValue +
        masteryBonusValue;
  }

  static ({int min, int max}) _calculateMeritBounds(
    int yearLevel,
    int wordLength,
  ) {
    int minBase = 10 + (yearLevel * 5);
    int maxBase = 20 + (yearLevel * 6);
    int lengthBonus = (wordLength == 6) ? 5 : (wordLength >= 7 ? 10 : 0);

    return (min: minBase + lengthBonus, max: maxBase + lengthBonus);
  }

  static ({String original, String boosted}) getMeritRange(
    UserStats stats,
    int yearLevel,
    int wordLength,
  ) {
    final bounds = _calculateMeritBounds(yearLevel, wordLength);
    final multiplier = stats.meritMultiplier;

    final int boostedMin = (bounds.min * multiplier).round();
    final int boostedMax = (bounds.max * multiplier).round();

    return (
      original: "${bounds.min}-${bounds.max}",
      boosted: "$boostedMin-$boostedMax",
    );
  }

  static int generateGainedMerit({
    required UserStats stats,
    required int yearLevel,
    required int wordLength,
    required int attempts,
    required String majorId,
  }) {
    final bounds = _calculateMeritBounds(yearLevel, wordLength);

    double performanceWeight = (8 - attempts) / 7.0;

    performanceWeight = performanceWeight.clamp(0.0, 1.0);

    int baseMerit =
        bounds.min + ((bounds.max - bounds.min) * performanceWeight).round();

    double totalMerit = baseMerit * stats.meritMultiplier;

    final bool isMastered = stats.masteredMajorIds.contains(majorId);
    final bool hasFinishedAll = stats.masteredCount >= MajorsData.all.length;

    if (isMastered && !hasFinishedAll) {
      totalMerit *= 0.5;
    }

    return totalMerit.round();
  }

  static ({int min, int max}) calculateReducedBounds(int min, int max) {
    return (min: min ~/ 2, max: max ~/ 2);
  }

  static String formatReducedRange(String boostedRange) {
    final parts = boostedRange.split('-');
    if (parts.length != 2) return boostedRange;

    final min = (int.tryParse(parts[0]) ?? 0) ~/ 2;
    final max = (int.tryParse(parts[1]) ?? 0) ~/ 2;

    return "$min-$max";
  }
}
