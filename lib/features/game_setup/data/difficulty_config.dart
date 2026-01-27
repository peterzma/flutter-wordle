abstract class DifficultyConfig {
  DifficultyConfig._();

  static const Map<int, (String label, String attempts)> levels = {
    1: ('1st Year', '8'),
    2: ('2nd Year', '7'),
    3: ('3rd Year', '6'),
    4: ('Postgrad', '5'),
  };

  static (String label, String attempts) getByLevel(int level) {
    return levels[level] ?? levels[1]!;
  }

  static String getAttemptsByLabel(String label) {
    final match = levels.values.cast<(String, String)?>().firstWhere(
          (e) => e?.$1.toLowerCase() == label.toLowerCase(),
          orElse: () => null,
        );
    
    return match?.$2 ?? levels[1]!.$2;
  }
}