import 'package:animal_facts_app/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';


class NextButton extends StatelessWidget {
  final VoidCallback onTap;

  const NextButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomButton.primary(
        text: 'Следующий вопрос',
        onTap: onTap,
      ),
    );
  }
}