import 'package:currency_picker/currency_picker.dart';
import 'package:intl/intl.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/finance_category.dart';

DateTime toDateTime(String value) => DateTime.parse(value);

String fromDateTime(DateTime value) => DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(value);

int toInt(String value) => int.tryParse(value) ?? 0;

int? fromCategory(FinanceCategory? category) => category?.id ?? -1;

FinanceCategory? toCategory(int? value) =>
    value == null ? null : FinanceCategories.getCategoryById(value);

Currency? toCurrency(String value) => CurrencyService().findByCode(value);

String fromCurrency(Currency? currency) => currency?.code ?? "";
