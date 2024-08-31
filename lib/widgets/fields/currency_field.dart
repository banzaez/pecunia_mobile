import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          favorite: ['eur'],
          onSelect: onChange,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: AppBorderStyle.borderRadius,
                border: AppBorderStyle.borderSideBox,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 48,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(currency?.name ?? ""),
              ),
            ),
            if (errorText != null)
              Text(errorText!, style: AppTextStyle.text12w400(color: Colors.red))
                  .paddingOnly(left: 16, top: 4),
          ],
        ),
      );
}
