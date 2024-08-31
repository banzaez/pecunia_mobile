import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class BaseField extends TextFormField {
  BaseField({
    super.key,
    super.onChanged,
    super.onEditingComplete,
    super.autofillHints,
    super.enabled,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    String? prefixText,
    super.controller,
    super.initialValue,
    super.validator,
    super.keyboardType,
    super.inputFormatters,
    super.minLines,
    super.maxLength,
    super.maxLines,
    super.obscureText,
    Widget? prefixIcon,
    Widget? prefix,
    Widget? suffixIcon,
    bool showLabel = true,
    super.autofocus,
    super.focusNode,
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
            prefix: prefix,
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            suffixIcon: suffixIcon,
            labelText: showLabel ? labelText : null,
            hintText: hintText,
            hintMaxLines: 10,
            floatingLabelBehavior: showLabel ? null : FloatingLabelBehavior.never,
            errorText: errorText,
            errorStyle: AppTextStyle.text12w400(color: AppColors.error),
            errorMaxLines: 2,
            helperText: helperText,
          ),
          style: AppTextStyle.text14w400(),
        );
}
