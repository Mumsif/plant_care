enum PlantStatus {
  thriving,
  good,
  needsWater,
}

extension PlantStatusExtension on PlantStatus {
  String get label {
    switch (this) {
      case PlantStatus.thriving:
        return 'Thriving';
      case PlantStatus.good:
        return 'Good';
      case PlantStatus.needsWater:
        return 'Needs Water';
    }
  }
}

class Plant {
  final String id;
  final String name;
  final String species;
  final String location;
  final String imageUrl;
  final int waterDaysLeft;
  final PlantStatus status;
  final bool isIndoor;
  final String waterAmount;
  final String? lightRequirement;
  final DateTime? lastWatered;

  const Plant({
    required this.id,
    required this.name,
    required this.species,
    required this.location,
    required this.imageUrl,
    required this.waterDaysLeft,
    required this.status,
    this.isIndoor = true,
    this.waterAmount = '200ml',
    this.lightRequirement = 'Indirect sunlight',
    this.lastWatered,
  });

  Plant copyWith({
    String? id,
    String? name,
    String? species,
    String? location,
    String? imageUrl,
    int? waterDaysLeft,
    PlantStatus? status,
    bool? isIndoor,
    String? waterAmount,
    String? lightRequirement,
    DateTime? lastWatered,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      waterDaysLeft: waterDaysLeft ?? this.waterDaysLeft,
      status: status ?? this.status,
      isIndoor: isIndoor ?? this.isIndoor,
      waterAmount: waterAmount ?? this.waterAmount,
      lightRequirement: lightRequirement ?? this.lightRequirement,
      lastWatered: lastWatered ?? this.lastWatered,
    );
  }
}
