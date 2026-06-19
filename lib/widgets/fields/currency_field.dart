import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';

class CurrencyField extends ConsumerWidget {
  const CurrencyField({super.key, required this.onChange, required this.currency, this.errorText});

  final ValueChanged<Currency> onChange;
  final Currency? currency;
  final String? errorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    return GestureDetector(
      onTap: () => showCurrencyPicker(
        context: context,
        showFlag: true,
        showSearchField: true,
        showCurrencyName: true,
        showCurrencyCode: true,
        favorite: [
          settings.currency?.code ?? "",
        ],
        onSelect: onChange,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: AppBorderStyle.fieldBox(context),
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(errorText!, style: AppTextStyle.text12w400(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
