import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:animal_facts_app/presentation/view_models/quiz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizScreen extends ConsumerWidget {
  final String? animalId;

  const QuizScreen({
    super.key,
    this.animalId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizViewModelProvider(animalId));
    final quizVM = ref.read(quizViewModelProvider(animalId).notifier);
    final animal = quizState.currentAnimal;

    return Scaffold(
      appBar: const QuizAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimalImage(imageUrl: animal.imageUrl),
            const Gap(16),
            QuestionText(animalName: animal.name),
            const Gap(24),

            ...List.generate(quizState.options.length, (index) {
              return AnswerCard(
                text: quizState.options[index],
                index: index,
                selectedIndex: quizState.selectedIndex,
                correctAnswerIndex: quizState.correctAnswerIndex,
                isAnswered: quizState.isAnswered,
                onTap: () => quizVM.selectAnswer(index),
              );
            }),
            const Gap(24),

            if (quizState.isAnswered) ...[
              ResultMessage(isCorrect: quizState.isCorrect ?? false),
              const Gap(16),
              NextButton(onTap: () => quizVM.nextQuestion()),
            ],
            const Gap(20),
          ],
        ),
      ),
    );
  }
}