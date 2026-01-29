  import 'dart:convert';
  import 'dart:math';
  import 'package:uniordle/shared/exports/profile_exports.dart';

  class StatsManager {
    static final StatsManager _instance = StatsManager._internal();
    factory StatsManager() => _instance;
    StatsManager._internal();

    late SharedPreferences _prefs;
    final ValueNotifier<UserStats> statsNotifier = ValueNotifier(UserStats(streak: 0, solved: 0, merit: 0));

    Future<void> init() async {
      _prefs = await SharedPreferences.getInstance();
      
      final distString = _prefs.getString('stat_dist') ?? '{}';
      final Map<String, dynamic> decodedDist = jsonDecode(distString);
      final unlocked = _prefs.getStringList('unlocked_disciplines') ?? [];
      final milestonesRaw = _prefs.getStringList('stat_milestones') ?? [];

      final modeFreqString = _prefs.getString('stat_mode_freq') ?? '{}';
      final Map<String, dynamic> decodedModeFreq = jsonDecode(modeFreqString);
      final Map<String, int> modeFrequency = decodedModeFreq.map((k, v) => MapEntry(k, v as int));
      
      final Map<int, int> distribution = {
        for (var e in decodedDist.entries) int.parse(e.key): e.value as int
      };

      final Map<int, int> fullDistribution = {
        for (int i = 1; i <= 8; i++) i: distribution[i] ?? 0
      };


      statsNotifier.value = UserStats(
        streak: _prefs.getInt('stat_streak') ?? 0,
        maxStreak: _prefs.getInt('stat_max_streak') ?? 0,
        solved: _prefs.getInt('stat_solved') ?? 0,
        lost: _prefs.getInt('stat_lost') ?? 0,
        merit: _prefs.getInt('stat_merit') ?? 0,
        guessDistribution: fullDistribution,
        unlockedIds: unlocked,
        achievedMilestones: milestonesRaw.map(int.parse).toList(),
        modeFrequency: modeFrequency,
      );
    }

    Future<int> recordWin({required int yearLevel, required int wordLength, required int attempts, required int maxAttempts}) async {
      final current = statsNotifier.value;

      final updatedModeFreq = await _incrementModeFrequency(wordLength, maxAttempts);

      final int gainedMerit = UserStatsRewards.generateGainedMerit(
        stats: current, 
        yearLevel: yearLevel, 
        wordLength: wordLength, 
        attempts: attempts,
      );

      final int oldLevel = current.currentLevel;
      final int newMerit = current.merit + gainedMerit;
      final int newLevel = newMerit ~/ UserStats.meritPerLevel;

      List<int> updatedMilestones = List.from(current.achievedMilestones);
      if (newLevel > oldLevel) {
        for (int i = oldLevel + 1; i <= newLevel; i++) {
          if (!updatedMilestones.contains(i)) updatedMilestones.insert(0, i);
        }
        await _prefs.setStringList('stat_milestones', updatedMilestones.map((e) => e.toString()).toList());
      }

      await _incrementModeFrequency(wordLength, maxAttempts);

      final newStreak = current.streak + 1;
      final newMaxStreak = max(newStreak, current.maxStreak);
      final newDist = Map<int, int>.from(current.guessDistribution);
      newDist[attempts] = (newDist[attempts] ?? 0) + 1;
      
      await _prefs.setInt('stat_merit', newMerit);
      await _prefs.setInt('stat_streak', newStreak);
      await _prefs.setInt('stat_max_streak', newMaxStreak);
      await _prefs.setInt('stat_solved', current.solved + 1);
      await _prefs.setString('stat_dist', jsonEncode(newDist.map((k, v) => MapEntry(k.toString(), v))));

      statsNotifier.value = current.copyWith(
        streak: newStreak,
        maxStreak: newMaxStreak,
        solved: current.solved + 1,
        merit: newMerit,
        guessDistribution: newDist,
        achievedMilestones: updatedMilestones,
        modeFrequency: updatedModeFreq,
      );

      return gainedMerit;
    }

    Future<void> recordLoss({required int wordLength, required int maxAttempts}) async {
      await _incrementModeFrequency(wordLength, maxAttempts);
      return _applyPenalty(UserStats.penaltyAmount);
    }
    Future<void> recordAbandonment({required int wordLength, required int maxAttempts}) async {
      await _incrementModeFrequency(wordLength, maxAttempts);
      final current = statsNotifier.value;
      return _applyPenalty(current.activePenalty);
    }

    Future<void> _applyPenalty(int amount) async {
      final current = statsNotifier.value;
      final newLost = current.lost + 1;
      final newMerit = max(0, current.merit - amount);

      await _prefs.setInt('stat_streak', 0);
      await _prefs.setInt('stat_lost', newLost);
      await _prefs.setInt('stat_merit', newMerit);

      statsNotifier.value = current.copyWith(
        streak: 0,
        lost: newLost,
        merit: newMerit,
      );
    }

    Future<void> unlockDiscipline(String id) async {
      final current = statsNotifier.value;
      if (current.unlockedIds.contains(id)) return;

      final newList = List<String>.from(current.unlockedIds)..add(id);
      await _prefs.setStringList('unlocked_disciplines', newList);
      
      statsNotifier.value = current.copyWith(unlockedIds: newList);
    }

    Future<Map<String, int>> _incrementModeFrequency(int length, int maxAttempts) async {
      final current = statsNotifier.value;
      final String modeKey = "$length-$maxAttempts";
      
      final newFreq = Map<String, int>.from(current.modeFrequency);
      newFreq[modeKey] = (newFreq[modeKey] ?? 0) + 1;

      await _prefs.setString('stat_mode_freq', jsonEncode(newFreq));
      
      statsNotifier.value = current.copyWith(modeFrequency: newFreq);
      
      return newFreq;
    }
  }

  final statsManager = StatsManager();