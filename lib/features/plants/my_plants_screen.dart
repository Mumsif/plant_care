import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/empty_state.dart';
import 'add_plant_screen.dart';
import 'plant_details_screen.dart';
import 'widgets/plant_card.dart';

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({super.key});

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = const [
    'All',
    'Indoor',
    'Outdoor',
    'Needs attention',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final theme = Theme.of(context);
    final filteredPlants = appState.filteredPlants;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Top Header Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.marginHorizontal,
                  right: AppSizes.marginHorizontal,
                  top: 24,
                  bottom: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Plants',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.56,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your little green collection',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    // Circular Add Plant Button
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPlantScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: AppColors.cardShadow,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.onPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                  vertical: 8,
                ),
                child: AppTextField(
                  controller: _searchController,
                  hintText: 'Search your plants',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.outline,
                  ),
                  suffixIcon: appState.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            appState.setSearchQuery('');
                          },
                        )
                      : null,
                  onChanged: (val) => appState.setSearchQuery(val),
                ),
              ),
            ),

            // Filter Chips (Horizontal Scroll)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.marginHorizontal,
                  ),
                  itemCount: _filters.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = appState.selectedFilter == filter;
                    final isNeedsAttention = filter == 'Needs attention';

                    Color bg;
                    Color fg;

                    if (isSelected) {
                      bg = isNeedsAttention
                          ? AppColors.error
                          : AppColors.primary;
                      fg = Colors.white;
                    } else if (isNeedsAttention) {
                      bg = AppColors.errorContainer;
                      fg = AppColors.onErrorContainer;
                    } else {
                      bg = theme.brightness == Brightness.dark
                          ? AppColors.surfaceContainerHigh.withValues(alpha: 0.2)
                          : AppColors.surfaceContainerHigh;
                      fg = theme.colorScheme.onSurface;
                    }

                    return InkWell(
                      onTap: () => appState.setFilter(filter),
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isNeedsAttention) ...[
                              Icon(
                                Icons.warning_amber_rounded,
                                size: 16,
                                color: fg,
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              filter,
                              style: TextStyle(
                                color: fg,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),

            // Plant Grid (2 columns)
            if (filteredPlants.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.search_off,
                  title: 'No Plants Found',
                  message: appState.searchQuery.isNotEmpty
                      ? 'No plants match "${appState.searchQuery}"'
                      : 'No plants match the selected filter',
                  buttonText: 'Reset Filters',
                  onButtonPressed: () {
                    _searchController.clear();
                    appState.setSearchQuery('');
                    appState.setFilter('All');
                  },
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                  vertical: 8,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final plant = filteredPlants[index];
                      return PlantCard(
                        plant: plant,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlantDetailsScreen(plantId: plant.id),
                            ),
                          );
                        },
                      );
                    },
                    childCount: filteredPlants.length,
                  ),
                ),
              ),

            // Bottom space for bottom navigation bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}
