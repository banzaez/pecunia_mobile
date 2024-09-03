import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/storage_controller.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';

class CurrencyField extends StatelessWidget {
  const CurrencyField({super.key, required this.onChange, required this.currency, this.errorText});

  final ValueChanged<Currency> onChange;
  final Currency? currency;
  final String? errorText;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => showCurrencyPicker(
          context: context,
          showFlag: true,
          showSearchField: true,
          showCurrencyName: true,
          showCurrencyCode: true,
          favorite: [
            Get.find<StorageController>().currency?.code ?? "",
          ],
          onSelect: onChange,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: AppBorderStyle.borderSideBox,
                borderRadius: AppBorderStyle.borderRadius,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(currency?.name ?? ""),
                  Text(currency?.symbol ?? ""),
                  Text(currency?.code ?? ""),
                ],
              ),
            ),
            if (errorText != null)
              Text(errorText!, style: AppTextStyle.text12w400(color: Colors.red))
                  .paddingOnly(left: 16, top: 4),
          ],
        ),
      );
}
