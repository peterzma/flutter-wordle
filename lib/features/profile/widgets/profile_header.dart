import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final String academicTitle = stats.academicTitle;
        // Check if the user has mastered all 14 majors
        final bool isChancellorOfMajors = stats.masteredCount >= 14;

        return Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.surfaceVariant,
                        child: Icon(AppIcons.defaultProfile,
                            size: 48, color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            context.autoText("Temp Name", style: AppFonts.displayLarge),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                context.autoText(
                  academicTitle,
                  style: AppFonts.labelLarge.copyWith(color: AppColors.accent),
                ),
                if (isChancellorOfMajors) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
                    ),
                    child: context.autoText(
                      "CHANCELLOR'S LIST (+50%)",
                      style: AppFonts.labelSmall.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}