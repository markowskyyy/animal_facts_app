import 'package:animal_facts_app/core/design.dart';
import 'package:flutter/material.dart';


class SettingsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
}