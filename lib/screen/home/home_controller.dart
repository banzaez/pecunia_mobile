import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/base_controller.dart';

class HomeController extends BaseController {
  AppController appController = Get.find<AppController>();

  TextEditingController controllerSumma = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();

  RxList items = RxList();

  // ----------INIT-------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

  }

  // ----------NAVIGATION------------------------------------------------------------------------

  void goToProfile() => appController.goToScreen(AppScreens.profile);

}
