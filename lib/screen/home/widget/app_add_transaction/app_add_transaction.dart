import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/widget/app_add_transaction/app_add_transaction_controller.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/number_field.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date.dart';
import 'package:pecunia/widgets/transfer/transfer.dart';

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
              Flexible(
                flex: 1,
                child: NumberField(
                  controller: controller.controllerAmount,
                  labelText: "home_button_amount".tr,
                  errorText: controller.errorAmount.value,
                ),
              ),
              AppSpaces.h8,
              Flexible(
                flex: 2,
                child: BaseField(
                  controller: controller.controllerCategory,
                  labelText: "home_button_category".tr,
                  errorText: controller.errorCategory.value,
                ),
              ),
              AppSpaces.h8,
              IconButton(
                onPressed: controller.showDate.toggle,
                icon: const Icon(Icons.date_range),
                color: AppColors.primary,
              ),
            ]),
            AppSpaces.v8,
            Visibility(
              visible: controller.showDate.isTrue,
              child: PickDate(
                onChanged: (value, type) => controller.datetime.value = value!,
                initDate: controller.datetime.value,
              ),
            ),
            AppSpaces.v8,
            _bottomRow(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (!controller.isOk()) return;
                    controller.add(-1);
                  },
                  child: Text("home_button_expense".tr),
                ),
              ),
              AppSpaces.h8,
              const Transfer(),
              AppSpaces.h8,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (!controller.isOk()) return;
                    controller.add(1);
                  },
                  child: Text("home_button_income".tr),
                ),
              ),
            ]),
          ],
        ),
      ).paddingOnly(bottom: 32).paddingSymmetric(horizontal: 8);

  // ---------------------------------------------------------------------------------------------

  Widget _bottomRow({required List<Widget> children}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (Widget widget in children) widget,
        ],
      );
}
