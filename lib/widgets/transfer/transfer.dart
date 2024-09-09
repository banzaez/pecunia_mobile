import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/number_field.dart';
import 'package:pecunia/widgets/fields/wallet_field.dart';
import 'package:pecunia/widgets/text_error.dart';
import 'package:pecunia/widgets/transfer/transfer_controller.dart';

class Transfer extends StatelessWidget {
  const Transfer({super.key});

  @override
  Widget build(BuildContext context) => IconButton.filled(
        onPressed: _bottomSheet,
        icon: const Icon(Icons.compare_arrows),
      );

  // --------------------------------------------------------------------------------------------

  Future<void> _bottomSheet() async => await appBottomSheet(
        GetX<TransferController>(
          init: TransferController()..onInit(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "transfer_title".tr,
                  style: AppTextStyle.text16w400(),
                  textAlign: TextAlign.center,
                ),
                AppSpaces.v16,
                Text("from".tr),
                WalletField(
                  onChanged: (value) => controller.from = value,
                  initValue: controller.from,
                ),
                Text("to".tr),
                WalletField(
                  onChanged: (value) => controller.to = value,
                  initValue: controller.to,
                ),
                TextError(text: controller.errorWallet.value),
                AppSpaces.v16,
                Row(
                  children: [
                    Expanded(
                      child: NumberField(
                        controller: controller.amount,
                        labelText: "amount".tr,
                      ),
                    ),
                    AppSpaces.h16,
                    _exchangeRate(controller),
                  ],
                ),
                AppSpaces.v16,
                Row(
                  children: [
                    Expanded(
                      child: NumberField(
                        controller: controller.total,
                        labelText: "transfer_total".tr,
                      ),
                    ),
                    AppSpaces.h16,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.enableDone.isTrue ? () => onDone(controller) : null,
                        child: Text("transfer_done".tr),
                      ),
                    )
                  ],
                ),
                AppSpaces.v32,
              ],
            ),
          ),
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _exchangeRate(TransferController controller) => Expanded(
        child: Row(
          children: [
            GestureDetector(
              onTap: controller.divisionSign.toggle,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundContent,
                  border: AppBorderStyle.borderSideBox,
                  borderRadius: AppBorderStyle.borderRadius,
                ),
                width: 48,
                height: 48,
                child: Center(
                  child: Text(
                    controller.divisionSign.isTrue ? "/" : "*",
                    style: AppTextStyle.text18w400(),
                  ),
                ),
              ),
            ),
            AppSpaces.h8,
            Flexible(
              child: NumberField(
                controller: controller.exchangeRate,
                decimal: 5,
                enabled: controller.needExchangeRate.isTrue,
                labelText: "transfer_exchange_rate".tr,
              ),
            ),
          ],
        ),
      );

  // --------------------------------------------------------------------------------------------

  void onDone(TransferController controller) {
    if (!controller.isOk()) return;
    controller.transfer();
    Get.backLegacy(result: true);
  }
}
