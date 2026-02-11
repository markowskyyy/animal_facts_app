import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}