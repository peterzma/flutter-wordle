import 'package:uniordle/features/home/widgets/unlocked_discipline_dialog.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';
import 'package:uniordle/shared/buttons/wiggle_button_wrapper.dart';

class UnlockDisciplineDialog extends StatefulWidget {
  final Major major;
  final int credits;
  final int nextLevel;

  const UnlockDisciplineDialog({
    super.key,
    required this.major,
    required this.credits,
    required this.nextLevel,
  });

  @override
  State<UnlockDisciplineDialog> createState() => _UnlockDisciplineDialogState();
}

class _UnlockDisciplineDialogState extends State<UnlockDisciplineDialog> {
  bool _isUnlocked = false;
  final wiggleKey = GlobalKey<WiggleButtonWrapperState>();

  void _handleUnlock() async {
    await statsManager.unlockDiscipline(widget.major.id);
    
    if (mounted) {
      setState(() {
        _isUnlocked = true;
      });
    }
    
    // TODO: change to victory
    SoundManager().play(SoundType.grid);
  }

  @override
  Widget build(BuildContext context) {
    if (_isUnlocked) {
      return UnlockedDisciplineDialog(major: widget.major);
    }

    final stats = statsManager.statsNotifier.value;
    final bool isFirstEnrollment = stats.unlockedIds.isEmpty;

    final bool canAfford = widget.credits > 0;
    final Color buttonColor = canAfford 
        ? widget.major.color 
        : AppColors.onSurfaceVariant.withValues(alpha: 0.5);
    final Color statusColor = canAfford 
        ? widget.major.color 
        : AppColors.onSurfaceVariant.withValues(alpha: 0.5);

    final String bonusText = isFirstEnrollment 
    ? "FIRST ENROLLMENT" 
    : "PERMANENT +5% MERIT BONUS";

    final IconData bonusIcon = isFirstEnrollment 
        ? LucideIcons.bookOpen 
        : LucideIcons.trendingUp;

    final wiggleKey = GlobalKey<WiggleButtonWrapperState>();

    return SizedBox(
      width: AppLayout.maxDialogWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DisciplineIcon(
            iconName: canAfford ? widget.major.icon : 'lock',
            color: statusColor,
            size: AppLayout.dialogIcon,
          ),
          const SizedBox(height: 8),
      
          Text(
            canAfford ? "Enroll in ${widget.major.name}?" : "LOCKED",
            style: AppFonts.displayMedium,
          ),
          const SizedBox(height: AppLayout.titleToSubtitle),
          
          Text(
            canAfford 
              ? "Spend 1 Credit to unlock ${widget.major.name}?"
              : "You don't have any credits to unlock ${widget.major.name}.",
            textAlign: TextAlign.center,
            style: AppFonts.labelLarge,
          ),
          
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: canAfford 
                  ? widget.major.color.withValues(alpha: 0.1)
                  : AppColors.onSurfaceVariant.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  bonusIcon,
                  size: 16, 
                  color: canAfford ? widget.major.color : AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  bonusText,
                  style: AppFonts.labelSmall.copyWith(
                    color: canAfford ? widget.major.color : AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          
          Column(
            children: [
              if (!canAfford) ...[
                Text(
                  "(Credit available at Level ${widget.nextLevel})",
                  style: AppFonts.labelMedium,
                ),
              ],
            ],
          ),
      
          const SizedBox(height: AppLayout.size2XL),
      
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () => Navigator.pop(context),
                  label: "BACK",
                ),
              ),
              const SizedBox(width: AppLayout.gapBetweenButtons),
              Expanded(
                child: WiggleButtonWrapper(
                  key: wiggleKey, 
                  child: PrimaryButton(
                    label: "UNLOCK",
                    color: buttonColor,
                    onPressed: () {
                      if (canAfford) {
                        _handleUnlock();
                      } else {
                        wiggleKey.currentState?.wiggle();
      
                        // TODO: change sound to negative
                        SoundManager().play(SoundType.grid); 
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}