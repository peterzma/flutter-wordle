import 'package:uniordle/shared/exports/app_exports.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColors.surface,

      canvasColor: Colors.transparent,
    ).copyWith(
      textTheme: TextTheme(
        displayLarge: AppFonts.displayMedium,
        headlineMedium: AppFonts.displayLarge,
        labelLarge: AppFonts.labelLarge,
        labelSmall: AppFonts.labelMedium,
      ),
    );
  }
}
