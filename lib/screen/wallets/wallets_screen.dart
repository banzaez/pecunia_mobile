import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/flex_builder.dart';
import 'package:pecunia/widgets/provider_error_listener.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/widgets/wallet_item.dart';

class WalletsScreen extends ConsumerStatefulWidget {
  const WalletsScreen({super.key});

  @override
  ConsumerState<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends ConsumerState<WalletsScreen> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    listenProviderError(
      ref,
      context,
      provider: walletNotifierProvider,
      selectError: (state) => (state as WalletState?)?.error,
      clearError: () => ref.read(walletNotifierProvider.notifier).clearError(),
      formatError: formatWalletError,
    );
    return Scaffold(
      appBar: CustomAppBar(title: l10n.walletsTitle),
      body: _body(context, l10n),
    );
  }

  // --------------------------------------------------------------------------------------------

  Widget _body(BuildContext context, AppLocalizations l10n) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SettingWallet(),
                TextButton.icon(
                  onPressed: () => setState(() => _isEditing = true),
                  icon: const Icon(Icons.edit, color: AppColors.edit),
                  label: Text(
                    l10n.profileEdit,
                    style: AppTextStyle.text14w600(color: AppColors.edit),
                  ),
                ),
              ],
            ),
            AppSpaces.v16,
            _listWallets(),
          ],
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _listWallets() {
    final wallets = ref.watch(walletNotifierProvider).wallets;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: FlexBuilder(
          itemCount: wallets.length,
          itemBuilder: (_, index) => WalletItem(
            wallet: wallets[index],
            isEditing: _isEditing,
          ),
        ),
      ),
    );
  }
}
