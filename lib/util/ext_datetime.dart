import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get _locale => Intl.getCurrentLocale();

  String get formatDDMMYYYY => DateFormat("dd.MM.yyyy", _locale).format(this);

  String get formatDDMMSYYYY => DateFormat("dd.MM yyyy", _locale).format(this);

  String get formatDDMMM => DateFormat("dd MMM", _locale).format(this);

  String get formatMMMM => DateFormat("MMMM", _locale).format(this);

  String get formatHourMin => DateFormat("HH:mm", _locale).format(this);

  String get formatYYYYMMDD => DateFormat("yyyy.MM.dd", _locale).format(this);

  String toFormat(String format) => DateFormat(format, _locale).format(this);

  // --------------------------------------------------------------------------------------------

  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get endOfMonth {
    DateTime startOfNextMonth = (month < 12)
        ? DateTime(year, month + 1, 1)
        : DateTime(year + 1, 1, 1);
    return startOfNextMonth.subtract(const Duration(milliseconds: 1));
  }

  DateTime get startOfYear => DateTime(year, 1, 1);

  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  // --------------------------------------------------------------------------------------------

  bool get isToday => DateTime.now().difference(startOfDay).inDays == 0;

  bool get isYesterday => DateTime.now().difference(startOfDay).inDays == 1;

  int get daysInMonth => DateTime(year, month + 1, 0).day;
}
