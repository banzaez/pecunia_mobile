import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_colors.dart';

Future<T?> appBottomSheet<T>(Widget child) async => await Get.bottomSheet(
      child.paddingAll(16),
      backgroundColor: AppColors.background,
      barrierColor: Get.isDarkMode ? Colors.white24 : Colors.black54,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
