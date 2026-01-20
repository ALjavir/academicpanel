class DateInRange {
  static bool isDateInRange(DateTime target, DateTime start, DateTime end) {
    // Normalize all dates to midnight (00:00:00) to ignore time differences
    final t = DateTime(target.year, target.month, target.day);
    final s = DateTime(start.year, start.month, start.day);
    final e = DateTime(end.year, end.month, end.day);

    // Check: (Target >= Start) AND (Target <= End)
    return (t.isAtSameMomentAs(s) || t.isAfter(s)) &&
        (t.isAtSameMomentAs(e) || t.isBefore(e));
  }
}
