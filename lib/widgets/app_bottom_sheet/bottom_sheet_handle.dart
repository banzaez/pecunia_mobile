import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_border_style.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 4),
        child: Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppBorderStyle.borderColor(Theme.of(context).brightness),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      );
}
