import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/plant.dart';

class PlantStatusBadge extends StatelessWidget {
  final PlantStatus status;

  const PlantStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case PlantStatus.thriving:
        bg = AppColors.secondaryContainer;
        fg = AppColors.onSecondaryContainer;
        break;
      case PlantStatus.good:
        bg = AppColors.surfaceContainerHigh;
        fg = AppColors.onSurfaceVariant;
        break;
      case PlantStatus.needsWater:
        bg = AppColors.errorContainer;
        fg = AppColors.onErrorContainer;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: fg,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PlantWateringBadge extends StatelessWidget {
  final int daysLeft;

  const PlantWateringBadge({
    super.key,
    required this.daysLeft,
  });

  @override
  Widget build(BuildContext context) {
    final isUrgent = daysLeft <= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isUrgent
            ? AppColors.errorContainer.withValues(alpha: 0.92)
            : AppColors.surfaceContainerLowest.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.water_drop,
            size: 13,
            color: isUrgent ? AppColors.error : (daysLeft <= 2 ? AppColors.secondary : AppColors.outline),
          ),
          const SizedBox(width: 3),
          Text(
            isUrgent ? 'Now' : '${daysLeft}d',
            style: TextStyle(
              color: isUrgent ? AppColors.error : AppColors.onSurface,
              fontSize: 11,
              fontWeight: isUrgent ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
