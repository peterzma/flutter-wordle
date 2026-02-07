import 'package:uniordle/shared/exports/profile_exports.dart';
import 'package:uniordle/shared/wrappers/celebration_wrapper.dart';

class Commencement extends StatelessWidget {
  const Commencement({super.key});

  @override
  Widget build(BuildContext context) {
    return CelebrationWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          context.autoIcon(
            AppIcons.badgeOracle,
            size: 64,
            color: context.colorScheme.tertiary,
          ),
          SizedBox(height: context.r(16)),

          context.autoText("COMMENCEMENT", style: context.headlineMedium),
          SizedBox(height: context.r(12)),

          context.autoText(
            "Congratulations, Oracle! You've reached the summit of knowledge. "
            "Level 100 is yours, but true prestige lies in the archives. "
            "Can you master every single major?",
            textAlign: TextAlign.center,
            style: context.labelMedium,
            maxLines: 4,
          ),
          SizedBox(height: context.r(32)),

          _buildSummitCard(context),

          SizedBox(height: context.r(32)),
          PrimaryButton(
            label: 'I am ready',
            color: context.colorScheme.tertiary,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSummitCard(BuildContext context) {
    final tertiaryColor = context.colorScheme.tertiary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: tertiaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tertiaryColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          context.autoText(
            "SUMMIT CONFERMENT",
            style: context.labelSmall.copyWith(
              color: tertiaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          context.autoText(
            "+100% PERMANENT MERIT",
            style: context.headlineMedium.copyWith(
              color: tertiaryColor,
              fontSize: 20,
            ),
            reduction: 8,
          ),
        ],
      ),
    );
  }
}
