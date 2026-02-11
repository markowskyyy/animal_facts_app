import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';


class AnswerCard extends StatelessWidget {
  final String text;
  final int index;
  final int? selectedIndex;
  final int correctAnswerIndex;
  final bool isAnswered;
  final VoidCallback onTap;

  const AnswerCard({
    super.key,
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.correctAnswerIndex,
    required this.isAnswered,
    required this.onTap,
  });

  bool get isSelected => selectedIndex == index;
  bool get isCorrectAnswer => index == correctAnswerIndex;

  Color get _backgroundColor {
    if (!isSelected && !(isCorrectAnswer && isAnswered)) {
      return AppColors.white;
    }
    if (isSelected && isCorrectAnswer) return AppColors.green.withOpacity(0.1);
    if (isSelected && !isCorrectAnswer) return AppColors.red.withOpacity(0.1);
    if (!isSelected && isCorrectAnswer && isAnswered) {
      return AppColors.green.withOpacity(0.1);
    }
    return AppColors.white;
  }

  Color get _borderColor {
    if (!isAnswered) return Colors.transparent;
    if (isCorrectAnswer) return AppColors.green;
    if (isSelected && !isCorrectAnswer) return AppColors.red;
    return Colors.transparent;
  }

  Color get _textColor {
    if (!isAnswered) return AppColors.darkText;
    if (isCorrectAnswer) return AppColors.green;
    if (isSelected && !isCorrectAnswer) return AppColors.red;
    return AppColors.darkText;
  }

  Color get _iconColor {
    if (isCorrectAnswer) return AppColors.green;
    if (isSelected && !isCorrectAnswer) return AppColors.red;
    return AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isAnswered ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _borderColor, width: 2),
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
            if (isAnswered && isCorrectAnswer)
              const Icon(Icons.check_circle, color: AppColors.green, size: 20)
            else if (isAnswered && isSelected && !isCorrectAnswer)
              const Icon(Icons.cancel, color: AppColors.red, size: 20)
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
                  color: _textColor,
                  fontWeight: (isSelected || isCorrectAnswer) && isAnswered
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}