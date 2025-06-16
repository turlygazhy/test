import 'package:flutter/material.dart';
import '../models/quran_word.dart';

class WordCard extends StatelessWidget {
  final QuranWord word;
  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                word.arabic,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(word.transcription, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 8),
              Text(word.translation, style: const TextStyle(fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
