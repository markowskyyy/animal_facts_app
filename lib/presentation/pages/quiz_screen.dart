import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/design.dart';
import '../ui_kit/ui_kit.dart';
import '../view_models/quiz_view_model.dart';

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
      appBar: AppBar(
        title: const Text('Викторина'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Фото животного
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(animal.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(16),

            // Вопрос
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Какой из этих фактов о ${animal.name} является правдой?',
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(24),

            // Варианты ответов
            ...List.generate(quizState.options.length, (index) {
              return _buildAnswerCard(
                text: quizState.options[index],
                index: index,
                selectedIndex: quizState.selectedIndex,
                isCorrectAnswer: quizState.options[index] == animal.interestingFact,
                isAnswered: quizState.isAnswered,
                onTap: () => quizVM.selectAnswer(index),
              );
            }),
            const Gap(24),

            // Результат
            if (quizState.isAnswered) ...[
              _buildResultMessage(quizState.isCorrect ?? false),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton.primary(
                  text: 'Следующий вопрос',
                  onTap: () => quizVM.nextQuestion(),
                ),
              ),
            ],
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerCard({
    required String text,
    required int index,
    required int? selectedIndex,
    required bool isCorrectAnswer,
    required bool isAnswered,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedIndex == index;

    Color backgroundColor = AppColors.white;
    Color borderColor = Colors.transparent;
    Color textColor = AppColors.darkText;
    Color iconColor = AppColors.grey;

    if (isSelected) {
      if (isCorrectAnswer) {
        backgroundColor = AppColors.green.withOpacity(0.1);
        borderColor = AppColors.green;
        textColor = AppColors.green;
        iconColor = AppColors.green;
      } else {
        backgroundColor = AppColors.red.withOpacity(0.1);
        borderColor = AppColors.red;
        textColor = AppColors.red;
        iconColor = AppColors.red;
      }
    }

    return GestureDetector(
      onTap: !isAnswered ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSelected)
              Icon(
                isCorrectAnswer ? Icons.check_circle : Icons.cancel,
                color: iconColor,
                size: 20,
              )
            else
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grey),
                ),
              ),
            const Gap(12),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.body.copyWith(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultMessage(bool isCorrect) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.green.withOpacity(0.1)
            : AppColors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect ? AppColors.green : AppColors.red,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.error,
            color: isCorrect ? AppColors.green : AppColors.red,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              isCorrect
                  ? 'Правильно!'
                  : 'Почти! Правильный ответ выделен зелёным',
              style: AppTextStyles.body.copyWith(
                color: isCorrect ? AppColors.green : AppColors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}