import '../models/care_tip.dart';

class MockCareTips {
  static const CareTip tipAlex = CareTip(
    id: 'tip-1',
    title: 'Care Tip of the Day',
    content:
        'Dust your plant leaves gently with a damp cloth to help them absorb more sunlight and breathe easier.',
    category: 'Maintenance',
  );

  static const CareTip tipSarah = CareTip(
    id: 'tip-2',
    title: 'Humidity Advice',
    content:
        'Mist tropical plants like Calatheas and Ferns in the morning to maintain optimal relative humidity.',
    category: 'Humidity',
  );

  static const CareTip tipDavid = CareTip(
    id: 'tip-3',
    title: 'Winter Watering Rule',
    content:
        'Always check the top 2 inches of soil with your finger before watering succulents to prevent root rot.',
    category: 'Watering',
  );
}
