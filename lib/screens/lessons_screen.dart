import 'package:flutter/material.dart';
import '../services/word_service.dart';
import '../services/progress_service.dart';
import 'lesson_screen.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Уроки')),
      body: FutureBuilder<List<Object>>(
        future: Future.wait([
          WordService.lessonCount(),
          ProgressService.getCompletedLessons(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final count = snapshot.data![0] as int;
            final completed = snapshot.data![1] as Set<int>;
            return ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                final lessonNum = index + 1;
                final locked = lessonNum > 1 && !completed.contains(lessonNum - 1);
                return ListTile(
                  title: Text('Урок $lessonNum'),
                  trailing: locked ? null : const Icon(Icons.chevron_right),
                  enabled: !locked,
                  onTap: locked
                      ? null
                      : () {
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
