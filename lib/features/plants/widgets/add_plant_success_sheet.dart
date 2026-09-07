import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../models/plant.dart';

class AddPlantSuccessSheet extends StatelessWidget {
  final Plant plant;
  final VoidCallback onViewPlants;

  const AddPlantSuccessSheet({
    super.key,
    required this.plant,
    required this.onViewPlants,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.marginHorizontal,
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Success Glowing Circle Checkmark
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.secondaryContainer,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.25),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.onSecondaryContainer,
                size: 38,
              ),
            ),
            const SizedBox(height: 16),

            // Success Titles
            Text(
              'Plant Added Successfully!',
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              '${plant.name} has been added to your green collection.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Plant Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppColors.cardShadow,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Image.network(
                        plant.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${plant.location} • Water in ${plant.waterDaysLeft}d',
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.eco, color: AppColors.secondary),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close bottom sheet
                  onViewPlants();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'View in My Plants',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done', style: TextStyle(color: AppColors.outline)),
            ),
          ],
        ),
      ),
    );
  }
}
