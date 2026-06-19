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
import 'package:pecunia/models/transaction_type.dart';
import 'package:pecunia/util/sheet_save.dart';
import 'package:pecunia/widgets/fields/number_field.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction_controller.dart';

class SettingTransactionSheet extends ConsumerStatefulWidget {
  const SettingTransactionSheet({
    super.key,
    required this.type,
    this.transaction,
  });

  final TransactionType type;
  final Transaction? transaction;

  @override
  ConsumerState<SettingTransactionSheet> createState() =>
      _SettingTransactionSheetState();
}

class _SettingTransactionSheetState extends ConsumerState<SettingTransactionSheet> {
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
    final isEditing = _ctrl.transaction.id != 0;
    final title = isEditing ? l10n.settingTranTitle : l10n.settingTranTitleNew;

    return ListenableBuilder(
      listenable: _ctrl,
      builder: (_, _) => BottomSheetScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            AppSpaces.v16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  NumberField(
                    autofocus: !isEditing,
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
            BottomSheetActionRow(
              action: ElevatedButton(
                onPressed: _save,
                child: Text(l10n.settingTranSave),
              ),
            ),
            AppSpaces.v16,
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final transaction = _ctrl.transaction;

    await saveSheetAndPop(
      context: context,
      validate: () => _ctrl.isOk(l10n.tranItemErrorAmount, l10n.tranItemErrorCategory),
      applyChanges: _ctrl.updateValues,
      persist: () async {
        final notifier = ref.read(transactionNotifierProvider.notifier);
        if (transaction.id == 0) {
          await notifier.addSQL(transaction);
        } else {
          await notifier.updateSQL(transaction);
        }
      },
      hasError: () => ref.read(transactionNotifierProvider).error != null,
      popResult: true,
    );
  }
}
