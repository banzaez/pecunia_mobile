import 'package:get/get.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/provider/sql_provider.dart';

class AnalyticsController extends GetxController {
  final SQLProvider _sqlProvider = Get.find();

  RxList<Analytics> analytics = RxList();

  @override
  void onReady() {
    super.onReady();

    refreshAnalytics();
  }

  Future<void> refreshAnalytics() async =>
      analytics.value = await _sqlProvider.transactions.selectAllAnalyticsById(1);
}
