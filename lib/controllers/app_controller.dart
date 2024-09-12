import 'package:get/get.dart';

class AppController extends GetxController {
  static bool isRoundUp = false;

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
  analytics,
  backup,
  home,
  profile,
  transactions,
  wallets;

  String get route => switch (this) {
        home => "/",
        analytics => "/analytics",
        backup => "/backup",
        profile => "/profile",
        transactions => "/transactions",
        wallets => "/wallets",
      };
}
