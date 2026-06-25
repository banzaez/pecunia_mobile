import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/screen/backup/widgets/backup_local_section.dart';
import 'package:pecunia/screen/backup/widgets/backup_snack_listener.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';

class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return BackupSnackListener(
      child: Scaffold(
        appBar: CustomAppBar(title: l10n.backupTitle),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BackupLocalSection(),
            ],
          ),
        ),
      ),
    );
  }
}
