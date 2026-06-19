import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/home_panel_style.dart';
import 'package:pecunia/screen/home/widgets/wallet_dots.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction.dart';

class HomeBottomOverlay extends ConsumerWidget {
  const HomeBottomOverlay({super.key, required this.bottomSafe});

  final double bottomSafe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = homeOverlayBaseColor(context);
    final panelColor = homePanelColor(context);

    final homeState = ref.watch(homeNotifierProvider);
    final wallets = ref.watch(walletNotifierProvider.select((s) => s.wallets));
    final currentIndex = wallets.indexWhere((e) => e.id == homeState.currentWallet?.id);

    final barButtonColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFD9D9D9);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                baseColor.withValues(alpha: 0.0),
                panelColor,
              ],
            ),
          ),
          child: WalletDots(
            walletCount: wallets.length,
            currentIndex: currentIndex,
            onSwipe: (offset) =>
                ref.read(homeNotifierProvider.notifier).swipeWallet(offset),
          ),
        ),
        ColoredBox(
          color: panelColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomSafe),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Theme(
                data: Theme.of(context).copyWith(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: barButtonColor,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: AppTextStyle.text16w400(),
                    ),
                  ),
                  iconButtonTheme: IconButtonThemeData(
                    style: IconButton.styleFrom(
                      backgroundColor: barButtonColor,
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                ),
                child: const SettingTransaction(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
