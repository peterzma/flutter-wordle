import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/navigation/navigation_item.dart';
import 'package:uniordle/shared/layout/base_footer.dart';


class MainNavigationFooter extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabChange;
  
  const MainNavigationFooter({
    super.key, 
    required this.activeTab, 
    required this.onTabChange
  });


  @override
  Widget build (BuildContext context) {
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