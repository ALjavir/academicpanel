class TbaStyle {
  static String checkTBA(dynamic value) {
    if (value == null ||
        (value is String && value.trim().isEmpty) ||
        value == '') {
      return 'TBA';
    }
    return value.toString();
  }
}
