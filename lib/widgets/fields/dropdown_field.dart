import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_border_style.dart';

class DropdownField<T> extends StatelessWidget {
  const DropdownField({
    super.key,
    this.onChanged,
    required this.items,
    required this.hint,
    this.value,
    this.errorText,
  });

  final ValueChanged<T>? onChanged;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String hint;
  final String? errorText;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
        onChanged: (value) {
          if (value == null) return;
          onChanged?.call(value);
        },
        decoration: AppBorderStyle.inputDecoration(
          context,
          errorText: errorText,
        ),
        hint: Text(hint),
        items: items,
        initialValue: value,
      );
}
