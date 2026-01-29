import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';
import 'package:uniordle/shared/exports/stats_exports.dart';
import 'package:uniordle/shared/layout/base_badge.dart';

class StatsScreen extends StatelessWidget {

  const StatsScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder<UserStats>(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final double winValue = double.tryParse(stats.winPercentage.replaceAll('%', '')) ?? 0;
        final double normalizedValue = (winValue / 100).clamp(0.0, 1.0);
        final Color winColor = Color.lerp(AppColors.accent2, AppColors.correctColor, normalizedValue)!;

        final int bonusCount = stats.unlockedIds.length;
        final int totalBonusPercent = (bonusCount * 5).clamp(0, 100);
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppLayout.sidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text("Academic Performance", style: AppFonts.displayLarge),
                    const SizedBox(height: AppLayout.titleToSubtitle),
                    Text("Your learning journey analytics", textAlign: TextAlign.center, style: AppFonts.labelMedium),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        BaseBadge(
                          label: "${stats.merit} TOTAL MERITS",
                          icon: AppIcons.merits,
                          color: AppColors.accent,
                        ),
                        
                        if (stats.unlockedIds.isNotEmpty)
                          BaseBadge(
                            label: "+$totalBonusPercent% MERIT BONUS",
                            icon: LucideIcons.trendingUp,
                            color: AppColors.correctColor,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppLayout.badgeToContent),

              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: StatCard(value: "${stats.totalGames}", label: "Total\nGames")),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: stats.winPercentage, label: "Win\n%", color: winColor)),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: "${stats.streak}", label: "Current\nStreak", color: Colors.orange)),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: "${stats.maxStreak}", label: "Best\nStreak", color: Colors.deepOrange)),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              Text(
                "CORRECT GUESS DISTRIBUTION", 
                style: AppFonts.labelMedium
              ),

              const SizedBox(height: 12),

              GuessDistributionChart(distribution: stats.guessDistribution),
              
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}