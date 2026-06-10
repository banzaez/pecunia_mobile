import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';

import 'package:pecunia/providers/settings_notifier.dart';

class TotalHeader extends ConsumerWidget {
  const TotalHeader({super.key, required this.total});

  final AnalyticsTotal total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final periodStr = DateTime.now().formatMMMM;
    final isRoundUp = ref.watch(settingsNotifierProvider).isRoundUp;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _item(
          value: total.total.formatSumCustom(roundUp: isRoundUp),
          valueStyle: AppTextStyle.text12w600(),
          label: l10n.totalSum,
          labelStyle: AppTextStyle.text18w700(),
        ),
        _item(
          value: total.income.formatSumCustom(roundUp: isRoundUp),
          label: l10n.incomesSum,
          hintText: l10n.totalHint(periodStr),
        ),
        _item(
          value: total.expense.abs().formatSumCustom(roundUp: isRoundUp),
          label: l10n.expensesSum,
          hintText: l10n.totalHint(periodStr),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------------------------

  Widget _item({
    required String value,
    required String label,
    TextStyle? labelStyle,
    TextStyle? valueStyle,
    String? hintText,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: labelStyle ?? AppTextStyle.text18w400()),
          Text(label, style: valueStyle ?? AppTextStyle.text12w400()),
          if (hintText != null) Text(hintText, style: AppTextStyle.text10w400()),
        ],
      );
}
