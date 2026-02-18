import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeStyle {
  static DateTime now = DateTime.now();
  static String formatTime12Hour(DateTime dateTime, BuildContext context) {
    try {
      final fromDateTimeIs = TimeOfDay.fromDateTime(dateTime).format(context);
      if (fromDateTimeIs == '00:00') {
        fromDateTimeIs == 'Class Time';
      }
      return fromDateTimeIs;
    } catch (e) {
      return 'TBA';
    }
  }

  static bool isDateInRange(DateTime target, DateTime start, DateTime end) {
    final t = DateTime(target.year, target.month, target.day);
    final s = DateTime(start.year, start.month, start.day);
    final e = DateTime(end.year, end.month, end.day);
    return (t.isAtSameMomentAs(s) || t.isAfter(s)) &&
        (t.isAtSameMomentAs(e) || t.isBefore(e));
  }

  static String getHybridDate(DateTime d, {int dayLeft = 7}) {
    final diff = now.difference(d);
    final isFuture = diff.isNegative;
    final absDiff = diff.abs();

    if (absDiff.inDays > dayLeft) {
      return DateFormat('d MMM').format(d);
    }

    if (absDiff.inDays >= 1) {
      if (isFuture) {
        return "${absDiff.inDays}d left";
      } else {
        return "${absDiff.inDays}d ago";
      }
    }
    if (absDiff.inHours > 0) {
      return isFuture ? "${absDiff.inHours}h left" : "${absDiff.inHours}h ago";
    }
    final minutes = absDiff.inMinutes;
    if (minutes == 0) return "Just now";
    return isFuture ? "${minutes}m left" : "${minutes}m ago";
  }

  static String getSemester() {
    String semmesterIs = '';
    if (now.month <= 4) {
      semmesterIs = "Spring - ${DateFormat('y').format(now)}";
    } else if (now.month <= 8) {
      semmesterIs = "Summer - ${DateFormat('y').format(now)}";
    } else {
      semmesterIs = "Fall - ${DateFormat('y').format(now)}";
    }

    return semmesterIs;
  }
}
