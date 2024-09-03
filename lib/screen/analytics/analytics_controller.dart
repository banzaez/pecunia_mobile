import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_field.dart';

class AnalyticsController extends GetxController {
  final SQLProvider _sqlProvider = Get.find();
  final TransactionController _transactionController = Get.find();

  final RxList<Analytics> _years = RxList();
  final RxList<Analytics> _yearsCategory = RxList();
  final RxList<Analytics> _months = RxList();
  final RxList<Analytics> _monthsCategory = RxList();
  final RxList<Analytics> _days = RxList();
  final RxList<Analytics> _daysCategory = RxList();

  final Rx<DateTime> _date = DateTime.now().startOfDay.obs;

  DateTime get date => _date.value;

  setDate(DateTime value, PickDateTypeField type) {
    if (type == PickDateTypeField.year) {
      _type.value = AnalyticsType.year;
    } else if (type == PickDateTypeField.month) {
      _type.value = AnalyticsType.month;
    } else if (type == PickDateTypeField.day) {
      _type.value = AnalyticsType.day;
    }

    _date.value = value.startOfDay;
  }

  final Rx<AnalyticsType> _type = AnalyticsType.year.obs;

  List<Transaction> get transactionList => _transactionController.transactions;

  bool get isYearSelected => _type.value == AnalyticsType.year;

  bool get isMonthSelected => _type.value == AnalyticsType.month;

  bool get isDaySelected => _type.value == AnalyticsType.day;

  List<int> get valuesYear => _years.map((e) => e.date.year).toList();

  List<int> get valuesMonth =>
      _months.where((e) => e.date.year == date.year).map((e) => e.date.month).toList();

  List<int> get valuesDay => _days
      .where((e) => e.date.year == date.year && e.date.month == date.month)
      .map((e) => e.date.day)
      .toList();

  //----------INIT-------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    _refreshAnalytics();
  }

  //---------------------------------------------------------------------------------------------

  Future<void> _refreshAnalytics() async {
    final results = await _sqlProvider.analytics.analytics(_transactionController.walletId);

    _years.value = results[0];
    _yearsCategory.value = results[1];
    _months.value = results[2];
    _monthsCategory.value = results[3];
    _days.value = results[4];
    _daysCategory.value = results[5];
  }

  //---------------------------------------------------------------------------------------------

  double? get amount => switch (_type.value) {
        AnalyticsType.year => _years.firstWhereOrNull((e) => e.date.year == date.year)?.amount,
        AnalyticsType.month => _months
            .firstWhereOrNull((e) => e.date.year == date.year && e.date.month == date.month)
            ?.amount,
        AnalyticsType.day => _days.firstWhereOrNull((e) => e.date == date)?.amount,
      };

  List<Analytics> get category => switch (_type.value) {
        AnalyticsType.year => _yearsCategory.where((e) => e.date.year == date.year).toList(),
        AnalyticsType.month => _monthsCategory
            .where((e) => e.date.year == date.year && e.date.month == date.month)
            .toList(),
        AnalyticsType.day => _daysCategory.where((e) => e.date == date).toList(),
      };
}

enum AnalyticsType {
  year,
  month,
  day,
}
