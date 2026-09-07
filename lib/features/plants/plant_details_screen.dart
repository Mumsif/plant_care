import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';
import '../../models/plant.dart';
import 'widgets/plant_status_badge.dart';

class PlantDetailsScreen extends StatelessWidget {
  final String plantId;

  const PlantDetailsScreen({
    super.key,
    required this.plantId,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final plant = appState.currentUser.plants.firstWhere(
      (p) => p.id == plantId,
      orElse: () => appState.currentUser.plants.first,
    );

    final theme = Theme.of(context);
    final isUrgent = plant.waterDaysLeft <= 0 || plant.status == PlantStatus.needsWater;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Hero Image Header AppBar
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.35),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    plant.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceVariant,
                      child: const Icon(Icons.eco, size: 80, color: AppColors.primary),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.marginHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Health pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plant.name,
                              style: theme.textTheme.displayLarge?.copyWith(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              plant.species,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PlantStatusBadge(status: plant.status),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Info grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: Icons.location_on_outlined,
                          label: 'Location',
                          value: plant.location,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: Icons.water_drop_outlined,
                          label: 'Next Water',
                          value: isUrgent ? 'Today' : 'in ${plant.waterDaysLeft}d',
                          isUrgent: isUrgent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: Icons.wb_sunny_outlined,
                          label: 'Sunlight',
                          value: plant.lightRequirement ?? 'Indirect sunlight',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: Icons.opacity,
                          label: 'Amount',
                          value: plant.waterAmount,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Water Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        appState.waterPlant(plant.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${plant.name} has been watered!'),
                            backgroundColor: AppColors.primary,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.water_drop),
                      label: Text(
                        isUrgent ? 'Water Now' : 'Mark as Watered',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isUrgent = false,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: isUrgent
            ? Border.all(color: AppColors.errorContainer, width: 1.5)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: isUrgent ? AppColors.error : AppColors.primary,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isUrgent ? AppColors.error : theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
