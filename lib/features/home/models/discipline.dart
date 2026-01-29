import 'package:uniordle/shared/exports/home_exports.dart';

class Discipline {
  final String id;
  final String name;
  final String icon;
  final String tag;
  final Color color;
  final bool isLocked;
  final int totalWords;
  
  Discipline({
    required this.id,
    required this.name,
    required this.icon,
    required this.tag,
    required this.color,
    required this.totalWords,
    this.isLocked = true,
  });
}