import 'package:flutter_test/flutter_test.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

void main() {
  group('UserStats Core Logic::', () {
    test('Win percentage calculates correctly', () {
      final stats = UserStats(streak: 0, solved: 10, merit: 0, lost: 10);
      expect(stats.totalGames, 20);
      expect(stats.winPercentage, "50%");
    });

    test('Win percentage handles zero games', () {
      final stats = UserStats(streak: 0, solved: 0, merit: 0);
      expect(stats.winPercentage, "0%");
    });
  });

  group('UserStats Progress & Leveling:', () {
    test('Level and progress calculated from merit', () {
      // 250 merit should be Level 2 (since meritPerLevel is 100)
      final stats = UserStats(streak: 0, solved: 0, merit: 250);
      
      expect(stats.currentLevel, 2);
      expect(stats.meritInCurrentLevel, 50);
      expect(stats.levelProgress, 0.5);
      expect(stats.progressText, "50%");
    });

    test('Academic Titles progress every 10 levels', () {
      final freshStats = UserStats(streak: 0, solved: 0, merit: 0);
      final masterStats = UserStats(streak: 0, solved: 0, merit: 3500); // Level 35

      expect(freshStats.academicTitle, "UNDERGRADUATE");
      expect(masterStats.academicTitle, "MASTERS");
    });
  });

  group('UserStats Rewards & Multipliers:', () {
    test('Merit multiplier increases with unlocked disciplines', () {
      // 1 initial major = 1.0x
      final baseStats = UserStats(streak: 0, solved: 0, merit: 0, unlockedIds: ['eng']);
      
      // 1 initial + 2 additional = 1.0 + (2 * 0.05) = 1.1x
      final multiStats = UserStats(
        streak: 0, 
        solved: 0, 
        merit: 0, 
        unlockedIds: ['eng', 'cs', 'law'],
      );

      expect(baseStats.meritMultiplier, 1.0);
      expect(multiStats.meritMultiplier, closeTo(1.1, 0.01));
    });

    test('Merit generation rewards fewer attempts', () {
      final stats = UserStats(streak: 0, solved: 0, merit: 0);

      final meritQuick = UserStatsRewards.generateGainedMerit(
        stats: stats,
        yearLevel: 1,
        wordLength: 5,
        attempts: 1,
      );

      final meritSlow = UserStatsRewards.generateGainedMerit(
        stats: stats,
        yearLevel: 1,
        wordLength: 5,
        attempts: 6,
      );

      expect(meritQuick, greaterThan(meritSlow));
    });
  });

  group('UserStats Unlocks & Penalties:', () {
    test('Available credits scale with level', () {
      // Level 10 should have (1 + 10~/5) = 3 total credits
      final stats = UserStats(streak: 0, solved: 0, merit: 1000, unlockedIds: ['eng']);
      
      expect(stats.totalCreditsEarned, 3);
      expect(stats.availableCredits, 2);
      expect(stats.hasCredits, true);
    });

    test('Active penalty increases with academic rank', () {
      final undergrad = UserStats(streak: 0, solved: 0, merit: 0); // Rank 0
      final masters = UserStats(streak: 0, solved: 0, merit: 3000); // Rank 3

      expect(undergrad.activePenalty, 10);
      expect(masters.activePenalty, 10 + (3 * 5)); // 25
    });
  });
}