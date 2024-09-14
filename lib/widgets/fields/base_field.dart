import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_border_style.dart';

class BaseField extends TextFormField {
  BaseField({
    super.key,
    super.onChanged,
    super.autofocus,
    super.autofillHints,
    super.focusNode,
    super.enabled,
    super.controller,
    super.initialValue,
    super.validator,
    super.keyboardType,
    super.inputFormatters,
    super.minLines,
    super.maxLength,
    super.maxLines,
    super.obscureText,
    String? labelText,
    String? hintText,
    String? helperText,
    String? prefixText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
    bool showLabel = true,
  }) : super(
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
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            suffixIcon: suffixIcon,
            labelText: labelText,
            hintText: hintText,
            errorText: errorText,
            helperText: helperText,
          )
        );
}
