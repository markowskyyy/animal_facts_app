class UserProgress {
  final int totalQuizzes;
  final int correctAnswers;
  final List<String> learnedAnimalIds;
  final List<Achievement> achievements;
  final List<QuizHistoryItem> history;

  UserProgress({
    required this.totalQuizzes,
    required this.correctAnswers,
    required this.learnedAnimalIds,
    required this.achievements,
    required this.history,
  });

  double get accuracy {
    if (totalQuizzes == 0) return 0;
    return (correctAnswers / totalQuizzes) * 100;
  }

  int get learnedCount => learnedAnimalIds.length;

  factory UserProgress.empty() {
    return UserProgress(
      totalQuizzes: 0,
      correctAnswers: 0,
      learnedAnimalIds: [],
      achievements: [],
      history: [],
    );
  }

  UserProgress copyWith({
    int? totalQuizzes,
    int? correctAnswers,
    List<String>? learnedAnimalIds,
    List<Achievement>? achievements,
    List<QuizHistoryItem>? history,
  }) {
    return UserProgress(
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      learnedAnimalIds: learnedAnimalIds ?? this.learnedAnimalIds,
      achievements: achievements ?? this.achievements,
      history: history ?? this.history,
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String icon;
  bool isUnlocked;

  Achievement({
    required this.id,
    required this.title,
    required this.icon,
    this.isUnlocked = false,
  });
}

class QuizHistoryItem {
  final String animalName;
  final DateTime timestamp;
  final bool isCorrect;

  QuizHistoryItem({
    required this.animalName,
    required this.timestamp,
    required this.isCorrect,
  });
}