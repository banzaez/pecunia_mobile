import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_colors.dart';

Future<T?> appBottomSheet<T>(BuildContext context, Widget child) async =>
    await showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.background(context),
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.black54,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
