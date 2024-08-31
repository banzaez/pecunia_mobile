import 'package:get/get.dart';
import 'package:pecunia/screen/home/home_controller.dart';

class HomeBinding implements Binding {
  @override
  List<Bind> dependencies() => [
        Bind.put(HomeController(), permanent: true),
      ];
}
