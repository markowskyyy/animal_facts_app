import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';


class ResultMessage extends StatelessWidget {
  final bool isCorrect;

  const ResultMessage({
    super.key,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
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