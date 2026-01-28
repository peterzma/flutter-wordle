import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';
import 'package:uniordle/shared/buttons/wiggle_button_wrapper.dart';

class UnlockDisciplineDialog extends StatelessWidget {
  final Discipline discipline;
  final int credits;
  final int nextLevel;

  const UnlockDisciplineDialog({
    super.key,
    required this.discipline,
    required this.credits,
    required this.nextLevel,
  });

  @override
  Widget build(BuildContext context) {
    final bool canAfford = credits > 0;
    final Color buttonColor = canAfford 
        ? discipline.color 
        : AppColors.onSurfaceVariant.withValues(alpha: 0.5);
    final Color statusColor = canAfford 
        ? discipline.color 
        : AppColors.onSurfaceVariant.withValues(alpha: 0.5);

    final wiggleKey = GlobalKey<WiggleButtonWrapperState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DisciplineIcon(
          iconName: canAfford ? discipline.icon : 'lock',
          color: statusColor,
          size: AppLayout.dialogIcon,
        ),
        const SizedBox(height: 12),
        
        // Title
        Text(
          canAfford ? "Enroll in ${discipline.name}?" : "LOCKED",
          style: AppFonts.displayMedium,
        ),
        const SizedBox(height: 6),
        
        // Content
        Text(
          canAfford 
            ? "Spend 1 Credit to unlock ${discipline.name}?"
            : "You don't have enough Credits to unlock ${discipline.name} right now.",
          textAlign: TextAlign.center,
          style: AppFonts.labelLarge,
        ),
        
        const SizedBox(height: 12),
        
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$credits ${credits == 1 ? 'Credit' : 'Credits'} Available",
                  style: AppFonts.labelMedium.copyWith(
                    color: statusColor, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            if (!canAfford) ...[
              Text(
                "Next Credit at Level $nextLevel",
                style: AppFonts.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ],
          ],
        ),
        
        const SizedBox(height: 24),
        
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onPressed: () => Navigator.pop(context),
                label: "BACK",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WiggleButtonWrapper(
                key: wiggleKey, 
                child: PrimaryButton(
                  label: "UNLOCK",
                  color: buttonColor,
                  onPressed: () async {
                    if (canAfford) {
                      await statsManager.unlockDiscipline(discipline.id);
                      if (context.mounted) Navigator.pop(context);
                    } else {
                      wiggleKey.currentState?.wiggle();
                      SoundManager().play(SoundType.grid); 
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}