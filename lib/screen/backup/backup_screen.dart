import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/generated/assets.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/google_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/backup/backup_controller.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/button_social.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';

class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    _listenSnack(context, ref, l10n);

    return Scaffold(
      appBar: CustomAppBar(title: l10n.backupTitle),
      body: _body(context, ref, l10n),
    );
  }

  // ----------SNACKBAR--------------------------------------------------------------------------

  void _listenSnack(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    ref.listen<BackupState>(backupNotifierProvider, (prev, next) {
      final msg = next.snackMessage;
      if (msg == null || msg == prev?.snackMessage) return;

      final text = switch (msg) {
        '__saved__' => l10n.backupSavedSuccess,
        '__restored__' => l10n.backupRestoredSuccess,
        '__deleted__' => l10n.backupDeletedSuccess,
        '__format_error__' => l10n.backupErrorMsg,
        _ => l10n.error,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: next.isError ? Colors.red : Colors.green,
        ),
      );

      ref.read(backupNotifierProvider.notifier).clearSnack();

      // После восстановления возвращаемся на home
      if (msg == '__restored__' && context.mounted) {
        context.go(AppRoute.home.path);
      }
    });
  }

  // --------------------------------------------------------------------------------------------

  Widget _body(BuildContext context, WidgetRef ref, AppLocalizations l10n) =>
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _localBackup(ref, l10n),
            AppSpaces.v48,
            _googleBackup(context, ref, l10n),
          ],
        ),
      );

  // ----------LOCAL-BACKUP----------------------------------------------------------------------

  Widget _text(String value, String hint) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(value, style: AppTextStyle.text18w400()),
      Text(hint, style: AppTextStyle.text14w400()),
    ],
  );

  Widget _localBackup(WidgetRef ref, AppLocalizations l10n) {
    final state = ref.watch(backupNotifierProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSpaces.v24,
        Column(
          children: [
            _text(state.filename, l10n.backupFilename),
            AppSpaces.v32,
            _text("${state.sizeKb}KB", l10n.backupSize),
          ],
        ),
        AppSpaces.v24,
        SizedBox(
          width: 256,
          child: ElevatedButton(
            onPressed: () =>
                ref.read(backupNotifierProvider.notifier).archiving(),
            child: Text(l10n.backupArchiving),
          ),
        ),
        AppSpaces.v12,
        SizedBox(
          width: 256,
          child: ElevatedButton(
            onPressed: () =>
                ref.read(backupNotifierProvider.notifier).recovery(),
            child: Text(l10n.backupRecovery),
          ),
        ),
      ],
    );
  }

  // ----------Google-Drive----------------------------------------------------------------------

  Widget _googleBackup(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
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
          Expanded(child: _listFiles(context, ref, l10n, google)),
        ],
      ),
    );
  }

  Widget _listItem(
    BuildContext context,
    WidgetRef ref,
    String name,
    String id,
    AppLocalizations l10n,
  ) => Container(
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
          onPressed: () {
            _confirmDialog(
              context: context,
              ref: ref,
              l10n: l10n,
              onConfirm: () => ref
                  .read(googleDriveNotifierProvider.notifier)
                  .deleteFile(id, onSuccess: () {}, onError: (e) {}),
              title: l10n.backupCloudDialogDelete,
              content: l10n.backupCloudDialogDeleteContent,
            );
          },
          icon: Icon(Icons.delete, color: Colors.red.shade400),
        ),
        IconButton(
          onPressed: () => _confirmDialog(
            context: context,
            ref: ref,
            l10n: l10n,
            onConfirm: () =>
                ref.read(backupNotifierProvider.notifier).recoveryCloud(id),
            title: l10n.backupCloudDialogRecovery,
            content: l10n.backupCloudDialogRecoveryContent,
          ),
          icon: Icon(Icons.download, color: Colors.blue.shade400),
        ),
      ],
    ),
  );

  Widget _listFiles(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    GoogleAuthState google,
  ) {
    if (!google.isSignedIn || !google.hasDrive || google.client == null) {
      return const SizedBox.shrink();
    }

    final driveState = ref.watch(googleDriveNotifierProvider);
    final driveFiles = driveState.files;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppSpaces.v24,
          driveState.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => ref
                      .read(backupNotifierProvider.notifier)
                      .createCloudBackup(),
                  child: Text(l10n.backupCreateCloudRecovery),
                ),
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
                    itemBuilder: (_, index) => _listItem(
                      context,
                      ref,
                      driveFiles[index].name!,
                      driveFiles[index].id!,
                      l10n,
                    ),
                    separatorBuilder: (_, _) => AppSpaces.v8,
                  ),
                ),
        ],
      ),
    );
  }

  // ----------DIALOG---------------------------------------------------------------------------

  Future<bool> _confirmDialog({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required VoidCallback onConfirm,
    required String title,
    required String content,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.no),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(ctx).pop(true);
            },
            child: Text(
              l10n.yes,
              style: AppTextStyle.text16w600(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
