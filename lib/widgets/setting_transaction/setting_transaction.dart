import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 32),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => setting(context, TransactionType.expense),
              child: Text(AppLocalizations.of(context).homeButtonExpense),
            ),
          ),
          AppSpaces.h8,
          const Transfer(),
          AppSpaces.h8,
          Expanded(
            child: ElevatedButton(
              onPressed: () => setting(context, TransactionType.income),
              child: Text(AppLocalizations.of(context).homeButtonIncome),
            ),
          ),
        ],
      ),
    ),
  );

  static Future<void> setting(
    BuildContext context,
    TransactionType type, [
    Transaction? transaction,
  ]) async {
    await appBottomSheet<bool>(
      context,
      _SettingTransactionSheet(type: type, transaction: transaction),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal sheet widget
// ---------------------------------------------------------------------------

class _SettingTransactionSheet extends ConsumerStatefulWidget {
  const _SettingTransactionSheet({required this.type, this.transaction});

  final TransactionType type;
  final Transaction? transaction;

  @override
  ConsumerState<_SettingTransactionSheet> createState() =>
      _SettingTransactionSheetState();
}

class _SettingTransactionSheetState
    extends ConsumerState<_SettingTransactionSheet> {
  late SettingTransactionController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = SettingTransactionController(
      type: widget.type,
      transaction: widget.transaction,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: _ctrl,
      builder: (_, _) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.settingTranTitle),
            AppSpaces.v16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  NumberField(
                    autofocus: true,
                    controller: _ctrl.amount,
                    labelText: l10n.settingTranAmount,
                    errorText: _ctrl.errorAmount,
                  ),
                  AppSpaces.v16,
                  CategoryField(
                    onChanged: (value) => _ctrl.category = value,
                    type: _ctrl.type,
                    value: _ctrl.category,
                    hint: l10n.labelCategory,
                    error: _ctrl.errorCategory,
                  ),
                  if (_ctrl.category?.subcategories.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CategoryField(
                        onChanged: (value) => _ctrl.subcategory = value,
                        type: _ctrl.type,
                        value: _ctrl.subcategory,
                        items: _ctrl.category!.subcategories,
                        hint: l10n.labelSubcategory,
                      ),
                    ),
                  AppSpaces.v16,
                  BaseField(
                    controller: _ctrl.description,
                    maxLines: 3,
                    labelText: l10n.settingTranDescription,
                  ),
                  AppSpaces.v16,
                  AppSwitch(
                    onChange: (value) => _ctrl.type = value,
                    values: [
                      AppSwitchValue(
                        label: l10n.settingTranExpenses,
                        value: TransactionType.expense,
                      ),
                      AppSwitchValue(
                        label: l10n.settingTranIncome,
                        value: TransactionType.income,
                      ),
                    ],
                    value: _ctrl.type,
                  ),
                ],
              ),
            ),
            AppSpaces.v16,
            PickDate(
              onChanged: (value, type) => _ctrl.setDatetime(value!),
              initDate: _ctrl.datetime,
            ),
            AppSpaces.v32,
            ElevatedButton(onPressed: _save, child: Text(l10n.settingTranSave)),
            AppSpaces.v32,
          ],
        ),
      ),
    );
  }

  void _save() async {
    final l10n = AppLocalizations.of(context);
    if (!_ctrl.isOk(l10n.tranItemErrorAmount, l10n.tranItemErrorCategory)) {
      return;
    }
    _ctrl.updateValues();

    final navigator = Navigator.of(context);
    final notifier = ref.read(transactionNotifierProvider.notifier);
    final transaction = _ctrl.transaction;
    if (transaction.id == 0) {
      await notifier.addSQL(transaction);
    } else {
      await notifier.updateSQL(transaction);
    }

    if (ref.read(transactionNotifierProvider).error != null) return;

    navigator.pop(true);
  }
}
