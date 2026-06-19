import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/models/transaction_type.dart';
import 'package:pecunia/util/category_icon_helper.dart';
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
        final icon = CategoryIconHelper.getIcon(item.name);
        return DropdownMenuItem(
          value: item,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 12),
              Text(item.localizedName(l10n)),
            ],
          ),
        );
      });
}

