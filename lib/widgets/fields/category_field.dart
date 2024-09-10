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
  });

  final ValueChanged<FinanceCategory> onChanged;
  final CategoryType type;
  final FinanceCategory? value;

  List<FinanceCategory> get items => type == CategoryType.income
      ? FinanceCategories.incomeCategories
      : FinanceCategories.expenseCategories;

  @override
  Widget build(BuildContext context) => DropdownField(
        items: _itemsWidget(),
        hint: "label_category".tr,
        value: value,
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

enum CategoryType { income, expense }
