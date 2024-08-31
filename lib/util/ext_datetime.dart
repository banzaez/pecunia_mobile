import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get _locale => Localizations.localeOf(Get.context!).toString();

  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  String get formatDDMMYYYY => DateFormat("dd.MM.yyyy", _locale).format(this);

  String get formatDDMMSYYYY => DateFormat("dd.MM yyyy", _locale).format(this);

  String get formatDDMMM => DateFormat("dd MMM", _locale).format(this);

  String get formatHourMin => DateFormat("HH:mm", _locale).format(this);

  String get formatYYYYMMDD => DateFormat("yyyy.MM.dd", _locale).format(this);

  bool get isToday {
    DateTime now = DateTime.now();
    return DateTime(year, month, day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays == 0;
  }

  bool get isYesterday {
    DateTime now = DateTime.now();
    return DateTime(year, month, day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays == 1;
  }
}
