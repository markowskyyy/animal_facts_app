import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.pets,
                  color: AppColors.green,
                  size: 28,
                ),
              ),
              const Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AnimalFacts',
                    style: AppTextStyles.title,
                  ),
                  Text(
                    'Версия 1.0.0',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const Gap(20),
          Text(
            'AnimalFacts — образовательное приложение для изучения интересных фактов о животных. Проходите викторины, собирайте коллекцию и зарабатывайте достижения!',
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}