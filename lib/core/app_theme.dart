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
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      textTheme: _buildTextTheme(Brightness.light),
      colorScheme: const ColorScheme.light(
        surface: Color(0xFFF8FAFC),
        onSurface: Color(0xFF0F172A),
        primary: AppColorsDark.accent,
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final Color primaryText = isDark
        ? AppColorsDark.onSurface
        : const Color(0xFF0F172A);
    final Color secondaryText = isDark
        ? AppColorsDark.onSurfaceVariant
        : const Color(0xFF64748B);
    final Color accentText = AppColorsDark.accent;

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
