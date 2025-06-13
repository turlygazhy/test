import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quran_word.dart';
import '../services/progress_service.dart';

class TrainingScreen extends StatefulWidget {
  final List<QuranWord> words;
  final int lesson;
  const TrainingScreen({super.key, required this.words, required this.lesson});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int _index = 0;
  int _correct = 0;
  late List<QuranWord> _words;

  @override
  void initState() {
    super.initState();
    _words = List<QuranWord>.from(widget.words)..shuffle();
  }

  void _answer(String translation) {
    final current = _words[_index];
    if (translation == current.translation) {
      _correct++;
    }
    if (_index < _words.length - 1) {
      setState(() {
        _index++;
      });
    } else {
      ProgressService.markWordsLearned(widget.words.map((w) => w.id).toList());
      ProgressService.completeLesson(widget.lesson);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Результат'),
          content: Text('Правильных ответов: $_correct из ${_words.length}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final word = _words[_index];
    final options = [word.translation];
    final otherWords = _words.where((w) => w != word).toList();
    otherWords.shuffle();
    for (var i = 0; i < 3 && i < otherWords.length; i++) {
      options.add(otherWords[i].translation);
    }
    options.shuffle(Random());

    return Scaffold(
      appBar: AppBar(title: const Text('Тренировка')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(word.arabic, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            ...options.map((o) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _answer(o),
                    child: Text(o),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
