import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/google_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/backup/backup_controller.dart';
import 'package:pecunia/util/google_drive_errors.dart';

class BackupSnackListener extends ConsumerWidget {
  const BackupSnackListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    ref.listen<BackupState>(backupNotifierProvider, (prev, next) {
      final msg = next.snackMessage;
      if (msg == null || msg == prev?.snackMessage) return;

      final text = switch (msg) {
        '__saved__' => l10n.backupSavedSuccess,
        '__restored__' => l10n.backupRestoredSuccess,
        '__deleted__' => l10n.backupDeletedSuccess,
        '__format_error__' => l10n.backupErrorMsg,
        '__cancelled__' => l10n.backupCancelled,
        _ => l10n.error,
      };

      if (msg == '__cancelled__') {
        ref.read(backupNotifierProvider.notifier).clearSnack();
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: next.isError ? Colors.red : Colors.green,
        ),
      );

      ref.read(backupNotifierProvider.notifier).clearSnack();

      if (msg == '__restored__' && context.mounted) {
        context.go(AppRoute.home.path);
      }
    });

    ref.listen<GoogleDriveState>(googleDriveNotifierProvider, (prev, next) {
      final error = next.error;
      if (error == null || error == prev?.error) return;

      final text = switch (error) {
        GoogleDriveErrors.read => l10n.driveErrorRead,
        GoogleDriveErrors.create => l10n.driveErrorCreate,
        GoogleDriveErrors.delete => l10n.driveErrorDelete,
        _ => error,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: Colors.red,
        ),
      );
      ref.read(googleDriveNotifierProvider.notifier).clearError();
    });

    return child;
  }
}
