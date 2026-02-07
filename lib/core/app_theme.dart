import 'package:uniordle/shared/exports/app_exports.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColorsDark.surface,
      textTheme: _buildTextTheme(Brightness.dark),
      colorScheme: const ColorScheme.dark(
        surface: AppColorsDark.surface,
        onSurface: AppColorsDark.onSurface,
        primary: AppColorsDark.accent,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColorsLight.surface,
      textTheme: _buildTextTheme(Brightness.light),
      colorScheme: const ColorScheme.light(
        surface: AppColorsLight.surface,
        onSurface: AppColorsLight.onSurface,
        primary: AppColorsLight.accent,
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final Color primaryText = isDark
        ? AppColorsDark.onSurface
        : AppColorsLight.onSurface;
    final Color secondaryText = isDark
        ? AppColorsDark.onSurfaceVariant
        : AppColorsLight.onSurfaceVariant;
    final Color accentText = isDark
        ? AppColorsDark.accent
        : AppColorsLight.accent;

    return TextTheme(
      displayLarge: AppFonts.displayLarge.copyWith(color: primaryText),
      displayMedium: AppFonts.displayMedium.copyWith(color: primaryText),
      headlineMedium: AppFonts.headlineMedium.copyWith(color: primaryText),
      labelLarge: AppFonts.labelLarge.copyWith(color: primaryText),
      labelMedium: AppFonts.labelMedium.copyWith(color: secondaryText),
      labelSmall: AppFonts.labelSmall.copyWith(color: accentText),
    );
  }
}
