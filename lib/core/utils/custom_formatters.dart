import 'package:intl/intl.dart';

class CustomFormatters {
  static String getMonth(String isoString) {
    final date = DateTime.parse(isoString).toLocal();
    ;
    return DateFormat.MMMM().format(date); // October
  }

  static String getDay(String isoString) {
    final date = DateTime.parse(isoString).toLocal();
    ;
    return DateFormat.d().format(date); // 3
  }

  static String getYear(String isoString) {
    final date = DateTime.parse(isoString).toLocal();
    ;
    return DateFormat.y().format(date); // 2025
  }

  static String getShortMonth(String isoString) {
    final date = DateTime.parse(isoString).toLocal();
    ;
    return DateFormat.MMM().format(date); // Oct
  }

  static String getWeekdayShort(String isoString) {
    final date = DateTime.parse(isoString).toLocal();
    ;
    return DateFormat.E().format(date); // Fri
  }

  static String getWeekday(String isoString) {
    final date = DateTime.parse(isoString).toLocal();
    ;
    return DateFormat.EEEE().format(date);
  }

  static String getDayWithMonth(String isoString) {
    final date = DateTime.parse(isoString).toLocal();
    ;
    final day = date.day;
    String suffix;

    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    final month = DateFormat.MMMM().format(date);
    return '$day$suffix $month'; // e.g., 17th October
  }

  static bool isToday(String isoString) {
    final date = DateTime.parse(isoString);
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isSameDayAsToday(String isoString) {
    // Parse the ISO string to DateTime
    final date = DateTime.parse(isoString).toLocal();
    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
