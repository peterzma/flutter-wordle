import 'package:uniordle/shared/home_screen_exports.dart';
import 'package:uniordle/shared/widgets/base_footer.dart';


class HomeFooter extends StatelessWidget implements PreferredSizeWidget {
  final String activeTab;
  final Function(String) onTabChange;
  
  const HomeFooter({
    super.key, 
    required this.activeTab, 
    required this.onTabChange
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build (BuildContext context) {
    return BaseFooter(
        height: preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navItem('stats', 'Stats', LucideIcons.history),
              _navItem('home', 'home', LucideIcons.layoutGrid),
              _navItem('profile', 'Profile', LucideIcons.user),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String id, String label, IconData icon) {
    final bool isActive = activeTab == id;
    final Color color = isActive ? AppColors.selectedIcon : AppColors.nonSelectedIcon;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTabChange(id),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: HomeFonts.iconText(color),
          )
        ]
      )
    );
  }
}