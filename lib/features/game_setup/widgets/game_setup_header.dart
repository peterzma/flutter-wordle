import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class GameSetupHeader extends StatelessWidget implements PreferredSizeWidget {
  const GameSetupHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: '',
      leftIcon: AppIcons.leftArrow,
      onLeftTap: () => Navigator.of(context).pop(),
      height: 72,
    );
  }
}