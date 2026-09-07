class WateringTask {
  final String id;
  final String plantId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String actionText;
  final bool isCompleted;
  final bool isWatering;

  const WateringTask({
    required this.id,
    required this.plantId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.actionText = 'Water Now',
    this.isCompleted = false,
    this.isWatering = true,
  });

  WateringTask copyWith({
    String? id,
    String? plantId,
    String? title,
    String? subtitle,
    String? imageUrl,
    String? actionText,
    bool? isCompleted,
    bool? isWatering,
  }) {
    return WateringTask(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      actionText: actionText ?? this.actionText,
      isCompleted: isCompleted ?? this.isCompleted,
      isWatering: isWatering ?? this.isWatering,
    );
  }
}
