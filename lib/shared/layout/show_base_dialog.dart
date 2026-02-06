import 'package:uniordle/shared/exports/core_exports.dart';

Future<T?> showBaseDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
  Color barrierColor = Colors.transparent,
  Duration transitionDuration = Duration.zero,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    pageBuilder: (context, anim1, anim2) => BaseDialog(child: child),
  );
}
