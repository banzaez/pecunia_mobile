import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_text_style.dart';

class TextError extends StatelessWidget {
  const TextError({super.key, required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) => text == null || text!.isEmpty
      ? const SizedBox.shrink()
      : Text(text!, style: AppTextStyle.text14w400(color: Colors.red), textAlign: TextAlign.center);
}
