import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/screen/backup/backup_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';

class BackupLocalSection extends ConsumerWidget {
  const BackupLocalSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(backupNotifierProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSpaces.v24,
        Column(
          children: [
            _InfoRow(value: state.filename, hint: l10n.backupFilename),
            AppSpaces.v32,
            _InfoRow(value: '${state.sizeKb}KB', hint: l10n.backupSize),
          ],
        ),
        AppSpaces.v24,
        SizedBox(
          width: 256,
          child: ElevatedButton(
            onPressed: () => ref.read(backupNotifierProvider.notifier).archiving(),
            child: Text(l10n.backupArchiving),
          ),
        ),
        AppSpaces.v12,
        SizedBox(
          width: 256,
          child: ElevatedButton(
            onPressed: () => ref.read(backupNotifierProvider.notifier).recovery(),
            child: Text(l10n.backupRecovery),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.value, required this.hint});

  final String value;
  final String hint;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTextStyle.text18w400()),
          Text(hint, style: AppTextStyle.text14w400()),
        ],
      );
}
