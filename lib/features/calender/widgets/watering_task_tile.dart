import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/watering_task.dart';

class WateringTaskTile extends StatelessWidget {
  final WateringTask task;
  final VoidCallback? onComplete;

  const WateringTaskTile({
    super.key,
    required this.task,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Image.network(
                task.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.yard),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  task.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: task.isCompleted ? AppColors.secondary : AppColors.outline,
            ),
            onPressed: onComplete,
          ),
        ],
      ),
    );
  }
}
