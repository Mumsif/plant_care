import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../models/plant.dart';
import 'plant_status_badge.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback? onTap;
  final bool isCarousel;

  const PlantCard({
    super.key,
    required this.plant,
    this.onTap,
    this.isCarousel = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isUrgent = plant.waterDaysLeft <= 0 || plant.status == PlantStatus.needsWater;

    if (isCarousel) {
      // Carousel Card Style (Used in Home Screen)
      return Container(
        width: 240,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppSizes.roundedCard,
          boxShadow: isDark ? null : AppColors.cardShadow,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Header (Height 128)
              SizedBox(
                height: 128,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      plant.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceContainerHigh,
                        child: const Icon(Icons.eco, size: 40, color: AppColors.primary),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.favorite,
                              size: 13,
                              color: AppColors.onSecondaryContainer,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              plant.status.label,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Plant Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plant.species,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.water_drop,
                          size: 16,
                          color: isUrgent ? AppColors.error : AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isUrgent
                              ? 'Needs water now'
                              : 'Water in ${plant.waterDaysLeft} days',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isUrgent
                                ? AppColors.error
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Grid Card Style (Used in My Plants Screen)
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppSizes.roundedCard,
        border: isUrgent
            ? Border.all(color: AppColors.errorContainer, width: 2)
            : null,
        boxShadow: isDark ? null : AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Aspect square image with watering badge
            AspectRatio(
              aspectRatio: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      plant.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceVariant,
                        child: const Icon(Icons.eco, size: 36, color: AppColors.primary),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: PlantWateringBadge(daysLeft: plant.waterDaysLeft),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Plant Names & Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    plant.location,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  PlantStatusBadge(status: plant.status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
