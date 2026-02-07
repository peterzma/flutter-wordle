import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/features/game/models/letter_model.dart';

extension ThemeHelper on BuildContext {
  // Use: context.theme
  ThemeData get theme => Theme.of(this);

  // Use: context.textTheme.displayLarge
  TextTheme get textTheme => theme.textTheme;

  // Use: context.colorScheme.primary
  ColorScheme get colorScheme => theme.colorScheme;

  // Use: context.dialogBackground
  Color get dialogBackground =>
      theme.dialogTheme.backgroundColor ?? colorScheme.surface;

  // Use: context.gameColors.correct
  GameColors get gameColors => theme.extension<GameColors>()!;

  // Use: context.outline
  Color get outline => colorScheme.outline;

  // Use: context.surface
  Color get surface => colorScheme.surface;

  // Use: context.surfaceVariant
  Color get surfaceVariant => colorScheme.surfaceContainer;

  // Use: context.onSurface
  Color get onSurface => colorScheme.onSurface;

  // Use: context.onSurfaceVariant
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;

  // Use: context.getLetterBgColor(letter.status)
  Color getLetterBgColor(LetterStatus status) {
    switch (status) {
      case LetterStatus.initial:
        return surfaceVariant;
      case LetterStatus.notInWord:
        return gameColors.notInWord!;
      case LetterStatus.inWord:
        return gameColors.inWord!;
      case LetterStatus.correct:
        return gameColors.correct!;
    }
  }

  // Use: context.getLetterBorderColor(letter)
  Color getLetterBorderColor(Letter letter) {
    switch (letter.status) {
      case LetterStatus.initial:
        return letter.val.isNotEmpty ? outline : surfaceVariant;
      case LetterStatus.notInWord:
      case LetterStatus.inWord:
      case LetterStatus.correct:
        return getLetterBgColor(letter.status);
    }
  }
}
