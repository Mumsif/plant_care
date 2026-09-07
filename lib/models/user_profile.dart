import 'plant.dart';
import 'watering_task.dart';
import 'care_tip.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final bool wateringReminders;
  final bool careTipsEnabled;
  final bool weeklySummary;
  final String temperatureUnit;
  final String dateFormat;
  final String themePreference; // 'Light', 'Dark', 'System'
  final List<Plant> plants;
  final List<WateringTask> tasks;
  final CareTip careTip;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.wateringReminders = true,
    this.careTipsEnabled = true,
    this.weeklySummary = false,
    this.temperatureUnit = 'Celsius (°C)',
    this.dateFormat = 'DD/MM/YYYY',
    this.themePreference = 'Light',
    required this.plants,
    required this.tasks,
    required this.careTip,
  });

  int get totalPlants => plants.length;

  int get needWaterCount => plants.where((p) => p.waterDaysLeft == 0 || p.status == PlantStatus.needsWater).length;

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    bool? wateringReminders,
    bool? careTipsEnabled,
    bool? weeklySummary,
    String? temperatureUnit,
    String? dateFormat,
    String? themePreference,
    List<Plant>? plants,
    List<WateringTask>? tasks,
    CareTip? careTip,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      wateringReminders: wateringReminders ?? this.wateringReminders,
      careTipsEnabled: careTipsEnabled ?? this.careTipsEnabled,
      weeklySummary: weeklySummary ?? this.weeklySummary,
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      dateFormat: dateFormat ?? this.dateFormat,
      themePreference: themePreference ?? this.themePreference,
      plants: plants ?? this.plants,
      tasks: tasks ?? this.tasks,
      careTip: careTip ?? this.careTip,
    );
  }
}
