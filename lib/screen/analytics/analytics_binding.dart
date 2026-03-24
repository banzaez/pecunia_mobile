import 'package:get/get.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';

class AnalyticsBinding implements Binding {
  @override
  List<Bind> dependencies() => [
        Bind.put(AnalyticsController()),
      ];
}
