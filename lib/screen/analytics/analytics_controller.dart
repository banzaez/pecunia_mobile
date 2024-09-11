import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/provider/sql_analytics.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/screen/transactions/transactions_arguments.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_field.dart';

class AnalyticsController extends GetxController {
  final AppController _appController = Get.find();
  final SQLProvider _sqlProvider = Get.find();
  final TransactionController _transactionController = Get.find();

  final RxList<Analytics> _analytics = RxList();

  final Rx<DateTime> _date = DateTime.now().startOfDay.obs;

  DateTime get date => _date.value;

  setDate(DateTime value, DateType type) {
    _date.value = value.startOfDay;
    _period.value = type;
  }

  final Rx<AnalyticsFilter> _filter = AnalyticsFilter.total.obs;

  AnalyticsFilter get filter => _filter.value;

  set filter(AnalyticsFilter value) {
    _filter.value = value;
    _refreshAnalytics();
  }

  final Rx<DateType> _period = DateType.year.obs;

  DateType get period => _period.value;

  List<Transaction> get transactionList => _transactionController.transactions;

  String get periodStr => switch (period) {
        DateType.year => date.toFormat("yyyy"),
        DateType.month => date.toFormat("MMMM yyyy"),
        DateType.day => date.toFormat("dd MMMM yyyy"),
        DateType.hour => date.toFormat("HH:mm"),
        DateType.minute => date.toFormat("HH:mm"),
      };

  List<int> get valuesYear => category.map((e) => e.date.year).toSet().toList();

  List<int> get valuesMonth => category.map((e) => e.date.month).toSet().toList();

  List<int> get valuesDay => category.map((e) => e.date.day).toSet().toList();

  //----------INIT-------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    _refreshAnalytics();
  }

  //----------NAVIGATION-------------------------------------------------------------------------

  goToDetails({required int categoryId}) {
    final TransactionsArguments arguments = TransactionsArguments(
      walletId: _transactionController.walletId,
      categoryId: categoryId,
      startDate: interval.first,
      endDate: interval.last,
    );
    return _appController.goToScreen(AppScreens.transactions, arguments: arguments);
  }

  //---------------------------------------------------------------------------------------------

  Future<void> _refreshAnalytics() async => _analytics.value = await _sqlProvider.analytics
      .allAnalytics(walletId: _transactionController.walletId, filter: filter);

  //---------------------------------------------------------------------------------------------

  List<Analytics> get category {
    final list = switch (_period.value) {
      DateType.year => _analytics.where((e) => e.date.year == date.year),
      DateType.month => _analytics.where((e) => e.startOfMonth == date.startOfMonth),
      DateType.day => _analytics.where((e) => e.date == date),
      DateType.hour => throw UnimplementedError(),
      DateType.minute => throw UnimplementedError(),
    };
    return list.toList();
  }

  double? get total => category.fold(0.0, (value, e) => (value ?? 0) + e.total);

  List<DateTime> get interval => switch (_period.value) {
        DateType.year => [date.startOfYear, date.endOfYear],
        DateType.month => [date.startOfMonth, date.endOfMonth],
        DateType.day => [date.startOfDay, date.endOfDay],
        DateType.hour => throw UnimplementedError(),
        DateType.minute => throw UnimplementedError(),
      };
}
