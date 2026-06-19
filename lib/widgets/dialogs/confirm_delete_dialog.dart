import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/styles/app_text_style.dart';

Future<bool> showConfirmDeleteDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final result = await showConfirmDialog(
    context,
    title: l10n.dialogDeleteTitle,
    content: l10n.dialogDeleteContent,
    confirmLabel: l10n.dialogDeleteDelete,
    cancelLabel: l10n.dialogDeleteCancel,
  );
  return result ?? false;
}

Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String confirmLabel,
  required String cancelLabel,
  Color confirmColor = Colors.red,
  VoidCallback? onConfirm,
}) =>
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(cancelLabel, style: AppTextStyle.text16w600()),
          ),
          TextButton(
            onPressed: () {
              onConfirm?.call();
              Navigator.of(ctx).pop(true);
            },
            child: Text(
              confirmLabel,
              style: AppTextStyle.text16w600(color: confirmColor),
            ),
          ),
        ],
      ),
    );
