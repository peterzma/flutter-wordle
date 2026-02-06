import 'package:uniordle/shared/exports/game_setup_exports.dart';

class GameSetupHeader extends StatelessWidget implements PreferredSizeWidget {
  const GameSetupHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppLayout.marginHeight);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: '',
      leftIcon: AppIcons.navBack,
      onLeftTap: () => Navigator.of(context).pop(),
      height: AppLayout.marginHeight,
    );
  }
}
