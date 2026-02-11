import 'package:animal_facts_app/core/design.dart';
import 'package:flutter/material.dart';


class QuestionText extends StatelessWidget {
  final String animalName;

  const QuestionText({
    super.key,
    required this.animalName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Какой из этих фактов о $animalName является правдой?',
        style: AppTextStyles.title,
        textAlign: TextAlign.center,
      ),
    );
  }
}