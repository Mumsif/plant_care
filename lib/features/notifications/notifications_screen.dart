import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class PlantNotification {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final String imageUrl;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  bool isUnread;

  PlantNotification({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.imageUrl,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.isUnread = true,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<PlantNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [
      PlantNotification(
        id: 'n-1',
        title: "It's time to water your Monstera",
        subtitle: 'Living Room • Soil moisture is below 20%',
        time: '2h ago',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAaCToavAjCji6vMF5TBGExsZa3OqKwQ0DG7HaJt631W865JB6F2crehqb-hh-IkcxljggsPop9BUjbvNgKwFolAScZ3p8fLYs6XGmkw-qHpdbu36ExS97NchZoUI8GT6HFzya8Y3n9fE0Bi5e2vmRFDeRLOuhAFVN6HLCq2Gr8DCYBE5vMe5BrC7ocgcEgRqcZ6KMqKbC4NWrb4D6yF6xUiNMszjN9Ufvk4aC9vkiQ1PFstXy4AYte',
        icon: Icons.water_drop,
        iconBg: AppColors.errorContainer,
        iconColor: AppColors.error,
        isUnread: true,
      ),
      PlantNotification(
        id: 'n-2',
        title: 'Aloe Vera needs sunlight rotation',
        subtitle: 'Kitchen • Rotate 90° for balanced growth',
        time: '5h ago',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD0WDjU2hOewm6R3tYNkGISMB_Q2jKZt5OYIhIGtlPrO9x1LLVVqYS7Z5CaItfQvnmkEhFdXxKP3YEEITwA2AbO_h-9y3JbhDyiaLfBFL2CjF72Fs6mTzeye0YSvr-uCUCWauQ1uVhtgPDXTefE52MpBXR2g8AjxUqVmf4geJoJdMJLc8zFkCTo8IhtEJFVaEWXQb_hd-RE7esqcruwqwQ_Sl1Tun7C_6LTg_E9YKPbxkc7BxKuDBRn',
        icon: Icons.wb_sunny,
        iconBg: const Color(0xFFFFE082),
        iconColor: const Color(0xFFE65100),
        isUnread: true,
      ),
      PlantNotification(
        id: 'n-3',
        title: 'Weekly Care Streak Milestone!',
        subtitle: 'You completed 100% of watering tasks this week.',
        time: 'Yesterday',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDA2bHoYUouTg7vf38_5lPjPHtmXutZJMCgdmMiNgmZ36vW8A0Q9OnW433DQriGuIsoiYv7LPErsSR1I686b7uKKZ1l_bfiW2irsEzt9x61vUXhgCMYl7NMQ4MKWVYVTaaMk6cSU2mFhBMuSOw_E3gDe5Eh15Dju9u_7GfanfX_zkTbAV4X5VebE6phkDWhcVpHvsjsuEINOSw2zRXkVXpg72nkktAFfx697g7fDcuz8P9C09kH-X47',
        icon: Icons.emoji_events,
        iconBg: AppColors.secondaryContainer,
        iconColor: AppColors.onSecondaryContainer,
        isUnread: false,
      ),
    ];
  }

  void _markAllAsRead() {
    setState(() {
      for (final n in _notifications) {
        n.isUnread = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unreadCount = _notifications.where((n) => n.isUnread).length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark All Read',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.marginHorizontal,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Updates',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                unreadCount > 0
                    ? 'You have $unreadCount unread reminders.'
                    : 'All caught up! No unread notifications.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.outline,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),

              if (_notifications.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(child: Text('No notifications right now.')),
                )
              else
                ..._notifications.map((notification) {
                  return Dismissible(
                    key: Key(notification.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: AppColors.errorContainer,
                      child: const Icon(Icons.delete, color: AppColors.error),
                    ),
                    onDismissed: (_) {
                      setState(() {
                        _notifications.removeWhere((n) => n.id == notification.id);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: AppColors.cardShadow,
                        border: notification.isUnread
                            ? Border.all(
                                color: AppColors.primaryFixedDim.withValues(alpha: 0.6),
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          if (notification.isUnread) ...[
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.error,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],

                          // Plant Thumbnail
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: SizedBox(
                              width: 52,
                              height: 52,
                              child: Image.network(
                                notification.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Text Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: notification.isUnread
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  notification.subtitle,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Urgency icon badge & time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: notification.iconBg,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  notification.icon,
                                  size: 14,
                                  color: notification.iconColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notification.time,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
