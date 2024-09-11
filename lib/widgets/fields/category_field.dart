import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/widgets/fields/dropdown_field.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({
    super.key,
    required this.onChanged,
    required this.type,
    required this.value,
    required this.error,
  });

  final ValueChanged<FinanceCategory> onChanged;
  final TransactionType type;
  final FinanceCategory? value;
  final String? error;

  List<FinanceCategory> get items => type == TransactionType.income
      ? FinanceCategories.incomeCategories
      : FinanceCategories.expenseCategories;

  @override
  Widget build(BuildContext context) => DropdownField(
        onChanged: onChanged,
        items: _itemsWidget(),
        hint: "label_category".tr,
        value: value,
        error: error,
      );

  // --------------------------------------------------------------------------------------------

  List<DropdownMenuItem<FinanceCategory>> _itemsWidget() {
    final list = List.generate(items.length, (index) {
      final item = items[index];
      return DropdownMenuItem(
        value: item,
        child: Text(item.name),
      );
    });

    list.insert(
      0,
      DropdownMenuItem(
        value: null,
        child: Text("tran_item_error_category".tr),
      ),
    );

    return list;
  }
}

enum TransactionType {
  income,
  expense;

  int get i => this == income ? 1 : -1;
}
