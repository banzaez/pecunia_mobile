
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_colors.dart';

Future<T?> appBottomSheet<T>({required List<Widget> children}) async => await Get.bottomSheet(
  Column(
    mainAxisSize: MainAxisSize.min,
    children: children,
  ).paddingAll(16),
  backgroundColor: AppColors.background,
  barrierColor: Colors.white10,
  shape: const RoundedRectangleBorder(
    side: BorderSide(color: Colors.white10, width: 0.5),
    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
  ),
  isScrollControlled: true,
);