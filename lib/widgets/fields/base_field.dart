import 'package:flutter/material.dart';
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
              borderSide: BorderSide(color: AppColors.borderColor, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.error, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
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
