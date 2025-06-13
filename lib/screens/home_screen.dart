import 'package:flutter/material.dart';
import 'lessons_screen.dart';
import 'repeat_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('500 слов из Корана'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('📚 Уроки'),
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
    );
  }
}
