import 'package:uniordle/shared/exports/game_exports.dart';

class HomeHero extends StatelessWidget {
  final UserStats stats;

  const HomeHero({
    super.key, 
    required this.stats
  });

  @override
  Widget build (BuildContext context) {
    // final bool hasCredits = stats.availableCredits > 0;
    // final Color statusColor = hasCredits ? AppColors.correctColor : AppColors.onSurfaceVariant.withValues(alpha: 0.5);

    return Column(
      children: [
        Text(
          'Select a Discipline',
          style: AppFonts.displayLarge,
        ),
        SizedBox(height: 8),
        Text(
          'Master your academic vocabulary.',
          textAlign: TextAlign.center,
          style: AppFonts.labelMedium,
        ),
        SizedBox(height: 12),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //   decoration: BoxDecoration(
        //     color: statusColor.withValues(alpha: 0.2),
        //     borderRadius: BorderRadius.circular(24),
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(
        //         LucideIcons.graduationCap, 
        //         size: 16, 
        //         color: statusColor
        //       ),
        //       const SizedBox(width: 8),
        //       Text(
        //         "${stats.availableCredits} ${stats.availableCredits == 1 ? 'CREDIT AVAILABLE' : 'CREDITS AVAILABLE'}",
        //         style: AppFonts.labelMedium.copyWith(
        //           color: statusColor,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}