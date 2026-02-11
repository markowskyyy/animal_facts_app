import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:animal_facts_app/providers/progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                // Достижения
                Text(
                  'Достижения',
                  style: AppTextStyles.title,
                ),
                const Gap(16),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
                  children: [
                    AchievementCard(
                      title: 'Изучил 10 животных',
                      icon: '🔥',
                      isUnlocked: progress.learnedCount >= 10,
                    ),
                    AchievementCard(
                      title: 'Изучил 5 хищников',
                      icon: '🦁',
                      isUnlocked: progress.learnedCount >= 5,
                    ),
                    AchievementCard(
                      title: 'Коллекционер',
                      icon: '🏆',
                      isUnlocked: progress.learnedCount >= 3,
                    ),
                  ],
                ),

                const Gap(32),
                StatCard(
                  value: '${progress.totalQuizzes}',
                  label: 'Всего викторин',
                  color: AppColors.blue,
                  icon: Icons.quiz,
                ),
                const Gap(16),
                StatCard(
                  value: '${progress.accuracy.toStringAsFixed(0)}%',
                  label: 'Точность',
                  color: AppColors.green,
                  icon: Icons.graphic_eq,
                ),
                const Gap(16),
                StatCard(
                  value: '${progress.learnedCount}',
                  label: 'Изучено животных',
                  color: AppColors.orange,
                  icon: Icons.pets,
                ),
              ],
            ),

            const Gap(32),
          ],
        ),
      ),
    );
  }

}