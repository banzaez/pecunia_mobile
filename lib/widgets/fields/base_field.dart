import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pecunia/styles/app_border_style.dart';

class BaseField extends StatelessWidget {
  const BaseField({
    super.key,
    this.onChanged,
    this.autofocus = false,
    this.autofillHints,
    this.focusNode,
    this.enabled = true,
    this.controller,
    this.initialValue,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.minLines,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.labelText,
    this.hintText,
    this.helperText,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.showLabel = true,
  });

  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;
  final bool enabled;
  final TextEditingController? controller;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        autofocus: autofocus,
        autofillHints: autofillHints,
        focusNode: focusNode,
        enabled: enabled,
        controller: controller,
        initialValue: initialValue,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        minLines: minLines,
        maxLength: maxLength,
        maxLines: maxLines,
        obscureText: obscureText,
        scrollPadding: const EdgeInsets.only(bottom: 88),
        decoration: AppBorderStyle.inputDecoration(
          context,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          suffixIcon: suffixIcon,
          labelText: showLabel ? (labelText ?? hintText) : null,
          hintText: hintText,
          errorText: errorText,
          helperText: helperText,
        ),
      );
  }
}
