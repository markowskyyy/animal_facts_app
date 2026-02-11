import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:animal_facts_app/providers/animal_provider.dart';
import 'package:animal_facts_app/providers/progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animals = ref.watch(allAnimalsProvider);
    final progress = ref.watch(progressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Моя коллекция'),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          CollectionProgressBar(
            learnedCount: progress.learnedCount,
            totalCount: animals.length,
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];
                final isLearned = progress.learnedAnimalIds.contains(animal.id);
                return CollectionCard(
                  animal: animal,
                  isLearned: isLearned,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}