import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_field.dart';

class AnalyticsController extends GetxController {
  final SQLProvider _sqlProvider = Get.find();
  final TransactionController _transactionController = Get.find();

  final RxList<Analytics> yearList = RxList();
  final RxList<Analytics> yearCategoryList = RxList();
  final RxList<Analytics> monthList = RxList();
  final RxList<Analytics> monthCategoryList = RxList();
  final RxList<Analytics> dayList = RxList();
  final RxList<Analytics> dayCategoryList = RxList();

  final Rx<DateTime> _dateTime = DateTime.now().obs;
  DateTime get dateTime => _dateTime.value;
  setDateTime(DateTime value, PickDateTypeField type) {
    if (type == PickDateTypeField.year) {
      _type.value = AnalyticsType.year;
    } else if (type == PickDateTypeField.month) {
      _type.value = AnalyticsType.month;
    } else if (type == PickDateTypeField.day) {
      _type.value = AnalyticsType.day;
    }

    _dateTime.value = value;
  }

  final Rx<AnalyticsType> _type = AnalyticsType.month.obs;

  List<Transaction> get transactionList => _transactionController.transactions;

  bool get isYearSelected => _type.value == AnalyticsType.year;
  bool get isMonthSelected => _type.value == AnalyticsType.month;
  bool get isDaySelected => _type.value == AnalyticsType.day;


  //----------INIT-------------------------------------------------------------------------------

  @override
  void onReady() {
    super.onReady();

    refreshAnalytics();
  }

  //---------------------------------------------------------------------------------------------

  Future<void> refreshAnalytics() async {
     final results = await _sqlProvider.analytics.analytics(1);

     yearList.value = results[0];
     yearCategoryList.value = results[1];
     monthList.value = results[2];
     monthCategoryList.value = results[3];
     dayList.value = results[4];
     dayCategoryList.value = results[5];
  }
}

enum AnalyticsType {
  year,
  month,
  day,
}
