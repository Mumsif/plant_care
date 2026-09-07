import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../models/watering_task.dart';
import '../models/user_profile.dart';
import 'mock_plants.dart';

/// Central state manager for the PlantCare application.
/// Manages multiple user profiles, active user switching, plants, tasks, and settings.
class AppState extends ChangeNotifier {
  List<UserProfile> _users = [];
  int _currentUserIdIndex = 0;

  String _searchQuery = '';
  String _selectedFilter = 'All'; // 'All', 'Indoor', 'Outdoor', 'Needs attention'

  AppState() {
    _users = MockData.allUsers;
  }

  // Current active user
  UserProfile get currentUser => _users[_currentUserIdIndex];
  List<UserProfile> get allUsers => List.unmodifiable(_users);
  int get currentUserIndex => _currentUserIdIndex;

  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;

  ThemeMode get themeMode {
    switch (currentUser.themePreference) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  /// Switch the active user profile
  void switchUser(int index) {
    if (index >= 0 && index < _users.length) {
      _currentUserIdIndex = index;
      _searchQuery = '';
      _selectedFilter = 'All';
      notifyListeners();
    }
  }

  /// Update Search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Update Filter category
  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  /// Get filtered plants for the current user based on search query and category filter
  List<Plant> get filteredPlants {
    final plants = currentUser.plants;
    return plants.where((plant) {
      final matchesSearch = _searchQuery.isEmpty ||
          plant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          plant.species.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          plant.location.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      switch (_selectedFilter) {
        case 'Indoor':
          return plant.isIndoor;
        case 'Outdoor':
          return !plant.isIndoor;
        case 'Needs attention':
          return plant.waterDaysLeft == 0 || plant.status == PlantStatus.needsWater;
        case 'All':
        default:
          return true;
      }
    }).toList();
  }

  /// Mark plant as watered
  void waterPlant(String plantId) {
    final user = currentUser;
    final updatedPlants = user.plants.map((p) {
      if (p.id == plantId) {
        return p.copyWith(
          waterDaysLeft: 5,
          status: PlantStatus.thriving,
          lastWatered: DateTime.now(),
        );
      }
      return p;
    }).toList();

    // Mark matching tasks as completed
    final updatedTasks = user.tasks.map((t) {
      if (t.plantId == plantId && t.isWatering) {
        return t.copyWith(isCompleted: true, actionText: 'Done');
      }
      return t;
    }).toList();

    _users[_currentUserIdIndex] = user.copyWith(
      plants: updatedPlants,
      tasks: updatedTasks,
    );
    notifyListeners();
  }

  /// Complete a specific task
  void completeTask(String taskId) {
    final user = currentUser;
    WateringTask? matchedTask;
    final updatedTasks = user.tasks.map((t) {
      if (t.id == taskId) {
        matchedTask = t;
        return t.copyWith(isCompleted: true, actionText: 'Done');
      }
      return t;
    }).toList();

    List<Plant> updatedPlants = user.plants;
    if (matchedTask != null && matchedTask!.isWatering) {
      updatedPlants = user.plants.map((p) {
        if (p.id == matchedTask!.plantId) {
          return p.copyWith(
            waterDaysLeft: 5,
            status: PlantStatus.thriving,
            lastWatered: DateTime.now(),
          );
        }
        return p;
      }).toList();
    }

    _users[_currentUserIdIndex] = user.copyWith(
      tasks: updatedTasks,
      plants: updatedPlants,
    );
    notifyListeners();
  }

  /// Add a new plant to the current user's profile
  void addPlant(Plant newPlant) {
    final user = currentUser;
    final updatedPlants = [...user.plants, newPlant];
    _users[_currentUserIdIndex] = user.copyWith(plants: updatedPlants);
    notifyListeners();
  }

  /// Toggle notification switches
  void updateNotifications({
    bool? wateringReminders,
    bool? careTipsEnabled,
    bool? weeklySummary,
  }) {
    final user = currentUser;
    _users[_currentUserIdIndex] = user.copyWith(
      wateringReminders: wateringReminders ?? user.wateringReminders,
      careTipsEnabled: careTipsEnabled ?? user.careTipsEnabled,
      weeklySummary: weeklySummary ?? user.weeklySummary,
    );
    notifyListeners();
  }

  /// Update theme preference ('Light', 'Dark', 'System')
  void setThemePreference(String themePreference) {
    final user = currentUser;
    _users[_currentUserIdIndex] = user.copyWith(themePreference: themePreference);
    notifyListeners();
  }

  /// Update user preferences
  void updatePreferences({
    String? temperatureUnit,
    String? dateFormat,
  }) {
    final user = currentUser;
    _users[_currentUserIdIndex] = user.copyWith(
      temperatureUnit: temperatureUnit ?? user.temperatureUnit,
      dateFormat: dateFormat ?? user.dateFormat,
    );
    notifyListeners();
  }
}

/// InheritedNotifier to provide AppState down the widget tree
class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    super.key,
    required AppState super.notifier,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'No AppStateProvider found in context');
    return provider!.notifier!;
  }
}
