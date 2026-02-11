import 'package:animal_facts_app/core/design.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const CustomButton._({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  factory CustomButton.primary({
    Key? key,
    required String text,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onTap: onTap,
      backgroundColor: AppColors.green,
      textColor: Colors.white,
      icon: icon,
    );
  }

  factory CustomButton.secondary({
    Key? key,
    required String text,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onTap: onTap,
      backgroundColor: Colors.white,
      textColor: AppColors.darkText,
      icon: icon,
    );
  }

  factory CustomButton.outline({
    Key? key,
    required String text,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onTap: onTap,
      backgroundColor: Colors.transparent,
      textColor: AppColors.green,
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(28),
          border: backgroundColor == Colors.transparent
              ? Border.all(color: AppColors.green, width: 2)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: backgroundColor == Colors.transparent
                  ? AppTextStyles.buttonLight.copyWith(color: AppColors.green)
                  : backgroundColor == Colors.white
                  ? AppTextStyles.buttonLight
                  : AppTextStyles.button,
            ),
          ],
        ),
      ),
    );
  }
}