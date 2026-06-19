import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/home_panel_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/total_header.dart';

class HomeTopOverlay extends ConsumerWidget {
  const HomeTopOverlay({super.key, required this.fadeHeight});

  final double fadeHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final baseColor = homeOverlayBaseColor(context);
    final panelColor = homePanelColor(context);
    final showBalance = ref.watch(homeNotifierProvider).currentWallet?.showBalance ?? false;
    final isRoundUp = ref.watch(settingsNotifierProvider.select((s) => s.isRoundUp));
    final total = ref.watch(transactionNotifierProvider.select((s) => s.analyticsTotal));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColoredBox(
          color: panelColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showBalance)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: TotalHeader(total: total, isRoundUp: isRoundUp),
                ),
              TextButton.icon(
                onPressed: () => context.push(AppRoute.analytics.path),
                icon: const Icon(Icons.query_stats),
                label: Text(l10n.analyticsTitle, style: AppTextStyle.text16w400()),
              ),
            ],
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                panelColor,
                baseColor.withValues(alpha: 0.0),
              ],
            ),
          ),
          child: SizedBox(height: fadeHeight, width: double.infinity),
        ),
      ],
    );
  }
}
