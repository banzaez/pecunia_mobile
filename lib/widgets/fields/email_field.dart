import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get/get.dart';
import 'package:pecunia/util/ext_string.dart';
import 'package:pecunia/widgets/fields/base_field.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    super.key,
    required this.onChange,
    required this.controller,
    this.hintText,
    this.validator,
    this.autofocus = false,
    this.autofillHints,
    this.canInputPhone = false,
  });

  final ValueChanged<String> onChange;
  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final bool canInputPhone;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  FocusNode focus = FocusNode();
  bool isPhoneType = false;

  @override
  void initState() {
    super.initState();

    var controller = widget.controller;
    controller.addListener(() => changeText(controller.text));
  }

  @override
  Widget build(BuildContext context) => BaseField(
        autofocus: widget.autofocus,
        autofillHints: widget.autofillHints,
        controller: widget.controller,
        focusNode: focus,
        validator: widget.validator,
        prefixText: isPhoneType ? "+998 " : null,
        hintText: widget.hintText ?? 'Email',
        keyboardType: isPhoneType ? TextInputType.phone : TextInputType.emailAddress,
        inputFormatters: [
          if (isPhoneType) PhoneInputFormatter(defaultCountryCode: "UZ"),
        ],
      );

  void changeText(String value) {
    checkType(value);

    widget.onChange(isPhoneType ? "998 $value" : value);
  }

  void checkType(String value) {
    if (widget.canInputPhone == false) return;

    bool newType = value.toWithoutSpace().isNumericOnly || value.isPhoneNumber;

    if (isPhoneType != newType) {
      setState(() {
        isPhoneType = newType;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        focus.unfocus();
        await Future.delayed(const Duration(milliseconds: 30));
        FocusScope.of(Get.context!).requestFocus(focus);
      });
    }
  }
}
