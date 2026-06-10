import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/dialogs/dialog_choose_wallet.dart';

class CurrentWallet extends ConsumerWidget {
  const CurrentWallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final currentWallet = homeState.currentWallet;
    final l10n = AppLocalizations.of(context);

    return DialogChooseWallet(
      onChanged: (value) {
        if (value != null) {
          ref.read(homeNotifierProvider.notifier).selectWallet(value);
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpaces.h24,
              Text(currentWallet?.name ?? ''),
              const Icon(Icons.arrow_drop_down, size: 24),
            ],
          ),
          Text(l10n.currentWalletTitle, style: AppTextStyle.text12w400()),
        ],
      ),
    );
  }
}
