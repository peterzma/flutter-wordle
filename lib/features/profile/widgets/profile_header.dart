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
        final bool isChancellorOfMajors = stats.masteredCount >= 14;

        return Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
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
                            "DEAN'S LIST (+50%)",
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
              ),
            ),
            context.autoText(
              "Temp Name",
              style: AppFonts.displayLarge
            ),
            context.autoText(
              academicTitle, 
            style: AppFonts.labelLarge.copyWith(color: AppColors.accent)
            ),
          ],
        );
      }
    );
  }
}