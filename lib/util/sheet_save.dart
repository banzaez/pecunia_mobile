import 'package:flutter/material.dart';

/// Validates form, persists data, and closes the bottom sheet on success.
Future<bool> saveSheetAndPop({
  required BuildContext context,
  required bool Function() validate,
  required VoidCallback applyChanges,
  required Future<void> Function() persist,
  required bool Function() hasError,
  Object? popResult,
}) async {
  if (!validate()) return false;

  applyChanges();
  await persist();

  if (hasError()) return false;
  if (!context.mounted) return false;

  Navigator.of(context).pop(popResult);
  return true;
}
