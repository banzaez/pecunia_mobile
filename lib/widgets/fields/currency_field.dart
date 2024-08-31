import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_border_style.dart';

class CurrencyField extends StatelessWidget {
  const CurrencyField({super.key, required this.onChange, required this.currency});

  final ValueChanged<Currency> onChange;
  final Currency? currency;

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
        child: Container(
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
      );
}
