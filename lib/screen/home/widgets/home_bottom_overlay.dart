import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/transaction_type.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/styles/app_panel_style.dart';
import 'package:pecunia/screen/home/home_bottom_layout.dart';
import 'package:pecunia/screen/home/widgets/wallet_dots.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction.dart';
import 'package:pecunia/widgets/transfer/transfer_sheet.dart';

class HomeBottomOverlay extends ConsumerWidget {
  const HomeBottomOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panelColor = appPanelColor(context);

    final currentWalletId = ref.watch(
      homeNotifierProvider.select((s) => s.currentWallet?.id),
    );
    final wallets = ref.watch(walletNotifierProvider.select((s) => s.wallets));
    final currentIndex = wallets.indexWhere((e) => e.id == currentWalletId);

    final l10n = AppLocalizations.of(context);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.05);

    final floatingActionBar = Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: panelColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(
                  context,
                  icon: Icons.remove_circle_outline_rounded,
                  label: l10n.homeButtonExpense,
                  color: const Color(0xFFC62828),
                  isDark: isDark,
                  onTap: () => SettingTransaction.setting(
                    context,
                    TransactionType.expense,
                  ),
                ),
                _centralButton(
                  context,
                  isDark: isDark,
                  onTap: () => appBottomSheet(context, const TransferSheet()),
                ),
                _actionButton(
                  context,
                  icon: Icons.add_circle_outline_rounded,
                  label: l10n.homeButtonIncome,
                  color: const Color(0xFF2E7D32),
                  isDark: isDark,
                  onTap: () => SettingTransaction.setting(
                    context,
                    TransactionType.income,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: HomeBottomLayout.bottomInset(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WalletDots(
            walletCount: wallets.length,
            currentIndex: currentIndex,
            onSwipe: (offset) =>
                ref.read(homeNotifierProvider.notifier).swipeWallet(offset),
          ),
          floatingActionBar,
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: color.withValues(alpha: 0.1),
          highlightColor: color.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.text12w600(
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _centralButton(
    BuildContext context, {
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final gradientColors = isDark
        ? [const Color(0xFF3F51B5), const Color(0xFF5C6BC0)]
        : [const Color(0xFF3F51B5), const Color(0xFF303F9F)];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3F51B5).withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.compare_arrows_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }
}
