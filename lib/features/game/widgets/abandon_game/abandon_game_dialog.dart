import 'package:uniordle/shared/exports/end_game_exports.dart';

class AbandonGameDialog extends StatelessWidget {
  const AbandonGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            "ABANDON GAME?",
            style: AppFonts.labelLarge, // Using your existing font styles
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "Leaving now will result in a penalty of ${UserStatsExtension.penaltyAmount} merits.",
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'CANCEL',
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: 'LEAVE',
                  color: AppColors.accent2,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper static method to show the dialog
  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => const AbandonGameDialog(),
    ) ?? false;
  }
}