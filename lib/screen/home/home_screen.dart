import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_botton_sheet.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/bool_switch.dart';
import 'package:pecunia/widgets/fields/dropdown_field.dart';
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

  Widget _leading() => IconButton(
        onPressed: _setting,
        icon: const Icon(Icons.settings),
      );

  Widget _profile() => IconButton(
        onPressed: controller.goToProfile,
        icon: const Icon(Icons.account_box),
      );

  AppBar _appBar() => AppBar(
        leading: _leading(),
        title: Column(
          children: [
            Text("Кошелек"),
            Text(
              "home_current_wallet".tr,
              style: AppTextStyle.text12w400(),
            ),
          ],
        ),
        actions: [
          _profile(),
        ],
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (_, index) => ListView(),
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

  // --------------------------------------------------------------------------------------------

  Future<void> _setting() async => appBottomSheet(
        children: [
          AppSpaces.v8,
          Text("home_bottom_sheet_title".tr, style: AppTextStyle.text22w400()),
          AppSpaces.v16,
          BaseField(
              //labelText: "NAME WALLET",
              ),
          Text("home_bottom_sheet_name".tr),
          AppSpaces.v16,
          DropdownField(items: [], hint: "hint"),
          Text("home_bottom_sheet_currency".tr),
          AppSpaces.v16,
          BoolSwitch(
            onChange: (value) {},
            textPrimary: "no".tr,
            textSecond: "yes".tr,
            value: false,
            width: 256,
          ),
          Text("home_bottom_sheet_show_balance".tr),
          AppSpaces.v16,
          BoolSwitch(
            onChange: (value) {},
            textPrimary: "no".tr,
            textSecond: "yes".tr,
            value: false,
            width: 256,
          ),
          Text("home_bottom_sheet_round".tr),
          AppSpaces.v32,
          ElevatedButton(onPressed: () {}, child: Text("home_bottom_sheet_button_save".tr)),
        ],
      );
}
