import 'package:auto_size_text/auto_size_text.dart';
import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/layout/base_badge.dart';

class HomeHero extends StatelessWidget {
  final UserStats stats;

  const HomeHero({
    super.key, 
    required this.stats
  });

  @override
  Widget build (BuildContext context) {
    final bool hasCredits = stats.availableCredits > 0;
    final Color statusColor = hasCredits ? AppColors.accent3 : AppColors.onSurfaceVariant.withValues(alpha: 0.5);

    return Column(
      children: [
        AutoSizeText('Select a Major', style: AppFonts.displayLarge, maxLines: 1,),
        const SizedBox(height: AppLayout.titleToSubtitle),
        Text(
          'Master your academic vocabulary.',
          textAlign: TextAlign.center,
          style: AppFonts.labelMedium,
        ),
        const SizedBox(height: 12),
        BaseBadge(
          label: "${stats.availableCredits} ${stats.availableCredits == 1 ? 'CREDIT' : 'CREDITS'}",
          icon: AppIcons.credits,
          color: statusColor,
        ),
      ],
    );
  }
}