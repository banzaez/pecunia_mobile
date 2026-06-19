import 'package:flutter/material.dart';

/// Scrollable body for bottom sheets with keyboard-friendly defaults.
class BottomSheetScrollView extends StatelessWidget {
  const BottomSheetScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: child,
      );
}
