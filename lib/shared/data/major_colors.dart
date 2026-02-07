import 'package:flutter/material.dart';

class MajorColors extends ThemeExtension<MajorColors> {
  final Map<String, Color> map;

  MajorColors({required this.map});

  @override
  ThemeExtension<MajorColors> copyWith({Map<String, Color>? map}) {
    return MajorColors(map: map ?? this.map);
  }

  @override
  ThemeExtension<MajorColors> lerp(
    ThemeExtension<MajorColors>? other,
    double t,
  ) {
    if (other is! MajorColors) return this;
    return other;
  }
}
