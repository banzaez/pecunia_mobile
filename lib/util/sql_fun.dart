import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/finance_category.dart';

bool toBoolean(str) => str != 0 || str != '0' && str != 'false' && str != '';

String fromBoolean(value) => value ? "1" : "0";

DateTime toDateTime(value) => DateTime.parse(value);

String fromDateTime(DateTime value) => DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(value);

int toInt(String value) => int.tryParse(value) ?? 0;

int fromCategory(FinanceCategory? category) => category?.id ?? -1;

FinanceCategory? toCategory(int? value) => value == null ? null : FinanceCategories.allCategories
    .firstWhereOrNull((element) => element.id == value);
