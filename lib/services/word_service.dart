import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/quran_word.dart';
import 'progress_service.dart';

class WordService {
  static Future<List<QuranWord>> loadWords() async {
    final String jsonString = await rootBundle.loadString('assets/words.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final words = jsonList.map((json) => QuranWord.fromJson(json)).toList();
    final learned = await ProgressService.getLearnedWordIds();
    for (final w in words) {
      if (learned.contains(w.id)) {
        w.isLearned = true;
      }
    }
    return words;
  }

  static Future<List<QuranWord>> loadWordsByLesson(int lesson) async {
    final words = await loadWords();
    return words.where((w) => w.lesson == lesson).toList();
  }

  static Future<List<QuranWord>> loadUnlearnedWordsByLesson(int lesson) async {
    final words = await loadWordsByLesson(lesson);
    return words.where((w) => !w.isLearned).toList();
  }

  static Future<int> lessonCount() async {
    final words = await loadWords();
    return words.map((w) => w.lesson).toSet().length;
  }
}
