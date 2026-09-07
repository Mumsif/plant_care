import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'data/app_state.dart';
import 'features/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AppStateProvider(
      notifier: AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    return MaterialApp(
      title: 'PlantCare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: appState.themeMode,
      home: const Splash(),
    );
  }
}
