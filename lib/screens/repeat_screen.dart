import 'package:flutter/material.dart';
import '../models/quran_word.dart';
import '../services/word_service.dart';
import 'training_screen.dart';

class RepeatScreen extends StatefulWidget {
  const RepeatScreen({super.key});

  @override
  State<RepeatScreen> createState() => _RepeatScreenState();
}

class _RepeatScreenState extends State<RepeatScreen> {
  late Future<List<QuranWord>> _future;

  @override
  void initState() {
    super.initState();
    _future = WordService.loadWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Повторение')),
      body: FutureBuilder<List<QuranWord>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final words = snapshot.data!.where((w) => w.isLearned).toList();
            if (words.isEmpty) {
              return const Center(child: Text('Нет выученных слов'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: words
                        .map((w) => ListTile(
                              title: Text(w.arabic),
                              subtitle: Text(w.translation),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text('Тренировка'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TrainingScreen(words: words)),
                      );
                    },
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
