import 'dart:math';

class UserStats {
  final int streak;
  final int maxStreak;
  final int solved;
  final int lost;
  final int xp;
  final Map<int, int> guessDistribution;

  UserStats({
    required this.streak,
    required this.solved,
    required this.xp,
    this.maxStreak = 0,
    this.lost = 0,
    this.guessDistribution = const {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0},
  });

  int get totalGames => solved + lost;

  String get winPercentage {
    if (totalGames == 0) return "0%";
    return "${((solved / totalGames) * 100).toInt()}%";
  }
}

extension UserStatsExtension on UserStats {
  static const int xpPerLevel = 100;

  static ({int min, int max}) _calculateXpBounds(int yearLevel, int wordLength) {
    int minBase = 10 + (yearLevel * 5);
    int maxBase = 20 + (yearLevel * 6);

    int lengthBonus = 0;
    if (wordLength == 6) lengthBonus = 5;
    if (wordLength >= 7) lengthBonus = 15;

    return (min: minBase + lengthBonus, max: maxBase + lengthBonus);
  }

  static String getMeritRange(int yearLevel, int wordLength) {
    final bounds = _calculateXpBounds(yearLevel, wordLength);
    return "${bounds.min}-${bounds.max}";
  }

  static int generateGainedMerit(int yearLevel, int wordLength) {
    final bounds = _calculateXpBounds(yearLevel, wordLength);
    final random = Random();
    return bounds.min + random.nextInt(bounds.max - bounds.min + 1);
  }

  int get currentLevel => xp ~/ xpPerLevel;

  int get nextLevel => currentLevel + 1;
  
  int get xpInCurrentLevel => xp % xpPerLevel;

  double get levelProgress => (xp % xpPerLevel) / xpPerLevel.toDouble();
  
  String get progressText => "$xpInCurrentLevel/$xpPerLevel MERITS";
  
  static (int level, double progress) getPreviousState(int totalXP, int gainedXP) {
    int oldXP = totalXP - gainedXP;
    return (oldXP ~/ xpPerLevel, (oldXP % xpPerLevel) / xpPerLevel.toDouble());
  }

  String get academicTitle => getAcademicTitle(currentLevel);

  String getAcademicTitle(int level) {
    const titles = [
      "UNDERGRADUATE", // 0-9
      "BACHELOR",      // 10-19
      "HONOURS",       // 20-29
      "MASTERS",       // 30-39
      "DOCTORAL",      // 40-49
      "PROFESSOR",     // 50-59
      "DEAN",          // 60+
      "CHANCELLOR",    // 70+
    ];
    
    // Calculate index: level 15 ~/ 10 = index 1
    int index = level ~/ 10;
    
    // Ensure we don't go out of bounds if level is 70+
    if (index >= titles.length) index = titles.length - 1;
    
    return titles[index];
  }
}