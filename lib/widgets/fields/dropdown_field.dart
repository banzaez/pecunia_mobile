import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';

class DropdownField<T> extends StatelessWidget {
  final T? value;

  final String hint;
  final String? label;
  final String? error;

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T>? onChanged;

  const DropdownField({
    super.key,
    this.onChanged,
    required this.items,
    required this.hint,
    this.label,
    this.value,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    var field = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: error == null ? AppColors.borderColor : AppColors.error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              onChanged: (value) {
                if (value == null) return;
                onChanged?.call(value);
              },
              borderRadius: BorderRadius.circular(8),
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
              ),
              underline: const SizedBox(),
              value: value,
              hint: Text(hint),
              items: items,
            ), //.marginSymmetric(horizontal: 8),
          ),
        ),
        if (error != null)
          Text(error!, style: AppTextStyle.text12w400(color: Colors.red))
              .paddingOnly(left: 12, top: 8),
      ],
    );

    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label!, style: AppTextStyle.text12w400()),
          AppSpaces.v8,
          field,
        ],
      );
    }

    return field;
  }
}
