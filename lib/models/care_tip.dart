class CareTip {
  final String id;
  final String title;
  final String content;
  final String? category;

  const CareTip({
    required this.id,
    required this.title,
    required this.content,
    this.category,
  });
}
