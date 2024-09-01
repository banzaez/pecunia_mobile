import 'package:countries_flag/countries_flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/translations/app_translations.dart';
import 'package:pecunia/util/app_spaces.dart';

class SwitchLanguage extends StatelessWidget {
  final AppTranslations _appTranslations = Get.find();

  SwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) => DropdownButton(
        onChanged: (value) => _appTranslations.setLocale(value!),
        value: Get.locale,
        items: _appTranslations.localeItems.map((e) => _item(item: e)).toList(),
        autofocus: false,
        borderRadius: BorderRadius.circular(8),
        padding: EdgeInsets.zero,
        underline: const SizedBox.shrink(),
        elevation: 1,
        icon: const Icon(Icons.arrow_drop_down, color: AppColors.disable, size: 26),
      ).marginOnly(left: 8);

  //---------------------------------------------------------------------------------------------

  DropdownMenuItem _item({required LocaleItem item}) => DropdownMenuItem(
        value: item.locale,
        child: Row(
          children: [
            ClipOval(
              child: Transform.scale(
                scale: 1.5,
                child: CountriesFlag(item.flag, height: 24, width: 24, fit: BoxFit.cover),
              ),
            ),
            AppSpaces.h16,
            Text(item.name, style: AppTextStyle.text14w600()),
          ],
        ),
      );
}
