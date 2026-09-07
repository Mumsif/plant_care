import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedDay = 15; // default selected day of current month
  int _selectedMonthIndex = 9; // October (0-indexed 9)

  final List<String> _months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final Set<int> _wateringDays = const {3, 7, 10, 15, 18, 22, 26, 29};

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final user = appState.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Top Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.marginHorizontal,
                  right: AppSizes.marginHorizontal,
                  top: 20,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                            child: Image.network(user.avatarUrl, fit: BoxFit.cover),
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
                    IconButton(
                      icon: const Icon(Icons.today, color: AppColors.primary),
                      onPressed: () => setState(() => _selectedDay = 15),
                    ),
                  ],
                ),
              ),
            ),

            // Page Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Care Calendar',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stay on top of your plant\'s hydration and care needs.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Interactive Calendar Card (from calendar/code.html)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                  vertical: 8,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppColors.cardShadow,
                  ),
                  child: Column(
                    children: [
                      // Month Header with Prev/Next controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {
                              setState(() {
                                if (_selectedMonthIndex > 0) {
                                  _selectedMonthIndex--;
                                } else {
                                  _selectedMonthIndex = 11;
                                }
                              });
                            },
                          ),
                          Text(
                            '${_months[_selectedMonthIndex]} 2026',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                              setState(() {
                                if (_selectedMonthIndex < 11) {
                                  _selectedMonthIndex++;
                                } else {
                                  _selectedMonthIndex = 0;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Weekday Header (S M T W T F S)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _WeekdayLetter('S'),
                          _WeekdayLetter('M'),
                          _WeekdayLetter('T'),
                          _WeekdayLetter('W'),
                          _WeekdayLetter('T'),
                          _WeekdayLetter('F'),
                          _WeekdayLetter('S'),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Calendar Days Grid (31 days)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 35, // 4 empty leading days + 31 days
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          final dayNum = index - 3; // 4 offset days
                          if (dayNum < 1 || dayNum > 31) {
                            return const SizedBox.shrink();
                          }

                          final isSelected = dayNum == _selectedDay;
                          final hasWatering = _wateringDays.contains(dayNum);

                          return InkWell(
                            onTap: () => setState(() => _selectedDay = dayNum),
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$dayNum',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  if (hasWatering) ...[
                                    const SizedBox(height: 2),
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.secondary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Scheduled Tasks for Selected Day
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.marginHorizontal,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Schedule for ${_months[_selectedMonthIndex]} $_selectedDay',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${user.tasks.length} tasks',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Tasks List
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.marginHorizontal,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = user.tasks[index];
                    return Container(
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
                              width: 50,
                              height: 50,
                              child: Image.network(
                                task.imageUrl,
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
                                  task.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    decoration: task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  task.subtitle,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              task.isCompleted
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: task.isCompleted
                                  ? AppColors.secondary
                                  : AppColors.outline,
                              size: 26,
                            ),
                            onPressed: () {
                              appState.completeTask(task.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Completed "${task.title}"!'),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: user.tasks.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}

class _WeekdayLetter extends StatelessWidget {
  final String letter;

  const _WeekdayLetter(this.letter);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Text(
        letter,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.outline,
        ),
      ),
    );
  }
}
