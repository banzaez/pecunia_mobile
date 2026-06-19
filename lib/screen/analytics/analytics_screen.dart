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

    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(title: l10n.analyticsTitle),
      body: _body(context, ref),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    final bottomSafe = MediaQuery.viewPaddingOf(context).bottom;
    final hasCategories =
        ref.watch(analyticsNotifierProvider.select((s) => s.category.isNotEmpty));

    const topFadeHeight = 24.0;
    const graphHeight = 220.0;
    const topTextHeight = 40.0;
    const bottomContentHeight = 120.0;
    const listInsetTrim = 12.0;

    final topContentHeight = hasCategories
        ? topTextHeight + graphHeight + 20
        : topTextHeight + 12;
    final topOverlayHeight = topContentHeight + topFadeHeight * 0.5;
    final bottomOverlayHeight = bottomContentHeight + 24 + bottomSafe + 8;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnalyticsCategoryList(
              topPadding: topOverlayHeight - listInsetTrim,
              bottomPadding: bottomOverlayHeight - listInsetTrim,
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnalyticsBottomOverlay(bottomSafe: bottomSafe),
          ),
        ],
      ),
    );
  }
}
