import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'data/app_state.dart';
import 'features/calender/calendar_screen.dart';
import 'features/care_tips/care_tips_screen.dart';
import 'features/home/home_screen.dart';
import 'features/plants/my_plants_screen.dart';
import 'features/profile/profile_screen.dart';
import 'shared/widgets/liquid_glass_nav_bar.dart';

class PlantCareApp extends StatelessWidget {
  const PlantCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    return MaterialApp(
      title: 'PlantCare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: appState.themeMode,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  final int initialIndex;

  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onNavigateTab: _onTabTapped),
      const MyPlantsScreen(),
      const CalendarScreen(),
      const CareTipsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LiquidGlassNavBar(
              currentIndex: _currentIndex,
              onTabSelected: _onTabTapped,
            ),
          ),
        ],
      ),
    );
  }
}
