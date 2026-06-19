import 'package:flutter/material.dart';

/// Отступы выдвигающихся bottom sheet.
abstract final class AppBottomSheetLayout {
  static const horizontalInset = 16.0;
  static const extraBottomInset = 12.0;
  static const headerHeight = 26.0;

  /// Горизонтальные отступы и зазор над системной навигацией (без клавиатуры).
  static EdgeInsets safePadding(BuildContext context) {
    final media = MediaQuery.of(context);
    return EdgeInsets.fromLTRB(
      horizontalInset,
      0,
      horizontalInset,
      horizontalInset + media.viewPadding.bottom + extraBottomInset,
    );
  }

  /// Подъём всей панели при открытой клавиатуре.
  static EdgeInsets keyboardPadding(BuildContext context) =>
      EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom);
}
