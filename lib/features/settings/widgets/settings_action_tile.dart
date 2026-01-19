import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final bool isLast;

  const SettingsActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: !isLast
                ? Border(bottom: BorderSide(color: AppColors.backgroundBorder.withValues(alpha: 0.4)))
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.textSecondary, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (value != null)
                    Text(
                      value!,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (value != null) const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right, 
                    color: AppColors.textSecondary.withValues(alpha: 0.7), 
                    size: 20
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}