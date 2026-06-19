import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/generated/assets.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/google_notifier.dart';
import 'package:pecunia/screen/backup/backup_controller.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/button_social.dart';
import 'package:pecunia/widgets/dialogs/confirm_delete_dialog.dart';

class BackupGoogleSection extends ConsumerWidget {
  const BackupGoogleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final google = ref.watch(googleNotifierProvider);

    return Expanded(
      child: Column(
        children: [
          google.isSignedIn
              ? ButtonSocial(
                  onPressed: () =>
                      ref.read(googleNotifierProvider.notifier).signOut(),
                  label: l10n.signOutWithGoogle,
                  icon: Assets.pngIconGoogle,
                )
              : ButtonSocial(
                  onPressed: () =>
                      ref.read(googleNotifierProvider.notifier).signIn(),
                  label: l10n.signInWithGoogle,
                  icon: Assets.pngIconGoogle,
                ),
          Expanded(child: _DriveFileList(google: google)),
        ],
      ),
    );
  }
}

class _DriveFileList extends ConsumerWidget {
  const _DriveFileList({required this.google});

  final GoogleAuthState google;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    if (!google.isSignedIn) {
      return const SizedBox.shrink();
    }

    if (!google.hasDrive || google.client == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          l10n.driveScopeError,
          style: AppTextStyle.text14w400(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    final driveState = ref.watch(googleDriveNotifierProvider);
    final driveFiles = driveState.files;
    final isBackupBusy = ref.watch(backupNotifierProvider.select((s) => s.isLoading));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppSpaces.v24,
          driveState.isLoading || isBackupBusy
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: isBackupBusy
                      ? null
                      : () => ref
                          .read(backupNotifierProvider.notifier)
                          .createCloudBackup(),
                  child: Text(l10n.backupCreateCloudRecovery),
                ),
          if (driveState.error != null) ...[
            AppSpaces.v16,
            Text(
              driveState.error!,
              style: AppTextStyle.text14w400(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
          AppSpaces.v32,
          driveFiles.isEmpty
              ? Text(
                  l10n.backupCloudEmpty,
                  style: AppTextStyle.text14w600(color: Colors.white30),
                )
              : Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: driveFiles.length,
                    itemBuilder: (_, index) => _DriveFileItem(
                      name: driveFiles[index].name!,
                      id: driveFiles[index].id!,
                    ),
                    separatorBuilder: (_, _) => AppSpaces.v8,
                  ),
                ),
        ],
      ),
    );
  }
}

class _DriveFileItem extends ConsumerWidget {
  const _DriveFileItem({required this.name, required this.id});

  final String name;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isBackupBusy = ref.watch(backupNotifierProvider.select((s) => s.isLoading));

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderStyle.borderRadius,
        color: Colors.white10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          AppSpaces.h16,
          Text(name, style: AppTextStyle.text12w600(color: Colors.white)),
          const Spacer(),
          IconButton(
            onPressed: isBackupBusy
                ? null
                : () => showConfirmDialog(
              context,
              title: l10n.backupCloudDialogDelete,
              content: l10n.backupCloudDialogDeleteContent,
              confirmLabel: l10n.yes,
              cancelLabel: l10n.no,
              onConfirm: () => ref.read(googleDriveNotifierProvider.notifier).deleteFile(
                    id,
                    onSuccess: () => ref
                        .read(backupNotifierProvider.notifier)
                        .showMessage('__deleted__'),
                    onError: (_) => ref
                        .read(backupNotifierProvider.notifier)
                        .showMessage('__error__', isError: true),
                  ),
            ),
            icon: Icon(Icons.delete, color: Colors.red.shade400),
          ),
          IconButton(
            onPressed: isBackupBusy
                ? null
                : () => showConfirmDialog(
              context,
              title: l10n.backupCloudDialogRecovery,
              content: l10n.backupCloudDialogRecoveryContent,
              confirmLabel: l10n.yes,
              cancelLabel: l10n.no,
              onConfirm: () =>
                  ref.read(backupNotifierProvider.notifier).recoveryCloud(id),
            ),
            icon: Icon(Icons.download, color: Colors.blue.shade400),
          ),
        ],
      ),
    );
  }
}
