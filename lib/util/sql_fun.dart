import 'package:intl/intl.dart';

bool toBoolean(str) => str != 0 || str != '0' && str != 'false' && str != '';

String fromBoolean(value) => value ? "1" : "0";

DateTime toDateTime(value) => DateTime.parse(value);

String fromDateTime(DateTime value) => DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(value);
