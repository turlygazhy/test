class QuranWord {
  final int id;
  final int lesson;
  final String arabic;
  final String transcription;
  final String translation;
  bool isLearned;

  QuranWord({
    required this.id,
    required this.lesson,
    required this.arabic,
    required this.transcription,
    required this.translation,
    this.isLearned = false,
  });

  factory QuranWord.fromJson(Map<String, dynamic> json) {
    return QuranWord(
      id: json['id'],
      lesson: json['lesson'],
      arabic: json['arabic'],
      transcription: json['transcription'],
      translation: json['translation'],
      isLearned: json['isLearned'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lesson': lesson,
      'arabic': arabic,
      'transcription': transcription,
      'translation': translation,
      'isLearned': isLearned,
    };
  }
}
