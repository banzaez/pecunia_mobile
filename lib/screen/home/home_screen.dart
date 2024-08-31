import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/widget/current_wallet.dart';
import 'package:pecunia/screen/profile/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/number_field.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(),
        bottomSheet: _bottom(),
      );

  // --------------------------------------------------------------------------------------------

  Widget _leading() => Obx(() => SettingWallet(update: controller.currentWallet.value));

  Widget _profile() => IconButton(
        onPressed: controller.goToProfile,
        icon: const Icon(Icons.account_box),
      );

  AppBar _appBar() => AppBar(
        leading: _leading(),
        title: const CurrentWallet(),
        actions: [
          _profile(),
        ],
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => ListView.builder(
        itemCount: 0,
        itemBuilder: (_, index) => SizedBox(),
      );

  Widget _bottomRow({required List<Widget> children}) => Row(
        children: [
          for (Widget widget in children) widget is SizedBox ? widget : Expanded(child: widget),
        ],
      );

  Widget _bottom() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _bottomRow(children: [
            NumberField(
              controller: controller.controllerSumma,
              labelText: "home_button_summa".tr,
            ),
            AppSpaces.h8,
            BaseField(
              controller: controller.controllerCategory,
              labelText: "home_button_category".tr,
            ),
          ]),
          AppSpaces.v8,
          _bottomRow(children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("home_button_income".tr),
            ),
            AppSpaces.h8,
            ElevatedButton(
              onPressed: () {},
              child: Text("home_button_expense".tr),
            ),
          ]),
        ],
      ).paddingOnly(bottom: 16);
}
