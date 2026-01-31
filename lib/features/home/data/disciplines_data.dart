import 'package:flutter/material.dart';
import 'package:uniordle/features/home/models/major.dart';
import 'package:uniordle/shared/exports/word_lists_exports.dart';
import 'package:uniordle/features/game/data/word_list.dart';

class DisciplinesData {

  static List<String> getAllWordsForDiscipline(String id) {
    // Get the map for this major (e.g., engineeringWords)
    final Map<int, List<String>> wordMap = categorizedWords[id.toLowerCase()] ?? {};
    
    // Flatten all values (List of strings for 5, 6, 7 letters) into one list
    return wordMap.values
        .expand((list) => list)
        .map((word) => word.toUpperCase())
        .toList();
  }

  static int getWordCount(Map<int, List<String>> wordMap) {
    return wordMap.values.fold(0, (sum, list) => sum + list.length);
  }

  static List<Major> getSortedDisciplines(List<String> unlockedIds) {
    List<Major> sortedList = List.from(all);

    sortedList.sort((a, b) {
      bool isAUnlocked = unlockedIds.contains(a.id);
      bool isBUnlocked = unlockedIds.contains(b.id);

      // Sort by "Lockedness"
      if (isAUnlocked && !isBUnlocked) return -1;
      if (!isAUnlocked && isBUnlocked) return 1;

      // Sort Alphabetically
      return a.name.compareTo(b.name);
    });

    return sortedList;
  }

  static final List<Major> all = [
    Major(
      id: 'engineering',
      name: 'Engineering',
      icon: 'settings',
      totalWords: getWordCount(engineeringWords),
      tag: '${getWordCount(engineeringWords)} WORDS', 
      color: Colors.blue,
    ),
    Major(
      id: 'cs',
      name: 'CS',
      icon: 'code',
      totalWords: getWordCount(csWords),
      tag: '${getWordCount(csWords)} WORDS',
      color: Colors.red,
    ),
    Major(
      id: 'medicine',
      name: 'Medicine',
      icon: 'heart_pulse',
      totalWords: getWordCount(medicineWords),
      tag: '${getWordCount(medicineWords)} WORDS',
      color: Colors.pinkAccent,
    ),
    Major(
      id: 'law',
      name: 'Law',
      icon: 'scale',
      totalWords: getWordCount(lawWords),
      tag: '${getWordCount(lawWords)} WORDS',
      color: Colors.orangeAccent,
    ),
    Major(
      id: 'psychology',
      name: 'Psychology',
      icon: 'brain',
      totalWords: getWordCount(psychologyWords),
      tag: '${getWordCount(psychologyWords)} WORDS',
      color: Colors.purpleAccent,
    ),
    Major(
      id: 'arts',
      name: 'Arts',
      icon: 'palette',
      totalWords: getWordCount(artsWords),
      tag: '${getWordCount(artsWords)} WORDS',
      color: Colors.deepPurpleAccent,
    ),
    Major(
      id: 'business',
      name: 'Business',
      icon: 'briefcase',
      totalWords: getWordCount(businessWords),
      tag: '${getWordCount(businessWords)} WORDS',
      color: Colors.greenAccent,
    ),
    Major(
      id: 'humanities',
      name: 'Humanities',
      icon: 'book_open',
      totalWords: getWordCount(humanitiesWords),
      tag: '${getWordCount(humanitiesWords)} WORDS',
      color: Colors.amber,
    ),
    Major(
      id: 'education',
      name: 'Education',
      icon: 'graduation_cap',
      totalWords: getWordCount(educationWords),
      tag: '${getWordCount(educationWords)} WORDS',
      color: Colors.lightBlueAccent,
    ),
    Major(
      id: 'maths',
      name: 'Maths',
      icon: 'calculator',
      totalWords: getWordCount(mathsWords),
      tag: '${getWordCount(mathsWords)} WORDS',
      color: Colors.deepOrangeAccent,
    ),
    Major(
      id: 'music',
      name: 'Music',
      icon: 'music',
      totalWords: getWordCount(musicWords),
      tag: '${getWordCount(musicWords)} WORDS',
      color: Colors.lime,
    ),
    Major(
      id: 'science',
      name: 'Science',
      icon: 'flask_conical',
      totalWords: getWordCount(scienceWords),
      tag: '${getWordCount(scienceWords)} WORDS',
      color: Colors.tealAccent,
    ),
    Major(
      id: 'design',
      name: 'Design',
      icon: 'pen_tool',
      totalWords: getWordCount(designWords),
      tag: '${getWordCount(designWords)} WORDS',
      color: Colors.cyanAccent,
    ),
    Major(
      id: 'architecture',
      name: 'Architecture',
      icon: 'building_2',
      totalWords: getWordCount(architectureWords),
      tag: '${getWordCount(architectureWords)} WORDS',
      color: Colors.indigo,
    ),
  ]..sort((a, b) => a.name.compareTo(b.name));

}