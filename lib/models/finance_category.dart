import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

class FinanceCategory {
  const FinanceCategory(this.id, this._name, this.subcategories);

  final int id;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String _name;
  final List<FinanceCategory> subcategories;

  String get name => _name.tr;
}
