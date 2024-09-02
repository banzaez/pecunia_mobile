
import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_colors.dart';

abstract class AppBorderStyle{

  static const borderRadius = BorderRadius.all(Radius.circular(8));

  static const borderSide = BorderSide(color: AppColors.borderColor, width: 2);
  static const borderSideEnabled = BorderSide(color: AppColors.borderColor, width: 2);
  static const borderSideError = BorderSide(color: AppColors.error, width: 2);
  static final borderSideBox = Border.all(color: AppColors.borderColor, width: 2);

  static final borderItemAnalytic = Border.all(color: AppColors.analyticsBorder, width: 1);

}