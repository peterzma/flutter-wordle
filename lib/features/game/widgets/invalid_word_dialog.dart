import 'dart:async';
import 'package:uniordle/shared/exports/game_exports.dart';

class InvalidWordDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (dialogContext) {
        
        Timer(const Duration(milliseconds: 700), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });

        return BaseDialog(
          blur: 0.0,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(
            'Word not found',
            textAlign: TextAlign.center,
            style: AppFonts.displayMedium,
          ),
        );
      },
    );
  }
}