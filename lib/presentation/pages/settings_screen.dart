import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
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
            SettingsSection(
              title: 'О приложении',
              child: const AboutCard(),
            ),
            const Gap(32),
            SettingsSection(
              title: 'Сброс прогресса',
              child: const ResetProgressCard(),
            ),
            const Gap(40),
            const SettingsFooter(),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}