import 'package:animal_facts_app/domain/entities/user_progress.dart';
import 'package:animal_facts_app/providers/animal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in main.dart');
});

// Состояние прогресса
class ProgressNotifier extends StateNotifier<UserProgress> {
  ProgressNotifier(this.ref) : super(UserProgress.empty());

  final Ref ref;

  Future<void> loadProgress() async {
    final prefs = ref.read(sharedPrefsProvider);

    final learnedIds = prefs.getStringList('learned_animal_ids') ?? [];

    final totalQuizzes = prefs.getInt('total_quizzes') ?? 0;
    final correctAnswers = prefs.getInt('correct_answers') ?? 0;

    state = UserProgress(
      totalQuizzes: totalQuizzes,
      correctAnswers: correctAnswers,
      learnedAnimalIds: learnedIds,
      achievements: [],
      history: [],
    );

    _syncLearnedStatus();
  }

  void _syncLearnedStatus() {
    final animals = ref.read(allAnimalsProvider);
    for (var animal in animals) {
      animal.isLearned = state.learnedAnimalIds.contains(animal.id);
    }
  }

  Future<void> addLearnedAnimal(String animalId) async {
    if (state.learnedAnimalIds.contains(animalId)) return;

    final updatedIds = [...state.learnedAnimalIds, animalId];

    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setStringList('learned_animal_ids', updatedIds);

    state = state.copyWith(learnedAnimalIds: updatedIds);
    _syncLearnedStatus();
  }

  Future<void> addQuizResult(String animalName, bool isCorrect) async {
    final prefs = ref.read(sharedPrefsProvider);

    final totalQuizzes = state.totalQuizzes + 1;
    final correctAnswers = state.correctAnswers + (isCorrect ? 1 : 0);

    await prefs.setInt('total_quizzes', totalQuizzes);
    await prefs.setInt('correct_answers', correctAnswers);

    state = state.copyWith(
      totalQuizzes: totalQuizzes,
      correctAnswers: correctAnswers,
    );
  }

  Future<void> resetProgress() async {
    final prefs = ref.read(sharedPrefsProvider);

    await prefs.remove('learned_animal_ids');
    await prefs.remove('total_quizzes');
    await prefs.remove('correct_answers');

    state = UserProgress.empty();
    _syncLearnedStatus();
  }
}

final progressProvider = StateNotifierProvider<ProgressNotifier, UserProgress>((ref) {
  return ProgressNotifier(ref);
});