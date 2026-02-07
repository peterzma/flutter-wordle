import 'package:uniordle/shared/exports/game_setup_exports.dart';

class MeritPreviewBadge extends StatelessWidget {
  final int difficulty;
  final int wordLength;
  final Major major;

  const MeritPreviewBadge({
    super.key,
    required this.difficulty,
    required this.wordLength,
    required this.major,
  });

  @override
  Widget build(BuildContext context) {
    final bool mobileMode = AppLayout.mobileMode(context);

    return ValueListenableBuilder<UserStats>(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final ranges = UserStatsRewards.getMeritRange(
          stats,
          difficulty,
          wordLength,
        );

        final bool hasMasteredEverything =
            stats.masteredCount >= MajorsData.all.length;
        final bool isMastered = stats.masteredMajorIds.contains(major.id);
        final bool hasBonus = stats.meritMultiplier > 1.0;

        final bool showReductionUI = isMastered && !hasMasteredEverything;

        String labelText;
        IconData displayIcon;

        if (hasMasteredEverything) {
          labelText = mobileMode ? "ASCENSION: " : "ASCENSION MERITS: ";
          displayIcon = AppIcons.badgeMastery;
        } else if (showReductionUI) {
          labelText = "REDUCED MERITS: ";
          displayIcon = AppIcons.gameRepeat;
        } else if (hasBonus) {
          labelText = mobileMode ? "BOOSTED: " : "BOOSTED MERITS: ";
          displayIcon = AppIcons.gameBoostedMerit;
        } else {
          labelText = mobileMode ? "MERITS: " : "POTENTIAL MERITS: ";
          displayIcon = AppIcons.gameMerit;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: context.getMajorColor(major.id).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          displayIcon,
                          size: 16,
                          color: context.getMajorColor(major.id),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          labelText,
                          style: AppFonts.labelLarge.copyWith(
                            color: context.getMajorColor(major.id),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          showReductionUI ? ranges.boosted : ranges.original,
                          style: AppFonts.labelLarge.copyWith(
                            color:
                                (showReductionUI ||
                                    hasBonus ||
                                    hasMasteredEverything)
                                ? context
                                      .getMajorColor(major.id)
                                      .withValues(alpha: 0.5)
                                : context.getMajorColor(major.id),
                            fontWeight:
                                (showReductionUI ||
                                    hasBonus ||
                                    hasMasteredEverything)
                                ? FontWeight.normal
                                : FontWeight.bold,
                            decoration:
                                (showReductionUI ||
                                    hasBonus ||
                                    hasMasteredEverything)
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),

                        if (showReductionUI) ...[
                          const SizedBox(width: 4),
                          Icon(
                            AppIcons.gameMeritRange,
                            size: 16,
                            color: context
                                .getMajorColor(major.id)
                                .withValues(alpha: 0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            UserStatsRewards.formatReducedRange(ranges.boosted),
                            style: AppFonts.labelLarge.copyWith(
                              color: context.getMajorColor(major.id),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ] else if (hasBonus || hasMasteredEverything) ...[
                          const SizedBox(width: 4),
                          Icon(
                            AppIcons.gameMeritRange,
                            size: 16,
                            color: context
                                .getMajorColor(major.id)
                                .withValues(alpha: 0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ranges.boosted,
                            style: AppFonts.labelLarge.copyWith(
                              color: context.getMajorColor(major.id),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
