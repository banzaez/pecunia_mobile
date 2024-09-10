import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pecunia/widgets/fields/base_field.dart';

class NumberField extends StatelessWidget {
  final NumberEditingController? controller;
  final ValueChanged<num>? onChanged;
  final bool autofocus;
  final num? initialValue;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool enabled;
  final bool showLabel;
  final int decimal;
  final FormFieldValidator<String>? validator;

  const NumberField({
    super.key,
    this.controller,
    this.onChanged,
    this.autofocus = false,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.errorText,
    this.enabled = true,
    this.showLabel = true,
    this.decimal = 2,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => BaseField(
        controller: controller,
        initialValue: initialValue?.toString(),
        autofocus: autofocus,
        enabled: enabled,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,' '$decimal})')),
        ],
        hintText: hintText,
        showLabel: showLabel,
        labelText: labelText,
        errorText: errorText,
        validator: validator,
        onChanged: (value) => onChanged?.call(num.tryParse(value) ?? 0),
      );
}

class NumberEditingController extends TextEditingController {
  num get number => num.tryParse(super.text.replaceAll(",", ".")) ?? 0;

  set number(num? value) => value == null ? super.clear() : super.text = value.toString();
}
