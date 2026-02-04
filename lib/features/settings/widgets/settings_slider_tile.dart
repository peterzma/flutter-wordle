import 'package:flutter/cupertino.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsSliderTile extends StatelessWidget {
  final IconData icon;
  final IconData muteIcon;
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback onMuteToggle;

  const SettingsSliderTile({
    super.key,
    required this.icon,
    required this.muteIcon,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onMuteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppLayout.settingsPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Tapping the icon acts as a quick mute/unmute
                  GestureDetector(
                    onTap: onMuteToggle,
                    child: context.autoIcon(
                      value > 0 ? icon : muteIcon, 
                      color: value > 0 ? AppColors.accent : AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 12),
                  context.autoText(label, style: AppFonts.labelLarge),
                ],
              ),
              // Percentage indicator
              context.autoText(
                '${(value * 100).toInt()}%', 
                style: AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlider(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.accent,
              thumbColor: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}