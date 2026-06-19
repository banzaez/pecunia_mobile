import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/widgets/app_bottom_sheet/app_bottom_sheet_layout.dart';
import 'package:pecunia/widgets/app_bottom_sheet/bottom_sheet_handle.dart';

Future<T?> appBottomSheet<T>(BuildContext context, Widget child) async =>
    showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.background(context),
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      useSafeArea: false,
      enableDrag: true,
      builder: (sheetContext) {
        final mediaQuery = MediaQuery.of(sheetContext);
        final viewInsets = mediaQuery.viewInsets;
        final maxHeight = mediaQuery.size.height * 0.85 - viewInsets.bottom;

        return AnimatedPadding(
          padding: AppBottomSheetLayout.keyboardPadding(sheetContext),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight.clamp(160, double.infinity),
            ),
            child: Padding(
              padding: AppBottomSheetLayout.safePadding(sheetContext),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BottomSheetHandle(),
                  const SizedBox(height: 8),
                  Flexible(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
