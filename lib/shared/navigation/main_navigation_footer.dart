import 'package:uniordle/shared/exports/core_exports.dart';

class MainNavigationFooter extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabChange;

  const MainNavigationFooter({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return BaseFooter(
      children: [
        NavigationItem(
          icon: AppIcons.footerStats,
          label: 'Stats',
          isActive: activeTab == 'stats',
          onTap: () => onTabChange('stats'),
        ),
        NavigationItem(
          icon: AppIcons.footerHome,
          label: 'Home',
          isActive: activeTab == 'home',
          onTap: () => onTabChange('home'),
        ),
        NavigationItem(
          icon: AppIcons.footerProfile,
          label: 'Profile',
          isActive: activeTab == 'profile',
          onTap: () => onTabChange('profile'),
        ),
      ],
    );
  }
}
