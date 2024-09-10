import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/number_field.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction_controller.dart';
import 'package:pecunia/widgets/transfer/transfer.dart';

class SettingTransaction extends StatelessWidget {
  const SettingTransaction({super.key, this.update, this.onChange});

  final ValueChanged? onChange;
  final Transaction? update;

  @override
  @override
  Widget build(BuildContext context) => GetX<SettingTransactionController>(
    init: SettingTransactionController(update),
    builder: (controller) => Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _setting,
            child: Text("home_button_expense".tr),
          ),
        ),
        AppSpaces.h8,
        const Transfer(),
        AppSpaces.h8,
        Expanded(
          child: ElevatedButton(
            onPressed: _setting,
            child: Text("home_button_income".tr),
          ),
        ),
      ],
    ),
  ).paddingOnly(bottom: 32).paddingSymmetric(horizontal: 8);

  // --------------------------------------------------------------------------------------------

  Future<void> _setting() async => appBottomSheet(SingleChildScrollView(
        child: GetX<SettingTransactionController>(
          builder: (controller) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("tran_dialog_edit_title".tr),
              AppSpaces.v16,
              _sizeField(
                child: NumberField(
                  autofocus: true,
                  controller: controller.controllerAmount,
                  labelText: "tran_dialog_edit_amount".tr,
                  errorText: controller.errorAmount.value,
                ),
              ),
              AppSpaces.v16,
              _sizeField(
                child: BaseField(
                  controller: controller.controllerCategory,
                  labelText: "tran_dialog_edit_category".tr,
                  errorText: controller.errorCategory.value,
                ),
              ),
              AppSpaces.v16,
              _sizeField(
                child: BaseField(
                  controller: controller.controllerDescription,
                  maxLines: 3,
                  labelText: "tran_dialog_edit_description".tr,
                ),
              ),
              AppSpaces.v16,
              PickDate(
                onChanged: (value, type) => controller.datetime.value = value!,
                initDate: controller.datetime.value,
              ),
              AppSpaces.v16,
              _sizeField(
                child: AppSwitch(
                  onChange: (value) => controller.i.value = value,
                  values: [
                    AppSwitchValue(label: "tran_dialog_edit_expenses".tr, value: -1),
                    AppSwitchValue(label: "tran_dialog_edit_income".tr, value: 1),
                  ],
                  value: controller.i.value,
                ),
              ),
              AppSpaces.v16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (!controller.isOk()) return;
                      Get.backLegacy(result: controller.save());
                    },
                    child: Text(
                      "tran_dialog_edit_save".tr,
                      style: AppTextStyle.text16w600(
                          color: Colors.lightGreenAccent.withOpacity(0.8)),
                    ),
                  ),
                  AppSpaces.h16,
                  TextButton(
                    onPressed: () => Get.backLegacy(result: false),
                    child: Text(
                      "tran_dialog_edit_cancel".tr,
                      style: AppTextStyle.text16w600(),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingAll(16),
        ),
      ));

  // --------------------------------------------------------------------------------------------

  Widget _sizeField({required Widget child}) => SizedBox(width: 250, child: child);
}
