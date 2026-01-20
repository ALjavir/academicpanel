import 'package:intl/intl.dart';

class HybriddateStyle {
  static String getHybridDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    final isFuture = diff.isNegative;
    final absDiff = diff.abs();

    if (absDiff.inDays > 7) {
      return DateFormat('d MMM').format(d);
    }
    final String weekday = DateFormat(
      'E',
    ).format(DateTime(d.year, d.month, d.day));
    // final String weekday = DateFormat('E').format(d);
    if (absDiff.inDays >= 1) {
      if (isFuture) {
        return "In ${absDiff.inDays}d • $weekday";
      } else {
        return "${absDiff.inDays}d ago • $weekday";
      }
    }
    if (absDiff.inHours > 0) {
      return isFuture ? "In ${absDiff.inHours}h" : "${absDiff.inHours}h ago";
    }
    final minutes = absDiff.inMinutes;
    if (minutes == 0) return "Just now";
    return isFuture ? "In ${minutes}m" : "${minutes}m ago";
  }
}
