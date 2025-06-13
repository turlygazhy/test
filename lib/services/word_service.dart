import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/quran_word.dart';

class WordService {
  static Future<List<QuranWord>> loadWords() async {
    final String jsonString = await rootBundle.loadString('assets/words.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => QuranWord.fromJson(json)).toList();
  }

  static Future<List<QuranWord>> loadWordsByLesson(int lesson) async {
    final words = await loadWords();
    return words.where((w) => w.lesson == lesson).toList();
  }

  static Future<int> lessonCount() async {
    final words = await loadWords();
    return words.map((w) => w.lesson).toSet().length;
  }
}
