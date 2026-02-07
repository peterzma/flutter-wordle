import 'package:uniordle/shared/exports/app_exports.dart';

abstract class AppColorsDark {
  // Game Logic
  static const Color correctColor = Color(0xFF4caf50); // Success / Correct
  static const Color inWordColor = Color(0XFFEAD637); // Warning / In Word
  static const Color notInWordColor = Color(0xFF475569); // Wrong / Not in Word

  // Backgrounds
  static const Color surface = Color(0xFF00121f); // Main background
  static const Color surfaceDialog = Color(0xFF060C16); // Only for dialog boxs
  static const Color surfaceVariant = Color(
    0xFF001a2c,
  ); // Cards,keyboard buttons

  // Content (Text/Icons)
  static const Color onSurface = Color(0xFFF8FAFC); // High emphasis text
  static const Color onSurfaceVariant = Color(
    0xFF94A3B8,
  ); // Medium emphasis / secondary text / inactive
  static const Color outline = Color(0xFF334155);

  // UI Accents
  static const Color accent = Color(
    0xFF3B82F6,
  ); // Active icons/selection / Basic
  static const Color accent2 = Color(0xFFEF4444); // Negative / Loss etc
  static const Color accent3 = Color(
    0xFFF4D35E,
  ); // Good, Merits / Positive (End Game Completionist)
  static const Color accent4 = Color(0xFFF18F01); // Very good / Best (Ranks)

  // Major Specific Colors
  static const Color majorEngineering = Color(0xFF4DD0E1);
  static const Color majorCS = Color(0xFF7986CB);
  static const Color majorMedicine = Color(0xFFF06292);
  static const Color majorLaw = Color(0xFFFFB74D);
  static const Color majorPsychology = Color(0xFFBA68C8);
  static const Color majorArts = Color(0xFFE57373);
  static const Color majorHumanities = Color(0xFFFFF176);
  static const Color majorEducation = Color(0xFF81D4FA);
  static const Color majorMaths = Color(0xFF9575CD);
  static const Color majorMusic = Color(0xFFC5E1A5);
  static const Color majorArchitecture = Color(0xFF80CBC4);
  static const Color majorNursing = Color(0xFFFFAB91);
  static const Color majorHistory = Color(0xFFBCAAA4);
  static const Color majorJournalism = Color(0xFFB0BEC5);
  static const Color majorAstronomy = Color(0xFF9FA8DA);
  static const Color majorPhilosophy = Color(0xFFECEFF1);
  static const Color majorPhysics = Color(0xFFCE93D8);
  static const Color majorChemistry = Color(0xFFA5D6A7);
  static const Color majorBiology = Color(0xFFDCE775);
  static const Color majorEconomics = Color(0xFF81C784);
}
