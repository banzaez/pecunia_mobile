import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/category_field.dart';
import 'package:pecunia/widgets/fields/number_field.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction_controller.dart';
import 'package:pecunia/widgets/transfer/transfer.dart';

class SettingTransaction extends StatelessWidget {
  const SettingTransaction({super.key, this.transaction, this.onChange});

  final ValueChanged? onChange;
  final Transaction? transaction;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => setting(TransactionType.expense),
              child: Text("home_button_expense".tr),
            ),
          ),
          AppSpaces.h8,
          const Transfer(),
          AppSpaces.h8,
          Expanded(
            child: ElevatedButton(
              onPressed: () => setting(TransactionType.income),
              child: Text("home_button_income".tr),
            ),
          ),
        ],
      ).paddingOnly(bottom: 32).paddingSymmetric(horizontal: 8);

  // --------------------------------------------------------------------------------------------

  static Future<void> setting(TransactionType type, [Transaction? transaction]) async =>
      appBottomSheet(SingleChildScrollView(
        child: GetX<SettingTransactionController>(
          init: SettingTransactionController(type: type, transaction: transaction),
          builder: (controller) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("setting_tran_title".tr),
              AppSpaces.v16,
              NumberField(
                autofocus: true,
                controller: controller.amount,
                labelText: "setting_tran_amount".tr,
                errorText: controller.errorAmount.value,
              ),
              AppSpaces.v16,
              CategoryField(
                onChanged: (value) => controller.category.value = value,
                type: controller.type,
                value: controller.category.value,
                error: controller.errorCategory.value,
              ),
              AppSpaces.v16,
              BaseField(
                controller: controller.description,
                maxLines: 3,
                labelText: "setting_tran_description".tr,
              ),
              AppSpaces.v16,
              AppSwitch(
                onChange: (value) => controller.type = value,
                values: [
                  AppSwitchValue(
                    label: "setting_tran_expenses".tr,
                    value: TransactionType.expense,
                  ),
                  AppSwitchValue(
                    label: "setting_tran_income".tr,
                    value: TransactionType.income,
                  ),
                ],
                value: controller.type,
              ),
              AppSpaces.v16,
              PickDate(
                onChanged: (value, type) => controller.datetime.value = value!,
                initDate: controller.datetime.value,
              ),
              AppSpaces.v32,
              ElevatedButton(
                onPressed: () {
                  if (!controller.isOk()) return;
                  Get.backLegacy(result: controller.save());
                },
                child: Text("setting_tran_save".tr),
              ),
              AppSpaces.v16,
            ],
          ),
        ),
      ));
}
