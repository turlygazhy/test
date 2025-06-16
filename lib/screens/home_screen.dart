import 'package:flutter/material.dart';
import 'lessons_screen.dart';
import 'repeat_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('500 слов из Корана'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFB9F6CA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: const Text('📚 Уроки'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LessonsScreen()),
                  );
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text('🔁 Повторение'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RepeatScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text('📊 Статистика'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProgressScreen()),
                );
              },
            ),
          ],
        ),
        ),
      ),
    );
  }
}
