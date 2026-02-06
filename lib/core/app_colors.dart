import 'package:flutter/material.dart';

abstract class AppColors {
  // Game Logic
  static const Color correctColor = Colors.green; // Success / Correct
  static const Color inWordColor = Color(0XFFEAD637); // Warning / In Word
  static const Color notInWordColor = Color(0xFF475569); // Gray / Not in Word
  
  // Backgrounds
  static const Color surface = Color(0xFF00121f); // Main dark background
  static const Color surfaceDialog = Color(0xFF060C16); // Main dark background
  static const Color surfaceVariant = Color(0x401A1F2E); // Cards, tiles, keyboard buttons
  static const Color gameTiles = Color(0xFF1A1F2E); // Cards, tiles, keyboard buttons
  
  // Content (Text/Icons)
  static const Color onSurface = Color(0xFFF8FAFC); // High emphasis text
  static const Color onSurfaceVariant = Color(0xFF94A3B8); // Medium emphasis / secondary text / inactive
  static const Color outline = Color(0xFF334155);

  // UI Accents
  static const Color accent = Color(0xFF3B82F6); // Active icons/selection / Basic
  static const Color accent2 = Color(0xFFEF4444); // Negative / Loss etc
  static const Color accent3 = Color(0xFFF4D35E); // Good, Merits / Positive
  static const Color accent4 = Color(0xFFF18F01); // Very good
}