import 'package:get/get.dart';

class AppController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  //----------NAVIGATION-------------------------------------------------------------------------

  Future<void> goToScreen(AppScreens screen, {bool addToStack = true, dynamic arguments}) async {
    addToStack
        ? await Get.toNamed(screen.route, arguments: arguments)
        : await Get.offAllNamed(screen.route, arguments: arguments);
  }
}

enum AppScreens {
  home,
  analytics,
  profile,
  transactions;

  String get route => switch (this) {
        home => "/",
        profile => "/profile",
        analytics => "/analytics",
        transactions => "/transactions",
      };
}
