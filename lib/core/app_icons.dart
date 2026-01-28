import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

abstract class AppIcons {
  static const IconData leftArrow = LucideIcons.chevronLeft;
  static const IconData rightArrow = LucideIcons.chevronRight;
  static const IconData help = LucideIcons.helpCircle;

  static const IconData heart = Icons.favorite;
}

class IconMapper {
  static IconData getIcon(String name) {
    switch (name) {
      case 'settings': return LucideIcons.settings;
      case 'code': return LucideIcons.code;
      case 'heart_pulse': return LucideIcons.heartPulse;
      case 'scale': return LucideIcons.scale;
      case 'brain': return LucideIcons.brain;
      case 'palette': return LucideIcons.palette;
      case 'briefcase': return LucideIcons.briefcase;
      case 'book_open': return LucideIcons.bookOpen;
      case 'graduation_cap': return LucideIcons.graduationCap;
      case 'calculator': return LucideIcons.calculator;
      case 'music': return LucideIcons.music;
      case 'flask_conical': return LucideIcons.flaskConical;
      case 'pen_tool': return LucideIcons.penTool;
      case 'building_2': return LucideIcons.building2;
      default: return LucideIcons.bookOpen;
    }
  }
}