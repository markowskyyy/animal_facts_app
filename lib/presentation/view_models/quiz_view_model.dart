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

  QuizState({
    required this.currentAnimal,
    required this.options,
    this.selectedIndex,
    this.isCorrect,
    required this.isAnswered,
  });

  QuizState copyWith({
    Animal? currentAnimal,
    List<String>? options,
    int? selectedIndex,
    bool? isCorrect,
    bool? isAnswered,
  }) {
    return QuizState(
      currentAnimal: currentAnimal ?? this.currentAnimal,
      options: options ?? this.options,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      isAnswered: isAnswered ?? this.isAnswered,
    );
  }
}

// Простой ViewModel
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

    final options = _generateOptions(animal);

    return QuizState(
      currentAnimal: animal,
      options: options,
      isAnswered: false,
    );
  }

  static List<String> _generateOptions(Animal animal) {
    final correctFact = animal.interestingFact;

    final shuffledWrongs = List<String>.from(animal.wrongFacts)..shuffle();
    final selectedWrongs = shuffledWrongs.take(3).toList();

    final options = [correctFact, ...selectedWrongs];
    options.shuffle();
    return options;
  }

  void selectAnswer(int index) {
    if (state.isAnswered) return;

    final isCorrect = state.options[index] == state.currentAnimal.interestingFact;

    state = state.copyWith(
      selectedIndex: index,
      isCorrect: isCorrect,
      isAnswered: true,
    );
  }

  void nextQuestion() {
    ref.read(progressProvider.notifier).addQuizResult(
      state.currentAnimal.name,
      state.isCorrect ?? false,
    );

    if (state.isCorrect == true) {
      ref.read(progressProvider.notifier).addLearnedAnimal(
        state.currentAnimal.id,
      );
    }

    final animals = ref.read(allAnimalsProvider);
    final newAnimal = animals[DateTime.now().millisecondsSinceEpoch % animals.length];
    final newOptions = _generateOptions(newAnimal);

    state = QuizState(
      currentAnimal: newAnimal,
      options: newOptions,
      isAnswered: false,
    );
  }
}

final quizViewModelProvider = StateNotifierProvider.family<QuizViewModel, QuizState, String?>(
      (ref, animalId) => QuizViewModel(ref: ref, animalId: animalId),
);