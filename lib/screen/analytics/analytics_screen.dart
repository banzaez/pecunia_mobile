import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_bottom_overlay.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_category_list.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_top_overlay.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    ref.listen<String?>(
      analyticsNotifierProvider.select((s) => s.error),
      (prev, next) {
        if (next == null || next == prev) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), backgroundColor: Colors.red),
        );
        ref.read(analyticsNotifierProvider.notifier).clearError();
      },
    );

    return Scaffold(
      appBar: CustomAppBar(title: l10n.analyticsTitle),
      body: const AnalyticsScreenBody(),
    );
  }
}

class AnalyticsScreenBody extends ConsumerWidget {
  const AnalyticsScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCategories =
        ref.watch(analyticsNotifierProvider.select((s) => s.category.isNotEmpty));

    const topFadeHeight = 24.0;
    const graphHeight = 220.0;
    const topTextHeight = 40.0;
    const listInsetTrim = 12.0;

    final topContentHeight = hasCategories
        ? topTextHeight + graphHeight + 20
        : topTextHeight + 12;
    final topOverlayHeight = topContentHeight + topFadeHeight * 0.5;

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: AnalyticsCategoryList(
                  topPadding: topOverlayHeight - listInsetTrim,
                  bottomPadding: 12,
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: AnalyticsTopOverlay(
                  fadeHeight: topFadeHeight,
                  graphHeight: graphHeight,
                ),
              ),
            ],
          ),
        ),
        const AnalyticsBottomOverlay(),
      ],
    );
  }
}
