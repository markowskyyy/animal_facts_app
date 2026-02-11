import 'package:flutter/material.dart';
import '../../../core/design.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String icon;
  final bool isUnlocked;

  const AchievementCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked ? AppColors.white : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
        border: isUnlocked
            ? Border.all(color: AppColors.green.withOpacity(0.3), width: 1)
            : null,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUnlocked
                  ? AppColors.green.withOpacity(0.1)
                  : AppColors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              icon,
              style: TextStyle(
                fontSize: 24,
                color: isUnlocked ? AppColors.green : AppColors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: isUnlocked ? AppColors.darkText : AppColors.grey,
              fontWeight: isUnlocked ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}