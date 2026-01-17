import 'package:uniordle/shared/home_screen_exports.dart';

class AppNavItem extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final bool isActive;
  final double iconSize;

  const AppNavItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.label,
    this.isActive = false,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive 
        ? AppColors.selectedIcon 
        : AppColors.nonSelectedIcon;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: color,
            ),
            if (label != null) ...[
              const SizedBox(height: 4),
              Text(
                label!.toUpperCase(),
                style: HomeFonts.iconText(color),
              ),
            ],
          ],
        ),
      ),
    );
  }
}