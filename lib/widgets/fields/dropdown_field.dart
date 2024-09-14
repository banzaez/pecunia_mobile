import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_border_style.dart';

class DropdownField<T> extends StatelessWidget {
  final ValueChanged<T>? onChanged;
  final List<DropdownMenuItem<T>> items;
  final T? value;

  final String hint;
  final String? errorText;

  const DropdownField({
    super.key,
    this.onChanged,
    required this.items,
    required this.hint,
    this.value,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField(
        onChanged: (value) {
          if (value == null) return;
          onChanged?.call(value);
        },
        decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          border: const OutlineInputBorder(
            borderSide: AppBorderStyle.borderSide,
            borderRadius: AppBorderStyle.borderRadius,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: AppBorderStyle.borderSideEnabled,
            borderRadius: AppBorderStyle.borderRadius,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: AppBorderStyle.borderSideError,
            borderRadius: AppBorderStyle.borderRadius,
          ),
          errorText: errorText,
        ),
        hint: Text(hint),
        items: items,
        value: value,
      );
}
