import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/provider/sql_analytics.dart';
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
      _period.value = AnalyticsPeriod.year;
    } else if (type == PickDateTypeField.month) {
      _period.value = AnalyticsPeriod.month;
    } else if (type == PickDateTypeField.day) {
      _period.value = AnalyticsPeriod.day;
    }

    _date.value = value.startOfDay;
  }

  final Rx<AnalyticsFilter> _filter = AnalyticsFilter.total.obs;

  AnalyticsFilter get filter => _filter.value;

  set filter(AnalyticsFilter value) {
    _filter.value = value;
    _refreshAnalytics();
  }

  final Rx<AnalyticsPeriod> _period = AnalyticsPeriod.year.obs;

  List<Transaction> get transactionList => _transactionController.transactions;

  String get periodStr => switch (_period.value) {
        AnalyticsPeriod.year => date.toFormat("yyyy"),
        AnalyticsPeriod.month => date.toFormat("MMMM yyyy"),
        AnalyticsPeriod.day => date.toFormat("dd MMMM yyyy"),
      };

  bool get isYearSelected => _period.value == AnalyticsPeriod.year;

  bool get isMonthSelected => _period.value == AnalyticsPeriod.month;

  bool get isDaySelected => _period.value == AnalyticsPeriod.day;

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
    final results = await _sqlProvider.analytics
        .allAnalytics(walletId: _transactionController.walletId, filter: filter);

    _years.value = results[0];
    _yearsCategory.value = results[1];
    _months.value = results[2];
    _monthsCategory.value = results[3];
    _days.value = results[4];
    _daysCategory.value = results[5];
  }

  //---------------------------------------------------------------------------------------------

  double? get amount => switch (_period.value) {
        AnalyticsPeriod.year => _years.firstWhereOrNull((e) => e.date.year == date.year)?.amount,
        AnalyticsPeriod.month => _months
            .firstWhereOrNull((e) => e.date.year == date.year && e.date.month == date.month)
            ?.amount,
        AnalyticsPeriod.day => _days.firstWhereOrNull((e) => e.date == date)?.amount,
      };

  List<Analytics> get category => switch (_period.value) {
        AnalyticsPeriod.year => _yearsCategory.where((e) => e.date.year == date.year).toList(),
        AnalyticsPeriod.month => _monthsCategory
            .where((e) => e.date.year == date.year && e.date.month == date.month)
            .toList(),
        AnalyticsPeriod.day => _daysCategory.where((e) => e.date == date).toList(),
      };
}
