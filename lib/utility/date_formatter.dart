// ignore_for_file: unnecessary_this

import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  /// yyyy-MM-dd
  String toYearMonthDayFormatte() {
    return "${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }

  /// yyyy-MM-dd HH:mm:ss
  String toYearMonthDayHourMinuteSecondFormatte() {
    return "${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
  }

  /// HH:mm:ss
  String toHoursMinutesSeconds() => "${this.hour} : ${this.minute} : ${this.second}";

  /// HH:mm a
  String toHoursMinutesPer() =>
      "${this.minute} : ${this.hour > 12 ? this.hour - 12 : this.hour} ${this.hour > 12 ? "PM" : "AM"}";

  /// HH:mm
  String toHoursMinutes() => "${this.minute} : ${this.hour > 12 ? this.hour - 12 : this.hour}";

  static String formatTime(DateTime time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  static String formatDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    String formattedDate = DateFormat.yMd().add_jm().format(dateTime);

    return formattedDate.toString();
  }
}
