import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const _completedLessonsKey = 'completed_lessons';
  static const _learnedWordsKey = 'learned_words';

  static Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  static Future<Set<int>> getCompletedLessons() async {
    final prefs = await _prefs();
    final list = prefs.getStringList(_completedLessonsKey) ?? [];
    return list.map(int.parse).toSet();
  }

  static Future<void> completeLesson(int lesson) async {
    final prefs = await _prefs();
    final set = await getCompletedLessons();
    if (set.add(lesson)) {
      await prefs.setStringList(
        _completedLessonsKey,
        set.map((e) => e.toString()).toList(),
      );
    }
  }

  static Future<bool> isLessonCompleted(int lesson) async {
    final completed = await getCompletedLessons();
    return completed.contains(lesson);
  }

  static Future<Set<int>> getLearnedWordIds() async {
    final prefs = await _prefs();
    final list = prefs.getStringList(_learnedWordsKey) ?? [];
    return list.map(int.parse).toSet();
  }

  static Future<void> markWordsLearned(List<int> ids) async {
    final prefs = await _prefs();
    final set = await getLearnedWordIds();
    final initialLen = set.length;
    set.addAll(ids);
    if (set.length != initialLen) {
      await prefs.setStringList(
        _learnedWordsKey,
        set.map((e) => e.toString()).toList(),
      );
    }
  }
}
