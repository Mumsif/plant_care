import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';
import '../care_tips/care_tips_screen.dart';
import '../history/watering_history_screen.dart';
import '../notifications/notifications_screen.dart';
import '../plants/plant_details_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final user = appState.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.marginHorizontal,
          vertical: 12,
        ),
        child: Column(
          children: [
            // Profile Hero Section with 128px Avatar
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryContainer,
                            width: 3,
                          ),
                          boxShadow: AppColors.cardShadow,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            user.avatarUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.scaffoldBackgroundColor,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user.name,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Plant parent since 2026 • ${user.email}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.outline,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => _showUserSwitchSheet(context, appState),
                    icon: const Icon(Icons.swap_horiz, size: 18),
                    label: Text('Switch Profile (${user.name})'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Statistics Row: Total Plants, Vitality Score, Streak
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    context,
                    label: 'Collection',
                    value: '${user.totalPlants}',
                    subtext: 'Plants',
                    icon: Icons.yard_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    context,
                    label: 'Vitality Score',
                    value: '85%',
                    subtext: 'Optimal',
                    icon: Icons.favorite_border,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    context,
                    label: 'Care Streak',
                    value: '34',
                    subtext: 'Days',
                    icon: Icons.local_fire_department,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // My Garden Preview Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Garden',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${user.totalPlants} Plants',
                  style: const TextStyle(
                    color: AppColors.outline,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: user.plants.length,
                separatorBuilder: (_, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final plant = user.plants[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantDetailsScreen(plantId: plant.id),
                        ),
                      );
                    },
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppColors.cardShadow,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(
                              plant.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            child: Text(
                              plant.name,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // Navigation Hub Cards
            _buildNavCard(
              context,
              icon: Icons.history_rounded,
              title: 'Watering History',
              subtitle: 'View monthly hydration logs and accuracy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WateringHistoryScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildNavCard(
              context,
              icon: Icons.lightbulb_outline_rounded,
              title: 'Care Tips & Library',
              subtitle: 'Explore plant care guides and seasonal tips',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CareTipsScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildNavCard(
              context,
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Recent reminders and plant care alerts',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildNavCard(
              context,
              icon: Icons.tune_rounded,
              title: 'Settings & Preferences',
              subtitle: 'Theme, temperature units, notification toggles',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile(
    BuildContext context, {
    required String label,
    required String value,
    required String subtext,
    required IconData icon,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          Text(
            subtext,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
          ),
          trailing: const Icon(Icons.chevron_right, color: AppColors.outline),
        ),
      ),
    );
  }

  void _showUserSwitchSheet(BuildContext context, AppState appState) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Switch Active User',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...appState.allUsers.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final u = entry.value;
                  final isCurrent = appState.currentUserIndex == idx;

                  return ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(u.avatarUrl)),
                    title: Text(u.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${u.totalPlants} plants • ${u.email}'),
                    trailing: isCurrent ? const Icon(Icons.check_circle, color: AppColors.secondary) : null,
                    onTap: () {
                      appState.switchUser(idx);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
