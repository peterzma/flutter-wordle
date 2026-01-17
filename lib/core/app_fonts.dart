import 'package:flutter/material.dart';

class AppTextStyles {
  static const String displayFont = 'Lexend';
  static const String uiFont = 'PlusJakartaSans';

  // Display Styles
  static TextStyle get gameTitle => const TextStyle(
        fontFamily: displayFont,
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      );

  static TextStyle get tileNumber => const TextStyle(
        fontFamily: displayFont,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  // UI Styles
  static TextStyle get buttonText => const TextStyle(
        fontFamily: uiFont,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      );

  static TextStyle get smallLabel => const TextStyle(
        fontFamily: uiFont,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        letterSpacing: 1.1,
      );

  static TextStyle get microData => const TextStyle(
        fontFamily: uiFont,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: Colors.blueAccent,
      );
}

class GameFonts {
  static TextStyle get titleText => AppTextStyles.gameTitle.copyWith(fontSize: 24, fontWeight: FontWeight.w600);
  
  static TextStyle get tileText => AppTextStyles.tileNumber;

  static TextStyle get keyText => AppTextStyles.tileNumber.copyWith(fontSize: 24, fontWeight: FontWeight.w900);
}

class GameSetUpFonts {
  static TextStyle get yearLevelText => AppTextStyles.gameTitle.copyWith(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.2);
  
  static TextStyle get attemptsAllowedText => AppTextStyles.smallLabel.copyWith(color: Colors.blue, fontWeight: FontWeight.bold, letterSpacing: 1.5);

  static TextStyle get yearLabelBase => AppTextStyles.smallLabel.copyWith(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white54);

  static TextStyle get yearLabelActive => AppTextStyles.smallLabel.copyWith(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle get attemptsInactiveText => AppTextStyles.smallLabel.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white54);

  static TextStyle get attemptsActiveText => AppTextStyles.smallLabel.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF64B5F6));

  static const IconData attemptsIcon = Icons.favorite;

  static TextStyle get closeButtonText => AppTextStyles.buttonText.copyWith(color: Colors.blueGrey, fontSize: 15, fontWeight: FontWeight.w600);

  static TextStyle get gameSettingsText => AppTextStyles.smallLabel.copyWith(color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 2);

  static TextStyle get playGameText => AppTextStyles.buttonText.copyWith(color: const Color(0xFF0A0E17), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.1);

  static TextStyle get wordLengthText => AppTextStyles.smallLabel.copyWith(color: Colors.blueGrey, fontWeight: FontWeight.bold, letterSpacing: 0.15 * 11);

  static TextStyle get numberOfLettersText => AppTextStyles.tileNumber;

  static TextStyle get lettersText => AppTextStyles.smallLabel.copyWith(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white70);

  static TextStyle get disciplineText => AppTextStyles.gameTitle.copyWith(fontSize: 32, fontWeight: FontWeight.w800);
}

class HomeFonts {
  static TextStyle get disciplineText => AppTextStyles.buttonText.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get titleText => AppTextStyles.gameTitle;

  static TextStyle get mainHeroText => AppTextStyles.gameTitle.copyWith(fontSize: 40, letterSpacing: -1, fontWeight: FontWeight.w900);

  static TextStyle get subHeroText => AppTextStyles.smallLabel.copyWith(fontSize: 14, color: Colors.blueGrey, height: 1.5);

  static TextStyle iconText(Color color) => AppTextStyles.microData.copyWith(letterSpacing: 1.4, color: color);

  static TextStyle tagText(Color color) => AppTextStyles.microData.copyWith(color: color);
}