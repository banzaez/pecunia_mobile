import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/widgets/fields/dropdown_field.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({
    super.key,
    required this.onChanged,
    required this.type,
    required this.value,
    required this.hint,
    this.items,
    this.error,
  });

  final ValueChanged<FinanceCategory> onChanged;
  final TransactionType type;
  final List<FinanceCategory>? items;
  final FinanceCategory? value;
  final String hint;
  final String? error;

  List<FinanceCategory> get _items => items ?? (type == TransactionType.income
      ? FinanceCategories.incomeCategories
      : FinanceCategories.expenseCategories);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DropdownField(
      onChanged: onChanged,
      items: _itemsWidget(l10n),
      hint: hint,
      value: value,
      errorText: error,
    );
  }

  // --------------------------------------------------------------------------------------------

  List<DropdownMenuItem<FinanceCategory>> _itemsWidget(AppLocalizations l10n) =>
      List.generate(_items.length, (index) {
        final item = _items[index];
        return DropdownMenuItem(
          value: item,
          child: Text(item.localizedName(l10n)),
        );
      });
}

enum TransactionType {
  income,
  expense;

  int get i => this == income ? 1 : -1;
}
