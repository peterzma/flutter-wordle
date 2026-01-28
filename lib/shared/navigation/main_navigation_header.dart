import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/features/help/views/help_dialog.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class MainNavigationHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MainNavigationHeader({
    super.key,
    this.title = 'Uniordle'
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppLayout.barHeight);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
        title: title,
        leftIcon: LucideIcons.settings,
        onLeftTap: () {
          Navigator.of(context).pushNamed('/settings');
        },
        rightIcon: LucideIcons.helpCircle,
        onRightTap: () {
          showDialog(
          context: context,
          barrierDismissible: true, 
          barrierColor: Colors.black.withValues(alpha: 0.4),
          builder: (context) => const HelpDialog(),
        );
      },
    );
  }
}
