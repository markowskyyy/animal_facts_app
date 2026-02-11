import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:animal_facts_app/providers/progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Еще'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // О приложении
            _buildSection(
              title: 'О приложении',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  ),
                ],
              ),
            ),

            const Gap(32),

            // Сброс прогресса
            _buildSection(
              title: 'Сброс прогресса',
              child: Container(
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
                            color: AppColors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.red,
                            size: 24,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Text(
                            'Удалить всю статистику, коллекцию и достижения',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.darkText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    Text(
                      'Это действие нельзя отменить.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const Gap(20),
                    CustomButton.outline(
                      text: 'Сбросить прогресс',
                      icon: Icons.delete_outline,
                      onTap: () => _showResetDialog(context, ref),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(40),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    'Сделано с ❤️ для животных',
                    style: AppTextStyles.bodySmall,
                  ),
                  const Gap(4),
                  Text(
                    '© 2026 MST AnimalFactsApp',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.darkText,
            ),
          ),
        ),
        child,
      ],
    );
  }

  Future<void> _showResetDialog(BuildContext context, WidgetRef ref) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.warning,
                color: AppColors.red,
                size: 28,
              ),
              const Gap(12),
              Text(
                'Сбросить прогресс?',
                style: AppTextStyles.title.copyWith(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Text(
            'Вся ваша статистика, коллекция изученных животных и достижения будут безвозвратно удалены.',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Отмена',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await ref.read(progressProvider.notifier).resetProgress();

                // Показываем SnackBar об успешном сбросе
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                        const Gap(12),
                        Expanded(
                          child: Text(
                            'Прогресс успешно сброшен',
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: AppColors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(20),
                  ),
                );
              },
              child: const Text('Сбросить'),
            ),
          ],
        );
      },
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}