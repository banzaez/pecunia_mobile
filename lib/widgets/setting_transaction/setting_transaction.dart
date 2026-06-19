import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/models/transaction_type.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction_sheet.dart';
import 'package:pecunia/widgets/transfer/transfer.dart';

class SettingTransaction extends StatelessWidget {
  const SettingTransaction({super.key, this.transaction, this.onChange});

  final ValueChanged? onChange;
  final Transaction? transaction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => setting(context, TransactionType.expense),
              child: Text(l10n.homeButtonExpense),
            ),
          ),
          AppSpaces.h8,
          const Transfer(),
          AppSpaces.h8,
          Expanded(
            child: ElevatedButton(
              onPressed: () => setting(context, TransactionType.income),
              child: Text(l10n.homeButtonIncome),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> setting(
    BuildContext context,
    TransactionType type, [
    Transaction? transaction,
  ]) async {
    await appBottomSheet<bool>(
      context,
      SettingTransactionSheet(type: type, transaction: transaction),
    );
  }
}
