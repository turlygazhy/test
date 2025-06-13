import 'package:flutter/material.dart';
import '../models/quran_word.dart';

class WordCard extends StatelessWidget {
  final QuranWord word;
  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(word.arabic, style: const TextStyle(fontSize: 36)),
              const SizedBox(height: 16),
              Text(word.transcription, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              Text(word.translation, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
