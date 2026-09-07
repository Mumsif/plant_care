import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final user = appState.currentUser;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // TopAppBar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar & PlantCare Brand
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryContainer,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              user.avatarUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'PlantCare',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),

                    // Switch User Profile Button
                    OutlinedButton.icon(
                      onPressed: () => _showSwitchUserDialog(context, appState),
                      icon: const Icon(Icons.swap_horiz, size: 18),
                      label: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.primary,
                        side: BorderSide(color: theme.colorScheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Settings Title & Subtitle
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your plant care preferences.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Settings Content Body
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.marginHorizontal,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // 1. Notifications Card
                  _buildCard(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.notifications_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Notifications',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSwitchTile(
                          title: 'Watering Reminders',
                          subtitle: 'Get notified when plants need water',
                          value: user.wateringReminders,
                          onChanged: (val) => appState.updateNotifications(
                            wateringReminders: val,
                          ),
                        ),
                        const Divider(height: 24),
                        _buildSwitchTile(
                          title: 'Care Tips',
                          subtitle: 'Seasonal advice for your plants',
                          value: user.careTipsEnabled,
                          onChanged: (val) => appState.updateNotifications(
                            careTipsEnabled: val,
                          ),
                        ),
                        const Divider(height: 24),
                        _buildSwitchTile(
                          title: 'Weekly Summary',
                          subtitle: 'Review of your care activities',
                          value: user.weeklySummary,
                          onChanged: (val) => appState.updateNotifications(
                            weeklySummary: val,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. Appearance Card
                  _buildCard(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.palette_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Appearance',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceContainerHigh.withValues(alpha: 0.2)
                                : AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _buildThemeOption(
                                context,
                                label: 'Light',
                                icon: Icons.light_mode_outlined,
                                isSelected: user.themePreference == 'Light',
                                onTap: () =>
                                    appState.setThemePreference('Light'),
                              ),
                              _buildThemeOption(
                                context,
                                label: 'Dark',
                                icon: Icons.dark_mode_outlined,
                                isSelected: user.themePreference == 'Dark',
                                onTap: () => appState.setThemePreference('Dark'),
                              ),
                              _buildThemeOption(
                                context,
                                label: 'System',
                                icon: Icons.smartphone_outlined,
                                isSelected: user.themePreference == 'System',
                                onTap: () =>
                                    appState.setThemePreference('System'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 3. Preferences Card
                  _buildCard(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.tune_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Preferences',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildPreferenceRow(
                          context,
                          label: 'Temperature Unit',
                          value: user.temperatureUnit,
                          onTap: () => _showUnitPicker(context, appState),
                        ),
                        const Divider(height: 24),
                        _buildPreferenceRow(
                          context,
                          label: 'Date Format',
                          value: user.dateFormat,
                          onTap: () => _showDateFormatPicker(context, appState),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 4. Other Card (Privacy, About, Logout)
                  _buildCard(
                    context,
                    child: Column(
                      children: [
                        _buildActionRow(
                          context,
                          icon: Icons.shield_outlined,
                          label: 'Privacy Policy',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('PlantCare respects your privacy.'),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 20),
                        _buildActionRow(
                          context,
                          icon: Icons.info_outline,
                          label: 'About PlantCare',
                          onTap: () {
                            showAboutDialog(
                              context: context,
                              applicationName: 'PlantCare',
                              applicationVersion: '1.0.0',
                              children: const [
                                Text('Keep your plants thriving effortlessly.'),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        // Log Out Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Logged out of ${user.name}.'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.logout, color: AppColors.error),
                            label: const Text(
                              'Log Out',
                              style: TextStyle(
                                color: AppColors.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.error,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: isDark ? null : AppColors.cardShadow,
      ),
      child: child,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.outline,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeThumbColor: AppColors.secondary,
          activeTrackColor: AppColors.secondaryContainer,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (theme.brightness == Brightness.dark
                    ? AppColors.primaryContainer
                    : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? theme.colorScheme.primary : AppColors.outline,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? theme.colorScheme.onSurface
                      : AppColors.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceRow(
    BuildContext context, {
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.outline,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.chevron_right, size: 20, color: AppColors.outline),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.outline),
          ],
        ),
      ),
    );
  }

  static void _showSwitchUserDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Switch Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: appState.allUsers.asMap().entries.map((entry) {
              final idx = entry.key;
              final u = entry.value;
              final isCurrent = appState.currentUserIndex == idx;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(u.avatarUrl),
                ),
                title: Text(u.name),
                subtitle: Text('${u.totalPlants} plants'),
                trailing: isCurrent ? const Icon(Icons.check, color: AppColors.secondary) : null,
                onTap: () {
                  appState.switchUser(idx);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  static void _showUnitPicker(BuildContext context, AppState appState) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Celsius (°C)'),
                trailing: appState.currentUser.temperatureUnit.contains('Celsius')
                    ? const Icon(Icons.check, color: AppColors.secondary)
                    : null,
                onTap: () {
                  appState.updatePreferences(temperatureUnit: 'Celsius (°C)');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Fahrenheit (°F)'),
                trailing: appState.currentUser.temperatureUnit.contains('Fahrenheit')
                    ? const Icon(Icons.check, color: AppColors.secondary)
                    : null,
                onTap: () {
                  appState.updatePreferences(temperatureUnit: 'Fahrenheit (°F)');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void _showDateFormatPicker(BuildContext context, AppState appState) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('DD/MM/YYYY'),
                trailing: appState.currentUser.dateFormat == 'DD/MM/YYYY'
                    ? const Icon(Icons.check, color: AppColors.secondary)
                    : null,
                onTap: () {
                  appState.updatePreferences(dateFormat: 'DD/MM/YYYY');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('MM/DD/YYYY'),
                trailing: appState.currentUser.dateFormat == 'MM/DD/YYYY'
                    ? const Icon(Icons.check, color: AppColors.secondary)
                    : null,
                onTap: () {
                  appState.updatePreferences(dateFormat: 'MM/DD/YYYY');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
