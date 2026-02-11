import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';


class CollectionProgressBar extends StatelessWidget {
  final int learnedCount;
  final int totalCount;

  const CollectionProgressBar({
    super.key,
    required this.learnedCount,
    required this.totalCount,
  });

  double get _percent => totalCount == 0 ? 0 : (learnedCount / totalCount * 100);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Изучено животных',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                '$learnedCount из $totalCount',
                style: AppTextStyles.subtitle,
              ),
            ],
          ),
          const Gap(12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: learnedCount / totalCount,
              backgroundColor: AppColors.lightGrey,
              color: AppColors.green,
              minHeight: 8,
            ),
          ),
          const Gap(8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_percent.toStringAsFixed(0)}% завершено',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}