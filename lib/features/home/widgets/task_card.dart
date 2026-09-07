import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../models/watering_task.dart';

class TaskCard extends StatelessWidget {
  final WateringTask task;
  final VoidCallback? onAction;

  const TaskCard({
    super.key,
    required this.task,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppSizes.roundedCard,
        boxShadow: isDark ? null : AppColors.cardShadow,
      ),
      child: Row(
        children: [
          // Plant Thumbnail (48x48)
          ClipRRect(
            borderRadius: AppSizes.roundedLg,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Image.network(
                task.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceContainerHigh,
                  child: const Icon(Icons.yard, color: AppColors.primary),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  task.subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Action Button
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: task.isCompleted
                  ? (isDark
                      ? AppColors.surfaceContainerHigh.withValues(alpha: 0.3)
                      : AppColors.surfaceContainerHigh)
                  : AppColors.primary,
              foregroundColor: task.isCompleted
                  ? theme.colorScheme.onSurface
                  : AppColors.onPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (task.isCompleted) ...[
                  const Icon(Icons.check, size: 16, color: AppColors.secondary),
                  const SizedBox(width: 4),
                ],
                Text(
                  task.isCompleted ? 'Done' : task.actionText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
