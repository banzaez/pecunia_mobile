import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/widget/app_add_transaction/app_add_transaction_controller.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/number_field.dart';

class AppAddTransaction extends StatelessWidget {
  const AppAddTransaction({super.key});

  @override
  Widget build(BuildContext context) => GetX<AppAddTransactionController>(
        init: AppAddTransactionController(),
        builder: (controller) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSpaces.v8,
            _bottomRow(children: [
              NumberField(
                controller: controller.controllerAmount,
                labelText: "home_button_summa".tr,
                errorText: controller.errorAmount.value,
              ),
              AppSpaces.h8,
              BaseField(
                controller: controller.controllerCategory,
                labelText: "home_button_category".tr,
                errorText: controller.errorCategory.value,
              ),
            ]),
            AppSpaces.v8,
            _bottomRow(children: [
              ElevatedButton(
                onPressed: () {
                  if (!controller.isOk()) return;
                  controller.add(1);
                },
                child: Text("home_button_income".tr),
              ),
              AppSpaces.h8,
              ElevatedButton(
                onPressed: () {
                  if (!controller.isOk()) return;
                  controller.add(-1);
                },
                child: Text("home_button_expense".tr),
              ),
            ]),
          ],
        ),
      ).paddingOnly(bottom: 32);

  // ---------------------------------------------------------------------------------------------

  Widget _bottomRow({required List<Widget> children}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (Widget widget in children) widget is SizedBox ? widget : Expanded(child: widget),
        ],
      );
}
