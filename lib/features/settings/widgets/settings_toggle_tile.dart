import 'package:flutter/cupertino.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: AppLayout.settingsTileHeight,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surface.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.onSurfaceVariant, size: 24),
              const SizedBox(width: 12),
              Text(label, style: AppFonts.labelLarge),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            alignment: Alignment.centerRight,
            child: CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}