import 'package:flutter/material.dart';
import '../models/quran_word.dart';
import '../services/word_service.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuranWord>>(
      future: WordService.loadWords(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final words = snapshot.data!;
          final learned = words.where((w) => w.isLearned).length;
          final lessonCount = words.map((w) => w.lesson).toSet().length;
          final completedLessons = words
              .where((w) => w.isLearned)
              .map((w) => w.lesson)
              .toSet()
              .length;
          return Scaffold(
            appBar: AppBar(title: const Text('Статистика')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Пройдено уроков: $completedLessons из $lessonCount'),
                  const SizedBox(height: 8),
                  Text('Выучено слов: $learned / ${words.length}'),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(title: const Text('Статистика')),
              body: const Center(child: Text('Ошибка загрузки')));
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
