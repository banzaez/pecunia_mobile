import 'package:json_annotation/json_annotation.dart';

part 'finance_category.g.dart';

@JsonSerializable()
class FinanceCategory {
  final int id;
  final String name;
  final List<FinanceCategory> subcategories;

  const FinanceCategory({required this.id, required this.name, required this.subcategories});

  factory FinanceCategory.fromJson(Map<String, dynamic> json) => _$FinanceCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceCategoryToJson(this);
}
