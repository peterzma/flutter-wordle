import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  String _getAcademicTitle(int level) {
    const titles = [
      "UNDERGRADUATE", // 0-9
      "BACHELOR",      // 10-19
      "HONORS",        // 20-29
      "MASTERS",       // 30-39
      "DOCTORAL",      // 40-49
      "FELLOW",        // 50-59
      "EMERITUS",      // 60+
    ];
    
    // Calculate index: level 15 ~/ 10 = index 1
    int index = level ~/ 10;
    
    // Ensure we don't go out of bounds if level is 70+
    if (index >= titles.length) index = titles.length - 1;
    
    return titles[index];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final int currentLevel = stats.currentLevel;
        final String academicTitle = _getAcademicTitle(currentLevel);

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
                        child: Icon(Icons.account_circle, size: 48, color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Temp Name",
              style: AppFonts.displayMedium
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                "Academic Rank: ", 
                style: AppFonts.labelMedium
                ),
                Text(
                  academicTitle, 
                style: AppFonts.labelLarge.copyWith(color: AppColors.accent)
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}