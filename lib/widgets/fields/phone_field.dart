import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get/get.dart';
import 'package:pecunia/widgets/fields/base_field.dart';

class PhoneField extends BaseField {
  PhoneField({
    super.key,
    super.controller,
    super.initialValue,
    super.validator,
    String? hintText,
    super.showLabel,
    super.enabled,
    super.errorText,
  }) : super(
          autofillHints: [
            AutofillHints.telephoneNumberNational,
          ],
          prefixText: "+998 ",
          hintText: hintText ?? 'Номер телефона'.tr,
         // prefixIcon: AppImages.phoneFlag.marginAll(10),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            PhoneInputFormatter(
              defaultCountryCode: "UZ",
            )
          ],
        );
}
