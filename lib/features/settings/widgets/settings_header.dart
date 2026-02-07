import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsHeader extends StatelessWidget {
  final String title;

  const SettingsHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.r(16), bottom: context.r(8)),
      child: Text(title.toUpperCase(), style: context.labelMedium),
    );
  }
}
