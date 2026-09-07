class DateFormatter {
  DateFormatter._();

  static String formatWaterDays(int days) {
    if (days <= 0) {
      return 'Now';
    }
    return '${days}d';
  }

  static String formatWaterStatusText(int days) {
    if (days <= 0) {
      return 'Needs water today';
    } else if (days == 1) {
      return 'Water tomorrow';
    } else {
      return 'Water in $days days';
    }
  }
}
