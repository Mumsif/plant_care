import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';
import '../../shared/widgets/section_title.dart';
import '../plants/add_plant_screen.dart';
import '../plants/plant_details_screen.dart';
import '../plants/widgets/plant_card.dart';
import 'widgets/care_tip_card.dart';
import 'widgets/greeting_header.dart';
import 'widgets/summary_card.dart';
import 'widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigateTab;

  const HomeScreen({
    super.key,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final user = appState.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 104),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPlantScreen(),
              ),
            );
          },
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.add, size: 28),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.marginHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Greeting Header with Profile and Notifications
              const GreetingHeader(),

              const SizedBox(height: 16),

              // 2. Summary Cards (Total Plants, Need Water)
              SummarySection(
                totalPlants: user.totalPlants,
                needWaterCount: user.needWaterCount,
                onTotalTap: () => onNavigateTab?.call(1),
                onNeedWaterTap: () {
                  appState.setFilter('Needs attention');
                  onNavigateTab?.call(1);
                },
              ),

              const SizedBox(height: AppSizes.sectionPadding),

              // 3. Today's Tasks
              SectionTitle(
                title: "Today's Tasks",
                actionText: 'View All',
                onActionTap: () => onNavigateTab?.call(2), // Calendar tab
              ),

              const SizedBox(height: 12),

              if (user.tasks.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: AppSizes.roundedCard,
                  ),
                  child: const Center(
                    child: Text('No tasks pending today! 🎉'),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: user.tasks.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final task = user.tasks[index];
                    return TaskCard(
                      task: task,
                      onAction: () {
                        if (!task.isCompleted) {
                          appState.completeTask(task.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Completed "${task.title}"!'),
                              backgroundColor: AppColors.primary,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),

              const SizedBox(height: AppSizes.sectionPadding),

              // 4. My Plants Carousel
              SectionTitle(
                title: 'My Plants',
                actionText: 'See All',
                onActionTap: () => onNavigateTab?.call(1), // My Plants tab
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: user.plants.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final plant = user.plants[index];
                    return PlantCard(
                      plant: plant,
                      isCarousel: true,
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
                ),
              ),

              const SizedBox(height: AppSizes.sectionPadding),

              // 5. Care Tip of the Day
              CareTipCard(tip: user.careTip),

              const SizedBox(height: 110), // Bottom navigation bar clearance
            ],
          ),
        ),
      ),
    );
  }
}
