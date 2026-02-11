import 'package:animal_facts_app/domain/entities/animal.dart';
import 'package:animal_facts_app/providers/animal_provider.dart';
import 'package:animal_facts_app/providers/progress_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class QuizState {
  final Animal currentAnimal;
  final List<String> options;
  final int? selectedIndex;
  final bool? isCorrect;
  final bool isAnswered;
  final int correctAnswerIndex;

  QuizState({
    required this.currentAnimal,
    required this.options,
    this.selectedIndex,
    this.isCorrect,
    required this.isAnswered,
    required this.correctAnswerIndex,
  });

  QuizState copyWith({
    Animal? currentAnimal,
    List<String>? options,
    int? selectedIndex,
    bool? isCorrect,
    bool? isAnswered,
    int? correctAnswerIndex,
  }) {
    return QuizState(
      currentAnimal: currentAnimal ?? this.currentAnimal,
      options: options ?? this.options,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      isAnswered: isAnswered ?? this.isAnswered,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
    );
  }
}

class QuizViewModel extends StateNotifier<QuizState> {
  QuizViewModel({required this.ref, required String? animalId})
      : super(_initState(ref, animalId));

  final Ref ref;

  static QuizState _initState(Ref ref, String? animalId) {
    final animals = ref.read(allAnimalsProvider);

    Animal animal;
    if (animalId != null) {
      animal = animals.firstWhere(
            (a) => a.id == animalId,
        orElse: () => animals.first,
      );
    } else {
      animal = animals[DateTime.now().millisecondsSinceEpoch % animals.length];
    }

    final (options, correctIndex) = _generateOptions(animal);

    return QuizState(
      currentAnimal: animal,
      options: options,
      isAnswered: false,
      correctAnswerIndex: correctIndex,
    );
  }

  static (List<String>, int) _generateOptions(Animal animal) {
    final correctFact = animal.interestingFact;

    final shuffledWrongs = List<String>.from(animal.wrongFacts)..shuffle();
    final selectedWrongs = shuffledWrongs.take(3).toList();

    final options = [correctFact, ...selectedWrongs];
    options.shuffle();

    final correctIndex = options.indexOf(correctFact);

    return (options, correctIndex);
  }

  void selectAnswer(int index) {
    if (state.isAnswered) return;

    final isCorrect = index == state.correctAnswerIndex;

    state = state.copyWith(
      selectedIndex: index,
      isCorrect: isCorrect,
      isAnswered: true,
    );

    ref.read(progressProvider.notifier).addQuizResult(
      state.currentAnimal.name,
      state.isCorrect ?? false,
    );

    if (state.isCorrect == true) {
      ref.read(progressProvider.notifier).addLearnedAnimal(
        state.currentAnimal.id,
      );
    }
  }

  void nextQuestion() {

    final animals = ref.read(allAnimalsProvider);
    final newAnimal = animals[DateTime.now().millisecondsSinceEpoch % animals.length];
    final (newOptions, newCorrectIndex) = _generateOptions(newAnimal);

    state = QuizState(
      currentAnimal: newAnimal,
      options: newOptions,
      isAnswered: false,
      correctAnswerIndex: newCorrectIndex,
    );
  }

  void resetCurrentQuestion() {
    if (state.isAnswered == false) return; // Нечего сбрасывать

    final (newOptions, newCorrectIndex) = _generateOptions(state.currentAnimal);

    state = state.copyWith(
      options: newOptions,
      selectedIndex: null,
      isCorrect: null,
      isAnswered: false,
      correctAnswerIndex: newCorrectIndex,
    );
  }
}

final quizViewModelProvider = StateNotifierProvider.family<QuizViewModel, QuizState, String?>(
      (ref, animalId) => QuizViewModel(ref: ref, animalId: animalId),
);