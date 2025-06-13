import 'package:flutter/material.dart';
import '../services/word_service.dart';
import 'lesson_screen.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Уроки')),
      body: FutureBuilder<int>(
        future: WordService.lessonCount(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final count = snapshot.data!;
            return ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                final lessonNum = index + 1;
                return ListTile(
                  title: Text('Урок $lessonNum'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonScreen(lesson: lessonNum),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки уроков'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
