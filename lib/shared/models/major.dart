import 'package:uniordle/shared/exports/core_exports.dart';

class Major {
  final String id;
  final String name;
  final IconData icon;
  final String tag;
  final Color color;
  final bool isLocked;
  final int totalWords;

  Major({
    required this.id,
    required this.name,
    required this.icon,
    required this.tag,
    required this.color,
    required this.totalWords,
    this.isLocked = true,
  });

  /// Mock data for testing and previews
  factory Major.mock() {
    return Major(
      id: 'cs_101',
      name: 'Computer Science',
      icon: Icons.laptop,
      tag: 'STEM',
      color: const Color(0xFF2196F3),
      totalWords: 150,
      isLocked: false,
    );
  }

  /// Handy for state management or testing different UI states
  Major copyWith({String? name, Color? color, bool? isLocked}) {
    return Major(
      id: id,
      name: name ?? this.name,
      icon: icon,
      tag: tag,
      color: color ?? this.color,
      totalWords: totalWords,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
