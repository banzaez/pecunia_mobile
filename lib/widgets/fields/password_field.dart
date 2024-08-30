import 'package:flutter/material.dart';
import 'package:pecunia/widgets/fields/base_field.dart';

class PasswordField extends BaseField {
  PasswordField({
    super.key,
    String? hintText,
    super.controller,
    super.validator,
    super.autofillHints,
    super.errorText,
    bool showPassword = false,
    Function(bool)? onChangeVisible,
  }) : super(
          hintText: hintText ?? 'Password',
          obscureText: !showPassword,
          suffixIcon: IconButton(
            padding: const EdgeInsets.all(2),
            onPressed: () => onChangeVisible?.call(!showPassword),
            icon: Icon(showPassword ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
          ),
        );
}
