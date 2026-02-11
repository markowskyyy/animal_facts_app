import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/ui_kit/frequent/info_section_widget.dart';
import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:animal_facts_app/providers/animal_provider.dart';
import 'package:animal_facts_app/providers/progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends ConsumerWidget {
  final String animalId;

  const DetailScreen({
    super.key,
    required this.animalId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animal = ref.watch(animalByIdProvider(animalId));
    final progress = ref.watch(progressProvider);

    if (animal == null) {
      return const Scaffold(
        body: Center(child: Text('Животное не найдено')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            // backgroundColor: AppColors.background,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                animal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      animal.name,
                      style: AppTextStyles.headline,
                    ),
                  ),

                  const Gap(16),

                  InfoSectionWidget(
                    icon: Icons.lightbulb_outline,
                    title: 'Интересный факт',
                    content: animal.interestingFact,
                    color: AppColors.orange,
                  ),
                  InfoSectionWidget(
                    icon: Icons.public,
                    title: 'Среда обитания',
                    content: animal.habitat,
                    color: AppColors.blue,
                  ),
                  InfoSectionWidget(
                    icon: Icons.search,
                    title: 'Особенности',
                    content: animal.features,
                    color: AppColors.green,
                  ),

                  const Gap(32),

                  // Padding(
                  //   padding: const EdgeInsets.all(20),
                  //   child: CustomButton.primary(
                  //     text: 'Пройти викторину про ${animal.name}',
                  //     icon: Icons.casino,
                  //     onTap: () {
                  //       context.push('/quiz/animal/${animal.id}');
                  //     },
                  //   ),
                  // ),
                  // const Gap(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}