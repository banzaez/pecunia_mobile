import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.isRoundUp,
    required this.onDelete,
  });

  final Transaction transaction;
  final bool isRoundUp;
  final Future<bool> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => SettingTransaction.setting(context, transaction.type, transaction),
      child: Dismissible(
        key: Key(transaction.id.toString()),
        confirmDismiss: (_) => _confirmDismiss(context),
        onDismissed: (_) {},
        background: Container(color: Colors.red),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white10,
                child: transaction.amount > 0
                    ? const Icon(Icons.attach_money, color: Colors.green)
                    : const Icon(Icons.money_off, color: Colors.red),
              ),
              AppSpaces.h24,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _label(context),
                    Text(
                      transaction.amount.formatSumCustom(roundUp: isRoundUp),
                      style: AppTextStyle.text16w400(),
                    ),
                    _description(),
                  ],
                ),
              ),
              _date(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categoryName = transaction.category?.localizedName(l10n) ?? "";
    final subcategoryName = transaction.subcategory?.localizedName(l10n);
    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text: transaction.amount > 0 ? l10n.tranItemIncome : l10n.tranItemExpense,
          style: AppTextStyle.text12w400(),
        ),
        TextSpan(
          text:
              " $categoryName${subcategoryName != null ? " ($subcategoryName)" : ""}",
          style: AppTextStyle.text14w600(),
        ),
      ],
    ));
  }

  Widget _description() {
    if (transaction.description.isEmpty) return const SizedBox.shrink();
    var chars = transaction.description.substring(0, min(transaction.description.length, 25));
    chars = chars + (chars.length < transaction.description.length ? "..." : "");
    return Text(chars, style: AppTextStyle.text12w400());
  }

  Widget _date(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (transaction.createdAt.isToday) {
      return Text("${l10n.tranItemToday} ${transaction.createdAt.formatHourMin}");
    } else if (transaction.createdAt.isYesterday) {
      return Text("${l10n.tranItemYesterday} ${transaction.createdAt.formatHourMin}");
    } else {
      return Text(transaction.createdAt.formatDDMMSYYYY);
    }
  }

  Future<bool> _confirmDismiss(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.dialogDeleteTitle),
        content: Text(l10n.dialogDeleteContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.dialogDeleteCancel, style: AppTextStyle.text16w600()),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              l10n.dialogDeleteDelete,
              style: AppTextStyle.text16w600(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return false;
    return onDelete();
  }
}
