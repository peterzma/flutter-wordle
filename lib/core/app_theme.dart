import 'package:uniordle/shared/data/major_colors.dart';
import 'package:uniordle/shared/exports/app_exports.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColorsDark.surface,
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColorsDark.surfaceDialog,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      extensions: [
        GameColors(
          correct: AppColorsDark.correctColor,
          inWord: AppColorsDark.inWordColor,
          notInWord: AppColorsDark.notInWordColor,
        ),
        MajorColors(
          map: {
            'engineering': AppColorsDark.majorEngineering,
            'cs': AppColorsDark.majorCS,
            'medicine': AppColorsDark.majorMedicine,
            'law': AppColorsDark.majorLaw,
            'psychology': AppColorsDark.majorPsychology,
            'arts': AppColorsDark.majorArts,
            'humanities': AppColorsDark.majorHumanities,
            'education': AppColorsDark.majorEducation,
            'maths': AppColorsDark.majorMaths,
            'music': AppColorsDark.majorMusic,
            'architecture': AppColorsDark.majorArchitecture,
            'nursing': AppColorsDark.majorNursing,
            'history': AppColorsDark.majorHistory,
            'journalism': AppColorsDark.majorJournalism,
            'astronomy': AppColorsDark.majorAstronomy,
            'philosophy': AppColorsDark.majorPhilosophy,
            'physics': AppColorsDark.majorPhysics,
            'chemistry': AppColorsDark.majorChemistry,
            'biology': AppColorsDark.majorBiology,
            'economics': AppColorsDark.majorEconomics,
          },
        ),
      ],
      colorScheme: const ColorScheme.dark(
        surface: AppColorsDark.surface,
        onSurface: AppColorsDark.onSurface,
        primary: AppColorsDark.accent,
        secondary: AppColorsDark.accent3,
        tertiary: AppColorsDark.accent4,
        error: AppColorsDark.accent2,

        outline: AppColorsDark.outline,
        surfaceContainer: AppColorsDark.surfaceVariant,
        onSurfaceVariant: AppColorsDark.onSurfaceVariant,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColorsLight.surface,
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColorsLight.surfaceDialog,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      extensions: [
        GameColors(
          correct: AppColorsLight.correctColor,
          inWord: AppColorsLight.inWordColor,
          notInWord: AppColorsLight.notInWordColor,
        ),
        MajorColors(
          map: {
            'engineering': AppColorsLight.majorEngineering,
            'cs': AppColorsLight.majorCS,
            'medicine': AppColorsLight.majorMedicine,
            'law': AppColorsLight.majorLaw,
            'psychology': AppColorsLight.majorPsychology,
            'arts': AppColorsLight.majorArts,
            'humanities': AppColorsLight.majorHumanities,
            'education': AppColorsLight.majorEducation,
            'maths': AppColorsLight.majorMaths,
            'music': AppColorsLight.majorMusic,
            'architecture': AppColorsLight.majorArchitecture,
            'nursing': AppColorsLight.majorNursing,
            'history': AppColorsLight.majorHistory,
            'journalism': AppColorsLight.majorJournalism,
            'astronomy': AppColorsLight.majorAstronomy,
            'philosophy': AppColorsLight.majorPhilosophy,
            'physics': AppColorsLight.majorPhysics,
            'chemistry': AppColorsLight.majorChemistry,
            'biology': AppColorsLight.majorBiology,
            'economics': AppColorsLight.majorEconomics,
          },
        ),
      ],
      colorScheme: const ColorScheme.light(
        surface: AppColorsLight.surface,
        onSurface: AppColorsLight.onSurface,
        primary: AppColorsLight.accent,
        secondary: AppColorsLight.accent3,
        tertiary: AppColorsLight.accent4,
        error: AppColorsLight.accent2,

        outline: AppColorsLight.outline,
        surfaceContainer: AppColorsLight.surfaceVariant,
        onSurfaceVariant: AppColorsLight.onSurfaceVariant,
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
