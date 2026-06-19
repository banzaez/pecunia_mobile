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

  static const _panelRadius = 28.0;
  static const _iconSize = 44.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panelColor = appPanelColor(context);

    final currentWalletId = ref.watch(
      homeNotifierProvider.select((s) => s.currentWallet?.id),
    );
    final wallets = ref.watch(walletNotifierProvider.select((s) => s.wallets));
    final currentIndex = wallets.indexWhere((e) => e.id == currentWalletId);
    final hasMultipleWallets = wallets.length > 1;

    final l10n = AppLocalizations.of(context);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.1)
        : Colors.black.withValues(alpha: 0.06);

    void stepWallet(int direction) =>
        ref.read(homeNotifierProvider.notifier).stepWallet(direction);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        HomeBottomLayout.bottomInset(context),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_panelRadius),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.28 : 0.08),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_panelRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: ColoredBox(
              color: panelColor.withValues(alpha: isDark ? 0.58 : 0.68),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasMultipleWallets) ...[
                    WalletDots(
                      walletCount: wallets.length,
                      currentIndex: currentIndex,
                      onStep: stepWallet,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        height: 1,
                        thickness: 0.5,
                        color: borderColor,
                      ),
                    ),
                  ],
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      10,
                      hasMultipleWallets ? 8 : 14,
                      10,
                      14,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _actionButton(
                            context,
                            icon: Icons.remove_rounded,
                            label: l10n.homeButtonExpense,
                            color: const Color(0xFFC62828),
                            isDark: isDark,
                            onTap: () => SettingTransaction.setting(
                              context,
                              TransactionType.expense,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _transferButton(
                            context,
                            isDark: isDark,
                            onTap: () =>
                                appBottomSheet(context, const TransferSheet()),
                          ),
                        ),
                        Expanded(
                          child: _actionButton(
                            context,
                            icon: Icons.add_rounded,
                            label: l10n.homeButtonIncome,
                            color: const Color(0xFF2E7D32),
                            isDark: isDark,
                            onTap: () => SettingTransaction.setting(
                              context,
                              TransactionType.income,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: color.withValues(alpha: 0.12),
        highlightColor: color.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: _iconSize,
                height: _iconSize,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.18 : 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 6),
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
    );
  }

  Widget _transferButton(
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
        borderRadius: BorderRadius.circular(18),
        splashColor: const Color(0xFF3F51B5).withValues(alpha: 0.12),
        highlightColor: const Color(0xFF3F51B5).withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: _iconSize,
                height: _iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3F51B5).withValues(alpha: 0.28),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.compare_arrows_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 6),
              // Заглушка под подпись — выравнивает ряд с боковыми кнопками.
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
