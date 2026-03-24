import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/screen/transactions/transactions_arguments.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_type.dart';

class AnalyticsController extends BaseController {
  final AppController _appController = Get.find();
  final SQLProvider _sqlProvider = Get.find();
  final TransactionController _transactionController = Get.find();

  final RxList<Analytics> _analytics = RxList();

  final Rx<DateTime> _date = DateTime.now().startOfDay.obs;
  DateTime get date => _date.value;

  final Rx<DateType> _period = DateType.year.obs;
  DateType get period => _period.value;

  final RxBool _detail = false.obs;
  bool get detail => _detail.value;
  set detail(bool value) {
    _detail.value = value;
    _refreshAnalytics();
  }

  final Rx<AnalyticsFilter> _filter = AnalyticsFilter.total.obs;
  AnalyticsFilter get filter => _filter.value;
  set filter(AnalyticsFilter value) {
    _filter.value = value;
    _refreshAnalytics();
  }

  // Доступные значения для пикера дат — загружаются из БД независимо от текущего фильтра
  final RxList<int> _valuesYear = <int>[].obs;
  final RxList<int> _valuesMonth = <int>[].obs;
  final RxList<int> _valuesDay = <int>[].obs;

  List<int> get valuesYear => _valuesYear;
  List<int> get valuesMonth => _valuesMonth;
  List<int> get valuesDay => _valuesDay;

  //----------INIT-------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();
    _refreshAll();
  }

  //----------NAVIGATION-------------------------------------------------------------------------

  void goToDetails({required int categoryId}) {
    final TransactionsArguments arguments = TransactionsArguments(
      walletId: _transactionController.walletId,
      categoryId: categoryId,
      startDate: interval.first,
      endDate: interval.last,
    );
    _appController.goToScreen(AppScreens.transactions, arguments: arguments);
  }

  //----------DATE SELECTION---------------------------------------------------------------------

  void setDate(DateTime value, DateType type) {
    final prevYear = _date.value.year;
    final prevMonth = _date.value.month;
    _date.value = value.startOfDay;
    _period.value = type;
    _refreshAnalytics();
    if (_date.value.year != prevYear) {
      _loadAvailableMonths();
      _loadAvailableDays();
    } else if (_date.value.month != prevMonth) {
      _loadAvailableDays();
    }
  }

  //----------DATA-------------------------------------------------------------------------------

  List<Analytics> get category => _analytics;

  double? get total => _analytics.fold(0.0, (value, e) => (value ?? 0) + e.total);

  List<DateTime> get interval => switch (_period.value) {
        DateType.year => [date.startOfYear, date.endOfYear],
        DateType.month => [date.startOfMonth, date.endOfMonth],
        DateType.day ||
        DateType.hour ||
        DateType.minute =>
          [date.startOfDay, date.endOfDay],
      };

  String get periodStr => switch (period) {
        DateType.year => date.toFormat("yyyy"),
        DateType.month => date.toFormat("MMMM yyyy"),
        DateType.day ||
        DateType.hour ||
        DateType.minute =>
          date.toFormat("dd MMMM yyyy"),
      };

  //----------LOAD-------------------------------------------------------------------------------

  Future<void> _refreshAll() => Future.wait([
        _refreshAnalytics(),
        _loadAvailableYears(),
        _loadAvailableMonths(),
        _loadAvailableDays(),
      ]);

  Future<void> _refreshAnalytics() async {
    _analytics.value = await _sqlProvider.analytics.selectByWalletId(
      walletId: _transactionController.walletId,
      filter: filter,
      detail: detail,
      startDate: interval.first,
      endDate: interval.last,
    );
  }

  Future<void> _loadAvailableYears() async {
    _valuesYear.value = await _sqlProvider.transactions.availableYears(
      _transactionController.walletId,
    );
  }

  Future<void> _loadAvailableMonths() async {
    _valuesMonth.value = await _sqlProvider.transactions.availableMonths(
      _transactionController.walletId,
      _date.value.year,
    );
  }

  Future<void> _loadAvailableDays() async {
    _valuesDay.value = await _sqlProvider.transactions.availableDays(
      _transactionController.walletId,
      _date.value.year,
      _date.value.month,
    );
  }
}
