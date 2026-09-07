import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class SummarySection extends StatelessWidget {
  final int totalPlants;
  final int needWaterCount;
  final VoidCallback? onTotalTap;
  final VoidCallback? onNeedWaterTap;

  const SummarySection({
    super.key,
    required this.totalPlants,
    required this.needWaterCount,
    this.onTotalTap,
    this.onNeedWaterTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        // Total Plants Card (Light / neutral surface container lowest)
        Expanded(
          child: InkWell(
            onTap: onTotalTap,
            borderRadius: AppSizes.roundedCard,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLowest,
                borderRadius: AppSizes.roundedCard,
                boxShadow: isDark ? null : AppColors.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.yard_outlined,
                      color: AppColors.onSecondaryContainer,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$totalPlants',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.primaryFixedDim
                          : AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Total Plants',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Need Water Card (Primary container colored)
        Expanded(
          child: InkWell(
            onTap: onNeedWaterTap,
            borderRadius: AppSizes.roundedCard,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: AppSizes.roundedCard,
                boxShadow: isDark ? null : AppColors.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$needWaterCount',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Need Water',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
