import 'package:flutter/services.dart';
import 'package:pecunia/widgets/fields/base_field.dart';

class NumberField extends BaseField {
  NumberField({
    super.key,
    super.controller,
    super.hintText,
    super.labelText,
    super.validator,
    super.showLabel,
    super.errorText,
    bool super.enabled = true,
    super.initialValue,
    ValueChanged? super.onChanged,
    super.onEditingComplete,
  }) : super(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[,.]?\d{0,2}')),
          ],
        );
}
