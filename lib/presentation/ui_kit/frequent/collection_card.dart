import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/domain/entities/animal.dart';
import 'package:flutter/material.dart';

class CollectionCard extends StatelessWidget {
  final Animal animal;
  final bool isLearned;

  const CollectionCard({
    super.key,
    required this.animal,
    required this.isLearned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    animal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                if (!isLearned)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(126),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.help_outline,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLearned ? animal.name : '???',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isLearned ? AppColors.darkText : AppColors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (isLearned)
                    _buildLearnedBadge()
                  else
                    _buildNotLearnedBadge(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearnedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Изучено',
        style: TextStyle(
          fontSize: 12,
          color: AppColors.green,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNotLearnedBadge() {
    return Text(
      'Не изучено',
      style: TextStyle(
        fontSize: 12,
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}