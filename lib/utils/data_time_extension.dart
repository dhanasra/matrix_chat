
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {

  String localizedTimeShort(BuildContext context) {
    final now = DateTime.now();

    final sameYear = now.year == year;

    final sameDay = sameYear && now.month == month && now.day == day;

    final sameWeek = sameYear &&
        !sameDay &&
        now.millisecondsSinceEpoch - millisecondsSinceEpoch <
            1000 * 60 * 60 * 24 * 7;

    if (sameDay) {
      return localizedTimeOfDay(context);
    } else if (sameWeek) {
      switch (weekday) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
    } else if (sameYear) {
      return "${month.toString().padLeft(2, '0')} ${day.toString().padLeft(2, '0')}";
    }
    return "${year.toString()} ${month.toString().padLeft(2, '0')} ${day.toString().padLeft(2, '0')}";
  }


  String localizedTimeOfDay(BuildContext context) {
    if (MediaQuery.of(context).alwaysUse24HourFormat) {
      return '${_z(hour)}:${_z(minute)}';
    } else {
      return '${_z(hour % 12 == 0 ? 12 : hour % 12)}:${_z(minute)} ${hour > 11 ? "pm" : "am"}';
    }
  }

  static String _z(int i) => i < 10 ? '0${i.toString()}' : i.toString();

}