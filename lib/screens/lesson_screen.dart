import 'package:flutter/material.dart';
import 'package:quran_words/services/progress_service.dart';
import '../models/quran_word.dart';
import '../services/word_service.dart';
import '../widgets/word_card.dart';
import 'training_screen.dart';

class LessonScreen extends StatefulWidget {
  final int lesson;

  LessonScreen({required this.lesson});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late Future<List<QuranWord>> _wordsFuture;
  late PageController _controller;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _wordsFuture = WordService.loadWordsByLesson(widget.lesson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Урок ${widget.lesson}')),
      body: FutureBuilder<List<QuranWord>>(
        future: _wordsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final words = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: words.length,
                    onPageChanged: (i) => setState(() => _current = i),
                    itemBuilder: (context, index) => WordCard(word: words[index]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_current + 1}/${words.length}'),
                      ElevatedButton(
                        onPressed: words[_current].isLearned
                            ? null
                            : () {
                                setState(() {
                                  words[_current].isLearned = true;
                                });
                                ProgressService
                                    .markWordsLearned([words[_current].id]);
                                if (_current < words.length - 1) {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TrainingScreen(
                                              words: words,
                                              lesson: widget.lesson,
                                            )),
                                  );
                                }
                              },
                        child: Text(words[_current].isLearned
                            ? 'Изучено ✅'
                            : 'Изучено'),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки слов'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
