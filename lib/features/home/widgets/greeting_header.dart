import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/app_state.dart';
import '../../notifications/notifications_screen.dart';

class GreetingHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const GreetingHeader({
    super.key,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final user = appState.currentUser;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User Avatar & Greeting
          Expanded(
            child: InkWell(
              onTap: onProfileTap ?? () => _showUserSwitchModal(context, appState),
              borderRadius: BorderRadius.circular(30),
              child: Row(
                children: [
                  // Profile Photo with border
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.outlineVariant,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        user.avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.primaryContainer,
                          child: Center(
                            child: Text(
                              user.name.substring(0, 1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Name and subtext
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Good morning, ${user.name}',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                            color: theme.colorScheme.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ready to care for your plants?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Notifications button with badge
          IconButton(
            onPressed: onNotificationTap ??
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ),
                  );
                },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_outlined,
                  size: 26,
                  color: theme.colorScheme.onSurface,
                ),
                if (user.needWaterCount > 0)
                  Positioned(
                    top: 1,
                    right: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _showUserSwitchModal(BuildContext context, AppState appState) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Switch User Profile',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Selecting a user dynamically loads their personalized plants, tasks, and settings.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.outline,
                      ),
                ),
                const SizedBox(height: 16),
                ...appState.allUsers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final user = entry.value;
                  final isSelected = appState.currentUserIndex == index;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.secondaryContainer.withValues(alpha: 0.35)
                          : AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.secondary
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatarUrl),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${user.totalPlants} plants • ${user.needWaterCount} need water',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle,
                              color: AppColors.secondary)
                          : null,
                      onTap: () {
                        appState.switchUser(index);
                        Navigator.pop(context);
                      },
                    ),
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
