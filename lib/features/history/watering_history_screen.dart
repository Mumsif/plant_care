import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';

class WateringLog {
  final String id;
  final String plantName;
  final String location;
  final String amount;
  final String date;
  final String imageUrl;
  final bool isOnTime;

  const WateringLog({
    required this.id,
    required this.plantName,
    required this.location,
    required this.amount,
    required this.date,
    required this.imageUrl,
    this.isOnTime = true,
  });
}

class WateringHistoryScreen extends StatelessWidget {
  const WateringHistoryScreen({super.key});

  static const List<WateringLog> _logs = [
    WateringLog(
      id: 'log-1',
      plantName: 'Monstera Deliciosa',
      location: 'Living Room',
      amount: '200ml',
      date: 'Today, 9:30 AM',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDjl164ySO1bub0IDK6xCvpp_lSPxRMCmjFev-sc0u7_Ox3AqE1Izlrbv7KmixUUPkNFXg-6w4PMRpqOMYXUkhyrE4FuaaW0XZ-aShm6vOSqq7lsogUsaAX9lTGN9OIR2Zp2fWjUstrOAPMyV1P_gRyjhmvaonMld2UvLR2NpQ8P_VdrhJ_jwQT0Xe3wkFlILOtSyiPpC8sz660GOjqKlxVMhYwCJa2uX_ULVvg7wJFTm5u_ogk7ZHF',
      isOnTime: true,
    ),
    WateringLog(
      id: 'log-2',
      plantName: 'Snake Plant',
      location: 'Bedroom',
      amount: '150ml',
      date: 'Oct 12, 10:00 AM',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDy5auWU-8XlPTGcheVE36syZxM0IuWavSfhyjsmOXPgR6mZoC8lqhQ6UUe3aJ5ZoBsmYg_fEdUe6qJ57qoNrZhvK59pGD5KR2zBA83BFb34fMdoIgJTyapb9DISGXffhXidZdcukSTWhejMpbrk6FRfOtdMRuBGCDm-Y5FGGP8RY35LGcXx3zia2BrJM6XE4MXatlZoy-StJJDjdzvuX1DMSS8AUdzhifxX8OEkjfsXYpsxxgm6vME',
      isOnTime: true,
    ),
    WateringLog(
      id: 'log-3',
      plantName: 'Rubber Tree',
      location: 'Office',
      amount: '250ml',
      date: 'Oct 10, 4:15 PM',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDx7GYmJkKaB-vqWNyrT6-T8BH951IfDyQKHBQBT8BQpB47hlUQKsRtre-Nslniz0sy1l2fqu38vVEioo5mAmhaV17hu1bzZ76LSl0zj1A1wfBDXek7Q3iLAksQavryeDkt1TOlQzSzQl4jHwpQ6qbTpM0Gvv8NI0SWKP-bk1L4WMp1RMQXhEBVIKSMBAQiRiD-NqtqVmixSaw49lGp8gOFmTKTMKfoWh4RjRCv8e1EC581EFKYRca3',
      isOnTime: true,
    ),
    WateringLog(
      id: 'log-4',
      plantName: 'Aloe Vera',
      location: 'Kitchen',
      amount: '100ml',
      date: 'Oct 6, 11:20 AM',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAtuNdXlT0X-BcHbGNEEL67-tZbHb4E63jWVqj5cvuKnJkQ3dijJTzjV4umIUuY-zWT8K9euPePw9YEfuC8lah_0FvHMJkQB8_8WkCElPyNVdkjAIeruD1otncxOYyBi95Kx3uwKr9J_gwL7-qVk2honH6zNeAF2efpTd-5DGVvCVrL0QEg4nPyMpdtzQdpnHKboG_5gAbzaHK_1ewOWQwXt-hm4KGlz4AezvVc0yjlAXZRKQ-2m09R',
      isOnTime: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final user = appState.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Watering History'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.marginHorizontal,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Care Summary',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${user.name}\'s monthly care summary and hydration statistics.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.outline,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),

              // Summary Metrics Row
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      context,
                      title: 'Total Waters',
                      value: '24',
                      icon: Icons.water_drop,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      context,
                      title: 'On-Time Rate',
                      value: '96%',
                      icon: Icons.verified,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      context,
                      title: 'Total Volume',
                      value: '4.8 L',
                      icon: Icons.opacity,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Filter & Timeline Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Activity Timeline',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.calendar_month, size: 16, color: AppColors.primary),
                        SizedBox(width: 6),
                        Text(
                          'October 2026',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Timeline Logs List
              ..._logs.map((log) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
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
                            width: 52,
                            height: 52,
                            child: Image.network(
                              log.imageUrl,
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
                                log.plantName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${log.location} • ${log.amount}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                log.date,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: log.isOnTime
                                ? AppColors.secondaryContainer
                                : AppColors.errorContainer,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            log.isOnTime ? 'On Time' : 'Delayed',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: log.isOnTime
                                  ? AppColors.onSecondaryContainer
                                  : AppColors.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
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
}
